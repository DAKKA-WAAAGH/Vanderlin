/datum/job/kaizoku/votary
	title = "Votary"
	tutorial = "Ever since your faith has been proven to thalassic angels, you became \
	one of Abyssanctum's votaries, no longer a supplicant and not yet a Prophet, \
	but an important catalyst of purification. You're sworn into holy service aiding \
	in protecting the nations against demonic corruption and general disgrace. \
	Keep your rites sacred, the mind sharp and the corruption at bay. \
	The Prophet is your leader, and their words, your rules."
	department_flag = FACTION_ABYSSANCTUM
	job_flags = (JOB_ANNOUNCE_ARRIVAL | JOB_SHOW_IN_CREDITS | JOB_EQUIP_RANK | JOB_NEW_PLAYER_JOINABLE)
	display_order = KZ_VOTARY
	faction = FACTION_TOWN
	total_positions = 4
	spawn_positions = 4
	// min_pq = 0 ; Stonekeep Todo - Vanderlin removed PQ, reimplement it later.
	bypass_lastclass = TRUE
	give_bank_account = TRUE
	allowed_races = RACES_PLAYER_ALL
	allowed_patrons = ALL_ABYSSANCTUM_DOCTRINES

	outfit = /datum/outfit/kaizoku/votary
	give_bank_account = TRUE
	job_bitflag = BITFLAG_CHURCH

/datum/outfit/kaizoku/votary/pre_equip(mob/living/carbon/human/H)
	..()
	belt = /obj/item/storage/belt/leather/rope
	beltr = /obj/item/storage/belt/pouch/coins/poor
	r_hand = /obj/item/weapon/polearm/woodstaff/quarterstaff/bostaff
	neck = /obj/item/clothing/neck/psycross/silver/abyssanctum
	backpack_contents = list(/obj/item/needle)
	switch(H.patron?.type)
		if(/datum/patron/abyssanctum/tideweaver)
			H.name = "Shoaling" //Our version of 'Shaolin', but with a similar-nomeclature and based on water. https://en.wikipedia.org/wiki/Wave_shoaling
			shirt = /obj/item/clothing/shirt/rags/monkgarb/tideweaver
			shoes = /obj/item/clothing/shoes/shortboots/cloudhead
			pants = /obj/item/clothing/pants/trou/leather/eastpants1
			gloves = /obj/item/clothing/gloves/leather/eastgloves2
			mask = /obj/item/clothing/face/kaizoku/eyeband/tideweaver
			if(H.gender == FEMALE)
				armor = /obj/item/clothing/shirt/rags/monkgarb/tideweaver
				shirt = /obj/item/clothing/suit/roguetown/shirt/eastshirt2 //You won't start with one tits out.
		if(/datum/patron/abyssanctum/curator)
			H.name = "Itinerant"
			shirt = /obj/item/clothing/suit/roguetown/shirt/eastshirt1
			cloak = /obj/item/clothing/cloak/raincloak/mino
			shoes = /obj/item/clothing/shoes/boots/jikatabi
			pants = /obj/item/clothing/pants/tights/hakama/curator
			belt = /obj/item/storage/belt/kaizoku/leather/daisho/curator
			gloves = /obj/item/clothing/gloves/leather/eastgloves1
			armor = /obj/item/clothing/armor/leather/jacket/eastsuit2
			head = /obj/item/clothing/head/tengai/curator
		else // Failsafe
			H.name = "Shrinekeeper"
			head = /obj/item/clothing/head/padded/shrinekeeper
			armor = /obj/item/clothing/shirt/robe/shrinekeeper
			shirt = /obj/item/clothing/shirt/rags/monkgarb/random
			shoes = /obj/item/clothing/shoes/sandals/geta
			wrists = /obj/item/clothing/wrists/shrinekeeper
			//beltl = Remember to make the Gohei and put this here.
			if(H.mind)
				if(H.patron != /datum/patron/abyssanctum/purifier)
					H.set_patron(/datum/patron/abyssanctum/purifier) //Forces you to be Abyssanctum if you are not.

	if(H.mind)
		H.adjust_skillrank(/datum/skill/misc/sewing, 3, TRUE)
		H.adjust_skillrank(/datum/skill/misc/medicine, 2, TRUE)
		H.adjust_skillrank(/datum/skill/combat/polearms, 2, TRUE) // Khakkhara, buddhism mercy, a weapon and a walking stick
		H.adjust_skillrank(/datum/skill/combat/unarmed, 4, TRUE) // Old acolyte unarmed fighting. Don't you dare to 'Nerf' this. This is fully intended.
		H.adjust_skillrank(/datum/skill/combat/wrestling, 5, TRUE) // Old acolyte unarmed fighting. Don't you dare to 'Nerf' this. This is fully intended.
		H.adjust_skillrank(/datum/skill/combat/swords, 1, TRUE) //Replace Axe/blunt. East asian monks made a lot of use of blades.
		H.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE) //Reverted with Reading. More proper for east-asian monks.
		H.adjust_skillrank(/datum/skill/misc/reading, 2, TRUE) //Reverted with Athletics. More proper for east-asian monks.
		H.adjust_skillrank(/datum/skill/magic/holy, 3, TRUE)
		H.adjust_skillrank(/datum/skill/labor/fishing, 1, TRUE) //Abyssorites staple.
		H.adjust_skillrank(/datum/skill/misc/swimming, 1, TRUE) // One rituals is required to be done while on water. This is quite required.
		if(H.age == AGE_OLD)
			H.adjust_skillrank(/datum/skill/magic/holy, 1, TRUE)
	H.change_stat(STATKEY_INT, 1)
	H.change_stat(STATKEY_STR, 1) //Votary training includes strength training.
	H.change_stat(STATKEY_END, 2) // For casting lots of spells, and working long hours without sleep at the church
	H.change_stat(STATKEY_PER, -1)
	ADD_TRAIT(H, TRAIT_EMPTYHANDS, TRAIT_GENERIC)

	if(!H.has_language(/datum/language/celestial)) // For discussing church matters with the other Clergy
		H.grant_language(/datum/language/celestial)
		to_chat(H, "<span class='info'>I can speak Celestial with ,c before my speech.</span>")

	var/holder = H.patron.devotion_holder
	if(holder)
		var/datum/devotion/devotion = new holder()
		devotion.make_acolyte()
		devotion.grant_to(H)
