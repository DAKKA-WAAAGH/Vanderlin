/datum/job/kaizoku/menial
	title = "Menial laborer"
	tutorial = "Many workers are outsiders fleeing the Denmorian swarms, \
	and plenty of the unskilled ones now serve as menial laborers, scrubbing floors, polishing \
	jade and sweeping tatami mats as nameless attendants. As nameless though you are, \
	it is your labor that sustains this palace, and different of the low-life outside, \
	you are well fed and cared for."
	department_flag = FACTION_GOVERNMENT
	faction = FACTION_TOWN
	job_flags = (JOB_ANNOUNCE_ARRIVAL | JOB_SHOW_IN_CREDITS | JOB_EQUIP_RANK | JOB_NEW_PLAYER_JOINABLE)
	display_order = KZ_SERVANT
	total_positions = 5
	spawn_positions = 5
	// min_pq = 0 ; Stonekeep Todo - Vanderlin removed PQ, reimplement it later.
	bypass_lastclass = TRUE
	allowed_ages = list(AGE_ADULT, AGE_IMMORTAL) // put all others
	allowed_races = RACES_NOTNATIVE //Usually non-native. Will change to allow natives later.
	outfit = /datum/outfit/kaizoku/menial
	give_bank_account = TRUE
	cmode_music = 'sound/music/cmode/towner/CombatPrisoner.ogg'
	can_have_apprentices = FALSE

/datum/outfit/kaizoku/menial/pre_equip(mob/living/carbon/human/H)
	..()
	shoes = /obj/item/clothing/shoes/simpleshoes
	pants = /obj/item/clothing/pants/tights/colored/uncolored
	shirt = /obj/item/clothing/shirt/undershirt/colored/uncolored
	belt = /obj/item/storage/belt/leather/rope
	beltl = /obj/item/storage/belt/pouch/coins/poor
	backl = /obj/item/storage/backpack/satchel
	backpack_contents = list(/obj/item/recipe_book/cooking = 1)
	neck = /obj/item/key/manor
	if(H.gender == MALE)
		armor = /obj/item/clothing/armor/leather/vest/colored/black
	else
		cloak = /obj/item/clothing/cloak/apron
	H.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
	H.adjust_skillrank(/datum/skill/craft/cooking, 3, TRUE)
	H.adjust_skillrank(/datum/skill/labor/butchering, 1, TRUE)
	H.adjust_skillrank(/datum/skill/misc/medicine, 1, TRUE)
	H.adjust_skillrank(/datum/skill/labor/farming, 1, TRUE)
	H.adjust_skillrank(/datum/skill/misc/sewing, 3, TRUE)
	H.adjust_skillrank(/datum/skill/craft/crafting, 1, TRUE)
	H.adjust_skillrank(/datum/skill/misc/sneaking, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/stealing, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/music, pick(0,1,1), TRUE)
	H.change_stat(STATKEY_SPD, 1)
	H.change_stat(STATKEY_END, 1)
