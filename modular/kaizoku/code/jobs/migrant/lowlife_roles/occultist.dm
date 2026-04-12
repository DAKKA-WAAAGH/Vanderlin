/datum/job/advclass/kaizoku/lowlife/occultist
	title = "Occultist"
	tutorial = "You are an occultist, whom follows the chaotic whims of Zizo. \
	You are no Noccite hypocrite, you know from where mana truly flows, \
	and through witchcraft, you harness it. The people on this land don't care much \
	for your kind as long you avoid Graggarite connections, but the presence of \
	Psydonites with the refugees started making your life way too problematic."
	allowed_sexes = list(MALE, FEMALE)
	outfit = /datum/outfit/kaizoku/lowlife/occultist
	category_tags = list(CTAG_LOWLIFE)
	allowed_patrons = list(/datum/patron/inhumen/zizo)
	cmode_music = 'sound/blank.ogg'
	allowed_ages = ALL_AGES_LIST_BLOOMING

/datum/outfit/kaizoku/lowlife/occultist
	head = /obj/item/clothing/head/wizhat/witch
	shoes = /obj/item/clothing/shoes/simpleshoes
	armor = /obj/item/clothing/shirt/robe/colored/mage
	belt = /obj/item/storage/belt/leather/rope
	backr = /obj/item/storage/backpack/satchel
	beltl = /obj/item/reagent_containers/glass/bottle/manapot
	r_hand = /obj/item/weapon/polearm/woodstaff

/datum/outfit/kaizoku/lowlife/occultist // Reminder message
	var/warning = "<br><br><font color='#b91818'><span class='bold'>Despite your powers, you are not an antagonistic role. \
	Follow up roleplay and common sense as usual. Let conflict brew rather than killing on sight.</span></font><br><br>"

/datum/outfit/kaizoku/lowlife/occultist/pre_equip(mob/living/carbon/human/H)
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
		H.add_spell(/datum/action/cooldown/spell/pointed/frog_curse)
		H.add_spell(/datum/action/cooldown/spell/pointed/hex_of_withering)
		H.add_spell(/datum/action/cooldown/spell/pointed/witch_powder)
		H.add_spell(/datum/action/cooldown/spell/aoe/diseased_hand)
		H.adjust_spell_points(5)
		H.add_spell(/datum/action/cooldown/spell/undirected/touch/prestidigitation)
