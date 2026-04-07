//Remember: Daily ration ticket system to be 'recovered' in a INN, or on a Ration Machine (bad trashy food).
// Military Personnel right: Your food is paid by the Imperial Government.
// Military Personnel right: Health checkup is paid by the Imperial Government, once a week.
// To do: Basic pants, wrist armor. Make custodian gutal stronger.
// Keep non-armored variety to constables.

/datum/job/kaizoku/retainer
	title = "Custodian Retainer"
	flag = KZ_RETAINER
	department_flag = FACTION_MILITARY
	total_positions = 4
	spawn_positions = 4
	job_flags = (JOB_ANNOUNCE_ARRIVAL | JOB_SHOW_IN_CREDITS | JOB_EQUIP_RANK | JOB_NEW_PLAYER_JOINABLE)
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_CITIZEN_PLAYERS
	allowed_ages = ALL_AGES_LIST_BLOOMING
	tutorial = "War is routine as a sworn retainer. You know the imperial fogcruisers \
	enjoy plundering Grenzelhoft warships while you rot as the infantry backbone protecting the \
	homeland from the castaways, but steady pay keeps your loyalty and honor firm, so \
	long as the coin arrives, and unlike the Militia, you are not meant to die cheaply, \
	as you know well you are no conscript rabble."
	display_order = GARRISON_ORDER
	outfit = /datum/outfit/job/kaizoku/retainer //Default outfit for the Custodian Guard
	advclass_cat_rolls = list(CTAG_RETAINER = 20)	//Handles class selection.
	give_bank_account = 25 // Considered "Slightly above average pay (20) + The government provided you with the equipments you wear."
	// min_pq = 0 ; Stonekeep Todo - Vanderlin removed PQ, reimplement it later.
	cmode_music = 'modular/kaizoku/sound/combat/combat_stormwarrior.ogg'

/datum/outfit/job/kaizoku/retainer // Reminder message
	var/oath = "<br><br><font color='#855b14'><span class='bold'>Remember to renew your oath of loyalty to the sovereign \
	at the start of the week, and train the Militia and New Rices. Your payment includes this requirement.</span></font><br><br>"

/datum/outfit/job/kaizoku/retainer/post_equip(mob/living/carbon/human/H)
	. = ..()
	to_chat(H, oath)
	if(istype(H.cloak, /obj/item/clothing/cloak/stabard/haramaki/jinbaori/guard) || istype(H.cloak, /obj/item/clothing/cloak/raincloak/guardsman))
		var/obj/item/clothing/S = H.cloak
		var/index = findtext(H.real_name, " ")
		if(index)
			index = copytext(H.real_name, 1, index)
		if(!index)
			index = H.real_name
		S.name = "retinue's cloak ([index])"

//Universal stuff for all guards, regardless of their class selection.
/datum/outfit/job/kaizoku/retainer
	pants = /obj/item/clothing/pants/trou/tobi/random
	shoes = /obj/item/clothing/shoes/ridingboots/gutal/custodian
	belt = /obj/item/storage/belt/kaizoku/leather/pursebelt
	wrists = /obj/item/clothing/wrists/bracers/leather/khudagach
	gloves = /obj/item/clothing/gloves/leather/abyssal

/datum/outfit/job/kaizoku/retainer/pre_equip(mob/living/carbon/human/H)
	..()
	// H.verbs |= /mob/proc/haltyell // Shitbroken.
	ADD_TRAIT(H, TRAIT_KNOWBANDITS, TRAIT_GENERIC)

/datum/job/advclass/kaizoku/retainer/vanguard
	title = "Vanguard Retinue"
	tutorial = "You are a frontline warrior, the staple in any art of warfare in which the shield holds the borders of the realm. Raised under native banners, fighting in formation comes effortlessly under the discipline of steel, holding a sword or a mace to put down any evildoer."
	outfit = /datum/outfit/job/kaizoku/retainer/vanguard
	category_tags = list(CTAG_RETAINER)

/datum/outfit/job/kaizoku/retainer/vanguard/pre_equip(mob/living/carbon/human/H)
	..()
	if(H.client?.prefs?.culture in list("kaizoku", "linyou"))
		beltr = /obj/item/ammo_holder/cscabbard/scscabbard/loaded
		beltl = /obj/item/weapon/axe/battle/ono/fogono
		neck = /obj/item/clothing/neck/gorget/lazerrain
		backr = /obj/item/weapon/shield/tower/abyssaltower
		head = /obj/item/clothing/head/helmet/guardsman/coastal
		armor = /obj/item/clothing/armor/cuirass/custodian
	else if(H.client?.prefs?.culture in list("muqian", "dustwalker"))
		beltr = /obj/item/ammo_holder/cscabbard/scscabbard/loaded
		beltl = /obj/item/weapon/axe/battle/ono/fogono
		neck = /obj/item/clothing/neck/gorget/lazerrain
		backr = /obj/item/weapon/shield/tower/abyssaltower
		armor = /obj/item/clothing/armor/medium/scale/shanwenkai
	else if(H.client?.prefs?.culture == "shuhen")
		H.change_stat(STATKEY_SPD, -1)
		H.change_stat(STATKEY_STR, 1)
		head = /obj/item/clothing/head/helmet/kettle/kaizoku/shuhen
		armor = /obj/item/clothing/armor/cuirass/shuhen //change this to the better one later.
		neck = /obj/item/clothing/neck/bevor/crabstain
		if(H.dna.species.name == "Ogrun")
			backr = /obj/item/weapon/mace/goden/kanabo
		else
			backr = /obj/item/weapon/sword/long/greatsword/zwei/okatana
	else
		beltr = /obj/item/weapon/sword
		beltl = /obj/item/weapon/axe/battle
		neck = /obj/item/clothing/neck/gorget
		backr = /obj/item/weapon/shield/tower
		head = /obj/item/clothing/head/helmet/townwatch
		armor = /obj/item/clothing/armor/cuirass
	to_chat(H, "<span class='warning'>My clan was bound to sworn to the king's cause under the Heavenly Emperor's will. As an Ashigaru retainer, their lineage is held in high regard, and I shall serve their bloodline as I would my daimyo.")
	shirt = /obj/item/clothing/armor/chainmail/tatami
	cloak = /obj/item/clothing/cloak/stabard/haramaki/jinbaori/guard
	backpack_contents = list(/obj/item/storage/keyring/garrison)
	ring = /obj/item/pet_command/whistle
	var/mob/living/simple_animal/hostile/retaliate/custodianpet/doggo/D = new(get_turf(H))
	D.summoner = H
	if(D.ai_controller)
		D.ai_controller.blackboard[BB_SUMMONER] = H

	H.adjust_skillrank(/datum/skill/combat/shields, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/axesmaces, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/swords, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE) //The elite garrison NEEDS to know HOW to read and write documents. Due to falconeer message delivery and more.
	H.change_stat(STATKEY_STR, 1)
	H.change_stat(STATKEY_END, 2)
	H.change_stat(STATKEY_CON, 2)
	ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)

/datum/job/advclass/kaizoku/retainer/phalangite
	title = "Phalangite Retinue"
	tutorial = "The bastion of leverage that puts a quick stop to any cavalry charge. Nothing passes the polearm that you wield as you anchor the line. You may not be the first to strike, yet it is your blow that breaks any mortal, and your strength shows it."
	outfit = /datum/outfit/job/kaizoku/retainer/phalangite

	category_tags = list(CTAG_RETAINER)

/datum/outfit/job/kaizoku/retainer/phalangite/pre_equip(mob/living/carbon/human/H)
	..()
	if(H.client?.prefs?.culture in list("kaizoku", "linyou"))
		head = /obj/item/clothing/head/helmet/kettle/kaizoku/coastal
		armor = /obj/item/clothing/armor/chainmail/hauberk/custodian
		beltr = /obj/item/weapon/sword/scimitar/messer/dao
	else if(H.client?.prefs?.culture == "foreigner")
		head = /obj/item/clothing/head/helmet/kettle
		armor = /obj/item/clothing/armor/chainmail/hauberk
		beltr = /obj/item/weapon/sword/scimitar/messer
	else
		head = /obj/item/clothing/head/helmet/kettle/kaizoku/imperial
		armor = /obj/item/clothing/armor/chainmail/hauberk/custodian
		beltr = /obj/item/weapon/sword/scimitar/messer/dao
	shirt = /obj/item/clothing/armor/gambeson/heavy/battleshirt
	backl = /obj/item/storage/backpack/satchel
	neck = /obj/item/clothing/neck/bevor/crabstain
	cloak = /obj/item/clothing/cloak/stabard/haramaki/jinbaori/guard
	to_chat(H, "<span class='boldwarning'>You remember your sensei's warnings.\n\n\ \
	DO NOT, EVER, CLOSE THE FIRELANCE WITHOUT A GOURD ON IT.\n\n\ \
	DO NOT PUT A GOURD ON IT WHILE IT IS ON YOUR BACK.\n\n\ \
	DO NOT DROP IT WHILE WITH A GOURD ON IT.\n\n\ \
	DO NOT PUT IT ON YOUR BACK WITH A GOURD EITHER. \
	REMEMBER. THE WEAPON IS AN ENEMY OF YOU JUST AS MUCH AS THE MAN INFRONT OF YOU.</span>")
	var/obj/item/weapon/polearm/halberd/bardiche/naginata/P = new()
	H.put_in_hands(P, forced = TRUE)
	backr = /obj/item/weapon/polearm/firelance
	backpack_contents = list(/obj/item/storage/keyring/garrison,/obj/item/sanctiflux,/obj/item/sanctiflux,/obj/item/sanctiflux)

	H.adjust_skillrank(/datum/skill/combat/polearms, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/swords, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/axesmaces, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE) //The elite garrison NEEDS to know HOW to read and write documents. Due to falconeer message delivery and more.
	H.change_stat(STATKEY_STR, 2)
	H.change_stat(STATKEY_END, 1)
	H.change_stat(STATKEY_CON, 2)
	H.change_stat(STATKEY_SPD, -1)
	ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)

/datum/job/advclass/kaizoku/retainer/marksman
	title = "Falconer Retinue"
	tutorial = "Your steady hands know the string just as much as your vision reachers farther than any other man, your precision has been shaped by the endless wind. You have a loyal companion for scouting, combat and communication as long it is alive."
	outfit = /datum/outfit/job/kaizoku/retainer/marksman
	category_tags = list(CTAG_RETAINER)


/datum/outfit/job/kaizoku/retainer/marksman/pre_equip(mob/living/carbon/human/H) //Made these more specialized in one type of ranged weapon.
	..()
	shirt = /obj/item/clothing/armor/gambeson/heavy/battleshirt
	cloak = /obj/item/clothing/cloak/raincloak/guardsman
	neck = /obj/item/clothing/neck/chaincoif/karuta_zukin/military
	wrists = /obj/item/clothing/wrists/bracers/leather/khudagach
	gloves = /obj/item/clothing/gloves/angle/falcon //This is a falconeer's gloves, name of the subrole. The falcons will also deal damage to those who does not use this glove.
	beltl = /obj/item/weapon/knife/steel/tanto
	ring = /obj/item/pet_command/whistle
	if(H.client?.prefs?.culture in list("kaizoku", "linyou"))
		head = /obj/item/clothing/head/helmet/kettle/kaizoku/coastal
		armor = /obj/item/clothing/armor/leather/jacket/custodian/foglander
	else if(H.client?.prefs?.culture in list("muqian", "dustwalker", "shuhen"))
		head = /obj/item/clothing/head/helmet/kettle/kaizoku/imperial
		armor = /obj/item/clothing/armor/leather/jacket/custodian
	else
		head = /obj/item/clothing/head/helmet/kettle
		armor = /obj/item/clothing/armor/leather
	backpack_contents = list(/obj/item/storage/keyring/garrison)
	var/choice = input(H, "Choose your primary weapon:", "Retinue Armament") in list("Long Bow", "Crossbow", "Chukonu")
	if(choice == "Long Bow")
		backr = /obj/item/gun/ballistic/revolver/grenadelauncher/bow/long/yumi
		beltr = /obj/item/ammo_holder/quiver/arrows
	if(choice == "Crossbow")
		backr = /obj/item/gun/ballistic/revolver/grenadelauncher/crossbow
		beltr = /obj/item/ammo_holder/quiver/bolts
	if(choice == "Chukonu")
		backr = /obj/item/gun/ballistic/revolver/grenadelauncher/chukonu
		beltr = /obj/item/ammo_holder/quiver/bolts
	var/mob/living/simple_animal/hostile/retaliate/custodianpet/falcon/F = new(get_turf(H))
	F.summoner = H
	if(F.ai_controller)
		F.ai_controller.blackboard[BB_SUMMONER] = H

	//Stats for class
	H.adjust_skillrank(/datum/skill/combat/bows, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/crossbows, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/knives, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/swords, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/axesmaces, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/swimming, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/sneaking, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/lockpicking, 2, TRUE)
	H.adjust_skillrank(/datum/skill/craft/crafting, 1, TRUE)
	H.adjust_skillrank(/datum/skill/craft/tanning, 1, TRUE)
	H.adjust_skillrank(/datum/skill/misc/reading, 2, TRUE) //Falconeers deserves one more skill of reading as a treat, since they are the ones writting afterall. Just got used to it.
	H.change_stat(STATKEY_PER, 2)
	H.change_stat(STATKEY_END, 1)
	H.change_stat(STATKEY_SPD, 1)
	ADD_TRAIT(H, TRAIT_DODGEEXPERT, TRAIT_GENERIC)

/datum/job/advclass/kaizoku/retainer/privateer
	title = "Privateer Retinue"
	tutorial = "You are a swift warrior who tasted blood across ship decks rather than on the field, courtier and unorthodox. Your slim edge finds weakness in armor as you learnt the ways of ebb-and-flow so you never swing wide, you slide and stab, or shoot and scram."
	outfit = /datum/outfit/job/kaizoku/retainer/privateer

	category_tags = list(CTAG_RETAINER)

/datum/outfit/job/kaizoku/retainer/privateer/pre_equip(mob/living/carbon/human/H)
	..()
	shirt = /obj/item/clothing/armor/chainmail/iron/tatami
	cloak = /obj/item/clothing/cloak/raincloak/guardsman
	neck = /obj/item/clothing/neck/chaincoif/karuta_zukin/military
	beltl = /obj/item/weapon/knife/steel/tanto
	if(H.client?.prefs?.culture in list("shuhen", "linyou", "dustwalker"))
		head = /obj/item/clothing/head/helmet/leather/paddedt/alt
		armor = /obj/item/clothing/armor/leather/jacket/custodian/foglander
	else if(H.client?.prefs?.culture in list("kaizoku", "linyou"))
		head = /obj/item/clothing/head/helmet/leather/paddedt
		armor = /obj/item/clothing/armor/leather/jacket/custodian
	else
		head = /obj/item/clothing/head/helmet/leather
		armor = /obj/item/clothing/armor/leather
	backpack_contents = list(/obj/item/storage/keyring/garrison,/obj/item/weapon/knife/steel/tanto,/obj/item/flint)
	H.adjust_skillrank(/datum/skill/combat/swords, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/firearms, 3, TRUE)
	beltl = /obj/item/reagent_containers/glass/bottle/aflask
	beltr = /obj/item/weapon/sword/rapier/starfang
	backr = /obj/item/gun/ballistic/revolver/grenadelauncher/handcannon
	backl = /obj/item/ammo_holder/bullet/garrison

	H.adjust_skillrank(/datum/skill/combat/knives, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/axesmaces, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/swimming, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/athletics, 4, TRUE)
	H.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE) //The elite garrison NEEDS to know HOW to read and write documents. Due to falconeer message delivery and more.
	H.change_stat(STATKEY_END, 2)
	H.change_stat(STATKEY_SPD, 2)
	ADD_TRAIT(H, TRAIT_DODGEEXPERT, TRAIT_GENERIC)

/obj/item/ammo_holder/bullet/garrison/Initialize()
	. = ..()
	for(var/i in 1 to max_storage)
		var/obj/item/ammo_casing/caseless/bullet/A = new(src)
		ammo_list += A
	update_icon()
