/// Kaizojave Window System
// VERY, VERY WIP. This cursed state is only temporary

/obj/structure/window/kaizojave
	name = "window"
	desc = "A very, very wip window which I am still suffering to make."
	icon = 'modular/kaizoku/icons/tileset/newwallset/connectors/window.dmi'
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
	attacked_sound = 'modular/kaizoku/sound/combat/hits/onglass/glasshit.ogg'
	break_sound = "glassbreak"
	destroy_sound = 'modular/kaizoku/sound/combat/hits/onwood/destroywalldoor.ogg'
	smoothing_groups = SMOOTH_GROUP_KAIZOJAVE_WALL
	smoothing_list = SMOOTH_GROUP_KAIZOJAVE_WALL

	var/wall_type = null
	var/wall_variety = null
	var/icon/frill_icon = 'modular/kaizoku/icons/tileset/newwallset/connectors/window_frill.dmi'
	var/icon/connector_frill_icon = null
	var/window_height = 0
	var/window_orientation = NORTH
	var/lock_on_both_sides = FALSE // if true, then either side is valid. Don't caaare
	var/detected_walls = list()
	var/detected_orientation = null
	var/can_open_close = TRUE
	var/requires_open_side = TRUE
	var/is_glass_window = FALSE
	var/preserve_subtype_wall_variety = FALSE
	var/broken_glass_cleared = FALSE
	var/glass_embed_chance = 45
	var/glass_armor_protection_threshold = 50
	var/glass_cleanup_time = 1.6 SECONDS
	var/cleanup_fail_base_chance = 0
	var/crossing_clears_glass = TRUE
	var/crossing_embed_enabled = TRUE
	var/crossing_ignores_armor = FALSE
	var/shard_item_type = /obj/item/natural/glass_shard
	var/shard_debris_type = /obj/effect/decal/cleanable/debris/glass
	var/shard_projectile_type = /obj/projectile/bullet/glass
	var/icon/connector_overlay_icon = null //This is the icon used for connectorcorner details.
	var/mutable_appearance/active_window_connector_overlay = null
	var/mutable_appearance/active_window_frill = null
	var/mutable_appearance/active_window_connector_frill = null
	var/connectorcorner_variant = 0 //Chooses window variant. 0 is for auto-detect. 1/2/3 if the spriter made the walls to specifically have one type.
	var/connectorcorner_detail = null //Optional for details.
	var/mutable_appearance/kaizojavedetail = null
	var/window_anim_time = 3
	var/window_frill_transition = null
	var/kaizojaveconnector_icon = "connectorcorners_1" //Smooth base state. Sourced from other walls.
	var/mergewithwalls = TRUE //If false, the windows will not be considered mergeable.

/obj/structure/window/kaizojave/proc/connectorvariant(wall_state)
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

/obj/structure/window/kaizojave/proc/setconnectorvariant(turf/closed/wall/kaizojave/reference_wall)
	if(connectorcorner_variant > 0)
		kaizojaveconnector_icon = "connectorcorners_[connectorcorner_variant]"
		return

	var/wall_state = reference_wall ? "[reference_wall.icon_state]" : null
	var/variant = connectorvariant(wall_state)
	kaizojaveconnector_icon = "connectorcorners_[variant]"

/obj/structure/window/kaizojave/proc/getconnectorvariant()
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

/obj/structure/window/kaizojave/proc/getstateprefix()
	var/list/candidates = list()
	if(wall_variety)
		candidates += wall_variety
	return candidates

/obj/structure/window/kaizojave/proc/window_state_exists(state_name)
	if(!icon || !state_name)
		return FALSE
	return (state_name in icon_states(icon))

/obj/structure/window/kaizojave/proc/find_connectoroverlay(state_name)
	if(!state_name)
		return FALSE
	if(connector_overlay_icon && (state_name in icon_states(connector_overlay_icon)))
		return TRUE
	if(icon && (state_name in icon_states(icon)))
		return TRUE
	return FALSE

/obj/structure/window/kaizojave/proc/has_any_usable_window_states()
	for(var/prefix in getstateprefix())
		if(window_state_exists("[prefix]_window") || window_state_exists("[prefix]_window_vert") || window_state_exists("[prefix]_window_horiz"))
			return TRUE
	return FALSE

/obj/structure/window/kaizojave/proc/get_base_window_state_name()
	for(var/prefix in getstateprefix())
		if(window_orientation == NORTH || window_orientation == SOUTH)
			if(window_state_exists("[prefix]_window_vert"))
				return "[prefix]_window_vert"
		if(window_orientation == EAST || window_orientation == WEST)
			if(window_state_exists("[prefix]_window_horiz"))
				return "[prefix]_window_horiz"
		if(window_state_exists("[prefix]_window"))
			return "[prefix]_window"
	return null

/obj/structure/window/kaizojave/proc/get_cleared_window_connector_state()
	var/variant = getconnectorvariant()
	var/list/candidates = list()
	if(window_orientation == NORTH || window_orientation == SOUTH)
		candidates += "window_connectorcorner_vertical_[variant]"
		candidates += "window_connectorcorner_vertical"
	else
		candidates += "window_connectorcorner_[variant]"
		candidates += "window_connectorcorner"
	for(var/state_name in candidates)
		if(find_connectoroverlay(state_name))
			return state_name
	return null

/obj/structure/window/kaizojave/proc/get_connectorcorner_overlay_state()
	if(!icon)
		return null

	var/variant = getconnectorvariant()
	var/is_vertical = (window_orientation == NORTH || window_orientation == SOUTH)
	var/list/base_candidates = list()
	if(is_vertical)
		base_candidates += "window_connectorcorner_vertical_[variant]"
		base_candidates += "window_connectorcorner_vertical"
	else
		base_candidates += "window_connectorcorner_[variant]"
		base_candidates += "window_connectorcorner"

	var/list/candidates = list()
	for(var/base_state in base_candidates)
		if(obj_broken)
			candidates += "[base_state]_broken"
		else if(climbable)
			candidates += "[base_state]_open"
		candidates += base_state

	for(var/state_name in candidates)
		if(find_connectoroverlay(state_name))
			return state_name
	return null

/obj/structure/window/kaizojave/proc/get_connectorcorner_detail_state()
	if(!connectorcorner_detail)
		return null
	if(!icon)
		return null
	if(obj_broken && is_glass_window && broken_glass_cleared)
		return null

	var/orientation_name = (window_orientation == EAST || window_orientation == WEST) ? "horizontal" : "vertical"
	var/base_state = "connectorcorner_detail[connectorcorner_detail]_[orientation_name]"
	var/list/candidates = list()
	if(obj_broken)
		candidates += "[base_state]_broken"
	else if(climbable)
		candidates += "[base_state]_open"
	candidates += base_state

	for(var/state_name in candidates)
		if(find_connectoroverlay(state_name))
			return state_name
	return null

/obj/structure/window/kaizojave/proc/get_connectoroverlay_iconsource()
	if(connector_overlay_icon)
		return connector_overlay_icon
	return icon

/obj/structure/window/kaizojave/proc/update_connectorcorner_overlay()
	if(active_window_connector_overlay)
		cut_overlay(active_window_connector_overlay)
		active_window_connector_overlay = null

	var/overlay_state = get_connectorcorner_overlay_state()
	if(!overlay_state)
		return

	var/icon/source_icon = get_connectoroverlay_iconsource()
	if(!source_icon)
		return

	var/mutable_appearance/connector_overlay = mutable_appearance(source_icon, overlay_state, layer - 0.01, plane)
	connector_overlay.appearance_flags = RESET_ALPHA
	connector_overlay.mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	active_window_connector_overlay = connector_overlay
	add_overlay(active_window_connector_overlay)

/obj/structure/window/kaizojave/proc/update_connectorcorner_detail_overlay()
	if(kaizojavedetail)
		cut_overlay(kaizojavedetail)
		kaizojavedetail = null

	var/detail_state = get_connectorcorner_detail_state()
	if(!detail_state)
		return

	var/icon/source_icon = get_connectoroverlay_iconsource()
	if(!source_icon)
		return

	var/mutable_appearance/detail_overlay = mutable_appearance(source_icon, detail_state, layer + 0.01, plane)
	detail_overlay.appearance_flags = RESET_ALPHA
	detail_overlay.mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	kaizojavedetail = detail_overlay
	add_overlay(kaizojavedetail)

/obj/structure/window/kaizojave/Initialize(mapload)
	. = ..()
	var/turf/current_turf = get_turf(src)
	if(current_turf)
		for(var/obj/structure/flora/flora in current_turf)
			qdel(flora)
		if(!lockdir)
			lockdir = dir
	if(!mapload)
		try_detect_and_configure()
	else if(mapload && !wall_type)
		try_detect_and_configure()
	update_appearance(UPDATE_ICON_STATE)
	if(frill_icon)
		update_window_frill()
	refresh_linked_walls()

	return INITIALIZE_HINT_NORMAL

/obj/structure/window/kaizojave/attack_hand_secondary(mob/user, params)
	. = ..()
	if(. == SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN)
		return

	if(obj_broken)
		if(is_glass_window)
			if(crossing_clears_glass && get_turf(user) == get_turf(src))
				if(!broken_glass_cleared)
					clear_broken_glass(user, FALSE)
				to_chat(user, span_notice("The broken pane is already clear enough to pass through."))
				return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN
			if(!broken_glass_cleared)
				to_chat(user, span_notice("I begin removing the shattered glass from the frame..."))
				if(!do_after(user, glass_cleanup_time, src))
					return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN
				if(!obj_broken || broken_glass_cleared)
					to_chat(user, span_notice("The shards are already gone."))
					return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN
				if(prob(get_cleanup_fail_chance(user)))
					hurt_cleanup_hand(user)
					to_chat(user, span_warning("I fumble and slice my hand on the shards, failing to clear them."))
					return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN
				clear_broken_glass(user, TRUE)
			else
				to_chat(user, span_warning("The broken glass has already been cleared."))
		else
			to_chat(user, "<span class='warning'>It's broken, that would be foolish.</span>")
		return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN

	if(!can_open_close)
		to_chat(user, span_warning("This window cannot be opened."))
		return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN

	if(requires_open_side && !can_use_open_side(user))
		to_chat(user, "<span class='warning'>The window doesn't close from this side.</span>")
		return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN

	if(climbable)
		close_up(user)
	else
		open_up(user)

	return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN

/obj/structure/window/kaizojave/proc/can_use_open_side(mob/user)
	if(!user)
		return FALSE

	var/relative_dir = get_dir(src, user)
	var/list/valid_dirs = get_valid_lock_dirs()
	if(!valid_dirs.len)
		return FALSE

	if(lock_on_both_sides)
		return (relative_dir in valid_dirs)

	return (relative_dir == get_effective_lockdir())

/obj/structure/window/kaizojave/proc/get_valid_lock_dirs()
	if(window_orientation == NORTH || window_orientation == SOUTH)
		return list(EAST, WEST)
	if(window_orientation == EAST || window_orientation == WEST)
		return list(NORTH, SOUTH)
	return list(NORTH, SOUTH, EAST, WEST)

/obj/structure/window/kaizojave/proc/get_effective_lockdir()
	var/list/valid_dirs = get_valid_lock_dirs()
	if(lockdir in valid_dirs)
		return lockdir
	if(dir in valid_dirs)
		return dir
	return valid_dirs[1]

/obj/structure/window/kaizojave/open_up(mob/user)
	. = ..()
	if(!obj_broken)
		window_frill_transition = "opening"
		update_window_frill()
		sleep(window_anim_time)
		window_frill_transition = null
	update_window_frill()
	update_connectorcorner_detail_overlay()
	refresh_linked_walls()

/obj/structure/window/kaizojave/close_up(mob/user)
	. = ..()
	if(!obj_broken)
		window_frill_transition = "closing"
		update_window_frill()
		sleep(window_anim_time)
		window_frill_transition = null
	update_window_frill()
	update_connectorcorner_detail_overlay()
	if(istype(src, /obj/structure/window/kaizojave/solid) && !obj_broken)
		opacity = TRUE
	refresh_linked_walls()

/obj/structure/window/kaizojave/atom_break(damage_flag, silent)
	. = ..()
	broken_glass_cleared = FALSE
	opacity = FALSE
	update_window_frill()
	update_connectorcorner_detail_overlay()
	refresh_linked_walls()

/obj/structure/window/kaizojave/atom_fix()
	. = ..()
	broken_glass_cleared = FALSE
	if(istype(src, /obj/structure/window/kaizojave/solid) && !climbable)
		opacity = TRUE
	update_window_frill()
	update_connectorcorner_detail_overlay()
	refresh_linked_walls()

/obj/structure/window/kaizojave/CanAllowThrough(atom/movable/mover, turf/target)
	. = ..()
	if(!is_glass_window || !obj_broken || broken_glass_cleared)
		return
	if(!isliving(mover))
		return
	addtimer(CALLBACK(src, PROC_REF(handle_forced_glass_crossing), mover), 1)

/obj/structure/window/kaizojave/proc/handle_forced_glass_crossing(mob/living/mover)
	if(!mover || QDELETED(mover) || QDELETED(src))
		return
	if(!is_glass_window || !obj_broken || broken_glass_cleared)
		return
	if(get_turf(mover) != get_turf(src))
		return

	if(istype(src, /obj/structure/window/kaizojave/ground))
		playsound(src, 'modular/kaizoku/sound/foley/glass_step.ogg', 40, FALSE)

	if(crossing_clears_glass)
		clear_broken_glass(mover, FALSE)

	if(ishuman(mover))
		apply_broken_glass_crossing_injuries(mover)

/obj/structure/window/kaizojave/proc/get_cleanup_fail_chance(mob/user)
	if(cleanup_fail_base_chance <= 0)
		return 0
	var/fail_chance = cleanup_fail_base_chance
	if(isliving(user))
		var/mob/living/living_user = user
		var/intelligence = living_user.get_stat(STATKEY_INT)
		fail_chance = cleanup_fail_base_chance - (intelligence * 2)
	return clamp(fail_chance, 0, 95)

/obj/structure/window/kaizojave/proc/hurt_cleanup_hand(mob/user)
	if(!ishuman(user))
		return
	var/mob/living/carbon/human/human_user = user
	var/obj/item/bodypart/hand = human_user.get_bodypart(pick(BODY_ZONE_PRECISE_L_HAND, BODY_ZONE_PRECISE_R_HAND))
	if(!hand)
		return
	hand.receive_damage(8)
	hand.add_wound(/datum/wound/slash/small)

/obj/structure/window/kaizojave/proc/checkfrill(icon/source_icon, state_name)
	if(!source_icon || !state_name)
		return FALSE
	return (state_name in icon_states(source_icon))

/obj/structure/window/kaizojave/proc/get_connectorfrill_source()
	if(connector_frill_icon)
		return connector_frill_icon
	if(connector_overlay_icon)
		return connector_overlay_icon
	return frill_icon

/obj/structure/window/kaizojave/proc/resolve_frill_state(base_state, icon/source_icon = null)
	if(!base_state)
		return null
	if(!source_icon)
		source_icon = frill_icon
	if(!source_icon)
		return null

	var/list/candidates = list()
	if(window_frill_transition)
		candidates += "[base_state]_[window_frill_transition]"
	if(obj_broken)
		candidates += "[base_state]_broken"
	if(climbable)
		candidates += "[base_state]_open"
	candidates += base_state

	for(var/candidate in candidates)
		if(checkfrill(source_icon, candidate))
			return candidate

	return null

/obj/structure/window/kaizojave/proc/add_resolved_window_frill_overlay(state_name, layer_offset = 0, icon/source_icon = null)
	if(!source_icon)
		source_icon = frill_icon
	if(!state_name || !source_icon)
		return null
	var/mutable_appearance/frill = mutable_appearance(source_icon, state_name, ABOVE_MOB_LAYER + layer_offset, OVER_FRILL_PLANE)
	frill.pixel_y = 32
	frill.appearance_flags = RESET_ALPHA
	add_overlay(frill)
	return frill

/obj/structure/window/kaizojave/proc/clear_broken_glass(mob/living/actor, manual_cleanup)
	if(!obj_broken || broken_glass_cleared)
		return

	broken_glass_cleared = TRUE
	if(manual_cleanup && actor)
		to_chat(actor, span_notice("I start to push away the shattered glass."))
		playsound(src, 'modular/kaizoku/sound/foley/glass_step.ogg', 40, FALSE)
		var/turf/drop_turf = get_turf(actor)
		if(!drop_turf)
			drop_turf = get_turf(src)
		if(drop_turf)
			new shard_item_type(drop_turf)
			new shard_item_type(drop_turf)
	else if(actor)
		to_chat(actor, span_warning("I scrape myself on jagged glass."))

	update_appearance(UPDATE_ICON_STATE)
	update_window_frill()
	update_connectorcorner_detail_overlay()
	refresh_linked_walls()

/obj/structure/window/kaizojave/proc/apply_broken_glass_crossing_injuries(mob/living/carbon/human/victim)
	if(!victim)
		return

	var/list/eligible_parts = list()
	for(var/obj/item/bodypart/part in victim.bodyparts)
		if(!part)
			continue
		if(part.body_zone == BODY_ZONE_HEAD)
			continue
		eligible_parts += part

	if(!eligible_parts.len)
		return

	victim.visible_message(
		span_warning("[victim] is cut by jagged glass while forcing through [src]!"),
		span_danger("Jagged shards slice into me as I force through!"),
	)

	var/wound_count = prob(50) ? 2 : 1
	var/list/wounded_parts = list()
	var/blocked_by_armor = FALSE

	for(var/i in 1 to wound_count)
		if(!eligible_parts.len)
			break
		var/obj/item/bodypart/target_part = pick(eligible_parts)
		eligible_parts -= target_part
		if(!target_part)
			continue

		if(!crossing_ignores_armor)
			var/armor_value = victim.run_armor_check(target_part.body_zone, "stab", "My armor shatters the glass.", "My armor protects me from the jagged glass.", damage = 12, blade_dulling = BCLASS_STAB)
			if(armor_value >= glass_armor_protection_threshold)
				blocked_by_armor = TRUE
				continue

		var/datum/wound/applied = target_part.add_wound(/datum/wound/slash/small)
		if(applied)
			wounded_parts += target_part

	if(!wounded_parts.len && blocked_by_armor)
		to_chat(victim, span_notice("I hear glass shattering."))
		return

	if(crossing_embed_enabled)
		for(var/obj/item/bodypart/wounded_part in wounded_parts)
			if(prob(glass_embed_chance))
				wounded_part.add_embedded_object(new shard_item_type(), silent = FALSE, crit_message = TRUE)
				victim.emote("embed")

/obj/structure/window/kaizojave/proc/update_window_frill()
	var/icon/material_frill_icon = frill_icon
	var/icon/connector_source_icon = get_connectorfrill_source()
	if(!material_frill_icon && !connector_source_icon)
		if(active_window_frill)
			cut_overlay(active_window_frill)
			active_window_frill = null
		if(active_window_connector_frill)
			cut_overlay(active_window_connector_frill)
			active_window_connector_frill = null
		return

	if(active_window_frill)
		cut_overlay(active_window_frill)
		active_window_frill = null
	if(active_window_connector_frill)
		cut_overlay(active_window_connector_frill)
		active_window_connector_frill = null

	var/is_vertical = (window_orientation == NORTH || window_orientation == SOUTH)
	var/variant = getconnectorvariant()
	var/material_frill_state = null
	var/list/material_candidates = list()
	for(var/prefix in getstateprefix())
		if(is_vertical)
			material_candidates += "[prefix]_windowfrill_vert"
			material_candidates += "[prefix]_window_frills_vert_[variant]"
			material_candidates += "[prefix]_window_frills_vert"
			material_candidates += "[prefix]_window_frill_vert"
		else
			material_candidates += "[prefix]_windowfrill_horiz"
			material_candidates += "[prefix]_windowfrill"
			material_candidates += "[prefix]_window_frills_[variant]"
			material_candidates += "[prefix]_window_frills"
			material_candidates += "[prefix]_window_frill"
	for(var/candidate in material_candidates)
		material_frill_state = resolve_frill_state(candidate, material_frill_icon)
		if(material_frill_state)
			break

	var/connector_frill_state = null
	var/list/connector_candidates = list()
	if(is_vertical)
		connector_candidates += "window_connectorcorner_vertical_[variant]"
		connector_candidates += "window_connectorcorner_vertical"
	else
		connector_candidates += "window_connectorcorner_[variant]"
		connector_candidates += "window_connectorcorner"
	for(var/candidate in connector_candidates)
		connector_frill_state = resolve_frill_state(candidate, connector_source_icon)
		if(connector_frill_state)
			break

	if(!material_frill_state && !connector_frill_state)
		return

	if(material_frill_state)
		active_window_frill = add_resolved_window_frill_overlay(material_frill_state, 0, material_frill_icon)
	if(connector_frill_state)
		var/connector_layer_offset = material_frill_state ? 0.01 : 0
		active_window_connector_frill = add_resolved_window_frill_overlay(connector_frill_state, connector_layer_offset, connector_source_icon)

/obj/structure/window/kaizojave/proc/add_horizontal_window_frill()
	var/icon/material_frill_icon = frill_icon
	var/icon/connector_source_icon = get_connectorfrill_source()
	if(!material_frill_icon && !connector_source_icon)
		if(active_window_frill)
			cut_overlay(active_window_frill)
			active_window_frill = null
		if(active_window_connector_frill)
			cut_overlay(active_window_connector_frill)
			active_window_connector_frill = null
		return

	if(active_window_frill)
		cut_overlay(active_window_frill)
		active_window_frill = null
	if(active_window_connector_frill)
		cut_overlay(active_window_connector_frill)
		active_window_connector_frill = null

	var/variant = getconnectorvariant()
	var/material_frill_state = null
	var/list/material_candidates = list()
	for(var/prefix in getstateprefix())
		material_candidates += "[prefix]_windowfrill_horiz"
		material_candidates += "[prefix]_windowfrill"
		material_candidates += "[prefix]_window_frills_[variant]"
		material_candidates += "[prefix]_window_frills"
		material_candidates += "[prefix]_window_frill"
	for(var/candidate in material_candidates)
		material_frill_state = resolve_frill_state(candidate, material_frill_icon)
		if(material_frill_state)
			break

	var/connector_frill_state = null
	var/list/connector_candidates = list(
		"window_connectorcorner_[variant]",
		"window_connectorcorner"
	)
	for(var/candidate in connector_candidates)
		connector_frill_state = resolve_frill_state(candidate, connector_source_icon)
		if(connector_frill_state)
			break

	if(!material_frill_state && !connector_frill_state)
		return

	if(material_frill_state)
		active_window_frill = add_resolved_window_frill_overlay(material_frill_state, 0, material_frill_icon)
	if(connector_frill_state)
		var/connector_layer_offset = material_frill_state ? 0.01 : 0
		active_window_connector_frill = add_resolved_window_frill_overlay(connector_frill_state, connector_layer_offset, connector_source_icon)

/obj/structure/window/kaizojave/proc/get_refresh_anchor_turf(turf/anchor_override)
	if(anchor_override)
		return anchor_override
	return get_turf(src)

/obj/structure/window/kaizojave/proc/update_adjacent_walls(turf/anchor_override)
	var/turf/anchor_turf = get_refresh_anchor_turf(anchor_override)
	if(!anchor_turf)
		return

	for(var/direction in list(NORTH, SOUTH, EAST, WEST))
		var/turf/adjacent = get_step(anchor_turf, direction)
		if(!adjacent)
			continue
		if(istype(adjacent, /turf/closed/wall/kaizojave))
			var/turf/closed/wall/kaizojave/wall = adjacent
			QUEUE_SMOOTH(wall)
			QUEUE_SMOOTH_NEIGHBORS(wall)

/obj/structure/window/kaizojave/proc/refresh_coverup_chain(turf/anchor_override)
	var/turf/anchor_turf = get_refresh_anchor_turf(anchor_override)
	if(!anchor_turf)
		return

	var/turf/closed/wall/kaizojave/start_wall = get_step(anchor_turf, SOUTH)
	if(!istype(start_wall))
		return

	refresh_coverup_wall(start_wall)

	for(var/scan_dir in list(EAST, WEST))
		var/turf/current = start_wall
		for(var/i in 1 to 64)
			var/turf/closed/wall/kaizojave/neighbor = get_step(current, scan_dir)
			if(!istype(neighbor))
				break
			if(!neighbor.is_kaizojave_wall(get_step(neighbor, SOUTH)))
				break
			refresh_coverup_wall(neighbor)
			current = neighbor

/obj/structure/window/kaizojave/proc/refresh_coverup_wall(turf/closed/wall/kaizojave/wall)
	if(!wall)
		return
	QUEUE_SMOOTH(wall)
	QUEUE_SMOOTH_NEIGHBORS(wall)

/obj/structure/window/kaizojave/proc/refresh_linked_walls(turf/anchor_override)
	update_adjacent_walls(anchor_override)
	refresh_coverup_chain(anchor_override)

/obj/structure/window/kaizojave/proc/get_detected_wall(direction)
	return detected_walls["[direction]"]

/obj/structure/window/kaizojave/proc/pick_reference_wall()
	var/behind_dir = turn(dir, 180)
	var/right_dir = turn(dir, 90)
	var/left_dir = turn(dir, -90)

	var/turf/closed/wall/kaizojave/behind_wall = get_detected_wall(behind_dir)
	if(behind_wall)
		return behind_wall

	var/turf/closed/wall/kaizojave/right_wall = get_detected_wall(right_dir)
	var/turf/closed/wall/kaizojave/left_wall = get_detected_wall(left_dir)
	if(right_wall && left_wall)
		if(right_wall.wall_variety != left_wall.wall_variety)
			return pick(right_wall, left_wall)
		return right_wall

	if(right_wall)
		return right_wall
	if(left_wall)
		return left_wall

	for(var/d in list(NORTH, SOUTH, EAST, WEST))
		var/turf/closed/wall/kaizojave/fallback = get_detected_wall(d)
		if(fallback)
			return fallback

	return null

/obj/structure/window/kaizojave/proc/try_detect_and_configure()
	var/found_count = 0
	detected_walls = list()

	for(var/direction in list(NORTH, SOUTH, EAST, WEST))
		var/turf/adjacent = get_step(src, direction)
		if(!adjacent)
			continue
		if(istype(adjacent, /turf/closed/wall/kaizojave))
			detected_walls["[direction]"] = adjacent
			found_count++

	if(found_count == 0)
		return FALSE

	var/turf/closed/wall/kaizojave/north_wall = get_detected_wall(NORTH)
	var/turf/closed/wall/kaizojave/south_wall = get_detected_wall(SOUTH)
	var/turf/closed/wall/kaizojave/east_wall = get_detected_wall(EAST)
	var/turf/closed/wall/kaizojave/west_wall = get_detected_wall(WEST)

	var/turf/closed/wall/kaizojave/wall_reference = pick_reference_wall()
	if(!wall_reference)
		return FALSE

	var/reference_dir = null
	for(var/d in list(NORTH, SOUTH, EAST, WEST))
		if(detected_walls["[d]"] == wall_reference)
			reference_dir = d
			break
	detected_orientation = (reference_dir == EAST || reference_dir == WEST) ? EAST : NORTH

	if(north_wall && south_wall && east_wall && west_wall)
		return FALSE

	wall_type = wall_reference
	return setup_from_wall(wall_reference)

/obj/structure/window/kaizojave/proc/setup_from_wall(turf/closed/wall/kaizojave/reference_wall)
	if(!reference_wall)
		return FALSE

	setconnectorvariant(reference_wall)
	connector_overlay_icon = reference_wall.icon
	connector_frill_icon = reference_wall.frill_icon

	icon = initial(icon)
	if(!has_any_usable_window_states() && reference_wall.icon)
		icon = reference_wall.icon
	wall_variety = reference_wall.wall_variety
	if(preserve_subtype_wall_variety && initial(wall_variety))
		wall_variety = initial(wall_variety)
	if(reference_wall && reference_wall.vars && reference_wall.vars["window_height"])
		window_height = reference_wall.vars["window_height"]
	if(reference_wall.max_integrity)
		max_integrity = max(100, round(reference_wall.max_integrity * 0.75))
		atom_integrity = max_integrity
		integrity_failure = 0.75
	if(detected_orientation)
		window_orientation = detected_orientation

	return TRUE

/obj/structure/window/kaizojave/update_icon_state()
	. = ..()
	if(!wall_variety && !kaizojaveconnector_icon)
		icon_state = "window"
		return

	var/base_state = get_base_window_state_name()
	if(!base_state)
		icon_state = "window"
		return

	if(obj_broken && is_glass_window && broken_glass_cleared)
		var/connector_state = get_cleared_window_connector_state()
		if(connector_state)
			icon_state = connector_state
		else
			icon_state = "[base_state]_broken"
	else if(obj_broken)
		icon_state = "[base_state]_broken"
	else if(climbable)
		icon_state = "[base_state]_open"
	else
		icon_state = base_state

/obj/structure/window/kaizojave/update_appearance(updates)
	. = ..()
	if(updates & UPDATE_ICON_STATE)
		update_connectorcorner_overlay()
		update_connectorcorner_detail_overlay()

/obj/structure/window/kaizojave/Destroy()
	if(active_window_connector_overlay)
		cut_overlay(active_window_connector_overlay)
		active_window_connector_overlay = null
	if(active_window_connector_frill)
		cut_overlay(active_window_connector_frill)
		active_window_connector_frill = null
	if(kaizojavedetail)
		cut_overlay(kaizojavedetail)
		kaizojavedetail = null
	var/turf/source_turf = get_turf(src)
	cleanup_adjacent_walls(source_turf)
	return ..()

/obj/structure/window/kaizojave/proc/cleanup_adjacent_walls(turf/anchor_override)
	var/turf/anchor_turf = get_refresh_anchor_turf(anchor_override)
	if(!anchor_turf)
		return

	for(var/direction in list(NORTH, SOUTH, EAST, WEST))
		var/turf/adjacent = get_step(anchor_turf, direction)
		if(!adjacent)
			continue
		if(istype(adjacent, /turf/closed/wall/kaizojave))
			var/turf/closed/wall/kaizojave/wall = adjacent
			if(wall.frill_icon)
				wall.RemoveElement(/datum/element/frill, wall.frill_icon)
				if(!wall.check_suppress_frill_for_doors_windows())
					wall.AddElement(/datum/element/frill, wall.frill_icon)
			QUEUE_SMOOTH(wall)
			QUEUE_SMOOTH_NEIGHBORS(wall)
	refresh_coverup_chain(anchor_turf)

/obj/structure/window/kaizojave/solid
	name = "unglazed window"
	desc = "Cheap opening with wooden lattice partially covering it. Cheap and protective, but offers little visibility."
	wall_variety = "wood"
	connectorcorner_variant = 1
	mergewithwalls = TRUE
	connectorcorner_detail = 1
	kaizojaveconnector_icon = "connectorcorners_1"
	is_glass_window = FALSE
	can_open_close = TRUE
	max_integrity = 480
	integrity_failure = 0.8
	damage_deflection = 14
	armor = list("blunt" = 30, "slash" = 28, "stab" = 22, "piercing" = 18, "fire" = 0, "acid" = 0)
	attacked_sound = list('modular/kaizoku/sound/combat/hits/onwood/woodimpact (1).ogg','modular/kaizoku/sound/combat/hits/onwood/woodimpact (2).ogg')
	break_sound = 'modular/kaizoku/sound/combat/hits/onwood/destroywalldoor.ogg'

/obj/structure/window/kaizojave/solid/Initialize(mapload)
	. = ..()
	if(!climbable && !obj_broken)
		opacity = TRUE

/obj/structure/window/kaizojave/solid/open_up(mob/user)
	. = ..()
	opacity = FALSE

/obj/structure/window/kaizojave/solid/close_up(mob/user)
	. = ..()
	if(!obj_broken)
		opacity = TRUE

/obj/structure/window/kaizojave/solid/stone
	desc = "A opening with an heavy stone frame built into the wall. It's quite difficult to raise this."
	wall_variety = "stone"
	connectorcorner_variant = 1
	mergewithwalls = TRUE
	kaizojaveconnector_icon = "connectorcorners_1"
	max_integrity = 620
	integrity_failure = 0.80
	damage_deflection = 18
	armor = list("blunt" = 42, "slash" = 40, "stab" = 32, "piercing" = 24, "fire" = 0, "acid" = 0)
	attacked_sound = list('modular/kaizoku/sound/combat/hits/onrock/onrock (1).ogg','modular/kaizoku/sound/combat/hits/onrock/onrock (2).ogg')
	break_sound = 'modular/kaizoku/sound/combat/hits/onrock/onrock (3).ogg'

/obj/structure/window/kaizojave/solid/iron
	desc = "A heavy iron-framed opening built upon the wall. Light, protective and somewhat cheap."
	wall_variety = "iron"
	connectorcorner_variant = 1
	mergewithwalls = TRUE
	kaizojaveconnector_icon = "connectorcorners_1"
	max_integrity = 760
	integrity_failure = 0.85
	damage_deflection = 22
	armor = list("blunt" = 52, "slash" = 48, "stab" = 40, "piercing" = 30, "fire" = 0, "acid" = 0)
	attacked_sound = list('modular/kaizoku/sound/combat/parry/shield/metalshield (1).ogg','modular/kaizoku/sound/combat/parry/shield/metalshield (2).ogg')
	break_sound = 'modular/kaizoku/sound/combat/parry/shield/metalshield (3).ogg'

/obj/structure/window/kaizojave/solid/steel
	desc = "Practically impenetrable to conventional weapons, this steel fortification will endure."
	wall_variety = "steel"
	connectorcorner_variant = 1
	mergewithwalls = TRUE
	kaizojaveconnector_icon = "connectorcorners_1"
	max_integrity = 920
	integrity_failure = 0.75
	damage_deflection = 26
	armor = list("blunt" = 60, "slash" = 55, "stab" = 48, "piercing" = 36, "fire" = 0, "acid" = 0)
	attacked_sound = list('modular/kaizoku/sound/combat/parry/shield/metalshield (1).ogg','modular/kaizoku/sound/combat/parry/shield/metalshield (2).ogg')
	break_sound = 'modular/kaizoku/sound/combat/parry/shield/metalshield (3).ogg'

/obj/structure/window/kaizojave/glass
	name = "window"
	desc = "Wrong type of window used. Please warn developers."
	mergewithwalls = TRUE
	is_glass_window = TRUE
	shard_item_type = /obj/item/natural/glass_shard
	shard_debris_type = /obj/effect/decal/cleanable/debris/glass
	shard_projectile_type = /obj/projectile/bullet/glass
	repair_thresholds = list(/obj/item/natural/glass = 1)
	broken_repair = /obj/item/natural/glass
	attacked_sound = 'modular/kaizoku/sound/combat/hits/onglass/glasshit.ogg'
	break_sound = "glassbreak"

/obj/structure/window/kaizojave/glass/winblue1
	desc = "A crown glass window. Formed with many small circular panes made by spinning molten glass into a disk."
	wall_variety = "glasswinblue1"
	preserve_subtype_wall_variety = TRUE
	connectorcorner_variant = 1
	mergewithwalls = TRUE
	connectorcorner_detail = 1
	kaizojaveconnector_icon = "connectorcorners_1"

/obj/structure/window/kaizojave/glass/winblue2
	desc = "Mullion glass window. Thick, square-like crystal panes joined by pewter or clay strips, giving a square-like look to the glass. Most favoured by foglanders."
	wall_variety = "glasswinblue2"
	preserve_subtype_wall_variety = TRUE
	connectorcorner_variant = 1
	mergewithwalls = TRUE
	connectorcorner_detail = 1
	kaizojaveconnector_icon = "connectorcorners_1"

/obj/structure/window/kaizojave/glass/winblue3
	desc = "Polished glass. It was mostly made of cut clear quartz before glass blowing became more specialized after blood apotheosis."
	wall_variety = "glasswinblue3"
	preserve_subtype_wall_variety = TRUE
	connectorcorner_variant = 1
	mergewithwalls = TRUE
	connectorcorner_detail = 1
	kaizojaveconnector_icon = "connectorcorners_1"

/obj/structure/window/kaizojave/ground
	name = "grounded window"
	desc = "Wrong type of window used. Please warn developers."
	mergewithwalls = TRUE
	is_glass_window = TRUE
	shard_item_type = /obj/item/natural/glass_shard
	shard_debris_type = /obj/effect/decal/cleanable/debris/glass
	shard_projectile_type = /obj/projectile/bullet/glass
	repair_thresholds = list(/obj/item/natural/glass = 1)
	broken_repair = /obj/item/natural/glass
	can_open_close = FALSE
	max_integrity = 300
	integrity_failure = 0.75
	damage_deflection = 10
	armor = list("blunt" = 25, "slash" = 20, "stab" = 20, "piercing" = 15, "fire" = 0, "acid" = 0)
	glass_cleanup_time = 4.8 SECONDS
	cleanup_fail_base_chance = 42
	crossing_clears_glass = FALSE
	crossing_embed_enabled = FALSE
	crossing_ignores_armor = TRUE

/obj/structure/window/kaizojave/ground/open_up(mob/user)
	return

/obj/structure/window/kaizojave/ground/close_up(mob/user)
	return

/obj/structure/window/kaizojave/ground/force_open()
	return

/obj/structure/window/kaizojave/ground/atom_break(damage_flag, silent)
	. = ..()
	density = FALSE
	climbable = TRUE

/obj/structure/window/kaizojave/ground/atom_fix()
	. = ..()
	density = TRUE
	climbable = FALSE

/obj/structure/window/kaizojave/ground/zamuraiground1
	desc = "Despiction of the paragons of foglander justice in stained glass. Shall the gaze of the Custodians watch over you."
	wall_variety = "zamuraiground1"
	preserve_subtype_wall_variety = TRUE
	connectorcorner_variant = 2
	kaizojaveconnector_icon = "connectorcorners_2"
	mergewithwalls = FALSE

/obj/structure/window/kaizojave/ground/zamuraiground2
	desc = "Despiction of the paragons of foglander justice in stained glass. Shall the gaze of the Custodians watch over you."
	wall_variety = "zamuraiground2"
	preserve_subtype_wall_variety = TRUE
	connectorcorner_variant = 2
	kaizojaveconnector_icon = "connectorcorners_2"
	mergewithwalls = FALSE

/obj/structure/window/kaizojave/ground/shinobi
	desc = "Portrayal of Pelangic Empire's agents made in stained glass in their nightly uniform. The ears and blades of the Sovereigns."
	wall_variety = "shinobi"
	preserve_subtype_wall_variety = TRUE
	connectorcorner_variant = 2
	kaizojaveconnector_icon = "connectorcorners_2"
	mergewithwalls = FALSE

/obj/structure/window/kaizojave/ground/beastmaster
	wall_variety = "beastmaster"
	desc = "Despiction of the nomadic beast tamers in stained glass, wild roamers bringing mutualism even for the most insanely dendorite of creatures."
	preserve_subtype_wall_variety = TRUE
	connectorcorner_variant = 2
	kaizojaveconnector_icon = "connectorcorners_2"
	mergewithwalls = FALSE

/obj/structure/window/kaizojave/ground/tideweaver
	desc = "Despiction of the Abyssanctum religious warriors in stained glass. Their martial prowess unmatched even in art."
	wall_variety = "tideweaver"
	preserve_subtype_wall_variety = TRUE
	connectorcorner_variant = 1
	kaizojaveconnector_icon = "connectorcorners_1"
	mergewithwalls = TRUE

/obj/structure/window/kaizojave/ground/abyssanctum1
	desc = "The Abyssanctum's trinomial anchor, displayed at the center as an circumnavigation tool. \
	Written explanation of the meridians can be found on the reflecting panels."
	wall_variety = "abyssanctum1"
	preserve_subtype_wall_variety = TRUE
	connectorcorner_variant = 2
	kaizojaveconnector_icon = "connectorcorners_2"
	mergewithwalls = FALSE

/obj/structure/window/kaizojave/ground/abyssanctum2
	desc = "The symbol of Abyssanctum, the 'Trinomial Anchor'. The tenants represented by its tree prongs, \
	all protruding from the same root entrenching it all as one."
	wall_variety = "abyssanctum2"
	preserve_subtype_wall_variety = TRUE
	connectorcorner_variant = 3
	kaizojaveconnector_icon = "connectorcorners_3"
	mergewithwalls = FALSE

/obj/structure/window/kaizojave/ground/abyssanctum3
	desc = "Colorful despiction of an flowering double lotus. Symbol of finding integrity in unity \
	even when severed by fate. Usually an analogy for foglander marriage."
	wall_variety = "abyssanctum3"
	preserve_subtype_wall_variety = TRUE
	connectorcorner_variant = 3
	kaizojaveconnector_icon = "connectorcorners_3"
	mergewithwalls = FALSE
