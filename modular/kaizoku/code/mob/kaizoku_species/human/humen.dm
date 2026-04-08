	/*==============*
	*				*
	*	 Humen		*
	*				*
	*===============*/

//	( +1 Fortune )

/mob/living/carbon/human/species/human/northern
	race = /datum/species/human/northern

/datum/species/human/northern
	name = "Psyjin"
	id = SPEC_ID_HUMEN
	desc = "Humenity, created in Psydon's image. \
	\n\n\
	Psyjin, or 'Mongrel', is the term used to describe humens, or half-elves for the latter, \
	as it became impossible to distinguish the two species after many generations. \
	They come from a vast swathe of cultures and ethnicities all around Psydonia, \
	most of which have historically been at odds with one another and other species. \
	The Heartfeltean people became part of Fog Island's political landscape by the alliance of \
	both nations, and are viewed in great light beyond the perception of prejudice. \
	Regardless, many came in search for a second chance far away from denmorian hordes, \
	other few has been recovered from zybantine slave ships, kept among the lower \
	classes as servants, or low lives. \
	\n\n\
	The Psyjin tend to find fortune easier than the other species, and are so diverse \
	that no other traits are dominant in their species."

	skin_tone_wording = "Ancestry"

	default_color = "FFFFFF"
	species_traits = list(EYECOLOR, HAIR, FACEHAIR, LIPS, STUBBLE, OLDGREY)
	inherent_traits = list(TRAIT_NOMOBSWAP)

	use_skintones = TRUE

	possible_ages = NORMAL_AGES_LIST_BLOOMING

	changesource_flags = WABBAJACK

	limbs_icon_m = 'icons/roguetown/mob/bodies/m/mm.dmi'
	limbs_icon_f = 'icons/roguetown/mob/bodies/f/fm.dmi'

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

	specstats_m = list(STATKEY_STR = 0, STATKEY_PER = 0, STATKEY_INT = 0, STATKEY_CON = 1, STATKEY_END = 2, STATKEY_SPD = 0, STATKEY_LCK = 1)
	specstats_f = list(STATKEY_STR = 0, STATKEY_PER = 0, STATKEY_INT = 0, STATKEY_CON = 1, STATKEY_END = 2, STATKEY_SPD = 0, STATKEY_LCK = 1)

	enflamed_icon = "widefire"

	customizers = list(
		/datum/customizer/organ/eyes/humanoid,
		/datum/customizer/bodypart_feature/hair/head/humanoid,
		/datum/customizer/bodypart_feature/hair/facial/humanoid,
		/datum/customizer/bodypart_feature/accessory,
		/datum/customizer/bodypart_feature/face_detail,
	)

	body_markings = list(
		/datum/body_marking/tonage,
	)
	allowed_cultures = list("muqian", "kaizoku", "shuhen", "linyou", "dustwalker", "foreigner") // IDs
	allowed_body_types = list("mt_kit", "normalbody") // IDs

/datum/species/human/northern/check_roundstart_eligible()
	return TRUE

/datum/species/human/northern/get_skin_list() //Back to Stonekeep lore. Let's go.
	return sortList(list(
		"Grenzelhoft" = SKIN_COLOR_ICECAP, // - (Pale)
		"Lowlander" = SKIN_COLOR_ARCTIC, // - (White 1)
		"Mainlander" = SKIN_COLOR_TUNDRA, // - (White 2)
		"Highlander" = SKIN_COLOR_CONTINENTAL, // - (White 3)
		"Valorian" = SKIN_COLOR_TEMPERATE, // - (White 4)
		"Heartfelt" = SKIN_COLOR_COASTAL, // - (Latin)
		"Steppe" = SKIN_COLOR_SUBTROPICAL, // - (Mediterranean)
		"Islander" = SKIN_COLOR_TROPICALDRY, // - (Mediterranean 2)
		"Southlander" = SKIN_COLOR_TROPICALWET, // - (Latin 2)
		"Zybantu" = SKIN_COLOR_DESERT, //  - (Middle-east)
		"Crimson Lands" = SKIN_COLOR_CRIMSONLANDS, // - (Black)
		"Mushroom-Minded delf" = SKIN_COLOR_MUSHROOM_MINDED, // - (Mid purple)
		"Cave-Attuned delf" = SKIN_COLOR_CAVE_ATTUNED, // - (Deep purple)
		"Fungus-Stained delf" = SKIN_COLOR_FUNGUS_STAINED, // - (Pink)

	))

/datum/species/human/northern/get_hairc_list()
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

/datum/species/human/northern/get_possible_names(gender = MALE)
	var/static/list/male_names = world.file2list('strings/names/roguetown/SKhumnorm.txt')
	var/static/list/female_names = world.file2list('strings/names/roguetown/SKhumnorf.txt')
	return (gender == FEMALE) ? female_names : male_names

/datum/species/human/northern/get_possible_surnames(gender = MALE)
	var/static/list/last_names = world.file2list('strings/rt/names/human/humnorlast.txt')
	return last_names
