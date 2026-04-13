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
	var/mergeable_connectors = TRUE //If TRUE, horizontal doors/windows ARE mergeable neighboors for WALL and FRILLS.
	var/merge_vertical_connectors = TRUE // Set to FALSE on walls that must NOT merge with connectors.
	var/list/allowed_door_varieties = null //Optional allowlist for door materials.
	var/destroyed_turf_type = null
	var/mutable_appearance/active_window_coverup = null
	var/murderhole_eligible = TRUE
	var/has_murderhole = FALSE
	var/mutable_appearance/active_murderhole_overlay = null

/turf/closed/wall/kaizojave/examine()
	. += ..()
	if(murderhole_eligible)
		. += "With an chisel, this wall can hold a murderhole."
	else
		. += "This wall is improper for alterations with a chisel."
	if(uses_integrity)
		var/healthpercent = (atom_integrity / max_integrity) * 100
		switch(healthpercent)
			if(75 to 99)
				. += "It has exposed scratches on the surface."
			if(50 to 74)
				. += "The surface is compromised, exposing the inner core."
			if(25 to 49)
				. += "The very structure of it is compromised and exposed."
			if(1 to 24)
				. += "<span class='warning'>It is clearly collapsing!</span>"

/turf/closed/wall/kaizojave/Initialize(mapload)
	. = ..()
	for(var/obj/structure/flora/flora in src)
		qdel(flora)
	if(uses_integrity && max_integrity)
		atom_integrity = max_integrity

	QUEUE_SMOOTH(src)
	QUEUE_SMOOTH_NEIGHBORS(src)

	if(frill_icon)
		AddElement(/datum/element/frill, frill_icon)
		apply_frill_cover_overlay()
	update_murderhole_overlay()

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

/turf/closed/wall/kaizojave/proc/ineffectiveattack(obj/item/W, mob/living/user)
	return null

/turf/closed/wall/kaizojave/attackby(obj/item/W, mob/living/user, params)
	if(!W || !user)
		return ..()

	if(!istype(W, /obj/item/weapon/chisel))
		if(user.used_intent)
			var/msg = ineffectiveattack(W, user)
			if(msg)
				to_chat(user, span_warning(msg))
				return TRUE
		return ..()

	if(!murderhole_eligible)
		to_chat(user, span_warning("This wall is improper for murderholes."))
		return TRUE

	var/list/offhand_types = typecacheof(list(/obj/item/weapon/hammer))
	var/obj/item/offhand_item = user.get_inactive_held_item()
	if(user.used_intent.type != /datum/intent/chisel || !is_type_in_typecache(offhand_item, offhand_types))
		to_chat(user, span_warning("I require a hammer in my other hand, and a chisel."))
		return TRUE

	if(has_murderhole)
		to_chat(user, span_notice("This wall already has a murderhole."))
		return TRUE

	user.changeNext_move(CLICK_CD_MELEE)
	playsound(src, pick('modular/kaizoku/sound/combat/hits/onrock/onrock (1).ogg', 'modular/kaizoku/sound/combat/hits/onrock/onrock (2).ogg', 'modular/kaizoku/sound/combat/hits/onrock/onrock (3).ogg', 'modular/kaizoku/sound/combat/hits/onrock/onrock (4).ogg'), 100)
	user.visible_message(span_info("[user] begins chiseling a hole into [src]."))
	if(!do_after(user, 5 SECONDS, src))
		return TRUE

	has_murderhole = TRUE
	opacity = FALSE
	update_murderhole_overlay()
	playsound(src, 'modular/kaizoku/sound/foley/smash_rock.ogg', 90, FALSE)
	QUEUE_SMOOTH(src)
	QUEUE_SMOOTH_NEIGHBORS(src)
	return TRUE

/turf/closed/wall/kaizojave/CanPass(atom/movable/mover, turf/target)
	if(has_murderhole && mover && ((mover.pass_flags & PASSTABLE) || (mover.pass_flags & PASSGRILLE)))
		return TRUE
	return ..()

/turf/closed/wall/kaizojave/proc/get_murderhole_state()
	if(!has_murderhole || !icon)
		return null

	var/list/available_states = icon_states(icon)
	if(!available_states || !available_states.len)
		return null

	var/is_backmost = istype(get_step(src, SOUTH), /turf/closed/wall/kaizojave)
	var/list/candidates = list()
	if(wall_variety)
		candidates += "[wall_variety]_[is_backmost ? "backmosthole" : "frontmosthole"]"
	candidates += is_backmost ? "backmosthole" : "frontmosthole"

	for(var/state_name in candidates)
		if(state_name in available_states)
			return state_name

	return null

/turf/closed/wall/kaizojave/proc/update_murderhole_overlay()
	if(active_murderhole_overlay)
		cut_overlay(active_murderhole_overlay)
		active_murderhole_overlay = null

	var/hole_state = get_murderhole_state()
	if(!hole_state)
		return

	var/mutable_appearance/hole = mutable_appearance(icon, hole_state, ABOVE_NORMAL_TURF_LAYER, plane)
	hole.appearance_flags = RESET_ALPHA
	hole.mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	active_murderhole_overlay = hole
	add_overlay(active_murderhole_overlay)

/turf/closed/wall/kaizojave/atom_destruction(damage_flag)
	return ..()

/turf/closed/wall/kaizojave/proc/get_destroyed_turf_type()
	if(ispath(destroyed_turf_type, /turf/open)) //Per-wall ovverride unless mappers wants special behaviors, or whatever.
		return destroyed_turf_type

	var/turf/runtime_candidate = pick_open_baseturf_type(baseturfs)
	var/turf/default_candidate = pick_open_baseturf_type(initial(baseturfs))
	var/turf/neighbor_candidate = get_neighbor_floor_consensus_type()

	if(runtime_candidate)
		if(neighbor_candidate && default_candidate && runtime_candidate == default_candidate && neighbor_candidate != runtime_candidate)
			return neighbor_candidate
		return runtime_candidate

	if(neighbor_candidate)
		return neighbor_candidate

	if(default_candidate)
		return default_candidate

	return /turf/open/floor/dirt/road

/turf/closed/wall/kaizojave/proc/pick_open_baseturf_type(source_baseturfs)
	if(ispath(source_baseturfs, /turf/open) && !ispath(source_baseturfs, /turf/open/openspace))
		return source_baseturfs

	if(!islist(source_baseturfs) || !length(source_baseturfs))
		return null

	var/list/baseturf_list = source_baseturfs
	for(var/i in baseturf_list.len to 1 step -1)
		var/candidate_type = baseturf_list[i]
		if(ispath(candidate_type, /turf/baseturf_skipover)) //stop KILLING the turf.
			continue
		if(ispath(candidate_type, /turf/closed/wall))
			continue
		if(ispath(candidate_type, /turf/open) && !ispath(candidate_type, /turf/open/openspace))
			return candidate_type

	return null

/turf/closed/wall/kaizojave/proc/get_neighbor_floor_consensus_type()
	var/list/type_weights = list()
	for(var/direction in GLOB.cardinals)
		var/turf/neighbor = get_step(src, direction)
		if(!neighbor || isclosedturf(neighbor) || istype(neighbor, /turf/open/openspace))
			continue

		var/turf/neighbor_type = neighbor.type
		type_weights[neighbor_type] = (type_weights[neighbor_type] || 0) + 1

	if(!length(type_weights))
		return null

	var/turf/best_type = null
	var/best_weight = -1
	for(var/turf/candidate_type as anything in type_weights)
		var/weight = type_weights[candidate_type]
		if(weight > best_weight)
			best_type = candidate_type
			best_weight = weight

	return best_type

/turf/closed/wall/kaizojave/dismantle_wall(devastated=0, explode=0)
	playsound(src, 'sound/blank.ogg', 100, TRUE)
	var/turf/target_turf_type = get_destroyed_turf_type()
	var/turf/new_turf = ChangeTurf(target_turf_type, flags = CHANGETURF_INHERIT_AIR | CHANGETURF_FORCEOP)

	// Fallback only if conversion failed or still produced a wall turf.
	if(!new_turf || istype(new_turf, /turf/closed/wall))
		new_turf = ChangeTurf(/turf/open/floor/dirt/road, flags = CHANGETURF_INHERIT_AIR | CHANGETURF_FORCEOP)

	if(new_turf)
		QUEUE_SMOOTH_NEIGHBORS(new_turf)

/turf/closed/wall/kaizojave/proc/check_suppress_frill_for_doors_windows()
	var/turf/south_turf = get_step(src, SOUTH)
	if(!south_turf)
		return FALSE
	if(istype(south_turf, /turf/closed/wall/kaizojave)) //Supress walls south if it exists.
		return TRUE
	for(var/obj/structure/door/kaizojave/door in south_turf) //Same for doors and windows.
		if(is_mergeable_connector(door))
			return TRUE
	for(var/obj/structure/window/kaizojave/window in south_turf)
		if(is_mergeable_connector(window))
			return TRUE

	return FALSE

/turf/closed/wall/kaizojave/proc/check_vertical_door_window_south()
	var/turf/south_turf = get_step(src, SOUTH)
	return get_vertical_door_window_type(south_turf)

/turf/closed/wall/kaizojave/proc/check_vertical_door_window_north()
	var/turf/north_turf = get_step(src, NORTH)
	return get_vertical_door_window_type(north_turf)

/turf/closed/wall/kaizojave/proc/get_vertical_door_window_type(turf/scan_turf)
	if(!scan_turf)
		return null

	for(var/obj/structure/door/kaizojave/door in scan_turf)
		var/is_vertical_door = (door.door_orientation == NORTH || door.door_orientation == SOUTH)
		if(!is_vertical_door)
			is_vertical_door = (door.dir == NORTH || door.dir == SOUTH)
		if(is_vertical_door) // Vertical door
			return "door"

	for(var/obj/structure/window/kaizojave/window in scan_turf)
		if(window.window_orientation == NORTH || window.window_orientation == SOUTH) // Vertical window
			return "window"

	return null

/turf/closed/wall/kaizojave/proc/is_vertical_kaizojave_door(obj/structure/door/kaizojave/door)
	if(!door)
		return FALSE
	var/is_vertical_door = (door.door_orientation == NORTH || door.door_orientation == SOUTH)
	if(!is_vertical_door)
		is_vertical_door = (door.dir == NORTH || door.dir == SOUTH)
	return is_vertical_door

/turf/closed/wall/kaizojave/proc/is_vertical_kaizojave_window(obj/structure/window/kaizojave/window)
	if(!window)
		return FALSE
	var/is_vertical_window = (window.window_orientation == NORTH || window.window_orientation == SOUTH)
	if(!is_vertical_window)
		is_vertical_window = (window.dir == NORTH || window.dir == SOUTH)
	return is_vertical_window

/turf/closed/wall/kaizojave/proc/is_mergeable_connector(atom/movable/candidate)
	if(istype(candidate, /obj/structure/door/kaizojave))
		var/obj/structure/door/kaizojave/door = candidate
		return !!door.mergewithwalls

	if(istype(candidate, /obj/structure/window/kaizojave)) //if true, eat my shorts.
		var/obj/structure/window/kaizojave/window = candidate
		return !!window.mergewithwalls

	return FALSE

/turf/closed/wall/kaizojave/proc/has_mergeable_connector_on_turf(turf/neighbor)
	if(!neighbor)
		return FALSE

	for(var/obj/structure/door/kaizojave/door in neighbor)
		if(is_mergeable_connector(door))
			return TRUE

	for(var/obj/structure/window/kaizojave/window in neighbor)
		if(is_mergeable_connector(window))
			return TRUE

	return FALSE

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
	if(!icon)
		return

	if(active_window_coverup)
		cut_overlay(active_window_coverup)
		active_window_coverup = null

	var/cover_state = get_window_coverup_state()
	if(!cover_state)
		return

	var/mutable_appearance/cover = mutable_appearance(icon, cover_state, layer, plane)
	cover.appearance_flags = RESET_ALPHA
	cover.mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	cover.pixel_x = 0
	cover.pixel_y = 0

	if(!should_use_window_coverup())
		return
	active_window_coverup = cover
	add_overlay(active_window_coverup)

/turf/closed/wall/kaizojave/proc/should_use_window_coverup()
	if(!is_kaizojave_wall(get_step(src, SOUTH))) //Coverups belongs on the backmost walls.
		return FALSE

	if(check_vertical_door_window_north())
		return TRUE

	for(var/scan_dir in list(EAST, WEST))
		var/turf/current = src
		for(var/i in 1 to 64)
			var/turf/neighbor = get_step(current, scan_dir)
			if(!is_kaizojave_wall(neighbor))
				break
			if(!is_kaizojave_wall(get_step(neighbor, SOUTH)))
				break
			if(get_vertical_door_window_type(get_step(neighbor, NORTH)))
				return TRUE
			current = neighbor

	return FALSE

/turf/closed/wall/kaizojave/proc/get_window_coverup_state()
	if(!icon)
		return null

	var/list/available_states = icon_states(icon)
	if(!available_states || !available_states.len)
		return null

	var/list/candidates = list()
	if(wall_variety)
		candidates += "[wall_variety]_frill_coverup"
	candidates += "frill_coverup"
	if(wall_variety)
		candidates += "[wall_variety]_wall13"
	candidates += "wall13"

	for(var/state_name in candidates)
		if(state_name in available_states)
			return state_name

	return null

/turf/closed/wall/kaizojave/proc/is_kaizojave_wall(turf/neighbor)
	if(istype(neighbor, /turf/closed/wall/kaizojave))
		return TRUE
	if(!neighbor)
		return FALSE

	for(var/obj/structure/door/kaizojave/door in neighbor)
		if(is_mergeable_connector(door))
			return TRUE

	for(var/obj/structure/window/kaizojave/window in neighbor)
		if(is_mergeable_connector(window))
			return TRUE

	return FALSE

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

	var/comp_back_sw = sw_is_back && !sw_back_has_north_wall //Back walls, these are complementary walls that respect diagonal backfrils.
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

	if(!east_is_back && !west_is_back) //These does not respect diagonals.
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
	var/vertical_door_window_south = check_vertical_door_window_south()
	if(vertical_door_window_south)
		consolidated = "wall13"

	var/frill_junction = new_junction //Frills are driven by junction bits, and it must be kept aware of connector too.
	if(west_is_wall)
		frill_junction |= WEST_JUNCTION
	else
		frill_junction &= ~WEST_JUNCTION
	if(east_is_wall)
		frill_junction |= EAST_JUNCTION
	else
		frill_junction &= ~EAST_JUNCTION

	icon_state = consolidated
	SEND_SIGNAL(src, COMSIG_ATOM_SET_SMOOTHED_ICON_STATE, frill_junction)
	apply_frill_cover_overlay()
	update_murderhole_overlay()

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
	apply_frill_cover_overlay()
	update_murderhole_overlay()


// Lattice type of walls are an weaker and cheaper version of the wood frames
// It's an ancient construction technique, using wooden lattice as frames, and lacking use of nails.
// Pretty much meant to be easily made by players with low skills, without using treenails/sharpened sticks.
// The one most well used EVEN up to nowadays would be Wattle-and-daub, as funny as it seems to use manure as wall,
// it's actually quite effective.

/turf/closed/wall/kaizojave/lattice
	name = "You should not be able to see this."
	desc = "Mappers fucked up if they spawned this."
	wall_variety = "wood"
	climbdiff = 2
	explosion_block = 1
	hardness = 60
	burn_power = 140
	spread_chance = 2.3
	blade_dulling = DULLING_BASHCHOP
	max_integrity = 300
	damage_deflection = 2
	break_sound = 'modular/kaizoku/sound/combat/hits/onwood/destroywalldoor.ogg'
	attacked_sound = list('modular/kaizoku/sound/combat/hits/onwood/woodimpact (1).ogg','modular/kaizoku/sound/combat/hits/onwood/woodimpact (2).ogg')
	above_floor = /turf/open/floor/ruinedwood
	baseturfs = /turf/open/floor/ruinedwood
	//allowed_door_varieties = list("wood")
	murderhole_eligible = TRUE
	var/hand_dismantle = FALSE

/turf/closed/wall/kaizojave/lattice/attack_hand(mob/living/user) //This is only for tents and whatnot. Still WIP.
	if(hand_dismantle && user)
		user.visible_message(span_info("[user] starts pulling down [src]."))
		if(!do_after(user, 3 SECONDS, src))
			return TRUE
		dismantle_wall()
		return TRUE
	return ..()

/turf/closed/wall/kaizojave/lattice/bcrosswattle
	name = "crosswattle painel"
	desc = "Cheap bamboo wall built with woven cross sections. It provides more stability than wood, yet remains fragile."
	icon = 'modular/kaizoku/icons/tileset/newwallset/latticenailess/bcrosswattle.dmi'
	frill_icon = 'modular/kaizoku/icons/tileset/newwallset/latticenailess/bcrosswattle_frill.dmi'
	max_integrity = 400

/turf/closed/wall/kaizojave/lattice/wcrosswattle
	name = "crosswattle painel"
	desc = "Cheap wall that was woven with sticks. Usual construction for elven settlements that requires lightweight extensions on leaves."
	icon = 'modular/kaizoku/icons/tileset/newwallset/latticenailess/crosswattle.dmi'
	frill_icon = 'modular/kaizoku/icons/tileset/newwallset/latticenailess/crosswattle_frill.dmi'

/turf/closed/wall/kaizojave/lattice/shoji
	name = "shoji painel"
	desc = "Traditional foglander painel, thick papers settled on a lattice frame. Light and cheap for low-budget housing."
	icon = 'modular/kaizoku/icons/tileset/newwallset/latticenailess/shoji.dmi'
	frill_icon = 'modular/kaizoku/icons/tileset/newwallset/latticenailess/shoji_frill.dmi'

/turf/closed/wall/kaizojave/lattice/wattledaub
	name = "wattledaub wall"
	desc = "Sticks and mud are one of the easiest materials to find, allowing coastals to rest on almost desert islands."
	icon = 'modular/kaizoku/icons/tileset/newwallset/latticenailess/wattledaub.dmi'
	frill_icon = 'modular/kaizoku/icons/tileset/newwallset/latticenailess/wattledaub_frill.dmi'

/* Not made yet.
/turf/closed/wall/kaizojave/lattice/cloth_tent
	name = "cloth tent wall"
	desc = "Simple stretched cloth connected by sticks puncturing the ground. It can be dismantled by hand."
	icon = 'modular/kaizoku/icons/tileset/newwallset/latticenailess/clothtent.dmi'
	frill_icon = 'modular/kaizoku/icons/tileset/newwallset/latticenailess/clothtent_frill.dmi'
	max_integrity = 120
	explosion_block = 0
	hardness = 80
	hand_dismantle = TRUE

/turf/closed/wall/kaizojave/lattice/pelt_tent
	name = "pelt tent wall"
	desc = "Stretched hides, common usage by the mobile dustwalkers. It can be dismantled by hand."
	icon = 'modular/kaizoku/icons/tileset/newwallset/latticenailess/pelttent.dmi'
	frill_icon = 'modular/kaizoku/icons/tileset/newwallset/latticenailess/pelttent_frill.dmi'
	max_integrity = 200
	explosion_block = 0
	hardness = 75
	hand_dismantle = TRUE
*/

/turf/closed/wall/kaizojave/wood
	name = "wood framed wall"
	desc = "You should NOT be seeing this."
	wall_variety = "wood"
	climbdiff = 3
	explosion_block = 4
	hardness = 8
	burn_power = 95
	spread_chance = 1.6
	blade_dulling = DULLING_CUT
	max_integrity = 1200
	damage_deflection = 8
	break_sound = 'modular/kaizoku/sound/combat/hits/onwood/destroywalldoor.ogg'
	attacked_sound = list('modular/kaizoku/sound/combat/hits/onwood/woodimpact (1).ogg','modular/kaizoku/sound/combat/hits/onwood/woodimpact (2).ogg')
	above_floor = /turf/open/floor/ruinedwood
	baseturfs = /turf/open/floor/ruinedwood
	allowed_door_varieties = list("wood")

/turf/closed/wall/kaizojave/wood/shoji
	name = "shoji wall"
	desc = "Refined foglander wall with dense paper painels with an sturdy wooden frame. Natural resins make it rather immune to mold."
	icon = 'modular/kaizoku/icons/tileset/newwallset/woodframe/bettershoji.dmi'
	frill_icon = 'modular/kaizoku/icons/tileset/newwallset/woodframe/bettershoji_frill.dmi'

/turf/closed/wall/kaizojave/wood/foreigner
	name = "foreigner wall"
	desc = "An foreigner wall, timber framing with baked clay sections. Common among the heartfeltean immigrants."
	icon = 'modular/kaizoku/icons/tileset/newwallset/woodframe/fachwerk.dmi'
	frill_icon = 'modular/kaizoku/icons/tileset/newwallset/woodframe/fachwerk_frill.dmi'

/turf/closed/wall/kaizojave/wood/logs
	name = "log wall"
	desc = "Interlocked logs. Quite an horrible sight for any elf worth its testicles."
	icon = 'modular/kaizoku/icons/tileset/newwallset/woodframe/logs.dmi'
	frill_icon = 'modular/kaizoku/icons/tileset/newwallset/woodframe/logs_frill.dmi'

/* Not finished
/turf/closed/wall/kaizojave/wood/siheyuan
	name = "courtland wall"
	desc = "Wall used for foglander enclosures for centuries. With wood and baked clay, it is sturdy and longlasting."
	icon = 'modular/kaizoku/icons/tileset/newwallset/woodframe/siheyuan.dmi'
	frill_icon = 'modular/kaizoku/icons/tileset/newwallset/woodframe/siheyuan_frill.dmi'
	max_integrity = 1320
*/

/turf/closed/wall/kaizojave/wood/planks
	name = "wood plank wall"
	desc = "Timber boards settled on an sturdy frame under foglander design. The wood is waxed."
	icon = 'modular/kaizoku/icons/tileset/newwallset/woodframe/woodplank.dmi'
	frill_icon = 'modular/kaizoku/icons/tileset/newwallset/woodframe/woodplank_frill.dmi'
	max_integrity = 1180

/turf/closed/wall/kaizojave/stone
	name = "stone framed wall"
	desc = "You should not see thiiiiis..."
	wall_variety = "stone"
	climbdiff = 5
	explosion_block = 12
	hardness = 12
	burn_power = 10
	spread_chance = 0.1
	blade_dulling = DULLING_BASH
	max_integrity = 2200
	damage_deflection = 14
	break_sound = 'modular/kaizoku/sound/combat/hits/onstone/stonedeath.ogg'
	attacked_sound = list('modular/kaizoku/sound/combat/hits/onstone/wallhit.ogg', 'modular/kaizoku/sound/combat/hits/onstone/wallhit2.ogg', 'modular/kaizoku/sound/combat/hits/onstone/wallhit3.ogg')
	above_floor = /turf/open/floor/ruinedwood
	baseturfs = /turf/open/floor/ruinedwood

/turf/closed/wall/kaizojave/stone/ineffectiveattack(obj/item/W, mob/living/user)
	var/bc = user.used_intent.blade_class
	if(bc == BCLASS_CUT || bc == BCLASS_CHOP)
		return "My [W] glances off the masonry."
	return null

/turf/closed/wall/kaizojave/stone/abyssanctum
	name = "abyssanctum stone wall"
	desc = "Solid stone wall with intricate carvings for the local Abyssanctum religion. Greatly differs from pantheonism heathens."
	icon = 'modular/kaizoku/icons/tileset/newwallset/stoneframe/abyssanctum.dmi'
	frill_icon = 'modular/kaizoku/icons/tileset/newwallset/stoneframe/abyssanctum_frill.dmi'
	max_integrity = 3000
	explosion_block = 16
	hardness = 14
	damage_deflection = 20

/turf/closed/wall/kaizojave/stone/encapsulate
	name = "encapsulate wall"
	desc = "Stone foundation with clay finish at its surface, the clay is can be colored for decorative purposes."
	icon = 'modular/kaizoku/icons/tileset/newwallset/stoneframe/encapsulateneutral.dmi'
	frill_icon = 'modular/kaizoku/icons/tileset/newwallset/stoneframe/encapsulateneutral_frill.dmi'
	mergeable_connectors = FALSE
	//merge_vertical_connectors = FALSE
	max_integrity = 2400
	damage_deflection = 16

/turf/closed/wall/kaizojave/stone/kirikomihagi
	name = "kirikomihagi wall"
	desc = "Refined castle wall with rocks shaped to fit together to minimize space. No gaps for climbing fingers."
	icon = 'modular/kaizoku/icons/tileset/newwallset/stoneframe/kirikomihagi.dmi'
	frill_icon = 'modular/kaizoku/icons/tileset/newwallset/stoneframe/kirikomihagi_frill.dmi'
	max_integrity = 2800
	damage_deflection = 20
	climbdiff = 6

/turf/closed/wall/kaizojave/stone/nozurazumii
	name = "nozurazumi wall"
	desc = "Rough stone wall with loose stones that are easy to climb. Comparatively weak to other stone walls, but it is far cheaper. "
	icon = 'modular/kaizoku/icons/tileset/newwallset/stoneframe/nozurazumi.dmi'
	frill_icon = 'modular/kaizoku/icons/tileset/newwallset/stoneframe/nozurazumi_frill.dmi'
	climbdiff = 3
	max_integrity = 1600
	explosion_block = 9
	hardness = 10
	damage_deflection = 12

/turf/closed/wall/kaizojave/stone/uchikomihagi
	name = "uchikomihagi wall"
	desc = "The type of wall made of pounded stones that were smoothed afterwards. Cheaper than Kirikomihagi, yet almost as durable."
	icon = 'modular/kaizoku/icons/tileset/newwallset/stoneframe/uchikomihagi.dmi'
	frill_icon = 'modular/kaizoku/icons/tileset/newwallset/stoneframe/uchikomihagi_frill.dmi'
	max_integrity = 2400
	damage_deflection = 18

/turf/closed/wall/kaizojave/stone/towerwall
	name = "towerwall"
	desc = "The very life and blood of the Foglander nation. This self-healing wall has blood vessels, part of the island itself."
	icon = 'modular/kaizoku/icons/tileset/newwallset/zion362/towerwall.dmi'
	frill_icon = 'modular/kaizoku/icons/tileset/newwallset/zion362/towerwall_frill.dmi'
	max_integrity = 3000
	explosion_block = 16
	hardness = 14
	damage_deflection = 20

/turf/closed/wall/kaizojave/stone/hemacite
	name = "hemacite wall"
	desc = "Wall made of hemacite, the coagulated blood rich in iron and silicate of the island itself."
	icon = 'modular/kaizoku/icons/tileset/newwallset/zion362/hemacite.dmi'
	frill_icon = 'modular/kaizoku/icons/tileset/newwallset/zion362/hemacite_frill.dmi'

/turf/closed/wall/kaizojave/metal
	name = "metal framed wall"
	desc = "grrrrrr."
	wall_variety = "metal"
	climbdiff = 6
	explosion_block = 20
	hardness = 1
	blade_dulling = DULLING_BASH
	max_integrity = 60000
	damage_deflection = 30
	break_sound = 'modular/kaizoku/sound/combat/hits/onmetal/sheet (1).ogg'
	attacked_sound = list('modular/kaizoku/sound/combat/hits/onmetal/attackpipewall (1).ogg','modular/kaizoku/sound/combat/hits/onmetal/attackpipewall (2).ogg')
	above_floor = /turf/open/floor/ruinedwood
	baseturfs = /turf/open/floor/ruinedwood
	burn_power = 0
	spread_chance = 0
	murderhole_eligible = FALSE
	mergeable_connectors = FALSE
	//merge_vertical_connectors = FALSE
	resistance_flags =  FIRE_PROOF | ACID_PROOF | UNACIDABLE

/turf/closed/wall/kaizojave/metal/ineffectiveattack(obj/item/W, mob/living/user)
	var/bc = user.used_intent.blade_class
	if(bc == BCLASS_CUT || bc == BCLASS_CHOP)
		return "My [W] glances off the metal."
	return null

/turf/closed/wall/kaizojave/metal/steel
	name = "imperial bastion"
	desc = "The walls of the imperial bastion, made of solid steel. Extremely expensive and outright insane to have. Merely looking at it makes you feel poor."
	icon = 'modular/kaizoku/icons/tileset/newwallset/metalframe/steel.dmi'
	frill_icon = 'modular/kaizoku/icons/tileset/newwallset/metalframe/steel_frill.dmi'

//Unused, for now. These are ceilings.
/obj/structure/table/kaizojave/low_wall/shoji
	name = "shoji ceiling"
	desc = ""
	icon = 'modular/kaizoku/icons/tileset/newwallset/woodframe/bettershoji.dmi'

/obj/structure/table/kaizojave/low_wall/ziontowerwall
	name = "bastion upper partition"
	desc = "A self-healing stone and mortar partition."
	icon = 'modular/kaizoku/icons/tileset/newwallset/zion362/towerwall.dmi'

/obj/structure/table/kaizojave/low_wall/zion_stone
	name = "hemacite roof"
	desc = "roof with a strange, iron-like smell."
	icon = 'modular/kaizoku/icons/tileset/newwallset/zion362/hemacite.dmi'

/obj/structure/table/kaizojave/low_wall/encapsulate_neutral
	name = "encapsulate upper partition"
	desc = "An upper partition made from encapsulated stonework."
	icon = 'modular/kaizoku/icons/tileset/newwallset/stoneframe/encapsulateneutral.dmi'

/obj/structure/table/kaizojave/low_wall/abyssanctum
	name = "abyssanctum upper partition"
	desc = "An upper partition crafted from abyssal stone."
	icon = 'modular/kaizoku/icons/tileset/newwallset/stoneframe/abyssanctum.dmi'

