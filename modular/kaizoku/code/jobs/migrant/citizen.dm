// This is better unused.
// Turns out, setting up every single citizen role spread around is better for
// player's eyecandiness.

/datum/job/kaizoku/citizen
	title = "Citizen"
	tutorial = "You are a Foglander citizen, granted privileges and safety that people \
	from other nations will never taste. Though you are not trapped \
	in filth, everything you hold dear is balanced on blood in this world. \
	As war looms ever closer, it becomes clear that survival is never guaranteed, \
	with looming danger that no law can shield you from, even more for those \
	like you whom never properly trained for war."
	department_flag = FACTION_CITIZENS
	job_flags = (JOB_ANNOUNCE_ARRIVAL | JOB_SHOW_IN_CREDITS | JOB_EQUIP_RANK | JOB_NEW_PLAYER_JOINABLE)
	display_order = KZ_CITIZEN
	total_positions = 20
	spawn_positions = 20
	// min_pq = 0 ; Stonekeep Todo - Vanderlin removed PQ, reimplement it later.
	banned_leprosy = FALSE
	bypass_lastclass = TRUE
	advclass_cat_rolls = list(CTAG_CITIZEN = 20)
	allowed_races = RACES_PLAYER_ALL
	outfit = null
	outfit_female = null
	give_bank_account = TRUE

/datum/job/kaizoku/citizen/after_spawn(mob/living/carbon/spawned, client/player_client)
	..()

/datum/job/kaizoku/citizen/New()
	. = ..()
	for(var/X in GLOB.peasant_positions)
		peopleiknow += X
		peopleknowme += X
	for(var/X in GLOB.serf_positions)
		peopleiknow += X
	for(var/X in GLOB.church_positions)
		peopleiknow += X
	for(var/X in GLOB.garrison_positions)
		peopleiknow += X
	for(var/X in GLOB.noble_positions)
		peopleiknow += X

/datum/job/advclass/kaizoku/citizen
	abstract_type = /datum/job/advclass/kaizoku/citizen
	category_tags = list(CTAG_CITIZEN)

/datum/job/advclass/kaizoku/citizen/rare
	abstract_type = /datum/job/advclass/kaizoku/citizen/rare
	category_tags = list(CTAG_CITIZEN)
	roll_chance = 30

/datum/job/advclass/kaizoku/citizen/tailor
	title = "Tailor"
	f_title = "Seamstress"
	tutorial = "Cloth, linen, silk and leather. \
	You've tirelessly studied and poured your life into \
	sewing articles of protection, padding, and fashion for citizen and noble alike."
	category_tags = list(CTAG_CITIZEN)
	allowed_sexes = list(MALE, FEMALE)
	outfit = /datum/outfit/tailor
	cmode_music = 'sound/music/cmode/towner/CombatTowner2.ogg'

	job_bitflag = BITFLAG_CONSTRUCTOR

/datum/outfit/tailor/pre_equip(mob/living/carbon/human/H)
	..()

	shoes = /obj/item/clothing/shoes/nobleboot
	head = /obj/item/clothing/head/courtierhat
	belt = /obj/item/storage/belt/leather
	beltr = /obj/item/weapon/knife/scissors
	beltl = /obj/item/key/tailor
	backr = /obj/item/storage/backpack/satchel
	neck = /obj/item/storage/belt/pouch/coins/mid
	backpack_contents = list(/obj/item/needle = 1, /obj/item/natural/bundle/cloth/full = 1, /obj/item/natural/bundle/fibers/full = 1, /obj/item/dye_pack/luxury = 1, /obj/item/recipe_book/sewing_leather = 1, /obj/item/weapon/knife/villager = 1)

	H.adjust_skillrank(/datum/skill/misc/sewing, pick(4,5), TRUE)
	H.adjust_skillrank(/datum/skill/craft/tanning, pick(3,4), TRUE)
	H.adjust_skillrank(/datum/skill/craft/crafting, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/knives, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/sneaking, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/medicine, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
	H.adjust_skillrank(/datum/skill/craft/carpentry, 1, TRUE)
	H.adjust_skillrank(/datum/skill/misc/stealing, 1, TRUE)
	H.adjust_skillrank(/datum/skill/labor/mathematics, 2, TRUE)
	ADD_TRAIT(H, TRAIT_SEEPRICES, TRAIT_GENERIC)
	if(H.gender == MALE)
		pants = /obj/item/clothing/pants/tights/colored/red
		shirt = /obj/item/clothing/shirt/undershirt/colored/red
		armor = /obj/item/clothing/shirt/tunic/colored/red
		cloak = /obj/item/clothing/cloak/raincloak/furcloak
	else
		cloak = /obj/item/clothing/cloak/raincloak/furcloak
		shirt = /obj/item/clothing/shirt/dress/gen/colored/purple
		armor = /obj/item/clothing/shirt/tunic/colored/purple
		pants = /obj/item/clothing/pants/tights/colored/purple
	H.change_stat(STATKEY_INT, 2)
	H.change_stat(STATKEY_SPD, 2)
	H.change_stat(STATKEY_PER, 1)

/datum/job/advclass/kaizoku/citizen/miner
	title = "Miner"
	tutorial = "Hardy people who ceaselessly toil at the mines for ores and salt, \
				who will ever know what they'll find beneath?"
	allowed_sexes = list(MALE, FEMALE)
	outfit = /datum/outfit/migrant/miner
	category_tags = list(CTAG_CITIZEN)
	apprentice_name = "Miner Apprentice"
	cmode_music = 'sound/music/cmode/towner/CombatBeggar.ogg'//pilgrims aren't towners, this fits them more for a combat on the woods

/datum/outfit/migrant/miner/pre_equip(mob/living/carbon/human/H)
	..()
	head =  pick(/obj/item/clothing/head/armingcap, /obj/item/clothing/head/headband/colored/red, /obj/item/clothing/head/roguehood/colored/random)
	pants = /obj/item/clothing/pants/trou
	armor = /obj/item/clothing/armor/gambeson/light/striped
	shirt = pick(/obj/item/clothing/shirt/undershirt/colored/random, /obj/item/clothing/shirt/shortshirt/colored/random)
	shoes = /obj/item/clothing/shoes/boots/leather
	belt = /obj/item/storage/belt/leather
	neck = /obj/item/storage/belt/pouch/coins/poor
	beltl = /obj/item/weapon/pick
	backr = /obj/item/weapon/shovel
	backl = /obj/item/storage/backpack/backpack
	backpack_contents = list(/obj/item/flint = 1, /obj/item/weapon/knife/villager = 1)
	if(H.mind)
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
		H.adjust_skillrank(/datum/skill/craft/smelting, 4, TRUE)
		H.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
		H.change_stat(STATKEY_STR, 1)
		H.change_stat(STATKEY_INT, -2)
		H.change_stat(STATKEY_END, 1)
		H.change_stat(STATKEY_CON, 1)

	if(H.dna.species.id == SPEC_ID_DWARF)
		head = /obj/item/clothing/head/helmet/leather/minershelm
		H.cmode_music = 'sound/music/cmode/combat_dwarf.ogg'
	else
		beltr = /obj/item/flashlight/flare/torch/lantern
