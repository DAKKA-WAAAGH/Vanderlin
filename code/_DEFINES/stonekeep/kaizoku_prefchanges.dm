// Global registries
GLOBAL_LIST_INIT(body_types, list())
GLOBAL_LIST_INIT(cultures, list())

/proc/register_body_type(id, path_or_datum)
	if(!id || !path_or_datum) return
	GLOB.body_types[id] = path_or_datum

/proc/register_culture(id, path_or_datum)
	if(!id || !path_or_datum) return
	GLOB.cultures[id] = path_or_datum

/proc/get_body_type(id)
	if(!id) return null
	var/entry = GLOB.body_types[id]
	if(ispath(entry)) return new entry()
	if(isdatum(entry)) return entry
	return null

/proc/get_culture(id)
	if(!id)
		return null

	return GLOB.cultures[id]

/datum/culture
	var/id
	var/name
	var/description

/datum/culture/muqian
	id = "muqian"
	name = "Muqian - Imperials"
	description = "Life in the great towers is orderly and safe, yet suffocating. \
	Waking bells notify the daybreak as work starts, squeezed into \
	narrow districts with people rotating through civic duties before drowning their nerves \
	in alcohol at night to make living stacked atop one another more bearable. \
	Youngsters are pushed early into quadrivium arts to feed the industrial ways. Political purges \
	and constant vigilance against suspicious behavior keep civilians tense, but to those \
	obedient, order still promises safety and predictable justice, albeit stressful under \
	the constant sounds of hammers and business that never dies."
	// /datum/skill/misc/medicine
	// /datum/skill/craft/masonry


/datum/culture/kaizoku
	id = "kaizoku"
	name = "Coastal - Sons of Kaizoku"
	description = "The sons of Kaizoku live and die by the sea, calling them freebooters is no exaggeration. \
	The youthful days are spent on docks, skiffs, and shore camps, gutting fish, climbing ropes, and learning \
	to balance on deck before even daring to write anything. The mature ones handle the true dangerous work \
	by sailing, shipwrighting, salvaging wrecks, ambushing coastal traffic, and preparing raids against \
	Grenzelhoft hulls. Life is mobile, loud, and relentless, punctuated by simple but spice-rich meals, \
	friendship with sea dogs, and the smell of salt. Their prayers \
	often goes to the Sky Serpent Syzygy for wind reorientation."
	// /datum/skill/craft/carpentry
	// /datum/skill/labor/fishing


/datum/culture/shuhen
	id = "shuhen"
	name = "Shuhen - Frontiersmen"
	description = "The Shuhen are the most traditional folk on Fog Island coming from the \
	ancient championage ways, clustered in tight farmland settlements where every household \
	works and fights. The act of tilling soil, building aqueducts, and repairing tools blurs \
	into militia drills, consequence of demonic incursions and border raids being part of \
	normal life. Their labor ensure their Zamurai lord's finance to start another expedition \
	against what threatens their fields with civilians turned retainers. Masks are sacred \
	to Shuhen identity, faces carved in the likeness of dead family members to be worn \
	on war or rituals. Different of others, they do not have a professional army."
	// /datum/skill/craft/tanning
	// /datum/skill/misc/sneaking


/datum/culture/linyou
	id = "linyou"
	name = "Linyou - Mirefolk"
	description = "The odd bunch among the Foglander population, living by and \
	living wild on stilt houses above flooding rivers with herbs and spices \
	drying from rafters, and intensive leather and fur production. They know \
	every bend of the marsh, using the fog and river currents to ambush \
	invaders and demons, very few leaves unscarred, with plenty being \
	left wedged in rocks and wood to slowly drown on the raising waters. \
	Protein-rich diets from fish and game keep their bodies and mind \
	strong. They are sought after as hunter and scouts, tracking down \
	criminals and recovering lost relics on expeditions. However, with \
	many years spent fighting horrors truly carves a hard edge on this people."
	// /datum/skill/labor/farming
	// /datum/skill/craft/cooking

/datum/culture/dustwalker
	id = "dustwalker"
	name = "Dustwalker - Caravaneers"
	description = "Ever since the oldest days, the Dustwalkers wanders, nomads \
	on Fog Island's harshests stretches in mobile tents and caravans that \
	ocasionally stops moving to tend portable forges that taps into exposed \
	lava veins to smelt metal in the open. During their nomadic routes, they spent \
	time tending horses, training mounted archery and acting like arteries for the \
	isles, turning Kaizoku's coagulated blood into cokeless iron to be traded to \
	other cultures. They value practicality with their tight-knit family caravans. \
	Dustwalkers are famed for their legendary cheesemakers, but infamous \
	for their dried meat made of horses, a taboo among other foglander cultures."
	// /datum/skill/craft/smelting
	// /datum/skill/misc/riding


/datum/culture/foreigner
	id = "foreigner"
	name = "Mainlander - Orbited Barbarian"
	description = "You've arrived on these islands from elsewhere, still retaining \
	your homeland's culture, either a refugee fleeing denmorian swarms, demonic \
	incursions or religious orders, or maybe just an immigrant from Heartfelt \
	seeking a better life with your allies. The island is comparatively safe, food \
	can be cheap and coin is easier to earn, but mistake, or simply existing, seems \
	to be judged harder on you, all while handling the odd jobs locals refuses in a \
	heartbeat as you struggle with the unique document bureaucracy and unspoken customs of Foglander life."
	// /datum/skill/misc/lockpicking
	// /datum/skill/misc/stealing
//
// Body types
//
/datum/body_type
	var/id
	var/name
	var/limbs_icon_m
	var/limbs_icon_f
	var/list/offset_features_m
	var/list/offset_features_f

/datum/body_type/mt_kit
	id = "mt_kit"
	name = "Experimental Bigger"
	limbs_icon_m = 'modular/kaizoku/icons/abyssariad_bodies/male/mt_kit.dmi'
	limbs_icon_f = 'modular/kaizoku/icons/abyssariad_bodies/female/ft_kit.dmi'
	offset_features_m = list(
		OFFSET_ID = list(0,1),
		OFFSET_GLOVES = list(0,1),
		OFFSET_WRISTS = list(0,1),
		OFFSET_CLOAK = list(0,1),
		OFFSET_FACEMASK = list(0,1),
		OFFSET_HEAD = list(0,1),
		OFFSET_FACE = list(0,1),
		OFFSET_BELT = list(0,1),
		OFFSET_BACK = list(0,1),
		OFFSET_NECK = list(0,1),
		OFFSET_MOUTH = list(0,1),
		OFFSET_PANTS = list(0,1),
		OFFSET_SHIRT = list(0,1),
		OFFSET_ARMOR = list(0,1),
		OFFSET_HANDS = list(0,1),
		OFFSET_UNDIES = list(0,1),
	)
	offset_features_f = list(
		OFFSET_ID = list(0,-1),
		OFFSET_GLOVES = list(0,1),
		OFFSET_WRISTS = list(0,1),
		OFFSET_HANDS = list(0,1),
		OFFSET_CLOAK = list(0,1),
		OFFSET_FACEMASK = list(0,0),
		OFFSET_HEAD = list(0,0),
		OFFSET_FACE = list(0,0),
		OFFSET_BELT = list(0,1),
		OFFSET_BACK = list(0,0),
		OFFSET_NECK = list(0,0),
		OFFSET_MOUTH = list(0,0),
		OFFSET_PANTS = list(0,1),
		OFFSET_SHIRT = list(0,1),
		OFFSET_ARMOR = list(0,1),
		OFFSET_UNDIES = list(0,1),
	)

/datum/body_type/normalbody
	id = "normalbody"
	name = "Normal Body"
	limbs_icon_m = 'icons/roguetown/mob/bodies/m/mm.dmi'
	limbs_icon_f = 'icons/roguetown/mob/bodies/f/fm.dmi'
	offset_features_m = list(
		OFFSET_RING = list(0,0),
		OFFSET_GLOVES = list(0,0),
		OFFSET_WRISTS = list(0,0),
		OFFSET_HANDS = list(0,0),
		OFFSET_CLOAK = list(0,0),
		OFFSET_FACEMASK = list(0,0),
		OFFSET_HEAD = list(0,0),
		OFFSET_FACE = list(0,0),
		OFFSET_BELT = list(0,0),
		OFFSET_BACK = list(0,0),
		OFFSET_NECK = list(0,0),
		OFFSET_MOUTH = list(0,0),
		OFFSET_PANTS = list(0,0),
		OFFSET_SHIRT = list(0,0),
		OFFSET_ARMOR = list(0,0),
		OFFSET_UNDIES = list(0,0),
	)
	offset_features_f = list(
		OFFSET_RING = list(0,-1),
		OFFSET_GLOVES = list(0,0),
		OFFSET_WRISTS = list(0,0),
		OFFSET_HANDS = list(0,0),
		OFFSET_CLOAK = list(0,0),
		OFFSET_FACEMASK = list(0,-1),
		OFFSET_HEAD = list(0,-1),
		OFFSET_FACE = list(0,-1),
		OFFSET_BELT = list(0,0),
		OFFSET_BACK = list(0,-1),
		OFFSET_NECK = list(0,-1),
		OFFSET_MOUTH = list(0,-1),
		OFFSET_PANTS = list(0,0),
		OFFSET_SHIRT = list(0,0),
		OFFSET_ARMOR = list(0,0),
		OFFSET_UNDIES = list(0,0),
	)

// Minimal species hooks
/datum/species
	var/list/allowed_cultures = null
	var/list/allowed_body_types = list("normalbody", "mt_kit")

/datum/species/proc/get_available_cultures()
	return allowed_cultures ? allowed_cultures.Copy() : list()

/datum/species/proc/get_available_body_types()
	return allowed_body_types ? allowed_body_types.Copy() : list()

/world/New()
	..()
	register_body_type("mt_kit", /datum/body_type/mt_kit)
	register_body_type("normalbody", /datum/body_type/normalbody)

	register_culture("muqian", /datum/culture/muqian)
	register_culture("kaizoku", /datum/culture/kaizoku)
	register_culture("shuhen", /datum/culture/shuhen)
	register_culture("linyou", /datum/culture/linyou)
	register_culture("foreigner", /datum/culture/foreigner)
	register_culture("dustwalker", /datum/culture/dustwalker)

/mob/living/carbon/human/proc/get_offset_features_for(datum/species/S, use_female_sprites)
	// Prefer the body-type offsets when present
	if(body_type_offset_features)
		return body_type_offset_features

	// Fallback to species offsets (keeps upstream behavior)
	if(!S)
		return null
	return use_female_sprites ? S.offset_features_f : S.offset_features_m

/datum/preferences/proc/ShowCultureMenu(mob/user)
	if(!user || !user.client) return
	var/list/dat = list()
	dat += "<h2 style='text-align:center;margin:0'>Choose Culture</h2><hr>"

	var/datum/species/S = src.pref_species
	var/list/allowed = S?.get_available_cultures()
	if(!islist(allowed) || !allowed.len)
		dat += "Your race have no culture. Warn the developers.<br>"
	else
		for(var/id in allowed)
			var/datum/culture/C = get_culture(id)
			if(!C) continue
			var/mark = (culture == id) ? "&#10003; " : ""
			dat += "[mark]<a href='?_src_=prefs;preference=culture;task=set;culture=[id]'>[C.name]</a><br>"

	dat += "<br><a href='?_src_=prefs;preference=back_to_main'>Back</a>"

	var/datum/browser/popup = new(user, "preferences_browser", "<div align='center'>Character Sheet</div>", 700, 650)
	popup.set_window_options(can_close = TRUE)
	popup.set_content(dat.Join())
	popup.open(FALSE)

/datum/preferences/proc/ensure_defaults_for_species()
	var/datum/species/S = src.pref_species
	if(!S) return

	var/list/c_allowed = S.get_available_cultures()
	if(islist(c_allowed) && c_allowed.len)
		if(isnull(culture) || !(culture in c_allowed))
			culture = c_allowed[1]

	var/list/b_allowed = S.get_available_body_types()
	if(islist(b_allowed) && b_allowed.len)
		if(isnull(body_type) || !(body_type in b_allowed))
			body_type = b_allowed[1]

/datum/preferences/proc/ShowBodyTypeMenu(mob/user)
	if(!user || !user.client) return
	var/list/dat = list()
	dat += "<h2 style='text-align:center;margin:0'>Choose Body Type</h2><hr>"

	var/datum/species/S = src.pref_species
	var/list/allowed = S?.get_available_body_types()
	if(!islist(allowed) || !allowed.len)
		dat += "No body types available for this race.<br>"
	else
		for(var/id in allowed)
			var/datum/body_type/BT = get_body_type(id)
			if(!BT) continue
			var/mark = (body_type == id) ? "&#10003; " : ""
			dat += "[mark]<a href='?_src_=prefs;preference=bodytype;task=set;body_type=[id]'>[BT.name]</a><br>"

	dat += "<br><a href='?_src_=prefs;preference=back_to_main'>Back</a>"

	var/datum/browser/popup = new(user, "preferences_browser", "<div align='center'>Character Sheet</div>", 700, 650)
	popup.set_window_options(can_close = TRUE)
	popup.set_content(dat.Join())
	popup.open(FALSE)
