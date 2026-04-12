/datum/job/advclass/kaizoku/lowlife/bloodcollector
	title = "Blood Collector"
	tutorial = "You are the true vulture of the desperated, preying upon \
	indebted foreigners and lower classes by exchanging funds for \
	blood, teeth and bone marrow. Ever since you've been hired by \
	Rockhill's organ harvesting black market, you've had to work in secrecy to avoid \
	bringing the attention of Constables on your occult activities. \
	Search for the sewer canals to exchange your collections for kaichins."
	allowed_sexes = list(MALE, FEMALE)
	outfit = /datum/outfit/kaizoku/lowlife/bloodcollector
	category_tags = list(CTAG_LOWLIFE)
	cmode_music = 'sound/blank.ogg'
	allowed_ages = ALL_AGES_LIST_BLOOMING
	give_bank_account = 5 //You will need your bank account for this one.

/datum/outfit/kaizoku/lowlife/bloodcollector
	head = /obj/item/clothing/head/roguehood/colored/black
	backl = /obj/item/storage/backpack/satchel/surgbag/bloodcollector
	shoes = /obj/item/clothing/shoes/simpleshoes
	beltr = /obj/item/weapon/mace/cudgel // So you have something to beat people with, for... forced teeth removal, yes.
	shirt = /obj/item/clothing/shirt/undershirt/colored/random
	pants = /obj/item/clothing/pants/tights/colored/random
	gloves = /obj/item/clothing/gloves/leather/phys
	armor = /obj/item/clothing/shirt/robe/phys
	neck = /obj/item/storage/belt/pouch/cloth
	// wrists = /obj/item/storage/keyring/clinicapprentice // Change this for random Lowlife housekey
	belt = /obj/item/storage/belt/leather/rope

/datum/outfit/kaizoku/lowlife/bloodcollector/pre_equip(mob/living/carbon/human/H)
	..()
	if(H.mind)
		H.adjust_skillrank(/datum/skill/combat/knives, 3, TRUE)
		H.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
		H.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
		H.adjust_skillrank(/datum/skill/misc/athletics, 1, TRUE)
		H.adjust_skillrank(/datum/skill/craft/crafting, 2, TRUE)
		H.adjust_skillrank(/datum/skill/misc/reading, 2, TRUE)
		H.adjust_skillrank(/datum/skill/craft/alchemy, 1, TRUE)
		H.adjust_skillrank(/datum/skill/misc/medicine, 1, TRUE) //You are not an actual doctor.
	H.change_stat(STATKEY_INT, 1)
	H.change_stat(STATKEY_STR, 1) // So you can sometimes beat someone to zhit for their blood.
	H.change_stat(STATKEY_CON, 1)
	ADD_TRAIT(H, TRAIT_FORAGER, TRAIT_GENERIC)

/obj/item/storage/backpack/satchel/surgbag/bloodcollector
	populate_contents = list( //Change all these surgery equipments for the handmade version.
		/obj/item/needle,
		/obj/item/weapon/surgery/scalpel,
		/obj/item/weapon/surgery/hemostat,
		/obj/item/weapon/surgery/hemostat,
		/obj/item/weapon/surgery/retractor,
		/obj/item/weapon/surgery/bonesetter, //Change that to the teeth collector thing.
		/obj/item/weapon/surgery/cautery,
		/obj/item/natural/worms/leech, //Change to that blood collection thing.
		/obj/item/natural/worms/leech, //Change to that bone marrow collection thing
		/obj/item/natural/bundle/fibers/full,
	)
