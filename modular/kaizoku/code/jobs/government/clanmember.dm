/datum/job/kaizoku/clanmember
	title = "Clan member"
	tutorial = "You are a member of the most powerful clan in this heavenly tower, taken with highest regard \
	as the owners of these lands. Your family has been uplifted by the Heavenly Emperor's will to \
	take care of this coastline against Grenzelhoft invasion, but you have the feeling the reasons \
	are greater than you currently believe. You directly or indirectly make part of the Sovereign's family, \
	and you have political or military influence to back it up during your workload."
	department_flag = FACTION_GOVERNMENT
	faction = FACTION_TOWN
	display_order = KZ_CLANMEMBER
	job_flags = (JOB_ANNOUNCE_ARRIVAL | JOB_SHOW_IN_CREDITS | JOB_EQUIP_RANK | JOB_NEW_PLAYER_JOINABLE)
	total_positions = 8
	spawn_positions = 8
	spells = list(
		/datum/action/cooldown/spell/undirected/list_target/grant_title,
	)
	// min_pq = 0 ; Stonekeep Todo - Vanderlin removed PQ, reimplement it later.
	bypass_lastclass = TRUE

	allowed_races = RACES_FIRSTCLASS_PLAYERS

	outfit = /datum/outfit/kaizoku/clanmember
	advclass_cat_rolls = list(CTAG_HAND = 20)
	give_bank_account = 120
	noble_income = 22
	job_bitflag = BITFLAG_ROYALTY

	mind_traits = list(
		TRAIT_KNOW_KEEP_DOORS
	)
	traits = list(
		TRAIT_NOBLE
	)
	job_bitflag = BITFLAG_ROYALTY

/datum/outfit/kaizoku/clanmember
	shoes = /obj/item/clothing/shoes/nobleboot/thighboots
	belt = /obj/item/storage/belt/leather/steel

/datum/job/kaizoku/clanmember/after_spawn(mob/living/spawned, client/player_client)
	. = ..()
	var/mob/living/carbon/human/H = spawned
	addtimer(CALLBACK(SSfamilytree, TYPE_PROC_REF(/datum/controller/subsystem/familytree, AddRoyal), H, FAMILY_OMMER), 5 SECONDS)

	addtimer(CALLBACK(src, PROC_REF(know_agents), H), 5 SECONDS)

/datum/job/kaizoku/clanmember/proc/know_agents(mob/living/carbon/human/H)
	if(!GLOB.roundstart_court_agents.len)
		to_chat(H, span_notice("You begun the week with no agents."))
	else
		to_chat(H, span_notice("We begun the week with these agents:"))
		for(var/name in GLOB.roundstart_court_agents)
			to_chat(H, span_notice(name))
		H.mind.cached_frumentarii |= GLOB.roundstart_court_agents

/datum/job/advclass/kaizoku/clanmember/companion
	title = "Companion"
	tutorial = "You are a Zamurai appointed to lead the garrison and enforce discipline within its ranks, \
	you are trained for formal warfare, but your authority comes from your lineage and leadership. \
	Your ceremonial blade can subdue your own warriors when they disrespect you, and your voice strengthens morale."
	outfit = /datum/outfit/kaizoku/clanmember/companion

	//var/list/category_tags = list(CTAG_HAND)
	cmode_music = 'sound/music/cmode/nobility/combat_noble.ogg'
	total_positions = 2
	spawn_positions = 2

/datum/outfit/kaizoku/clanmember/companion/pre_equip(mob/living/carbon/human/H)
	shirt = /obj/item/clothing/shirt/undershirt/fancy
	backr = /obj/item/storage/backpack/satchel/black
	backpack_contents = list(/obj/item/weapon/knife/dagger/steel = 1, /obj/item/storage/keyring/hand = 1, /obj/item/paper/scroll/frumentarii/roundstart = 1)
	armor = /obj/item/clothing/armor/leather/jacket/handjacket
	pants = /obj/item/clothing/pants/tights/colored/black
	beltr = /obj/item/weapon/sword/rapier/dec
	scabbards = list(/obj/item/weapon/scabbard/sword/royal)
	H.adjust_skillrank(/datum/skill/combat/axesmaces, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/crossbows, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/swords, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/swimming, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/lockpicking, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/reading, 4, TRUE)
	H.adjust_skillrank(/datum/skill/misc/riding, 2, TRUE)
	H.adjust_skillrank(/datum/skill/labor/mathematics, 3, TRUE)
	H.change_stat(STATKEY_STR, 2)
	H.change_stat(STATKEY_PER, 3)
	H.change_stat(STATKEY_INT, 3)
	ADD_TRAIT(H, TRAIT_NOBLE, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_HEAVYARMOR, TRAIT_GENERIC)
	H.verbs |= /mob/living/carbon/human/proc/torture_victim

//Start of Companion stuff

/datum/job/advclass/kaizoku/clanmember/spymaster
	title = "Spymaster"
	tutorial = "In a world of liars and betrayers, you are the clan's unblinking beacon, \
	watching over secrets and rumors to ensure the dignity and lives of your kin, \
	at least the ones whom does not betray your sovereign. You are entrusted because \
	they cannot survive without you, and they fear you because they cannot undo what \
	you already know. You can hire agents with your Metsuke scroll."
	outfit = /datum/outfit/kaizoku/clanmember/spymaster

	//var/list/category_tags = list(CTAG_HAND)
	cmode_music = 'sound/music/cmode/nobility/CombatSpymaster.ogg'
	total_positions = 2
	spawn_positions = 2

//Spymaster start. More similar to the rogue adventurer - loses heavy armor and sword skills for more sneaky stuff.
/datum/outfit/kaizoku/clanmember/spymaster/pre_equip(mob/living/carbon/human/H)
	backr = /obj/item/storage/backpack/satchel/black
	backpack_contents = list(/obj/item/weapon/knife/dagger/steel/special = 1, /obj/item/storage/keyring/hand = 1, /obj/item/lockpickring/mundane = 1, /obj/item/paper/scroll/frumentarii/roundstart = 1)

	gloves = /obj/item/clothing/gloves/fingerless/shadowgloves
	mask = /obj/item/clothing/face/shepherd/shadowmask
	pants = /obj/item/clothing/pants/trou/shadowpants
	cloak = /obj/item/clothing/cloak/raincloak/colored/mortus //cool spymaster cloak
	shirt = /obj/item/clothing/shirt/undershirt/colored/guard
	armor = /obj/item/clothing/armor/leather/jacket/hand

	H.adjust_skillrank(/datum/skill/combat/axesmaces, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/crossbows, 4, TRUE)
	H.adjust_skillrank(/datum/skill/combat/bows, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/swords, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/knives, 4, TRUE)
	H.adjust_skillrank(/datum/skill/misc/swimming, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/climbing, 6, TRUE)
	H.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/reading, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/riding, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/sneaking, 5, TRUE)
	H.adjust_skillrank(/datum/skill/misc/stealing, 5, TRUE)
	H.adjust_skillrank(/datum/skill/misc/lockpicking, 5, TRUE) // not like they're gonna break into the vault.
	H.adjust_skillrank(/datum/skill/labor/mathematics, 3, TRUE)
	H.change_stat(STATKEY_STR, -1)
	H.change_stat(STATKEY_PER, 2)
	H.change_stat(STATKEY_SPD, 4)
	H.change_stat(STATKEY_INT, 2)
	ADD_TRAIT(H, TRAIT_NOBLE, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_DODGEEXPERT, TRAIT_GENERIC)
	H.verbs |= /mob/living/carbon/human/proc/torture_victim

/datum/job/advclass/heir/daring
	title = "New Rice"
	tutorial = "The life of a mere courtling was not for you, if you are to make a name for yourself, \
	you must conquer it with your own glory that gives your bloodline meaning by becoming a Zamurai \
	with discipline and training. Your ambition provides the potential to become a true warrior, \
	but there is plenty to endure, be it from bloodshed, your teachers or even fate itself."
	outfit = /datum/outfit/heir/daring
	//var/list/category_tags = list(CTAG_HEIR)

/datum/outfit/heir/daring/pre_equip(mob/living/carbon/human/H)
	..()
	pants = /obj/item/clothing/pants/tights
	shirt = /obj/item/clothing/shirt/undershirt/colored/guard
	armor = /obj/item/clothing/armor/chainmail
	shoes = /obj/item/clothing/shoes/nobleboot
	belt = /obj/item/storage/belt/leather
	beltl = /obj/item/weapon/sword
	beltr = /obj/item/key/manor
	neck = /obj/item/storage/belt/pouch/coins/rich
	backr = /obj/item/storage/backpack/satchel
	H.adjust_skillrank(/datum/skill/combat/axesmaces, 1, TRUE)
	H.adjust_skillrank(/datum/skill/combat/bows, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/crossbows, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/swords, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/knives, 1, TRUE)
	H.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/athletics, 1, TRUE)
	H.adjust_skillrank(/datum/skill/misc/riding, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/reading, 2, TRUE)
	H.adjust_skillrank(/datum/skill/labor/mathematics, 3, TRUE)
	H.change_stat(STATKEY_STR, 1)
	H.change_stat(STATKEY_PER, 1)
	H.change_stat(STATKEY_CON, 1)
	H.change_stat(STATKEY_SPD, 1)
	H.change_stat(STATKEY_LCK, 1)
	ADD_TRAIT(H, TRAIT_NOBLE, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_INTRAINING, TRAIT_GENERIC)

/datum/job/advclass/kaizoku/clanmember/courtling
	title = "Courtling"
	tutorial = "You are a sheltered figure, the young adult offspring of the clan who did not take \
	any training nor duty, remaining solely as a diplomatic representative with little ambition, since \
	you have nothing to prove, as living a good life is enough until you are married away to another clan \
	to ensure good relations. At least a life without stress granted grace and knowledge of arts."
	outfit = /datum/outfit/kaizoku/clanmember/courtling
	//var/list/category_tags = list(CTAG_HEIR)
	total_positions = 2
	spawn_positions = 2

/datum/outfit/kaizoku/clanmember/courtling/pre_equip(mob/living/carbon/human/H)
	..()
	ADD_TRAIT(H, TRAIT_NOBLE, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_BEAUTIFUL, TRAIT_GENERIC)
	belt = /obj/item/storage/belt/leather
	beltl = /obj/item/key/manor
	beltr = /obj/item/storage/belt/pouch/coins/rich
	if(H.gender == MALE)
		pants = /obj/item/clothing/pants/tights
		shirt = /obj/item/clothing/shirt/dress/royal/prince
		belt = /obj/item/storage/belt/leather
		shoes = /obj/item/clothing/shoes/nobleboot
	if(H.gender == FEMALE)
		belt = /obj/item/storage/belt/leather/cloth/lady
		head = /obj/item/clothing/head/hennin
		shirt = /obj/item/clothing/shirt/dress/royal/princess
		shoes = /obj/item/clothing/shoes/shortboots
		pants = /obj/item/clothing/pants/tights/colored/random
	H.adjust_skillrank(/datum/skill/combat/bows, 1, TRUE)
	H.adjust_skillrank(/datum/skill/combat/crossbows, pick(0,1), TRUE)
	H.adjust_skillrank(/datum/skill/combat/wrestling, 1, TRUE)
	H.adjust_skillrank(/datum/skill/combat/unarmed, 1, TRUE)
	H.adjust_skillrank(/datum/skill/combat/knives, 1, TRUE)
	H.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/climbing, 1, TRUE)
	H.adjust_skillrank(/datum/skill/misc/athletics, pick(0,1), TRUE)
	H.adjust_skillrank(/datum/skill/misc/riding, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/reading, 3, TRUE)
	H.adjust_skillrank(/datum/skill/craft/cooking, 1, TRUE)
	H.adjust_skillrank(/datum/skill/misc/sewing, 1, TRUE)
	H.adjust_skillrank(/datum/skill/labor/mathematics, 3, TRUE)
	H.change_stat(STATKEY_PER, 2)
	H.change_stat(STATKEY_STR, -1)
	H.change_stat(STATKEY_INT, 2)
	H.change_stat(STATKEY_LCK, 1)
	H.change_stat(STATKEY_SPD, 1)

/datum/job/advclass/kaizoku/clanmember/broker
	title = "Broker"
	tutorial = "You know the power of finance within the clan, now tasked with managing internal \
	trade and clandestine exchanges. Similarly to the Quartermaster, you handle Fogcruisers \
	and worldly trade, process debt, documents, regulations, payments, loans and ensure civilian rights. \
	Your very stamp is what differs between someone being confiscated, jailed, or walk armed on town."
	outfit = /datum/outfit/kaizoku/clanmember/broker
	//var/list/category_tags = list(CTAG_HAND)
	cmode_music = 'sound/music/cmode/nobility/CombatSpymaster.ogg'
	give_bank_account = 100
	total_positions = 2
	spawn_positions = 2

/datum/outfit/kaizoku/clanmember/broker/pre_equip(mob/living/carbon/human/H)
	..()
	if(H.gender == FEMALE)
		shirt = /obj/item/clothing/shirt/dress/stewarddress
	else
		shirt = /obj/item/clothing/shirt/undershirt/fancy
		pants = /obj/item/clothing/pants/trou/leathertights

	ADD_TRAIT(H, TRAIT_SEEPRICES, type)
	shoes = /obj/item/clothing/shoes/simpleshoes/buckle
	head = /obj/item/clothing/head/stewardtophat
	cloak = /obj/item/clothing/cloak/raincloak/furcloak
	armor = /obj/item/clothing/armor/gambeson/steward
	belt = /obj/item/storage/belt/leather/plaquesilver
	beltr = /obj/item/storage/keyring/steward
	beltl = /obj/item/weapon/knife/dagger/steel
	backr = /obj/item/storage/backpack/satchel
	scabbards = list(/obj/item/weapon/scabbard/knife)
	backpack_contents = list(/obj/item/storage/belt/pouch/coins/rich = 1, /obj/item/lockpickring/mundane = 1)

	H.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/reading, 6, TRUE)
	H.adjust_skillrank(/datum/skill/misc/riding, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/stealing, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/sneaking, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/lockpicking, 6, TRUE)
	H.adjust_skillrank(/datum/skill/labor/mathematics, 5, TRUE)
	H.change_stat(STATKEY_STR, -2)
	H.change_stat(STATKEY_INT, 5)
	H.change_stat(STATKEY_CON, -2)
	ADD_TRAIT(H, TRAIT_NOBLE, TRAIT_GENERIC)

/datum/job/advclass/kaizoku/clanmember/conservator
	title = "Conservator"
	tutorial = "You are a keeper of memories and sacred decree at the same time you \
	can erase names from history. You oversee the clan's written legacy, and keep \
	everything stored so it all will be remembered and teached, allowing knowledge to \
	be passed uncensored, as long as you wish it to be like so. Bound to the Curator \
	doctrine or Noc's influence, you've secured name of demons to weaken them."
	outfit = /datum/outfit/kaizoku/clanmember/conservator

	//var/list/category_tags = list(CTAG_HAND)
	cmode_music = 'sound/music/cmode/nobility/CombatSpymaster.ogg'

	total_positions = 1
	spawn_positions = 1
	spells = list(
		/datum/action/cooldown/spell/undirected/learn,
		/datum/action/cooldown/spell/undirected/touch/prestidigitation,
	)
	job_bitflag = BITFLAG_ROYALTY
	allowed_patrons = list(/datum/patron/abyssanctum/curator, /datum/patron/divine/noc)

/datum/outfit/kaizoku/clanmember/conservator/pre_equip(mob/living/carbon/human/H)
	..()
	H.mana_pool?.set_intrinsic_recharge(MANA_ALL_LEYLINES)
	if(H.gender == FEMALE)
		armor = /obj/item/clothing/shirt/robe/archivist
		pants = /obj/item/clothing/pants/tights/colored/black
	else
		shirt = /obj/item/clothing/shirt/undershirt/puritan
		armor = /obj/item/clothing/shirt/robe/archivist
		pants = /obj/item/clothing/pants/tights/colored/black
	shoes = /obj/item/clothing/shoes/boots
	belt = /obj/item/storage/belt/leather/plaquesilver
	beltl = /obj/item/storage/keyring/archivist
	beltr = /obj/item/book/granter/spellbook/apprentice
	backl = /obj/item/storage/backpack/satchel
	neck = /obj/item/clothing/neck/psycross/silver/noc
	backpack_contents = list(/obj/item/textbook = 1, /obj/item/natural/feather)

	H.grant_language(/datum/language/elvish)
	H.grant_language(/datum/language/dwarvish)
	H.grant_language(/datum/language/zalad)
	H.grant_language(/datum/language/celestial)
	H.grant_language(/datum/language/hellspeak)
	H.grant_language(/datum/language/oldpsydonic)
	H.grant_language(/datum/language/orcish)
	H.grant_language(/datum/language/deepspeak)
	if(istype(H.patron, /datum/patron/inhumen/zizo))
		H.grant_language(/datum/language/undead)
	H.adjust_skillrank(/datum/skill/misc/reading, 6, TRUE)
	H.adjust_skillrank(/datum/skill/misc/riding, 2, TRUE)
	H.adjust_skillrank(/datum/skill/craft/alchemy, 3, TRUE)
	H.adjust_skillrank(/datum/skill/magic/arcane, 3, TRUE)
	H.adjust_skillrank(/datum/skill/labor/mathematics, 6, TRUE)
	if(H.age == AGE_OLD)
		H.adjust_skillrank(/datum/skill/magic/arcane, 2, TRUE)
	H.change_stat(STATKEY_STR, -1)
	H.change_stat(STATKEY_INT, 8)
	H.change_stat(STATKEY_CON, -1)
	H.change_stat(STATKEY_END, -1)
	H.change_stat(STATKEY_SPD, -1)
	ADD_TRAIT(H, TRAIT_NOBLE, TRAIT_GENERIC)
