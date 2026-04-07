/datum/job/kaizoku/doyen
	title = "Doyen Champion"
	f_title = "Doyenne Champion"
	tutorial = "More than six centuries has passed yet you still feel the blood of the unholy. \
	You've outlived your comrades, and the memories of watching the skies bleed asunder taught \
	you what slaughter really means, always on edge, everything that reenacts \
	the memories triggers an overdrive of your senses all over again. \
	There is no one better at killing demons, ... \
	but the memories... there is something... out there... coming for you. \
	Graggar knows your name."
	department_flag = FACTION_MILITARY
	display_order = KZ_DOYEN
	job_flags = (JOB_ANNOUNCE_ARRIVAL | JOB_SHOW_IN_CREDITS | JOB_EQUIP_RANK | JOB_NEW_PLAYER_JOINABLE)
	faction = FACTION_TOWN
	total_positions = 1
	spawn_positions = 1
	// min_pq = 0 ; Stonekeep Todo - Vanderlin removed PQ, reimplement it later.
	outfit = /datum/outfit/kaizoku/doyen

	spells = list(/datum/action/cooldown/spell/undirected/list_target/convert_role/militia)
	allowed_sexes = list(MALE, FEMALE) //same as town guard
	allowed_ages = list(AGE_ANCIENT) //You are more than 600 years old, bud.
	allowed_races = RACE_NATIVE_PLAYERS //Change this to Kaizoku races only.

	// advclass_cat_rolls = list(CTAG_VETERAN = 20) // You don't.
	give_bank_account = 35
	can_have_apprentices = FALSE
	job_bitflag = BITFLAG_GARRISON

/datum/job/kaizoku/doyen/after_spawn(mob/living/spawned, client/player_client)
	. = ..()
	var/mob/living/carbon/human/H = spawned
	if(istype(H.cloak, /obj/item/clothing/cloak/half/vet))
		var/obj/item/clothing/S = H.cloak
		var/index = findtext(H.real_name, " ")
		if(index)
			index = copytext(H.real_name, 1,index)
		if(!index)
			index = H.real_name
		S.name = "veteran cloak ([index])"
	ADD_TRAIT(spawned, TRAIT_OLDPARTY, TRAIT_GENERIC)

/datum/outfit/kaizoku/doyen/pre_equip(mob/living/carbon/human/H)
	neck = /obj/item/clothing/neck/bevor
	armor = /obj/item/clothing/armor/plate
	shirt = /obj/item/clothing/armor/chainmail
	pants = /obj/item/clothing/pants/chainlegs
	shoes = /obj/item/clothing/shoes/boots/armor
	beltl = /obj/item/weapon/sword/sabre
	beltr = /obj/item/storage/keyring/veteran
	backr = /obj/item/storage/backpack/satchel/black
	scabbards = list(/obj/item/weapon/scabbard/sword)
	cloak = /obj/item/clothing/cloak/half/vet
	belt = /obj/item/storage/belt/leather/black
	H.cmode_music = 'sound/music/cmode/adventurer/CombatWarrior.ogg'
	backpack_contents = list(/obj/item/weapon/knife/dagger/steel/special = 1)

	H.adjust_skillrank(/datum/skill/combat/swords, 5, TRUE)
	H.adjust_skillrank(/datum/skill/combat/axesmaces, 5, TRUE)
	H.adjust_skillrank(/datum/skill/combat/shields, 4, TRUE)
	H.adjust_skillrank(/datum/skill/combat/wrestling, 4, TRUE)
	H.adjust_skillrank(/datum/skill/combat/unarmed, 4, TRUE)
	H.adjust_skillrank(/datum/skill/combat/polearms, 4, TRUE)
	H.adjust_skillrank(/datum/skill/combat/bows, 4, TRUE)
	H.adjust_skillrank(/datum/skill/combat/crossbows, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/whipsflails, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/athletics, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
	H.adjust_skillrank(/datum/skill/misc/medicine, 3, TRUE)
	H.change_stat(STATKEY_INT, 1)
	H.change_stat(STATKEY_END, 2)
	H.change_stat(STATKEY_CON, 2)
	H.change_stat(STATKEY_STR, 3)

	ADD_TRAIT(H, TRAIT_HEAVYARMOR, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_STEELHEARTED, TRAIT_GENERIC)
	// ADD_TRAIT(H, TRAIT_BLOODBOIL, TRAIT_GENERIC) // kill TIEFLINGS AND DEMONS on SIGHT.
