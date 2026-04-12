/datum/job/advclass/kaizoku/lowlife/convict
	title = "Penal Battalion"
	tutorial = "You've been caught committing serious crimes, yet had opportunity to choose work camp \
	for an year over rotting away in a cell. \
	Due to the war, explosives litters the waters and your hands have been chosen to disarm them. \
	One wrong move, and said hands becomes part of the sea, if not your life. \
	This is the time to prove your worth to the emperor, filthy convict."
	allowed_sexes = list(MALE, FEMALE)
	outfit = /datum/outfit/kaizoku/lowlife/convict
	category_tags = list(CTAG_LOWLIFE)
	cmode_music = 'sound/blank.ogg'
	allowed_ages = ALL_AGES_LIST_BLOOMING
	bypass_lastclass = TRUE

/datum/outfit/kaizoku/lowlife/convict
	shoes = /obj/item/clothing/shoes/simpleshoes
	pants = /obj/item/clothing/pants/loincloth/colored/brown //Chance these for proper Foglander clothes
	armor = /obj/item/clothing/shirt/robe/colored/plain
	belt = /obj/item/storage/belt/leather/rope
	backr = /obj/item/storage/backpack/satchel

/datum/outfit/kaizoku/lowlife/convict/pre_equip(mob/living/carbon/human/H)
	..()
	if(H.mind)
		H.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
		H.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
		H.adjust_skillrank(/datum/skill/combat/swords, 3, TRUE)
		H.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
		H.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
		H.adjust_skillrank(/datum/skill/misc/athletics, 1, TRUE)
		H.adjust_skillrank(/datum/skill/misc/reading, 2, TRUE)
		H.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
		H.adjust_skillrank(/datum/skill/misc/sneaking, 3, TRUE)
		H.adjust_skillrank(/datum/skill/misc/lockpicking, 2, TRUE)
		H.adjust_skillrank(/datum/skill/misc/riding, 1, TRUE)
		H.adjust_skillrank(/datum/skill/labor/mathematics, 3, TRUE)
		H.change_stat(STATKEY_PER, 2)
		H.change_stat(STATKEY_INT, 1)
		H.change_stat(STATKEY_SPD, 1)
		H.change_stat(STATKEY_END, -1)

		ADD_TRAIT(H, TRAIT_BANDITCAMP, TRAIT_GENERIC)
