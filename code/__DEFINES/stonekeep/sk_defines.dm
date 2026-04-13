// Legacy (disabled) macro declarations kept for reference:
// ALL_RACES_WITH_FACIALHAIR		list("human", "rakshari", "dwarf", "elf", "tiefling", "halforc", "orc", "zizombie", "kobold",  "abyssariad")
// SK_DIVINE_PATRONS	list(/datum/patron/divine/astrata, /datum/patron/divine/noc, /datum/patron/divine/dendor, /datum/patron/divine/abyssor, /datum/patron/divine/necra, /datum/patron/divine/ravox, /datum/patron/divine/xylix, /datum/patron/divine/pestra, /datum/patron/divine/malum, /datum/patron/divine/eora,/datum/patron/psydon)
// SK_TEMPLE_PATRONS 		list(/datum/patron/divine/astrata, /datum/patron/divine/noc, /datum/patron/divine/abyssor, /datum/patron/divine/necra, /datum/patron/divine/ravox, /datum/patron/divine/pestra, /datum/patron/divine/malum, /datum/patron/divine/eora)
// SK_TEMPLAR_PATRONS 		list(/datum/patron/divine/astrata, /datum/patron/divine/noc, /datum/patron/divine/abyssor, /datum/patron/divine/necra, /datum/patron/divine/ravox, /datum/patron/divine/xylix, /datum/patron/divine/pestra, /datum/patron/divine/malum, /datum/patron/divine/eora)
// TRIUMPH_BUY_PSYDON_INFLUENCE "psydon_influence"
// PSYDON "Psydon"
// FACTION_BURAKUMIN "Burakumin"
// CTAG_SKMERCENARY 	"CAT_SKMERCENART"
// CTAG_SKGARRISON		"CAT_SKGARRISON"

#define VALID_HUNTING_AREAS list(\
	/area/rogue/outdoors/bog,/area/rogue/outdoors/woods )

#define CTAG_NITEMAIDEN		"CAT_NITEMAIDEN" 		// 2 choices, bathhouse only or inn focus.
#define CTAG_SKHAND			"CAT_SKHAND"
#define CTAG_SKWOODSMAN		"CAT_SKWOODSMAN"
#define CTAG_OLDVETERAN		"CAT_OLDVETERAN"
#define CTAG_SKACOLYTE		"CAT_SKACOLYTE"

//Tools stuff
#define TOOL_ADZE "woodcarving"

// Legacy role-bitmask macros retained in comments in source file; active ones below:
#define SK_ELDER		(1<<0)
#define SK_SOILSON		(1<<1)

#define SK_WEAVER		(1<<3)
#define SK_WOODSMAN		(1<<4)
#define SK_STEVEDORE	(1<<5)
#define SK_BATHMAID		(1<<6)
#define SK_BEGGAR		(1<<7)

#define SK_MERCENARY	(1<<0)
#define SK_ADVENTURER	(1<<1)
#define SK_PILGRIM		(1<<2)
#define SK_BANDIT		(1<<3)

#define SK_OUTSIDERS    (1<<7)

#define LORD_ORDER			1
#define CONSORT_ORDER		2
#define HAND_ORDER			3
#define STEWARD_ORDER		4
#define COURTWIZARD_ORDER	6
#define ARCHIVIST_ORDER		7
#define SERVANT_ORDER		8
#define JESTER_ORDER		9

#define SHERIFF_ORDER		11
#define GARRISON_ORDER		13
#define SQUIRE_ORDER		15

#define PRIEST_ORDER		21
#define ACOLYTE_ORDER		22
#define GRAVEKEEPER_ORDER	23
#define TEMPLAR_ORDER		24
#define INQUISITOR_ORDER	27
#define ADEPT_ORDER			28

#define MERCHANT_ORDER		31
#define MERCENARY_ORDER		32

#define GUILDMASTER_ORDER	41
#define INNKEEP_ORDER		42
#define FELDSHER_ORDER		43
#define BLACKSMITH_ORDER	44
#define MASON_ORDER			45
#define NITEMAN_ORDER		46

#define ELDER_ORDER			51
#define SOILSON_ORDER		52
#define COOK_ORDER			53
#define WEAVER_ORDER		54
#define WOODSMAN_ORDER		55
#define STEVEDORE_ORDER		56
#define BATHMAID_ORDER		57
#define BEGGAR_ORDER		58

#define PILGRIM_ORDER		61
#define ADVENTURER_ORDER	62
#define BANDIT_ORDER		63

#define GATOR_HEALTH 220

#define ZATANA_WOOSH			list('modular/kaizoku/sound/combat/wooshes/bladed/zatana_nimble(1).ogg','modular/kaizoku/sound/combat/wooshes/bladed/zatana_nimble(2).ogg','modular/kaizoku/sound/combat/wooshes/bladed/zatana_nimble(3).ogg')
#define MANCATCHER				/datum/intent/polearm/thrust/mancatcher
