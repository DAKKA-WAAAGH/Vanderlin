/obj/structure/demon/gateway
	name = "CARCINOMA"
	desc = "... Malignant epithelical tumor, throbs in black ichor, connective tissues feeding the hive like a living idol...THE SOURCE OF ALL..."
	icon = 'modular/kaizoku/icons/mapset/carcinoma_64x64.dmi'
	icon_state = "carcinoma"
	max_integrity = 500
	anchored = TRUE
	density = TRUE
	layer = OBJ_LAYER
	var/corruption_spread_timer = 0
	var/last_core_seed = 0
	var/list/datum/structure_slot/structure_slots = list()
	var/next_structure_spawn = 0

/obj/structure/demon/gateway/attackby(obj/item/I, mob/user, params)
	. = ..()
	if(QDELETED(src))
		return
	if(prob(30))
		playsound(get_turf(src), 'modular/kaizoku/sound/misc/gods/astrata_scream.ogg', 85, FALSE)
		for(var/mob/living/M in oview(1, src))
			M.Knockdown(30)
			shake_camera(M, 4, 3)
		visible_message("<span class='danger'>[src] screams!</span>")

/obj/structure/demon/gateway/Initialize()
	. = ..()
	if(!DEMON_HIVE)
		DEMON_HIVE = new
	DEMON_HIVE.gateway = src
	for(var/mob/living/carbon/human/TSeek in world)
		if(TSeek.job == "Tideseeker")
			to_chat(TSeek, "<span class='cult'><font size=5>I LIVE AGAIN, LITTLE TIDER</font></span>")
	// (slot setup unchanged)
	structure_slots = list()
	structure_slots += new /datum/structure_slot("tendril", src)
	structure_slots += new /datum/structure_slot("turret", src)
	structure_slots += new /datum/structure_slot("spawner", src)
	structure_slots += new /datum/structure_slot("mine", src)
	structure_slots += new /datum/structure_slot("mine", src)
	structure_slots += new /datum/structure_slot("spawner", src)
	structure_slots += new /datum/structure_slot("turret", src)
	structure_slots += new /datum/structure_slot("tentacle", src)
	structure_slots += new /datum/structure_slot("tentacle", src)
	structure_slots += new /datum/structure_slot("tentacle", src)

	if(!DEMON_HIVE.is_active)
		DEMON_HIVE.start(get_turf(src))
	corruption_spread_timer = world.time
	next_structure_spawn = world.time + 30 SECONDS
	spread_corruption()
	return .

/obj/structure/demon/gateway/proc/spawn_next_structure()
	if(QDELETED(src) || !DEMON_HIVE || !DEMON_HIVE.is_active)
		return

	var/datum/structure_slot/available_slot = null
	for(var/datum/structure_slot/SL in structure_slots)
		if(SL.is_available())
			available_slot = SL
			break
	if(!available_slot)
		return

	// Collect raw ichor tiles around the gateway (no spacing filter yet)
	var/list/spawn_spots = list()
	for(var/turf/T in range(4, src))
		if(T && !T.density && !(locate(/obj/structure/demon) in T) && (locate(/obj/effect/demon/corruption) in T))
			spawn_spots += T
	if(!spawn_spots.len)
		return

	var/turf/spot = null

	if(available_slot.slot_type == "tendril")
		// Tendrils (MESOTHELIOMA) should be pretty much huging the gateway.
		// Pick the closest ichor tile within 2 tiles, then fallback to the nearest autism I made
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
		// Non-tendrils STILL respect spacing and prefer spread-out placement, different of TENDRILS.
		var/list/spaced = list()
		for(var/turf/Ts in spawn_spots)
			if(is_good_structure_spot(Ts))
				spaced += Ts
		if(!spaced.len)
			return
		spot = pick_spread_out_spot(spaced)

	if(available_slot.slot_type == "tendril")
		var/obj/structure/demon/tentacle/Ten = new /obj/structure/demon/tentacle(spot)
		available_slot.fill_slot(Ten)
	else
		var/obj/structure/demon/cocoon/Cc = new(spot)
		Cc.cocoon_type = available_slot.slot_type
		Cc.target_slot = available_slot
		Cc.maturation_time = 60 SECONDS
		available_slot.reserve_for_cocoon(Cc)

	next_structure_spawn = world.time + 45 SECONDS

/obj/structure/demon/gateway/proc/spread_corruption()
	if(QDELETED(src) || !DEMON_HIVE || !DEMON_HIVE.is_active)
		return

	var/list/cands = get_organized_spread_candidates()
	if(cands.len)
		var/turf/Tpick = cands[1]
		spawn_corruption_with_animation(Tpick, null, src)

	try_seed_core_edge()

	if(world.time >= next_structure_spawn)
		spawn_next_structure()

	var/next = DEMON_HIVE ? DEMON_HIVE.next_spread_delay(6) : 6
	call_later(CALLBACK(src, /obj/structure/demon/gateway/proc/spread_corruption), next)

/obj/structure/demon/gateway/proc/try_seed_core_edge()
	if(DEMON_HIVE && DEMON_HIVE.cores && DEMON_HIVE.cores.len >= DEMON_HIVE_MAX_CORES)
		return
	if(world.time < last_core_seed + DEMON_CORE_SEED_COOLDOWN)
		return
	var/minx = 1e9, miny = 1e9, maxx = -1e9, maxy = -1e9
	var/list/owned = list()
	for(var/obj/effect/demon/corruption/Cov in range(DEMON_SPREAD_RADIUS, src))
		if(!isnull(Cov.parent_core))
			continue
		owned += Cov
		if(Cov.x < minx)
			minx = Cov.x
		if(Cov.y < miny)
			miny = Cov.y
		if(Cov.x > maxx)
			maxx = Cov.x
		if(Cov.y > maxy)
			maxy = Cov.y
	if(!owned.len)
		return
	var/w = (maxx - minx + 1)
	var/h = (maxy - miny + 1)
	if(w < DEMON_CORE_BOX_NEWCORE && h < DEMON_CORE_BOX_NEWCORE)
		return
	if(!prob(15))
		return

	var/list/spots = list()
	for(var/obj/effect/demon/corruption/Cov2 in owned)
		if(get_dist(src, Cov2) < MIN_CORE_DISTANCE)
			continue

		var/too_close_to_core = FALSE
		for(var/obj/structure/demon/expansion/existing_core in DEMON_HIVE.cores)
			if(get_dist(existing_core, Cov2) < MIN_CORE_DISTANCE)
				too_close_to_core = TRUE
				break
		if(too_close_to_core)
			continue

		if(Cov2.x == minx)
			var/turf/Tw = locate(Cov2.x - 1, Cov2.y, Cov2.z)
			if(Tw && !Tw.density && !(locate(/obj/structure/demon) in Tw) && !(locate(/obj/effect/demon/corruption) in Tw))
				if(is_good_structure_spot(Tw))
					spots += Tw
		if(Cov2.x == maxx)
			var/turf/Te = locate(Cov2.x + 1, Cov2.y, Cov2.z)
			if(Te && !Te.density && !(locate(/obj/structure/demon) in Te) && !(locate(/obj/effect/demon/corruption) in Te))
				if(is_good_structure_spot(Te))
					spots += Te
		if(Cov2.y == miny)
			var/turf/Ts = locate(Cov2.x, Cov2.y - 1, Cov2.z)
			if(Ts && !Ts.density && !(locate(/obj/structure/demon) in Ts) && !(locate(/obj/effect/demon/corruption) in Ts))
				if(is_good_structure_spot(Ts))
					spots += Ts
		if(Cov2.y == maxy)
			var/turf/Tn = locate(Cov2.x, Cov2.y + 1, Cov2.z)
			if(Tn && !Tn.density && !(locate(/obj/structure/demon) in Tn) && !(locate(/obj/effect/demon/corruption) in Tn))
				if(is_good_structure_spot(Tn))
					spots += Tn
	if(!spots.len)
		return

	var/obj/structure/demon/cocoon/Cc_new = new /obj/structure/demon/cocoon(pick_spread_out_spot(spots))
	Cc_new.cocoon_type = "core"
	Cc_new.maturation_time = 120 SECONDS
	last_core_seed = world.time
