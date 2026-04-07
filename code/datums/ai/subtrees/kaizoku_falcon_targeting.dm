/datum/ai_planning_subtree/falcon_custom_targeting

/datum/ai_planning_subtree/falcon_custom_targeting/SelectBehaviors(datum/ai_controller/controller, delta_time)
	var/mob/living/simple_animal/hostile/retaliate/custodianpet/falcon/falcon_pawn = controller.pawn
	if(!istype(falcon_pawn))
		return

	if(falcon_pawn.delivering_letter_anim)
		return SUBTREE_RETURN_FINISH_PLANNING

	if(HAS_TRAIT(falcon_pawn, TRAIT_FALCON_FROZEN))
		return SUBTREE_RETURN_FINISH_PLANNING

	if(HAS_TRAIT(falcon_pawn, TRAIT_FALCON_PERCHED) && controller.blackboard_key_exists(BB_FALCON_CURRENT_TARGET))
		controller.queue_behavior(/datum/ai_behavior/falcon_unperch)
		return SUBTREE_RETURN_FINISH_PLANNING

	var/mob/summoner = controller.blackboard[BB_SUMMONER]

	var/list/focus_targets = controller.blackboard[BB_FOCUS_TARGETS] //Priority 1 - Attack anything you're told to.
	if(length(focus_targets))
		var/mob/target = pick(focus_targets)
		if(!QDELETED(target) && target.stat != DEAD)
			controller.set_blackboard_key(BB_FALCON_CURRENT_TARGET, target)
			controller.queue_behavior(/datum/ai_behavior/basic_melee_attack/falcon, BB_FALCON_CURRENT_TARGET, BB_TARGETTING_DATUM, null)
			return SUBTREE_RETURN_FINISH_PLANNING
		else
			controller.blackboard[BB_FOCUS_TARGETS] -= target

	if(controller.blackboard[BB_FALCON_WANT_PERCH] && controller.blackboard_key_exists(BB_FALCON_PERCH_TARGET)) //Priority 2 - Go to summon to perch.
		var/atom/perch_target = controller.blackboard[BB_FALCON_PERCH_TARGET]
		if(!QDELETED(perch_target))
			var/dist = get_dist(falcon_pawn, perch_target)
			if(dist > 1)
				controller.queue_behavior(/datum/ai_behavior/falcon_follow, BB_FALCON_PERCH_TARGET)
				return SUBTREE_RETURN_FINISH_PLANNING
			else
				controller.queue_behavior(/datum/ai_behavior/falcon_perch_on_target, BB_FALCON_PERCH_TARGET)
				return SUBTREE_RETURN_FINISH_PLANNING

	if(controller.blackboard[BB_FOLLOWING] && summoner && !QDELETED(summoner)) //Priority 3 - Stay close to the summoner.
		var/dist = get_dist(falcon_pawn, summoner)
		if(dist > 2)
			controller.queue_behavior(/datum/ai_behavior/falcon_follow, BB_SUMMONER)
			return SUBTREE_RETURN_FINISH_PLANNING

	if(controller.blackboard[BB_PATROLLING] && summoner && !QDELETED(summoner)) //Priority 4 - Patrol and attack enemies.
		var/closest_target = null
		var/closest_dist = INFINITY

		for(var/mob/living/M in view(10, falcon_pawn))
			if(QDELETED(M) || M.stat == DEAD)
				continue
			if(M == falcon_pawn || M == summoner) //You'd rather not attack yourself or your summoner.
				continue
			if(!falcon_pawn.is_enemy(M)) //Checks if it is an valid enemy first.
				continue

			var/dist = get_dist(falcon_pawn, M)
			if(dist < closest_dist)
				closest_dist = dist
				closest_target = M

		if(closest_target)
			controller.set_blackboard_key(BB_FALCON_CURRENT_TARGET, closest_target)
			controller.queue_behavior(/datum/ai_behavior/basic_melee_attack/falcon, BB_FALCON_CURRENT_TARGET, BB_TARGETTING_DATUM, null)
			return SUBTREE_RETURN_FINISH_PLANNING
		else
			controller.queue_behavior(/datum/ai_behavior/falcon_patrol)
			return SUBTREE_RETURN_FINISH_PLANNING

	if(summoner && !QDELETED(summoner)) //Priotity 5 - Default; Stay near the summoner.
		var/dist = get_dist(falcon_pawn, summoner)
		if(dist > 4)
			controller.queue_behavior(/datum/ai_behavior/falcon_follow, BB_SUMMONER)
			return SUBTREE_RETURN_FINISH_PLANNING

	return
