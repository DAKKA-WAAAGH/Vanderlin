/datum/job/advclass/kaizoku/lowlife/oddjobber
	title = "Oddjobber"
	tutorial = "Many migrants such as you outside of Fog Islands lacks structured teachings, \
	never something mandated by government but paid by individual's fundings, and many of \
	these only find work as a oddjobber, taking whatever menial work the foglander shun \
	due to the lack of a craft of formal skill. You might not be specialized, \
	but you can work in many things."
	allowed_sexes = list(MALE, FEMALE)
	outfit = /datum/outfit/kaizoku/lowlife/oddjobber
	category_tags = list(CTAG_LOWLIFE)
	cmode_music = 'sound/blank.ogg'
	allowed_ages = ALL_AGES_LIST_BLOOMING

/datum/outfit/kaizoku/lowlife/oddjobber
	shoes = /obj/item/clothing/shoes/simpleshoes
	armor = /obj/item/clothing/shirt/tunic/colored/random
	pants = /obj/item/clothing/pants/tights/colored/random
	belt = /obj/item/storage/belt/leather/rope
	backr = /obj/item/storage/backpack/satchel

/datum/outfit/kaizoku/lowlife/oddjobber/pre_equip(mob/living/carbon/human/H)
	..()
	H.adjust_skillrank(/datum/skill/labor/mining, 2, TRUE)
	H.adjust_skillrank(/datum/skill/labor/farming, 3, TRUE)
	H.adjust_skillrank(/datum/skill/labor/butchering, 2, TRUE)
	H.adjust_skillrank(/datum/skill/labor/lumberjacking, 2, TRUE)
	H.adjust_skillrank(/datum/skill/craft/cooking, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/sewing, 2, TRUE)
	H.adjust_skillrank(/datum/skill/craft/carpentry, 2, TRUE)
	H.adjust_skillrank(/datum/skill/craft/masonry, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
	H.change_stat("strength", 1)
	H.change_stat("endurance", 1)
	H.change_stat("constitution", 1)
	H.change_stat("speed", -1)
