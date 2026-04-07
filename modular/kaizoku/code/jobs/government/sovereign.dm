GLOBAL_VAR(lordsurname)
GLOBAL_LIST_EMPTY(lord_titles)

/datum/job/kaizoku/sovereign
	title = "Sovereign"
	var/ruler_title = "sovereign"
	tutorial = "Your clan has been elevated to this throne by decree of the Heavenly Emperor, but peace was never granted, \
	as the weight of expectation linger since the last soreveigner that betrayed the imperial banner was crushed like oat \
	in a miller, and now you sit where they fell as the center of every plot. You are a powerful warrior, but all blades are \
	directed towards your kin just as much you can direct blades of your retainers towards anyone. You must crush \
	your enemies and ensure the Heavenly Emperor is satisfied, lest you meet an horrible fate."
	department_flag = FACTION_GOVERNMENT
	faction = FACTION_TOWN
	job_flags = (JOB_ANNOUNCE_ARRIVAL | JOB_SHOW_IN_CREDITS | JOB_EQUIP_RANK | JOB_NEW_PLAYER_JOINABLE)
	display_order = KZ_SOVEREIGN
	total_positions = 0
	spawn_positions = 1
	// min_pq = 0 ; Stonekeep Todo - Vanderlin removed PQ, reimplement it later.
	allowed_races = RACES_FIRSTCLASS_PLAYERS
	outfit = /datum/outfit/kaizoku/sovereign
	bypass_lastclass = TRUE
	give_bank_account = 500
	selection_color = "#7851A9"

	spells = list( //Kaizoku change: Remember to give them the new spell.
		/datum/action/cooldown/spell/undirected/list_target/grant_title,
		/datum/action/cooldown/spell/undirected/list_target/grant_nobility,
	)

	cmode_music = 'sound/music/cmode/nobility/combat_noble.ogg' // Change this wherever possible.
	can_have_apprentices = FALSE

	job_bitflag = BITFLAG_ROYALTY

/datum/job/kaizoku/sovereign/get_informed_title(mob/mob, change_title = FALSE, new_title)
	if(change_title)
		ruler_title = new_title
		return "[ruler_title]"
	else
		return "[ruler_title]"

//TODO: MOVE THIS INTO TICKER INIT
/datum/job/kaizoku/sovereign/after_spawn(mob/living/spawned, client/player_client)
	..()
	SSticker.rulermob = spawned
	var/mob/living/carbon/human/H = spawned
	addtimer(CALLBACK(H, TYPE_PROC_REF(/mob/living/carbon/human, lord_color_choice)), 7 SECONDS)
	if(spawned.gender == MALE)
		SSfamilytree.AddRoyal(H, FAMILY_FATHER)
		ruler_title = "[SSmapping.config.monarch_title]"
	else
		SSfamilytree.AddRoyal(H, FAMILY_MOTHER)
		ruler_title = "[SSmapping.config.monarch_title_f]"
	to_chat(world, "<b>[span_notice(span_big("[H.real_name] is [ruler_title] of [SSmapping.config.map_name]."))]</b>")
	to_chat(world, "<br>")

/datum/outfit/kaizoku/sovereign/pre_equip(mob/living/carbon/human/H)
	..()
	head = /obj/item/clothing/head/crown/serpcrown
	backr = /obj/item/storage/backpack/satchel
	belt = /obj/item/storage/belt/leather/plaquegold
	beltl = /obj/item/weapon/knife/dagger/steel/special
	beltr = /obj/item/weapon/sword/rapier
	scabbards = list(/obj/item/weapon/scabbard/knife/royal, /obj/item/weapon/scabbard/sword/royal)
	ring = /obj/item/clothing/ring/active/nomag
	l_hand = /obj/item/weapon/lordscepter

	H.adjust_skillrank(/datum/skill/combat/polearms, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/axesmaces, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/crossbows, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/unarmed, 1, TRUE)
	H.adjust_skillrank(/datum/skill/combat/swords, 4, TRUE)
	H.adjust_skillrank(/datum/skill/combat/knives, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/swimming, 1, TRUE)
	H.adjust_skillrank(/datum/skill/misc/climbing, 1, TRUE)
	H.adjust_skillrank(/datum/skill/misc/athletics, 4, TRUE)
	H.adjust_skillrank(/datum/skill/misc/reading, 4, TRUE)
	H.adjust_skillrank(/datum/skill/misc/riding, 3, TRUE)
	H.adjust_skillrank(/datum/skill/labor/mathematics, 3, TRUE)
	if(H.age == AGE_OLD)
		H.adjust_skillrank(/datum/skill/combat/swords, 1, TRUE)
	H.change_stat(STATKEY_STR, 2) //Decrease speed for strength. The sovereign is an member of the warrior class.
	H.change_stat(STATKEY_INT, 3)
	H.change_stat(STATKEY_END, 3)
	H.change_stat(STATKEY_PER, 2)
	H.change_stat(STATKEY_LCK, 5)
	if(H.gender == MALE)
		pants = /obj/item/clothing/pants/tights/colored/black
		shirt = /obj/item/clothing/shirt/undershirt/colored/black
		armor = /obj/item/clothing/armor/gambeson/arming
		shoes = /obj/item/clothing/shoes/boots
		cloak = /obj/item/clothing/cloak/lordcloak
		if(H.dna?.species)
			if(H.dna.species.id == SPEC_ID_HUMEN)
				H.dna.species.soundpack_m = new /datum/voicepack/male/evil()
	else
		pants = /obj/item/clothing/pants/tights/colored/random
		armor = /obj/item/clothing/shirt/dress/royal
		shoes = /obj/item/clothing/shoes/shortboots
		cloak = /obj/item/clothing/cloak/lordcloak/ladycloak
		wrists = /obj/item/clothing/wrists/royalsleeves

		if(H.wear_mask)
			if(istype(H.wear_mask, /obj/item/clothing/face/eyepatch))
				qdel(H.wear_mask)
				mask = /obj/item/clothing/face/lordmask
			if(istype(H.wear_mask, /obj/item/clothing/face/eyepatch/left))
				qdel(H.wear_mask)
				mask = /obj/item/clothing/face/lordmask/l

	ADD_TRAIT(H, TRAIT_NOBLE, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_NOSEGRAB, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_HEAVYARMOR, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_KNOW_KEEP_DOORS, TRAIT_GENERIC)

/datum/job/exlord //just used to change the lords title
	title = "Ex-Sovereign"
	department_flag = FACTION_GOVERNMENT
	faction = FACTION_TOWN
	total_positions = 0
	spawn_positions = 0
	display_order = KZ_SOVEREIGN

/proc/give_lord_surname(mob/living/carbon/human/family_guy, preserve_original = FALSE)
	if(!GLOB.lordsurname)
		return
	if(preserve_original)
		family_guy.fully_replace_character_name(family_guy.real_name, family_guy.real_name + " " + GLOB.lordsurname)
		return family_guy.real_name
	var/list/chopped_name = splittext(family_guy.real_name, " ")
	if(length(chopped_name) > 1)
		family_guy.fully_replace_character_name(family_guy.real_name, chopped_name[1] + " " + GLOB.lordsurname)
	else
		family_guy.fully_replace_character_name(family_guy.real_name, family_guy.real_name + " " + GLOB.lordsurname)
	return family_guy.real_name

