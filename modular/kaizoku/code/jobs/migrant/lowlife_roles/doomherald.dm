/datum/job/advclass/kaizoku/lowlife/doomherald
	title = "Doom Herald"
	tutorial = "You've came from the lands beyond, a foreigner that saw too much. \
	You've witnessed horrors of the denmorian swarms, demonic invasions, the collapse of society, \
	pain, sexual humiliation and the impaled corpses set ablaze as they laughted in glee. \
	So here you are, wandering while preaching the end of days to anyone who'll listen."
	allowed_sexes = list(MALE, FEMALE)
	outfit = /datum/outfit/kaizoku/lowlife/doomherald
	category_tags = list(CTAG_LOWLIFE)
	cmode_music = 'sound/blank.ogg'
	allowed_ages = ALL_AGES_LIST_BLOOMING

/datum/outfit/kaizoku/lowlife/doomherald //Placeholder outfit.
	head = /obj/item/clothing/head/roguehood/astrata
	//neck = /obj/item/clothing/neck/psycross/silver/astrata //Not really followers of astrata. Just placeholder.
	wrists = /obj/item/clothing/wrists/wrappings
	shoes = /obj/item/clothing/shoes/sandals
	armor = /obj/item/clothing/shirt/robe/astrata
	r_hand = /obj/item/weapon/polearm/woodstaff/quarterstaff
	belt = /obj/item/storage/belt/leather/rope
	beltr = /obj/item/storage/belt/pouch/coins/poor

/datum/outfit/kaizoku/lowlife/doomherald/pre_equip(mob/living/carbon/human/H)
	..()
	H.adjust_skillrank(/datum/skill/misc/sewing, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/medicine, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/polearms, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/axesmaces, 1, TRUE)
	H.adjust_skillrank(/datum/skill/misc/athletics, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/reading, 3, TRUE)
	H.change_stat("intelligence", 1)
	H.change_stat("endurance", 2)
	H.change_stat("perception", -1)
