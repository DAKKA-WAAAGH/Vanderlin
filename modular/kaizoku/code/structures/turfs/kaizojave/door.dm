/// Kaizojave Door System
// VERY, VERY WIP. This cursed state is only temporary

/obj/structure/door/kaizojave
	name = "door"
	desc = "A sturdy door frame."
	icon = 'code/__DEFINES/kaizojave/placeholder_icons/structures/door_placeholder.dmi'
	icon_state = "door"
	density = TRUE
	anchored = TRUE
	opacity = TRUE
	layer = CLOSED_DOOR_LAYER
	resistance_flags = FLAMMABLE
	pass_flags_self = PASSDOORS|PASSSTRUCTURE
	max_integrity = 1000
	integrity_failure = 0.5
	armor = list("blunt" = 10, "slash" = 10, "stab" = 10, "piercing" = 0, "fire" = 0, "acid" = 0)
	damage_deflection = 10
	CanAtmosPass = ATMOS_PASS_DENSITY
	break_sound = 'sound/combat/hits/onwood/destroywalldoor.ogg'
	attacked_sound = list('sound/combat/hits/onwood/woodimpact (1).ogg','sound/combat/hits/onwood/woodimpact (2).ogg')
	lock = /datum/lock/key
	can_add_lock = TRUE
	smoothing_groups = SMOOTH_GROUP_KAIZOJAVE_WALL
	smoothing_list = SMOOTH_GROUP_KAIZOJAVE_WALL

	// Kaizojave-specific variables
	var/wall_type = null
	var/wall_variety = null // The variety name, like "wood", "metal", "stone". Or whatever tf
	var/icon/frill_icon = null
	var/door_height = 0 // Offset for height on z-plane (in case we want customized doors)
	var/door_orientation = NORTH // NORTH/SOUTH for frontal, EAST/WEST for sideways
	var/use_placeholder = TRUE
	var/detected_walls = list() // List of detected adjacent walls
	var/detected_orientation = null // Detected door orientation from walls

/obj/structure/door/kaizojave/Initialize(mapload)
	. = ..()
	if(!mapload)
		var/success = try_detect_and_configure()
		if(!success)
			use_placeholder = TRUE
	else if(mapload && !wall_type)
		try_detect_and_configure()
	update_appearance(UPDATE_ICON_STATE)
	if(frill_icon)
		update_door_frill()
	update_adjacent_walls() //Smooth up with doors and adjust frills accordingly

	// Add orientation-specific frills
	if(frill_icon && wall_variety)
		if(door_orientation == EAST || door_orientation == WEST)
			add_horizontal_door_frill()
		else if(door_orientation == NORTH || door_orientation == SOUTH)
			add_vertical_door_top_frill()

	return INITIALIZE_HINT_NORMAL

/obj/structure/door/kaizojave/proc/update_door_frill() //Frill overlay based on orientation
	if(!frill_icon || !wall_variety)
		return
	cut_overlay("door_frill")
	var/frill_state = "[wall_variety]_doorfrill"
	if(door_orientation == NORTH || door_orientation == SOUTH)
		frill_state += "_vert"
	else if(door_orientation == EAST || door_orientation == WEST)
		frill_state += "_horiz"
	if(obj_broken)
		frill_state += "_broken"
	else if(door_opened)
		frill_state += "_open"
	var/mutable_appearance/frill = mutable_appearance(frill_icon, frill_state, ABOVE_MOB_LAYER, OVER_FRILL_PLANE)
	frill.pixel_y = 32  //Frills above the door
	add_overlay(frill)

/obj/structure/door/kaizojave/proc/add_horizontal_door_frill()
	if(!frill_icon || !wall_variety)
		return

	cut_overlay("door_frill_horiz")

	var/frill_state = "[wall_variety]_doorfrill_horiz"
	if(obj_broken)
		frill_state += "_broken"
	else if(door_opened)
		frill_state += "_open"

	var/mutable_appearance/frill = mutable_appearance(frill_icon, frill_state, ABOVE_MOB_LAYER, OVER_FRILL_PLANE)
	frill.pixel_y = 32
	frill.appearance_flags = RESET_COLOR | RESET_ALPHA
	add_overlay(frill)

/obj/structure/door/kaizojave/proc/add_vertical_door_top_frill()
	if(!frill_icon || !wall_variety)
		return

	cut_overlay("door_top_frill")

	var/frill_state = "[wall_variety]_doorfrill_top"
	if(obj_broken)
		frill_state += "_broken"
	else if(door_opened)
		frill_state += "_open"

	var/mutable_appearance/top_frill = mutable_appearance(frill_icon, frill_state, ABOVE_MOB_LAYER, OVER_FRILL_PLANE)
	top_frill.pixel_y = 64
	top_frill.appearance_flags = RESET_COLOR | RESET_ALPHA
	add_overlay(top_frill)

/obj/structure/door/kaizojave/proc/update_adjacent_walls()
	for(var/direction in list(NORTH, SOUTH, EAST, WEST))
		var/turf/adjacent = get_step(src, direction)
		if(!adjacent)
			continue
		if(istype(adjacent, /turf/closed/wall/kaizojave))
			var/turf/closed/wall/kaizojave/wall = adjacent
			QUEUE_SMOOTH(wall)

/obj/structure/door/kaizojave/proc/try_detect_and_configure()
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

	var/wall_type_path = wall_reference.type
	wall_type = wall_type_path
	return setup_from_wall(wall_reference)

/obj/structure/door/kaizojave/proc/setup_from_wall(turf/closed/wall/kaizojave/reference_wall)
	if(!reference_wall)
		return FALSE

	if(reference_wall.icon)
		icon = reference_wall.icon
	wall_variety = reference_wall.wall_variety
	frill_icon = reference_wall.frill_icon

	if(reference_wall && reference_wall.vars && reference_wall.vars["door_height"])
		door_height = reference_wall.vars["door_height"]

	if(detected_orientation)
		door_orientation = detected_orientation

	use_placeholder = FALSE
	return TRUE

/obj/structure/door/kaizojave/Destroy()
	cleanup_adjacent_walls()
	return ..()

/obj/structure/door/kaizojave/proc/cleanup_adjacent_walls()
	for(var/direction in list(NORTH, SOUTH, EAST, WEST))
		var/turf/adjacent = get_step(src, direction)
		if(!adjacent)
			continue
		if(istype(adjacent, /turf/closed/wall/kaizojave))
			var/turf/closed/wall/kaizojave/wall = adjacent
			if(wall.frill_icon && !wall.check_suppress_frill_for_doors_windows())
				wall.AddElement(/datum/element/frill, wall.frill_icon)
			QUEUE_SMOOTH(wall)

/obj/structure/door/kaizojave/update_appearance(updates)
	. = ..()
	if(updates & UPDATE_ICON_STATE)
		update_icon_state()
		update_door_frill()

/obj/structure/door/kaizojave/update_icon_state()
	. = ..()
	if(use_placeholder)
		if(obj_broken)
			icon_state = "door_broken"
		else if(door_opened)
			icon_state = "door_open"
		else
			icon_state = "door"
		return

	if(!wall_variety) //fallback
		use_placeholder = TRUE
		icon_state = "door"
		return

	var/base_state = "[wall_variety]_door"
	if(door_orientation == NORTH || door_orientation == SOUTH)
		base_state = "[wall_variety]_door_vert"
	else if(door_orientation == EAST || door_orientation == WEST)
		base_state = "[wall_variety]_door_horiz"

	if(obj_broken)
		icon_state = "[base_state]_broken"
	else if(door_opened)
		icon_state = "[base_state]_open"
	else
		icon_state = base_state

/obj/structure/door/kaizojave/attack_hand(mob/user)
	. = ..()
	if(obj_broken)
		to_chat(user, "<span class='warning'>The door is broken!</span>")
		return
	if(door_opened)
		close_door()
	else
		open_door()

/obj/structure/door/kaizojave/proc/open_door()
	if(door_opened)
		return
	door_opened = TRUE
	density = FALSE
	opacity = FALSE
	update_appearance(UPDATE_ICON_STATE)
	playsound(src, 'sound/foley/doors/shittyopen.ogg', 50, TRUE)
	if(door_orientation == NORTH || door_orientation == SOUTH)
		add_door_slide_overlay(TRUE)
		update_adjacent_walls()
		add_vertical_door_top_frill()
	else if(door_orientation == EAST || door_orientation == WEST)
		add_horizontal_door_frill()

/obj/structure/door/kaizojave/proc/close_door()
	if(!door_opened)
		return
	door_opened = FALSE
	density = TRUE
	opacity = TRUE
	update_appearance(UPDATE_ICON_STATE)
	playsound(src, 'sound/foley/doors/shittyclose.ogg', 50, TRUE)
	if(door_orientation == NORTH || door_orientation == SOUTH)
		add_door_slide_overlay(FALSE)
		update_adjacent_walls()
		add_vertical_door_top_frill()
	else if(door_orientation == EAST || door_orientation == WEST)
		add_horizontal_door_frill()

/obj/structure/door/kaizojave/proc/add_door_slide_overlay(is_open)
	cut_overlay("door_slide")

	if(!is_open)
		return

	var/overlay_state = "[wall_variety]_door_slide"
	if(!wall_variety)
		return

	var/mutable_appearance/door_slide = mutable_appearance(icon, overlay_state, layer)
	door_slide.pixel_x = 16  //Slide to the right. Still WIP as hell.
	door_slide.appearance_flags = RESET_COLOR | RESET_ALPHA
	add_overlay(door_slide)

/obj/structure/door/kaizojave/wood
	name = "wooden door"
	desc = "A sturdy wooden door."
	wall_variety = "wood"
