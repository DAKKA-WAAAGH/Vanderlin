/obj/effect/demon/corruption
	name = "METASTASIS"
	desc = "Viscous black ichor crawling over the ground."
	icon = 'modular/kaizoku/icons/mapset/carcinoma_32x32.dmi'
	icon_state = "ichor_single"
	layer = DECAL_LAYER
	anchored = TRUE
	density = FALSE
	mouse_opacity = MOUSE_OPACITY_ICON
	var/health = 40
	var/max_health = 40
	var/obj/structure/demon/expansion/parent_core = null
	var/unholy = TRUE
	var/list/edge_objs = null
	var/full_variant = 0

/obj/effect/demon/corruption/Initialize()
	. = ..()
	if(GLOB.DEMON_HIVE)
		GLOB.DEMON_HIVE.on_corruption_created(src)
	update_icon()
	refresh_neighbors()
	update_edges()

/obj/effect/demon/corruption/Destroy()
	refresh_neighbors()
	clear_edge_overlays()
	if(GLOB.DEMON_HIVE)
		GLOB.DEMON_HIVE.on_corruption_destroyed(src)
	return ..()

/obj/effect/demon/corruption/attackby(obj/item/I, mob/user)
	if(!I)
		return
	var/damage = (I.force >= 8) ? rand(6,12) : 0
	if(!damage)
		return
	shake_camera(user, 2, 1)
	playsound(get_turf(src), 'sound/foley/meatslap.ogg', 50, TRUE)
	health -= damage
	if(health <= 0)
		qdel(src)

/obj/effect/demon/corruption/Crossed(atom/movable/AM)
	. = ..()
	if(isliving(AM))
		var/mob/living/L = AM
		if(FACTION_CABAL in (L.faction || list()))
			return
		if(!(L.mob_biotypes & MOB_SPIRIT))
			if(world.time >= (L.ichor_next_burn_tick || 0))
				L.adjustFireLoss(rand(2,4))
				to_chat(L, "<span class='warning'>The ichor sears your skin.</span>")
				L.ichor_next_burn_tick = world.time + 20

/obj/effect/demon/corruption/take_damage(amount, damage_type)
	. = ..()
	health -= max(0, amount)
	if(health <= 0)
		qdel(src)

/obj/effect/demon/corruption/proc/has_neighbor(D)
	var/turf/Tnb = get_step(src, D)
	if(!Tnb)
		return FALSE
	if(locate(/obj/structure/demon) in Tnb)
		return FALSE
	return !!(locate(/obj/effect/demon/corruption) in Tnb)

/obj/effect/demon/corruption/proc/refresh_neighbors()
	for(var/D in GLOB.alldirs)
		var/turf/T = get_step(src, D)
		if(!T)
			continue
		for(var/obj/effect/demon/corruption/C in T)
			C.update_icon()
			C.update_edges()
	update_edges()

/obj/effect/demon/corruption/update_icon()
	. = ..()
	var/n = has_neighbor(NORTH)
	var/e = has_neighbor(EAST)
	var/s = has_neighbor(SOUTH)
	var/w = has_neighbor(WEST)
	var/count = (n?1:0) + (e?1:0) + (s?1:0) + (w?1:0)
	if(count <= 0)
		icon_state = "ichor_single"
		dir = SOUTH
		return
	if(count == 1)
		icon_state = "ichor_end"
		if(n)      dir = NORTH
		else if(e) dir = EAST
		else if(s) dir = SOUTH
		else       dir = WEST
		return
	if(count == 2)
		if((n && s) || (e && w))
			icon_state = "ichor_straight"
			dir = (n && s) ? NORTH : EAST
		else
			icon_state = "ichor_curve"
			if(n && e)      dir = NORTHEAST
			else if(e && s) dir = SOUTHEAST
			else if(s && w) dir = SOUTHWEST
			else            dir = NORTHWEST
		return
	if(count == 3)
		icon_state = "ichor_t"
		if(!n)      dir = NORTH
		else if(!e) dir = EAST
		else if(!s) dir = SOUTH
		else        dir = WEST
		return
	if(!full_variant)
		full_variant = rand(1,7)
	icon_state = "ichor_full[full_variant]"
	dir = SOUTH
	update_edges()

/obj/effect/demon/corruption/proc/clear_edge_overlays()
	if(!edge_objs)
		return
	for(var/obj/effect/decal/corruption_rim/R in edge_objs)
		if(!QDELETED(R))
			R.remove_supporter()
	edge_objs.Cut()

/obj/effect/demon/corruption/proc/_neighbor_has_corruption(turf/T)
	if(!T)
		return FALSE
	if(locate(/obj/structure/demon) in T)
		return FALSE
	return !!(locate(/obj/effect/demon/corruption) in T)

/obj/effect/demon/corruption/proc/_ensure_rim_on(turf/T, typepath, dirval)
	if(!T)
		return null
	for(var/obj/effect/decal/corruption_rim/R in T)
		if(istype(R, typepath) && R.dir == dirval)
			R.add_supporter()
			return R
	var/obj/effect/decal/corruption_rim/N = new typepath(T, dirval)
	return N

/obj/effect/demon/corruption/proc/update_edges()
	var/turf/T = get_turf(src)
	if(!T)
		return
	clear_edge_overlays()
	edge_objs = list()
	var/has_N = has_neighbor(NORTH)
	var/has_S = has_neighbor(SOUTH)
	var/has_E = has_neighbor(EAST)
	var/has_W = has_neighbor(WEST)
	if(!has_N)
		var/turf/Nt = get_step(T, NORTH)
		if(Nt)
			var/obj/effect/decal/corruption_edge/E1 = _ensure_rim_on(Nt, /obj/effect/decal/corruption_edge, SOUTH)
			if(E1) edge_objs += E1
	if(!has_S)
		var/turf/St = get_step(T, SOUTH)
		if(St)
			var/obj/effect/decal/corruption_edge/E2 = _ensure_rim_on(St, /obj/effect/decal/corruption_edge, NORTH)
			if(E2) edge_objs += E2
	if(!has_E)
		var/turf/Et = get_step(T, EAST)
		if(Et)
			var/obj/effect/decal/corruption_edge/E3 = _ensure_rim_on(Et, /obj/effect/decal/corruption_edge, WEST)
			if(E3) edge_objs += E3
	if(!has_W)
		var/turf/Wt = get_step(T, WEST)
		if(Wt)
			var/obj/effect/decal/corruption_edge/E4 = _ensure_rim_on(Wt, /obj/effect/decal/corruption_edge, EAST)
			if(E4) edge_objs += E4
	var/turf/NEN = get_step(T, NORTHEAST)
	var/turf/NWN = get_step(T, NORTHWEST)
	var/turf/SEN = get_step(T, SOUTHEAST)
	var/turf/SWN = get_step(T, SOUTHWEST)
	var/openN = !has_N
	var/openS = !has_S
	var/openE = !has_E
	var/openW = !has_W
	if(openN && openE && NEN && !_neighbor_has_corruption(NEN))
		var/obj/effect/decal/corruption_corner/C1 = _ensure_rim_on(NEN, /obj/effect/decal/corruption_corner, SOUTHWEST)
		if(C1) edge_objs += C1
	if(openN && openW && NWN && !_neighbor_has_corruption(NWN))
		var/obj/effect/decal/corruption_corner/C2 = _ensure_rim_on(NWN, /obj/effect/decal/corruption_corner, SOUTHEAST)
		if(C2) edge_objs += C2
	if(openS && openE && SEN && !_neighbor_has_corruption(SEN))
		var/obj/effect/decal/corruption_corner/C3 = _ensure_rim_on(SEN, /obj/effect/decal/corruption_corner, NORTHWEST)
		if(C3) edge_objs += C3
	if(openS && openW && SWN && !_neighbor_has_corruption(SWN))
		var/obj/effect/decal/corruption_corner/C4 = _ensure_rim_on(SWN, /obj/effect/decal/corruption_corner, NORTHEAST)
		if(C4) edge_objs += C4

/obj/structure/demon/proc/spawn_corruption_with_animation(turf/where, obj/structure/demon/expansion/owner_core, atom/source_for_dir)
	if(!where)
		return
	var/obj/effect/temp_visual/expanding_corruption/A = new /obj/effect/temp_visual/expanding_corruption(where)
	A.plan_finalize(owner_core, source_for_dir)

/obj/effect/temp_visual/expanding_corruption
	name = "METASTASIS SPREAD"
	desc = "The corruption spreads..."
	icon = 'modular/kaizoku/icons/mapset/carcinoma_32x32.dmi'
	icon_state = "ichor_anim"
	layer = DECAL_LAYER
	anchored = TRUE
	density = FALSE
	mouse_opacity = 0

/obj/effect/temp_visual/expanding_corruption/Initialize()
	. = ..()
	flick("ichor_anim", src)
	QDEL_IN(src, duration)
	return .

/obj/effect/temp_visual/expanding_corruption/proc/plan_finalize(obj/structure/demon/expansion/core_ref, atom/source_for_dir)
	addtimer(CALLBACK(src, .proc/finalize_spawn, core_ref, source_for_dir), duration)

/obj/effect/temp_visual/expanding_corruption/proc/finalize_spawn(obj/structure/demon/expansion/core_ref, atom/source_for_dir)
	if(QDELETED(src) || !loc)
		return
	var/turf/T = loc
	var/obj/effect/demon/corruption/C = new(T)
	C.parent_core = core_ref
	var/atom/from_atom = source_for_dir || core_ref
	if(!from_atom) from_atom = C
	for(var/D in GLOB.alldirs)
		var/turf/N = get_step(T, D)
		if(!N) continue
		var/obj/effect/demon/corruption/Nc = locate(/obj/effect/demon/corruption) in N
		if(Nc && (!core_ref || Nc.parent_core == core_ref))
			from_atom = Nc
			break
	C.dir = get_dir(from_atom, T)
	C.update_icon()
	C.refresh_neighbors()
	qdel(src)

/obj/effect/decal/corruption_rim
	name = ""
	desc = ""
	icon = 'modular/kaizoku/icons/mapset/carcinoma_32x32.dmi'
	icon_state = null
	mouse_opacity = 0
	anchored = TRUE
	layer = DECAL_LAYER + 0.01
	var/supporters = 0

/obj/effect/decal/corruption_rim/New(loc, dirval)
	. = ..()
	dir = dirval
	supporters = 1

/obj/effect/decal/corruption_rim/proc/add_supporter()
	supporters++

/obj/effect/decal/corruption_rim/proc/remove_supporter()
	supporters--
	if(supporters <= 0)
		qdel(src)

/obj/effect/decal/corruption_edge
	parent_type = /obj/effect/decal/corruption_rim

/obj/effect/decal/corruption_edge/New(loc, dirval)
	. = ..()
	switch(dirval)
		if(NORTH) icon_state = "ichor_edge-n[rand(1,3)]"
		if(SOUTH) icon_state = "ichor_edge-s[rand(1,3)]"
		if(EAST)  icon_state = "ichor_edge-e[rand(1,3)]"
		if(WEST)  icon_state = "ichor_edge-w[rand(1,3)]"

/obj/effect/decal/corruption_corner
	parent_type = /obj/effect/decal/corruption_rim

/obj/effect/decal/corruption_corner/New(loc, dirval)
	. = ..()
	switch(dirval)
		if(NORTHEAST) icon_state = "ichor_corner-ne[rand(1,3)]"
		if(NORTHWEST) icon_state = "ichor_corner-nw[rand(1,3)]"
		if(SOUTHEAST) icon_state = "ichor_corner-se[rand(1,3)]"
		if(SOUTHWEST) icon_state = "ichor_corner-sw[rand(1,3)]"
