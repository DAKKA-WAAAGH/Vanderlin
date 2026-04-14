/// Kaizojave Door System
// VERY, VERY WIP. This cursed state is only temporary

/obj/structure/door/kaizojave
	name = "door"
	desc = "A sturdy door frame."
	icon = 'modular/kaizoku/icons/tileset/newwallset/connectors/door.dmi'
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
	break_sound = 'modular/kaizoku/sound/combat/hits/onwood/destroywalldoor.ogg'
	attacked_sound = list('modular/kaizoku/sound/combat/hits/onwood/woodimpact (1).ogg','modular/kaizoku/sound/combat/hits/onwood/woodimpact (2).ogg')
	lock = /datum/lock/key
	can_add_lock = TRUE
	smoothing_groups = SMOOTH_GROUP_KAIZOJAVE_WALL
	smoothing_list = SMOOTH_GROUP_KAIZOJAVE_WALL

	// Kaizojave-specific variables
	var/wall_type = null
	var/wall_variety = null // The variety name, like "wood", "metal", "stone". Or whatever tf
	var/icon/frill_icon = 'modular/kaizoku/icons/tileset/newwallset/connectors/door_frills.dmi'
	var/icon/connector_frill_icon = null
	var/icon/connector_overlay_icon = null
	var/door_height = 0 // Offset for height on z-plane (in case we want customized doors)
	var/door_orientation = NORTH // NORTH/SOUTH for frontal, EAST/WEST for sideways
	var/detected_walls = list() // List of detected adjacent walls
	var/detected_orientation = null // Detected door orientation from walls
	var/mutable_appearance/doorconnector_overlay = null
	var/mutable_appearance/doorconnector_frill = null
	var/mutable_appearance/doorconnector_frill_active = null
	var/mutable_appearance/doorconnectorvertical_overlay = null
	var/mutable_appearance/doorconnectorverticalceiling_overlay = null
	var/open_side_suffix = null // "left" or "right"
	var/protudetowards = EAST
	var/choosethetimerforfucksake = 3
	var/transition = null
	var/slide = FALSE
	var/kaizojaveconnector_icon = "connectorcorners_1"
	var/connectorcorner_variant = 0
	var/mergewithwalls = TRUE

/obj/structure/door/kaizojave/proc/connectorvariant(wall_state)
	if(!wall_state)
		return 1

	if(findtext(wall_state, "connectorcorners_2"))
		return 2
	if(findtext(wall_state, "connectorcorners_3"))
		return 3

	if(findtext(wall_state, "wall"))
		var/idx = findtext(wall_state, "wall") + 4
		var/state_num = text2num(copytext(wall_state, idx))
		switch(state_num)
			if(2, 5, 8, 10)
				return 2
			if(3, 6, 9, 11)
				return 3

	return 1

/obj/structure/door/kaizojave/proc/setconnectorvariant(turf/closed/wall/kaizojave/reference_wall)
	if(connectorcorner_variant > 0)
		kaizojaveconnector_icon = "connectorcorners_[connectorcorner_variant]"
		return

	var/wall_state = reference_wall ? "[reference_wall.icon_state]" : null
	var/variant = connectorvariant(wall_state)
	kaizojaveconnector_icon = "connectorcorners_[variant]"

/obj/structure/door/kaizojave/proc/getconnectorvariant()
	if(connectorcorner_variant > 0)
		return connectorcorner_variant
	if(!kaizojaveconnector_icon)
		return 1
	var/prefix = "connectorcorners_"
	if(findtext(kaizojaveconnector_icon, prefix) == 1)
		var/num_text = copytext(kaizojaveconnector_icon, length(prefix) + 1)
		var/n = text2num(num_text)
		if(n >= 1)
			return n
	return 1

/obj/structure/door/kaizojave/proc/getstateprefix()
	var/list/candidates = list()
	if(wall_variety)
		candidates += wall_variety
	return candidates

/obj/structure/door/kaizojave/proc/doorstates_active()
	for(var/prefix in getstateprefix())
		if(find_doorstate("[prefix]_door") || find_doorstate("[prefix]_door_vert") || find_doorstate("[prefix]_door_horiz"))
			return TRUE
	return FALSE

/obj/structure/door/kaizojave/proc/checkfrill(icon/source_icon, state_name)
	if(!source_icon || !state_name)
		return FALSE
	return (state_name in icon_states(source_icon))

/obj/structure/door/kaizojave/proc/get_connectorfrill_source()
	if(connector_frill_icon)
		return connector_frill_icon
	if(connector_overlay_icon)
		return connector_overlay_icon
	return frill_icon

/obj/structure/door/kaizojave/proc/find_doorstate(state_name)
	if(!icon || !state_name)
		return FALSE
	return (state_name in icon_states(icon))

/obj/structure/door/kaizojave/proc/find_connectoroverlay(state_name)
	if(!state_name)
		return FALSE
	if(connector_overlay_icon && (state_name in icon_states(connector_overlay_icon)))
		return TRUE
	if(icon && (state_name in icon_states(icon)))
		return TRUE
	return FALSE

/obj/structure/door/kaizojave/proc/get_connectoroverlay_iconsource()
	if(connector_overlay_icon)
		return connector_overlay_icon
	return icon

/obj/structure/door/kaizojave/proc/get_anotheroverlaything()
	if(!icon)
		return null

	var/variant = getconnectorvariant()
	var/is_vertical = !(door_orientation == EAST || door_orientation == WEST)
	var/list/base_candidates = list()
	if(is_vertical)
		base_candidates += "door_connectorcorner_vertical_[variant]"
		base_candidates += "door_connectorcorner_vertical"
		base_candidates += "door_connectorcorners_vertical_[variant]"
		base_candidates += "door_connectorcorners_vertical"
	else
		base_candidates += "door_connectorcorner_[variant]"
		base_candidates += "door_connectorcorner"
		base_candidates += "door_connectorcorners_[variant]"
		base_candidates += "door_connectorcorners"

	var/list/candidates = list()
	for(var/base_state in base_candidates)
		if(obj_broken)
			candidates += "[base_state]_broken"
		else if(door_opened)
			candidates += "[base_state]_open"
		candidates += base_state

	for(var/state_name in candidates)
		if(find_connectoroverlay(state_name))
			return state_name
	return null

/obj/structure/door/kaizojave/proc/update_connector_overlay()
	if(doorconnector_overlay)
		cut_overlay(doorconnector_overlay)
		doorconnector_overlay = null

	var/overlay_state = get_anotheroverlaything()
	if(!overlay_state)
		return

	var/icon/source_icon = get_connectoroverlay_iconsource()
	if(!source_icon)
		return

	var/mutable_appearance/connector_overlay = mutable_appearance(source_icon, overlay_state, layer + 0.005, plane)
	connector_overlay.appearance_flags = RESET_ALPHA
	connector_overlay.mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	doorconnector_overlay = connector_overlay
	add_overlay(doorconnector_overlay)

/obj/structure/door/kaizojave/proc/get_base_door_state_name()
	for(var/prefix in getstateprefix())
		if(door_orientation == NORTH || door_orientation == SOUTH)
			if(find_doorstate("[prefix]_door_vert"))
				return "[prefix]_door_vert"
		if(door_orientation == EAST || door_orientation == WEST)
			if(find_doorstate("[prefix]_door_horiz"))
				return "[prefix]_door_horiz"
		if(find_doorstate("[prefix]_door"))
			return "[prefix]_door"
	return null

/obj/structure/door/kaizojave/proc/get_allowed_varieties_for_wall(turf/closed/wall/kaizojave/reference_wall)
	if(!reference_wall)
		return null
	if(!islist(reference_wall.allowed_door_varieties) || !length(reference_wall.allowed_door_varieties))
		return null
	return reference_wall.allowed_door_varieties

/obj/structure/door/kaizojave/proc/is_variety_allowed_for_wall(turf/closed/wall/kaizojave/reference_wall, variety)
	if(!variety)
		return FALSE
	var/list/allowed = get_allowed_varieties_for_wall(reference_wall)
	if(!allowed)
		return TRUE
	return (variety in allowed)

/obj/structure/door/kaizojave/proc/has_door_states_for_variety(variety)
	if(!icon || !variety)
		return FALSE

	if(door_orientation == NORTH || door_orientation == SOUTH)
		if(find_doorstate("[variety]_door_vert") || find_doorstate("[variety]_door"))
			return TRUE
	else
		if(find_doorstate("[variety]_door_horiz") || find_doorstate("[variety]_door"))
			return TRUE

	return FALSE

/obj/structure/door/kaizojave/proc/choose_compatible_variety(turf/closed/wall/kaizojave/reference_wall, requested_variety)
	var/list/candidates = list()
	if(requested_variety)
		candidates += requested_variety
	if(reference_wall && reference_wall.wall_variety && !(reference_wall.wall_variety in candidates))
		candidates += reference_wall.wall_variety

	var/list/allowed = get_allowed_varieties_for_wall(reference_wall)
	if(allowed)
		for(var/allowed_variety in allowed)
			if(!(allowed_variety in candidates))
				candidates += allowed_variety

	for(var/candidate in candidates)
		if(!is_variety_allowed_for_wall(reference_wall, candidate))
			continue
		if(has_door_states_for_variety(candidate))
			return candidate

	return null

/obj/structure/door/kaizojave/proc/pick_alternate_reference_wall(turf/closed/wall/kaizojave/failed_wall)
	for(var/direction_key in detected_walls)
		var/turf/closed/wall/kaizojave/candidate = detected_walls[direction_key]
		if(!candidate || candidate == failed_wall)
			continue

		var/compatible_variety = choose_compatible_variety(candidate, candidate.wall_variety)
		if(compatible_variety)
			return candidate

	return null

/obj/structure/door/kaizojave/proc/get_open_side_suffix(mob/user)
	if(protudetowards == WEST)
		return "left"
	return "right"

/obj/structure/door/kaizojave/proc/get_open_door_state_name(base_state)
	if(!base_state)
		return null

	var/list/candidates = list()
	candidates += "[base_state]_open"

	for(var/state_name in candidates)
		if(find_doorstate(state_name))
			return state_name

	return base_state

/obj/structure/door/kaizojave/proc/uses_split_panel_door_states()
	for(var/prefix in getstateprefix())
		if(find_doorstate("[prefix]_door_vert_nonslider_left") || find_doorstate("[prefix]_door_vert_nonslider_right"))
			return TRUE
	return FALSE

/obj/structure/door/kaizojave/proc/is_vertical_protruding_mode()
	if(door_orientation == EAST || door_orientation == WEST)
		return FALSE
	return !slide

/obj/structure/door/kaizojave/proc/update_slide_mode_from_icon_states()
	slide = !uses_split_panel_door_states()

	//Checks the slider. If the overlay exists, uses protuding behavior.
	// If not, you are a SLIDER

/obj/structure/door/kaizojave/proc/play_open_close_animation(is_opening)
	if(is_vertical_protruding_mode())
		return

	var/base_state = get_base_door_state_name()
	transition = is_opening ? "opening" : "closing"
	update_appearance(UPDATE_ICON_STATE)

	if(base_state)
		var/transition_state = is_opening ? "opening" : "closing"
		var/list/anim_candidates = list(
			"[base_state]_[transition_state]",
			"[base_state]_[transition_state]_animated"
		)
		for(var/candidate in anim_candidates)
			if(find_doorstate(candidate))
				flick(candidate, src)
				break

	sleep(choosethetimerforfucksake)
	transition = null

/obj/structure/door/kaizojave/proc/pick_protudetowards(mob/user)
	if(user)
		var/user_side = get_dir(src, user)
		if(user_side == EAST || user_side == WEST)
			return user_side
		switch(user.dir)
			if(EAST)
				return EAST
			if(WEST)
				return WEST

	return pick(EAST, WEST)

/obj/structure/door/kaizojave/proc/get_open_protudetowards(mob/user, push_mode = FALSE, prefer_facing_for_push = FALSE)
	if(!user)
		return pick_protudetowards(null)

	if(push_mode && prefer_facing_for_push)
		var/approach_dir = get_dir(user, src)
		switch(approach_dir)
			if(EAST)
				return WEST
			if(WEST)
				return EAST
		switch(user.dir)
			if(EAST)
				return WEST
			if(WEST)
				return EAST

	var/user_side = get_dir(src, user)
	if(user_side == EAST)
		return push_mode ? WEST : EAST
	if(user_side == WEST)
		return push_mode ? EAST : WEST

	switch(user.dir)
		if(EAST)
			return push_mode ? WEST : EAST
		if(WEST)
			return push_mode ? EAST : WEST

	return pick_protudetowards(null)

/obj/structure/door/kaizojave/proc/update_protrusion_offset()
	// Keep the main door sprite anchored; protrusion visuals are handled entirely by overlay states.
	pixel_x = 0

/obj/structure/door/kaizojave/proc/can_kick_force_open_from_side(mob/living/user)
	if(!user || locked() || door_opened)
		return FALSE
	if(!is_vertical_protruding_mode())
		return FALSE

	var/user_side = get_dir(src, user)
	return (user_side == EAST || user_side == WEST)

/obj/structure/door/kaizojave/proc/handle_kick_open_collision(mob/living/aggressor)
	if(!aggressor)
		return

	var/turf/impact_turf = get_step(src, protudetowards)
	if(!impact_turf)
		return

	var/mob/living/victim = null
	for(var/mob/living/L in impact_turf)
		if(L == aggressor)
			continue
		victim = L
		break

	if(!victim)
		return

	var/attacker_power = (aggressor.STASTR || 10)
	var/victim_power = (victim.STACON || 10)
	var/power_delta = attacker_power - victim_power

	if(victim_power - attacker_power >= 2) //Found an victim. The victim has more +2 over the attacker's str
		aggressor.adjustBruteLoss(rand(10, 30))
		aggressor.Knockdown(2 SECONDS)
		to_chat(aggressor, span_warning("My leg buckles! The door has resisted my kick!"))
		to_chat(victim, span_notice("The door hits me, but I barely felt it."))
		return

	if(victim_power - attacker_power == 1) // one little point of difference.
		aggressor.OffBalance(5)
		aggressor.adjustBruteLoss(rand(4, 16))
		to_chat(aggressor, span_warning("I hurt my leg trying to kick this door."))
		to_chat(victim, span_notice("The door slams against me, yet I hold my ground."))
		return

	if(power_delta == 0)
		aggressor.OffBalance(5) //Both are off-balance.
		victim.OffBalance(5)
		to_chat(aggressor, span_notice("I stagger as the door resists my kick."))
		to_chat(victim, span_notice("I've staggered as the door hits me."))
		return

	if(power_delta > 0)
		victim.visible_message(span_danger("[victim] is slammed!"), span_userdanger("The door slams into me!"))
		if(power_delta > 3) //Attacker is stronger, with significant advantage of 3.
			var/turf/push_target = get_step(victim, protudetowards)
			if(push_target)
				victim.throw_at(push_target, 1, 1, aggressor)
			victim.Knockdown(2 SECONDS)
			to_chat(victim, span_warning("I lose my footing!"))
			return
		victim.Stun(1 SECONDS)
		victim.OffBalance(6)
		return

/obj/structure/door/kaizojave/proc/resolve_door_frill_state(base_state, icon/source_icon = null)
	if(!base_state)
		return null
	if(!source_icon)
		source_icon = frill_icon
	if(!source_icon)
		return null

	var/list/candidates = list()
	if(transition)
		candidates += "[base_state]_[transition]"
	if(obj_broken)
		candidates += "[base_state]_broken"
	if(door_opened)
		candidates += "[base_state]_open"
	candidates += base_state

	for(var/candidate in candidates)
		if(checkfrill(source_icon, candidate))
			return candidate

	return null

/obj/structure/door/kaizojave/proc/add_resolved_frill_overlay(state_name, layer_offset = 0, icon/source_icon = null)
	if(!source_icon)
		source_icon = frill_icon
	if(!state_name || !source_icon)
		return null
	var/mutable_appearance/frill = mutable_appearance(source_icon, state_name, ABOVE_MOB_LAYER + layer_offset, OVER_FRILL_PLANE)
	frill.pixel_y = 32
	frill.appearance_flags = RESET_ALPHA
	frill.mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	add_overlay(frill)
	return frill

/obj/structure/door/kaizojave/Initialize(mapload)
	. = ..()
	door_orientation = (dir == EAST || dir == WEST) ? EAST : NORTH
	protudetowards = mapload ? pick(EAST, WEST) : pick_protudetowards(null)
	var/turf/current_turf = get_turf(src)
	if(current_turf)
		for(var/obj/structure/flora/flora in current_turf)
			qdel(flora)
	if(!mapload)
		try_detect_and_configure()
	else if(mapload && !wall_type)
		try_detect_and_configure()
	update_appearance(UPDATE_ICON_STATE)
	if(frill_icon)
		update_door_frill()
	update_adjacent_walls() //Smooth up with doors and adjust frills accordingly

	return INITIALIZE_HINT_NORMAL

/obj/structure/door/kaizojave/proc/update_door_frill() //Frill overlay based on orientation
	var/icon/material_frill_icon = frill_icon
	var/icon/connector_source_icon = get_connectorfrill_source()
	if(!material_frill_icon && !connector_source_icon)
		if(doorconnector_frill)
			cut_overlay(doorconnector_frill)
			doorconnector_frill = null
		if(doorconnector_frill_active)
			cut_overlay(doorconnector_frill_active)
			doorconnector_frill_active = null
		return

	if(doorconnector_frill)
		cut_overlay(doorconnector_frill)
		doorconnector_frill = null
	if(doorconnector_frill_active)
		cut_overlay(doorconnector_frill_active)
		doorconnector_frill_active = null

	var/is_vertical = !(door_orientation == EAST || door_orientation == WEST)
	var/variant = getconnectorvariant()

	var/material_frill_state = null
	var/list/material_candidates = list()
	for(var/prefix in getstateprefix())
		if(is_vertical)
			material_candidates += "[prefix]_doorfrill_vert"
			material_candidates += "[prefix]_door_frills_vert_[variant]"
			material_candidates += "[prefix]_door_frills_vert"
			material_candidates += "[prefix]_door_frill_vert"
		else
			material_candidates += "[prefix]_doorfrill_horiz"
			material_candidates += "[prefix]_doorfrill"
			material_candidates += "[prefix]_door_frills_[variant]"
			material_candidates += "[prefix]_door_frills"
			material_candidates += "[prefix]_door_frill"
	for(var/candidate in material_candidates)
		material_frill_state = resolve_door_frill_state(candidate, material_frill_icon)
		if(material_frill_state)
			break

	var/connector_frill_state = null
	var/list/connector_candidates = list()
	if(is_vertical)
		connector_candidates += "door_connectorcorner_vertical_[variant]"
		connector_candidates += "door_connectorcorner_vertical"
		connector_candidates += "door_connectorcorners_vertical_[variant]"
		connector_candidates += "door_connectorcorners_vertical"
	else
		connector_candidates += "door_connectorcorner_[variant]"
		connector_candidates += "door_connectorcorner"
		connector_candidates += "door_connectorcorners_[variant]"
		connector_candidates += "door_connectorcorners"
	for(var/candidate in connector_candidates)
		connector_frill_state = resolve_door_frill_state(candidate, connector_source_icon)
		if(connector_frill_state)
			break

	if(!material_frill_state && !connector_frill_state)
		return

	if(material_frill_state)
		doorconnector_frill = add_resolved_frill_overlay(material_frill_state, 0, material_frill_icon)
	if(connector_frill_state)
		var/connector_layer_offset = material_frill_state ? 0.01 : 0
		doorconnector_frill_active = add_resolved_frill_overlay(connector_frill_state, connector_layer_offset, connector_source_icon)

/obj/structure/door/kaizojave/proc/resolve_vertical_overlay_state()
	if(door_orientation == EAST || door_orientation == WEST)
		return null
	if(!door_opened)
		return null
	if(obj_broken)
		return null
	var/side = (protudetowards == WEST) ? "right" : "left"
	for(var/prefix in getstateprefix())
		var/sided_state = "[prefix]_door_vert_nonslider_[side]"
		if(find_doorstate(sided_state))
			return sided_state

	for(var/prefix in getstateprefix())
		var/list/candidates = list()
		if(obj_broken)
			candidates += "[prefix]_door_vert_broken_overlay_[side]"
			candidates += "[prefix]_door_vert_broken_overlay"
		else
			candidates += "[prefix]_door_vert_overlay_[side]"
			candidates += "[prefix]_door_vert_overlay"
		for(var/c in candidates)
			if(find_doorstate(c))
				return c

	return null

/obj/structure/door/kaizojave/proc/resolve_vertical_ceiling_overlay_state()
	if(door_orientation == EAST || door_orientation == WEST)
		return null
	if(!door_opened)
		return null
	if(obj_broken)
		return null

	for(var/prefix in getstateprefix())
		var/ceiling_state = "[prefix]_door_vert_overlay"
		if(find_doorstate(ceiling_state))
			return ceiling_state

	return null

/obj/structure/door/kaizojave/proc/update_vertical_door_overlay()
	if(doorconnectorvertical_overlay)
		cut_overlay(doorconnectorvertical_overlay)
		doorconnectorvertical_overlay = null
	if(doorconnectorverticalceiling_overlay)
		cut_overlay(doorconnectorverticalceiling_overlay)
		doorconnectorverticalceiling_overlay = null

	if(!icon)
		return

	if(door_orientation == EAST || door_orientation == WEST)
		return

	var/overlay_state = resolve_vertical_overlay_state()
	if(overlay_state)
		var/overlay_layer = ABOVE_ALL_MOB_LAYER
		var/overlay_plane = GAME_PLANE_UPPER
		if(findtext(overlay_state, "_right"))
			overlay_layer = BELOW_MOB_LAYER
			overlay_plane = GAME_PLANE
		var/mutable_appearance/vert_overlay = mutable_appearance(icon, overlay_state, overlay_layer, overlay_plane)
		vert_overlay.pixel_x = (protudetowards == WEST) ? -16 : 16
		vert_overlay.appearance_flags = RESET_ALPHA
		vert_overlay.mouse_opacity = MOUSE_OPACITY_TRANSPARENT
		doorconnectorvertical_overlay = vert_overlay
		add_overlay(doorconnectorvertical_overlay)

	var/ceiling_overlay_state = resolve_vertical_ceiling_overlay_state()
	if(!ceiling_overlay_state)
		return

	var/mutable_appearance/ceiling_overlay = mutable_appearance(icon, ceiling_overlay_state, ABOVE_ALL_MOB_LAYER + 0.001, GAME_PLANE_UPPER)
	ceiling_overlay.appearance_flags = RESET_ALPHA
	ceiling_overlay.mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	doorconnectorverticalceiling_overlay = ceiling_overlay
	add_overlay(doorconnectorverticalceiling_overlay)

/obj/structure/door/kaizojave/proc/add_horizontal_door_frill()
	var/icon/material_frill_icon = frill_icon
	var/icon/connector_source_icon = get_connectorfrill_source()
	if(!material_frill_icon && !connector_source_icon)
		if(doorconnector_frill)
			cut_overlay(doorconnector_frill)
			doorconnector_frill = null
		if(doorconnector_frill_active)
			cut_overlay(doorconnector_frill_active)
			doorconnector_frill_active = null
		return

	if(doorconnector_frill)
		cut_overlay(doorconnector_frill)
		doorconnector_frill = null
	if(doorconnector_frill_active)
		cut_overlay(doorconnector_frill_active)
		doorconnector_frill_active = null

	var/variant = getconnectorvariant()
	var/material_frill_state = null
	var/list/material_candidates = list()
	for(var/prefix in getstateprefix())
		material_candidates += "[prefix]_doorfrill_horiz"
		material_candidates += "[prefix]_doorfrill"
		material_candidates += "[prefix]_door_frills_[variant]"
		material_candidates += "[prefix]_door_frills"
		material_candidates += "[prefix]_door_frill"
	for(var/candidate in material_candidates)
		material_frill_state = resolve_door_frill_state(candidate, material_frill_icon)
		if(material_frill_state)
			break

	var/connector_frill_state = null
	var/list/connector_candidates = list(
		"door_connectorcorner_[variant]",
		"door_connectorcorner",
		"door_connectorcorners_[variant]",
		"door_connectorcorners"
	)
	for(var/candidate in connector_candidates)
		connector_frill_state = resolve_door_frill_state(candidate, connector_source_icon)
		if(connector_frill_state)
			break

	if(!material_frill_state && !connector_frill_state)
		return

	if(material_frill_state)
		doorconnector_frill = add_resolved_frill_overlay(material_frill_state, 0, material_frill_icon)
	if(connector_frill_state)
		var/connector_layer_offset = material_frill_state ? 0.01 : 0
		doorconnector_frill_active = add_resolved_frill_overlay(connector_frill_state, connector_layer_offset, connector_source_icon)

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

	var/behind_dir = turn(dir, 180)
	var/right_dir = turn(dir, 90)
	var/left_dir = turn(dir, -90)

	var/turf/closed/wall/kaizojave/behind_wall = detected_walls["[behind_dir]"]
	var/turf/closed/wall/kaizojave/right_wall = detected_walls["[right_dir]"]
	var/turf/closed/wall/kaizojave/left_wall = detected_walls["[left_dir]"]

	var/turf/closed/wall/kaizojave/wall_reference = null
	if(behind_wall)
		wall_reference = behind_wall
	else if(right_wall && left_wall)
		if(right_wall.wall_variety != left_wall.wall_variety)
			wall_reference = pick(right_wall, left_wall)
		else
			wall_reference = right_wall
	else if(right_wall)
		wall_reference = right_wall
	else if(left_wall)
		wall_reference = left_wall
	else if(north_wall)
		wall_reference = north_wall
	else if(south_wall)
		wall_reference = south_wall
	else if(east_wall)
		wall_reference = east_wall
	else if(west_wall)
		wall_reference = west_wall
	if(!wall_reference)
		return FALSE

	if((east_wall || west_wall) && !(north_wall || south_wall))
		detected_orientation = EAST
	else if((north_wall || south_wall) && !(east_wall || west_wall))
		detected_orientation = NORTH
	else
		detected_orientation = (dir == EAST || dir == WEST) ? EAST : NORTH

	if(north_wall && south_wall && east_wall && west_wall)
		return FALSE

	var/wall_type_path = wall_reference.type
	wall_type = wall_type_path
	return setup_from_wall(wall_reference)

/obj/structure/door/kaizojave/proc/setup_from_wall(turf/closed/wall/kaizojave/reference_wall)
	if(!reference_wall)
		return FALSE
	var/requested_variety = wall_variety

	if(detected_orientation)
		door_orientation = detected_orientation
	else
		door_orientation = (dir == EAST || dir == WEST) ? EAST : NORTH

	wall_type = reference_wall.type
	setconnectorvariant(reference_wall)
	connector_overlay_icon = reference_wall.icon
	connector_frill_icon = reference_wall.frill_icon

	// Start from connector icon-state families defined on the door itself.
	icon = initial(icon)
	if(!doorstates_active() && reference_wall.icon)
		icon = reference_wall.icon
	if(requested_variety)
		wall_variety = requested_variety
	else if(reference_wall.wall_variety)
		wall_variety = reference_wall.wall_variety
	update_slide_mode_from_icon_states()

	if(reference_wall && reference_wall.vars && reference_wall.vars["door_height"])
		door_height = reference_wall.vars["door_height"]

	return TRUE

/obj/structure/door/kaizojave/Destroy()
	if(doorconnector_overlay)
		cut_overlay(doorconnector_overlay)
		doorconnector_overlay = null
	if(doorconnectorvertical_overlay)
		cut_overlay(doorconnectorvertical_overlay)
		doorconnectorvertical_overlay = null
	if(doorconnectorverticalceiling_overlay)
		cut_overlay(doorconnectorverticalceiling_overlay)
		doorconnectorverticalceiling_overlay = null
	if(doorconnector_frill)
		cut_overlay(doorconnector_frill)
		doorconnector_frill = null
	if(doorconnector_frill_active)
		cut_overlay(doorconnector_frill_active)
		doorconnector_frill_active = null
	cleanup_adjacent_walls()
	return ..()

/obj/structure/door/kaizojave/atom_break(damage_flag, silent)
	. = ..()
	update_appearance(UPDATE_ICON_STATE)

/obj/structure/door/kaizojave/atom_fix()
	. = ..()
	update_appearance(UPDATE_ICON_STATE)

/obj/structure/door/kaizojave/proc/cleanup_adjacent_walls()
	for(var/direction in list(NORTH, SOUTH, EAST, WEST))
		var/turf/adjacent = get_step(src, direction)
		if(!adjacent)
			continue
		if(istype(adjacent, /turf/closed/wall/kaizojave))
			var/turf/closed/wall/kaizojave/wall = adjacent
			if(wall.frill_icon)
				wall.RemoveElement(/datum/element/frill, wall.frill_icon)
				if(!wall.check_suppress_frill_for_doors_windows())
					wall.AddElement(/datum/element/frill, wall.frill_icon)
			QUEUE_SMOOTH(wall)

/obj/structure/door/kaizojave/update_appearance(updates)
	. = ..()
	if(updates & UPDATE_ICON_STATE)
		update_icon_state()
		update_protrusion_offset()
		update_connector_overlay()
		update_door_frill()
		update_vertical_door_overlay()

/obj/structure/door/kaizojave/update_icon_state()
	. = ..()
	if(!wall_variety && !kaizojaveconnector_icon) //fallback
		icon_state = "door"
		return

	var/base_state = get_base_door_state_name()
	if(!base_state)
		icon_state = "door"
		return

	if(obj_broken)
		icon_state = "[base_state]_broken"
	else if(is_vertical_protruding_mode())
		icon_state = door_opened ? get_open_door_state_name(base_state) : base_state
	else if(door_opened)
		icon_state = get_open_door_state_name(base_state)
	else
		icon_state = base_state

/obj/structure/door/kaizojave/attack_hand(mob/user)
	if(obj_broken)
		to_chat(user, "<span class='warning'>The door is broken!</span>")
		return
	if(switching_states)
		return
	if(locked())
		rattle()
		return
	if(door_opened)
		close_door(user)
	else
		open_door(user)

/obj/structure/door/kaizojave/attack_hand_secondary(mob/user, params)
	attack_hand(user)
	return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN

/obj/structure/door/kaizojave/Bumped(atom/movable/AM)
	. = ..()
	if(!isliving(AM))
		return
	if(obj_broken || switching_states || door_opened)
		return
	if(locked())
		rattle()
		return
	open_door(AM, TRUE, TRUE)

/obj/structure/door/kaizojave/proc/open_door(mob/user, push_mode = FALSE, prefer_facing_for_push = FALSE)
	if(switching_states || door_opened)
		return
	switching_states = TRUE
	if(is_vertical_protruding_mode())
		protudetowards = get_open_protudetowards(user, push_mode, prefer_facing_for_push)
	open_side_suffix = get_open_side_suffix(user)
	transition = null
	if(!windowed)
		set_opacity(FALSE)
	playsound(src, 'modular/kaizoku/sound/foley/doors/shittyopen.ogg', 50, TRUE)
	play_open_close_animation(TRUE)
	density = FALSE
	door_opened = TRUE
	layer = OPEN_DOOR_LAYER
	update_appearance(UPDATE_ICON_STATE)
	switching_states = FALSE
	update_adjacent_walls()
	air_update_turf(TRUE)

/obj/structure/door/kaizojave/proc/close_door(mob/user)
	if(switching_states || !door_opened)
		return
	for(var/mob/living/L in get_turf(src))
		return
	switching_states = TRUE
	transition = null
	if(!windowed)
		set_opacity(TRUE)
	playsound(src, 'modular/kaizoku/sound/foley/doors/shittyclose.ogg', 50, TRUE)
	play_open_close_animation(FALSE)
	density = TRUE
	door_opened = FALSE
	layer = CLOSED_DOOR_LAYER
	open_side_suffix = get_open_side_suffix(user)
	update_appearance(UPDATE_ICON_STATE)
	switching_states = FALSE
	update_adjacent_walls()
	air_update_turf(TRUE)

/obj/structure/door/kaizojave/OnCrafted(dirin, user)
	. = ..()
	if(user)
		protudetowards = pick_protudetowards(user)
	else
		protudetowards = pick_protudetowards(null)
	open_side_suffix = get_open_side_suffix(user)
	update_appearance(UPDATE_ICON_STATE)

/obj/structure/door/kaizojave/onkick(mob/user)
	if(obj_broken || switching_states)
		return
	if(slide)
		playsound(src, pick(attacked_sound), 100)
		user.visible_message(span_warning("[user] kicks [src], but it does not budge."), span_notice("I kick [src], but it does not budge."))
		return

	if(door_opened)
		if(isliving(user))
			var/mob/living/L = user
			playsound(src, 'modular/kaizoku/sound/items/weapons/thudswoosh.ogg', 50, TRUE)
			user.visible_message(span_warning("[user] kicks at [src], the leg swinging through nothing."), span_notice("I tried to kick this, but the momentum carried me too far..."))
			L.Knockdown(2 SECONDS)
		return

	if(!isliving(user))
		return ..()

	var/mob/living/L = user
	if(!locked() && can_kick_force_open_from_side(L))
		playsound(src, pick(attacked_sound), 100)
		user.visible_message(span_warning("[user] kicks [src] open!"), span_notice("I kick [src] open!"))
		handle_kick_open_collision(L)
		open_door(L, TRUE)
		return

	if(!locked() && is_vertical_protruding_mode())
		playsound(src, pick(attacked_sound), 100)
		user.visible_message(span_warning("[user] kicks [src], but it resists from this side!"), span_notice("I kick [src], but it does not swing from this side."))
		take_damage(35, BRUTE, BCLASS_BLUNT, TRUE)
		return

	return ..()

/obj/structure/door/kaizojave/wood
	name = "wooden door"
	desc = "A sturdy wooden door."
	wall_variety = "wood"
	connectorcorner_variant = 1
	mergewithwalls = TRUE

/obj/structure/door/kaizojave/shoji
	name = "shoji door"
	wall_variety = "shoji"
	connectorcorner_variant = 4
	mergewithwalls = FALSE

/obj/structure/door/kaizojave/stone
	name = "stone door"
	wall_variety = "stone"
	connectorcorner_variant = 1
	mergewithwalls = TRUE

/obj/structure/door/kaizojave/iron
	name = "iron door"
	wall_variety = "iron"
	connectorcorner_variant = 1
	mergewithwalls = TRUE

/obj/structure/door/kaizojave/steel
	name = "steel door"
	wall_variety = "steel"
	connectorcorner_variant = 2
	mergewithwalls = FALSE

/obj/structure/door/kaizojave/ornamented
	name = "ornamented door"
	wall_variety = "ornamented"
	connectorcorner_variant = 1
	mergewithwalls = TRUE

/obj/structure/door/kaizojave/glassed
	name = "glassed door"
	wall_variety = "glassed"
	connectorcorner_variant = 3
	mergewithwalls = TRUE

/obj/structure/door/kaizojave/roughwood
	name = "roughwood door"
	wall_variety = "roughwood"
	connectorcorner_variant = 3
	mergewithwalls = TRUE

/obj/structure/door/kaizojave/banded
	name = "banded door"
	wall_variety = "banded"
	connectorcorner_variant = 3
	mergewithwalls = TRUE
