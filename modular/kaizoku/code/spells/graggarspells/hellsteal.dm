/datum/action/cooldown/spell/pointed/sacrificial_rite
	name = "Sacrifice Weakling"
	desc = "Restore your power... kill off your weak ally..."
	button_icon = 'modular/kaizoku/icons/misc/spells.dmi'
	button_icon_state = "placeholder"

	spell_type = SPELL_MANA
	// antimagic_flags = MAGIC_RESISTANCE_HOLY

	charge_required = TRUE
	charge_time = 3 SECONDS
	cooldown_time = 30 SECONDS
	spell_cost = 50
	associated_skill = /datum/skill/magic/arcane //Might take 'demonic' or 'holy' here, whatever fits.
	invocation = "YOU ARE WORTHIER FED TO ME!"

/datum/action/cooldown/spell/pointed/sacrificial_rite/cast(atom/cast_on)
	. = ..()
	var/mob/living/carbon/human/living_owner = owner
	if(!living_owner.do_blood_sacrifice())
		return
	if(!isliving(cast_on))
		return

	var/mob/living/target = cast_on

	if(ishuman(target) || target.maxHealth > 300)
		owner.balloon_alert(owner, "This being is... stronger than you.")
		return
	if(("cabal" in target.faction) || (FACTION_CABAL in target.faction) || ("infernal" in target.faction))
		target.adjustBruteLoss(target.maxHealth + 100) //Incase death trigger doesn't work.
		target.death()
		owner.visible_message(span_danger("[owner]'s hand reaches upon [target], drying it into a husk."))
		living_owner.adjustBruteLoss(-50) //This is supposed to heal the caster, mind you.
		living_owner.adjustFireLoss(-50)
		living_owner.adjustToxLoss(-50)
		living_owner.adjustOxyLoss(-50)
		for(var/obj/item/bodypart/BP in living_owner.bodyparts) // This is supposed to heal all wounds.
			for(var/datum/wound/W in BP.wounds)
				BP.remove_wound(W) // Still testing out things.
	else
		if(target.health > 50) // This is just for testing purposes until I find out how to fix the issues this code has.
			target.adjustBruteLoss(30)
			living_owner.adjustBruteLoss(-20)
			owner.visible_message(span_warning("[owner] wounds [target] failing to sacrifice it."))
		else
			owner.balloon_alert(owner, "Not weak enough.")
