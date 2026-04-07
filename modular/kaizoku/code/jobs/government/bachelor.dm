/datum/job/kaizoku/bachelor
	title = "Vassal Bachelor"
	tutorial = "You've been elevated by oathbound merit, granted \
	lordhood under the accolade ritual. \
	As a vassal, your bailiff takes care of your land so you can \
	perform the duty of protecting the clan of this land. \
	Greater empires will test your loyalty, probing for cracks to \
	turn you against your leaders, but spitting \
	on the plate that feeds you may be your downfall."
	department_flag = FACTION_MILITARY
	total_positions = 2
	spawn_positions = 2
	job_flags = (JOB_ANNOUNCE_ARRIVAL | JOB_SHOW_IN_CREDITS | JOB_EQUIP_RANK | JOB_NEW_PLAYER_JOINABLE)
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_FIRSTCLASS_PLAYERS
	allowed_ages = list(AGE_ADULT, AGE_MIDDLEAGED, AGE_IMMORTAL)
	display_order = KZ_BACHELOR
	whitelist_req = FALSE
	outfit = /datum/outfit/job/kaizoku/bachelor
	give_bank_account = 30 //Way above average pay, paid by the Government - not by the clan members.
	// min_pq = 0 ; Stonekeep Todo - Vanderlin removed PQ, reimplement it later.
	///advclass_cat_rolls = list(CTAG_BACHELOR = 20)	//Content for later.
	cmode_music = 'sound/music/cmode/nobility/CombatKnight.ogg'

/datum/outfit/job/kaizoku/bachelor/custzamurai/pre_equip(mob/living/carbon/human/H)
	..()
	belt = /obj/item/storage/belt/kaizoku/leather/pursebelt
	cloak = /obj/item/clothing/cloak/raincloak/guardsman //remember to make a knight version
	armor = /obj/item/clothing/armor/brigandine/custzamurai
	shoes = /obj/item/clothing/shoes/boots/armor/ironmaille/kusaritabi
	gloves = /obj/item/clothing/gloves/chain/kikko
	head = /obj/item/clothing/head/helmet/visored/knight/custknight/custzamurai
	shirt = /obj/item/clothing/armor/gambeson/heavy/battleshirt
	backr = /obj/item/storage/backpack/satchel
	wrists = /obj/item/clothing/wrists/bracers/mountainstar
	neck = /obj/item/clothing/neck/chaincoif
	backpack_contents = list(/obj/item/storage/keyring/manorguard = 1)

/datum/outfit/job/kaizoku/bachelor/post_equip(mob/living/carbon/human/H, visualsOnly)
	. = ..()
	if(!ishuman(H))
		return

	//if(istype(H.cloak, /obj/item/clothing/cloak/tabard/knight/guard))
	//	var/obj/item/clothing/C = H.cloak
	//	var/index = findtext(H.real_name, " ")
	//	var/base = index ? copytext(H.real_name, 1, index) : H.real_name
	//	C.name = "knight's tabard ([base])"
	else if(istype(H.cloak, /obj/item/clothing/cloak/stabard/haramaki/odoshi/zamurai))
		var/obj/item/clothing/C2 = H.cloak
		var/index2 = findtext(H.real_name, " ")
		var/base2 = index2 ? copytext(H.real_name, 1, index2) : H.real_name
		C2.name = "zamurai's odoshi ([base2])"

	var/prev_real = H.real_name
	var/prev_short = H.name

	if(H.dna.species?.id != "abyssariad" && H.dna.species.name != "Undine")
		var/honor = H.gender == FEMALE ? "Dame" : "Sir"
		H.real_name = "[honor] [prev_real]"
		H.name = "[honor] [prev_short]"
	else
		var/index3 = findtext(prev_real, " of ")
		if(index3)
			var/first = copytext(prev_real, 1, index3)
			var/clan = copytext(prev_real, index3)
			H.real_name = "[first]-dono[clan]"
		else
			H.real_name = "[prev_real]-dono"
		H.name = H.real_name

	if(findtext(H.real_name, " Clanless"))
		to_chat(H, "<span class='warning'>The King acquired my clan - so I have to belong to one before reaching this royal duty I serve.</span>")
		clanfication(H)

	H.adjust_skillrank(/datum/skill/combat/swords, 3, TRUE) //Whatever they choose in specialization will give them 4 in the chosen skill. Exception to Unarmed.
	H.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/shields, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/polearms, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/whipsflails, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/axesmaces, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)

	H.adjust_skillrank(/datum/skill/combat/bows, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/crossbows, 3, TRUE)

	H.adjust_skillrank(/datum/skill/misc/athletics, 4, TRUE)
	H.adjust_skillrank(/datum/skill/misc/riding, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
	H.adjust_skillrank(/datum/skill/labor/mathematics, 3, TRUE)

	H.change_stat("strength", 2)
	H.change_stat("perception", 2)
	H.change_stat("endurance", 2)
	H.change_stat("constitution", 1)
	ADD_TRAIT(H, TRAIT_HEAVYARMOR, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_KNOWBANDITS, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_NOBLE, TRAIT_GENERIC) //They are, in fact, knights/zamurais. So they have nobility rights.
	if(H.dna?.species?.id == "human")
		H.dna.species.soundpack_m = new /datum/voicepack/male/knight()

/datum/outfit/job/kaizoku/bachelor/pre_equip(mob/living/carbon/human/H)
	. = ..()
	if(!H.client)
		return
	var/choice = input(H, "Choose your primary weapon:", "Retinue Armament") in list("Flail","Halberd","Longsword","Sabre","Unarmed", "Goden")
	if(choice =="Flail")
		H.adjust_skillrank(/datum/skill/combat/whipsflails, 1, TRUE)
		H.adjust_skillrank(/datum/skill/combat/shields, 1, TRUE)
		if(H.dna.species?.id != "abyssariad" && H.dna.species.name != "Undine")
			beltr = /obj/item/weapon/flail/sflail
			backr = /obj/item/weapon/shield/tower/metal
		else
			backr = /obj/item/weapon/shield/tower/metal/abyssal
			beltr = /obj/item/weapon/flail/sflail/kusarifundo

	if(choice =="Halberd")
		H.adjust_skillrank(/datum/skill/combat/polearms, 1, TRUE)
		if(H.dna.species?.id != "abyssariad" && H.dna.species.name != "Undine")
			var/obj/item/weapon/polearm/halberd/P = new()
			H.put_in_hands(P, forced = TRUE)
		else
			var/obj/item/weapon/polearm/halberd/bisento/P = new()
			H.put_in_hands(P, forced = TRUE)
	if(choice =="Longsword")
		H.adjust_skillrank(/datum/skill/combat/swords, 1, TRUE)
		H.adjust_skillrank(/datum/skill/combat/shields, 1, TRUE)
		if(H.dna.species?.id != "abyssariad" && H.dna.species.name != "Undine")
			beltr = /obj/item/weapon/sword/long
			backr = /obj/item/weapon/shield/tower/metal
		else
			backr = /obj/item/weapon/shield/tower/metal/abyssal
			beltr = /obj/item/weapon/sword/long/tachi

	if(choice =="Sabre")
		H.adjust_skillrank(/datum/skill/combat/swords, 1, TRUE)
		H.adjust_skillrank(/datum/skill/combat/shields, 1, TRUE)
		if(H.dna.species?.id != "abyssariad" && H.dna.species.name != "Undine")
			beltr = /obj/item/weapon/sword/sabre/dec
			backr = /obj/item/weapon/shield/tower/metal
		else
			backr = /obj/item/weapon/shield/tower/metal/abyssal
	if(choice =="Unarmed")
		H.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
		H.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
		H.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)

	if(choice =="Goden")
		H.adjust_skillrank(/datum/skill/combat/axesmaces, 1, TRUE)
		if(H.dna.species?.id != "abyssariad" && H.dna.species.name != "Undine")
			var/obj/item/weapon/mace/goden/steel/P = new()
			H.put_in_hands(P, forced = TRUE)
		else
			var/obj/item/weapon/mace/goden/steel/tetsubo/P = new()
			H.put_in_hands(P, forced = TRUE)
