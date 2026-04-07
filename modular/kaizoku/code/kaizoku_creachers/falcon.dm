//This animal alongside the Doggo has been organized this way because I seriously can't organize the code otherwise.
//Feel free to change it. In fact, I encourage you to do it. I just can't waste time on it right now.

/proc/OnFalconBuckled(mob/living/carbon/human/H, mob/living/M)
	H.update_falcon_perched_overlay()

/proc/OnFalconUnbuckled(mob/living/carbon/human/H, mob/living/M)
	H.update_falcon_perched_overlay()

/mob/living/carbon/human/proc/update_falcon_perched_overlay()
	if(falcon_perched_overlay)
		overlays -= falcon_perched_overlay
		falcon_perched_overlay = null

	if(buckled_mobs) //Only show the overlay if the falcon is bucklet to the player.
		for(var/mob/living/simple_animal/hostile/retaliate/custodianpet/falcon/F in buckled_mobs)
			if(QDELETED(F) || F.stat == DEAD)
				continue
			falcon_perched_overlay = image(F.icon, F.icon_perched, F.dir)
			falcon_perched_overlay.pixel_x = 7
			falcon_perched_overlay.pixel_y = 8
			overlays += falcon_perched_overlay
			break

/mob/living/simple_animal/hostile/retaliate/custodianpet
	ai_controller = /datum/ai_controller/falcon
	max_buckled_mobs = 0
	var/summoner = null
	var/list/focus_targets = list()
	var/patrolling = FALSE
	var/following = FALSE
	var/delivering_paper = FALSE
	var/obj/item/paper/held_paper = null
	var/delivery_target = null
	var/old_following_state = FALSE
	var/delivering_letter_anim = FALSE
	var/has_smoke = FALSE
	var/obj/item/clothing/face/cigarette/rollie/falcon_smoke = null

/mob/living/simple_animal/hostile/retaliate/custodianpet/falcon
	name = "saintalon"
	desc = "The saintalon, whom each dive is a judgemental rite as the winged covenant of the skies. It like to smoke rollies."
	icon = 'modular/kaizoku/icons/mobs/falcon.dmi'
	icon_state = "falcon"
	icon_living = "falcon"
	icon_dead = "falcon_dead"
	environment_smash = ENVIRONMENT_SMASH_NONE
	pass_flags = PASSTABLE|PASSGRILLE
	limb_destroyer = 1
	movement_type = FLYING
	density = TRUE
	melee_damage_lower = 15
	melee_damage_upper = 20
	health = 100
	maxHealth = 100
	emote_see = list("scans the horizon", "judges you with a gaze", "swoops low.")
	speak_chance = 2
	attack_sound = list() // Placeholder - will use attack_hit_sound instead
	var/list/attack_hit_sound = list(
		'sound/combat/hits/bladed/genslash (3).ogg',  // Placeholder - will replace with actual hit sounds
		'sound/combat/hits/bladed/genslash (2).ogg',
		'sound/combat/hits/bladed/genslash (1).ogg',
	)
	var/attack_sound_chance = 40 // 40% chance to play hit sound on attack
	butcher_results = list(/obj/item/reagent_containers/food/snacks/fat = 1,
						/obj/item/reagent_containers/food/snacks/meat/poultry = 1,
						/obj/item/natural/feather = 1)
	perfect_butcher_results = list(/obj/item/reagent_containers/food/snacks/fat = 1,
						/obj/item/reagent_containers/food/snacks/meat/poultry = 1,
						/obj/item/reagent_containers/food/snacks/meat/poultry/cutlet = 1,
						/obj/item/natural/feather = 1)
	food_type = list(/obj/item/natural/worms,
				/obj/item/reagent_containers/food/snacks/smallrat,
				/obj/item/reagent_containers/food/snacks/meat,
				/obj/item/reagent_containers/food/snacks/produce/grain/wheat,
				/obj/item/reagent_containers/food/snacks/produce/grain/oat)
	var/icon_perched = "falcon_perch"

/mob/living/simple_animal/hostile/retaliate/custodianpet/falcon/proc/is_enemy(mob/living/M)
	if(M == src)
		return FALSE
	if(M == summoner) //Will never attack the summoner or itself.
		return FALSE
	if(istype(M, /mob/living/simple_animal/hostile/retaliate/custodianpet)) //NEVER attack other custodian pets.
		return FALSE
	if(M.stat == DEAD) // Never attack dead mobs.
		return FALSE
	if(istype(M, /mob/living/simple_animal/hostile)) //Automatically attacks hostile simple animals.
		return TRUE
	if(islist(M.faction))
		if(FACTION_ORCS in M.faction)
			return TRUE
		if(FACTION_UNDEAD in M.faction)
			return TRUE
		if(FACTION_CABAL in M.faction)
			return TRUE
		if(FACTION_MATTHIOS in M.faction)
			return TRUE
	if(isnum(M:mob_biotypes) && (M:mob_biotypes & MOB_UNDEAD)) //Straight up attack by bodytype.
		return TRUE //Just to reinforce THAT you GOT to ATTACK THESE ONES
	return FALSE

/mob/living/simple_animal/hostile/retaliate/custodianpet/falcon/Initialize(mapload)
	. = ..()
	base_pixel_x = pixel_x
	base_pixel_y = pixel_y
	if(ai_controller)
		ai_controller.blackboard[BB_SUMMONER] = summoner
		ai_controller.blackboard[BB_FOCUS_TARGETS] = focus_targets
		ai_controller.blackboard[BB_PATROLLING] = patrolling
		ai_controller.blackboard[BB_FOLLOWING] = following
		ai_controller.blackboard[BB_FALCON_WANT_PERCH] = FALSE
		ai_controller.blackboard[BB_FALCON_PERCH_TYPES] = list(
			/obj/structure/table,
			/obj/structure/chair,
			/obj/structure/bed,
			/obj/machinery,
			/obj/structure/statue
		)
		ai_controller.blackboard[BB_TARGETTING_DATUM] = new /datum/targetting_datum/basic()

/mob/living/simple_animal/hostile/retaliate/custodianpet/falcon/update_icon_state()
	. = ..()
	if(stat == DEAD)
		return
	if(HAS_TRAIT(src, TRAIT_FALCON_PERCHED))
		if(src.has_smoke)
			icon_state = "falcon_perch_smoke"
		else
			icon_state = icon_perched
	else
		if(src.has_smoke)
			icon_state = "falcon_smoke"
		else
			icon_state = icon_living
	if(buckled && istype(buckled, /mob/living/carbon/human))
		invisibility = 101
	else
		invisibility = 0

/mob/living/simple_animal/hostile/retaliate/custodianpet/falcon/proc/can_be_perched(mob/living/carbon/human/user)
	return stat != DEAD && !buckled

/mob/living/simple_animal/hostile/retaliate/custodianpet/falcon/proc/on_perched(mob/living/carbon/human/holder)
	ADD_TRAIT(src, TRAIT_FALCON_FROZEN, "perching")
	toggle_perched(TRUE)
	visible_message("<span class='notice'>[src] perches obediently on [holder]'s arm.</span>")

/mob/living/simple_animal/hostile/retaliate/custodianpet/falcon/proc/on_unperched()
	REMOVE_TRAIT(src, TRAIT_FALCON_FROZEN, "perching")
	toggle_perched(FALSE)
	update_icon_state() // Always force visual reset
	visible_message("<span class='notice'>[src] leaps off!</span>")

/mob/living/simple_animal/hostile/retaliate/custodianpet/falcon/proc/resist_from_perch()
	if(buckled)
		var/mob/living/carbon/human/H = buckled
		H.unbuckle_mob(src)
		update_icon_state() // Make sure sprite switches to non-perched!
	else
		toggle_perched(perched = FALSE)
		update_icon_state()

/mob/living/simple_animal/hostile/retaliate/custodianpet/falcon/proc/perch_on_human(mob/living/carbon/human/target)
	if(LAZYLEN(target.buckled_mobs) >= target.max_buckled_mobs)
		return FALSE
	var/old_dense = src.density
	src.density = FALSE
	src.forceMove(get_turf(target))
	src.density = old_dense
	sleep(1) // Sometimes, it may be necessary a tick to properly register!!!!!!!!!!!aaaaaaAAAAAAAAAAAA

	if(!target.buckle_mob(src, TRUE))
		return FALSE
	on_perched(target)
	RegisterSignal(src, COMSIG_LIVING_SET_BUCKLED, PROC_REF(on_unbuckle))
	return TRUE

/mob/living/simple_animal/hostile/retaliate/custodianpet/falcon/proc/on_unbuckle(mob/living/source, atom/movable/new_buckled)
	SIGNAL_HANDLER
	if(new_buckled)
		return
	on_unperched()
	UnregisterSignal(src, COMSIG_LIVING_SET_BUCKLED)

/mob/living/simple_animal/hostile/retaliate/custodianpet/falcon/proc/toggle_perched(perched)
	if(!perched)
		REMOVE_TRAIT(src, TRAIT_FALCON_PERCHED, PERCH_SOURCE)
		pixel_x = base_pixel_x
		pixel_y = base_pixel_y
	else
		ADD_TRAIT(src, TRAIT_FALCON_PERCHED, PERCH_SOURCE)
		pixel_y = base_pixel_y + 9
	update_icon_state()

#undef PERCH_SOURCE

/mob/living/simple_animal/hostile/retaliate/custodianpet/falcon/proc/toggle_patrol(mob/user)
	patrolling = !patrolling
	following = FALSE
	if(ai_controller)
		ai_controller.blackboard[BB_PATROLLING] = patrolling
		ai_controller.blackboard[BB_FOLLOWING] = following
		ai_controller.blackboard[BB_FALCON_WANT_PERCH] = FALSE
		ai_controller.clear_blackboard_key(BB_FALCON_PERCH_TARGET)
	to_chat(user, "<span class='notice'>The falcon is now [patrolling ? "patrolling" : "staying close"].</span>")

/mob/living/simple_animal/hostile/retaliate/custodianpet/falcon/proc/set_following(mob/user)
	following = TRUE
	patrolling = FALSE
	summoner = user
	if(ai_controller)
		ai_controller.blackboard[BB_FOLLOWING] = following
		ai_controller.blackboard[BB_PATROLLING] = patrolling
		ai_controller.blackboard[BB_SUMMONER] = summoner
		ai_controller.blackboard[BB_FALCON_WANT_PERCH] = FALSE
		ai_controller.clear_blackboard_key(BB_FALCON_PERCH_TARGET)
	to_chat(user, "<span class='notice'>The falcon begins following you closely.</span>")

/mob/living/simple_animal/hostile/retaliate/custodianpet/falcon/proc/set_perching(mob/user)
	following = FALSE
	patrolling = FALSE
	summoner = user

	if(ai_controller)
		ai_controller.blackboard[BB_FOLLOWING] = FALSE
		ai_controller.blackboard[BB_PATROLLING] = FALSE
		ai_controller.blackboard[BB_SUMMONER] = summoner
		ai_controller.blackboard[BB_FALCON_WANT_PERCH] = TRUE
		ai_controller.blackboard[BB_FALCON_PERCH_TARGET] = user
		ai_controller.queue_behavior(/datum/ai_behavior/falcon_wait_and_perch, BB_FALCON_PERCH_TARGET)

/mob/living/simple_animal/hostile/retaliate/custodianpet/falcon/proc/set_unperching()
	following = FALSE
	patrolling = FALSE
	if(buckled)
		buckled.unbuckle_mob(src)
	else
		toggle_perched(perched = FALSE)
	if(ai_controller)
		ai_controller.blackboard[BB_FOLLOWING] = FALSE
		ai_controller.blackboard[BB_PATROLLING] = FALSE
		ai_controller.blackboard[BB_FALCON_WANT_PERCH] = FALSE
		ai_controller.clear_blackboard_key(BB_FALCON_PERCH_TARGET)

/mob/living/simple_animal/hostile/retaliate/custodianpet/falcon/proc/add_focus_target(mob/target)
	if(!focus_targets)
		focus_targets = list()
	if(target in focus_targets)
		focus_targets -= target
		if(ai_controller)
			ai_controller.blackboard[BB_FOCUS_TARGETS] = focus_targets.Copy()
		return
	focus_targets = list(target)
	if(ai_controller)
		ai_controller.blackboard[BB_FOCUS_TARGETS] = list(target)

/mob/living/simple_animal/hostile/retaliate/custodianpet/falcon/proc/find_and_smoke_ziggie(mob/user)
	if(has_smoke)
		to_chat(user, "<span class='notice'>[src] is already proudly smoking like the reverenced symbol that it is.</span>")
		return
	var/obj/item/clothing/face/cigarette/rollie/found_ziggie = null
	for(var/obj/item/clothing/face/cigarette/rollie/R in view(7, src))
		found_ziggie = R
		break

	if(!found_ziggie)
		to_chat(user, "<span class='warning'>[src] could not find any smokies nearby.</span>")
		return
	visible_message("<span class='notice'>[src] spots a ziggie and swoops toward it!</span>")
	if(ai_controller)
		patrolling = FALSE
		following = FALSE
		ai_controller.set_blackboard_key("ziggie_target", found_ziggie)
		ai_controller.queue_behavior(/datum/ai_behavior/falcon_follow, "ziggie_target")
	spawn(0)
		var/attempts = 0
		while(attempts < 100 && !QDELETED(src) && stat != DEAD && !QDELETED(found_ziggie))
			if(get_dist(src, found_ziggie) <= 1)
				found_ziggie.forceMove(src)
				falcon_smoke = found_ziggie
				has_smoke = TRUE // PROCEED TO HEAL FROM SMOKING!!! hahaa... a smoking snakes reference... haha....
				update_icon_state()
				visible_message("<span class='notice'>[src] looks pleased while smoking a literal ziggie. Who fucking teached them that?</span>")
				var/heal_ticks = 12
				for(var/i = 1 to heal_ticks)
					if(!has_smoke || QDELETED(src))
						break
					heal_overall_damage(5, 5)
					sleep(50)
				if(has_smoke && !QDELETED(src))
					has_smoke = FALSE
					if(falcon_smoke)
						qdel(falcon_smoke)
						falcon_smoke = null
					update_icon_state()
					visible_message("<span class='notice'>[src] finishes the ziggie and looks refreshed.</span>")
				return
			attempts++
			sleep(2)
		if(!QDELETED(found_ziggie))
			visible_message("<span class='notice'>[src] couldn't reach the ziggie in time.</span>")

/mob/living/carbon/human/proc/perch_falcon_on_hand(var/falcon)
	var/mob/living/simple_animal/hostile/retaliate/custodianpet/falcon/F = falcon
	if(!istype(F, /mob/living/simple_animal/hostile/retaliate/custodianpet/falcon) || !F.can_be_perched(src))
		to_chat(src, "<span class='warning'>That falcon don't want to perch on you.</span>")
		return FALSE
	if(F.ai_controller)
		F.ai_controller.blackboard[BB_FALCON_WANT_PERCH] = TRUE
		F.ai_controller.blackboard[BB_FALCON_PERCH_TARGET] = src
		F.ai_controller.queue_behavior(/datum/ai_behavior/falcon_wait_and_perch, BB_FALCON_PERCH_TARGET)
		to_chat(src, "<span class='info'>You beckon your falcon to perch on you.</span>")
		return TRUE
	return FALSE

/mob/living/carbon/human/proc/drop_perched_falcon()
	if(buckled_mobs)
		for(var/mob/living/simple_animal/hostile/retaliate/custodianpet/falcon/F in buckled_mobs)
			F.resist_from_perch()
			F.on_unperched()
	return FALSE

/mob/living/carbon/human/post_buckle_mob(mob/living/M)
	..()
	update_falcon_perched_overlay()

/mob/living/carbon/human/post_unbuckle_mob(mob/living/M)
	..()
	update_falcon_perched_overlay()

/mob/living/simple_animal/hostile/retaliate/custodianpet/falcon/MouseDrop_T(mob/living/carbon/human/target, mob/living/user)
	if(target == user && !buckled)
		if(ishuman(user))
			var/mob/living/carbon/human/H = user
			H.perch_falcon_on_hand(src)

/mob/living/carbon/human/MiddleClickOn(atom/A, params)
	if(A == src && buckled_mobs)
		for(var/mob/living/simple_animal/hostile/retaliate/custodianpet/falcon/F in buckled_mobs)
			F.resist_from_perch()
			return // Only drop one falcon, specifically.
	..() //THEN you can continue with the normal middle click behavior

/obj/item/paper/attackby(obj/item/I, mob/living/user, params)
	if(istype(I, /mob/living/simple_animal/hostile/retaliate/custodianpet/falcon))
		return afterattack(I, user, TRUE, params)
	return ..()

/mob/living/simple_animal/hostile/retaliate/custodianpet/falcon/attackby(obj/item/I, mob/living/carbon/human/user, params)
	if(istype(I, /obj/item/paper))
		var/obj/item/paper/P = I
		return P.afterattack(src, user, TRUE, params)
	return ..()

/mob/living/simple_animal/hostile/retaliate/custodianpet/falcon/MouseDrop_T(obj/item/paper/P, mob/living/carbon/human/user)
	if(istype(P, /obj/item/paper))
		return P.afterattack(src, user, TRUE, list())
	return ..()

/obj/item/paper/afterattack(var/obj, mob/user, reach, params)
	var/mob/living/simple_animal/hostile/retaliate/custodianpet/falcon/F = obj
	if(!istype(F, /mob/living/simple_animal/hostile/retaliate/custodianpet/falcon) || F.delivering_paper || !info)
		return ..()
	if(!user || !user.real_name)
		return ..()
	var/recipient_name = input(user, "Manifest the figure and smell for the falcon", "Send Letter")
	if(!recipient_name)
		return ..()
	var/recipient = null
	for(var/mob/living/carbon/human/H in GLOB.human_list)
		if(H.real_name == recipient_name)
			recipient = H
			break
	if(!recipient)
		to_chat(user, "<span class='warning'>The Saintalon does not know anyone with that smell.</span>")
		return ..()
	F.start_paper_delivery(src, user, recipient)
	return TRUE

/mob/living/simple_animal/hostile/retaliate/custodianpet/falcon/proc/start_paper_delivery(obj/item/paper/P, mob/living/carbon/human/sender, mob/living/carbon/human/recipient)
	if(delivering_paper)
		to_chat(sender, "<span class='warning'>The Saintalon is already delivering something.</span>")
		return
	REMOVE_TRAIT(src, TRAIT_FALCON_FROZEN, "perching")
	REMOVE_TRAIT(src, TRAIT_FALCON_PERCHED, "perched")
	if(buckled)
		buckled.unbuckle_mob(src)
	toggle_perched(FALSE)
	update_icon_state()
	delivering_paper = TRUE
	held_paper = P
	delivery_target = recipient
	old_following_state = following
	if(P.loc != src)
		P.forceMove(src)
	following = FALSE
	patrolling = FALSE
	if(ai_controller)
		ai_controller.blackboard[BB_FOLLOWING] = FALSE
		ai_controller.blackboard[BB_PATROLLING] = FALSE
		ai_controller.blackboard[BB_FALCON_WANT_PERCH] = FALSE
		ai_controller.blackboard[BB_FALCON_DELIVERING_PAPER] = TRUE
		ai_controller.clear_blackboard_key(BB_FALCON_PERCH_TARGET)
		ai_controller.clear_blackboard_key(BB_FALCON_CURRENT_TARGET)
		ai_controller.clear_blackboard_key(BB_FOCUS_TARGETS)
	fly_and_deliver_paper(sender, recipient)

/mob/living/simple_animal/hostile/retaliate/custodianpet/falcon/proc/fly_and_deliver_paper(mob/living/carbon/human/sender, mob/living/carbon/human/recipient)
	delivering_letter_anim = TRUE
	delivering_paper = TRUE
	if(ai_controller)
		ai_controller.blackboard[BB_FALCON_DELIVERING_PAPER] = TRUE
	visible_message("<span class='info'>The falcon spreads its wings and takes flight!</span>")
	var/original_pixel_y = pixel_y
	for(var/i = 1 to 8)
		pixel_y = original_pixel_y + i * 4 // Move up visually
		alpha = 255 - i * 30 //then fades out
		sleep(1)
	pixel_y = original_pixel_y + 32 //... aaand vanish.
	alpha = 0
	sleep(2)
	if(QDELETED(recipient) || !delivering_paper) return finish_falcon_delivery() // Now you come back to the recipient.
	forceMove(get_turf(recipient))
	original_pixel_y = pixel_y
	for(var/i = 8 to 1 step -1)
		pixel_y = (i-1) * 4
		alpha = 255 - (i-1) * 30
		sleep(1)
	pixel_y = 0
	alpha = 255

	visible_message("<span class='info'>[src] arrives at [recipient.real_name] with a letter!</span>")
	to_chat(recipient, "<span class='info'>[src] is offering you a letter from [sender.real_name]. Use [src] to take it.</span>")
	var/wait_time = 0
	while(wait_time < 50 && held_paper && held_paper.loc == src && !QDELETED(src) && !QDELETED(recipient) && delivering_paper)
		if(get_dist(src, recipient) > 2) break
		sleep(2)
		wait_time++

	if(held_paper && held_paper.loc == src)
		visible_message("<span class='notice'>[src] grows impatient, drops the letter, and leaves.</span>")
		held_paper.forceMove(get_turf(src))
		held_paper = null

	if(!QDELETED(sender) && delivering_paper) //Return to the falconeer after delivering the paper.
		visible_message("<span class='info'>[src] prepares to return to [sender.real_name].</span>")
		original_pixel_y = pixel_y
		for(var/i = 1 to 8)
			pixel_y = original_pixel_y + i * 4
			alpha = 255 - i * 30
			sleep(1)
		pixel_y = original_pixel_y + 32
		alpha = 0
		sleep(2)

		forceMove(get_turf(sender))
		for(var/i = 8 to 1 step -1)
			pixel_y = (i-1) * 4
			alpha = 255 - (i-1) * 30
			sleep(1)
		pixel_y = 0
		alpha = 255
		sleep(8)
	finish_falcon_delivery()

/mob/living/simple_animal/hostile/retaliate/custodianpet/falcon/proc/finish_falcon_delivery()
	delivering_letter_anim = FALSE
	delivering_paper = FALSE
	delivery_target = null
	held_paper = null
	following = old_following_state
	if(ai_controller)
		ai_controller.blackboard[BB_FOLLOWING] = following
		ai_controller.blackboard[BB_SUMMONER] = summoner
		ai_controller.blackboard[BB_FALCON_DELIVERING_PAPER] = FALSE
	src.alpha = 255

/mob/living/simple_animal/hostile/retaliate/custodianpet/falcon/simple_limb_hit(zone)
	if(!zone)
		return ""
	switch(zone)
		if(BODY_ZONE_PRECISE_R_EYE)
			return "head"
		if(BODY_ZONE_PRECISE_L_EYE)
			return "head"
		if(BODY_ZONE_PRECISE_NOSE)
			return "snout"
		if(BODY_ZONE_PRECISE_MOUTH)
			return "snout"
		if(BODY_ZONE_PRECISE_SKULL)
			return "head"
		if(BODY_ZONE_PRECISE_EARS)
			return "head"
		if(BODY_ZONE_PRECISE_NECK)
			return "neck"
		if(BODY_ZONE_PRECISE_L_HAND)
			return "foreleg"
		if(BODY_ZONE_PRECISE_R_HAND)
			return "foreleg"
		if(BODY_ZONE_PRECISE_L_FOOT)
			return "leg"
		if(BODY_ZONE_PRECISE_R_FOOT)
			return "leg"
		if(BODY_ZONE_PRECISE_STOMACH)
			return "stomach"
		if(BODY_ZONE_HEAD)
			return "head"
		if(BODY_ZONE_R_LEG)
			return "leg"
		if(BODY_ZONE_L_LEG)
			return "leg"
		if(BODY_ZONE_R_ARM)
			return "foreleg"
		if(BODY_ZONE_L_ARM)
			return "foreleg"
	return ..()

/obj/item/clothing/face/cigarette/rollie/attack(mob/living/target, mob/living/carbon/human/user)
	if(istype(target, /mob/living/simple_animal/hostile/retaliate/custodianpet/falcon))
		var/mob/living/simple_animal/hostile/retaliate/custodianpet/falcon/F = target
		if(!F.has_smoke)
			user.visible_message("<span class='warning'>[user] tries to put a rollie on [F]'s beak...</span>")
			if(do_after(user, 2 SECONDS, F))
				user.dropItemToGround(src)
				F.has_smoke = TRUE
				src.forceMove(F)
				F.update_icon_state()
		else
			to_chat(user, "<span class='notice'>[F] is already smoking!</span>")
			return
	..()

/*
/mob/living/simple_animal/hostile/retaliate/custodianpet/falcon/get_sound(input)
	if("idle")
		return pick('modular/kaizoku/sound/animals/saintalon/saintalon_3.ogg','modular/kaizoku/sound/animals/saintalon/saintalon_4.ogg','modular/kaizoku/sound/animals/saintalon/saintalon_5.ogg','modular/kaizoku/sound/animals/saintalon/saintalon_6.ogg')
*/

/mob/living/carbon/human
	var/image/falcon_perched_overlay = null
	max_buckled_mobs = 1

/mob/living/carbon/human/MiddleClickOn(atom/A, params)
	..()
	if(A == src)
		drop_perched_falcon()

/datum/intent/whistle/use
	name = "Use"
	icon_state = "inuse"
	chargetime = 0
	noaa = TRUE
	rmb_ranged = TRUE

/datum/intent/whistle/use/rmb_ranged(atom/target, mob/user)
	if(ismob(target))
		var/mob/L = target
		for(var/mob/living/simple_animal/hostile/retaliate/custodianpet/falcon/F in view(7, user))
			if(!F.summoner)
				continue
			if(F.summoner != user)
				to_chat(user, "<span class='warning'>[F] ignores your command. It serves another master.</span>")
				continue
			if(F == L)
				to_chat(user, "<span class='warning'>The falcon gets confused. Why attack itself?</span>")
				continue
			F.add_focus_target(L)
		for(var/mob/living/simple_animal/hostile/retaliate/custodianpet/doggo/D in view(7, user))
			if(!D.summoner)
				continue
			if(D.summoner != user)
				to_chat(user, "<span class='warning'>[D] ignores your command. It serves another master.</span>")
				continue
			if(D == L)
				to_chat(user, "<span class='warning'>The doggo gets confused. Why attack itself?</span>")
				continue
			D.add_focus_target(L)
		to_chat(user, "<span class='info'>The sharp sounds command your animal(s) to attack [L].</span>")
		return
	if(isturf(target))
		var/turf/T = target
		for(var/mob/living/simple_animal/hostile/retaliate/custodianpet/falcon/F in view(7, user))
			if(F.summoner == user)
				F.move_to_turf(T, user)
		for(var/mob/living/simple_animal/hostile/retaliate/custodianpet/doggo/D in view(7, user))
			if(D.summoner == user)
				D.move_to_turf(T, user)
		to_chat(user, "<span class='info'>You signal your animal(s) to move to a spot.</span>")
		return

var/global/list/whistle_command_cooldowns = list()

/obj/item/pet_command/whistle/attack_self(mob/user)
	if(whistle_command_cooldowns[user] && world.time < whistle_command_cooldowns[user])
		to_chat(user, "<span class='warning'>Your lungs need to recover before using this again.</span>")
		return
	whistle_command_cooldowns[user] = world.time + 10

	// Find both falcons and doggos
	var/list/falcons = list()
	var/list/doggos = list()

	for(var/mob/living/simple_animal/hostile/retaliate/custodianpet/falcon/F in view(7, user))
		if(F.summoner == user && !(HAS_TRAIT(F, TRAIT_FALCON_PERCHED) && F.buckled == user))
			falcons += F

	for(var/mob/living/simple_animal/hostile/retaliate/custodianpet/doggo/D in view(7, user))
		if(D.summoner == user)
			doggos += D

	if(!falcons.len && !doggos.len)
		to_chat(user, "<span class='warning'>No companions recognize your whistle.</span>")
		return

	var/list/made_choices = list()

	if(falcons.len)
		var/datum/radial_menu_choice/perch_option = new
		perch_option.image = image(icon = 'icons/mob/animal.dmi', icon_state = "parrot_sit")
		perch_option.info = span_boldnotice("Call your falcon to perch on you.")
		made_choices["Perch"] = perch_option

	var/datum/radial_menu_choice/patrol_option = new
	patrol_option.image = image(icon = 'icons/mob/animal.dmi', icon_state = "parrot_fly")
	patrol_option.info = span_boldnotice("Command your companion to patrol the area and hunt for enemies.")
	made_choices["Patrol"] = patrol_option

	var/datum/radial_menu_choice/heal_option = new
	heal_option.image = image(icon = 'icons/roguetown/items/lighting.dmi', icon_state = "spliffoff")
	heal_option.info = span_boldnotice("Command your companion to find healing. Falcon seeks ziggies, doggo seeks meat or bones.")
	made_choices["Heal"] = heal_option

	if(falcons.len)
		var/datum/radial_menu_choice/message_option = new
		message_option.image = image(icon = 'icons/mob/animal.dmi', icon_state = "parrot_dead")
		message_option.info = span_boldnotice("Use your falcon to send messages or small objects.")
		made_choices["Send Message"] = message_option

	if(doggos.len)
		var/datum/radial_menu_choice/rest_option = new
		rest_option.image = image(icon = 'icons/mob/animal.dmi', icon_state = "parrot_dead")
		rest_option.info = span_boldnotice("Allow your doggo to rest on a nearby bed and recover.")
		made_choices["Rest"] = rest_option

	var/task = show_radial_menu(user, get_turf(user), made_choices, tooltips = TRUE)
	if(!task)
		return
	switch(task)
		if("Perch")
			if(!falcons.len)
				to_chat(user, "<span class='warning'>You have no falcon to perch!</span>")
				return
			for(var/mob/living/simple_animal/hostile/retaliate/custodianpet/falcon/F in falcons)
				F.set_perching(user)
			to_chat(user, "<span class='info'>The sound beckons your falcon(s) to perch on you.</span>")
			// Doggo confusion
			if(doggos.len)
				for(var/mob/living/simple_animal/hostile/retaliate/custodianpet/doggo/D in doggos)
					D.visible_message("<span class='notice'>[D] tilts its head in confusion at the command.</span>")
		if("Patrol")
			for(var/mob/living/simple_animal/hostile/retaliate/custodianpet/falcon/F in falcons)
				F.toggle_patrol(user)
			for(var/mob/living/simple_animal/hostile/retaliate/custodianpet/doggo/D in doggos)
				D.toggle_patrol(user)
		if("Heal")
			for(var/mob/living/simple_animal/hostile/retaliate/custodianpet/falcon/F in falcons)
				F.find_and_smoke_ziggie(user)
			for(var/mob/living/simple_animal/hostile/retaliate/custodianpet/doggo/D in doggos)
				D.find_and_eat_food(user)
		if("Send Message")
			if(!falcons.len)
				to_chat(user, "<span class='warning'>You have no falcon for sending messages!</span>")
				return
			var/obj/item/held_item = user.get_inactive_held_item()
			if(!held_item)
				to_chat(user, "<span class='warning'>You need to hold an item (paper or small object) in your other hand to send!</span>")
				return
			if(!istype(held_item, /obj/item/paper) && held_item.w_class != WEIGHT_CLASS_TINY && held_item.w_class != WEIGHT_CLASS_SMALL)
				to_chat(user, "<span class='warning'>The falcon can only carry paper, keys, or small items!</span>")
				return
			var/recipient_name = input(user, "Who do you want to send this to? (Type their exact name)", "Falcon Messenger") as text|null
			if(!recipient_name)
				return
			var/mob/living/carbon/human/target = null
			for(var/mob/living/carbon/human/H in GLOB.human_list)
				if(H.real_name == recipient_name)
					target = H
					break
			if(!target)
				to_chat(user, "<span class='warning'>The falcon cannot find anyone named '[recipient_name]'.</span>")
				return
			for(var/mob/living/simple_animal/hostile/retaliate/custodianpet/falcon/F in falcons)
				F.send_item_via_messenger(user, held_item, target)
				break
			if(doggos.len)
				for(var/mob/living/simple_animal/hostile/retaliate/custodianpet/doggo/D in doggos)
					D.visible_message("<span class='notice'>[D] looks confused, unsure of what to do.</span>")
		if("Rest")
			if(!doggos.len)
				to_chat(user, "<span class='warning'>You have no doggo to rest!</span>")
				return
			var/obj/structure/bed/found_bed = null
			for(var/obj/structure/bed/B in view(10, user))
				found_bed = B
				break
			if(found_bed)
				for(var/mob/living/simple_animal/hostile/retaliate/custodianpet/doggo/D in doggos)
					D.set_resting_bed(found_bed, user)
			else
				to_chat(user, "<span class='warning'>There are no beds nearby for your doggo to rest on.</span>")

/mob/living/simple_animal/hostile/retaliate/custodianpet/falcon/proc/move_to_turf(var/turf/T, mob/user)
	patrolling = FALSE
	following = FALSE
	if(ai_controller)
		ai_controller.blackboard[BB_PATROLLING] = FALSE
		ai_controller.blackboard[BB_FOLLOWING] = FALSE
		ai_controller.blackboard[BB_DOGGO_RESTING] = FALSE
		ai_controller.blackboard[BB_DOGGO_REST_BED] = null
		ai_controller.set_movement_target(T)
	to_chat(user, "<span class='notice'>[src] begins moving to the spot.</span>")

/obj/item/pet_command/whistle
	name = "dustwalker whistle"
	desc = "A metal whistle of dustwalker culture settled to allow communication between user and its spiritual companions. Works with both falcons and doggos."
	icon = 'modular/kaizoku/icons/mobs/falcon.dmi'
	icon_state = "whistle"
	possible_item_intents = list(/datum/intent/whistle/use)
	w_class = WEIGHT_CLASS_TINY
	slot_flags = ITEM_SLOT_RING|ITEM_SLOT_HIP|ITEM_SLOT_WRISTS

/mob/living/simple_animal/hostile/retaliate/custodianpet/falcon/proc/start_perching(atom/target)
	if(HAS_TRAIT(src, TRAIT_FALCON_PERCHED))
		return FALSE

	if(istype(target, /mob/living/carbon/human))
		if(get_dist(src, target) > 1)
			return FALSE
		return perch_on_human(target)

	var/list/perch_types = ai_controller?.blackboard[BB_FALCON_PERCH_TYPES]
	if(!perch_types || !is_type_in_list(target, perch_types))
		return FALSE
	if(get_dist(src, target) > 1)
		return FALSE

	src.forceMove(get_turf(target))
	toggle_perched(perched = TRUE)
	visible_message("<span class='notice'>[src] perches on [target].</span>")
	return TRUE

/obj/item/kaizoku/falcon_crate
	name = "falcon crate"
	desc = "A wooden crate with air holes. Scratching and chirping can be heard from inside."
	icon = 'modular/kaizoku/icons/mapset/tradesector32.dmi'
	icon_state = "animal_cage"
	var/mob_path = /mob/living/simple_animal/hostile/retaliate/custodianpet/falcon

/obj/item/kaizoku/falcon_crate/attackby(obj/item/W, mob/living/user)
	if(istype(W, /obj/item/weapon/knife))
		to_chat(user, "<span class='info'>You carefully cut the bindings on the crate, and a falcon bursts out!</span>")
		playsound(src, 'sound/misc/slide_wood (1).ogg', 50, TRUE)
		var/mob/living/simple_animal/hostile/retaliate/custodianpet/falcon/F = new mob_path(get_turf(user))
		F.summoner = user
		if(F.ai_controller)
			F.ai_controller.blackboard[BB_SUMMONER] = user
		qdel(src)
	else
		to_chat(user, "<span class='warning'>You need a knife to open this crate.</span>")

/obj/item/kaizoku/falcon_crate/doggo
	name = "doggo crate"
	desc = "A wooden crate with air holes. Scratching and chirping can be heard from inside."
	icon = 'modular/kaizoku/icons/mapset/tradesector32.dmi'
	icon_state = "animal_cage"
	mob_path = /mob/living/simple_animal/hostile/retaliate/custodianpet/doggo

/obj/effect/kaizoku_falcon_messenger
	name = "messenger falcon"
	desc = "A falcon carrying an item to its destination."
	icon = 'modular/kaizoku/icons/mobs/falcon.dmi'
	icon_state = "falcon"
	layer = ABOVE_NORMAL_TURF_LAYER
	var/obj/item/carried_item
	var/turf/target_turf
	var/mob/living/recipient

/obj/effect/kaizoku_falcon_messenger/Initialize(mapload, obj/item/I, turf/T, mob/living/R)
	. = ..()
	carried_item = I
	target_turf = T
	recipient = R
	addtimer(CALLBACK(src, PROC_REF(do_delivery)), 0)

/obj/effect/kaizoku_falcon_messenger/proc/do_delivery()
	if(!target_turf)
		qdel(src)
		return

	forceMove(target_turf)
	pixel_x = -32
	pixel_y = 24
	alpha = 255

	if(recipient && !QDELETED(recipient))
		recipient.Immobilize(1 SECONDS)

	var/matrix/diveTilt = matrix().Turn(40)
	var/matrix/climbTilt = matrix().Turn(-25)

	animate(src, time = 12, pixel_x = 0, pixel_y = -16, transform = diveTilt, easing = CUBIC_EASING | EASE_IN)
	animate(src, time = 18, pixel_x = 32, pixel_y = 24, transform = climbTilt, alpha = 0, easing = CUBIC_EASING | EASE_OUT)

	playsound(src, 'sound/vo/mobs/bird/birdfly.ogg', 30, TRUE, -1)

	addtimer(CALLBACK(src, PROC_REF(drop_item)), 1.2 SECONDS)
	addtimer(CALLBACK(src, PROC_REF(cleanup)), 2 SECONDS)

/obj/effect/kaizoku_falcon_messenger/proc/drop_item()
	if(carried_item && !QDELETED(carried_item))
		carried_item.forceMove(target_turf)
		for(var/mob/M in view(3, target_turf))
			to_chat(M, "<span class='nicegreen'>A falcon swoops low and drops [carried_item.name] at [recipient?.name]'s feet!</span>")

/obj/effect/kaizoku_falcon_messenger/proc/cleanup()
	qdel(src)

/mob/living/simple_animal/hostile/retaliate/custodianpet/falcon/proc/send_item_via_messenger(mob/user, obj/item/I, mob/living/target)
	if(!I || !target)
		return FALSE

	var/turf/T = get_turf(target)
	if(!T)
		return FALSE

	user.dropItemToGround(I)
	I.forceMove(src)

	new /obj/effect/kaizoku_falcon_messenger(get_turf(user), I, T, target)

	to_chat(user, "<span class='notice'>[src] takes [I.name] and flies off to deliver it to [target.real_name]!</span>")
	visible_message("<span class='info'>[src] takes flight with [I.name] clutched in its talons!</span>")
	playsound(src, 'sound/vo/mobs/bird/birdfly.ogg', 50, TRUE, -1)

	return TRUE
