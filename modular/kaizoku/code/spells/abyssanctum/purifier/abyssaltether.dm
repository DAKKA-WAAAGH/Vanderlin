// ===================================================================================================================
// GLACIAL HARPOON, TIER 2 IN PURE HURT JUICE. YOU CAN MOVE AWAY, BUT YOU WISH TO NOT GET TRAPPED ON WALLS.
// ADDITIONAL ASSET. IT ALSO DOESN'T CARE ABOUT WALLS. BECAUSE THIS SPELL IS EVIL.
// ===================================================================================================================

/datum/action/cooldown/spell/abyssal_tether
	name = "~ABYSSAL TETHER~"
	desc = "Jagged trail of abyssal cold that brings damnation in straight lines. No walls shall cease this."
	button_icon = 'modular/kaizoku/icons/misc/spells.dmi'
	button_icon_state = "rake"
	background_icon = 'icons/mob/actions/roguespells.dmi'
	background_icon_state = "spell0"
	active_background_icon_state = "spell1"

	spell_type = SPELL_MIRACLE
	antimagic_flags = MAGIC_RESISTANCE_HOLY
	associated_skill = /datum/skill/magic/holy
	associated_stat = STATKEY_INT

	invocation_type = INVOCATION_NONE
	// sound = 'sound/magic/icecrack.ogg' //The sound disappear for some reason.

	click_to_activate = TRUE               // middle‑click to cast at a tile
	self_cast_possible = TRUE              // can self‑cast; direction taken from owner.dir
	cast_range = 6
	charge_required = FALSE
	cooldown_time = 30 SECONDS
	spell_cost = 25                         // devotion cost (miracle)

/datum/action/cooldown/spell/abyssal_tether/is_valid_target(atom/cast_on)
	// Accept any atom within range; we only need the owner's current facing
	return TRUE

/datum/action/cooldown/spell/abyssal_tether/cast(atom/cast_on)
	. = ..()
	var/mob/living/M = owner
	if(!istype(M))
		return

	var/turf/start = get_turf(M)
	if(!isturf(start))
		return

	var/dx = 0
	var/dy = 0
	switch(M.dir)
		if(NORTH) dy = 1
		if(SOUTH) dy = -1
		if(EAST)  dx = 1
		if(WEST)  dx = -1

	for(var/step in 1 to cast_range)
		spawn(step * 2) // pequenas ondas em sequência
			var/turf/T = locate(start.x + (dx * step), start.y + (dy * step), start.z)
			if(!isturf(T))
				return

			var/obj/structure/tether/I = new /obj/structure/tether(T)
			I.dir = get_dir(start, T)

			for(var/mob/living/L in T.contents)
				if(L == M)
					continue

				L.visible_message("<span class='danger'>[L]'s chest is raked by jagged ice!</span>")

				if(can_escape_wall(L))
					var/turf/throw_to = get_edge_target_turf(L, get_dir(M, T))
					L.throw_at(throw_to, 2, 1, M)
					L.adjustBruteLoss(rand(10, 20))
					L.adjust_eye_blur(5 SECONDS)
					L.apply_status_effect(/datum/status_effect/void_chill)
				else
					L.visible_message(span_danger("[L] is trapped within the ice!"))
					L.adjustBruteLoss(rand(40, 60))
					L.adjust_eye_blur(10 SECONDS)
					L.apply_status_effect(/datum/status_effect/void_chill)
	if(sound)
		playsound(get_turf(owner), sound, 50, TRUE)

/obj/structure/tether
	name = "tether"
	desc = "... The tether that anchor storms, as not all prayers are spoken—many are hurled, tearing through lies as it once did flesh ..."
	icon = 'modular/kaizoku/icons/misc/spells.dmi'
	icon_state = "icewall"
	density = TRUE
	opacity = FALSE
	anchored = TRUE
	max_integrity = 80

/obj/structure/tether/Initialize()
	. = ..()
	QDEL_IN(src, 15 SECONDS)

/proc/can_escape_wall(mob/living/L)
	for(var/dir in GLOB.cardinals)
		var/turf/T = get_step(L, dir)
		if(T && !T.density)
			return TRUE
	return FALSE
