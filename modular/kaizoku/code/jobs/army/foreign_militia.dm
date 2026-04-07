//Differently of Vanderlin, the Militiaman has no such a thing as weaponsmithing/armorsmithing or smithing hammer. It'd be improper for Stonekeep in any way.
//Militia's idea was to have some minor 'worker' skills to offset their less quantity of combat skill. But Gundam was against that
//If you want Militia to have some 'minor work skills', talk with them and change their mind.

/datum/job/kaizoku/militia // Replacement for 'Squires', most suitable because squires usually is implied, in irl terms, to be minors. This still functions as a beginner role.
	title = "Custodian Militia"
	flag = KZ_MILITIA
	department_flag = FACTION_MILITARY
	job_flags = (JOB_ANNOUNCE_ARRIVAL | JOB_SHOW_IN_CREDITS | JOB_EQUIP_RANK | JOB_NEW_PLAYER_JOINABLE)
	total_positions = 4 //Militia are a common role.
	spawn_positions = 4
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_NOTNATIVE
	allowed_ages = list(AGE_ADULT, AGE_MIDDLEAGED, AGE_OLD)
	tutorial = "Fate has placed a weapon upon your foreigner hands as you volunteered \
	your name upon a conscription roll, another non-citizen turned warrior under the lord's banner \
	just to not use foglander blood. Still in training, you've been handed whatever left over equipment and income \
	stability many dreams about. You do not have much expectations compared to the Custodian mainlanders, \
	and still require training."
	outfit = /datum/outfit/job/kaizoku/militia
	display_order = SQUIRE_ORDER
	give_bank_account = TRUE
	// min_pq = 0 ; Stonekeep Todo - Vanderlin removed PQ, reimplement it later.
	can_have_apprentices = FALSE
	give_bank_account = 15 // Considered "Slightly below average military pay(20), but higher than minimal pay (10)"
	cmode_music = 'modular/stonekeep/sound/cmode/combat_quarte.ogg'

/datum/outfit/job/kaizoku/militia/pre_equip(mob/living/carbon/human/H)
	gloves = /obj/item/clothing/gloves/leather
	shoes = /obj/item/clothing/shoes/boots
	belt = /obj/item/storage/belt/leather
	backr = /obj/item/storage/backpack/satchel
	backpack_contents = list(/obj/item/storage/belt/pouch/coins/poor = 1, /obj/item/storage/keyring/garrison)
	var/armortype = pickweight(list("Ironmail" = 3, "Ironplate" = 3, "Gambechain" = 3))
	var/meleetype = pickweight(list("Axe" = 3, "Mace" = 3, "Messer" = 3, "Sword" = 3, "Flail" = 3))
	var/rangedtype = pickweight(list("Crossbow" = 3, "Bow" = 3, "Shield" = 3)) //If we have slings in the future, give them a sling.
	var/pantsarmor = pickweight(list("Yes" = 1, "No" = 2))
	var/cloaktype = pickweight(list("Stabard" = 2, "Tabard" = 2, "Surcoat" = 2))
	var/headtype = pickweight(list("Kettle" = 2, "Nasal" = 2, "Skullcap" = 1, "Sallet" = 1))

	switch(armortype)
		if("Ironmail")
			armor = /obj/item/clothing/armor/leather/splint
			shirt = /obj/item/clothing/armor/chainmail
		if("Ironplate")
			armor = /obj/item/clothing/armor/cuirass/iron
			shirt = /obj/item/clothing/armor/gambeson
		if("Gambechain")
			armor = /obj/item/clothing/armor/chainmail
			shirt = /obj/item/clothing/armor/gambeson/heavy
	switch(pantsarmor)
		if("Yes")
			pants = /obj/item/clothing/pants/chainlegs/iron
		if("No")
			pants = /obj/item/clothing/pants/trou/leather/guard
	switch(rangedtype)
		if("Crossbow")
			backl = /obj/item/gun/ballistic/revolver/grenadelauncher/crossbow
			beltr = /obj/item/ammo_holder/quiver/bolts
			H.adjust_skillrank(/datum/skill/combat/crossbows, 1, TRUE)
		if("Bow")
			backl = /obj/item/gun/ballistic/revolver/grenadelauncher/bow
			beltr = /obj/item/ammo_holder/quiver/arrows
			H.adjust_skillrank(/datum/skill/combat/bows, 1, TRUE)
		if("Shield")
			backl = /obj/item/weapon/shield/wood
			H.adjust_skillrank(/datum/skill/combat/shields, 1, TRUE)
	switch(meleetype)
		if("Axe")
			beltl = /obj/item/weapon/axe/iron
			H.adjust_skillrank(/datum/skill/combat/axesmaces, 1, TRUE)
		if("Mace")
			beltl = /obj/item/weapon/mace
			H.adjust_skillrank(/datum/skill/combat/axesmaces, 1, TRUE)
		if("Messer")
			beltl = /obj/item/weapon/sword/scimitar/messer
			H.adjust_skillrank(/datum/skill/combat/swords, 1, TRUE)
		if("Sword")
			beltl = /obj/item/weapon/sword/iron
			H.adjust_skillrank(/datum/skill/combat/swords, 1, TRUE)
		if("Flail")
			beltl = /obj/item/weapon/flail
			H.adjust_skillrank(/datum/skill/combat/whipsflails, 1, TRUE)
	switch(cloaktype)
		if("Surcoat")
			cloak = /obj/item/clothing/cloak/stabard/guard
		if("Tabard")
			cloak = /obj/item/clothing/cloak/tabard/knight/guard
	switch(headtype)
		if("Skullcap") //Unlucky roll.
			head = /obj/item/clothing/head/helmet/skullcap
			neck = /obj/item/clothing/neck/chaincoif
		if("Kettle") //Average roll.
			head = /obj/item/clothing/head/helmet/kettle
			neck = /obj/item/clothing/neck/chaincoif/iron
		if("Nasal") //Average roll.
			head = /obj/item/clothing/head/helmet/nasal
			neck = /obj/item/clothing/neck/chaincoif/iron
		if("Sallet") //Lucky roll.
			head = /obj/item/clothing/head/helmet/sallet
			neck = /obj/item/clothing/neck/coif

	H.adjust_skillrank(/datum/skill/combat/wrestling, rand(1,2), TRUE)
	H.adjust_skillrank(/datum/skill/combat/unarmed, rand(1,2), TRUE)
	H.adjust_skillrank(/datum/skill/combat/knives, rand(0,1), TRUE)
	H.adjust_skillrank(/datum/skill/misc/swimming, rand(1,2), TRUE)
	H.adjust_skillrank(/datum/skill/misc/climbing, rand(1,2), TRUE)
	H.adjust_skillrank(/datum/skill/misc/athletics, rand(1,2), TRUE)
	H.adjust_skillrank(/datum/skill/misc/reading, rand(0,1), TRUE)
	H.adjust_skillrank(/datum/skill/misc/riding, rand(0,2), TRUE)

	H.change_stat(STATKEY_STR, rand(-1,2))
	H.change_stat(STATKEY_CON, rand(-1,2))
	H.change_stat(STATKEY_PER, rand(-1,2))
	H.change_stat(STATKEY_SPD, rand(-1,2))
	H.change_stat(STATKEY_INT, rand(0,1))
	// You can have -1 STR, -1 CON, -1 PER, -1 SPD, 0 INT at minimum,
	// Or +2 STR, 2 CON, 2 PER, 2 SPD, 1 INT at maximum.
	// Good luck to the RNG gods.

	if(H.gender == MALE && H.dna?.species)
		H.dna.species.soundpack_m = new /datum/voicepack/male/squire()
	ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_INTRAINING, TRAIT_GENERIC)
