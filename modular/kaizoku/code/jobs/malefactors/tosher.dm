/datum/job/kaizoku/tosher
	title = "Tosher"
	tutorial = "Scavengers masked as sanitation workers, butchering and breeding waste-eating \
	slimes to clean the city's wastes, however, it is all a laundering scheme no different \
	from the Panderer's bath house, and the slime cores, a source to make even more drugs. \
	In truth, you run smuggling routes on the arteries of the town, all under the Garrison's nose."
	faction = FACTION_TOWN
	department_flag = FACTION_MALEFACTORS
	display_order = KZ_TOSHER
	job_flags = (JOB_ANNOUNCE_ARRIVAL | JOB_SHOW_IN_CREDITS | JOB_EQUIP_RANK | JOB_NEW_PLAYER_JOINABLE)
	total_positions = 3
	spawn_positions = 3
	bypass_lastclass = TRUE
	allowed_races = RACES_PLAYER_ALL //change this
	// min_pq = 0 ; Stonekeep Todo - Vanderlin removed PQ, reimplement it later.
	outfit = /datum/outfit/kaizoku/tosher
	cmode_music = 'sound/music/cmode/towner/CombatTowner2.ogg'

/datum/outfit/kaizoku/tosher/pre_equip(mob/living/carbon/human/H)
	..()
	head = /obj/item/clothing/head/helmet/leather/minershelm
	pants = /obj/item/clothing/pants/trou
	armor = /obj/item/clothing/armor/gambeson/light/striped
	shirt = /obj/item/clothing/shirt/undershirt/colored/random
	shoes = /obj/item/clothing/shoes/boots/leather
	belt = /obj/item/storage/belt/leather
	neck = /obj/item/storage/belt/pouch/coins/poor
	beltr = /obj/item/flashlight/flare/torch/lantern
	// beltl = /obj/item/weapon/pick
	// backr = /obj/item/weapon/shovel
	backl = /obj/item/storage/backpack/backpack
	backpack_contents = list(/obj/item/flint = 1, /obj/item/weapon/knife/villager = 1, /obj/item/storage/keyring/artificer = 1)
	H.adjust_skillrank(/datum/skill/combat/axesmaces, 2, TRUE)
	H.adjust_skillrank(/datum/skill/labor/mining, 4, TRUE)
	H.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
	H.adjust_skillrank(/datum/skill/craft/crafting, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/swimming, 1, TRUE)
	H.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/medicine, 1, TRUE)
	H.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
	H.adjust_skillrank(/datum/skill/craft/traps, 1, TRUE)
	H.adjust_skillrank(/datum/skill/craft/engineering, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
	H.change_stat(STATKEY_STR, 1)
	H.change_stat(STATKEY_INT, -2)
	H.change_stat(STATKEY_END, 1)
	H.change_stat(STATKEY_CON, 1)
