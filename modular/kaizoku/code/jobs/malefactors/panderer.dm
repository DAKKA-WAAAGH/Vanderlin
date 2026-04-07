//The panderer is both a replacement for the Nitemaster, and the Gaffer at the same time.

/datum/job/kaizoku/panderer
	title = "Panderer"
	faction = FACTION_TOWN
	department_flag = FACTION_MALEFACTORS
	total_positions = 1
	spawn_positions = 1
	allowed_races = RACES_CITIZEN_PLAYERS

	tutorial = "You own this den of indulgence with your associates, your hand controls the population \
	with vice and sin, be it drugs, assassinations or pleasures of the flesh, you provide \
	it all. Your infamous organized society thrives beyond the law's reach, as the sewers have no owners \
	as the tower's clan tolerates you, since your gang ensures no more other syndicates intrude on their \
	domains with more aggressive drugs and crimes, such as the Rockhill's black market, so seek to destroy it. \
	Don't forget gambling and the adventure guild, your only 'legal' business."
	// min_pq = 0 ; Stonekeep Todo - Vanderlin removed PQ, reimplement it later.
	allowed_sexes = list(MALE, FEMALE)
	outfit = /datum/outfit/job/kaizoku/panderer
	display_order = NITEMAN_ORDER
	give_bank_account = 120
	cmode_music = 'modular/stonekeep/sound/cmode/combat_hellish2.ogg'
	spells = list(/datum/action/cooldown/spell/undirected/list_target/convert_role/mercenary)


/datum/outfit/job/kaizoku/panderer/pre_equip(mob/living/carbon/human/H)
	..()
	backr = /obj/item/storage/backpack/satchel
	backpack_contents = list(/obj/item/storage/belt/pouch/coins/rich = 1, /obj/item/merctoken = 2, /obj/item/natural/feather, /obj/item/paper = 3, /obj/item/weapon/knife/dagger/steel, /obj/item/paper)
	backl = /obj/item/weapon/sword/long/replica // Just give them a normal Katana.
	belt = /obj/item/storage/belt/leather/plaquegold
	beltr = /obj/item/flashlight/flare/torch/lantern
	shirt = /obj/item/clothing/shirt/tunic/colored/black
	wrists = /obj/item/clothing/wrists/bracers/leather/advanced
	armor = /obj/item/clothing/armor/leather/hide
	mask = /obj/item/clothing/face/spectacles/delf // Change this to normal red spectacles.
	ring = /obj/item/clothing/ring/gold
	pants = /obj/item/clothing/pants/trou/leather/advanced
	shoes = /obj/item/clothing/shoes/nobleboot
	cloak = /obj/item/clothing/cloak/raincloak/furcloak/colored/black
	mask = /obj/item/clothing/face/eyepatch/fake
	// beltl = /obj/item/storage/keyring/nitemaster
	beltl = /obj/item/storage/keyring/gaffer // Change to the Panderer key later.
	if(H.gender == FEMALE)
		shoes = /obj/item/clothing/shoes/shortboots
		armor = /obj/item/clothing/shirt/dress/stewarddress
		cloak = /obj/item/clothing/cloak/cape/silk/dark

	ADD_TRAIT(H, TRAIT_GOODLOVER, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_THIEVESGUILD, TRAIT_GENERIC)
	H.grant_language(/datum/language/thievescant) //Change this later to a Mafia language.

	to_chat(H, "<span class='info'>I can gesture in thieves' cant with ,t before my speech.</span>")
	H.adjust_skillrank(/datum/skill/combat/knives, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/wrestling, 4, TRUE)
	H.adjust_skillrank(/datum/skill/combat/unarmed, 4, TRUE)
	H.adjust_skillrank(/datum/skill/combat/crossbows, 3, TRUE)//a dishonourable noble isn't going to be fighting like a honorable knight
	H.adjust_skillrank(/datum/skill/misc/reading, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/sneaking, 4, TRUE)
	H.adjust_skillrank(/datum/skill/misc/stealing, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/lockpicking, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
	H.change_stat("speed", 1)
	H.change_stat("intelligence", 1)
	H.change_stat("perception", 2)
	H.mind.teach_crafting_recipe(/datum/blueprint_recipe/forgery_nitemaiden)
	H.mind.teach_crafting_recipe(/datum/blueprint_recipe/forgery_adventurer)
	if(H.gender == MALE)
		head = /obj/item/clothing/head/roguehood/colored/brown
		armor = /obj/item/clothing/armor/leather/jacket/niteman
		shirt = /obj/item/clothing/armor/gambeson/arming//dark gambeson who only covers the chest + arms
		pants = /obj/item/clothing/pants/trou/leather
		shoes = /obj/item/clothing/shoes/nobleboot
		if(H.dna?.species)
			if(H.dna.species.id == "human")
				H.dna.species.soundpack_m = new /datum/voicepack/male/zeth()

/*	.................   Unique Nitemaster recipes   ................... */
/datum/blueprint_recipe/forgery_nitemaiden
	name = "Forge panderer license"
	construct_tool = /obj/item/natural/feather
	required_materials = list(/obj/item/paper = 1)
	result_type = /obj/item/paper/certificate/fake_health

/datum/blueprint_recipe/forgery_adventurer
	name = "Forge adventurer license"
	construct_tool = /obj/item/natural/feather
	required_materials = list(/obj/item/paper = 1)
	result_type = /obj/item/paper/certificate/adventurer_fake



/datum/outfit/gaffer/pre_equip(mob/living/carbon/human/H, visuals_only)
	..()
	backr = /obj/item/storage/backpack/satchel
	backpack_contents = list(/obj/item/storage/belt/pouch/coins/rich = 1, /obj/item/merctoken = 2, /obj/item/natural/feather, /obj/item/paper = 3, /obj/item/weapon/knife/dagger/steel, /obj/item/paper)
	backl = /obj/item/weapon/sword/long/replica
	belt = /obj/item/storage/belt/leather/plaquegold
	beltl = /obj/item/storage/keyring/gaffer
	beltr = /obj/item/flashlight/flare/torch/lantern
	shirt = /obj/item/clothing/shirt/tunic/colored/black
	wrists = /obj/item/clothing/wrists/bracers/leather/advanced
	armor = /obj/item/clothing/armor/leather/hide
	if(!visuals_only)
		ring = /obj/item/clothing/ring/gold/burden
	else
		ring = /obj/item/clothing/ring/gold
	pants = /obj/item/clothing/pants/trou/leather/advanced
	shoes = /obj/item/clothing/shoes/nobleboot
	cloak = /obj/item/clothing/cloak/raincloak/furcloak/colored/black
	mask = /obj/item/clothing/face/eyepatch/fake

	ADD_TRAIT(H, TRAIT_SEEPRICES, type)
	ADD_TRAIT(H, TRAIT_BURDEN, type)
	ADD_TRAIT(H, TRAIT_STEELHEARTED, type)
	ADD_TRAIT(H, TRAIT_OLDPARTY, TRAIT_GENERIC)

	H.change_stat(STATKEY_SPD, 2)
	H.change_stat(STATKEY_PER, 1)
	H.change_stat(STATKEY_STR, 1)

	H.adjust_skillrank(/datum/skill/combat/swords, pick(1,2), TRUE) //they are practicing with their fake ass shit sword but its clearly not paying off yet
	H.adjust_skillrank(/datum/skill/combat/knives, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/crossbows, 4, TRUE)
	H.adjust_skillrank(/datum/skill/combat/bows, 5, TRUE)
	H.adjust_skillrank(/datum/skill/misc/swimming, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/climbing, 4, TRUE)
	H.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/sneaking, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/reading, 5, TRUE)
	H.adjust_skillrank(/datum/skill/craft/cooking, 3, TRUE)
	H.adjust_skillrank(/datum/skill/craft/traps, 1, TRUE)
	H.adjust_skillrank(/datum/skill/labor/butchering, 5, TRUE)
	H.adjust_skillrank(/datum/skill/labor/mathematics, 5, TRUE)
	if(H.age == AGE_OLD)
		H.adjust_skillrank(/datum/skill/combat/crossbows, 1, TRUE)
		H.adjust_skillrank(/datum/skill/combat/bows, 1, TRUE)
		H.adjust_skillrank(/datum/skill/combat/unarmed, 1, TRUE)
		H.adjust_skillrank(/datum/skill/combat/knives, 1, TRUE)
		H.adjust_skillrank(/datum/skill/misc/sneaking, 2, TRUE) //actual stealth archer
		H.adjust_skillrank(/datum/skill/misc/swimming, 1, TRUE)
		H.adjust_skillrank(/datum/skill/misc/climbing, 1, TRUE)
		H.adjust_skillrank(/datum/skill/misc/athletics, 2, TRUE)
		H.change_stat(STATKEY_PER, 1)

