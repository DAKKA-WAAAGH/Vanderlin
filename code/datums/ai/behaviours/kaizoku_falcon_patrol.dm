/datum/ai_behavior/falcon_patrol
	behavior_flags = AI_BEHAVIOR_REQUIRE_MOVEMENT | AI_BEHAVIOR_MOVE_AND_PERFORM

var/next_patrol_time = 0

/datum/ai_behavior/falcon_patrol/perform(delta_time, datum/ai_controller/controller)
	var/mob/falcon_pawn = controller.pawn
	var/mob/summoner = controller.blackboard[BB_SUMMONER]
	if(!summoner || QDELETED(summoner))
		finish_action(controller, FALSE)
		return
	if(world.time >= next_patrol_time)
		var/patrol_radius = 7
		var/target_x = summoner.x + rand(-patrol_radius, patrol_radius)
		var/target_y = summoner.y + rand(-patrol_radius, patrol_radius)
		var/turf/target_turf = locate(target_x, target_y, summoner.z)

		if(target_turf && !target_turf.density)
			controller.set_movement_target(target_turf)
			next_patrol_time = world.time + 40
		else
			next_patrol_time = world.time + 5 //The turf was invalid? Try again
		return //Keep patrolling, not finished yet.
	var/dist_to_summoner = get_dist(falcon_pawn, summoner) //We're TOO FAR from the summoner, now.
	if(dist_to_summoner > 12)
		controller.set_movement_target(summoner)
		return

	// Continue patrolling
	finish_action(controller, TRUE)
