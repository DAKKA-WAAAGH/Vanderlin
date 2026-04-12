/datum/job/advclass/kaizoku/lowlife/counterfeiter
	title = "Counterfeiter"
	tutorial = "You've had luck forging documents and counterfeiting coin on other lands, \
	but as the wars spread, you've been forced to flee to new shores to ply your trade. \
	You've met strict regulations and a very organized system, with money literally recorded in registries, \
	but your skills remains in demand. However, counterfeiting is punishable by death as treason."
	allowed_sexes = list(MALE, FEMALE)
	outfit = /datum/outfit/kaizoku/lowlife/counterfeiter
	category_tags = list(CTAG_LOWLIFE)
	cmode_music = 'sound/blank.ogg'
	allowed_ages = ALL_AGES_LIST_BLOOMING

/datum/outfit/kaizoku/lowlife/counterfeiter
	head = /obj/item/clothing/head/fancyhat
	armor = /obj/item/clothing/shirt/tunic/noblecoat
	cloak = /obj/item/clothing/cloak/cape/colored
	shoes = /obj/item/clothing/shoes/boots
	pants = /obj/item/clothing/pants/trou
	shirt = /obj/item/clothing/shirt/undershirt/colored/random
	neck = /obj/item/storage/belt/pouch/cloth
	belt = /obj/item/storage/belt/leather/rope
	beltl = /obj/item/storage/belt/pouch/coins/poor
	r_hand = /obj/item/weapon/knife/dagger

/datum/outfit/kaizoku/lowlife/counterfeiter/pre_equip(mob/living/carbon/human/H)
	..()
	H.adjust_skillrank(/datum/skill/misc/reading, 4, TRUE)
	H.adjust_skillrank(/datum/skill/craft/crafting, 3, TRUE)
	H.adjust_skillrank(/datum/skill/craft/alchemy, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/stealing, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/sneaking, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/lockpicking, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
	H.change_stat("intelligence", 2)
	H.change_stat("perception", 1)
	H.change_stat("constitution", -1)
