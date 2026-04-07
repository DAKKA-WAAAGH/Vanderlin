// ====================================================================================================
// VEIL OF THUNDER, A SUPPORT SPELL. TIER 2
// ====================================================================================================

/mob/living
	var/datum/lightning_shield/shield_status

/datum/action/cooldown/spell/veil_of_spirits
	name = "~SPIRIT VEIL~"
	desc = "Watchful spirits descends from the heavens to answer your cry, giving judgement to armed attackers."
	button_icon = 'modular/kaizoku/icons/misc/spells.dmi'
	button_icon_state = "waternet"
	sound = 'sound/magic/charging.ogg'

	spell_type = SPELL_MIRACLE
	antimagic_flags = MAGIC_RESISTANCE_HOLY
	associated_skill = /datum/skill/magic/holy
	required_items = list(/obj/item/clothing/neck/psycross/silver/abyssanctum)

	invocation = "THE SPIRITS ARE RELENTLESS!" // Warcraft 3 quote reference.
	invocation_type = INVOCATION_SHOUT

	cast_range = 7
	charge_required = FALSE
	cooldown_time = 30 SECONDS
	spell_cost = 45

/datum/action/cooldown/spell/veil_of_spirits/cast(atom/cast_on)
	. = ..()
	if(!owner || !cast_on)
		return FALSE

	var/mob/living/target
	if(isopenturf(cast_on))
		for(var/mob/living/L in cast_on)
			target = L
			break
	else if(isliving(cast_on))
		target = cast_on

	if(!target)
		to_chat(owner, span_warning("Choose a living target."))
		return FALSE
	if(get_dist(owner, target) > cast_range)
		return FALSE

	if(target.shield_status)
		qdel(target.shield_status)

	var/datum/lightning_shield/L = new
	L.activate(target)
	target.shield_status = L

	to_chat(owner, span_info("Spheres of power envelop [target] in a spinning motion."))
	return TRUE

/datum/lightning_shield
	var/mob/living/owner
	var/overlay
	var/intensity = 15
	var/duration = 120

/datum/lightning_shield/proc/activate(mob/living/M)
	owner = M
	if(!owner)
		return
	if(!overlay)
		overlay = mutable_appearance('modular/kaizoku/icons/misc/spells.dmi', "littleangels")
	owner.overlays += overlay
	owner.shield_status = src
	spawn(duration)
		if(owner == M && owner.shield_status == src)
			src.deactivate()

/datum/lightning_shield/proc/deactivate()
	if(owner)
		owner.overlays -= overlay
		if(owner.shield_status == src)
			owner.shield_status = null
	qdel(src)

/datum/lightning_shield/proc/on_attacked(mob/living/attacker)
	if(!attacker || !isliving(attacker))
		return
	attacker.visible_message(span_danger("[attacker] is shocked by wild spirits!"))
	attacker.adjustFireLoss(intensity)
	attacker.Paralyze(10)
	attacker.adjust_jitter(20 SECONDS)
	attacker.electrocute_act(1)
	playsound(get_turf(attacker), 'sound/magic/lightning.ogg', 70, TRUE)
	new /obj/effect/temp_visual/lightning(get_turf(attacker))

/mob/living/attackby(obj/item/I, mob/living/user, params)
	if(shield_status)
		shield_status.on_attacked(user)
		return
	..()
	return

/mob/living/attack_hand(mob/living/user)
	if(shield_status)
		shield_status.on_attacked(user)
		return
	..()
	return

/mob/living/attack_animal(mob/living/user)
	if(shield_status)
		shield_status.on_attacked(user)
		return
	..()
	return

/mob/living/carbon/attack_hand(mob/living/carbon/human/user)
	if(shield_status)
		shield_status.on_attacked(user)
		return
	..()
	return

/mob/living/carbon/human/attack_hand(mob/living/carbon/human/user)
	if(shield_status)
		shield_status.on_attacked(user)
		return
	..()
	return

/obj/effect/temp_visual/lightning
	icon = 'icons/effects/effects.dmi'
	icon_state = "shield"
	duration = 10
	light_outer_range = 2
	layer = FLY_LAYER
	randomdir = FALSE
