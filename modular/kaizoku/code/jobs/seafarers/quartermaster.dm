// The Quartermaster, differently of most 'Worker' roles, are actually members of the military.
// There will be no stretch to keep them weaker than unspecialized basic warriors, even if they are
// essencially the workforce. If someone attempts to attack them, they should struggle
// similarly to your average armorless warrior.

/datum/job/kaizoku/quartermaster
	title = "Imperial Quartermaster"
	allowed_races = RACES_PLAYER_ALL
	department_flag = FACTION_IMPERIAL
	display_order = KZ_QUARTERMASTER
	job_flags = (JOB_ANNOUNCE_ARRIVAL | JOB_SHOW_IN_CREDITS | JOB_EQUIP_RANK | JOB_NEW_PLAYER_JOINABLE )
	faction = FACTION_TOWN
	// min_pq = 0 ; Stonekeep Todo - Vanderlin removed PQ, reimplement it later.
	bypass_lastclass = TRUE
	total_positions = 1
	spawn_positions = 1

	allowed_races = RACES_CITIZEN_PLAYERS //To be this job, you require studies. Only citizens have this right.

	tutorial = "You are a court officer, the backbone of supplies with your fogcruisers. \
	Your captain is protecting the coast against Grenzelhoft, \
	leaving you with armed civilians and a few ships to do the raiding business. \
	Do not let others midjudge you, you are the most important gear on this war machine, \
	providing the tower with trade, rations, and many more. \
	The navy is bound to the capital's court, and not to the \
	ruling clans on the outskirts, but you cooperate to bring victory to the Heavenly Emperor."
	display_order = MERCHANT_ORDER
	outfit = /datum/outfit/job/kaizoku/quartermaster
	give_bank_account = 100
	selection_color = "#2a348b"
	cmode_music = 'modular/kaizoku/sound/combat/combat_searaider.ogg' // Remove this SHET. Give it PIRATE music.

/datum/outfit/job/kaizoku/quartermaster/pre_equip(mob/living/carbon/human/H)
	..()

	backr = /obj/item/storage/backpack/satchel
	backpack_contents = list(/obj/item/storage/belt/pouch/coins/veryrich = 1, /obj/item/merctoken = 1)
	beltr = /obj/item/weapon/sword/iron/jian
	belt = /obj/item/storage/belt/leather/plaquesilver
	beltl = /obj/item/storage/keyring/merchant_hamlet
	armor = /obj/item/clothing/shirt/robe/merchant
	head = /obj/item/clothing/head/chaperon
	ring = /obj/item/clothing/ring/gold/guild_mercator
	shoes = /obj/item/clothing/shoes/boots/leather

	if(H.gender == MALE)
		shirt = /obj/item/clothing/shirt/undershirt/sailor
		pants = /obj/item/clothing/pants/tights/sailor

	else
		shirt = /obj/item/clothing/shirt/tunic/colored/blue

	ADD_TRAIT(H, TRAIT_SEEPRICES, type)
	ADD_TRAIT(H, TRAIT_FOREIGNER, TRAIT_GENERIC)

	H.change_stat(STATKEY_INT, 2)
	H.change_stat(STATKEY_PER, 1)
	H.change_stat(STATKEY_STR, 1) //Military, do Military things.

	H.adjust_skillrank(/datum/skill/combat/swords, 3, TRUE) // Military.
	H.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/reading, 5, TRUE)
	H.adjust_skillrank(/datum/skill/misc/sneaking, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE) //They work with the ocean, they've paddled on it.
	H.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE) //Pulling themselves out of the ocean's rocky shores.
	H.adjust_skillrank(/datum/skill/misc/medicine, 1, TRUE)
	H.adjust_skillrank(/datum/skill/misc/athletics, 2, TRUE) // Military.
	//H.adjust_skillrank(/datum/skill/misc/stealing, 2, TRUE) // Removed two points of stealing, brought it to Lockpicking and Riding.
	H.adjust_skillrank(/datum/skill/misc/lockpicking, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/riding, 2, TRUE)
