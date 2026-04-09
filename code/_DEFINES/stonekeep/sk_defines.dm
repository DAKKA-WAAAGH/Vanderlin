// #define ALL_RACES_WITH_FACIALHAIR		list("human", "rakshari", "dwarf", "elf", "tiefling", "halforc", "orc", "zizombie", "kobold",  "abyssariad")

//#define SK_DIVINE_PATRONS	list(/datum/patron/divine/astrata, /datum/patron/divine/noc, /datum/patron/divine/dendor, /datum/patron/divine/abyssor, /datum/patron/divine/necra, /datum/patron/divine/ravox, /datum/patron/divine/xylix, /datum/patron/divine/pestra, /datum/patron/divine/malum, /datum/patron/divine/eora,/datum/patron/psydon)


//#define SK_TEMPLE_PATRONS 		list(/datum/patron/divine/astrata, /datum/patron/divine/noc, /datum/patron/divine/abyssor, /datum/patron/divine/necra, /datum/patron/divine/ravox, /datum/patron/divine/pestra, /datum/patron/divine/malum, /datum/patron/divine/eora)
//#define SK_TEMPLAR_PATRONS 		list(/datum/patron/divine/astrata, /datum/patron/divine/noc, /datum/patron/divine/abyssor, /datum/patron/divine/necra, /datum/patron/divine/ravox, /datum/patron/divine/xylix, /datum/patron/divine/pestra, /datum/patron/divine/malum, /datum/patron/divine/eora)

//#define TRIUMPH_BUY_PSYDON_INFLUENCE "psydon_influence"
//#define PSYDON "Psydon"

//#define FACTION_BURAKUMIN "Burakumin"

//#define CTAG_SKMERCENARY 	"CAT_SKMERCENART"  		// Mercenary classes
//#define CTAG_SKGARRISON		"CAT_SKGARRISON"

//#define isgoblin(A) (is_species(A, /datum/species/goblin))

#define VALID_HUNTING_AREAS list(\
	/area/rogue/outdoors/bog,/area/rogue/outdoors/woods )

/proc/is_valid_hunting_area(area/A)
	for(var/i in VALID_HUNTING_AREAS)
		if(istype(A, i))
			return TRUE
	return FALSE

GLOBAL_LIST_INIT(outlaw_quotes, world.file2list("strings/rt/outlawlines.txt"))
GLOBAL_LIST_INIT(outlaw_aggro, world.file2list("strings/rt/outlawaggrolines.txt"))

GLOBAL_LIST_EMPTY(bogroad_starts)
GLOBAL_LIST_EMPTY(forestroad_starts)
GLOBAL_LIST_EMPTY(mountainroad_starts)
GLOBAL_LIST_EMPTY(bogevil_starts)
GLOBAL_LIST_EMPTY(forestevil_starts)
GLOBAL_LIST_EMPTY(mountainevil_starts)
GLOBAL_LIST_EMPTY(zizo_starts)

#define CTAG_NITEMAIDEN		"CAT_NITEMAIDEN" 		// 2 choices, bathhouse only or inn focus.
#define CTAG_SKHAND			"CAT_SKHAND"
#define CTAG_SKWOODSMAN		"CAT_SKWOODSMAN"
#define CTAG_OLDVETERAN		"CAT_OLDVETERAN"
#define CTAG_SKACOLYTE		"CAT_SKACOLYTE"

//Tools stuff
#define TOOL_ADZE "woodcarving"

/mob/living/carbon/human
	// Another Boolean. But this time entirely for Kaizoku content to define those whom Abyssariads considers 'impure', and for champions.
	var/burakumin = FALSE
	var/champion = FALSE
	//Kaizoku changes; Unique stuff.
	var/icon/body_type_limb_icon = null
	var/list/body_type_offset_features = null

	//a var used for a rather niched power.
	var/purification = FALSE

	//These vars are used for Changeling special quirks.
	var/mutable_appearance/eldritch_maw
	var/mob/living/carbon/human/var/list/transformed = null
	var/true_gender_string // <- this stores "male" or "female" for full safety
	var/list/true_original_form = null
	var/original_gender_mimicry = null
	var/overlay_eldritchjaw = 0

	//This var is used for Skylancer special quirk.
	var/flight_processing = FALSE

	//Vars for Abyssariad Raiders NPCs, specifically for special attacks.
	var/special_timer = 0
	var/special_cooldown = 20 // 20 seconds
	var/shuriken_count = 0 //used only for NPC stuff.

	var/aggressive //Outdated NPC stuff. Remove when the Raiders are updated.
	var/next_reposition = 0 //Outdated NPC stuff. Remove when the Raiders are updated.
