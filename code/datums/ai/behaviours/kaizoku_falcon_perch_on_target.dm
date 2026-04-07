/datum/ai_behavior/falcon_perch_on_target
	behavior_flags = AI_BEHAVIOR_REQUIRE_MOVEMENT | AI_BEHAVIOR_REQUIRE_REACH

/datum/ai_behavior/falcon_perch_on_target/setup(datum/ai_controller/controller, target_key)
	. = ..()
	var/atom/target = controller.blackboard[target_key]
	if(QDELETED(target))
		return FALSE
	controller.set_movement_target(target)

/datum/ai_behavior/falcon_perch_on_target/perform(delta_time, datum/ai_controller/controller, target_key)
	var/atom/target = controller.blackboard[target_key]
	if(QDELETED(target))
		finish_action(controller, FALSE)
		return

	var/mob/living/simple_animal/hostile/retaliate/custodianpet/falcon/falcon_pawn = controller.pawn
	var/dist = get_dist(falcon_pawn, target)

	if(dist > 1)
		controller.set_movement_target(target)
		return

	if(falcon_pawn.start_perching(target)) //Only try to perch if adjacent, then 'micro-teleport'.
		controller.blackboard[BB_FALCON_WANT_PERCH] = FALSE //This micro-teleport thing might be improved later.
		finish_action(controller, TRUE) // I genuinely only managed to make it work like that.
	else
		controller.blackboard[BB_FALCON_WANT_PERCH] = FALSE
		finish_action(controller, FALSE)

/datum/ai_behavior/falcon_perch_on_target/finish_action(datum/ai_controller/controller, succeeded, target_key)
	. = ..()
	controller.clear_blackboard_key(target_key)
