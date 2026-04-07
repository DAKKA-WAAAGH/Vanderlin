/datum/job/kaizoku/supplicant
	title = "Supplicant"
	tutorial = "You are an novice devotee of Abyssanctum. \
	You've already chosen the thalassic angel that most alizgns with your beliefs, \
	and now, you must prove yourself worthy in your path of championage, \
	as to serve Abyssor, you must first serve his children. \
	However, your path of abyssal devotion and discovery will be filled of chores."
	department_flag = FACTION_ABYSSANCTUM
	job_flags = (JOB_ANNOUNCE_ARRIVAL | JOB_SHOW_IN_CREDITS | JOB_EQUIP_RANK | JOB_NEW_PLAYER_JOINABLE)
	display_order = KZ_SUPPLICANT
	faction = FACTION_TOWN
	total_positions = 2
	spawn_positions = 2
	// min_pq = 0 ; Stonekeep Todo - Vanderlin removed PQ, reimplement it later.
	bypass_lastclass = TRUE
	allowed_ages = list(BLOOMING_ADULT) // Young Adult
	allowed_races = RACES_PLAYER_ALL
	allowed_patrons = list(/datum/patron/abyssanctum/curator, /datum/patron/abyssanctum/purifier, /datum/patron/abyssanctum/tideweaver)

	outfit = /datum/outfit/kaizoku/supplicant
	give_bank_account = TRUE
	can_have_apprentices = FALSE
	cmode_music = 'sound/music/cmode/towner/CombatTowner.ogg'
	//job_bitflag = BITFLAG_CHURCH
	//exp_types_granted = list(EXP_TYPE_CHURCH, EXP_TYPE_CLERIC)

/datum/outfit/kaizoku/supplicant
	name = "Supplicant"

/datum/outfit/kaizoku/supplicant/pre_equip(mob/living/carbon/human/H)
	..()
	if(H.mind)
		H.adjust_skillrank(/datum/skill/misc/climbing, 4, TRUE)
		H.adjust_skillrank(/datum/skill/misc/sneaking, 4, TRUE)
		H.adjust_skillrank(/datum/skill/misc/medicine, 1, TRUE)
		H.adjust_skillrank(/datum/skill/magic/holy, 2, TRUE)
		H.adjust_skillrank(/datum/skill/misc/sewing, 2, TRUE)
		H.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
		H.adjust_skillrank(/datum/skill/craft/crafting, 1, TRUE)
		H.adjust_skillrank(/datum/skill/craft/cooking, 1, TRUE)
	if(H.gender == FEMALE)
		head = /obj/item/clothing/head/armingcap
		armor = /obj/item/clothing/shirt/dress/gen/colored/random
		shirt = /obj/item/clothing/shirt/undershirt
	else
		armor = /obj/item/clothing/shirt/robe
		shirt = /obj/item/clothing/shirt/undershirt
	pants = /obj/item/clothing/pants/tights
	belt = /obj/item/storage/belt/leather/rope
	shoes = /obj/item/clothing/shoes/simpleshoes
	beltl = /obj/item/key/church
	neck = /obj/item/clothing/neck/psycross/silver/abyssor

	H.change_stat(STATKEY_INT, 1)
	H.change_stat(STATKEY_PER, 1)
	H.change_stat(STATKEY_SPD, 2)
	if(!H.has_language(/datum/language/celestial)) // For discussing church matters with the other Clergy
		H.grant_language(/datum/language/celestial)
		to_chat(H, "<span class='info'>I can speak Celestial with ,c before my speech.</span>")

	var/holder = H.patron?.devotion_holder
	if(holder)
		var/datum/devotion/devotion = new holder()
		devotion.make_churching()
		devotion.grant_to(H)

	if(!(H.patron?.type in H.mind?.assigned_role?.allowed_patrons))
		var/chosen_patron = pick(H.mind?.assigned_role?.allowed_patrons)
		H.set_patron(chosen_patron)
