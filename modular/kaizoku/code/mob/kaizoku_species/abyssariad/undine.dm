	/*==============*
	*				*
	*	  Undine  	*
	*				*
	*===============*/

//	( Not done yet. But hopefully breathing underwater. )
//	( Not sure what to give them as debuff tbh. )

/mob/living/carbon/human/species/elf/undine
	race = /datum/species/elf/undine

/datum/species/elf/undine
	name = "Undine"
	id = SPEC_ID_UNDINE
	desc = "<b>Undine</b><br>\
	An amalgamation between Goblins and Elves that arrived at the Fog islands centuries \
	ago, long corrupted by demonic essence and alchemical misconducts over generations, \
	they now possess features that blends amphibious traits from Goblin's lineage, \
	including moist, permeable skin and a large shell on their back. They are a small, \
	water-dwelling creatures that inhabit rivers and ponds, often living tribalistic, \
	hedonistic lives, feared by those aware of their mischievous, people-drowning nature. \
	One may say these are misunderstood rituals of trust, others warns the others that it is \
	a sacrifice to the spirits they believe that exists. They have a natural, biological \
	antipathy and abhorrence to humens - and a mutual alliance with Abyssariads."
	default_color = "FFFFFF"
	species_traits = list(EYECOLOR,HAIR,FACEHAIR,LIPS,OLDGREY)
	inherent_traits = list(TRAIT_NOMOBSWAP)
	inherent_skills = list(
		/datum/skill/misc/reading = 1,
	)
	use_skintones = 1
	disliked_food = NONE
	liked_food = NONE
	swap_male_clothes = TRUE
	possible_ages = NORMAL_AGES_LIST_BLOOMING
	changesource_flags = WABBAJACK
	limbs_icon_m = 'modular/kaizoku/icons/abyssariad_bodies/male/ms_kappa.dmi'
	limbs_icon_f = 'modular/kaizoku/icons/abyssariad_bodies/female/fs_kappa.dmi'
	dam_icon_m = 'icons/roguetown/mob/bodies/dam/dam_male.dmi'
	dam_icon_f = 'icons/roguetown/mob/bodies/dam/dam_female.dmi'

	hairyness = "t1"
	soundpack_m = /datum/voicepack/male/elf
	soundpack_f = /datum/voicepack/female/elf
//	minrace_pq = 0

	offset_features_m = list(
		OFFSET_ID = list(0,-1),\
		OFFSET_GLOVES = list(0,-1),\
		OFFSET_WRISTS = list(0,-1),\
		OFFSET_CLOAK = list(0,-1),\
		OFFSET_FACEMASK = list(0,-1),\
		OFFSET_HEAD = list(0,-1),\
		OFFSET_FACE = list(0,-1),\
		OFFSET_BELT = list(0,-1),\
		OFFSET_BACK = list(0,-1),\
		OFFSET_NECK = list(0,-1),\
		OFFSET_MOUTH = list(0,-1),\
		OFFSET_PANTS = list(0,-1),\
		OFFSET_SHIRT = list(0,-1),\
		OFFSET_ARMOR = list(0,-1),\
		OFFSET_HANDS = list(0,-1),\
		OFFSET_UNDIES = list(0,-1),\
	)
	offset_features_f = list(
		OFFSET_ID = list(0,-1),\
		OFFSET_GLOVES = list(0,-1),\
		OFFSET_WRISTS = list(0,-1),\
		OFFSET_HANDS = list(0,-2),\
		OFFSET_CLOAK = list(0,-1),\
		OFFSET_FACEMASK = list(0,-2),\
		OFFSET_HEAD = list(0,-2),\
		OFFSET_FACE = list(0,-2),\
		OFFSET_BELT = list(0,-1),\
		OFFSET_BACK = list(0,-2),\
		OFFSET_NECK = list(0,-2),\
		OFFSET_MOUTH = list(0,-2),\
		OFFSET_PANTS = list(0,-1),\
		OFFSET_SHIRT = list(0,-1),\
		OFFSET_ARMOR = list(0,-1),\
		OFFSET_UNDIES = list(0,-1)
		)
	specstats_m = list("strength" = 0, "perception" = 0, "intelligence" = 0, "constitution" = 2, "endurance" = 2, "speed" = 0, "fortune" = 0)
	specstats_f = list("strength" = -1, "perception" = 0, "intelligence" = 0, "constitution" = 2, "endurance" = 2, "speed" = 1, "fortune" = 0)
	enflamed_icon = "widefire"
	// Usual 0+0+0+1+1+0+0 = 2, switching only strength for speed, so they are balanced alike the abyssariads.

	organs = list(
		ORGAN_SLOT_BRAIN = /obj/item/organ/brain,
		ORGAN_SLOT_HEART = /obj/item/organ/heart,
		ORGAN_SLOT_LUNGS = /obj/item/organ/lungs,
		ORGAN_SLOT_EYES = /obj/item/organ/eyes,
		ORGAN_SLOT_EARS = /obj/item/organ/ears/kappa,
		ORGAN_SLOT_TAIL = /obj/item/organ/tail/kappa,
		ORGAN_SLOT_TONGUE = /obj/item/organ/tongue,
		ORGAN_SLOT_LIVER = /obj/item/organ/liver,
		ORGAN_SLOT_STOMACH = /obj/item/organ/stomach,
		ORGAN_SLOT_APPENDIX = /obj/item/organ/appendix,
		ORGAN_SLOT_GUTS = /obj/item/organ/guts,
	)

	customizers = list(
		/datum/customizer/organ/ears/kappa,
		/datum/customizer/organ/eyes/humanoid,
		/datum/customizer/organ/tail/kappa,
		/datum/customizer/bodypart_feature/hair/head/humanoid/kaizoku,
		/datum/customizer/bodypart_feature/hair/facial/humanoid,
		/datum/customizer/bodypart_feature/accessory,
		/datum/customizer/bodypart_feature/face_detail,
	)
	allowed_cultures = list("muqian", "kaizoku", "shuhen", "linyou", "dustwalker", "foreigner") // IDs
	allowed_body_types = list("mt_kit", "normalbody") // IDs

/datum/species/elf/undine/check_roundstart_eligible()
	return TRUE

/datum/species/elf/undine/get_span_language(datum/language/message_language)
	if(!message_language)
		return
//	if(message_language.type == /datum/language/elvish)
//		return list(SPAN_SELF)
//	if(message_language.type == /datum/language/common)
//		return list(SPAN_SELF)
	if(message_language.type == /datum/language/abyssal)
		return list(SPAN_ABYSSAL)
	return message_language.spans

/datum/species/elf/undine/get_skin_list()
	return sortList(list(
		"Swamp Bodysnatcher" = SKIN_COLOR_SWAMPCLAN,
		"Jungle Bodysnatcher" = SKIN_COLOR_JUNGLECLAN, //EDIT
		"Leaf Skypiercer" = SKIN_COLOR_LEAFCLAN,
		"Bog Skypiercer" = SKIN_COLOR_BOGCLAN, //EDIT
		"Forest Boneclad" = SKIN_COLOR_FORESTCLAN,
		"Shadow Boneclad" = SKIN_COLOR_SHADOWCLAN,
		"Abyssal Riverdweller" = SKIN_COLOR_ABYSSALCLAN,
	))

/datum/species/elf/undine/get_hairc_list()
	return sortList(list(
	"black - oil" = "181a1d",
	"black - cave" = "201616",
	"black - rogue" = "2b201b",
	"black - midnight" = "1d1b2b",

	"brown - mud" = "362e25",
	"brown - oats" = "584a3b",
	"brown - grain" = "58433b",
	"brown - soil" = "48322a",

	"red - berry" = "48322a",
	"red - wine" = "82534c",
	"red - sunset" = "82462b",
	"red - blood" = "822b2b",

	"green - grass" = "2a482c",
	"green - swamp" = "3b482a",
	"green - leaf" = "2f3c2e",
	"green - moss" = "3b3c2a",
	"white - silver" = "e8fdfd",
	"white - oceanid" = "b8d4de"
	))
/*	This using the older proc causes runtimes, if possible adapt to new below ROGTODO
/datum/species/elf/undine/random_name(gender,unique,lastname)
	var/randname
	if(unique)
		if(gender == MALE)
			for(var/i in 1 to 10)
				randname = pick( world.file2list("strings/rt/names/elf/elfwm.txt") )
				if(!findname(randname))
					break
		if(gender == FEMALE)
			for(var/i in 1 to 10)
				randname = pick( world.file2list("strings/rt/names/elf/elfwf.txt") )
				if(!findname(randname))
					break
	else
		if(gender == MALE)
			randname = pick( world.file2list("strings/rt/names/elf/elfwm.txt") )
		if(gender == FEMALE)
			randname = pick( world.file2list("strings/rt/names/elf/elfwf.txt") )
	return randname

/datum/species/elf/undine/random_surname()
	return " [pick(world.file2list("strings/rt/names/elf/elfwlast.txt"))]"
*/
/datum/species/elf/undine/get_possible_names(gender = MALE)
	var/static/list/male_names = world.file2list('modular/kaizoku/code/strings/names/onim.txt')
	var/static/list/female_names = world.file2list('modular/kaizoku/code/strings/names/onif.txt')
	return (gender == FEMALE) ? female_names : male_names

/datum/species/elf/undine/get_possible_surnames(gender = MALE)
	var/static/list/last_names = world.file2list('modular/kaizoku/code/strings/names/abyssnorm.txt')
	return last_names

/mob/proc/croak()
	set name = "Croak"
	set category = "Noises"
	emote("croak")

// Unique Undine Recipes. They are actually meant to be RACIAL. But I'm too bad at doing that.

/datum/blueprint_recipe/tribal
	category = "Tribal Gear"
	requires_learning = TRUE
	skillcraft = /datum/skill/craft/crafting

/datum/blueprint_recipe/tribal/reinforced_armor
	name = "Reinforced Tribal Armor"
	desc = ""
	result_type = /obj/item/clothing/armor/ceramic/reinforced
	required_materials = list(
		/obj/item/alch/bone = 5,
		/obj/item/alch/sinew = 2,
		/obj/item/natural/hide = 3,
		/obj/item/alch/horn = 1
	)
	build_time = 8 SECONDS
	craftdiff = 2
	verbage = "assemble"
	verbage_tp = "assembles"
	craftsound = 'modular/kaizoku/sound/foley/Building-01.ogg'

/datum/blueprint_recipe/tribal/reinforced_helmet
	name = "Reinforced Tribal Helmet"
	desc = ""
	result_type = /obj/item/clothing/head/helmet/ceramic/reinforced
	required_materials = list(
		/obj/item/alch/bone = 3,
		/obj/item/alch/sinew = 2,
		/obj/item/natural/hide = 2,
		/obj/item/alch/horn = 1
	)
	build_time = 8 SECONDS
	craftdiff = 2
	verbage = "assemble"
	verbage_tp = "assembles"
	craftsound = 'modular/kaizoku/sound/foley/Building-01.ogg'

/datum/blueprint_recipe/tribal/medium_helmet
	name = "Medium Tribal Helmet"
	desc = ""
	result_type = /obj/item/clothing/head/helmet/ceramic/medium
	required_materials = list(
		/obj/item/alch/bone = 2,
		/obj/item/alch/sinew = 1,
		/obj/item/natural/hide = 1,
		/obj/item/natural/cloth = 4
	)
	build_time = 4 SECONDS
	craftdiff = 1
	verbage = "craft"
	verbage_tp = "crafts"
	craftsound = 'modular/kaizoku/sound/foley/Building-01.ogg'

/datum/blueprint_recipe/tribal/medium_armor
	name = "Medium Tribal Armor"
	desc = ""
	result_type = /obj/item/clothing/armor/ceramic
	required_materials = list(
		/obj/item/alch/bone = 3,
		/obj/item/alch/sinew = 2,
		/obj/item/natural/hide = 2,
		/obj/item/natural/cloth = 4
	)
	build_time = 4 SECONDS
	craftdiff = 1
	verbage = "craft"
	verbage_tp = "crafts"
	craftsound = 'modular/kaizoku/sound/foley/Building-01.ogg'

/datum/blueprint_recipe/tribal/light_helmet
	name = "Light Tribal Helmet"
	desc = ""
	result_type = /obj/item/clothing/head/helmet/ceramic
	required_materials = list(
		/obj/item/alch/bone = 1,
		/obj/item/natural/cloth = 4
	)
	build_time = 4 SECONDS
	craftdiff = 0
	verbage = "stitch"
	verbage_tp = "stitches"
	craftsound = 'modular/kaizoku/sound/foley/Building-01.ogg'

/datum/blueprint_recipe/tribal/light_armor
	name = "Light Tribal Armor"
	desc = ""
	result_type = /obj/item/clothing/armor/ceramic/light
	required_materials = list(
		/obj/item/alch/bone = 2,
		/obj/item/natural/cloth = 4
	)
	build_time = 4 SECONDS
	craftdiff = 0
	verbage = "stitch"
	verbage_tp = "stitches"
	craftsound = 'modular/kaizoku/sound/foley/Building-01.ogg'

/datum/blueprint_recipe/tribal_weapons
	category = "Tribal Weapons"
	requires_learning = TRUE
	skillcraft = /datum/skill/craft/crafting

/datum/blueprint_recipe/tribal_weapons/obsidian_club
	name = "Obsidian Club"
	desc = ""
	result_type = /obj/item/weapon/mace/ararebo/obsidian
	required_materials = list(
		/obj/item/grown/log/tree/small = 1,
		/obj/item/natural/stone = 4,
		/obj/item/fertilizer/ash = 1
	)
	build_time = 4 SECONDS
	craftdiff = 1
	verbage = "bind"
	verbage_tp = "binds"
	craftsound = 'modular/kaizoku/sound/foley/Building-01.ogg'

/datum/blueprint_recipe/tribal_weapons/obsidian_spear
	name = "Obsidian Spear"
	desc = ""
	result_type = /obj/item/weapon/polearm/spear/stone/obsidian
	required_materials = list(
		/obj/item/grown/log/tree/small = 1,
		/obj/item/natural/cloth = 1,
		/obj/item/natural/stone = 2,
		/obj/item/fertilizer/ash = 1
	)
	build_time = 4 SECONDS
	craftdiff = 1
	verbage = "lash"
	verbage_tp = "lashes"
	craftsound = 'modular/kaizoku/sound/foley/Building-01.ogg'
