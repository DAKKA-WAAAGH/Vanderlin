/datum/ai_behavior/basic_melee_attack/falcon
	action_cooldown = 2 SECONDS
	behavior_flags = AI_BEHAVIOR_REQUIRE_MOVEMENT | AI_BEHAVIOR_REQUIRE_REACH | AI_BEHAVIOR_CAN_PLAN_DURING_EXECUTION

/datum/ai_behavior/basic_melee_attack/falcon/perform(delta_time, datum/ai_controller/controller, target_key, targetting_datum_key, hiding_location_key)
	var/mob/living/simple_animal/hostile/retaliate/custodianpet/falcon/falcon_pawn = controller.pawn
	if(falcon_pawn.next_click && world.time < falcon_pawn.next_click)
		return

	var/atom/target = controller.blackboard[target_key]
	if(!istype(falcon_pawn) || QDELETED(target))
		finish_action(controller, FALSE)
		return

	var/dist = get_dist(falcon_pawn, target)
	if(dist > 1)
		controller.set_movement_target(target)
		return

	if(dist <= 1 && isliving(target))
		var/mob/living/L = target
		var/list/limb_zones = list(
			BODY_ZONE_L_ARM, BODY_ZONE_R_ARM,
			BODY_ZONE_L_LEG, BODY_ZONE_R_LEG,
			BODY_ZONE_CHEST, BODY_ZONE_HEAD
		)
		var/zone = pick(limb_zones)
		var/obj/item/bodypart/target_bp = L.get_bodypart(zone)
		var/damage = rand(falcon_pawn.melee_damage_lower, falcon_pawn.melee_damage_upper)
		var/wound_class = BCLASS_CUT //Talons = cutting

		var/protected = FALSE //First, armor protection check.
		if(target_bp)
			if(zone == BODY_ZONE_HEAD) //First, check helmets.
				for(var/obj/item/clothing/C in L.contents)
					if(C.slot_flags & ITEM_SLOT_HEAD)
						if(islist(C.prevent_crits) && (wound_class in C.prevent_crits))
							protected = TRUE
							to_chat(L, "<span class='notice'>[C] deflects the falcon's talons!</span>")
							break
			else if(zone == BODY_ZONE_PRECISE_R_EYE || zone == BODY_ZONE_PRECISE_L_EYE)
				for(var/obj/item/clothing/C in L.contents)
					if(C.slot_flags & ITEM_SLOT_MASK)
						if(islist(C.prevent_crits) && (wound_class in C.prevent_crits))
							protected = TRUE
							to_chat(L, "<span class='notice'>[C] protects your eye from the falcon's talons!</span>")
							break

		if(protected)
			falcon_pawn.next_click = world.time + (falcon_pawn.melee_attack_cooldown || 15)
			finish_action(controller, TRUE, target_key)
			return
		falcon_pawn.do_attack_animation(L)

		falcon_pawn.visible_message("<span class='danger'>[falcon_pawn] swoops down at [L], talons sink into [L.p_their()] [parse_zone(zone)]!</span>", COMBAT_MESSAGE_RANGE)
		if(prob(falcon_pawn.attack_sound_chance))
			playsound(get_turf(falcon_pawn), pick(falcon_pawn.attack_hit_sound), 60, TRUE)

		L.apply_damage(damage, BRUTE, zone)

		if(target_bp)
			if(zone == BODY_ZONE_HEAD && prob(25))
				var/eye_type
				var/eye_side
				if(prob(50))
					eye_type = /datum/wound/facial/eyes/right
					eye_side = "right"
				else
					eye_type = /datum/wound/facial/eyes/left
					eye_side = "left"
				if(!L.has_wound(eye_type))
					var/datum/wound/W = new eye_type()
					W.apply_to_bodypart(target_bp, FALSE, TRUE)
					L.visible_message("<span class='critical'>[L]'s [eye_side] eye is gouged!</span>")
					return // Eye gouged, don't apply additional wounds here.
			if(prob(10)) //Regular wound chance for all other zones.
				var/datum/wound/W = new /datum/wound/slash/large()
				W.apply_to_bodypart(target_bp, FALSE, TRUE)
				L.visible_message("<span class='warning'>[L]'s [parse_zone(zone)] is deeply cut!</span>")
			else if(prob(30))
				var/wound_type = damage > 18 ? /datum/wound/slash : /datum/wound/slash/small
				var/datum/wound/W = new wound_type()
				W.apply_to_bodypart(target_bp, FALSE, TRUE)
				L.visible_message("<span class='warning'>[L]'s [parse_zone(zone)] is cut open!</span>")
		falcon_pawn.next_click = world.time + (falcon_pawn.melee_attack_cooldown || 15)
		finish_action(controller, TRUE, target_key)
		return
