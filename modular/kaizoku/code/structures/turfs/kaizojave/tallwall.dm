/turf/closed/wall/kaizojave
	uses_integrity = TRUE
	name = "base class wall"
	desc = "Abyssor is with us"
	icon_state = "wall0"
	base_icon_state = "wall"
	baseturfs = /turf/open/floor/dirt/road
	wallclimb = TRUE
	explosion_block = 10
	hardness = 7
	blade_dulling = DULLING_BASHCHOP
	max_integrity = 700
	smoothing_flags = SMOOTH_BITMASK
	smoothing_groups = SMOOTH_GROUP_KAIZOJAVE_WALL
	smoothing_list = SMOOTH_GROUP_KAIZOJAVE_WALL
	above_floor = /turf/open/floor/blocks
	var/last_event = 0
	var/active = null
	var/low_wall_type = null
	var/wall_variety = null
	var/icon/frill_icon = null
	var/door_height = 0
	var/window_height = 0

/turf/closed/wall/kaizojave/examine()
	. += ..()
	if(uses_integrity)
		var/healthpercent = (atom_integrity / max_integrity) * 100
		switch(healthpercent)
			if(75 to 99)
				. += "It shows only minor wear on the surface."
			if(50 to 74)
				. += "Its structure looks moderately damaged."
			if(25 to 49)
				. += "It appears severely damaged."
			if(1 to 24)
				. += "<span class='warning'>It's on the verge of collapse!</span>"

/turf/closed/wall/kaizojave/Initialize(mapload)
	. = ..()
	if(uses_integrity && max_integrity)
		atom_integrity = max_integrity

	QUEUE_SMOOTH(src)
	QUEUE_SMOOTH_NEIGHBORS(src)

	if(frill_icon)
		AddElement(/datum/element/frill, frill_icon)

	if(low_wall_type)
		var/turf/above_turf = get_step_multiz(src, UP)
		if(above_turf && !istype(above_turf, /turf/open/openspace))
			var/has_low_wall = FALSE
			for(var/obj/structure/table/kaizojave/low_wall/existing in above_turf)
				has_low_wall = TRUE
				break
			if(!has_low_wall)
				new low_wall_type(above_turf)
	return INITIALIZE_HINT_NORMAL

/turf/closed/wall/kaizojave/proc/check_suppress_frill_for_doors_windows()
	var/turf/south_turf = get_step(src, SOUTH)
	if(!south_turf)
		return FALSE
	if(istype(south_turf, /turf/closed/wall/kaizojave)) //Supress walls south if it exists.
		return TRUE
	for(var/obj/structure/door/kaizojave/door in south_turf) //Same for doors and windows.
		return TRUE
	for(var/obj/structure/window/kaizojave/window in south_turf)
		return TRUE

	return FALSE

/turf/closed/wall/kaizojave/proc/check_vertical_door_window_south()
	var/turf/south_turf = get_step(src, SOUTH)
	if(!south_turf)
		return null

	for(var/obj/structure/door/kaizojave/door in south_turf)
		if(door.door_orientation == NORTH || door.door_orientation == SOUTH) // Vertical door
			return "door"

	for(var/obj/structure/window/kaizojave/window in south_turf)
		if(window.window_orientation == NORTH || window.window_orientation == SOUTH) // Vertical window
			return "window"

	return null

/turf/closed/wall/kaizojave/proc/check_vertical_door_window_north()
	var/turf/north_turf = get_step(src, NORTH)
	if(!north_turf)
		return null

	for(var/obj/structure/door/kaizojave/door in north_turf)
		if(door.door_orientation == NORTH || door.door_orientation == SOUTH) // Vertical door
			return "door"

	for(var/obj/structure/window/kaizojave/window in north_turf)
		if(window.window_orientation == NORTH || window.window_orientation == SOUTH) // Vertical window
			return "window"

	return null

/turf/closed/wall/kaizojave/bitmask_smooth()
	var/new_junction = NONE

	for(var/direction in GLOB.cardinals)
		KJ_SET_ADJ_IN_DIR(direction, direction)

	for(var/direction in list(NORTHWEST, NORTHEAST, SOUTHWEST, SOUTHEAST))
		var/cardinal_dirs = list()
		switch(direction)
			if(NORTHWEST)
				cardinal_dirs = list(NORTH, WEST)
			if(NORTHEAST)
				cardinal_dirs = list(NORTH, EAST)
			if(SOUTHWEST)
				cardinal_dirs = list(SOUTH, WEST)
			if(SOUTHEAST)
				cardinal_dirs = list(SOUTH, EAST)

		var/has_cardinal = new_junction
		var/can_smooth_diag = TRUE
		for(var/cardinal in cardinal_dirs)
			if(!(has_cardinal & cardinal))
				can_smooth_diag = FALSE
				break

		if(can_smooth_diag)
			KJ_SET_ADJ_IN_DIR(direction, direction)

	set_smoothed_icon_state(new_junction)

/turf/closed/wall/kaizojave/proc/apply_frill_cover_overlay()
	if(!frill_icon)
		return
	var/turf/south_turf = get_step(src, SOUTH)
	if(!istype(south_turf, /turf/closed/wall/kaizojave))
		return
	var/mutable_appearance/cover = mutable_appearance(frill_icon, "frill_coverup", ABOVE_MOB_LAYER, FRILL_PLANE)
	cover.appearance_flags = RESET_COLOR | RESET_ALPHA
	cover.pixel_x = 0
	cover.pixel_y = 0
	cut_overlay(cover)
	// add_overlay(cover)  // Commented out to prevent covering the wall icon

/turf/closed/wall/kaizojave/proc/is_kaizojave_wall(turf/neighbor)
	return istype(neighbor, /turf/closed/wall/kaizojave)

/turf/closed/wall/kaizojave/proc/is_back_wall(turf/neighbor)
	if(!is_kaizojave_wall(neighbor))
		return FALSE
	var/turf/south_turf = get_step(neighbor, SOUTH)
	return istype(south_turf, /turf/closed/wall/kaizojave)

/turf/closed/wall/kaizojave/proc/is_front_wall(turf/neighbor)
	if(!is_kaizojave_wall(neighbor))
		return FALSE
	return !is_back_wall(neighbor)

/turf/closed/wall/kaizojave/proc/get_consolidated_wall_state(has_south_wall, east_is_wall, west_is_wall, east_is_back, west_is_back, east_is_front, west_is_front, se_is_back, sw_is_back, se_back_has_north_wall, sw_back_has_north_wall)
	if(!has_south_wall)
		var/continues_east = east_is_front
		var/continues_west = west_is_front

		if(!continues_east && !continues_west)
			return "wall0"
		if(continues_east && !continues_west)
			return "wall2"
		if(!continues_east && continues_west)
			return "wall3"
		return "wall4"

	// Back walls: complementary walls driven by diagonal south back frills
	var/comp_back_sw = sw_is_back && !sw_back_has_north_wall
	var/comp_back_se = se_is_back && !se_back_has_north_wall
	if(comp_back_sw || comp_back_se)
		if(comp_back_sw && comp_back_se)
			return "wall12"
		if(comp_back_sw && east_is_back)
			return "wall10"
		if(comp_back_se && west_is_back)
			return "wall11"
		if(comp_back_sw && !east_is_back)
			return "wall8"
		if(comp_back_se && !west_is_back)
			return "wall9"

	// Back walls: standard non-diagonal types only
	if(!east_is_back && !west_is_back)
		return "wall1"
	if(east_is_back && !west_is_back)
		return "wall5"
	if(!east_is_back && west_is_back)
		return "wall6"
	return "wall7"

/turf/closed/wall/kaizojave/set_smoothed_icon_state(new_junction)
	var/turf/south_neighbor = get_step(src, SOUTH)
	var/turf/west_neighbor = get_step(src, WEST)
	var/turf/east_neighbor = get_step(src, EAST)
	var/turf/sw_neighbor = get_step(src, SOUTHWEST)
	var/turf/se_neighbor = get_step(src, SOUTHEAST)

	var/has_south_wall = is_kaizojave_wall(south_neighbor)
	var/west_is_wall = is_kaizojave_wall(west_neighbor)
	var/east_is_wall = is_kaizojave_wall(east_neighbor)
	var/west_is_back = is_back_wall(west_neighbor)
	var/east_is_back = is_back_wall(east_neighbor)
	var/west_is_front = is_front_wall(west_neighbor)
	var/east_is_front = is_front_wall(east_neighbor)
	var/sw_is_back = is_back_wall(sw_neighbor)
	var/se_is_back = is_back_wall(se_neighbor)
	var/sw_back_has_north_wall = FALSE
	var/se_back_has_north_wall = FALSE
	if(sw_neighbor)
		sw_back_has_north_wall = is_kaizojave_wall(get_step(sw_neighbor, NORTH))
	if(se_neighbor)
		se_back_has_north_wall = is_kaizojave_wall(get_step(se_neighbor, NORTH))

	var/consolidated = get_consolidated_wall_state(has_south_wall, east_is_wall, west_is_wall, east_is_back, west_is_back, east_is_front, west_is_front, se_is_back, sw_is_back, se_back_has_north_wall, sw_back_has_north_wall)

	icon_state = consolidated
	SEND_SIGNAL(src, COMSIG_ATOM_SET_SMOOTHED_ICON_STATE, new_junction)

/turf/closed/wall/kaizojave/proc/set_consolidated_icon_state(junction)
	// Deprecated: use set_smoothed_icon_state instead
	var/turf/south_neighbor = get_step(src, SOUTH)
	var/turf/west_neighbor = get_step(src, WEST)
	var/turf/east_neighbor = get_step(src, EAST)
	var/turf/sw_neighbor = get_step(src, SOUTHWEST)
	var/turf/se_neighbor = get_step(src, SOUTHEAST)

	var/has_south_wall = is_kaizojave_wall(south_neighbor)
	var/west_is_wall = is_kaizojave_wall(west_neighbor)
	var/east_is_wall = is_kaizojave_wall(east_neighbor)
	var/west_is_back = is_back_wall(west_neighbor)
	var/east_is_back = is_back_wall(east_neighbor)
	var/west_is_front = is_front_wall(west_neighbor)
	var/east_is_front = is_front_wall(east_neighbor)
	var/sw_is_back = is_back_wall(sw_neighbor)
	var/se_is_back = is_back_wall(se_neighbor)
	var/sw_back_has_north_wall = FALSE
	var/se_back_has_north_wall = FALSE
	if(sw_neighbor)
		sw_back_has_north_wall = is_kaizojave_wall(get_step(sw_neighbor, NORTH))
	if(se_neighbor)
		se_back_has_north_wall = is_kaizojave_wall(get_step(se_neighbor, NORTH))

	var/consolidated = get_consolidated_wall_state(has_south_wall, east_is_wall, west_is_wall, east_is_back, west_is_back, east_is_front, west_is_front, se_is_back, sw_is_back, se_back_has_north_wall, sw_back_has_north_wall)
	icon_state = consolidated
	SEND_SIGNAL(src, COMSIG_ATOM_SET_SMOOTHED_ICON_STATE, junction)

/turf/closed/wall/kaizojave/kaizoku
	name = "kaizoku wall"
	desc = ""
	icon = 'modular/kaizoku/icons/tileset/newwallset/shoji.dmi'
	frill_icon = 'modular/kaizoku/icons/tileset/newwallset/shoji_frill.dmi'
	wall_variety = "wood"
	low_wall_type = /obj/structure/table/kaizojave/low_wall/kaizoku
	climbdiff = 3
	explosion_block = 4
	hardness = 7
	burn_power = 100
	spread_chance = 1.8
	blade_dulling = DULLING_BASHCHOP
	max_integrity = 1100
	break_sound = 'sound/combat/hits/onwood/destroywalldoor.ogg'
	attacked_sound = list('sound/combat/hits/onwood/woodimpact (1).ogg','sound/combat/hits/onwood/woodimpact (2).ogg')
	above_floor = /turf/open/floor/ruinedwood
	baseturfs = /turf/open/floor/ruinedwood
	door_height = 0
	window_height = 0

/obj/structure/table/kaizojave/low_wall/kaizoku
	name = "kaizoku ceiling"
	desc = ""
	icon = 'modular/kaizoku/icons/tileset/newwallset/shoji.dmi'


// Clay brick style walls (sturdy, brick-like)
/turf/closed/wall/kaizojave/ziontowerwall
	name = "bastion towerwall"
	desc = "Ancient, self-healing bricks contained within solid mineral binder. It recovers every rain."
	icon = 'modular/kaizoku/icons/tileset/newwallset/ziontowerwall.dmi'
	frill_icon = 'modular/kaizoku/icons/tileset/newwallset/ziontowerwall_frill.dmi'
	wall_variety = "clay"
	low_wall_type = /obj/structure/table/kaizojave/low_wall/ziontowerwall
	climbdiff = 4
	explosion_block = 6
	hardness = 9
	burn_power = 40
	spread_chance = 0.6
	blade_dulling = DULLING_BASHCHOP
	max_integrity = 1400
	// reuse generic sounds unless project provides clay-specific ones
	above_floor = /turf/open/floor/ruinedwood
	baseturfs = /turf/open/floor/ruinedwood
	door_height = 0
	window_height = 0


/obj/structure/table/kaizojave/low_wall/ziontowerwall
	name = "bastion upper partition"
	desc = "A self-healing stone and mortar partition."
	icon = 'modular/kaizoku/icons/tileset/newwallset/ziontowerwall.dmi'


// Stone brick style walls (very sturdy, high-end)
/turf/closed/wall/kaizojave/zion_stone
	name = "hemacite walls"
	desc = "Stones covered in the island's coagulated blood makes durable, blast-resistant walls."
	icon = 'modular/kaizoku/icons/tileset/newwallset/zionstonewall.dmi'
	frill_icon = 'modular/kaizoku/icons/tileset/newwallset/zionstonewall_frill.dmi'
	wall_variety = "stone"
	low_wall_type = /obj/structure/table/kaizojave/low_wall/zion_stone
	climbdiff = 5
	explosion_block = 12
	hardness = 12
	burn_power = 10
	spread_chance = 0.1
	blade_dulling = DULLING_BASHCHOP
	max_integrity = 2000
	above_floor = /turf/open/floor/ruinedwood
	baseturfs = /turf/open/floor/ruinedwood
	door_height = 0
	window_height = 0


/obj/structure/table/kaizojave/low_wall/zion_stone
	name = "hemacite roof"
	desc = "roof with a strange, iron-like smell."
	icon = 'modular/kaizoku/icons/tileset/newwallset/zionstonewall.dmi'

