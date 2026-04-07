/datum/job/kaizoku/constable
	title = "Custodian Constable"
	flag = KZ_RETAINER
	department_flag = FACTION_MILITARY
	total_positions = 3
	spawn_positions = 3
	job_flags = (JOB_ANNOUNCE_ARRIVAL | JOB_SHOW_IN_CREDITS | JOB_EQUIP_RANK | JOB_NEW_PLAYER_JOINABLE)
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_CITIZEN_PLAYERS
	allowed_ages = list(AGE_ADULT, AGE_MIDDLEAGED, AGE_IMMORTAL)
	tutorial = "The empire's wars rages beyond your duty as a constable, \
	far more comfortable patrolling alleys and marketplaces while preserving \
	order and ensuring no rebelion sparks. It is well \
	know among the civic authority the outsiders have little to no loyalty \
	to the new banners that embraces them, and thus, you have all the right \
	to fix their defiance, yet be wary of the Clan members watching over, \
	they hold little passion for cynical enforcers."
	display_order = GARRISON_ORDER
	outfit = /datum/outfit/job/kaizoku/constable
	give_bank_account = 20 // Average pay.
	// min_pq = 0 ; Stonekeep Todo - Vanderlin removed PQ, reimplement it later.0
	cmode_music = 'modular/kaizoku/sound/combat/combat_stormwarrior.ogg'

/datum/outfit/job/kaizoku/constable/pre_equip(mob/living/carbon/human/H) //Everything here is placeholder
	..()
	head = /obj/item/clothing/head/helmet/zijinguan
	mask = /obj/item/clothing/face/kaizoku/menpo/half
	armor = /obj/item/clothing/armor/cuirass/iron/sanmaido
	shirt = /obj/item/clothing/armor/gambeson/heavy/battleshirt
	backr = /obj/item/weapon/shield/wood/rattan
	backl = /obj/item/storage/backpack/satchel
	beltr = /obj/item/weapon/sword/scimitar/messer/dao
	beltl = /obj/item/weapon/mace/cudgel/jitte
	scabbards = list(/obj/item/weapon/scabbard/sword)
	cloak = pick(/obj/item/clothing/cloak/half/guard, /obj/item/clothing/cloak/half/guardsecond)//Placeholder
	pants = /obj/item/clothing/pants/trou/leather/splint//Placeholder
	wrists = /obj/item/clothing/wrists/bracers/ironjackchain //Placeholder
	shoes = /obj/item/clothing/shoes/boots/armor/ironmaille/kusaritabi
	belt = /obj/item/storage/belt/leather/townguard
	gloves = /obj/item/clothing/wrists/bracers/leather/khudagach
	backpack_contents = list(/obj/item/rope/chain)


	H.adjust_skillrank(/datum/skill/combat/axesmaces, 3, TRUE) // Main weapon
	H.adjust_skillrank(/datum/skill/combat/shields, 3, TRUE) // Main off-hand weapon
	H.adjust_skillrank(/datum/skill/combat/swords, 2, TRUE) // Backup
	H.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/unarmed, 4, TRUE) // Guards should be going for less than lethal in reality. Unarmed would be a primary thing.
	H.change_stat(STATKEY_STR, 1)
	H.change_stat(STATKEY_END, 2)
	H.change_stat(STATKEY_CON, 1)
	ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
	H.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/athletics, 4, TRUE) // Wrestling is cardio intensive, and guards wrestle with the populace a lot.
	H.adjust_skillrank(/datum/skill/misc/sneaking, 2, TRUE)
	H.adjust_skillrank(/datum/skill/craft/crafting, 1, TRUE)
	H.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
	ADD_TRAIT(H, TRAIT_KNOWBANDITS, TRAIT_GENERIC)
