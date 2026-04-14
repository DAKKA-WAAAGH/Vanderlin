GLOBAL_LIST_INIT(abyssal_readme, world.file2list("strings/rt/abyssaltide.json"))

// =============================================================================
// ========================	SPRITE ACCESSORIES	================================
/*
/datum/sprite_accessory/underwear/male_fundoshi
	name = "Mendoshi"
	icon_state = "male_fundoshi"
	gender = MALE
	specuse = list("abyssariad")
	roundstart = TRUE
	use_static = TRUE
	icon = 'modular/kaizoku/icons/clothing/underwear.dmi'
*/
/datum/sprite_accessory/underwear/male_fundoshi/female
	name = "Femdoshi"
	icon_state = "female_fundoshi"
	gender = FEMALE
	specuse = list("abyssariad")
	roundstart = TRUE
	use_static = TRUE


// Kaizoku bodyparts
// ACCESORIES ARE DEPRECATED. USE SPRITE ACCESSORY AND ORGANS.



// END OF KAIZOKU RACES BODYPARTS
/* Issues? ROGTODO
/datum/sprite_accessory/detail
	specuse = list("human", "dwarf", "elf", "aasimar", "tiefling", "halforc", "abyssariad")

/datum/sprite_accessory/detail/irezumi
	icon = 'modular/kaizoku/icons/body_details/attachment.dmi'
	name = "Blademaster Irezumi"
	icon_state = "blademaster"
	specuse = list("human", "abyssariad") //Humens are getting irezumis due to heartfelt.

/datum/sprite_accessory/detail/irezumi/champion
	icon = 'modular/kaizoku/icons/body_details/attachment.dmi'
	name = "Champion Irezumi"
	icon_state = "champion"

/datum/sprite_accessory/detail/irezumi/monk
	icon = 'modular/kaizoku/icons/body_details/attachment.dmi'
	name = "Monk Irezumi"
	icon_state = "monk"

/datum/sprite_accessory/detail/irezumi/seduction
	icon = 'modular/kaizoku/icons/body_details/attachment.dmi'
	name = "Eyes Irezumi"
	icon_state = "seduction"

/datum/sprite_accessory/detail/irezumi/seductionalt
	icon = 'modular/kaizoku/icons/body_details/attachment.dmi'
	name = "Side-eyes Irezumi"
	icon_state = "seductionalt"

/datum/sprite_accessory/detail/irezumi/warrior
	icon = 'modular/kaizoku/icons/body_details/attachment.dmi'
	name = "Abyss Warrior Irezumi"
	icon_state = "warrior"
*/

/datum/outfit/job/pre_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	. = ..()
	if(H.mind)
		if(H.dna)
			if(H.dna.species)
				if(H.dna.species.id == "abyssariad")
					H.verbs |= /mob/proc/throatsing
					H.verbs |= /mob/living/carbon/human/proc/abyssalcombat
					H.verbs |= /mob/proc/abyssaltide
					H.cmode_music = 'sound/blank.ogg'
					ADD_TRAIT(H, TRAIT_KAIZOKU, TRAIT_GENERIC)
					if(H.dna.species.name == "Changeling")
						H.verbs |= /mob/living/carbon/human/proc/toggle_changeling_maw
						//H.verbs |= /mob/living/carbon/human/proc/toggle_shapeshift // Not done. The idea is for changelings to choose their specialization later.
						//H.verbs |= /mob/living/carbon/human/proc/toggle_mimicry //This one isn't working.
						ADD_TRAIT(H, TRAIT_CHANGELING_METABOLISM, TRAIT_GENERIC) //Both an advantage and a disadvantage, essentially carnivore code + Venom bite.
						ADD_TRAIT(H, TRAIT_BEAUTIFUL, TRAIT_GENERIC) //Mythology Kitsune trope //hopefully// done right. Seduction may go a long way to KILL victims.
						// please. Don't make me feel like I did a wrong move here. I swear to INARI. You people fucked up too much for my taste.
					if(H.dna.species.name == "Skylancer")
						H.verbs |= /mob/proc/birdcall
						H.verbs |= /mob/living/carbon/human/proc/fly
						H.verbs |= /mob/living/carbon/human/proc/fly_up
					if(H.dna.species.name == "Ogrun")
						H.verbs |= /mob/living/carbon/human/proc/warcry
/*				if(H.dna.species.name == "Undine") //undine ability; Making below-average armor with normal random things/butchered goods.
					H.verbs |= /mob/living/carbon/human/proc/abyssalcombat
					H.cmode_music = 'sound/blank.ogg'
					ADD_TRAIT(H, TRAIT_KAIZOKU, TRAIT_GENERIC)
					H.mind.teach_crafting_recipe(/datum/crafting_recipe/reinforcedarmor)
					H.mind.teach_crafting_recipe(/datum/crafting_recipe/reinforcedhelmet)
					H.mind.teach_crafting_recipe(/datum/crafting_recipe/mediumhelmet)
					H.mind.teach_crafting_recipe(/datum/crafting_recipe/mediumarmor)
					H.mind.teach_crafting_recipe(/datum/crafting_recipe/lighthelmet)
					H.mind.teach_crafting_recipe(/datum/crafting_recipe/lightarmor)
					H.mind.teach_crafting_recipe(/datum/crafting_recipe/obsidian_spear)
					H.mind.teach_crafting_recipe(/datum/crafting_recipe/obsidian_club)
					H.verbs |= /mob/proc/croak



H.mind.teach_crafting_recipe(/datum/repeatable_crafting_recipe/dendor/visage)

/datum/repeatable_crafting_recipe/dendor/visage
	name = "druids mask (unique)"
	attacked_atom = /obj/item/grown/log/tree/small
	starting_atom = /obj/item/weapon/knife
	tool_usage = list(
		/obj/item/weapon/knife = list(span_notice("starts to whittle"), span_notice("start to whittle"), 'modular/kaizoku/sound/items/wood_sharpen.ogg'),
	)
	requirements = list(/obj/item/grown/log/tree/small = 1)
	output = /obj/item/clothing/face/druid
	subtypes_allowed = TRUE
*/

/* Add to kaizok jobs
	if(H.dna.species.id == "human")
		H.skin_tone = SKIN_COLOR_TROPICALDRY
		ADD_TRAIT(H, TRAIT_KAIZOKU, TRAIT_GENERIC)
		H.grant_language(/datum/language/abyssal)
*/

/datum/stress_event/raider
	timer = 1 MINUTES
	stress_change = 1
	desc = "<span class='red'>Vicious sea raider, they prey on fellow men.</span>"

/datum/stress_event/whaler
	timer = 1 MINUTES
	stress_change = 1
	desc = "<span class='red'>Filthy corrupted whaler. Never forget the Storm Lord.</span>"

// TODO: Employ this tongue so they can open and close their spooky maws
/obj/item/organ/tongue/kitsune
	name = "changeling tongue"
	desc = "The tongue that inwardly bends the moldable changeling skull into a glasgow smile, or other shapes depending on their branch."
	icon = 'modular/kaizoku/icons/misc/surgery.dmi'
	icon_state = "eldritch"
	slot = ORGAN_SLOT_TONGUE
	zone = BODY_ZONE_PRECISE_MOUTH
	slot = ORGAN_SLOT_TONGUE

/obj/item/organ/eyes/rogue/tengu
	name = "tengu eyes"
	eye_icon_state = "tengu_eye"
	icon = 'modular/kaizoku/icons/misc/surgery.dmi'
	mob_overlay_icon = 'modular/kaizoku/icons/misc/surgery_mob.dmi'
	icon_state = "tengu_eye"

/* Kaizoku Change
/mob/living/carbon/human/species/abyssariad/raider/stripPanelUnequip(obj/item/what, mob/living/who, where)
	if(istype(who, /mob/living))
		if(who.abyssariadraider == TRUE && who.stat == CONSCIOUS) //If they are unconscious, you can loot them.
			src.visible_message(
				"<span class='danger'>[who] grabs [src]'s exposed arm before slamming them on the ground!</span>")
			src.AdjustKnockdown(5 + rand(3, 5))
			src.apply_damage(rand(5, 10), BRUTE, BODY_ZONE_CHEST)
			playsound(get_turf(src), 'modular/kaizoku/sound/combat/shieldraise.ogg', 100, TRUE)
			if(length(GLOB.custodian_handsoff))
				who.say(pick(GLOB.custodian_handsoff))
			return
	..()
*/

/datum/customizer/bodypart_feature/hair/head/humanoid/kaizoku
	customizer_choices = list(/datum/customizer_choice/bodypart_feature/hair/head/humanoid/kai)

/datum/customizer_choice/bodypart_feature/hair/head/humanoid/kai
	sprite_accessories = list(
		/datum/sprite_accessory/hair/head/empress,
		/datum/sprite_accessory/hair/head/onnamusha,
		/datum/sprite_accessory/hair/head/waterfield,
		/datum/sprite_accessory/hair/head/homewaifu,
		/datum/sprite_accessory/hair/head/casual,
		/datum/sprite_accessory/hair/head/martyr,
		/datum/sprite_accessory/hair/head/zamurai,
		/datum/sprite_accessory/hair/head/ronin,
		/datum/sprite_accessory/hair/head/freespirit,
		/datum/sprite_accessory/hair/head/novice,
		/datum/sprite_accessory/hair/head/yakuza,
		/datum/sprite_accessory/hair/head/steppeman,
		/datum/sprite_accessory/hair/head/bishonen,
		/datum/sprite_accessory/hair/head/emperor,
		/datum/sprite_accessory/hair/head/protagonist,
		/datum/sprite_accessory/hair/head/protagonistalt,
	)

/proc/is_abyssorfaithful(datum/patron/P)
	var/list/valid = list(
		/datum/patron/divine/abyssor,
		/datum/patron/abyssanctum/tideweaver,
		/datum/patron/abyssanctum/curator,
		/datum/patron/abyssanctum/purifier,
		/datum/patron/abyssanctum/silent
	)
	for(var/type in valid)
		if(istype(P, type))
			return TRUE
	return FALSE

/*
/datum/devotion/cleric_holder/proc/grant_spells_sohei(mob/living/carbon/human/H)
	if(!H || !H.mind)
		return

	var/datum/patron/A = H.patron
	var/list/spelllist = list(/obj/effect/proc_holder/spell/invoked/gale_palm, A.t0) //Placeholder. Need to change this for a Sohei-only.
	for(var/spell_type in spelllist)
		if(!spell_type || H.mind.has_spell(spell_type))
			continue
		H.mind.AddSpell(new spell_type)
	level = CLERIC_T0
	max_devotion = 150
*/
