// ====================================================================================================
// HEAVENLY PILLAR - RAISE PEOPLE FOR FUN, MIGHT MAKE THEM FALL. CAN HELP IN INVADING PLACES - TIER 2
// ====================================================================================================

/datum/action/cooldown/spell/heavens_pillar
	name = "~HEAVENLY COLUMN~"
	desc = "Raises a violent column of wind; slams targets into a ceiling or lifts them upward."
	button_icon = 'modular/kaizoku/icons/misc/spells.dmi'
	button_icon_state = "swirly"
	sound = 'sound/magic/whiteflame.ogg'

	spell_type = SPELL_MIRACLE
	antimagic_flags = MAGIC_RESISTANCE_HOLY
	associated_skill = /datum/skill/magic/holy

	invocation_type = INVOCATION_NONE

	cast_range = 8
	charge_time = 4 SECONDS
	charge_slowdown = 2
	cooldown_time = 30 SECONDS
	spell_cost = 45

/datum/action/cooldown/spell/heavens_pillar/cast(atom/cast_on)
	. = ..()
	if(!owner || !cast_on)
		return FALSE

	var/turf/T
	if(isopenturf(cast_on))
		T = cast_on
	else
		T = get_turf(cast_on)
	if(!isturf(T) || isclosedturf(T))
		to_chat(owner, span_warning("This spell requires open, stable ground."))
		return FALSE
	if(get_dist(get_turf(owner), T) > cast_range)
		to_chat(owner, span_warning("Too far away!"))
		return FALSE

	var/turf/above = get_step_multiz(T, UP)
	var/turf/ceiling = above ? get_step_multiz(above, UP) : null

	var/obj/effect/overlay/tempwarning = new(T)
	tempwarning.name = "rising wind"
	tempwarning.icon = 'modular/kaizoku/icons/misc/spells.dmi'
	tempwarning.icon_state = "swirly"
	tempwarning.layer = EFFECTS_LAYER
	tempwarning.anchored = TRUE
	tempwarning.pixel_y = 0
	QDEL_IN(tempwarning, 10)

	spawn(10)
		if(!T || QDELETED(T))
			return

		var/obj/structure/heavenpillar/P = new(T)
		P.name = "Heaven's Pillar"
		QDEL_IN(P, 150)

		var/turf/open/floor/above_tile
		if(above && istype(above, /turf/open/openspace))
			above_tile = new /turf/open/floor/eyeofstorm(above)
			above_tile.name = "eye of the storm"
			above_tile.desc = "The fierce winds keep you in place, somehow. But its force weakens."
			above_tile.icon = 'modular/kaizoku/icons/misc/spells.dmi'
			above_tile.icon_state = "eye"
			above_tile.overlays += image('modular/kaizoku/icons/misc/spells.dmi', "eye")
			spawn(150)
				if(above_tile && above_tile.loc)
					above_tile.ChangeTurf(/turf/open/openspace)

		for(var/mob/living/M in T.contents)
			if(ceiling && !istransparentturf(ceiling))
				M.visible_message(span_danger("[M] is slammed into the ceiling as the heavenly pillar erupts beneath them!"))
				M.adjustBruteLoss(rand(20, 35))
				M.throw_at(get_step_away(M, T), 2, 1)
			else if(above)
				M.visible_message(span_notice("[M] is caught and raised upwards!"))
				M.forceMove(above)
				M.Stun(20)

	to_chat(owner, span_info("You channel winds to rise like solid stone..."))
	return TRUE

/obj/structure/heavenpillar
	name = "abyssal whirly"
	desc = "The heavens crumble, skies held by one truth. It rises in pride, but under this sacred weight, no one touches the legitimate crown."
	icon = 'modular/kaizoku/icons/misc/spells.dmi'
	icon_state = "whirl"
	density = TRUE
	anchored = TRUE
	max_integrity = 300
	appearance_flags = NO_CLIENT_COLOR

/turf/open/floor/eyeofstorm
	icon_state = "eye"
	footstep = FOOTSTEP_STONE
	barefootstep = FOOTSTEP_HARD_BAREFOOT
	clawfootstep = FOOTSTEP_HARD_CLAW
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY
	damage_deflection = 10
	max_integrity = 2800
