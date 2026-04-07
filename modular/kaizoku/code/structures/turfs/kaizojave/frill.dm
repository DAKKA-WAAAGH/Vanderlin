//Cursed version of Mojave's frills. Improve at your own risk.

GLOBAL_LIST_EMPTY(frill_objects)
var/FRILL_DEBUG = FALSE

/proc/debug_frill_junction(junction)
	var/state = get_consolidated_frill_state(junction)
	return "[state] (j:[junction])"

//New adjustment. North and South are ignored, with exception to diagonal detection.
/proc/get_consolidated_frill_state(junction, west_is_diagonal = FALSE, east_is_diagonal = FALSE)
	var/masked = junction & (4|8|16|128) // East (E=4), West (W=8), NorthEast (NE=16), NorthWest (NW=128)
	var/has_south = junction & 2
	var/has_se = junction & SOUTHEAST_JUNCTION
	var/has_sw = junction & SOUTHWEST_JUNCTION

	var/has_east = masked & 4      // Right
	var/has_west = masked & 8      // Left
	var/has_ne = masked & 16       // NorthEast (top-right)
	var/has_nw = masked & 128      // NorthWest (top-left)

	// Diagonal Detection
	if(west_is_diagonal && !has_east && !has_west && !has_ne && !has_nw) // Only when NO corner neighbors and side neighbor is diagonal
		return "frill0"  // West neighbor is diagonal, treated as bare
	if(east_is_diagonal && !has_east && !has_west && !has_ne && !has_nw)
		return "frill0"  // East neighbor is diagonal, treated as bare
	if(has_south && has_east && !has_west && !has_ne && !has_nw && !has_se && !has_sw) // S+E without W/NE/NW/SE/SW
		return "frill0"  // True S+E diagonal
	if(has_south && has_west && !has_east && !has_ne && !has_nw && !has_se && !has_sw) // S+W without E/NE/NW/SE/SW
		return "frill0"  // True S+W diagonal
	if(!has_east && !has_west && !has_ne && !has_nw) // frill0: No right, no left, no NW, no NE (bare corner)
		return "frill0"

	// frill1: Frills on right and left, no NW, no NE (both sides)
	if(has_east && has_west && !has_ne && !has_nw)
		if(west_is_diagonal && east_is_diagonal) // But if side neighbors are diagonal, get gay as frill0
			return "frill0"
		if(west_is_diagonal)
			return "frill3"  // East only
		if(east_is_diagonal)
			return "frill2"  // West only
		return "frill1"

	// frill2: Frill on left, no NW, no NE, no right
	if(has_west && !has_east && !has_ne && !has_nw)
		return "frill2"
	// frill3: Frill on right, no NW, no NE, no left
	if(has_east && !has_west && !has_ne && !has_nw)
		return "frill3"
	// frill4: Frill on right and left, there is W and NE
	if(has_east && has_west && has_ne && !has_nw)
		if(east_is_diagonal && !west_is_diagonal && has_se)// Check for diagonal slash-up pattern
			return "frill9"
		return "frill4" //Otherwise, be a good boy.

	// frill5: Frill on right, there is NE, but no frill on left nor NW
	if(has_east && has_ne && !has_west && !has_nw)
		return "frill5"

	// frill6: Reverse of frill5 (frill on left, there is NW, but no frill on right nor NE)
	if(has_west && has_nw && !has_east && !has_ne)
		if(west_is_diagonal && !east_is_diagonal && has_nw) //diagonal slash-down pattern
			return "frill8"
		return "frill6"
	return "frill1"


/proc/get_consolidated_front_frill_state(junction, west_is_diagonal = FALSE, east_is_diagonal = FALSE)
	var/masked = junction & (4|8)  // Only E and W
	var/has_south = junction & 2   // South neighbor
	var/has_se = junction & SOUTHEAST_JUNCTION
	var/has_sw = junction & SOUTHWEST_JUNCTION

	var/has_east = masked & 4      // Right
	var/has_west = masked & 8      // Left
	if(has_south && has_east && !has_west && !has_se && !has_sw)
		if(east_is_diagonal)
			return "frill0"
	if(has_south && has_west && !has_east && !has_se && !has_sw)
		if(west_is_diagonal)
			return "frill0"

	if(!has_east && !has_west)
		return "frill0"

	if(has_east && has_west)
		if(west_is_diagonal && has_se && !east_is_diagonal)
			return "frill9"
		if(east_is_diagonal && has_se && !west_is_diagonal)
			return "frill9"
		return "frill1"

	if(has_west && !has_east)// Left only
		return "frill2"
	if(has_east && !has_west)// Right only
		return "frill3"
	return "frill0"


/proc/get_frill_object(icon_path, icon_state, alpha = 255, pixel_x = 0, pixel_y = 0, plane = FRILL_PLANE, layer = FLOAT_LAYER)
	var/cache_key = "[icon_path]-[icon_state]-[alpha]-[pixel_x]-[pixel_y]-[plane]-[layer]"
	if(cache_key in GLOB.frill_objects)
		return GLOB.frill_objects[cache_key]

	var/mutable_appearance/mut_appearance = mutable_appearance(icon_path, icon_state, layer, plane, alpha)
	mut_appearance.pixel_x = pixel_x
	mut_appearance.pixel_y = pixel_y
	return GLOB.frill_objects[cache_key] = mut_appearance


/proc/get_frill_for_junction(icon_path, junction, alpha = 255, pixel_x = 0, pixel_y = 0, plane = OVER_FRILL_PLANE, is_modular = FALSE, layer = FLOAT_LAYER, west_is_diagonal = FALSE, east_is_diagonal = FALSE)
	var/consolidated = is_modular ? get_consolidated_front_frill_state(junction, west_is_diagonal, east_is_diagonal) : get_consolidated_frill_state(junction, west_is_diagonal, east_is_diagonal)
	var/icon_state = is_modular ? "[consolidated]_front" : consolidated
	if(FRILL_DEBUG)
		world << "FRILL_DEBUG: junction=[junction] -> [consolidated] (icon=[icon_state])"
	return get_frill_object(icon_path, icon_state, alpha, pixel_x, pixel_y, plane, layer)

/datum/element/frill
	element_flags = ELEMENT_BESPOKE | ELEMENT_DETACH
	id_arg_index = 2
	var/icon_path
	var/list/tracked_overlays = list()
	var/last_south_turf = null

/datum/element/frill/Attach(datum/target, icon_path)
	if(!isturf(target) && !ismovable(target))
		return ELEMENT_INCOMPATIBLE
	. = ..()
	src.icon_path = icon_path

	RegisterSignal(target, COMSIG_ATOM_SET_SMOOTHED_ICON_STATE, PROC_REF(on_junction_change))


/datum/element/frill/Detach(atom/target)
	var/list/current = tracked_overlays[target]
	if(current)
		target.cut_overlay(current)
		tracked_overlays -= target
	UnregisterSignal(target, COMSIG_ATOM_SET_SMOOTHED_ICON_STATE)
	return ..()


/datum/element/frill/proc/on_junction_change(atom/source, new_junction)
	SIGNAL_HANDLER
	var/turf/turf_or_movable = source
	var/turf/south_turf = get_step(turf_or_movable, SOUTH)

	var/turf/west_neighbor = get_step(source, WEST)
	var/turf/east_neighbor = get_step(source, EAST)
	var/west_is_diagonal = FALSE
	var/east_is_diagonal = FALSE
	var/west_is_back = FALSE
	var/east_is_back = FALSE
	if(istype(west_neighbor, /turf/closed/wall/kaizojave))
		var/turf/west_south = get_step(west_neighbor, SOUTH)
		west_is_back = istype(west_south, /turf/closed/wall/kaizojave)
		if(!west_is_back)
			west_is_diagonal = TRUE
	if(istype(east_neighbor, /turf/closed/wall/kaizojave))
		var/turf/east_south = get_step(east_neighbor, SOUTH)
		east_is_back = istype(east_south, /turf/closed/wall/kaizojave)
		if(!east_is_back)
			east_is_diagonal = TRUE

	var/south_changed = (last_south_turf != south_turf)
	last_south_turf = south_turf

	//The only useful one
	var/turf/north_turf = get_step(source, NORTH)
	// Was used for shitass admin logs, "she is no more more"
	/*
	var/turf/east_turf = get_step(source, EAST)
	var/turf/west_turf = get_step(source, WEST)
	var/turf/ne_turf = get_step(source, NORTHEAST)
	var/turf/nw_turf = get_step(source, NORTHWEST)
	*/
	if(!south_changed)
		var/list/old_overlays = tracked_overlays[source]
		if(old_overlays && old_overlays.len > 0)
			var/list/updated_overlays = list()
			var/has_north_wall_check = north_turf && istype(north_turf, /turf/closed/wall/kaizojave)

			if(!has_north_wall_check) // Only create back frill if NO wall to north
				var/back_frill = get_frill_for_junction(icon_path, new_junction, 255, 0, 32, OVER_FRILL_PLANE, FALSE, FLOAT_LAYER, west_is_diagonal, east_is_diagonal)
				updated_overlays += back_frill
			var/is_still_frontmost = !south_turf || !istype(south_turf, /turf/closed/wall/kaizojave)
			if(is_still_frontmost)// Re-add front frill if this wall is still frontmost
				var/front_junction = new_junction
				if(west_is_back)
					front_junction &= ~WEST_JUNCTION
				if(east_is_back)
					front_junction &= ~EAST_JUNCTION
				var/front_west_is_diagonal = west_is_diagonal && !west_is_back
				var/front_east_is_diagonal = east_is_diagonal && !east_is_back
				var/front_plane = has_north_wall_check ? GAME_PLANE_UPPER : OVER_FRILL_PLANE
				updated_overlays += get_frill_for_junction(icon_path, front_junction, 255, 0, 32, front_plane, TRUE, ABOVE_MOB_LAYER, front_west_is_diagonal, front_east_is_diagonal)

			source.cut_overlay(old_overlays)
			if(updated_overlays.len > 0)
				source.add_overlay(updated_overlays)
			tracked_overlays[source] = updated_overlays
			return

	var/list/current_overlays = tracked_overlays[source]
	if(current_overlays)
		source.cut_overlay(current_overlays)

	var/list/new_overlays = list()

	var/has_north_wall = north_turf && istype(north_turf, /turf/closed/wall/kaizojave)

	var/turf/closed/wall/kaizojave/wall_source = source
	var/vertical_door_south = wall_source?.check_vertical_door_window_south()

	if(!has_north_wall)
		if(vertical_door_south)
			var/mutable_appearance/coverup = mutable_appearance(icon_path, "frill_coverup", FLOAT_LAYER, OVER_FRILL_PLANE)
			coverup.appearance_flags = RESET_COLOR | RESET_ALPHA
			coverup.pixel_y = 32
			new_overlays += coverup
		else
			var/back_frill = get_frill_for_junction(icon_path, new_junction, 255, 0, 32, OVER_FRILL_PLANE, FALSE, FLOAT_LAYER, west_is_diagonal, east_is_diagonal)
			new_overlays += back_frill
	var/is_frontmost = !south_turf || !istype(south_turf, /turf/closed/wall/kaizojave)

	if(is_frontmost)
		var/front_junction = new_junction
		if(west_is_back)
			front_junction &= ~WEST_JUNCTION
		if(east_is_back)
			front_junction &= ~EAST_JUNCTION
		var/front_west_is_diagonal = west_is_diagonal && !west_is_back
		var/front_east_is_diagonal = east_is_diagonal && !east_is_back
		var/front_plane = has_north_wall ? GAME_PLANE_UPPER : OVER_FRILL_PLANE
		new_overlays += get_frill_for_junction(icon_path, front_junction, 255, 0, 32, front_plane, TRUE, ABOVE_MOB_LAYER, front_west_is_diagonal, front_east_is_diagonal)

	source.add_overlay(new_overlays)
	tracked_overlays[source] = new_overlays
