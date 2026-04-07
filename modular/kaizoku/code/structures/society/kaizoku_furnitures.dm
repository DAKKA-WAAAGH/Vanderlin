/obj/structure/frontierjustice
	name = "frontier justice"
	desc = "The manifestation extrajudicidal punishment by vigilantism, or performed by evil doers to instill fear. One may never know."
	icon = 'modular/kaizoku/icons/mapset/frontierjustice.dmi'
	icon_state = "edgy1"
	anchored = TRUE
	density = FALSE
	opacity = 0
	blade_dulling = DULLING_CUT
	max_integrity = 50
	layer = ABOVE_OBJ_LAYER
	destroy_sound = 'sound/foley/bodyfall (1).ogg'

/obj/structure/frontierjustice/Initialize()
	. = ..()
	icon_state = "edgy[rand(1,5)]"

/obj/structure/frontierjustice/examine_status(mob/user)
	if(max_integrity)
		var/healthpercent = (atom_integrity/max_integrity) * 100
		switch(healthpercent)
			if(50 to 99)
				return  "The flesh is still in place."
			if(25 to 50)
				return  "Damage has set its toll."
			if(1 to 25)
				return  "<span class='warning'>The corpse is almost butchered.</span>"

/obj/structure/frontierjustice/Destroy()
	var/turf/T = loc
	if(isturf(T)) // Ensure `T` is a valid turf
		var/obj/item/reagent_containers/food/snacks/meat/steak/meat_piece = new(T)
		if(meat_piece)
			meat_piece.name = "humen meat" //funny
	. = ..()

/obj/structure/frontierjustice/dead
	name = "fated as you"
	desc = "Killed off and left to rot."
	icon_state = "dead1"
	destroy_sound = 'sound/combat/dismemberment/dismem (1).ogg'

/obj/structure/frontierjustice/dead/Initialize()
	. = ..()
	icon_state = "dead1" //had to put that otherwise OG frontier justice would kill it off

/obj/structure/frontierjustice/canibalism
	name = "the meal"
	desc = "Poor victim of the greenskins or wood elven."
	icon_state = "cannibalism1"
	destroy_sound = 'sound/combat/dismemberment/dismem (1).ogg'

/obj/structure/frontierjustice/canibalism/Initialize()
	. = ..()
	icon_state = "cannibalism[rand(1,2)]"

/obj/structure/frontierjustice/canibalism/Destroy()
	var/turf/T = loc
	if(isturf(T)) // Ensure `T` is a valid turf
		var/obj/item/reagent_containers/food/snacks/cooked/frysteak/meat_piece = new(T)
		if(meat_piece)
			meat_piece.name = "cooked humen meat" //funny
			meat_piece.desc = "A slab of manflesh, slow-cooked over glowing coals."
	. = ..()

/obj/structure/frontierjustice/crossed
	name = "believer"
	desc = "If one forgot the meaning of some religious symbols, surely this will remind them."
	icon_state = "crossed1"
	destroy_sound = 'sound/foley/breaksound.ogg'

/obj/structure/frontierjustice/crossed/Initialize()
	. = ..()
	icon_state = "crossed[rand(1,3)]"

/obj/structure/frontierjustice/caged
	name = "cage"
	desc = "Better check if someone is already inside, awaiting for salvation that never came."
	icon_state = "cage1"
	destroy_sound = 'sound/combat/hits/blunt/metalblunt (2).ogg'

/obj/structure/frontierjustice/caged/Initialize()
	. = ..()
	icon_state = "cage[rand(1,3)]"

/obj/structure/frontierjustice/caged/Destroy()
	. = ..()

/obj/structure/chair/bench/fogland
	name = "cushioned couch"
	desc = "A couch made from silken muqian-styled threads and expensive, reddish tropical wood."
	icon_state = "abyssanctumthrone"
	icon = 'modular/kaizoku/icons/mapset/furniture_32x32.dmi'

/obj/structure/chair/bench/fogland/stone
	name = "stone throne"
	desc = "Stoneblock that was chiseled into the shape of a chair."
	icon_state = "abyssalthrone_2"

/obj/structure/chair/bench/fogland/abyssal
	name = "purifier bench"
	desc = "Among the purifiers, some degree of comfort can be ensured."
	icon_state = "abyssalbench"

/obj/structure/chair/bench/fogland/sand
	name = "sandstone bench"
	desc = "Simple, cheap bench made out of compacted, burnt sand."
	icon_state = "sandstonebench"

/obj/structure/chair/bench/fogland/stone
	name = "abyssanctum bench"
	desc = "Padded bench to provide great comfort for the restless abyssal fold."
	icon_state = "abyssalbench_2"

/obj/structure/bed/wool/futon
	name = "foglander bed"
	desc = "A bedding made from many tatami layering and cloth that can be aired to keep it free of mites and mold."
	icon_state = "futon"
	icon = 'modular/kaizoku/icons/mapset/furniture_32x32.dmi'

/obj/structure/chair/wood/foglander
	name = "foglander chair"
	icon_state = "abyssalchair"
	desc = "Smooth chair made out of reddish, expensive tropical woods."
	icon = 'modular/kaizoku/icons/mapset/furniture_32x32.dmi'
	resistance_flags = FLAMMABLE
	max_integrity = 70
	buildstacktype = null
	buildstackamount = 0
	item_chair = null
	anchored = FALSE

/obj/structure/well/shishiodoshi //Make this scare demons and tieflings later.
	name = "demon frightener" //deerscare
	desc = "Water fountain used in gardens, making windstalks bash against an argentite ore, creating an almost imperceptible sound that makes demons uncomfortable."
	icon = 'modular/kaizoku/icons/mapset/furniture_32x32.dmi'
	icon_state = "shishiodoshi"
	layer = BELOW_MOB_LAYER
	var/openwater = TRUE

/obj/structure/well/shishiodoshi/attack_hand(mob/living/user)
	update_icon()
	return

/obj/structure/well/shishiodoshi/update_icon()
	. = ..()
	cut_overlays()
	if(openwater == TRUE)
		icon_state = "shishiodoshi_stop"
		openwater = FALSE
	else
		icon_state = "shishiodoshi"
		openwater = TRUE

/obj/structure/well/shishiodoshi/onbite(mob/user)
	if(isliving(user))
		var/mob/living/L = user
		if(L.stat != CONSCIOUS)
			return
		if(iscarbon(user))
			var/mob/living/carbon/C = user
			if(C.is_mouth_covered())
				return
		if(src.openwater == FALSE)
			user.visible_message(span_info("[user] attempts to drink water from a closed [src]. Foolish."))
			return
		playsound(user, pick('sound/foley/waterwash (1).ogg','sound/foley/waterwash (2).ogg'), 100, FALSE)
		user.visible_message(span_info("[user] starts to drink from [src]."))
		if(do_after(L, 2.5 SECONDS, src))
			var/datum/reagents/reagents = new()
			reagents.add_reagent_list(list(/datum/reagent/water = 2))
			reagents.trans_to(L, reagents.total_volume, transfered_by = user, method = INGEST)
			playsound(user,pick('sound/items/drink_gen (1).ogg','sound/items/drink_gen (2).ogg','sound/items/drink_gen (3).ogg'), 100, TRUE)
		return
	..()

/obj/structure/well/shishiodoshi/attackby(obj/item/I, mob/user, params)
	if(istype(I, /obj/item/reagent_containers/glass/bucket))
		var/obj/item/reagent_containers/glass/bucket/W = I
		if(W.reagents.holder_full())
			to_chat(user, "<span class='warning'>[W] is full.</span>")
			return
		if(do_after(user, 6 SECONDS, src))
			var/list/waterl = list(/datum/reagent/water = 100)
			W.reagents.add_reagent_list(waterl)
			to_chat(user, "<span class='notice'>I fill [W] from [src].</span>")
			playsound(user, pick('sound/foley/waterwash (1).ogg','sound/foley/waterwash (2).ogg'), 80, FALSE)
			return
	else ..()

/obj/structure/bed/bedbox //WARNING: SPRITES ARE BUGGED NOW AFTER UPDATE.
	name = "box-bed"
	desc = "Traditional enclosed bed used by foglander imperial and custodian forces for protection against surprise attacks."
	icon = 'modular/kaizoku/icons/mapset/furniture_32x32.dmi'
	icon_state = "boxbed"
	layer = OBJ_LAYER
	resistance_flags = FLAMMABLE //Has too much wood to be fireproof, even if it has iron on it.
	max_integrity = 400 //Will resist damage to a degree. Cannot be comparable to walls, but it will take enough time to wake up the person inside if attacked.
	integrity_failure = 0.35
	anchored = TRUE
	density = TRUE
	can_buckle = TRUE
	buckle_lying = 90
	sleepy = 3
	buckleverb = "lay"
	debris = list(/obj/item/natural/wood/plank = 1)

	base_icon_state = "boxbed"
	var/opened = TRUE
	var/locked = FALSE
	var/welded = FALSE
	var/mob_storage_capacity = 1
	var/storage_capacity = 10
	var/open_sound = 'sound/misc/chestopen.ogg'
	var/close_sound = 'sound/misc/chestclose.ogg'
	var/open_sound_volume = 50
	var/close_sound_volume = 50

/obj/structure/bed/bedbox/Initialize()
	. = ..()
	update_icon()
	if(!opened)
		addtimer(CALLBACK(src, PROC_REF(take_contents)), 0)

/obj/structure/bed/bedbox/update_icon()
	. = ..()
	cut_overlays()
	icon_state = "[base_icon_state][opened ? "_open" : ""]"
	if(opened)
		add_overlay("boxbed_open_in")
		density = FALSE
	else
		add_overlay("boxbed_close_in")
		density = TRUE

	if(!opened && islist(buckled_mobs) && buckled_mobs.len)
		var/mutable_appearance/cover = mutable_appearance(icon, "boxbed_close_in")
		cover.layer = ABOVE_MOB_LAYER
		add_overlay(cover)

/obj/structure/bed/bedbox/post_buckle_mob(mob/living/M)
	. = ..()
	if(!opened)
		M.forceMove(src)
	update_icon()

/obj/structure/bed/bedbox/proc/ensure_inside()
	for(var/mob/living/M in buckled_mobs)
		if(M.loc != src)
			M.forceMove(src)

/obj/structure/bed/bedbox/post_unbuckle_mob(mob/living/M)
	. = ..()
	if(M.loc == src)
		M.forceMove(get_turf(src))
	update_icon()

/obj/structure/bed/bedbox/proc/open(mob/living/user)
	if(opened || locked)
		if(user)
			to_chat(user, span_warning("Someone else trapped themselves inside."))
		return FALSE
	playsound(loc, open_sound, open_sound_volume)
	opened = TRUE
	dump_contents()
	update_icon()
	return TRUE

/obj/structure/bed/bedbox/proc/close(mob/living/user)
	if(!opened || locked) //If this appeared, it means you managed to BREAK the bedbox, somehow.
		if(user)
			to_chat(user, span_warning("For some reason, it resist being closed."))
		return FALSE

	ensure_inside()
	for(var/mob/living/M in buckled_mobs)
		if(M.loc != src)
			M.forceMove(src)
			M.buckled = src

	playsound(loc, close_sound, close_sound_volume)
	opened = FALSE
	take_contents()
	update_icon()
	return TRUE

/obj/structure/bed/bedbox/proc/toggle(mob/living/user)
	return opened ? close(user) : open(user)

/obj/structure/bed/bedbox/attack_hand(mob/living/user)
	user.changeNext_move(CLICK_CD_MELEE)
	if(user.loc == src)
		return toggle(user)
	if(opened)
		return close(user)
	else
		return open(user)

/obj/structure/bed/bedbox/attack_paw(mob/user)
	return attack_hand(user)

/obj/structure/bed/bedbox/attack_hand_secondary(mob/living/user)
	if(opened) //Appears if open. Doesn't matter if the player is inside or not.
		to_chat(user, span_warning("You cannot force the deadbolt without closing the doors first."))
		return
	if(user.loc != src) //Should appear only when the player is not lying inside. Won't bother finding a way to differ between lying on the ground or on the bed.
		to_chat(user, span_warning("You must be lying inside to be able to lock it."))
		return
	locked = !locked
	to_chat(user, span_notice("You [locked ? "lock" : "unlock"] the bedbox from the inside."))
	return TRUE

/obj/structure/bed/bedbox/relaymove(mob/user)
	if(user.stat || !isturf(loc) || !isliving(user))
		return
	user_unbuckle_mob(user, user)

/obj/structure/bed/bedbox/user_unbuckle_mob(mob/living/M, mob/living/user)
	if(user.buckled != src)
		return

	if(locked)
		user.visible_message(span_warning("[src] crackles and rustles."))
		user.Stun(30)
		return

	. = ..()
	user.unbuckle_mob()

	if(!opened)
		open(user)

	if(user.loc == src)
		user.forceMove(get_turf(src))

	to_chat(user, span_notice("You push open the bedbox."))

/obj/structure/bed/bedbox/Exit(atom/movable/A)
	open()
	if(A.loc == src)
		return FALSE
	return TRUE

/obj/structure/bed/bedbox/Destroy()
	dump_contents()
	. = ..()

/obj/structure/bed/bedbox/proc/take_contents()
	var/atom/L = get_turf(src)
	for(var/atom/movable/AM in L)
		if(AM != src && insert(AM) == -1)
			break

/obj/structure/bed/bedbox/dump_contents()
	var/atom/L = get_turf(src)
	for(var/atom/movable/AM in contents)
		AM.forceMove(L)

/obj/structure/bed/bedbox/proc/insert(atom/movable/AM)
	if(contents.len >= storage_capacity)
		return -1
	if(insertion_allowed(AM))
		AM.forceMove(src)
		return TRUE
	return FALSE

/obj/structure/bed/bedbox/proc/insertion_allowed(atom/movable/AM)
	if(ismob(AM))
		if(!isliving(AM)) return FALSE
		var/mob/living/L = AM
		if(L.anchored || L.buckled || L.incorporeal_move || L.has_buckled_mobs())
			return FALSE
		if(contents.Find(L)) return FALSE
		if(length(contents) >= mob_storage_capacity)
			return FALSE
		L.stop_pulling()
		return TRUE
	else if(isobj(AM))
		if(AM.anchored || AM.has_buckled_mobs())
			return FALSE
	return TRUE

/obj/structure/abyssgate
	name = "gate of submergence"
	desc = "By Akhan, 3.2 'No passage is given to the desecrant. Drown the heretic, leave no bloated remains behind.'"
	icon = 'modular/kaizoku/icons/mapset/furniture_64x64.dmi'
	icon_state = "abyssgate"
	layer = ABOVE_MOB_LAYER + 10
	anchored = TRUE
	density = FALSE
	pixel_x = -16
	pixel_y = -16
	bound_width = 64
	bound_height = 64

/obj/structure/abyssgate/Initialize()
	. = ..()

	var/image/head_overlay = image(icon, "abyssgate_det")
	head_overlay.layer = ABOVE_MOB_LAYER
	head_overlay.plane = GAME_PLANE_UPPER
	head_overlay.density = TRUE

	head_overlay.pixel_x = 0
	head_overlay.pixel_y = 0
	head_overlay.appearance_flags = PIXEL_SCALE | KEEP_TOGETHER
	overlays += head_overlay

	var/obj/effect/abyssgate_sensor/S = new /obj/effect/abyssgate_sensor(get_turf(src))
	S.master = src

/obj/effect/abyssgate_sensor
	name = ""
	desc = ""
	anchored = TRUE
	density = FALSE
	layer = 2.0
	mouse_opacity = 0
	invisibility = 101 // Normally makes it always invisible. I suppose.
	var/obj/structure/abyssgate/master

/obj/effect/abyssgate_sensor/Crossed(atom/movable/A)
	if(!master || !isliving(A))
		return
	var/mob/living/L = A
	if(!L)
		return

	if(ishuman(L))
		var/mob/living/carbon/human/H = L
		if(H.dna?.species?.id == "tiefling") // Tieflings are tolerated, but not really accepted.
			to_chat(H, span_warning("By Akhang-u, 3.6 'For the verdict not yet cast to the curseborn, welcomed you are if spiritual purification is being seeked'."))
			playsound(src, pick('modular/kaizoku/sound/evil.ogg','modular/kaizoku/sound/evil2.ogg','modular/kaizoku/sound/evil3.ogg'), 35, TRUE, ignore_walls = FALSE)
			return

		if((islist(H.faction) && (FACTION_ORCS in H.faction)) || (H.mob_biotypes & MOB_UNDEAD)) //The undead and the Graggarious forces are gatekept.
			to_chat(H, span_danger("By Akhang-u, 3.2 'No heretic, zayagans and deceivers can escape thalassic judgement.'"))
			H.Immobilize(10)
			H.apply_status_effect(/datum/status_effect/debuff/frostbite)
			H.adjustFireLoss(5)
			H.Stun(20)
			playsound(src, pick('modular/kaizoku/sound/evil.ogg','modular/kaizoku/sound/evil2.ogg','modular/kaizoku/sound/evil3.ogg'), 35, TRUE, ignore_walls = FALSE)

			var/turf/origin = get_turf(H)
			var/dir_to_gate = get_dir(get_step_away(H, master), master)
			var/turf/push_dest = get_step(origin, dir_to_gate)
			if(push_dest)
				H.throw_at(push_dest, 4, 1)
			return
	to_chat(L, span_notice("By Akhang-u, 3.7 'Let the pure be praised, let the soul reaved walk again among the living, as redemption weights more than gold.'")) // All other are welcomed.
	playsound(src, pick('modular/kaizoku/sound/good.ogg','modular/kaizoku/sound/good2.ogg','modular/kaizoku/sound/good3.ogg'), 35, TRUE, ignore_walls = FALSE)

/obj/structure/fluff/railing/shojidivider
	name = "privacy screen"
	desc = "Foglander privacy divider for changing clothes."
	icon = 'modular/kaizoku/icons/mapset/furniture_32x32.dmi'
	icon_state = "shojidivider"
	density = FALSE
	anchored = TRUE
	deconstructible = FALSE
	climbable = FALSE
	dir = SOUTH
	layer = ABOVE_MOB_LAYER
	pass_crawl = FALSE
	flags_1 = ON_BORDER_1

/obj/structure/fluff/railing/shojidivider/Initialize()
	. = ..()
	dir = SOUTH
	layer = ABOVE_MOB_LAYER

/obj/structure/fluff/railing/shojidivider/OnCrafted(dirin, mob/user)
	dir = SOUTH
	layer = ABOVE_MOB_LAYER
	. = ..()

/obj/structure/fluff/railing/shojidivider/CanPass(atom/movable/mover, turf/target)
	. = ..()
	if(istype(mover, /mob/camera) || isobserver(mover) || mover.throwing || mover.movement_type & FLYING)
		return TRUE

	if(isliving(mover))
		var/mob/living/M = mover
		if(M.body_position == LYING_DOWN && pass_crawl)
			return TRUE

	var/to_dir = get_dir(loc, target)
	if(to_dir == NORTH || to_dir == SOUTH)
		return FALSE
	return TRUE

/obj/structure/fluff/railing/shojidivider/CanAStarPass(ID, to_dir, requester)
	return (to_dir != NORTH && to_dir != SOUTH)

/obj/structure/fluff/railing/frontfence/proc/checkExit(atom/movable/O, turf/target)
	if(istype(O, /obj/projectile) || isobserver(O) || O.throwing || O.movement_type & FLYING)
		return TRUE

	if(isliving(O))
		var/mob/living/M = O
		if(M.body_position == LYING_DOWN && pass_crawl)
			return TRUE

	if(get_dir(O.loc, target) == NORTH)
		return FALSE
	return TRUE

#define is_tideseeker(job_type) (istype(job_type, /datum/job/kaizoku/mastersohei) || istype(job_type, /datum/job/kaizoku/tideseeker))
//When possible, put this in Stonekeep helper.

/obj/structure/fluff/gong
	name = "ceremonial gong"
	desc = "A large metal gong suspended in a wooden frame. It looks like it could make quite the noise."
	icon = 'modular/kaizoku/icons/mapset/furniture_32x32.dmi'
	icon_state = "gong"
	anchored = TRUE
	density = TRUE
	layer = ABOVE_MOB_LAYER
	max_integrity = 150
	resistance_flags = FIRE_PROOF
	obj_flags = CAN_BE_HIT
	COOLDOWN_DECLARE(gong_ring)

/obj/structure/fluff/gong/attack_hand(mob/living/user)
	if(!COOLDOWN_FINISHED(src, gong_ring))
		to_chat(user, "<span class='warning'>The gong is still resonating.</span>")
		return

	to_chat(user, "<span class='notice'>You strike the gong. A deep, sacred tone echoes through the air.</span>")
	playsound(src, pick('modular/kaizoku/sound/gong.ogg','modular/kaizoku/sound/gong2.ogg','modular/kaizoku/sound/gong3.ogg'), 35, TRUE, ignore_walls = FALSE)

	var/oldx = pixel_x
	animate(src, pixel_x = oldx + 2, time = 0.3)
	animate(pixel_x = oldx - 2, time = 0.3)
	animate(pixel_x = oldx, time = 0.3)

	for(var/mob/living/player in GLOB.player_list)
		if(player.stat != DEAD && !isbrain(player) && is_tideseeker(player.mind?.assigned_role))
			player.playsound_local(get_turf(player), 'modular/kaizoku/sound/gong3.ogg', 60, FALSE)
			to_chat(player, "<span class='notice'>A sacred gong rings out from afar...</span>")

	COOLDOWN_START(src, gong_ring, 30 SECONDS)

/obj/machinery/light/fueled/lightbeacon
	name = "paper lantern"
	desc = "A paper lantern holding a candle inside. Simple, cheap, and can be placed anywhere that has a hoof."
	icon = 'modular/kaizoku/icons/mapset/frontierjustice.dmi'
	icon_state = "lightbeacon"
	base_state = "lightbeacon"
	density = FALSE
	anchored = TRUE
	on = FALSE
	brightness = 8
	bulb_power = 1.2
	fueluse = 0
	soundloop = null
	crossfire = FALSE
	cookonme = FALSE
	temperature_change = 10
	var/candle_lifetime = 1800 // 30 minutes

/obj/machinery/light/fueled/lightbeacon/Initialize()
	. = ..()
	if(prob(70))
		icon_state = base_state
	else
		icon_state = "[base_state]_on"
		on = TRUE
		set_light_on(TRUE)
		addtimer(CALLBACK(src, PROC_REF(burn_out)), candle_lifetime)

/obj/machinery/light/fueled/lightbeacon/attack_hand(mob/user)
	if(on)
		user.visible_message(span_warning("[user] snuffs out [src]."))
		burn_out()
	else
		user.visible_message(span_notice("[user] lights the [src]."))
		ignite()
	return

/obj/machinery/light/fueled/lightbeacon/proc/ignite()
	on = TRUE
	set_light_on(TRUE)
	icon_state = "[base_state]_on"
	playsound(loc, 'sound/items/firelight.ogg', 60)
	addtimer(CALLBACK(src, PROC_REF(burn_out)), candle_lifetime)

/obj/machinery/light/fueled/lightbeacon/burn_out()
	if(!on) return
	on = FALSE
	set_light_on(FALSE)
	icon_state = base_state
	playsound(loc, 'sound/items/firesnuff.ogg', 60)

/obj/machinery/light/fueled/lightbeacon/update_icon()
	. = ..()
	icon_state = on ? "[base_state]_on" : base_state

/turf/open/floor/rooftop/kaizoku/directional //leaving it to the mappers or someone else to play with the roof creations.
	name = "foreigner roof"
	icon = 'modular/kaizoku/icons/tileset/tilesets.dmi'
	icon_state = "browntiles"
	footstep = FOOTSTEP_WOOD
	barefootstep = FOOTSTEP_HARD_BAREFOOT
	clawfootstep = FOOTSTEP_WOOD_CLAW
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY
	damage_deflection = 8
	max_integrity = 800

/turf/open/floor/rooftop/kaizoku/directional/blue
	icon_state = "bluetiles"

/turf/open/floor/rooftop/kaizoku/directional/red
	icon_state = "redtiles"

/turf/open/floor/rooftop/kaizoku/directional/green
	icon_state = "greentiles"

/turf/open/floor/rooftop/kaizoku/central //leaving it to the mappers or someone else to play with the roof creations.
	icon_state = "bluetiles_central"

/turf/open/floor/rooftop/kaizoku/central/blue
	icon_state = "bluetiles_central"

/turf/open/floor/rooftop/kaizoku/central/red
	icon_state = "redtiles_central"

/turf/open/floor/rooftop/kaizoku/central/green
	icon_state = "greentiles_central"

/turf/open/floor/rooftop/kaizoku/horizontal //leaving it to the mappers or someone else to play with the roof creations.
	icon_state = "browntiles_hor"

/turf/open/floor/rooftop/kaizoku/horizontal/blue
	icon_state = "bluetiles_hor"

/turf/open/floor/rooftop/kaizoku/horizontal/red
	icon_state = "redtiles_hor"

/turf/open/floor/rooftop/kaizoku/horizontal/green
	icon_state = "greentiles_hor"

/turf/open/floor/rooftop/kaizoku/vertical
	icon_state = "browntiles_ver"

/turf/open/floor/rooftop/kaizoku/vertical/blue
	icon_state = "bluetiles_ver"

/turf/open/floor/rooftop/kaizoku/vertical/red
	icon_state = "redtiles_ver"

/turf/open/floor/rooftop/kaizoku/vertical/green
	icon_state = "greentiles_ver"

/obj/structure/fluff/statue/waterfall
	icon = 'modular/kaizoku/icons/tileset/tilesets.dmi'
	icon_state = "waterfall"

/obj/structure/rope/standing
	name = "fogstrand"
	desc = "Rope strung into a ceiling or an stone edge, most common among low-class foglanders. Its usage requires two hands."
	icon = 'modular/kaizoku/icons/mapset/furniture_32x64.dmi'
	icon_state = "rope"
	mouse_opacity = 1
	density = FALSE
	anchored = TRUE
	layer = EFFECTS_LAYER
	climbable = TRUE
	obj_flags = BLOCK_Z_OUT_DOWN | BLOCK_Z_IN_DOWN

	var/obj/structure/rope/standing/above
	var/obj/structure/rope/standing/below
	var/list/grabbers = list()
	var/is_top = FALSE
	var/is_bottom = FALSE

/obj/structure/rope/standing/CanPass(atom/movable/mover, border_dir)
	if(!isliving(mover))
		return ..()
	var/mob/living/M = mover
	if(M.held_rope == src)
		return TRUE
	if(M.CanAutoGrabRope())
		return TRUE
	var/turf/myturf = get_turf(src)
	if(myturf && istype(myturf, /turf/open/openspace))
		return FALSE
	return TRUE

/obj/structure/rope/standing/Initialize()
	. = ..()
	update_icon()

/obj/structure/rope/standing/update_icon()
	. = ..()
	if(is_top)
		icon_state = "rope_top"
	else if(is_bottom)
		icon_state = "rope_end"
	else
		icon_state = "rope"

/obj/structure/rope/standing/Destroy()
	for(var/mob/living/M as anything in grabbers.Copy())
		if(M && M.held_rope == src)
			M.ReleaseRope()
	grabbers = null
	return ..()

/obj/structure/rope/standing/Crossed(atom/movable/AM)
	. = ..()
	if(!isliving(AM))
		return
	var/mob/living/M = AM
	if(M.held_rope)
		if(M.held_rope != src)
			M.SwappingSegments(src)
		return
	if(M.CanAutoGrabRope())
		M.GrabRope(src)

/obj/structure/rope/standing/proc/_on_grab(mob/living/M)
	if(!(M in grabbers)) grabbers += M

/obj/structure/rope/standing/proc/_on_release(mob/living/M)
	if(M in grabbers) grabbers -= M


/obj/structure/rope/anchor
	name = "fogstrand anchor"
	desc = "Rope strung into a ceiling or an stone edge. If this is broken, the entire thing will fall."
	icon = 'modular/kaizoku/icons/mapset/furniture_32x64.dmi'
	icon_state = "rope_anchor"
	density = FALSE
	anchored = TRUE
	layer = EFFECTS_LAYER
	max_integrity = 120
	var/list/segments = list()

/obj/structure/rope/anchor/Initialize()
	. = ..()
	_build_chain()

/obj/structure/rope/anchor/Destroy()
	for(var/obj/structure/rope/standing/R in segments)
		qdel(R)
	segments = null
	return ..()

/obj/structure/rope/anchor/proc/_build_chain()
	var/turf/T = get_turf(src)
	if(!T)
		return
	var/obj/structure/rope/standing/top = new /obj/structure/rope/standing(T)
	top.is_top = TRUE
	top.update_icon()
	segments += top
	var/Zlevel_autism = T.z
	var/obj/structure/rope/standing/prev = top
	while(TRUE)
		var/turf/down = locate(T.x, T.y, Zlevel_autism-1)
		if(!down)
			break
		if(!istype(down, /turf/open))
			break
		var/obj/structure/rope/standing/R = new /obj/structure/rope/standing(down)
		R.above = prev
		prev.below = R
		segments += R
		Zlevel_autism--
		prev = R
	if(prev)
		prev.is_bottom = TRUE
		prev.update_icon()


/obj/item/rope_grip
	name = "rope grip"
	icon = 'modular/kaizoku/icons/mapset/furniture_32x64.dmi'
	icon_state = "rope_left"
	mouse_opacity = 0
	w_class = WEIGHT_CLASS_GIGANTIC
	item_flags = ABSTRACT | DROPDEL
	possible_item_intents = list(/datum/intent/rope/up, /datum/intent/rope/down)

/// left
/obj/item/rope_grip/l
	icon_state = "rope_left"
	possible_item_intents = list(/datum/intent/rope/up, /datum/intent/rope/down)

/// right
/obj/item/rope_grip/r
	icon_state = "rope_right"
	possible_item_intents = list(/datum/intent/rope/up, /datum/intent/rope/down)

/// You pinkly handlers trying to grab stuff.
/obj/item/rope_grip/attack_hand(mob/user)
	return

/obj/item/rope_grip/attack_self(mob/user)
	return

/obj/item/rope_grip/examine(mob/user)
	return list(span_info("I find myself staring down into my own hands. Why I am doing that?"))

/obj/item/rope_grip/Initialize()
	. = ..()
	ADD_TRAIT(src, TRAIT_NODROP, CURSED_ITEM_TRAIT)
	return .

/obj/item/rope_grip/dropped(mob/living/carbon/human/user)
	. = ..()
	if(QDELETED(src))
		return
	qdel(src)

/obj/item/rope_grip/attack(atom/target, mob/living/carbon/human/user)
	if(!user?.held_rope)
		return
	if(user.used_intent?.type == /datum/intent/rope/up)
		return climb_up_rope(user)
	if(user.used_intent?.type == /datum/intent/rope/down)
		return climb_down_rope(user)
	return

/obj/item/rope_grip/proc/climb_up_rope(mob/living/carbon/human/user)
	if(!user.held_rope)
		return
	var/obj/structure/rope/standing/target_segment = user.held_rope.above
	if(target_segment)
		var/turf/target_segment_turf = get_turf(target_segment)
		if(!target_segment_turf)
			to_chat(user, span_warning("I can't climb there."))
			return
		to_chat(user, span_notice("I start climbing up the rope..."))
		if(do_after(user, 5 SECONDS, target = user.held_rope))
			user.forceMove(target_segment_turf)
			user.SwappingSegments(target_segment)
			to_chat(user, span_notice("I climb up the rope."))
		return
	var/turf/rope_turf = get_turf(user.held_rope)
	var/turf/ledge_turf = get_step_multiz(rope_turf, UP)
	if(ledge_turf && !istype(ledge_turf, /turf/open))
		to_chat(user, span_notice("I start climbing up onto the ledge..."))
		if(do_after(user, 5 SECONDS, target = user.held_rope))
			user.ReleaseRope()
			user.forceMove(ledge_turf)
			to_chat(user, span_notice("I pull myself up onto the ledge."))
		return
	to_chat(user, span_warning("There is no rope above to climb to."))

/obj/item/rope_grip/proc/climb_down_rope(mob/living/carbon/human/user)
	if(!user.held_rope)
		return
	var/obj/structure/rope/standing/target_segment = user.held_rope.below
	if(target_segment)
		var/turf/target_segment_turf = get_turf(target_segment)
		if(target_segment_turf)
			to_chat(user, span_notice("I start climbing down the rope..."))
			if(do_after(user, 5 SECONDS, target = user.held_rope))
				user.forceMove(target_segment_turf)
				user.SwappingSegments(target_segment)
				to_chat(user, span_notice("I climb down the rope."))
			return
	var/turf/rope_turf = get_turf(user.held_rope)
	var/turf/ground_turf = get_step_multiz(rope_turf, DOWN)
	if(ground_turf && !istype(ground_turf, /turf/open))
		to_chat(user, span_notice("My grip loosens, heading down to the ground."))
		if(do_after(user, 5 SECONDS, target = user.held_rope))
			user.ReleaseRope()
			user.forceMove(ground_turf)
			to_chat(user, span_notice("I step off the rope."))
		return
	to_chat(user, span_redtext("Oh SHIT!!! FUCK!!!"))
	user.ReleaseRope()
	var/turf/fall_turf = get_step_multiz(get_turf(user), DOWN)
	if(fall_turf && istype(get_turf(user), /turf/open/openspace))
		user.forceMove(fall_turf)


/datum/intent/rope
	name = "rope"
	icon_state = "inuse"
	chargetime = 0
	noaa = TRUE
	candodge = FALSE
	canparry = FALSE
	misscost = 0
	no_attack = TRUE
	releasedrain = 0
	blade_class = BCLASS_PUNCH
	item_damage_type = "blunt"

/datum/intent/rope/up
	name = "climb up"
	icon_state = "inup"
	desc = "Climb up the rope"

/datum/intent/rope/down
	name = "climb down"
	icon_state = "indown"
	desc = "Climb down the rope or let go"


/mob/living
	var/obj/structure/rope/standing/held_rope
	var/last_rope_fail_time = 0
	var/rope_last_release_time = 0
	var/turf/rope_last_release_turf = null

/mob/living/proc/HandsAreFree()
	for(var/obj/item/I in held_items)
		if(!istype(I, /obj/item/rope_grip))
			return FALSE
	return TRUE

/mob/living/proc/CanAutoGrabRope()
	if(stat)
		return FALSE
	if(lying_angle)
		return FALSE
	if(buckled)
		return FALSE
	if(!HandsAreFree())
		return FALSE
	return TRUE

/mob/living/proc/RopeClearHands()
	for(var/obj/item/rope_grip/G in held_items)
		qdel(G)

/mob/living/proc/RopeFailOnce(obj/structure/rope/standing/R)
	if(world.time >= last_rope_fail_time + 5)
		to_chat(src, span_warning("You fail to hold the rope!"))
		last_rope_fail_time = world.time

/mob/living/proc/CancelYourself()
	if(hascall(src, "stop_throw"))
		call(src, "stop_throw")()
	throwing = null
	inertia_dir = 0

/mob/living/proc/GrabRope(obj/structure/rope/standing/R)
	if(!R || held_rope)
		return FALSE
	if(!CanAutoGrabRope())
		return FALSE
	RopeClearHands()
	var/obj/item/rope_grip/l/L = new
	var/obj/item/rope_grip/r/Ri = new
	if(ishuman(src))
		var/mob/living/carbon/human/H = src
		if(hascall(H, "put_in_l_hand"))
			call(H, "put_in_l_hand")(L)
		else
			H.put_in_hands(L)
		if(hascall(H, "put_in_r_hand"))
			call(H, "put_in_r_hand")(Ri)
		else
			H.put_in_hands(Ri)
	else
		put_in_hands(L)
		put_in_hands(Ri)
	var/obj/item/active_item = get_active_held_item()
	var/obj/item/inactive_item = get_inactive_held_item()
	if(!(istype(active_item, /obj/item/rope_grip) && istype(inactive_item, /obj/item/rope_grip)))
		if(L) qdel(L)
		if(Ri) qdel(Ri)
		return FALSE
	held_rope = R
	R._on_grab(src)
	CancelYourself()
	var/turf/rope_turf = get_turf(R)
	if(rope_turf && loc != rope_turf)
		forceMove(rope_turf)
	to_chat(src, span_notice("I grab onto the rope."))
	return TRUE

/mob/living/proc/ReleaseRope()
	if(!held_rope)
		return
	var/turf/rope_turf = get_turf(held_rope)
	rope_last_release_turf = rope_turf
	rope_last_release_time = world.time
	RopeClearHands()
	held_rope._on_release(src)
	held_rope = null
	to_chat(src, span_notice("I let go of the rope."))

/mob/living/proc/SwappingSegments(obj/structure/rope/standing/R)
	if(!held_rope)
		return
	if(!R)
		ReleaseRope()
		return
	if(R == held_rope)
		return
	held_rope._on_release(src)
	held_rope = R
	held_rope._on_grab(src)

/mob/living/Move(newloc, dir=0, step_x=0, step_y=0)
	var/oldloc = loc
	. = ..()
	if(!held_rope)
		return
	if(loc == oldloc)
		return
	if(held_rope && held_rope.loc == loc)
		return
	var/obj/structure/rope/standing/segment_here = locate(/obj/structure/rope/standing) in loc
	if(segment_here)
		SwappingSegments(segment_here)
	else
		ReleaseRope()

/mob/living/proc/ThrownYourself()
	if(!throwing)
		return null
	var/datum/thrownthing/throw_info = istype(throwing, /datum/thrownthing) ? throwing : null
	if(!throw_info)
		return null
	var/list/varmap = throw_info.vars
	if(!islist(varmap))
		return null
	var/list/keys = list("target", "destination", "end", "target_turf", "target_loc")
	for(var/k in keys)
		if(k in varmap)
			var/val = varmap[k]
			if(isatom(val))
				return val
	return null

/mob/living/proc/GrabThatRopeMan()
	if(!throwing)
		return FALSE
	if(held_rope)
		return FALSE
	if(!CanAutoGrabRope())
		return FALSE
	var/turf/current_turf = get_turf(src)
	if(!current_turf)
		return FALSE
	var/atom/throw_target = ThrownYourself()
	var/turf/target_turf = throw_target ? get_turf(throw_target) : null
	var/primary_dir = target_turf ? get_dir(current_turf, target_turf) : inertia_dir
	if(!primary_dir)
		primary_dir = dir
	var/list/candidate_turfs = list(current_turf)
	var/turf/forward_turf = null
	if(primary_dir)
		forward_turf = get_step(current_turf, primary_dir)
		if(forward_turf)
			candidate_turfs += forward_turf
		var/turf/left_turf = forward_turf ? get_step(forward_turf, turn(primary_dir, 90)) : null
		var/turf/right_turf = forward_turf ? get_step(forward_turf, turn(primary_dir, -90)) : null
		if(left_turf)
			candidate_turfs += left_turf
		if(right_turf)
			candidate_turfs += right_turf
	for(var/turf/check_turf in candidate_turfs)
		if(rope_last_release_turf && world.time < rope_last_release_time + 5)
			if(check_turf == rope_last_release_turf)
				continue
		var/obj/structure/rope/standing/segment = locate(/obj/structure/rope/standing) in check_turf
		if(segment)
			CancelYourself()
			forceMove(check_turf)
			GrabRope(segment)
			return TRUE
	return FALSE
