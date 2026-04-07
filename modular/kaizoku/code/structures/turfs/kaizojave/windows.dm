/// Kaizojave Window System
// VERY, VERY WIP. This cursed state is only temporary

/obj/structure/window/kaizojave
	name = "window"
	desc = "A very, very wip window which I am still suffering to make."
	icon = 'icons/obj/structures.dmi'
	icon_state = "window"
	layer = TABLE_LAYER
	density = TRUE
	anchored = TRUE
	opacity = FALSE
	pass_flags_self = PASSWINDOW|PASSSTRUCTURE
	max_integrity = 100
	integrity_failure = 0.1
	blade_dulling = DULLING_BASHCHOP
	CanAtmosPass = ATMOS_PASS_PROC
	climb_time = 20
	climb_offset = 10
	attacked_sound = 'sound/combat/hits/onglass/glasshit.ogg'
	break_sound = "glassbreak"
	destroy_sound = 'sound/combat/hits/onwood/destroywalldoor.ogg'
	smoothing_groups = SMOOTH_GROUP_KAIZOJAVE_WALL
	smoothing_list = SMOOTH_GROUP_KAIZOJAVE_WALL

	var/wall_type = null
	var/wall_variety = null
	var/icon/frill_icon = null
	var/window_height = 0
	var/window_orientation = NORTH
	var/use_placeholder = TRUE
	var/detected_walls = list()
	var/detected_orientation = null

/obj/structure/window/kaizojave/Initialize(mapload)
	. = ..()
	if(!mapload)
		var/success = try_detect_and_configure()
		if(!success)
			use_placeholder = TRUE
	else if(mapload && !wall_type)
		try_detect_and_configure()
	update_appearance(UPDATE_ICON_STATE)
	if(frill_icon)
		update_window_frill()
	update_adjacent_walls()
	if(frill_icon && wall_variety)
		if(window_orientation == EAST || window_orientation == WEST)
			add_horizontal_window_frill()
		else if(window_orientation == NORTH || window_orientation == SOUTH)
			add_vertical_window_top_frill()

	return INITIALIZE_HINT_NORMAL

/obj/structure/window/kaizojave/proc/update_window_frill()
	if(!frill_icon || !wall_variety)
		return

	cut_overlay("window_frill")

	var/frill_state = "[wall_variety]_windowfrill"
	if(window_orientation == NORTH || window_orientation == SOUTH)
		frill_state += "_vert"
	else if(window_orientation == EAST || window_orientation == WEST)
		frill_state += "_horiz"

	if(obj_broken)
		frill_state += "_broken"
	else if(climbable)
		frill_state += "_open"
	var/mutable_appearance/frill = mutable_appearance(frill_icon, frill_state, ABOVE_MOB_LAYER, OVER_FRILL_PLANE)
	frill.pixel_y = 32  // Frills STAYS above the window
	add_overlay(frill)

/obj/structure/window/kaizojave/proc/add_horizontal_window_frill()
	if(!frill_icon || !wall_variety)
		return

	cut_overlay("window_frill_horiz")

	var/frill_state = "[wall_variety]_windowfrill_horiz"
	if(obj_broken)
		frill_state += "_broken"
	else if(climbable)
		frill_state += "_open"
	var/mutable_appearance/frill = mutable_appearance(frill_icon, frill_state, ABOVE_MOB_LAYER, OVER_FRILL_PLANE)
	frill.pixel_y = 32
	frill.appearance_flags = RESET_COLOR | RESET_ALPHA
	add_overlay(frill)

/obj/structure/window/kaizojave/proc/add_vertical_window_top_frill()
	if(!frill_icon || !wall_variety)
		return

	cut_overlay("window_top_frill")

	var/frill_state = "[wall_variety]_windowfrill_top"
	if(obj_broken)
		frill_state += "_broken"
	else if(climbable)
		frill_state += "_open"
	var/mutable_appearance/top_frill = mutable_appearance(frill_icon, frill_state, ABOVE_MOB_LAYER, OVER_FRILL_PLANE)
	top_frill.pixel_y = 64  // Position above the window to cover the wall
	top_frill.appearance_flags = RESET_COLOR | RESET_ALPHA
	add_overlay(top_frill)

/obj/structure/window/kaizojave/proc/update_adjacent_walls()
	for(var/direction in list(NORTH, SOUTH, EAST, WEST))
		var/turf/adjacent = get_step(src, direction)
		if(!adjacent)
			continue
		if(istype(adjacent, /turf/closed/wall/kaizojave))
			var/turf/closed/wall/kaizojave/wall = adjacent
			QUEUE_SMOOTH(wall)

/obj/structure/window/kaizojave/proc/try_detect_and_configure()
	var/turf/closed/wall/kaizojave/north_wall = null
	var/turf/closed/wall/kaizojave/south_wall = null
	var/turf/closed/wall/kaizojave/east_wall = null
	var/turf/closed/wall/kaizojave/west_wall = null
	var/found_count = 0
	detected_walls = list()

	for(var/direction in list(NORTH, SOUTH, EAST, WEST))
		var/turf/adjacent = get_step(src, direction)
		if(!adjacent)
			continue
		if(istype(adjacent, /turf/closed/wall/kaizojave))
			switch(direction)
				if(NORTH)
					north_wall = adjacent
					detected_walls["NORTH"] = adjacent
				if(SOUTH)
					south_wall = adjacent
					detected_walls["SOUTH"] = adjacent
				if(EAST)
					east_wall = adjacent
					detected_walls["EAST"] = adjacent
				if(WEST)
					west_wall = adjacent
					detected_walls["WEST"] = adjacent
			found_count++

	if(found_count == 0)
		return FALSE

	if(north_wall && south_wall)
		if(north_wall.wall_variety != south_wall.wall_variety)
			return FALSE
		detected_orientation = NORTH

	if(east_wall && west_wall)
		if(east_wall.wall_variety != west_wall.wall_variety)
			return FALSE
		if(detected_orientation == NORTH)
			return FALSE
		detected_orientation = EAST

	var/turf/closed/wall/kaizojave/wall_reference
	if(north_wall)
		wall_reference = north_wall
	else if(south_wall)
		wall_reference = south_wall
	else if(east_wall)
		wall_reference = east_wall
	else if(west_wall)
		wall_reference = west_wall
	if(!wall_reference)
		return FALSE

	if(north_wall && south_wall && east_wall && west_wall)
		use_placeholder = TRUE
		return TRUE

	wall_type = wall_reference
	return setup_from_wall(wall_reference)

/obj/structure/window/kaizojave/proc/setup_from_wall(turf/closed/wall/kaizojave/reference_wall)
	if(!reference_wall)
		return FALSE

	if(reference_wall.icon)
		icon = reference_wall.icon
	wall_variety = reference_wall.wall_variety
	frill_icon = reference_wall.frill_icon
	if(reference_wall && reference_wall.vars && reference_wall.vars["window_height"])
		window_height = reference_wall.vars["window_height"]
	if(detected_orientation)
		window_orientation = detected_orientation

	use_placeholder = FALSE
	return TRUE

/obj/structure/window/kaizojave/update_icon_state()
	. = ..()
	if(use_placeholder)
		icon_state = "[initial(icon_state)][obj_broken ? "br" : ""]"
		return

	if(!wall_variety)
		use_placeholder = TRUE
		icon_state = "window"
		return

	var/base_state = "[wall_variety]_window"
	if(window_orientation == NORTH || window_orientation == SOUTH)
		base_state = "[wall_variety]_window_vert"
	else if(window_orientation == EAST || window_orientation == WEST)
		base_state = "[wall_variety]_window_horiz"

	if(obj_broken)
		icon_state = "[base_state]_broken"
	else if(climbable)
		icon_state = "[base_state]_open"
	else
		icon_state = base_state

/obj/structure/window/kaizojave/Destroy()
	cleanup_adjacent_walls()
	return ..()

/obj/structure/window/kaizojave/proc/cleanup_adjacent_walls()
	for(var/direction in list(NORTH, SOUTH, EAST, WEST))
		var/turf/adjacent = get_step(src, direction)
		if(!adjacent)
			continue
		if(istype(adjacent, /turf/closed/wall/kaizojave))
			var/turf/closed/wall/kaizojave/wall = adjacent
			if(wall.frill_icon && !wall.check_suppress_frill_for_doors_windows())
				wall.AddElement(/datum/element/frill, wall.frill_icon)
			QUEUE_SMOOTH(wall)

/obj/structure/window/kaizojave/wood
	name = "wooden window"
	desc = "A window set in a wooden frame."
	wall_variety = "wood"  // Fallback variety
