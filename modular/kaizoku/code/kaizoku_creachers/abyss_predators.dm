/datum/ai_controller/kaizoku_winged_hunter
	movement_delay = 0.35 SECONDS
	ai_movement = /datum/ai_movement/hybrid_pathing
	blackboard = list(
		BB_TARGETTING_DATUM = new /datum/targetting_datum/basic(),
		BB_KAIZOKU_WINGED_AIRBORNE = TRUE,
		BB_KAIZOKU_WINGED_SHADOW = null,
	)
	planning_subtrees = list(
		/datum/ai_planning_subtree/kaizoku_winged_airborne,
		/datum/ai_planning_subtree/aggro_find_target,
		/datum/ai_planning_subtree/basic_melee_attack_subtree,
	)
	idle_behavior = /datum/idle_behavior/idle_random_walk

/datum/ai_planning_subtree/kaizoku_winged_airborne

/datum/ai_planning_subtree/kaizoku_winged_airborne/SelectBehaviors(datum/ai_controller/controller, delta_time)
	. = ..()
	var/mob/living/simple_animal/hostile/retaliate/kaizoku/winged_hunter/hunter = controller.pawn
	if(!istype(hunter) || !hunter.airborne)
		return
	controller.CancelActions()
	controller.clear_blackboard_key(BB_BASIC_MOB_CURRENT_TARGET)
	hunter.target = null
	return SUBTREE_RETURN_FINISH_PLANNING

/datum/ai_controller/kaizoku_ambusher
	movement_delay = 0.45 SECONDS
	ai_movement = /datum/ai_movement/hybrid_pathing
	blackboard = list(
		BB_TARGETTING_DATUM = new /datum/targetting_datum/basic(),
		BB_SNEAKING = FALSE,
		BB_SNEAK_COOLDOWN = 0,
		BB_KAIZOKU_AMBUSH_PARALYZE_CD = 0,
	)
	planning_subtrees = list(
		/datum/ai_planning_subtree/kaizoku_ambush_sneak,
		/datum/ai_planning_subtree/aggro_find_target,
		/datum/ai_planning_subtree/basic_melee_attack_subtree,
	)
	idle_behavior = /datum/idle_behavior/idle_random_walk

// Custom sneak behavior for ambush stalker with lower alpha
/datum/ai_planning_subtree/kaizoku_ambush_sneak/SelectBehaviors(datum/ai_controller/controller, delta_time)
	if(controller.blackboard[BB_SNEAKING] || (world.time < controller.blackboard[BB_SNEAK_COOLDOWN]))
		return
	var/mob/living/simple_animal/basic_mob = controller.pawn
	if(!basic_mob)
		return
	var/turf/current_turf = get_turf(basic_mob)
	if(!current_turf)
		return
	var/light_amount = current_turf.get_lumcount()
	if(light_amount < SHADOW_SPECIES_LIGHT_THRESHOLD)
		controller.queue_behavior(/datum/ai_behavior/kaizoku_ambush_sneak)

/datum/ai_behavior/kaizoku_ambush_sneak
	action_cooldown = 3 SECONDS
	behavior_flags = AI_BEHAVIOR_CAN_PLAN_DURING_EXECUTION
	var/light_threshold = SHADOW_SPECIES_LIGHT_THRESHOLD
	var/sneak_cooldown_time = 30 SECONDS
	var/sneak_cooldown_key = BB_SNEAK_COOLDOWN
	var/sneaking_key = BB_SNEAKING
	var/sneak_alpha = 0 // Fully transparent in darkness

/datum/ai_behavior/kaizoku_ambush_sneak/setup(datum/ai_controller/controller)
	. = ..()
	if(isnull(controller.blackboard[sneak_cooldown_key]))
		controller.set_blackboard_key(sneak_cooldown_key, 0)
	if(isnull(controller.blackboard[sneaking_key]))
		controller.set_blackboard_key(sneaking_key, FALSE)

/datum/ai_behavior/kaizoku_ambush_sneak/perform(delta_time, datum/ai_controller/controller)
	. = ..()
	var/mob/living/simple_animal/basic_mob = controller.pawn
	if(!isturf(basic_mob.loc))
		finish_action(controller, FALSE)
		return
	var/currently_sneaking = controller.blackboard[sneaking_key]
	if(currently_sneaking)
		finish_action(controller, TRUE)
		return
	if(world.time < controller.blackboard[sneak_cooldown_key])
		finish_action(controller, FALSE)
		return
	var/turf/current_turf = get_turf(basic_mob)
	var/light_amount = current_turf.get_lumcount()
	if(light_amount < light_threshold)
		start_sneaking(controller)
		finish_action(controller, TRUE)
	else
		finish_action(controller, FALSE)

/datum/ai_behavior/kaizoku_ambush_sneak/proc/start_sneaking(datum/ai_controller/controller)
	var/mob/living/simple_animal/basic_mob = controller.pawn
	controller.set_blackboard_key(sneaking_key, TRUE)
	basic_mob.alpha = sneak_alpha
	RegisterSignal(basic_mob, COMSIG_ATOM_WAS_ATTACKED, PROC_REF(break_sneak))
	RegisterSignal(basic_mob, COMSIG_MOB_BREAK_SNEAK, PROC_REF(break_sneak))

/datum/ai_behavior/kaizoku_ambush_sneak/proc/break_sneak(mob/living/simple_animal/basic_mob)
	var/datum/ai_controller/controller = basic_mob.ai_controller
	if(!controller)
		return
	UnregisterSignal(basic_mob, list(COMSIG_MOB_BREAK_SNEAK, COMSIG_ATOM_WAS_ATTACKED))
	controller.set_blackboard_key(sneaking_key, FALSE)
	controller.set_blackboard_key(sneak_cooldown_key, world.time + sneak_cooldown_time)
	basic_mob.alpha = initial(basic_mob.alpha)

/mob/living/simple_animal/hostile/retaliate/kaizoku
	faction = list("kaizoku_predator")
	aggressive = TRUE
	var/aggro_component_range = 10

/mob/living/simple_animal/hostile/retaliate/kaizoku/Initialize()
	. = ..()
	if(hascall(src, "GetComponent") && hascall(src, "AddComponent"))
		if(!GetComponent(/datum/component/ai_aggro_system))
			AddComponent(/datum/component/ai_aggro_system, 10, aggro_component_range)

/mob/living/simple_animal/hostile/retaliate/kaizoku/winged_hunter
	name = "winged abyss hunter"
	desc = "A circling predator that strikes from above."
	icon = 'modular/kaizoku/icons/mobs/falcon.dmi'
	icon_state = "falcon"
	icon_living = "falcon"
	icon_dead = "falcon_dead"
	ai_controller = /datum/ai_controller/kaizoku_winged_hunter
	movement_type = FLYING
	pass_flags = PASSTABLE|PASSGRILLE
	move_to_delay = 4
	melee_damage_lower = 18
	melee_damage_upper = 28
	health = 140
	maxHealth = 140
	vision_range = 8
	aggro_vision_range = 10
	aggro_component_range = 12
	var/airborne = TRUE
	var/next_reascend = 0
	var/dive_attack_range = 1
	var/dive_prepare_min = 1 SECONDS
	var/dive_prepare_max = 4 SECONDS
	var/mob/living/prep_dive_target = null
	var/dive_prepare_until = 0
	var/obj/effect/kaizoku/winged_shadow/shadow = null
	var/spawn_z_level = 0
	var/hunt_z_level = 0

/mob/living/simple_animal/hostile/retaliate/kaizoku/winged_hunter/Initialize(mapload)
	. = ..()
	var/turf/my_turf = get_turf(src)
	if(!my_turf)
		return

	spawn_z_level = my_turf.z
	var/turf/shadow_turf = GET_TURF_BELOW(my_turf)
	if(!shadow_turf)
		shadow_turf = my_turf
	hunt_z_level = shadow_turf.z

	shadow = new /obj/effect/kaizoku/winged_shadow(shadow_turf, src)
	set_airborne(TRUE)
	update_shadow_state()

/mob/living/simple_animal/hostile/retaliate/kaizoku/winged_hunter/Destroy()
	if(shadow)
		QDEL_NULL(shadow)
	return ..()

/mob/living/simple_animal/hostile/retaliate/kaizoku/winged_hunter/Life()
	. = ..()
	if(!.)
		return

	var/turf/my_turf = get_turf(src)
	if(!my_turf)
		return

	if(!spawn_z_level)
		spawn_z_level = my_turf.z
	if(!hunt_z_level)
		hunt_z_level = my_turf.z
	if(airborne && istype(my_turf, /turf/open/openspace))
		spawn_z_level = my_turf.z

	update_shadow_state()

	if(!airborne)
		if(isliving(target))
			var/mob/living/current_target = target
			if(current_target.stat != DEAD && get_dist(src, current_target) <= 1 && next_click < world.time)
				ai_controller?.ai_interact(current_target, TRUE, TRUE)
				next_click = world.time + (melee_attack_cooldown || 15)
				SEND_SIGNAL(src, COMSIG_MOB_BREAK_SNEAK)
		if(!target && world.time >= next_reascend)
			set_airborne(TRUE)
		return

	if(airborne)
		if(!target)
			maintain_flight_altitude()

		if(prep_dive_target)
			if(!can_hunt(prep_dive_target))
				prep_dive_target = null
				dive_prepare_until = 0
			else if(world.time >= dive_prepare_until)
				var/mob/living/final_target = prep_dive_target
				prep_dive_target = null
				dive_prepare_until = 0
				descend_on_target(final_target)
				return

		if(shadow)
			var/mob/living/trigger = shadow.find_trigger_target()
			if(trigger)
				prepare_dive(trigger)
				return

		var/turf/below = locate(my_turf.x, my_turf.y, hunt_z_level)
		if(below)
			for(var/mob/living/L in range(dive_attack_range, below))
				if(can_hunt(L))
					prepare_dive(L)
				return

/mob/living/simple_animal/hostile/retaliate/kaizoku/winged_hunter/AttackingTarget(mob/living/passed_target)
	if(airborne)
		return FALSE
	return ..()

/mob/living/simple_animal/hostile/retaliate/kaizoku/winged_hunter/proc/can_hunt(mob/living/target_mob)
	if(!target_mob || target_mob.stat == DEAD)
		return FALSE
	if(!ishuman(target_mob))
		return FALSE
	if(airborne && !can_reach_target_from_air(target_mob))
		return FALSE
	var/datum/targetting_datum/td = ai_controller?.blackboard[BB_TARGETTING_DATUM]
	if(td && !td.can_attack(src, target_mob))
		return FALSE
	return TRUE

/mob/living/simple_animal/hostile/retaliate/kaizoku/winged_hunter/proc/can_reach_target_from_air(mob/living/target_mob)
	if(!target_mob)
		return FALSE

	var/turf/target_turf = get_turf(target_mob)
	if(!target_turf || target_turf.z != hunt_z_level)
		return FALSE

	var/turf/my_turf = get_turf(src)
	var/air_z_level = spawn_z_level
	if(airborne && my_turf)
		air_z_level = my_turf.z

	var/turf/air_lane = locate(target_turf.x, target_turf.y, air_z_level)
	if(!air_lane)
		return FALSE

	if(!istype(air_lane, /turf/open/openspace))
		return FALSE

	return TRUE

/mob/living/simple_animal/hostile/retaliate/kaizoku/winged_hunter/proc/maintain_flight_altitude()
	if(!airborne || target)
		return

	var/turf/my_turf = get_turf(src)
	if(!my_turf)
		return

	if(istype(my_turf, /turf/open/openspace))
		spawn_z_level = my_turf.z
		return

	var/turf/above = GET_TURF_ABOVE(my_turf)
	if(above && istype(above, /turf/open/openspace))
		forceMove(above)
		spawn_z_level = above.z
		return

	for(var/turf/T in orange(2, src))
		if(istype(T, /turf/open/openspace) && T.z == z)
			forceMove(T)
			spawn_z_level = T.z
			return

/mob/living/simple_animal/hostile/retaliate/kaizoku/winged_hunter/proc/descend_on_target(mob/living/target_mob)
	if(!can_hunt(target_mob))
		return
	if(!can_reach_target_from_air(target_mob))
		return

	var/turf/target_turf = get_turf(target_mob)
	if(target_turf && target_turf.z != hunt_z_level)
		target_turf = locate(target_turf.x, target_turf.y, hunt_z_level)
	if(target_turf)
		forceMove(target_turf)

	set_airborne(FALSE)
	next_reascend = world.time + 9 SECONDS
	target = target_mob
	if(target_mob.stat != DEAD)
		target_mob.Immobilize(25)
	ai_controller?.set_blackboard_key(BB_BASIC_MOB_CURRENT_TARGET, target_mob)
	visible_message(span_danger("[src] shrieks and dives down from above!"))
	if(target_mob.client)
		to_chat(target_mob, span_userdanger("[src] is diving at you from above!"))

/mob/living/simple_animal/hostile/retaliate/kaizoku/winged_hunter/proc/prepare_dive(mob/living/target_mob)
	if(!airborne)
		return
	if(!can_hunt(target_mob))
		return

	if(prep_dive_target == target_mob && world.time < dive_prepare_until)
		return

	prep_dive_target = target_mob
	dive_prepare_until = world.time + rand(dive_prepare_min, dive_prepare_max)
	visible_message(span_warning("[src] circles overhead, preparing to dive!"))

/mob/living/simple_animal/hostile/retaliate/kaizoku/winged_hunter/proc/set_airborne(state)
	var/turf/current_turf = get_turf(src)
	if(current_turf)
		if(state)
			var/turf/return_turf = locate(current_turf.x, current_turf.y, spawn_z_level)
			if(return_turf)
				forceMove(return_turf)
		else
			var/turf/hunt_turf = locate(current_turf.x, current_turf.y, hunt_z_level)
			if(hunt_turf)
				forceMove(hunt_turf)

	airborne = state
	if(state)
		density = FALSE
		pixel_y = 16
		alpha = 170
		target = null
		prep_dive_target = null
		dive_prepare_until = 0
		ai_controller?.clear_blackboard_key(BB_BASIC_MOB_CURRENT_TARGET)
	else
		density = TRUE
		pixel_y = 0
		alpha = 255
		prep_dive_target = null
		dive_prepare_until = 0
	ai_controller?.set_blackboard_key(BB_KAIZOKU_WINGED_AIRBORNE, state)
	if(shadow)
		ai_controller?.set_blackboard_key(BB_KAIZOKU_WINGED_SHADOW, shadow)
	update_shadow_state()

/mob/living/simple_animal/hostile/retaliate/kaizoku/winged_hunter/proc/update_shadow_state()
	if(!shadow)
		return

	if(!airborne)
		shadow.alpha = 0
		shadow.mouse_opacity = MOUSE_OPACITY_TRANSPARENT
		return

	var/turf/my_turf = get_turf(src)
	if(!my_turf || !istype(my_turf, /turf/open/openspace))
		shadow.alpha = 0
		shadow.mouse_opacity = MOUSE_OPACITY_TRANSPARENT
		return

	var/turf/ground_turf = GET_TURF_BELOW(my_turf)
	if(!ground_turf || ground_turf.z == my_turf.z)
		shadow.alpha = 0
		shadow.mouse_opacity = MOUSE_OPACITY_TRANSPARENT
		return

	shadow.forceMove(ground_turf)
	shadow.alpha = initial(shadow.alpha)
	shadow.mouse_opacity = initial(shadow.mouse_opacity)

/obj/effect/kaizoku/winged_shadow
	name = "hunting shadow"
	desc = "A moving stain of darkness. Something above is watching."
	icon = 'icons/effects/effects.dmi'
	icon_state = "shadow"
	alpha = 200
	anchored = TRUE
	density = FALSE
	mouse_opacity = MOUSE_OPACITY_ICON
	layer = BELOW_MOB_LAYER
	plane = GAME_PLANE
	var/mob/living/simple_animal/hostile/retaliate/kaizoku/winged_hunter/owner

/obj/effect/kaizoku/winged_shadow/Initialize(mapload, mob/living/simple_animal/hostile/retaliate/kaizoku/winged_hunter/new_owner)
	. = ..()
	owner = new_owner

/obj/effect/kaizoku/winged_shadow/Crossed(atom/movable/AM)
	. = ..()
	if(isliving(AM) && owner?.airborne)
		var/mob/living/L = AM
		if(owner.can_hunt(L))
			owner.prepare_dive(L)

/obj/effect/kaizoku/winged_shadow/proc/find_trigger_target()
	if(!owner?.airborne)
		return null
	for(var/mob/living/L in loc)
		if(owner.can_hunt(L))
			return L
	return null

/obj/structure/flora/tree/kaizoku_hidden
	name = "old tree"
	desc = "An old, wicked tree that not even elves could love."
	icon = 'icons/roguetown/misc/foliagetall.dmi'
	icon_state = "t1"
	base_icon_state = "t"
	num_random_icons = 16
	opacity = TRUE
	density = TRUE
	can_buckle = TRUE
	buckle_lying = FALSE
	max_buckled_mobs = 2
	max_integrity = 260
	attacked_sound = 'modular/kaizoku/sound/misc/woodhit.ogg'
	destroy_sound = 'modular/kaizoku/sound/misc/treefall.ogg'
	var/awakened = FALSE
	var/next_wave = 0
	var/wave_interval = 11.5 SECONDS
	var/list/tendrils = list()
	var/max_tendrils = 2
	var/tendril_max_length = 7
	var/tendril_stretch_delay = 5
	var/tendril_shrink_delay = 4
	var/tendril_speed_slowdown_mult = 1.15
	var/tendril_pull_slowdown_mult = 1.5
	var/tile_maneater_cooldown = 8 SECONDS
	var/next_tile_maneater = 0
	var/mob/living/eating_victim = null
	var/next_eat_tick = 0
	var/eat_tick_delay = 3 SECONDS
	var/limb_munch_windup = 1 SECONDS
	var/final_devour_windup = 2 SECONDS
	var/pending_limb_munch = FALSE
	var/pending_final_devour = FALSE
	var/deaggro_delay = 20 SECONDS
	var/idle_since = 0
	var/melee_cut_damage = 22
	var/melee_stab_damage = 16

/obj/structure/flora/tree/kaizoku_hidden/Initialize()
	. = ..()
	START_PROCESSING(SSobj, src)
	spawn_skulls()

/obj/structure/flora/tree/kaizoku_hidden/Destroy()
	if(has_buckled_mobs())
		for(var/mob/living/M in buckled_mobs)
			unbuckle_mob(M, force = TRUE)
	STOP_PROCESSING(SSobj, src)
	return ..()

/obj/structure/flora/tree/kaizoku_hidden/process()
	if(!awakened)
		for(var/mob/living/L in oview(6, src))
			if(L.stat == DEAD)
				continue
			awakened = TRUE
			idle_since = 0
			icon_state = "screaming1"
			visible_message(span_warning("[src] tears open as tendrils burst from its roots!"))
			break
		return

	if(eating_victim)
		if(QDELETED(eating_victim) || eating_victim.stat == DEAD || eating_victim.buckled != src)
			finish_eating_victim()
		else
			if(world.time >= next_eat_tick)
				next_eat_tick = world.time + eat_tick_delay
				tree_tile_munch(eating_victim)
		return

	if(world.time < next_wave)
		return
	next_wave = world.time + wave_interval

	// Clean up dead tendrils
	for(var/obj/effect/kaizoku/tree_tendril/T in tendrils)
		if(QDELETED(T))
			tendrils -= T

	// Find targets on same z-level
	var/list/valid_targets = list()
	for(var/mob/living/L in oview(tendril_max_length, src))
		if(L.stat == DEAD || L.z != z)
			continue
		valid_targets += L

	if(!length(valid_targets))
		if(!length(tendrils) && !has_buckled_mobs())
			if(!idle_since)
				idle_since = world.time
			if(world.time >= idle_since + deaggro_delay)
				go_dormant()
		return

	idle_since = 0

	// Spawn or update tendrils toward targets
	while(length(tendrils) < max_tendrils && length(valid_targets) > 0)
		var/mob/living/target = pick(valid_targets)
		valid_targets -= target
		spawn_line_tendril(target)

	// Attack nearby mobs with existing tendrils
	for(var/mob/living/L in range(1, src))
		if(L.stat == DEAD)
			continue
		lash_target(L)

	if(world.time >= next_tile_maneater)
		var/turf/my_turf = get_turf(src)
		for(var/mob/living/L in my_turf)
			if(L.stat == DEAD || (L.status_flags & GODMODE))
				continue
			tree_tile_snatch(L)
			next_tile_maneater = world.time + tile_maneater_cooldown
			break

/obj/structure/flora/tree/kaizoku_hidden/proc/tree_tile_snatch(mob/living/L)
	if(!L || QDELETED(L) || L.stat == DEAD)
		return
	start_eating_victim(L)

/obj/structure/flora/tree/kaizoku_hidden/proc/start_eating_victim(mob/living/L)
	if(!L || QDELETED(L) || L.stat == DEAD)
		return FALSE
	if(eating_victim && eating_victim != L)
		return FALSE
	if(L.buckled && L.buckled != src)
		L.buckled.unbuckle_mob(L, force = TRUE)
	if(L.buckled != src)
		if(!buckle_mob(L, TRUE, check_loc = FALSE))
			return FALSE
	if(length(L.held_items))
		L.drop_all_held_items()
	L.Knockdown(30)
	if(!HAS_TRAIT(L, TRAIT_NOPAIN))
		L.emote("painscream", forced = TRUE)
	L.visible_message(span_danger("[src] entangles and chews into [L]!"))
	eating_victim = L
	next_eat_tick = world.time + 1
	return TRUE

/obj/structure/flora/tree/kaizoku_hidden/proc/finish_eating_victim()
	if(eating_victim && !QDELETED(eating_victim) && eating_victim.buckled == src)
		unbuckle_mob(eating_victim, force = TRUE)
	eating_victim = null
	pending_limb_munch = FALSE
	pending_final_devour = FALSE

/obj/structure/flora/tree/kaizoku_hidden/proc/tree_tile_munch(mob/living/L)
	if(!L || QDELETED(L) || L.stat == DEAD)
		finish_eating_victim()
		return
	if(L.buckled != src)
		finish_eating_victim()
		return
	if(pending_limb_munch || pending_final_devour)
		return

	if(iscarbon(L))
		var/mob/living/carbon/C = L
		var/obj/item/bodypart/limb = C.get_bodypart_complex(list(BODY_ZONE_L_LEG, BODY_ZONE_R_LEG, BODY_ZONE_L_ARM, BODY_ZONE_R_ARM)) || C.get_bodypart(BODY_ZONE_HEAD)
		if(limb)
			pending_limb_munch = TRUE
			L.visible_message(span_danger("[src] tightens around [L]'s [limb.name], preparing to tear it free!"))
			addtimer(CALLBACK(src, PROC_REF(complete_limb_munch), L, limb), limb_munch_windup)
			return

	pending_final_devour = TRUE
	L.visible_message(span_danger("[src] drags [L] deeper into its maw!"))
	addtimer(CALLBACK(src, PROC_REF(complete_final_devour), L), final_devour_windup)

/obj/structure/flora/tree/kaizoku_hidden/proc/complete_limb_munch(mob/living/L, obj/item/bodypart/limb)
	pending_limb_munch = FALSE
	if(!L || QDELETED(L) || !eating_victim || eating_victim != L)
		return
	if(L.stat == DEAD || L.buckled != src)
		finish_eating_victim()
		return
	if(!limb || QDELETED(limb))
		return
	if(limb.dismember())
		playsound(src, 'modular/kaizoku/sound/misc/eat.ogg', rand(30,60), TRUE)
		qdel(limb)

/obj/structure/flora/tree/kaizoku_hidden/proc/complete_final_devour(mob/living/L)
	pending_final_devour = FALSE
	if(!L || QDELETED(L) || !eating_victim || eating_victim != L)
		return
	if(L.stat == DEAD || L.buckled != src)
		finish_eating_victim()
		return
	playsound(src, 'modular/kaizoku/sound/misc/eat.ogg', rand(30,60), TRUE)
	L.gib(TRUE, TRUE, TRUE, TRUE)
	finish_eating_victim()

/obj/structure/flora/tree/kaizoku_hidden/proc/go_dormant()
	awakened = FALSE
	idle_since = 0
	finish_eating_victim()
	icon_state = "t[rand(1, num_random_icons)]"

/obj/structure/flora/tree/kaizoku_hidden/proc/lash_target(mob/living/L)
	if(!L || L.stat == DEAD)
		return

	if(iscarbon(L))
		var/mob/living/carbon/C = L
		var/obj/item/bodypart/target_part = null
		if(length(C.bodyparts))
			target_part = pick(C.bodyparts)

		var/cut_dmg = rand(melee_cut_damage, melee_cut_damage + 8)
		var/stab_dmg = rand(melee_stab_damage, melee_stab_damage + 6)
		if(target_part)
			if(C.apply_damage(cut_dmg, BRUTE, target_part, C.run_armor_check(target_part, BCLASS_CUT)))
				target_part.try_crit(BCLASS_CUT, cut_dmg / 8)
			if(C.apply_damage(stab_dmg, BRUTE, target_part, C.run_armor_check(target_part, BCLASS_STAB)))
				target_part.try_crit(BCLASS_STAB, stab_dmg / 9)
			C.update_damage_overlays()
		else
			C.adjustBruteLoss(cut_dmg + stab_dmg)
	else
		L.adjustBruteLoss(rand(melee_cut_damage + 8, melee_cut_damage + melee_stab_damage + 10))

	L.visible_message(span_warning("[src] tears and punctures [L] with barbed roots!"))

/obj/structure/flora/tree/kaizoku_hidden/proc/spawn_skulls()
	var/turf/center = get_turf(src)
	if(!center)
		return
	for(var/i in 1 to rand(2, 5))
		var/list/choices = list()
		for(var/turf/T in orange(1, center))
			if(T.density)
				continue
			if(locate(/obj/item/skull) in T)
				continue
			choices += T
		if(!length(choices))
			return
		new /obj/item/skull(pick(choices))

/obj/structure/flora/tree/kaizoku_hidden/proc/spawn_line_tendril(mob/living/target_mob)
	var/turf/start = get_turf(src)
	var/turf/end = get_turf(target_mob)
	if(!start || !end)
		return

	var/obj/effect/kaizoku/tree_tendril/new_tendril = new(start, src, target_mob)
	tendrils += new_tendril

/obj/effect/kaizoku/tree_tendril
	name = "root tendril"
	desc = "A writhing tendril that seeks prey."
	icon = 'modular/kaizoku/icons/mapset/florafauna.dmi'
	icon_state = "mindsmiter_tendril"
	anchored = TRUE
	density = FALSE
	can_buckle = TRUE
	buckle_lying = NO_BUCKLE_LYING
	max_buckled_mobs = 1
	mouse_opacity = 0
	layer = EFFECTS_LAYER
	var/obj/structure/flora/tree/kaizoku_hidden/parent_tree
	var/mob/living/current_target
	var/list/path_turfs = list()
	var/current_length = 0
	var/max_length = 7
	var/growth_speed = 0
	var/next_growth = 0
	var/lifetime = 150 // 15 seconds
	var/created_time = 0
	var/mob/living/captured_victim = null
	var/shrinking = FALSE
	var/next_shrink = 0
	var/shrink_speed = 0
	var/victim_struggle_damage = 0
	var/struggle_breakpoint = 100
	var/list/body_segments = list()
	var/list/body_segments_by_turf = list()
	var/obj/effect/temp_visual/kaizoku/tendril_tip/tip_visual = null

/obj/effect/kaizoku/tree_tendril/Initialize(mapload, obj/structure/flora/tree/kaizoku_hidden/tree, mob/living/target)
	. = ..()
	parent_tree = tree
	current_target = target
	if(parent_tree)
		growth_speed = max(1, parent_tree.tendril_stretch_delay * parent_tree.tendril_speed_slowdown_mult)
		shrink_speed = max(1, round(growth_speed * parent_tree.tendril_pull_slowdown_mult))
	else
		growth_speed = 5
		shrink_speed = 8
	created_time = world.time
	START_PROCESSING(SSfastprocess, src)
	// Start at tree location
	path_turfs += get_turf(src)
	tip_visual = new /obj/effect/temp_visual/kaizoku/tendril_tip(get_turf(src), src)
	sync_tip_position()

/obj/effect/kaizoku/tree_tendril/Destroy()
	STOP_PROCESSING(SSfastprocess, src)
	release_captured_victim(FALSE)
	if(has_buckled_mobs())
		for(var/mob/living/M in buckled_mobs)
			unbuckle_mob(M, force = TRUE)
	if(tip_visual)
		QDEL_NULL(tip_visual)
	if(length(body_segments))
		for(var/obj/effect/kaizoku/tendril_body_segment/B in body_segments)
			if(B)
				qdel(B)
	body_segments = null
	body_segments_by_turf = null
	parent_tree = null
	current_target = null
	// Clean up all tendril segments
	for(var/turf/T in path_turfs)
		for(var/obj/effect/temp_visual/kaizoku/tendril_segment/seg in T)
			if(seg.parent_tendril == src)
				qdel(seg)
	path_turfs = null
	return ..()

/obj/effect/kaizoku/tree_tendril/process()
	if(!parent_tree || QDELETED(parent_tree))
		qdel(src)
		return

	// Check lifetime
	if(world.time > created_time + lifetime)
		qdel(src)
		return

	// Check if target still valid
	if(!current_target || QDELETED(current_target) || current_target.stat == DEAD || current_target.z != parent_tree.z)
		current_target = null
		// Try to find new target
		for(var/mob/living/L in oview(max_length, parent_tree))
			if(L.stat == DEAD || L.z != parent_tree.z)
				continue
			current_target = L
			break

		if(!current_target)
			// Retract if no target
			retract()
			return

	// If shrinking with victim, pull them in
	if(shrinking && captured_victim)
		if(QDELETED(captured_victim) || captured_victim.stat == DEAD)
			release_captured_victim(FALSE)
			shrinking = FALSE
		else
			if(captured_victim.buckled != src)
				buckle_mob(captured_victim, TRUE, check_loc = FALSE)
			if(world.time >= next_shrink && length(path_turfs) > 1)
				next_shrink = world.time + shrink_speed
				shrink_and_pull()
			if(length(path_turfs) <= 1)
				if(parent_tree?.start_eating_victim(captured_victim))
					handoff_captured_victim_to_tree()
				qdel(src)
				return
	else
		// Grow toward target
		if(world.time >= next_growth && current_length < max_length)
			next_growth = world.time + growth_speed
			grow_toward_target()

		// Check for victims along the tendril
		check_victims()

/obj/effect/kaizoku/tree_tendril/proc/grow_toward_target()
	if(!current_target || current_length >= max_length)
		return

	var/turf/current_tip = path_turfs[length(path_turfs)]
	var/turf/target_turf = get_turf(current_target)

	if(!current_tip || !target_turf)
		return

	// Get direction to target (only cardinal directions, no diagonals)
	var/next_dir = get_dir(current_tip, target_turf)
	// Convert diagonal to cardinal
	if(next_dir & (next_dir - 1)) // Check if direction is diagonal
		// Pick horizontal or vertical based on distance
		var/dx = target_turf.x - current_tip.x
		var/dy = target_turf.y - current_tip.y
		if(abs(dx) > abs(dy))
			next_dir = dx > 0 ? EAST : WEST
		else
			next_dir = dy > 0 ? NORTH : SOUTH

	var/turf/next_turf = get_step(current_tip, next_dir)

	// If blocked, try perpendicular directions (still no diagonals)
	if(!next_turf || next_turf.density)
		for(var/alt_dir in list(turn(next_dir, 90), turn(next_dir, -90)))
			next_turf = get_step(current_tip, alt_dir)
			if(next_turf && !next_turf.density)
				break

	if(!next_turf || next_turf.density)
		return

	// Check distance from tree
	if(get_dist(get_turf(parent_tree), next_turf) > max_length)
		return

	// Add to path
	add_body_segment(current_tip)
	path_turfs += next_turf
	current_length++
	sync_tip_position()

	// Create visual segment
	new /obj/effect/temp_visual/kaizoku/tendril_segment(next_turf, src)

	// Sound effect
	if(current_length % 2 == 0)
		playsound(next_turf, "plantcross", 30, TRUE)

/obj/effect/kaizoku/tree_tendril/proc/retract()
	if(length(path_turfs) <= 1)
		qdel(src)
		return

	var/turf/removed = path_turfs[length(path_turfs)]
	path_turfs -= removed
	current_length--
	remove_body_segment(removed)

	// Remove visual
	for(var/obj/effect/temp_visual/kaizoku/tendril_segment/seg in removed)
		if(seg.parent_tendril == src)
			qdel(seg)

	sync_tip_position()
	cleanup_body_segments()

/obj/effect/kaizoku/tree_tendril/proc/check_victims()
	if(!parent_tree || shrinking)
		return

	// Check tip of tendril
	if(length(path_turfs) < 2)
		return

	var/turf/tip = path_turfs[length(path_turfs)]
	for(var/mob/living/L in tip)
		if(L.stat == DEAD)
			continue

		// Capture the victim!
		capture_victim(L)
		break // Only capture one at a time

/obj/effect/kaizoku/tree_tendril/proc/capture_victim(mob/living/L)
	if(!L || QDELETED(L) || L.stat == DEAD)
		return FALSE
	if(captured_victim)
		return FALSE

	if(L.buckled)
		L.buckled.unbuckle_mob(L, force = TRUE)

	if(!buckle_mob(L, TRUE, check_loc = FALSE))
		return FALSE

	captured_victim = L
	shrinking = TRUE
	next_shrink = world.time
	victim_struggle_damage = 0
	L.Knockdown(35)
	L.apply_damage(15, BRUTE)
	if(length(L.held_items))
		L.drop_all_held_items()
	if(L.buckled != src)
		buckle_mob(L, TRUE, check_loc = FALSE)
	L.visible_message(span_danger("[L] is seized by the tendril and begins being dragged toward [parent_tree]!"))
	return TRUE

/obj/effect/kaizoku/tree_tendril/proc/on_victim_resist()
	if(!captured_victim || QDELETED(captured_victim) || !shrinking)
		return

	victim_struggle_damage += rand(20, 35)
	if(captured_victim.client)
		to_chat(captured_victim, span_warning("I struggle against the tendril's grip ([victim_struggle_damage]/[struggle_breakpoint])!"))

	if(victim_struggle_damage >= struggle_breakpoint)
		captured_victim.visible_message(span_warning("[captured_victim] tears free from the tendril!"))
		release_captured_victim(TRUE)
		qdel(src)

/obj/effect/kaizoku/tree_tendril/user_unbuckle_mob(mob/living/M, mob/living/user)
	if(!captured_victim || M != captured_victim)
		return ..()

	if(!isliving(user))
		return

	var/mob/living/L = user
	var/escape_chance = CLAMP(L.STASTR + 10, 5, 95)
	user.changeNext_move(CLICK_CD_RAPID)

	if(prob(escape_chance))
		user.visible_message(span_warning("[user] tears free from [src]!"))
		release_captured_victim(TRUE)
		qdel(src)
	else
		user.visible_message(span_warning("[user] struggles against [src]!"))

/obj/effect/kaizoku/tree_tendril/proc/handoff_captured_victim_to_tree()
	if(!captured_victim)
		return
	if(captured_victim.buckled == src)
		unbuckle_mob(captured_victim, force = TRUE)
	captured_victim = null
	shrinking = FALSE
	victim_struggle_damage = 0

/obj/effect/kaizoku/tree_tendril/proc/shrink_and_pull()
	if(!captured_victim || !parent_tree)
		return

	if(QDELETED(captured_victim) || captured_victim.stat == DEAD)
		release_captured_victim(FALSE)
		return

	// Remove the last segment of tendril
	if(length(path_turfs) > 1)
		var/turf/removed = path_turfs[length(path_turfs)]
		path_turfs -= removed
		current_length--

		// Remove visual
		for(var/obj/effect/temp_visual/kaizoku/tendril_segment/seg in removed)
			if(seg.parent_tendril == src)
				qdel(seg)

		sync_tip_position()

		// Pull victim to new tip position
		if(length(path_turfs) > 0)
			var/turf/new_tip = path_turfs[length(path_turfs)]
			var/turf/victim_turf = get_turf(captured_victim)
			if(new_tip && victim_turf && new_tip != victim_turf)
				if(captured_victim.buckled != src)
					buckle_mob(captured_victim, TRUE, check_loc = FALSE)
				captured_victim.forceMove(new_tip)
				captured_victim.Knockdown(12)

				captured_victim.apply_damage(6, BRUTE)

/obj/effect/kaizoku/tree_tendril/proc/release_captured_victim(apply_recovery = TRUE)
	if(!captured_victim)
		return
	if(captured_victim.buckled == src)
		unbuckle_mob(captured_victim, force = TRUE)
	if(apply_recovery && !QDELETED(captured_victim) && captured_victim.stat != DEAD)
		captured_victim.Paralyze(10)
	captured_victim = null
	shrinking = FALSE
	victim_struggle_damage = 0

/obj/effect/kaizoku/tree_tendril/proc/sync_tip_position()
	if(!length(path_turfs))
		return
	var/turf/tip = path_turfs[length(path_turfs)]
	remove_body_segment(tip)
	if(tip && get_turf(src) != tip)
		forceMove(tip)
	if(tip_visual && tip && get_turf(tip_visual) != tip)
		tip_visual.forceMove(tip)

/obj/effect/kaizoku/tree_tendril/proc/add_body_segment(turf/T)
	if(!T)
		return
	var/key = "[REF(T)]"
	if(body_segments_by_turf[key])
		return
	var/obj/effect/kaizoku/tendril_body_segment/B = new(T, src)
	body_segments += B
	body_segments_by_turf[key] = B

/obj/effect/kaizoku/tree_tendril/proc/remove_body_segment(turf/T)
	if(!T)
		return
	var/key = "[REF(T)]"
	var/obj/effect/kaizoku/tendril_body_segment/B = body_segments_by_turf[key]
	if(B)
		body_segments -= B
		body_segments_by_turf -= key
		qdel(B)

/obj/effect/kaizoku/tree_tendril/proc/cleanup_body_segments()
	if(!length(body_segments))
		return
	var/turf/tip = length(path_turfs) ? path_turfs[length(path_turfs)] : null
	for(var/obj/effect/kaizoku/tendril_body_segment/B in body_segments.Copy())
		if(!B || QDELETED(B))
			body_segments -= B
			continue
		var/turf/BT = get_turf(B)
		if(!BT || BT == tip || !(BT in path_turfs))
			var/key = BT ? "[REF(BT)]" : null
			if(key)
				body_segments_by_turf -= key
			body_segments -= B
			qdel(B)

/obj/effect/kaizoku/tree_tendril/attackby(obj/item/I, mob/user)
	. = ..()
	if(captured_victim && user && user != captured_victim)
		captured_victim.visible_message(span_warning("The tendril recoils and drops [captured_victim]!"))
		release_captured_victim(TRUE)
		qdel(src)

/obj/effect/kaizoku/tree_tendril/attack_hand(mob/user)
	. = ..()
	if(captured_victim && user && user != captured_victim)
		captured_victim.visible_message(span_warning("The tendril recoils and drops [captured_victim]!"))
		release_captured_victim(TRUE)
		qdel(src)

/obj/effect/kaizoku/tendril_body_segment
	name = "tendril"
	icon = 'modular/kaizoku/icons/mapset/florafauna.dmi'
	icon_state = "mindsmiter_tendril"
	anchored = TRUE
	density = FALSE
	layer = EFFECTS_LAYER
	mouse_opacity = MOUSE_OPACITY_ICON
	var/obj/effect/kaizoku/tree_tendril/parent_tendril

/obj/effect/kaizoku/tendril_body_segment/Initialize(mapload, obj/effect/kaizoku/tree_tendril/tendril)
	. = ..()
	parent_tendril = tendril

/obj/effect/kaizoku/tendril_body_segment/attackby(obj/item/I, mob/user)
	. = ..()
	if(!parent_tendril || QDELETED(parent_tendril))
		qdel(src)
		return
	if(parent_tendril.captured_victim && user && user != parent_tendril.captured_victim)
		parent_tendril.captured_victim.visible_message(span_warning("The tendril recoils and drops [parent_tendril.captured_victim]!"))
		parent_tendril.release_captured_victim(TRUE)
	qdel(parent_tendril)

/obj/effect/kaizoku/tendril_body_segment/attack_hand(mob/user)
	. = ..()
	if(!parent_tendril || QDELETED(parent_tendril))
		qdel(src)
		return
	if(parent_tendril.captured_victim && user && user != parent_tendril.captured_victim)
		parent_tendril.captured_victim.visible_message(span_warning("The tendril recoils and drops [parent_tendril.captured_victim]!"))
		parent_tendril.release_captured_victim(TRUE)
	qdel(parent_tendril)

/obj/effect/temp_visual/kaizoku/tendril_tip
	name = "tendril edge"
	icon = 'modular/kaizoku/icons/mapset/florafauna.dmi'
	icon_state = "mindsmiter_tendril"
	anchored = TRUE
	density = FALSE
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	layer = EFFECTS_LAYER + 0.1
	var/obj/effect/kaizoku/tree_tendril/parent_tendril

/obj/effect/temp_visual/kaizoku/tendril_tip/Initialize(mapload, obj/effect/kaizoku/tree_tendril/tendril)
	. = ..()
	parent_tendril = tendril

// Visual segment for tendril path
/obj/effect/temp_visual/kaizoku/tendril_segment
	name = "tendril"
	icon = 'modular/kaizoku/icons/mapset/florafauna.dmi'
	icon_state = "mindsmiter_tendril"
	anchored = TRUE
	density = FALSE
	mouse_opacity = 0
	layer = EFFECTS_LAYER
	duration = 999 // Manually deleted
	var/obj/effect/kaizoku/tree_tendril/parent_tendril

/obj/effect/temp_visual/kaizoku/tendril_segment/Initialize(mapload, obj/effect/kaizoku/tree_tendril/tendril)
	. = ..()
	parent_tendril = tendril

/mob/living/simple_animal/hostile/retaliate/kaizoku/ambush_stalker
	name = "ambush stalker"
	desc = "A patient killer that melts into darkness."
	icon = 'icons/roguetown/mob/monster/skeletons.dmi'
	icon_state = "skeleton"
	icon_living = "skeleton"
	icon_dead = "skeleton_dead"
	ai_controller = /datum/ai_controller/kaizoku_ambusher
	move_to_delay = 4
	melee_damage_lower = 16
	melee_damage_upper = 24
	health = 120
	maxHealth = 120
	vision_range = 7
	aggro_vision_range = 9
	aggro_component_range = 11
	var/seeking_darkness = FALSE
	var/look_for_dark_cooldown = 0

/mob/living/simple_animal/hostile/retaliate/kaizoku/ambush_stalker/Life()
	. = ..()
	if(!.)
		return

	if(isliving(target))
		var/mob/living/current_target = target
		if(current_target.stat != DEAD && get_dist(src, current_target) <= 1 && next_click < world.time)
			ai_controller?.ai_interact(current_target, TRUE, TRUE)
			next_click = world.time + (melee_attack_cooldown || 15)
			SEND_SIGNAL(src, COMSIG_MOB_BREAK_SNEAK)

	// Seek darkness when not sneaking and not in combat
	var/is_sneaking = ai_controller?.blackboard[BB_SNEAKING]
	if(!is_sneaking && !target && world.time >= look_for_dark_cooldown)
		look_for_dark_cooldown = world.time + 5 SECONDS
		seek_darkness()

/mob/living/simple_animal/hostile/retaliate/kaizoku/ambush_stalker/proc/seek_darkness()
	var/turf/my_turf = get_turf(src)
	if(!my_turf)
		return
	var/my_light = my_turf.get_lumcount()
	// Already in darkness
	if(my_light < SHADOW_SPECIES_LIGHT_THRESHOLD)
		return
	// Find darkest nearby turf
	var/turf/darkest = null
	var/darkest_light = 999
	for(var/turf/T in orange(5, src))
		if(T.density)
			continue
		var/light_level = T.get_lumcount()
		if(light_level < darkest_light)
			darkest = T
			darkest_light = light_level
	if(darkest && darkest_light < my_light)
		// Move toward darkness
		walk_to(src, darkest, 1, move_to_delay)

/mob/living/simple_animal/hostile/retaliate/kaizoku/ambush_stalker/AttackingTarget(mob/living/passed_target)
	var/was_sneaking = ai_controller?.blackboard[BB_SNEAKING]
	var/mob/living/actual_target = passed_target
	if(!actual_target)
		actual_target = target
	. = ..()
	if(!. || !was_sneaking || !actual_target)
		return
	var/next_paralyze = ai_controller?.blackboard[BB_KAIZOKU_AMBUSH_PARALYZE_CD]
	if(isnum(next_paralyze) && world.time < next_paralyze)
		return
	actual_target.Paralyze(40)
	ai_controller?.set_blackboard_key(BB_KAIZOKU_AMBUSH_PARALYZE_CD, world.time + 20 SECONDS)
	visible_message(span_danger("[src] strikes from shadow and locks [actual_target] in place!"))
