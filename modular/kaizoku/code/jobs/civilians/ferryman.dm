/datum/job/kaizoku/ferryman
	title = "Thresholder"
	tutorial = "Abyssanctum servant, guidance of both life and death. \
	You must ensure the dead find their way to the abyssal afterlife, \
	while protecting the living from restless spirits and bringing them \
	to the chores they've hired you for. \
	You can create and control ship graves or small ships for all purposes. "
	department_flag = FACTION_CITIZENS
	display_order = KZ_FERRYMAN
	job_flags = (JOB_ANNOUNCE_ARRIVAL | JOB_SHOW_IN_CREDITS | JOB_EQUIP_RANK | JOB_NEW_PLAYER_JOINABLE)
	faction = FACTION_TOWN
	total_positions = 3
	spawn_positions = 3
	// min_pq = 0 ; Stonekeep Todo - Vanderlin removed PQ, reimplement it later.
	bypass_lastclass = TRUE

	allowed_races = RACES_PLAYER_ALL
	outfit = /datum/outfit/kaizoku/ferryman
	give_bank_account = TRUE
	cmode_music = 'sound/music/cmode/church/CombatGravekeeper.ogg'
	job_bitflag = BITFLAG_CHURCH

	// exp_types_granted  = list(EXP_TYPE_CHURCH, EXP_TYPE_CLERIC)

/datum/outfit/kaizoku/ferryman/pre_equip(mob/living/carbon/human/H)
	..()
	head = /obj/item/clothing/head/padded/deathshroud
	neck = /obj/item/clothing/neck/psycross/silver/necra
	pants = /obj/item/clothing/pants/trou/leather/mourning
	armor = /obj/item/clothing/shirt/robe/necra
	shoes = /obj/item/clothing/shoes/boots
	belt = /obj/item/storage/belt/leather
	beltl = /obj/item/storage/keyring/gravetender
	beltr = /obj/item/storage/belt/pouch/coins/poor
	backr = /obj/item/weapon/shovel

	if(H.patron != /datum/patron/abyssanctum)
		switch(pick(/datum/patron/abyssanctum/purifier, /datum/patron/abyssanctum/curator, /datum/patron/abyssanctum/tideweaver))
			if(/datum/patron/abyssanctum/purifier)
				H.set_patron(/datum/patron/abyssanctum/purifier)
			if(/datum/patron/abyssanctum/curator)
				H.set_patron(/datum/patron/abyssanctum/curator)
			if(/datum/patron/abyssanctum/tideweaver)
				H.set_patron(/datum/patron/abyssanctum/tideweaver)

	H.adjust_skillrank(/datum/skill/misc/sewing, 2, TRUE) // these are basically the acolyte skills with a bit of other stuff
	H.adjust_skillrank(/datum/skill/misc/medicine, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/polearms, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
	H.adjust_skillrank(/datum/skill/craft/crafting, 1, TRUE)
	H.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/reading, 3, TRUE)
	H.adjust_skillrank(/datum/skill/magic/holy, 3, TRUE)
	H.adjust_skillrank(/datum/skill/labor/mathematics, 2, TRUE)
	//insert 'Navigation' and 'Boat Making' here when these skills exist.

	H.change_stat(STATKEY_STR, 1)
	H.change_stat(STATKEY_INT, 2)
	H.change_stat(STATKEY_END, 2)
	H.change_stat(STATKEY_PER, -1) // similar to acolyte's stats
	H.change_stat(STATKEY_LCK, -1) // Tradeoff for never being cursed when unearthing graves.
	if(!H.has_language(/datum/language/celestial)) // For discussing church matters with the other Clergy
		H.grant_language(/datum/language/celestial)
		to_chat(H, "<span class='info'>I can speak Celestial with ,c before my speech.</span>")
	ADD_TRAIT(H, TRAIT_DEADNOSE, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_STEELHEARTED, TRAIT_GENERIC) // Operating with corpses every day.
	ADD_TRAIT(H, TRAIT_GRAVEROBBER, TRAIT_GENERIC) // In case they need to move tombs or anything.

	//var/holder = H.patron?.devotion_holder
	//if(holder)
		//var/datum/devotion/devotion = new holder()
		//devotion.make_acolyte()
		//devotion.grant_to(H)
