/datum/ai_behavior/falcon_wait_and_perch
	behavior_flags = AI_BEHAVIOR_REQUIRE_MOVEMENT

/datum/ai_behavior/falcon_wait_and_perch/perform(seconds_per_tick, datum/ai_controller/controller, target_key)
	var/mob/living/simple_animal/hostile/retaliate/custodianpet/falcon/falcon_pawn = controller.pawn
	var/mob/living/carbon/human/target = controller.blackboard[target_key]
	if(QDELETED(falcon_pawn) || QDELETED(target))
		finish_action(controller, FALSE, target_key)
		return

	var/dist = get_dist(falcon_pawn, target)
	if(dist > 1)
		set_movement_target(controller, target)
		return

	if(falcon_pawn.start_perching(target)) 	// Adjacent? Then try to perch!
		finish_action(controller, TRUE, target_key)
	else
		finish_action(controller, FALSE, target_key)

/datum/ai_behavior/falcon_follow
	behavior_flags = AI_BEHAVIOR_REQUIRE_MOVEMENT | AI_BEHAVIOR_MOVE_AND_PERFORM

/datum/ai_behavior/falcon_follow/setup(datum/ai_controller/controller, target_key)
	. = ..()
	var/atom/target = controller.blackboard[target_key]
	if(QDELETED(target))
		return FALSE
	set_movement_target(controller, target)

/datum/ai_behavior/falcon_follow/perform(seconds_per_tick, datum/ai_controller/controller, target_key)
	. = ..()
	var/atom/target = controller.blackboard[target_key]
	if(QDELETED(target))
		finish_action(controller, FALSE, target_key)
		return

	var/mob/falcon_pawn = controller.pawn
	var/dist = get_dist(falcon_pawn, target)

	var/required_distance = controller.blackboard[BB_FALCON_WANT_PERCH] ? 1 : 2	// If we're following for perch command, get closer

	if(dist <= required_distance)
		finish_action(controller, TRUE, target_key)
		return
	set_movement_target(controller, target)
