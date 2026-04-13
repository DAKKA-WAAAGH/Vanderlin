/obj/item/kaizoku/grenade
	name = "grenade"
	desc = ""
	w_class = WEIGHT_CLASS_SMALL
	throw_speed = 1
	throw_range = 7
	flags_1 = CONDUCT_1
	slot_flags = ITEM_SLOT_BELT
	resistance_flags = FLAMMABLE
	max_integrity = 40
	var/active = FALSE
	var/det_time = 50
	var/display_timer = TRUE
	var/clumsy_check = GRENADE_CLUMSY_FUMBLE

/obj/item/kaizoku/grenade/suicide_act(mob/living/carbon/user)
	user.visible_message("<span class='suicide'>[user] primes [src], then eats it! It looks like [user.p_theyre()] trying to commit suicide!</span>")
	playsound(src, 'sound/blank.ogg', 50, TRUE)
	preprime(user, det_time)
	user.transferItemToLoc(src, user, TRUE)//>eat a grenade set to 5 seconds >rush captain
	sleep(det_time)//so you dont die instantly
	return BRUTELOSS

/obj/item/kaizoku/grenade/deconstruct(disassembled = TRUE)
	if(!disassembled)
		prime()
	if(!QDELETED(src))
		qdel(src)

/obj/item/kaizoku/grenade/examine(mob/user)
	. = ..()
	if(display_timer)
		if(det_time > 0)
			. += "The timer is set to [DisplayTimeText(det_time)]."
		else
			. += "\The [src] is set for instant detonation."

/obj/item/kaizoku/grenade/attack_self(mob/user)
	if(!active)
		preprime(user)

/obj/item/kaizoku/grenade/proc/log_grenade(mob/user, turf/T)
	log_bomber(user, "has primed a", src, "for detonation")

/obj/item/kaizoku/grenade/proc/preprime(mob/user, delayoverride, msg = TRUE, volume = 60)
	var/turf/T = get_turf(src)
	log_grenade(user, T) //Inbuilt admin procs already handle null users
	if(user)
		if(msg)
			to_chat(user, "<span class='warning'>I prime [src]! [capitalize(DisplayTimeText(det_time))]!</span>")
	playsound(src, 'sound/blank.ogg', volume, TRUE)
	active = TRUE
	icon_state = initial(icon_state) + "_active"
	addtimer(CALLBACK(src, PROC_REF(prime)), isnull(delayoverride)? det_time : delayoverride)

/obj/item/kaizoku/grenade/proc/prime()

/obj/item/kaizoku/grenade/proc/update_mob()
	if(ismob(loc))
		var/mob/M = loc
		M.dropItemToGround(src)

/obj/item/kaizoku/grenade/proc/change_det_time(time) //Time uses real time.
	. = TRUE
	if(time != null)
		if(time < 3)
			time = 3
		det_time = round(CLAMP(time * 10, 0, 50))
	else
		var/previous_time = det_time
		switch(det_time)
			if (0)
				det_time = 30
			if (30)
				det_time = 50
			if (50)
				det_time = 0
		if(det_time == previous_time)
			det_time = 50

/obj/item/kaizoku/grenade/attack_paw(mob/user)
	return attack_hand(user)

/obj/item/kaizoku/grenade/hit_reaction(mob/living/carbon/human/owner, atom/movable/hitby, attack_text = "the attack", final_block_chance = 0, damage = 0, attack_type = MELEE_ATTACK)
	var/obj/projectile/P = hitby
	if(damage && attack_type == PROJECTILE_ATTACK && P.damage_type != STAMINA && prob(15))
		owner.visible_message("<span class='danger'>[attack_text] hits [owner]'s [src], setting it off! What a shot!</span>")
		var/turf/T = get_turf(src)
		log_game("A projectile ([hitby]) detonated a grenade held by [key_name(owner)] at [COORD(T)]")
		message_admins("A projectile ([hitby]) detonated a grenade held by [key_name_admin(owner)] at [ADMIN_COORDJMP(T)]")
		prime()
		return TRUE //It hit the grenade, not them

/obj/item/kaizoku/grenade/afterattack(atom/target, mob/user)
	. = ..()
	if(active)
		user.throw_item(target)

// Smoke effects
/obj/effect/particle_effect/smoke/bad/stupid
	lifetime = 20
	color = "#1b802c"
	opaque = FALSE

/obj/effect/particle_effect/smoke/bad/stupid/smoke_mob(mob/living/carbon/M)
	if(..())
		M.add_nausea(4)
		M.adjustToxLoss(5, 0)
		M.emote("cough")
		return TRUE

/datum/effect_system/smoke_spread/bad/stupid
	effect_type = /obj/effect/particle_effect/smoke/bad/stupid

// Smoke bombs
/obj/item/kaizoku/grenade/smoke_bomb
	name = "smoke bomb"
	desc = "The stealth operation bomb made out of guano, sugar and nahcolite for shinobi usage."
	icon = 'modular/kaizoku/icons/weapons/32.dmi'
	icon_state = "smoke_bomb"
	item_state = "smoke_bomb"
	slot_flags = ITEM_SLOT_BELT
	display_timer = FALSE
	var/mob/last_user
	var/teleport_on_prime = FALSE

/obj/item/kaizoku/grenade/smoke_bomb/attack_self(mob/user)
	last_user = user
	teleport_on_prime = TRUE
	user.visible_message("<span class='warning'>[user]'s hand breaks the ceramic of the [src], releasing smoke!</span>", "<span class='notice'>I squeeze [src] down to release the inner compounds to the air.</span>")
	prime()

/obj/item/kaizoku/grenade/smoke_bomb/throw_impact(atom/hit_atom, datum/thrownthing/throwingdatum)
	last_user = throwingdatum.thrower
	..()
	prime()

/obj/item/kaizoku/grenade/smoke_bomb/prime()
	update_mob()
	playsound(src, 'modular/kaizoku/sound/items/smokebomb.ogg', 50, TRUE, -3)
	var/datum/effect_system/smoke_spread/bad/smoke = new
	smoke.set_up(4, src)
	smoke.start()
	if(teleport_on_prime && last_user && last_user.z == z)
		var/turf/above = locate(last_user.x, last_user.y, last_user.z + 1)
		if(above && (locate(/obj/structure/flora/newbranch) in above))
			last_user.forceMove(above)
			to_chat(last_user, "<span class='notice'>You leap to the branches above.</span>")
	qdel(src)

/obj/item/kaizoku/grenade/smoke_bomb/poison
	name = "toxic bomb"
	desc = "Ceramic sphere containing toxic composts from within, awaiting to be released."
	icon = 'modular/kaizoku/icons/weapons/32.dmi'
	icon_state = "poison_bomb"
	item_state = "poison_bomb"
	slot_flags = ITEM_SLOT_BELT

/obj/item/kaizoku/grenade/smoke_bomb/poison/attack_self(mob/user)
	last_user = user
	user.visible_message("<span class='warning'>[user]'s hand breaks the ceramic of the [src], engulfing themselves on poisonous smoke.</span>", "<span class='notice'>I squeeze [src] down to release the inner compounds- like an IDIOT. RUN AWAY!</span>")
	prime()

/obj/item/kaizoku/grenade/smoke_bomb/poison/throw_impact(atom/hit_atom, datum/thrownthing/throwingdatum)
	last_user = throwingdatum.thrower
	..()
	prime()

/obj/item/kaizoku/grenade/smoke_bomb/poison/prime()
	update_mob()
	playsound(src, 'modular/kaizoku/sound/items/smokebomb.ogg', 50, TRUE, -3)
	var/datum/effect_system/smoke_spread/bad/stupid/smoke = new
	smoke.set_up(4, src)
	smoke.start()
	qdel(src)

// Thunder crash bomb
/obj/item/kaizoku/grenade/zhentianlei
	name = "thunder crash bomb"
	desc = "A bomb made out of cast iron and ceramic, now filled with gunpowder to the brim. Usually, it takes five seconds before the fire on the fuse reaches the gunpowder."
	icon_state = "zhentianlei"
	icon = 'modular/kaizoku/icons/weapons/32.dmi'
	w_class = WEIGHT_CLASS_NORMAL
	throwforce = 0
	throw_speed = 0.5
	slot_flags = ITEM_SLOT_HIP
	display_timer = FALSE

	var/lit = FALSE
	var/fuze = 50  // about five seconds
	var/obj/item/ignited_by = null
	var/initial_icon_state = "zhentianlei"
	var/active_icon_state = "zhentianlei_rewinded"
	var/prob2fail = 23  // chance of failure

/obj/item/kaizoku/grenade/zhentianlei/spark_act()
	ignite()

/obj/item/kaizoku/grenade/zhentianlei/fire_act()
	ignite()

/obj/item/kaizoku/grenade/zhentianlei/ex_act()
	if(!QDELETED(src))
		lit = TRUE
		trigger_explosion(TRUE)

/obj/item/kaizoku/grenade/zhentianlei/New()
	..()
	icon_state = initial_icon_state

/obj/item/kaizoku/grenade/zhentianlei/proc/ignite(atom/igniter = null)
	if(!lit)
		START_PROCESSING(SSfastprocess, src)  // Start the processing for the fuse
		icon_state = active_icon_state
		lit = TRUE
		ignited_by = igniter
		playsound(src.loc, 'modular/kaizoku/sound/items/firelight.ogg', 100)
		to_chat(src.loc, "<span class='warning'>The [name] starts to fizzle!</span>")
		if(ismob(src.loc))
			var/mob/M = src.loc
			M.update_inv_hands()

/obj/item/kaizoku/grenade/zhentianlei/proc/stop_ignition()
	if(lit)
		lit = FALSE
		STOP_PROCESSING(SSfastprocess, src)
		icon_state = initial_icon_state
		ignited_by = null
		playsound(src.loc, 'modular/kaizoku/sound/items/firesnuff.ogg', 100)
		to_chat(src.loc, "<span class='notice'>\The [name] has been snuffed out.</span>")
		if(ismob(src.loc))
			var/mob/M = src.loc
			M.update_inv_hands()

/obj/item/kaizoku/grenade/zhentianlei/proc/trigger_explosion(skipprob = FALSE)
	STOP_PROCESSING(SSfastprocess, src)  // Stop the processing for the fuse
	var/turf/T = get_turf(src)
	if(T)
		if(lit)
			var/prob_fail = prob2fail
			if(ignited_by && istype(ignited_by, /obj/item))
				var/obj/item/igniter = ignited_by
				if(igniter.vars["prob2fail"])
					prob_fail = igniter.vars["prob2fail"]
			if(!skipprob && prob(prob_fail))
				stop_ignition()
			else
				explosion(T, light_impact_range = 2, flame_range = 4, smoke = TRUE, soundin = pick('modular/kaizoku/sound/misc/explode/bottlebomb (1).ogg','modular/kaizoku/sound/misc/explode/bottlebomb (2).ogg'))
		else
			if(prob(prob2fail))
				stop_ignition()
			else
				playsound(T, 'modular/kaizoku/sound/items/firesnuff.ogg', 100)
				new /obj/effect/decal/cleanable/debris/clay(T)
	qdel(src)

/obj/item/kaizoku/grenade/zhentianlei/process()
	if(lit)
		fuze -= 1
		if(fuze <= 0)
			trigger_explosion(TRUE)

/obj/item/kaizoku/grenade/zhentianlei/examine(mob/user)
	. = ..()
	if(lit)
		. += "The fuse is burning!"
	else
		. += "The fuse is not lit."

/obj/item/kaizoku/grenade/zhentianlei/attackby(obj/item/C, mob/living/user)
	if(C.sharpness >= IS_SHARP)
		var/list/options = list("Shorten fuse (3 seconds)", "Make booby trap (instant)")
		var/choice = input(user, "How do you want to cut the fuse?", "Fuse Adjustment") as null|anything in options
		if(!choice)
			return
		switch(choice)
			if("Shorten fuse (3 seconds)")
				if(fuze > 30)
					fuze = 30
					to_chat(user, "<span class='warning'>You shorten [src]'s fuse to 3 seconds.</span>")
					playsound(src.loc, 'modular/kaizoku/sound/items/sharpen_short2.ogg', 100)
				else
					to_chat(user, "<span class='warning'>The fuse is already short enough.</span>")
			if("Make booby trap (instant)")
				fuze = 0
				to_chat(user, "<span class='danger'>You shorten [src]'s fuse, turning it into a booby trap!</span>")
				playsound(src.loc, 'modular/kaizoku/sound/items/sharpen_short2.ogg', 100)
		return
	if(istype(C, /obj/item/natural/cloth))
		if(fuze < 50)
			fuze = 50
			to_chat(user, "<span class='notice'>You lengthen [src]'s fuse back to 5 seconds with the cloth.</span>")
			qdel(C)
		else
			to_chat(user, "<span class='warning'>The fuse is already at maximum length.</span>")
		return
	..()

// Grenade storage
/obj/item/storage/hip/grenade_satchel
	name = "grenade satchel"
	desc = "A satchel designed for storing grenades securely."
	icon = 'icons/roguetown/clothing/belts.dmi'
	icon_state = "grenade_satchel"
	item_state = "grenade_satchel"
	slot_flags = ITEM_SLOT_HIP
	w_class = WEIGHT_CLASS_NORMAL
	max_integrity = 300
	equip_sound = 'sound/blank.ogg'
	bloody_icon_state = "bodyblood"
	anvilrepair = /datum/skill/craft/blacksmithing
	smeltresult = /obj/item/ingot/iron
	component_type = /datum/component/storage/concrete/grid/grenade_satchel

/datum/component/storage/concrete/grid/grenade_satchel
	max_items = 6
	max_w_class = WEIGHT_CLASS_NORMAL
	max_combined_w_class = 18
	can_hold = list(/obj/item/kaizoku/grenade)

/datum/component/storage/concrete/grid/grenade_satchel/can_be_inserted(obj/item/I, stop_messages = FALSE, mob/M)
	if(!istype(I, /obj/item/kaizoku/grenade))
		if(!stop_messages && M)
			to_chat(M, "<span class='warning'>[I] won't fit in [parent]!</span>")
		return FALSE
	return ..()
