/datum/ai_controller/falcon
	movement_delay = 0.4 SECONDS
	ai_movement = /datum/ai_movement/hybrid_pathing
	blackboard = list(
		BB_TARGETTING_DATUM = new /datum/targetting_datum/basic(),
		BB_FOCUS_TARGETS = list(),
		BB_PATROLLING = FALSE,
		BB_FOLLOWING = FALSE,
		BB_SUMMONER = null,
		BB_FALCON_PERCH_TYPES = list(),
		BB_FALCON_WANT_PERCH = FALSE,
	)
	planning_subtrees = list(
		/datum/ai_planning_subtree/falcon_custom_targeting,
		/datum/ai_planning_subtree/falcon_perch_behavior,
	)
	idle_behavior = /datum/idle_behavior/idle_random_walk
