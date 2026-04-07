
/datum/ai_planning_subtree/falcon_perch_behavior //This is a subtree so the bird perches on targets.
	var/perch_chance = 6 //Chance to perchh
	var/unperch_chance = 8 //Chance to unperch when not attacking

/datum/ai_planning_subtree/falcon_perch_behavior/SelectBehaviors(datum/ai_controller/controller, delta_time)
	var/mob/living/simple_animal/hostile/retaliate/custodianpet/falcon/falcon_pawn = controller.pawn
	var/is_perched = HAS_TRAIT(falcon_pawn, TRAIT_FALCON_PERCHED)
	if(HAS_TRAIT(falcon_pawn, TRAIT_FALCON_FROZEN)) //Perched on player? Don't perch on objects.
		return SUBTREE_RETURN_FINISH_PLANNING

	if(is_perched && controller.blackboard_key_exists(BB_FALCON_CURRENT_TARGET))// If perched on object and have a target, unperch to attack
		controller.queue_behavior(/datum/ai_behavior/falcon_unperch)
		return SUBTREE_RETURN_FINISH_PLANNING

	if(is_perched) // If perched on object, decide whether to unperch or stay
		if(prob(unperch_chance))
			controller.queue_behavior(/datum/ai_behavior/falcon_unperch)
			return SUBTREE_RETURN_FINISH_PLANNING
		return SUBTREE_RETURN_FINISH_PLANNING

	// Explicit perch command (BB_FALCON_WANT_PERCH) takes priority - don't auto-perch on objects
	if(controller.blackboard[BB_FALCON_WANT_PERCH])
		return

	// During patrol mode, allow falcon to opportunistically perch on objects
	if(controller.blackboard[BB_PATROLLING])
		if(prob(perch_chance))
			// Try to find a nearby perch object
			var/list/perch_types = controller.blackboard[BB_FALCON_PERCH_TYPES]
			if(perch_types && length(perch_types))
				for(var/atom/perch_target in view(5, falcon_pawn))
					if(is_type_in_list(perch_target, perch_types) && get_dist(falcon_pawn, perch_target) <= 1)
						if(falcon_pawn.start_perching(perch_target))
							return SUBTREE_RETURN_FINISH_PLANNING
		return

	// Standard perching logic for follow/idle
	if(!prob(perch_chance))
		return

	if(controller.blackboard_key_exists(BB_FALCON_PERCH_TARGET))
		controller.queue_behavior(/datum/ai_behavior/falcon_wait_and_perch, BB_FALCON_PERCH_TARGET)
		return SUBTREE_RETURN_FINISH_PLANNING

	var/mob/summoner = controller.blackboard[BB_SUMMONER]
	// During non-patrol, prefer perching on summoner if nearby
	if(prob(75) && summoner && !QDELETED(summoner) && get_dist(falcon_pawn, summoner) <= 3)
		controller.set_blackboard_key(BB_FALCON_PERCH_TARGET, summoner)
		controller.queue_behavior(/datum/ai_behavior/falcon_perch_on_target, BB_FALCON_PERCH_TARGET)
		return SUBTREE_RETURN_FINISH_PLANNING
	else
		// Try to find a nearby object to perch on
		controller.queue_behavior(/datum/ai_behavior/find_and_set/in_list, BB_FALCON_PERCH_TARGET, controller.blackboard[BB_FALCON_PERCH_TYPES])
		return
