/datum/job/kaizoku/provost
	title = "Custodian Provost"
	flag = KZ_PROVOST
	department_flag = FACTION_MILITARY
	total_positions = 1 // Essentially, You can have 1 Provost, 4 Retainers, 3 Constables, 3 Militia. This breaks down into 11 >ACTIVE soldiers< in total.
	spawn_positions = 1 //This does not include 2 knights, 1 spectacler, and Companion Clan Members, as these are not active soldiers.
	job_flags = (JOB_ANNOUNCE_ARRIVAL | JOB_SHOW_IN_CREDITS | JOB_EQUIP_RANK | JOB_NEW_PLAYER_JOINABLE)
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_CITIZEN_PLAYERS
	allowed_ages = list(AGE_ADULT, AGE_MIDDLEAGED, AGE_IMMORTAL, AGE_ANCIENT)
	tutorial = "The mantle of an provost was never an easy one to bear ever \
	since the Seneschal went to war against Grenzelhoft. Now \
	with their absence, you control the Custodians at mainland. \
	Keep the order of the land, and feed the enemies the end of your boot, \
	and someday, you will be a high ranking Zamurai. \
	Your voice bring morale, and regardless of your bloodline, your leadership \
	is absolute among the Custodians."
	display_order = GARRISON_ORDER
	outfit = /datum/outfit/job/kaizoku/provost //Default outfit.
	give_bank_account = 30
	// min_pq = 0 ; Stonekeep Todo - Vanderlin removed PQ, reimplement it later.
	cmode_music = 'modular/kaizoku/sound/combat/combat_stormwarrior.ogg'

/datum/outfit/job/kaizoku/provost/pre_equip(mob/living/carbon/human/H) // All equipments here are placeholder for now.
	..()
	head = /obj/item/clothing/head/helmet/visored/abyssalchampion
	gloves = /obj/item/clothing/gloves/plate/lamellaetekko
	pants = /obj/item/clothing/pants/platelegs/weepershanwenkai
	armor = /obj/item/clothing/armor/brigandine/godwenkai
	neck = /obj/item/clothing/neck/gorget/lazerrain
	shirt = /obj/item/clothing/armor/gambeson/heavy/battleshirt
	shoes = /obj/item/clothing/shoes/ridingboots/gutal/custodian
	backl = /obj/item/storage/backpack/satchel
	backr = /obj/item/weapon/shield/tower/metal/abyssal
	belt = /obj/item/storage/belt/leather/plaquesilver
	beltl = /obj/item/weapon/sword/sabre/piandao/dec
	beltr = /obj/item/weapon/mace/cudgel/jitte
	cloak = /obj/item/clothing/cloak/captain //VERY Placeholder
	scabbards = list(/obj/item/weapon/scabbard/sword/noble) //VERY Placeholder
	backpack_contents = list(/obj/item/storage/keyring/captain = 1, /obj/item/signal_horn = 1)
	H.adjust_skillrank(/datum/skill/combat/swords, 5, TRUE)
	H.adjust_skillrank(/datum/skill/combat/wrestling, 4, TRUE)
	H.adjust_skillrank(/datum/skill/combat/axesmaces, 4, TRUE)
	H.adjust_skillrank(/datum/skill/combat/shields, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/knives, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/polearms, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/whipsflails, 2, TRUE)

	H.adjust_skillrank(/datum/skill/combat/crossbows, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/bows, 2, TRUE)

	H.adjust_skillrank(/datum/skill/misc/athletics, 4, TRUE)

	H.adjust_skillrank(/datum/skill/misc/swimming, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/riding, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/reading, 2, TRUE)

	H.adjust_skillrank(/datum/skill/labor/mathematics, 3, TRUE)

	H.change_stat(STATKEY_STR, 3)
	H.change_stat(STATKEY_PER, 2)
	H.change_stat(STATKEY_INT, 1)
	H.change_stat(STATKEY_CON, 1)
	H.change_stat(STATKEY_END, 2)
	H.change_stat(STATKEY_SPD, 1)

	ADD_TRAIT(H, TRAIT_NOBLE, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_HEAVYARMOR, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_KNOWBANDITS, TRAIT_GENERIC)
