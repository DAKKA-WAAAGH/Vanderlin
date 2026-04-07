/datum/ai_behavior/falcon_unperch/perform(seconds_per_tick, datum/ai_controller/controller)
	var/mob/living/simple_animal/hostile/retaliate/custodianpet/falcon/falcon_pawn = controller.pawn

	if(!HAS_TRAIT(falcon_pawn, TRAIT_FALCON_PERCHED))
		finish_action(controller, FALSE)
		return
	if(falcon_pawn.buckled) //Buckled to a human? Unbuckle.
		falcon_pawn.buckled.unbuckle_mob(falcon_pawn)
	else
		falcon_pawn.toggle_perched(perched = FALSE) //Perched on an object? Toggle itself off.

	finish_action(controller, TRUE)
	return TRUE
