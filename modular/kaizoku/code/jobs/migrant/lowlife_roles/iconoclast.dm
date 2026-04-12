/datum/job/advclass/kaizoku/lowlife/iconoclast
	title = "Iconoclast"
	tutorial = "You've killed your first person and you've loved to watch their bodies go limp. \
	Coming from afar, you've been killing refugees as they fled, and now, you are here. \
	Your faith in the ten has shattered as Graggar became easier to embrace with each taken life. \
	Of course, your soul may be damned, but such power is intoxicating, too bad the Tideweavers \
	are far too willing to hunt you down for your heresies."
	allowed_sexes = list(MALE, FEMALE)
	outfit = /datum/outfit/kaizoku/lowlife/iconoclast
	category_tags = list(CTAG_LOWLIFE)
	allowed_patrons = list(/datum/patron/inhumen/graggar)
	cmode_music = 'sound/blank.ogg'
	allowed_ages = ALL_AGES_LIST_BLOOMING

/datum/outfit/kaizoku/lowlife/iconoclast
	head = /obj/item/clothing/head/wizhat/witch //Replace this to something Cultist-like
	shoes = /obj/item/clothing/shoes/simpleshoes
	armor = /obj/item/clothing/shirt/robe/colored/mage //Better robe please.
	belt = /obj/item/storage/belt/leather/rope
	backr = /obj/item/storage/backpack/satchel
	beltl = /obj/item/reagent_containers/glass/bottle/manapot
	r_hand = /obj/item/weapon/polearm/woodstaff

/datum/outfit/kaizoku/lowlife/iconoclast // Reminder message
	var/warning = "<br><br><font color='#b91818'><span class='bold'>You are an side-antagonistic freak. \
	Follow up roleplay and common sense as usual to spice a round, but you are allowed to start \
	killing on sight after 30 minutes on the round.</span></font><br><br>"

/datum/outfit/kaizoku/lowlife/iconoclast/pre_equip(mob/living/carbon/human/H)
	..()
	to_chat(H, warning)
	if(H.mind)
		H.adjust_skillrank(/datum/skill/misc/reading, 4, TRUE)
		H.adjust_skillrank(/datum/skill/magic/arcane, 3, TRUE)
		H.adjust_skillrank(/datum/skill/craft/cooking, 1, TRUE)
		H.adjust_skillrank(/datum/skill/craft/alchemy, 2, TRUE)
		H.adjust_skillrank(/datum/skill/misc/medicine, 1, TRUE)
		if(H.age == AGE_OLD)
			H.adjust_skillrank(/datum/skill/magic/arcane, 2, TRUE)
		H.change_stat("strength", -1)
		H.change_stat("intelligence", 3)
		H.change_stat("constitution", -1)
		H.change_stat("endurance", -1)
		H.change_stat("speed", -2)
		H.faction |= list("infernal", "Cabal")
		H.add_spell(/datum/action/cooldown/spell/pointed/corruption)
		H.add_spell(/datum/action/cooldown/spell/undirected/demongaze)
		H.add_spell(/datum/action/cooldown/spell/pointed/sacrificial_rite)
		H.add_spell(/datum/action/cooldown/spell/undirected/hellfire)
		ADD_TRAIT(H, TRAIT_VILLAINOUS, TRAIT_GENERIC)
