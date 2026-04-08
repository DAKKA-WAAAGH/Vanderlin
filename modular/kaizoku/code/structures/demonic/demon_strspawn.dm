/datum/structure_slot
	var/slot_type
	var/occupied = FALSE
	var/reserved = FALSE
	var/obj/structure/demon/child_structure = null
	var/obj/structure/demon/cocoon/reserving_cocoon = null
	var/atom/owner = null

/datum/structure_slot/New(slot_name, owner_ref)
	slot_type = slot_name
	owner = owner_ref

/datum/structure_slot/proc/is_available()
	return !occupied && !reserved && (!child_structure || QDELETED(child_structure))

/datum/structure_slot/proc/fill_slot(obj/structure/demon/S)
	occupied = TRUE
	reserved = FALSE
	reserving_cocoon = null
	child_structure = S
	S.parent_slot = src

/datum/structure_slot/proc/reserve_for_cocoon(obj/structure/demon/cocoon/Cc)
	reserved = TRUE
	reserving_cocoon = Cc

/datum/structure_slot/proc/clear_reservation()
	reserved = FALSE
	reserving_cocoon = null

/datum/structure_slot/proc/clear_slot()
	occupied = FALSE
	if(child_structure && !QDELETED(child_structure))
		child_structure.parent_slot = null
	child_structure = null

//The main structure for demonz
/obj/structure/demon
	var/unholy = TRUE
	var/is_second_colony = FALSE
	var/datum/structure_slot/parent_slot = null

/* Stuff for later. Unfinished right now.
/obj/structure/demon/proc/reagent_act(datum/reagent/R, amount)
	if(istype(R, /datum/reagent/water/holywater))
		qdel(src)
		return
*/
/obj/structure/demon/Destroy()
	if(parent_slot)
		parent_slot.clear_slot()
	return ..()

/obj/structure/demon/proc/_apply_damage(amount)
	atom_integrity = max(0, (atom_integrity || max_integrity) - max(0, round(amount)))
	if(atom_integrity <= 0)
		qdel(src)

/obj/structure/demon/proc/_finalize_corruption_spawn(target, P, source_for_dir, anim)
	var/turf/T = target
	if(!T || QDELETED(src))
		return
	var/obj/structure/demon/expansion/CoreP = P
	var/obj/effect/temp_visual/expanding_corruption/A = anim
	var/obj/effect/demon/corruption/C = new /obj/effect/demon/corruption(T)
	C.parent_core = CoreP
	var/atom/from_atom = source_for_dir
	if(!from_atom)
		from_atom = src
	for(var/direction in GLOB.alldirs)
		var/turf/N = get_step(T, direction)
		if(!N)
			continue
		var/obj/effect/demon/corruption/Nc = locate(/obj/effect/demon/corruption) in N
		if(Nc && (!CoreP || Nc.parent_core == CoreP))
			from_atom = Nc
			break
	C.dir = get_dir(from_atom, T)
	C.update_icon()
	C.refresh_neighbors()
	if(A && !QDELETED(A))
		qdel(A)

/obj/structure/demon/proc/within_square_bounds(turf/T)
	return (abs(T.x - src.x) <= DEMON_SPREAD_RADIUS) && (abs(T.y - src.y) <= DEMON_SPREAD_RADIUS)

/obj/structure/demon/proc/get_organized_spread_candidates(obj/structure/demon/expansion/parent = null)
	var/list/candidates = list()
	var/list/corruption_tiles = list()
	if(parent)
		for(var/obj/effect/demon/corruption/Cp in range(DEMON_SPREAD_RADIUS, src))
			if(Cp.parent_core == parent)
				corruption_tiles += Cp
	else
		for(var/obj/effect/demon/corruption/Cu in range(DEMON_SPREAD_RADIUS, src))
			if(isnull(Cu.parent_core))
				corruption_tiles += Cu

	if(!corruption_tiles.len)
		for(var/dir_card3 in GLOB.demon_spread_dirs)
			var/turf/Tcand = get_step(src, dir_card3)
			if(is_valid_corruption_turf(Tcand) && within_square_bounds(Tcand))
				candidates += Tcand
		return candidates

	for(var/obj/effect/demon/corruption/Cl in corruption_tiles)
		for(var/dir_card4 in GLOB.demon_spread_dirs)
			var/turf/Tn = get_step(Cl, dir_card4)
			if(is_valid_corruption_turf(Tn) && within_square_bounds(Tn))
				if(!(Tn in candidates))
					candidates += Tn
	return candidates
