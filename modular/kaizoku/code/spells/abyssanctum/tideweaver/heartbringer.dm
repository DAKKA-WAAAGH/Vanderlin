// ===================================================================
// HEARTBRINGER - REVIVAL SPELL, TIER 3
// ===================================================================

/datum/action/cooldown/spell/revival_spark //Change to perform later: Sacrifice to be able to be casted.
	name = "~HEARTBRINGER~"
	desc = "Bring back someone with lightning, if you stand in water. May not work on corrupted."
	button_icon = 'modular/kaizoku/icons/misc/spells.dmi'
	button_icon_state = "graydream"
	sound = 'sound/magic/charging.ogg'

	spell_type = SPELL_MIRACLE
	antimagic_flags = MAGIC_RESISTANCE_HOLY
	associated_skill = /datum/skill/magic/holy
	required_items = list(/obj/item/clothing/neck/psycross/silver/abyssanctum)

	invocation = "Abyssor, I plea. Take away this soul from the under realm!"
	invocation_type = INVOCATION_SHOUT

	cast_range = 5
	charge_required = TRUE
	charge_time = 5 SECONDS
	charge_slowdown = 2
	cooldown_time = 2 MINUTES
	spell_cost = 100

/datum/action/cooldown/spell/revival_spark/is_valid_target(atom/cast_on)
	if(!..(cast_on))
		return FALSE

	if(!owner)
		return FALSE

	var/turf/owner_turf = get_turf(owner)
	if(!istype(owner_turf, /turf/open/water))
		to_chat(owner, span_boldwarning("One must draw the forces from Abyssor by standing on water."))
		return FALSE

	if(!isliving(cast_on))
		to_chat(owner, span_warning("This is not a fallen soul."))
		return FALSE

	var/mob/living/L = cast_on
	if(get_dist(owner, L) > cast_range)
		return FALSE

	if(L.stat != DEAD)
		to_chat(owner, span_warning("[L] must be dead to perform this manifestation of Abyssor's will."))
		return FALSE

	if(!L.can_be_revived())
		to_chat(owner, span_warning("[L]'s soul is beyond recovery."))
		return FALSE

	if(HAS_TRAIT(L, TRAIT_NECRA_CURSE))
		to_chat(owner, span_warning("That soul has been touched by a polytheistic dark goddess."))
		return FALSE

	return TRUE

/datum/action/cooldown/spell/revival_spark/cast(atom/cast_on)
	. = ..()
	if(!owner || !isliving(cast_on))
		return FALSE

	var/mob/living/target = cast_on
	var/turf/T = get_turf(owner)

	playsound(T, 'sound/weather/rain/thunder_1.ogg', 80, TRUE)
	T.visible_message(span_boldwarning("Water boils around [owner], crackling in essence beyond matter."))

	spawn(20)
		create_blue_lightning_storm(target)

	spawn(70)
		perform_actual_revival(owner, target)

	return TRUE

/proc/create_blue_lightning_storm(mob/living/target)
	var/turf/T = get_turf(target)
	if(!T)
		return
	for(var/turf/adjacent in spiral_range_turfs(2, T))
		if(!isturf(adjacent))
			continue
		var/obj/effect/temp_visual/lightning_blue/L = new(adjacent)
		L.icon = 'icons/effects/32x96.dmi'
		L.icon_state = "lightning"
		L.color = "#4ad0d4"
		L.light_color = "#4ad0d4"
		L.duration = 12
		spawn(L.duration)
			L.heal_surroundings()

/obj/effect/temp_visual/lightning_blue
	icon = 'icons/effects/32x96.dmi'
	icon_state = "lightning"
	layer = FLY_LAYER
	plane = GAME_PLANE_UPPER
	randomdir = FALSE
	duration = 12

/obj/effect/temp_visual/lightning_blue/proc/heal_surroundings()
	if(!src || !loc)
		return
	var/turf/T = get_turf(src)
	playsound(T, 'sound/magic/lightning.ogg', 70, TRUE)
	for(var/mob/living/M in T.contents)
		M.electrocute_act(1, src)
		M.adjustOxyLoss(-50)
		M.adjustBruteLoss(-10)
		M.adjustFireLoss(-10)
		M.adjustCloneLoss(-25)
		to_chat(M, span_userdanger("It mends... your flesh..."))

/proc/perform_actual_revival(mob/living/user, mob/living/target)
	if(!target || !isliving(target))
		return

	if(target.stat == DEAD && target.can_be_revived())
		var/mob/living/carbon/spirit/underworld_spirit = target.get_spirit()
		if(underworld_spirit)
			var/mob/dead/observer/ghost = underworld_spirit.ghostize()
			qdel(underworld_spirit)
			ghost.mind.transfer_to(target, TRUE)
		target.grab_ghost(force = TRUE)

	if(!target.revive())
		to_chat(user, span_warning("The abyssal surge fails to bring [target] back!"))
		return

	target.visible_message(
		span_info("[target]'s body spasms violently as life returns!"),
		span_notice("A searing jolt breathes me back into the world!")
	)

	target.adjustOxyLoss(-100)
	target.adjustFireLoss(-50)
	target.adjustBruteLoss(-50)
	target.adjustCloneLoss(-50)
	target.restore_blood()
	target.adjust_jitter(100 SECONDS)
	target.emote("gasp")
	target.apply_status_effect(/datum/status_effect/debuff/revive)
