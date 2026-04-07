/mob/living/carbon/human/species/sunscorned
	race = /datum/species/sunscorned

/datum/species/sunscorned
	name = "Sunscorned"
	id = SPEC_ID_SUNSCORNED
	native_language = "Celestial" //Change this to 'Valorian' later.
	desc = "The exiled aristocrats trying to survive the fall of magic. \
	\n\n\
	Once their rule was welcomed on Valoria, but the decline of magic mirrored the weakening of the Blood Barons, \
	growing desperate as blood tithe no longer came with mana they relied on. It was just a matter of time until \
	the Totod Order tilted the balance and scattered many sunscorned across, forcing them to carve hidden \
	enclaves or flee to Fog Islands, the last bastion where their existence is tolerated and mana is still recycled freely. \
	\n\n\
	As always, safety does not come easy. Leaving behind noblesse oblige for lives as second-class citizen \
	beneath suspicion, while steering clear of association with the zizoid vampires whom preys on vitae. \
	The sun weakens their bodies and so does theurgies, but the night empowers them. \
	\n\n\
	These struggling immortal nobles rely on mana-infused blood rather than food for survival, \
	luckily, the untapped mana-rich blood is found plentifully on these islands, a rarity anywhere else. \
	But one must be careful to not be perceived as a blood parasite. \
	\n\n\
	THIS IS AN SECOND CLASS CITIZEN, AND ARE PROVIDED STATE RIGHTS, WHICH INCLUDES THE RIGHTS OF THE LIVING. \
	YOU MIGHT BE HUNTED DOWN FREELY BY ANTAG MEMBERS OF TOTOD ORDER AND GRENZELHOFT SOLDIERS."
	skin_tone_wording = "Blood Heritage"

	species_traits = list(EYECOLOR, HAIR, FACEHAIR, LIPS, OLDGREY)
	inherent_traits = list(TRAIT_NOMOBSWAP, TRAIT_NOHYGIENE, TRAIT_NOSLEEP)
	inherent_biotypes = MOB_UNDEAD
	use_skintones = TRUE

	organs = list(
		ORGAN_SLOT_BRAIN = /obj/item/organ/brain,
		ORGAN_SLOT_HEART = /obj/item/organ/heart,
		ORGAN_SLOT_LUNGS = /obj/item/organ/lungs,
		ORGAN_SLOT_EYES = /obj/item/organ/eyes,
		ORGAN_SLOT_EARS = /obj/item/organ/ears/elf,
		ORGAN_SLOT_TONGUE = /obj/item/organ/tongue,
		ORGAN_SLOT_LIVER = /obj/item/organ/liver,
		ORGAN_SLOT_STOMACH = /obj/item/organ/stomach,
		ORGAN_SLOT_APPENDIX = /obj/item/organ/appendix,
		ORGAN_SLOT_GUTS = /obj/item/organ/guts,
	)

	possible_ages = list(AGE_IMMORTAL)
	changesource_flags = WABBAJACK

	limbs_icon_m = 'icons/roguetown/mob/bodies/m/mm.dmi'
	limbs_icon_f = 'icons/roguetown/mob/bodies/f/fm.dmi'

	soundpack_m = /datum/voicepack/male/serious

	offset_features_m = list(
		OFFSET_RING = list(0,0),\
		OFFSET_GLOVES = list(0,0),\
		OFFSET_WRISTS = list(0,0),\
		OFFSET_HANDS = list(0,0),\
		OFFSET_CLOAK = list(0,0),\
		OFFSET_FACEMASK = list(0,0),\
		OFFSET_HEAD = list(0,0),\
		OFFSET_FACE = list(0,0),\
		OFFSET_BELT = list(0,0),\
		OFFSET_BACK = list(0,0),\
		OFFSET_NECK = list(0,0),\
		OFFSET_MOUTH = list(0,0),\
		OFFSET_PANTS = list(0,0),\
		OFFSET_SHIRT = list(0,0),\
		OFFSET_ARMOR = list(0,0),\
		OFFSET_UNDIES = list(0,0),\
	)

	offset_features_f = list(
		OFFSET_RING = list(0,-1),\
		OFFSET_GLOVES = list(0,0),\
		OFFSET_WRISTS = list(0,0),\
		OFFSET_HANDS = list(0,0),\
		OFFSET_CLOAK = list(0,0),\
		OFFSET_FACEMASK = list(0,-1),\
		OFFSET_HEAD = list(0,-1),\
		OFFSET_FACE = list(0,-1),\
		OFFSET_BELT = list(0,0),\
		OFFSET_BACK = list(0,-1),\
		OFFSET_NECK = list(0,-1),\
		OFFSET_MOUTH = list(0,-1),\
		OFFSET_PANTS = list(0,0),\
		OFFSET_SHIRT = list(0,0),\
		OFFSET_ARMOR = list(0,0),\
		OFFSET_UNDIES = list(0,0),\
	)

	specstats_m = list(STATKEY_STR = 0, STATKEY_PER = 2, STATKEY_INT = 1, STATKEY_CON = 0, STATKEY_END = 1, STATKEY_SPD = 0, STATKEY_LCK = -1)
	specstats_f = list(STATKEY_STR = 0, STATKEY_PER = 2, STATKEY_INT = 1, STATKEY_CON = 0, STATKEY_END = 1, STATKEY_SPD = 0, STATKEY_LCK = -1)

	enflamed_icon = "widefire"

	bodypart_features = list(
		/datum/bodypart_feature/hair/head,
		/datum/bodypart_feature/hair/facial,
	)

	customizers = list(
		/datum/customizer/organ/eyes/humanoid,
		/datum/customizer/bodypart_feature/hair/head/humanoid,
		/datum/customizer/bodypart_feature/hair/facial/humanoid,
		/datum/customizer/bodypart_feature/accessory,
		/datum/customizer/bodypart_feature/face_detail,
		/datum/customizer/organ/ears/elf,
	)

	body_markings = list(
		/datum/body_marking/tonage,
	)
	allowed_cultures = list("muqian", "kaizoku", "shuhen", "linyou", "dustwalker", "foreigner")
	allowed_body_types = list("mt_kit", "normalbody")

/datum/species/sunscorned/on_species_gain(mob/living/carbon/C, datum/species/old_species)
	. = ..()
	var/datum/action/cooldown/spell/undirected/shapeshift/bat_form/B = new
	B.Grant(C)

	var/datum/action/cooldown/spell/targeted/disguise_self/D = new
	D.Grant(C)

	RegisterSignal(C, COMSIG_HUMAN_LIFE, PROC_REF(on_life_sunscorned))

	var/mob/living/carbon/human/H = C
	H.AddComponent(/datum/component/sunscorned_disguise)

/datum/species/sunscorned/check_roundstart_eligible()
	return TRUE

/datum/species/sunscorned/handle_bloodsuck(mob/living/carbon/human/drinker, mob/living/victim, datum/blood_type/blood_type)
	return ..()

/datum/species/sunscorned/proc/on_life_sunscorned(mob/living/carbon/human/H)
	var/turf/T = get_turf(H)
	var/has_sky_exposure = FALSE
	if(T && T.can_see_sky())
		has_sky_exposure = TRUE

	if(has_sky_exposure)
		if(GLOB.tod == "day")
			H.apply_status_effect(/datum/status_effect/debuff/sunscorned_day)
			H.remove_status_effect(/datum/status_effect/buff/sunscorned_night)
		else
			H.apply_status_effect(/datum/status_effect/buff/sunscorned_night)
			H.remove_status_effect(/datum/status_effect/debuff/sunscorned_day)
	else
		// Inside - remove both effects
		H.remove_status_effect(/datum/status_effect/buff/sunscorned_night)
		H.remove_status_effect(/datum/status_effect/debuff/sunscorned_day)

	return TRUE

/datum/species/sunscorned/get_skin_list()
	return sortList(list(
		"Ice Cap" = VAMP_COLOR_ICECAP,
		"Temperate" = VAMP_COLOR_TEMPERATE,
		"Tropical Dry" = VAMP_COLOR_TROPICALDRY,
		"Tropical Wet" = VAMP_COLOR_TROPICALWET,
		"Desert" = VAMP_COLOR_DESERT,
		"Crimson Lands" = VAMP_COLOR_CRIMSONLANDS,
	))

/datum/species/sunscorned/get_hairc_list()
	return sortList(list(
	"blond - pale" = "9d8d6e",
	"blond - dirty" = "88754f",
	"blond - drywheat" = "d5ba7b",
	"blond - strawberry" = "c69b71",

	"brown - mud" = "362e25",
	"brown - oats" = "584a3b",
	"brown - grain" = "58433b",
	"brown - soil" = "48322a",
	"brown - bark" = "2d1300",

	"black - oil" = "181a1d",
	"black - cave" = "201616",
	"black - rogue" = "2b201b",
	"black - midnight" = "1d1b2b",

	"red - berry" = "b23434",
	"red - wine" = "82534c",
	"red - sunset" = "82462b",
	"red - blood" = "822b2b",
	"red - maroon" = "612929",

	"orange - rust" = "bc5e35"
	))

/datum/species/sunscorned/get_possible_names(gender = MALE)
	var/static/list/male_names = world.file2list('strings/rt/names/human/humnorm.txt')
	var/static/list/female_names = world.file2list('strings/rt/names/human/humnorf.txt')
	return (gender == FEMALE) ? female_names : male_names

/datum/species/sunscorned/get_possible_surnames(gender = MALE)
	var/static/list/last_names = world.file2list('strings/rt/names/human/humnorlast.txt')
	return last_names

/datum/status_effect/debuff/sunscorned_day
	id = "sunscorned_day"
	alert_type = /atom/movable/screen/alert/status_effect/debuff/sunscorned_day
	duration = 30 SECONDS
	status_type = STATUS_EFFECT_REFRESH
	effectedstats = list(STATKEY_STR = -2, STATKEY_CON = -1)

/atom/movable/screen/alert/status_effect/debuff/sunscorned_day
	name = "SOLAR REPRISAL"
	desc = span_warning("The tyrannical sun's gaze is upon me.")
	icon = 'modular/kaizoku/icons/misc/screen_alert.dmi'
	icon_state = "reprisal"

/datum/status_effect/debuff/sunscorned_day/on_apply()
	. = ..()
	if(.)
		owner.add_movespeed_modifier("sunscorned_day", multiplicative_slowdown = 0.8)

/datum/status_effect/debuff/sunscorned_day/on_remove()
	. = ..()
	owner.remove_movespeed_modifier("sunscorned_day")
	if(iscarbon(owner))
		var/mob/living/carbon/C = owner
		C.clear_fullscreen("sunscorned_vision")
		if(C.client)
			C.client.view_size.resetToDefault()

/datum/status_effect/buff/sunscorned_night
	id = "sunscorned_night"
	alert_type = /atom/movable/screen/alert/status_effect/buff/sunscorned_night
	duration = 30 SECONDS
	status_type = STATUS_EFFECT_REFRESH
	effectedstats = list(STATKEY_CON = 1, STATKEY_PER = 2, STATKEY_SPD = 1)

/atom/movable/screen/alert/status_effect/buff/sunscorned_night
	name = "NIGHTFALL EMBRACE"
	desc = span_good("My creator is looking at me.")
	icon = 'modular/kaizoku/icons/misc/screen_alert.dmi'
	icon_state = "embrace"

/mob/living/carbon/human
	var/blood_accumulation = 0.0
	var/blood_accum_target = 7.0
	var/last_blood_message = 0

/datum/status_effect/buff/blood_satiation
	id = "blood_satiation"
	alert_type = /atom/movable/screen/alert/status_effect/buff/blood_satiation
	duration = 2 MINUTES
	status_type = STATUS_EFFECT_REFRESH

	var/drinks = 0.0
	var/satiation_target = 7
	var/target = 7
	var/quality_modifier = 1.0
	var/last_message = 0
	var/last_drink_time = 0

/atom/movable/screen/alert/status_effect/buff/blood_satiation
	name = "BLOOD DIGESTION"
	desc = span_good("Digesting blood is a tough work, and now I am temporarily weakened.") //Avoids drinking and going to fight for passive healing.
	icon = 'modular/kaizoku/icons/misc/screen_alert.dmi'
	icon_state = "satiated"

/datum/stress_event/blood_satiation
	desc = span_good("My body is being sustained by blood.")
	stress_change = -3
	timer = 2 MINUTES

/datum/status_effect/buff/blood_satiation/on_apply()
	. = ..()
	if(!.)
		return FALSE
	if(!owner || !ishuman(owner))
		return FALSE
	var/mob/living/carbon/human/H = owner
	if(H.blood_accumulation < satiation_target)
		return FALSE
	return TRUE

/datum/status_effect/buff/blood_satiation/proc/add_intake(amount)
	if(amount <= 0)
		return

	drinks = min(drinks + amount, satiation_target)

	if(drinks >= satiation_target)
		if(world.time > last_message + 10 SECONDS)
			to_chat(owner, span_good("My body is empowered by the blood!"))
			owner.add_stress(/datum/stress_event/blood_satiation)
			last_message = world.time
	else
		if(world.time > last_message + 10 SECONDS)
			to_chat(owner, span_notice("... Not enough... I need [round(satiation_target - drinks, 0.1)] more."))
			last_message = world.time

/datum/status_effect/buff/blood_satiation/proc/add_drink_from_feed(datum/blood_type/blood_type, is_dead = FALSE, units = 1.0)
	if(!blood_type)
		return
	satiation_target = blood_type.satiation_sips || 7
	var/amount = units
	if(is_dead)
		amount *= 0.5
	add_intake(amount)

/datum/status_effect/buff/blood_satiation/tick()
	..()
	if(!ishuman(owner))
		return
	var/mob/living/carbon/human/H = owner

	if(drinks < satiation_target)
		return

	var/heal_mod = 0.15 * (drinks / satiation_target) * quality_modifier
	heal_mod = min(heal_mod, 1.6)

	var/bleed_rate = H.get_bleed_rate()

	if(bleed_rate < 2)
		H.blood_volume = min(H.blood_volume + (4 * heal_mod), BLOOD_VOLUME_NORMAL)

	H.adjustBruteLoss(-1 * heal_mod)
	H.adjustFireLoss(-1 * heal_mod)
	H.adjustToxLoss(-0.15 * heal_mod)
	H.adjust_energy(H.max_energy * 0.01 * heal_mod) //Akin to sleep, this will recover their energy.
	H.adjust_stamina(-5 * heal_mod) //This will provide stamina as well. It was funny to see that negatives is what restores stamina here.

	for(var/obj/item/bodypart/affecting as anything in H.bodyparts)
		if(affecting.get_bleed_rate() >= 2)
			continue
		affecting.heal_damage(heal_mod * 1.5, heal_mod * 1.5, required_status = BODYPART_ORGANIC, updating_health = TRUE)
		for(var/datum/wound/wound in affecting.wounds)
			if(wound.sleep_healing)
				wound.heal_wound(wound.sleep_healing * heal_mod)

/datum/status_effect/buff/trehalose
	id = "trehalose"
	alert_type = /atom/movable/screen/alert/status_effect/buff/trehalose
	duration = 45 SECONDS
	status_type = STATUS_EFFECT_REFRESH

	var/drinks = 0.0
	var/satiation_target = 3
	var/last_message = 0
	var/last_drink_time = 0

/atom/movable/screen/alert/status_effect/buff/trehalose
	name = "TREHALOSE EMPOWERMENT"
	desc = "Sweet, pure and easy to digest. I can already feel the mana flowing."
	icon = 'modular/kaizoku/icons/misc/screen_alert.dmi'
	icon_state = "trehalose"

/datum/stress_event/trehalose
	desc = span_good("Sweet and addicting. I need it once more.")
	stress_change = -2
	timer = 2 MINUTES

/datum/status_effect/buff/trehalose/on_apply()
	. = ..()
	if(!.)
		return FALSE
	if(world.time < last_drink_time + 20 SECONDS)
		return FALSE
	last_drink_time = world.time
	drinks = 0.0
	if(ishuman(owner))
		var/mob/living/carbon/human/H = owner
		if(H.mana_pool)
			H.mana_pool.adjust_mana(25)
			H.mana_pool.ethereal_recharge_rate += 0.5
	return TRUE

/datum/status_effect/buff/trehalose/proc/add_drink(datum/blood_type/blood_type, is_dead = FALSE, amount = 1.0)
	if(!blood_type)
		return

	var/drink_value = amount
	if(is_dead)
		drink_value *= 0.5

	drinks = min(drinks + drink_value, 12)

	if(!satiation_target && blood_type.satiation_sips > 0)
		satiation_target = blood_type.satiation_sips

	if(world.time > last_message + 10 SECONDS)
		var/remaining = max(satiation_target - drinks, 0)
		to_chat(owner, span_notice("... Not enough. I need [round(remaining, 0.1)] more ..."))
		last_message = world.time

/datum/status_effect/buff/trehalose/on_remove()
	. = ..()
	if(ishuman(owner))
		var/mob/living/carbon/human/H = owner
		if(H.mana_pool)
			H.mana_pool.ethereal_recharge_rate = max(0, H.mana_pool.ethereal_recharge_rate - 0.5) //Removes the boost when the buff expires.

/datum/status_effect/buff/trehalose/tick()
	. = ..()
	if(!ishuman(owner)) //Increases recovery, does not weaken the body.
		return
	var/mob/living/carbon/human/H = owner

	if(drinks >= 3)
		H.adjust_energy(H.max_energy * 0.01)
	if(drinks >= 6)
		H.adjustBruteLoss(-1)
		H.adjustFireLoss(-1)
	if(drinks >= 9)
		H.heal_bodypart_damage(1, 1, 0)
		H.adjustToxLoss(-0.2)

/datum/status_effect/debuff/foul_blood // Easy-to-find blood isn't as ... good to make use of.
	id = "foul_blood"
	alert_type = /atom/movable/screen/alert/status_effect/debuff/foul_blood
	duration = 30 SECONDS
	status_type = STATUS_EFFECT_REFRESH

/atom/movable/screen/alert/status_effect/debuff/foul_blood
	name = "Foul Blood"
	desc = span_warning("My stomach churns from within, I am unable to digest this.")
	icon = 'modular/kaizoku/icons/misc/screen_alert.dmi'
	icon_state = "foulblood"

/datum/status_effect/debuff/foul_blood/on_apply()
	. = ..()
	if(!ishuman(owner))
		return
	var/mob/living/carbon/human/H = owner
	H.adjust_stamina(-15)

/datum/status_effect/debuff/foul_blood/tick()
	. = ..()
	if(!ishuman(owner))
		return
	var/mob/living/carbon/human/H = owner
	H.adjust_stamina(-1)

/datum/stress_event/foul_blood
	stress_change = 3
	desc = list("<span class='red'>No different... of vegetable oil.</span>","<span class='red'>Foul taste of graggarspawn. Horrible.</span>")
	timer = 1 MINUTES

/mob/living/proc/on_blood_consumed(mob/living/victim, blood_handle, datum/blood_type/blood_type)
	return

/mob/living/carbon/human/on_blood_consumed(mob/living/victim, blood_handle, datum/blood_type/blood_type)
	. = ..()
	if(!dna)
		return
	if(!dna.species)
		return
	if(!blood_type)
		return
	dna.species.handle_bloodsuck(src, victim, blood_type)

/datum/species/proc/handle_bloodsuck(mob/living/carbon/human/drinker, mob/living/victim, datum/blood_type/blood_type)
	if(!drinker)
		return

	var/datum/blood_type/bt = blood_type
	if(!bt && victim)
		bt = victim.get_blood_type()
	if(!bt)
		return

	var/is_corrupted = (bt.satiation_sips == 0)
	if(is_corrupted)
		drinker.apply_status_effect(/datum/status_effect/debuff/foul_blood)
		drinker.add_stress(/datum/stress_event/foul_blood)
		if(drinker.reagents)
			drinker.reagents.add_reagent(/datum/reagent/consumable/nutriment, 2)
		return

	var/amount = 1.0
	if(victim && victim.stat == DEAD)
		amount = 0.5

	if(!drinker.blood_accum_target || drinker.blood_accum_target <= 0) //Sets target based on blood type.
		drinker.blood_accum_target = bt.satiation_sips || 7 // This happens only once per feeding cycle btw

	drinker.blood_accumulation += amount

	var/nutrition_mult = 1.0
	var/is_pelagic = istype(bt, /datum/blood_type/human/pelagic)
	if(is_pelagic)
		nutrition_mult = 2.0 // Pelagic blood is way more nutritious. Consider that it is easy to absorb.
	else if(istype(bt, /datum/blood_type/animal))
		nutrition_mult = 0.5 // Animal blood is sustainable, just less nutritious.
	if(victim && victim.stat == DEAD)
		nutrition_mult *= 0.5 // Dead blood is less nutritous, as it lacks the essence of vitae. So it is LESS nutriment.

	if(drinker.reagents)
		drinker.reagents.add_reagent(/datum/reagent/consumable/nutriment, nutrition_mult * 2) // Scale nutrients to bite amount

	if(is_pelagic)
		var/datum/status_effect/buff/trehalose/t = drinker.has_status_effect(/datum/status_effect/buff/trehalose)
		if(!t)
			t = drinker.apply_status_effect(/datum/status_effect/buff/trehalose)
		if(t)
			t.drinks = min(t.drinks + amount, 12)
			var/list/messages = list(
				"Sweet rarity, unlike any other...",
				"... This lingers in delight.",
				"The deep waters never disappoint...",
				"Pure taste of power, not even aged to be perfect...",
				"Hmm. Clearly harvested from something ancient. I can tell.",
				"Abyssal reserve... Too civilized to the untrained tongue.",
				"Back to the homeland, this would costs lands in fortune..",
				"Exquisite, few paletes are worthy of this..",
				"The taste of deep waters...",
				"Most cultivated vintage."
			)

			to_chat(drinker, span_good(pick(messages)))

	if(drinker.blood_accumulation < drinker.blood_accum_target)
		to_chat(drinker, "... Not enough... I need [round(drinker.blood_accum_target - drinker.blood_accumulation, 0.1)] more.")
		return
	var/datum/status_effect/buff/blood_satiation/sat = drinker.has_status_effect(/datum/status_effect/buff/blood_satiation)
	if(!sat)
		sat = drinker.apply_status_effect(/datum/status_effect/buff/blood_satiation)
	if(!sat)
		return

	sat.satiation_target = drinker.blood_accum_target
	sat.drinks = drinker.blood_accumulation
	sat.quality_modifier = is_pelagic ? 1.5 : 1.0

	if(world.time > sat.last_message + 10 SECONDS)
		to_chat(drinker, span_good("My body is empowered! Now, I need to rest."))
		drinker.add_stress(/datum/stress_event/blood_satiation)
		sat.last_message = world.time
	drinker.blood_accumulation = 0 //Resets accumulation after a successful fill.
	drinker.blood_accum_target = 0

/datum/reagent/blood/proc/handle_sunscorned_blood_ingest(mob/living/carbon/human/drinker, reac_volume, list/blood_data)
	if(!ishuman(drinker))
		return

	var/datum/blood_type/blood_type = null
	var/is_corrupted = FALSE
	var/is_pelagic = FALSE
	var/is_animal = FALSE

	if(blood_data && blood_data["blood_type"])
		var/type_or_name = blood_data["blood_type"]
		if(ispath(type_or_name))
			if(ispath(type_or_name, /datum/blood_type/human/corrupted))
				is_corrupted = TRUE
				blood_type = new /datum/blood_type/human/corrupted()
			else if(type_or_name == /datum/blood_type/human/pelagic)
				is_pelagic = TRUE
				blood_type = new /datum/blood_type/human/pelagic()
			else if(type_or_name == /datum/blood_type/animal)
				is_animal = TRUE
				blood_type = new /datum/blood_type/animal()
			else
				blood_type = new /datum/blood_type/human()
		else
			var/type_name = text2path(type_or_name) ? type_or_name : type_or_name
			if(type_name in list("Goblin", "Orc", "Rousman", "Zizombie"))
				is_corrupted = TRUE
				blood_type = new /datum/blood_type/human/corrupted()
			else if(type_name == "pelagic vitae")
				is_pelagic = TRUE
				blood_type = new /datum/blood_type/human/pelagic()
			else if(type_name == "Animal")
				is_animal = TRUE
				blood_type = new /datum/blood_type/animal()
			else
				blood_type = new /datum/blood_type/human(type_name)
	else
		blood_type = new /datum/blood_type/human()

	var/is_dead_blood = TRUE
	if(blood_data && blood_data["donor"])
		var/mob/living/L = blood_data["donor"]
		if(istype(L, /mob/living) && L.stat != DEAD)
			is_dead_blood = FALSE

	if(is_corrupted)
		drinker.apply_status_effect(/datum/status_effect/debuff/foul_blood)
		drinker.add_stress(/datum/stress_event/foul_blood)
		if(drinker.reagents)
			drinker.reagents.add_reagent(/datum/reagent/consumable/nutriment, reac_volume * 0.5)
		return

	var/nutrition_mult = 1.0
	var/reagent_strength = 0.02

	if(is_pelagic)
		nutrition_mult = 2.0
		reagent_strength = 0.03
	else if(is_animal)
		nutrition_mult = 0.5
		reagent_strength = 0.01

	if(is_dead_blood)
		nutrition_mult *= 0.5
		reagent_strength *= 0.5

	if(drinker.reagents)
		drinker.reagents.add_reagent(/datum/reagent/consumable/nutriment, reac_volume * nutrition_mult)

	drinker.blood_volume = min(drinker.blood_volume + round(reac_volume, 0.1), BLOOD_VOLUME_MAXIMUM) //Might change this later to an higher amount.

	var/drink_units = min(reac_volume * reagent_strength, 0.5)
	if(is_dead_blood)
		drink_units *= 0.5

	if(!drinker.blood_accum_target || drinker.blood_accum_target <= 0)
		drinker.blood_accum_target = blood_type.satiation_sips || 7

	drinker.blood_accumulation += drink_units

	if(drinker.blood_accumulation >= drinker.blood_accum_target) //We reached your fill? Then we can rest.
		var/datum/status_effect/buff/blood_satiation/sat = drinker.has_status_effect(/datum/status_effect/buff/blood_satiation)
		if(!sat)
			sat = drinker.apply_status_effect(/datum/status_effect/buff/blood_satiation)
		if(sat)
			sat.satiation_target = drinker.blood_accum_target
			sat.drinks = drinker.blood_accumulation
			sat.quality_modifier = is_pelagic ? 1.5 : 1.0
			if(world.time > sat.last_message + 10 SECONDS)
				to_chat(drinker, span_good("My body is empowered by blood!"))
				drinker.add_stress(/datum/stress_event/blood_satiation)
				sat.last_message = world.time
		drinker.blood_accumulation = 0
		drinker.blood_accum_target = 0

	if(is_pelagic)
		var/datum/status_effect/buff/trehalose/t = drinker.has_status_effect(/datum/status_effect/buff/trehalose)
		if(!t)
			t = drinker.apply_status_effect(/datum/status_effect/buff/trehalose)
		if(t)
			t.drinks = min(t.drinks + drink_units, 12)


/datum/species/sunscorned/handle_blood_reagent_ingest(mob/living/carbon/human/drinker, datum/reagent/blood/blood_reagent, reac_volume, list/blood_data)
	if(!drinker || !blood_reagent)
		return FALSE
	blood_reagent.handle_sunscorned_blood_ingest(drinker, reac_volume, blood_data)
	return TRUE

/mob/living/simple_animal/hostile/retaliate/batsunscorned
	name = "leaf-nosed bat"
	desc = "A strange, large bat."
	icon_state = "bat"
	icon_living = "bat"
	icon_dead = "bat_dead"
	icon_gib = "bat_dead"
	mob_biotypes = MOB_SPIRIT
	speak_chance = 0
	base_intents = list(INTENT_HELP)
	a_intent = INTENT_HARM
	healable = 0
	speed = 0
	maxHealth = 40
	health = 40
	harm_intent_damage = 10
	melee_damage_lower = 15
	melee_damage_upper = 15
	emote_see = list("flutters")
	attack_verb_continuous = "bites"
	attack_verb_simple = "bite"
	attack_sound = 'sound/blank.ogg'
	speak_emote = list("squeaks")
	deathmessage = "crumbles to dust!"
	is_flying_animal = TRUE
	gold_core_spawnable = NO_SPAWN
	pass_flags = PASSTABLE | PASSMOB | PASSGLASS
	ventcrawler = VENTCRAWLER_ALWAYS
	dendor_taming_chance = DENDOR_TAME_PROB_NONE
	var/datum/status_effect/shapechange_mob/status_effect

/mob/living/simple_animal/hostile/retaliate/batsunscorned/death(gibbed)
	if(status_effect)
		status_effect.restore_caster()
	return ..()

/datum/action/cooldown/spell/undirected/shapeshift/bat_form
	name = "Bat Form"
	desc = "Transform into a bat."
	button_icon = 'modular/kaizoku/icons/misc/spells.dmi'
	button_icon_state = "battify"
	background_icon = 'icons/mob/actions/roguespells.dmi'
	background_icon_state = "spell0"

	attunements = list(
		/datum/attunement/dark = 0.4,
		/datum/attunement/polymorph = 0.5,
		/datum/attunement/aeromancy = 0.3,
	)

	charge_required = FALSE
	cooldown_time = 2 MINUTES

	possible_shapes = list(/mob/living/simple_animal/hostile/retaliate/batsunscorned)
	die_with_shapeshifted_form = FALSE

/datum/action/cooldown/spell/undirected/shapeshift/bat_form/do_unshapeshift(mob/living/caster)
	var/mob/living/unshapeshifted_mob = ..()
	if(unshapeshifted_mob)
		unshapeshifted_mob.adjustBruteLoss(40)
		unshapeshifted_mob.adjustFireLoss(40)
		unshapeshifted_mob.SetUnconscious(10 SECONDS)
		if(unshapeshifted_mob.health <= 0)
			unshapeshifted_mob.adjustBruteLoss(1 - unshapeshifted_mob.health)
	return unshapeshifted_mob

/datum/component/sunscorned_disguise
	var/disguised = FALSE
	var/vampire_skin = null // TRUE vampire appearance skin
	var/disguise_skin = null
	var/cache_eyes = null
	var/cache_eye_secondary = null
	var/cache_hetero = FALSE
	var/cache_ears_type = null

/datum/component/sunscorned_disguise/Initialize()
	if(!ishuman(parent))
		return COMPONENT_INCOMPATIBLE

	var/mob/living/carbon/human/H = parent
	cache_original_features(H)
	vampire_skin = H.skin_tone //stores the true vampire skintone.
	disguise_skin = generate_human_disguise_skin(vampire_skin)
	apply_vampire_appearance(H)

	RegisterSignal(parent, COMSIG_DISGUISE_STATUS, PROC_REF(disguise_status))

/datum/component/sunscorned_disguise/proc/cache_original_features(mob/living/carbon/human/H)
	var/obj/item/organ/eyes/eyes = H.getorganslot(ORGAN_SLOT_EYES)
	if(eyes)
		cache_eyes = eyes.eye_color
		cache_eye_secondary = eyes.second_color
		cache_hetero = eyes.heterochromia

	var/obj/item/organ/ears/ears = H.getorganslot(ORGAN_SLOT_EARS)
	if(ears)
		cache_ears_type = ears.type

/datum/component/sunscorned_disguise/proc/generate_human_disguise_skin(vamp_skin)
	var/list/vamp_to_human = list(
		"eaeaea" = "fff0e9",      // Ice Cap
		"eaeaeaff" = "fff0e9",
		"a9a9a9" = "e2b9a3",      // Temperate
		"a9a9a9ff" = "e2b9a3",
		"6e6e6e" = "ba9882",      // Tropical Dry
		"6e6e6eff" = "ba9882",
		"4d4d4d" = "ac8369",      // Tropical Wet
		"4d4d4dff" = "ac8369",
		"222222" = "9c6f52",      // Desert
		"222222ff" = "9c6f52",
		"0f0f0f" = "4e3729",      // Crimson Lands
		"0f0f0fff" = "4e3729"
	)

	var/normalized = lowertext(vamp_skin)
	if(vamp_to_human[normalized])
		return vamp_to_human[normalized]

	// Fallback
	return "fff0e9"

/datum/component/sunscorned_disguise/proc/apply_vampire_appearance(mob/living/carbon/human/H)
	H.skin_tone = vampire_skin

	var/obj/item/organ/eyes/eyes = H.getorganslot(ORGAN_SLOT_EYES)
	if(eyes)
		eyes.heterochromia = FALSE
		eyes.eye_color = "#AA0000"
		eyes.second_color = "#AA0000"

	var/obj/item/organ/ears/current_ears = H.getorganslot(ORGAN_SLOT_EARS)
	if(current_ears && current_ears.type != /obj/item/organ/ears/elf)
		current_ears.Remove(H)
		var/obj/item/organ/ears/elf/new_ears = new(H)
		H.internal_organs_slot[ORGAN_SLOT_EARS] = new_ears
		new_ears.Insert(H)

	H.update_organ_colors()
	H.update_body()
	H.update_body_parts(redraw = TRUE)

/datum/component/sunscorned_disguise/proc/apply_disguise(mob/living/carbon/human/H)
	if(disguised)
		return FALSE

	disguised = TRUE
	H.skin_tone = disguise_skin //Changes only the skintone.

	var/obj/item/organ/eyes/eyes = H.getorganslot(ORGAN_SLOT_EYES)
	if(eyes)
		eyes.eye_color = cache_eyes
		eyes.second_color = cache_eye_secondary
		eyes.heterochromia = cache_hetero

	// Change to normal human ears
	var/obj/item/organ/ears/current_ears = H.getorganslot(ORGAN_SLOT_EARS)
	if(current_ears && current_ears.type != /obj/item/organ/ears)
		current_ears.Remove(H)
		var/obj/item/organ/ears/new_ears = new /obj/item/organ/ears(H)
		H.internal_organs_slot[ORGAN_SLOT_EARS] = new_ears
		new_ears.Insert(H)

	H.update_organ_colors()
	H.update_body()
	H.update_body_parts(redraw = TRUE)

	to_chat(H, span_notice("I assume a mortal guise."))
	return TRUE

/datum/component/sunscorned_disguise/proc/remove_disguise(mob/living/carbon/human/H)
	if(!disguised)
		return FALSE

	disguised = FALSE
	apply_vampire_appearance(H)

	to_chat(H, span_warning("My true nature is revealed!"))
	return TRUE

/datum/component/sunscorned_disguise/proc/force_undisguise(mob/living/carbon/human/H)
	if(!disguised)
		return FALSE
	remove_disguise(H)
	to_chat(H, span_danger("My disguise is forcibly broken!"))
	return TRUE

/datum/component/sunscorned_disguise/proc/disguise_status()
	return disguised

/datum/component/sunscorned_disguise/proc/get_heritage_from_skin(skin_hex) //This one is used to keep the heritage name.
	var/list/hex_to_heritage = list(
		VAMP_COLOR_ICECAP = "Ice Cap",
		SKIN_COLOR_ICECAP = "Ice Cap",
		VAMP_COLOR_TEMPERATE = "Temperate",
		SKIN_COLOR_TEMPERATE = "Temperate",
		VAMP_COLOR_TROPICALDRY = "Tropical Dry",
		SKIN_COLOR_TROPICALDRY = "Tropical Dry",
		VAMP_COLOR_TROPICALWET = "Tropical Wet",
		SKIN_COLOR_TROPICALWET = "Tropical Wet",
		VAMP_COLOR_DESERT = "Desert",
		SKIN_COLOR_DESERT = "Desert",
		VAMP_COLOR_CRIMSONLANDS = "Crimson Lands",
		SKIN_COLOR_CRIMSONLANDS = "Crimson Lands",
	)

	var/normalized = lowertext(skin_hex)
	for(var/hex_key in hex_to_heritage)
		if(lowertext(hex_key) == normalized)
			return hex_to_heritage[hex_key]

	return null

/datum/species/sunscorned/proc/get_skin_tone_description(mob/living/carbon/human/H)
	var/datum/component/sunscorned_disguise/disguise_comp = H.GetComponent(/datum/component/sunscorned_disguise)
	if(disguise_comp)
		var/heritage = disguise_comp.get_heritage_from_skin(H.skin_tone)
		if(heritage)
			return lowertext(heritage)
	var/list/skin_tones = get_skin_list()
	if(H.skin_tone)
		for(var/tone in skin_tones)
			if(H.skin_tone == skin_tones[tone])
				return lowertext(tone)

	return "incomprehensible"

/datum/action/cooldown/spell/targeted/disguise_self
	name = "~Illusionist Disguise~"
	desc = "Manifest mana to assume a mortal disguise to better blend in society."
	button_icon = 'modular/kaizoku/icons/misc/spells.dmi'
	button_icon_state = "vampiric"
	background_icon = 'icons/mob/actions/roguespells.dmi'
	background_icon_state = "spell0"
	sound = 'sound/magic/magic_nulled.ogg'

	charge_required = FALSE
	cooldown_time = 0 SECONDS
	cast_range = 0
	click_to_activate = FALSE

/datum/action/cooldown/spell/targeted/disguise_self/is_valid_target(atom/cast_on)
	return ishuman(cast_on)

/datum/action/cooldown/spell/targeted/disguise_self/cast(mob/living/carbon/human/cast_on)
	. = ..()
	var/datum/component/sunscorned_disguise/disguise_comp = cast_on.GetComponent(/datum/component/sunscorned_disguise)
	if(!disguise_comp)
		to_chat(cast_on, span_warning("I cannot disguise myself."))
		return FALSE

	if(disguise_comp.disguised)
		return disguise_comp.remove_disguise(cast_on)
	else
		return disguise_comp.apply_disguise(cast_on)

/datum/species/proc/handle_blood_reagent_ingest(mob/living/carbon/human/drinker, datum/reagent/blood/blood_reagent, reac_volume, list/blood_data)
	return FALSE // Default: species doesn't handle it
