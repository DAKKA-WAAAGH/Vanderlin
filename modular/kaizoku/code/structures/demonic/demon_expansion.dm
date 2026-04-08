// ---------------------------------------------------
// Core (Sarcoma)
// ---------------------------------------------------

/obj/structure/demon/expansion
	name = "SARCOMA"
	desc = "... malignant tumors of connective tissue with twisted folds resulting in a strangely feminine frame... an open womb."
	icon = 'modular/kaizoku/icons/mapset/carcinoma_64x64.dmi'
	icon_state = "thewomb"
	max_integrity = 300
	anchored = TRUE
	density = TRUE
	layer = OBJ_LAYER
	var/corruption_spread_timer = 0
	var/corruption_count = 0
	var/max_corruption = 25
	var/placed_railings = FALSE
	var/list/datum/structure_slot/structure_slots = list()
	var/next_structure_spawn = 0

/obj/structure/demon/expansion/Initialize()
	. = ..()
	if(!DEMON_HIVE)
		DEMON_HIVE = new
	DEMON_HIVE.on_core_created(src)

	structure_slots = list()
	structure_slots += new /datum/structure_slot("tendril", src)
	structure_slots += new /datum/structure_slot("turret", src)
	structure_slots += new /datum/structure_slot("spawner", src)
	structure_slots += new /datum/structure_slot("mine", src)
	structure_slots += new /datum/structure_slot("mine", src)
	structure_slots += new /datum/structure_slot("spawner", src)
	structure_slots += new /datum/structure_slot("tentacle", src)
	structure_slots += new /datum/structure_slot("tentacle", src)
	structure_slots += new /datum/structure_slot("tentacle", src)

	corruption_spread_timer = world.time
	next_structure_spawn = world.time + 45 SECONDS
	spread_corruption()
	return .

/obj/structure/demon/expansion/Destroy()
	if(DEMON_HIVE)
		DEMON_HIVE.on_core_destroyed(src)
	return ..()

/obj/structure/demon/expansion/proc/upgrade_to_second_colony()
	if(is_second_colony)
		return
	is_second_colony = TRUE
	max_integrity = round(max_integrity * 1.5)
	atom_integrity = max_integrity
	max_corruption = 40
	visible_message("<span class='danger'>[src]'s tissue pulses and restructures into a sturdier frame.</span>")

/obj/structure/demon/expansion/attackby(obj/item/I, mob/user, params)
	. = ..()
	if(QDELETED(src))
		return
	if(prob(15))
		playsound(get_turf(src), 'sound/misc/gods/astrata_scream.ogg', 85, FALSE)
		for(var/mob/living/M in oview(1, src))
			M.Knockdown(30)
			shake_camera(M, 4, 3)
		visible_message("<span class='danger'>[src] screams!</span>")

/obj/structure/demon/expansion/proc/spawn_next_structure()
	if(QDELETED(src) || !DEMON_HIVE || !DEMON_HIVE.is_active)
		return

	var/datum/structure_slot/available_slot = null
	for(var/datum/structure_slot/SLc in structure_slots)
		if(SLc.is_available())
			available_slot = SLc
			break
	if(!available_slot)
		return

	// Collect raw ichor tiles owned by this core (no spacing filter yet)
	var/list/spawn_spots = list()
	for(var/obj/effect/demon/corruption/C in range(3, src))
		if(C.parent_core == src && !(locate(/obj/structure/demon) in C.loc))
			spawn_spots += C.loc
	if(!spawn_spots.len)
		return

	var/turf/spot = null

	if(available_slot.slot_type == "tendril")
		// Core tendrils hug their owning core.
		var/turf/best = null
		var/best_dist = 1e9
		for(var/turf/Tnear in spawn_spots)
			var/d = get_dist(src, Tnear)
			if(d <= 2 && d < best_dist)
				best_dist = d
				best = Tnear
		if(!best)
			for(var/turf/Tnear2 in spawn_spots)
				var/d2 = get_dist(src, Tnear2)
				if(d2 < best_dist)
					best_dist = d2
					best = Tnear2
		spot = best
	else
		var/list/spaced = list()
		for(var/turf/Ts in spawn_spots)
			if(is_good_structure_spot(Ts))
				spaced += Ts
		if(!spaced.len)
			return
		spot = pick_spread_out_spot(spaced)

	if(available_slot.slot_type == "tendril")
		var/obj/structure/demon/tentacle/Ten2 = new /obj/structure/demon/tentacle(spot)
		available_slot.fill_slot(Ten2)
	else
		var/obj/structure/demon/cocoon/Cc4 = new(spot)
		Cc4.cocoon_type = available_slot.slot_type
		Cc4.target_slot = available_slot
		Cc4.maturation_time = 60 SECONDS
		available_slot.reserve_for_cocoon(Cc4)

	next_structure_spawn = world.time + 60 SECONDS

/obj/structure/demon/expansion/proc/spread_corruption()
	if(QDELETED(src) || !DEMON_HIVE || !DEMON_HIVE.is_active)
		return

	var/list/cands = get_organized_spread_candidates(src)
	if(cands.len && corruption_count < max_corruption)
		var/turf/Tpick = cands[1]
		var/atom/source_for_dir = src

		for(var/dir_all in GLOB.demon_all_dirs)
			var/turf/Nt = get_step(Tpick, dir_all)
			if(!Nt) continue
			var/obj/effect/demon/corruption/Nc = locate(/obj/effect/demon/corruption) in Nt
			if(Nc && Nc.parent_core == src)
				source_for_dir = Nc
				break

		spawn_corruption_with_animation(Tpick, src, source_for_dir)
		corruption_count++

	if(corruption_count >= max_corruption && !placed_railings)
		placed_railings = TRUE
		place_railings_around_own_corruption()

	if(world.time >= next_structure_spawn)
		spawn_next_structure()

	var/next = DEMON_HIVE ? DEMON_HIVE.next_spread_delay(8) : 8
	call_later(CALLBACK(src, /obj/structure/demon/expansion/proc/spread_corruption), next)

/obj/structure/demon/expansion/proc/place_railings_around_own_corruption()
	for(var/obj/effect/demon/corruption/CorOwn in range(DEMON_SPREAD_RADIUS, src))
		if(CorOwn.parent_core != src)
			continue
		for(var/dir_card5 in GLOB.demon_spread_dirs)
			var/turf/Tb = get_step(CorOwn, dir_card5)
			if(!Tb)
				continue
			if(!(locate(/obj/effect/demon/corruption) in Tb))
				if(!(locate(/obj/structure/demon/railing) in CorOwn.loc))
					var/obj/structure/demon/railing/Rown = new(CorOwn.loc)
					Rown.dir = dir_card5
