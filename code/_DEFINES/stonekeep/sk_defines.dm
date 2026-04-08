// Legacy constants moved to code/__DEFINES/stonekeep/sk_defines.dm.

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
