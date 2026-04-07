/datum/faith/abyssanctum
	name = "\improper Abyssanctum"
	desc = "The religion of Fog Islanders, devoted to seek sanctity through purification \
	as the supreme tide against demonic taint, concepting the world's filter, said that the soul can reach \
	sanctity and be stripped away from the cycle of death as thalassic spirits, or be reincarnated by holy tides. \
	The abyssanctum have three expressions of resonance with Abyssor's thalassic angels, and they differ from \
	pantheon's abyssorites, with a more down-to-earth structure and mutual bind to the oceanic realm rather than hunting it down."
	godhead = /datum/patron/abyssanctum/purifier //All the doctrines are equals.

/datum/patron/abyssanctum
	name = null
	associated_faith = /datum/faith/abyssanctum

	profane_words = list()
	confess_lines = list(
		"ONLY ABYSSOR STAYS ON THE THRONE OF WORLD ORDER!",
		"THE WEEPER TEARS DEFINED THE TRUE FAITH BEFORE THE PANTHEON'S CREATION!",
		"PRAISE ABYSSOR AND THE TIDES OF FATE!"
	)

/datum/patron/abyssanctum/can_pray(mob/living/follower)
	var/turf/T = get_turf(follower)

	if(istype(T, /turf/open/water/sewer) || istype(T, /turf/open/water/bath))
		to_chat(follower, span_danger("Rites of reverence are not for places of decay."))
		return FALSE
	if(istype(T, /turf/open/water))
		return TRUE

	to_chat(follower, span_danger("My voice can only reach The Great Whale and his angels on watery tides."))
	return FALSE

/datum/patron/abyssanctum/purifier
	name = "Purifier Doctrine"
	domain = "Abyssor, mutual to Quintessential the Nautilus, focused on the spiritual."
	desc = "Purifiers act as the intermediaries of spirits and must hear \
			the splinters of the tides of fate found on dreams. Warnings demand change \
			just as much as purifications into the spiritual realm. \
			Restless souls seek salvation from twisted fates, \
			as no spirit deserves derailment on deadside's realm."
	flaws= "Reckless, Stubborn, Destructive - Intolerant"
	worshippers = "Exorcists, talisman makers, survivors of demonic incursions. The Shrinekeepers."
	sins = "Fear, Hubris, Forgetfulness - Hesitation"
	boons = "Purifier Bulwark. You directly resist corruptive influence, spiritual or not. Your rituals branches exorcisms and dream guidance."
	added_traits = list(TRAIT_PURIFIER_BULWARK, TRAIT_KAIZOKU) //Leech Immune will change later.
	devotion_holder = /datum/devotion/abyssanctum/purifier
	confess_lines = list(
		"ABYSSOR COMMANDS THE WAVES!",
		"THE OCEAN'S FURY IS ABYSSOR'S WILL!",
		"I AM DRAWN BY THE PULL OF THE TIDE!",
		"I CLEANSE THIS LAND BY BLADE AND FURY!",
		"THE CORRUPTION HIDES FROM ME!",
		"YOU SHALL BE UNDONE FOR YOUR AUDACITY!",
	)
	storyteller = /datum/storyteller/abyssor //perhaps make a edit in which demons are weaker as they spawn.

/datum/devotion/abyssanctum/purifier
	miracles = list(
		CLERIC_T0 = /datum/action/cooldown/spell/abyssal_heal,
		CLERIC_T1 = /datum/action/cooldown/spell/purify,
		CLERIC_T2 = /datum/action/cooldown/spell/abyssal_tether,
		CLERIC_T3 = /datum/action/cooldown/spell/barotrauma,
	)

/datum/patron/abyssanctum/curator
	name = "Curator Doctrine"
	domain = "Abyssor, mutual to Petrichor, the Cthonic Squid, focused on the mind."
	desc = "Bound to the ways of Petrichor, we must regard \
			wisdom as the pathway to salvation that overlaps evil, \
			censorship of purity is dissent, but sinful perceptions \
			must be purged. The purity of the mind must be restored, \
			as for every sickness of thought is feed for Zizo."
	flaws = "Reckless, Stubborn, Destructive - Overtrusting"
	worshippers = "The common folk, storytellers, ship doctors and educators. The Curators."
	sins = "Fear, Hubris, Forgetfulness - Intellectual arrogance"
	boons = "Champion's Knowledge. Waters provides more quality and ways of warfare. Your rituals branches blessings."
	added_traits = list(TRAIT_CHAMPION_KNOWLEDGE, TRAIT_KAIZOKU) //Leech Immune will change later.
	devotion_holder = /datum/devotion/abyssanctum/curator
	confess_lines = list(
		"ABYSSOR COMMANDS THE WAVES!",
		"THE OCEAN'S FURY IS ABYSSOR'S WILL!",
		"I AM DRAWN BY THE PULL OF THE TIDE!",
		"WISDOM WILL NEVER DIE!",
		"GATHER THE LORE!",
		"I AM THE STORM THAT IS APPROACHING!",  //I'm keeping this. It fits. Go away.
	)
	storyteller = /datum/storyteller/abyssor

/datum/devotion/abyssanctum/curator
	miracles = list(
		CLERIC_T0 = /datum/action/cooldown/spell/abyssal_heal,
		CLERIC_T1 = /datum/action/cooldown/spell/chain_of_torment,
		CLERIC_T2 = /datum/action/cooldown/spell/veil_of_spirits,
		CLERIC_T3 = /datum/action/cooldown/spell/revival_spark
	)

/datum/patron/abyssanctum/tideweaver
	name = "Tideweaver Doctrine"
	domain = "Abyssor, mutual to Syzygy the Sky Serpent, focused on the physical."
	desc = "Guardians of filtering, what shields the body \
			from rot unseen. Uphold the status quo of flesh and steel, \
			heal the flawed, shatter the irredeemable, eat the mutant, \
			as for every untreated disease or forced deformation, a failure. \
			Salvation lies in uprooting harm without leaving ruins behind."
	flaws = "Reckless, Stubborn, Destructive - Unyielding"
	worshippers = "Abyssal Warriors, Sea raiders, Generals. The Tideweavers."
	sins = "Fear, Hubris, Forgetfulness - Disobedience"
	boons = "Soulside Connection. You can feel the presence of heretics. Your rituals branches sacrifices."
	devotion_holder = /datum/devotion/abyssanctum/tideweaver
	added_traits = list(TRAIT_SOULSIDE_CONNECTION, TRAIT_KAIZOKU) //Leech Immune will change later.
	confess_lines = list(
		"ABYSSOR COMMANDS THE WAVES!",
		"THE OCEAN'S FURY IS ABYSSOR'S WILL!",
		"I AM DRAWN BY THE PULL OF THE TIDE!",
		"SNATCH THE PEBBLE FROM MY HAND, GRASSHOPPER!", //I'm keeping this. It fits. Go away.
		"I OBEY ONLY THE MANIFESTATIONS OF THE DEEP!",
		"DISCIPLINE IS THE TRUE GREAT HARBOR!",
	)
	storyteller = /datum/storyteller/abyssor

/datum/devotion/abyssanctum/tideweaver
	miracles = list(
		CLERIC_T0 = /datum/action/cooldown/spell/abyssal_heal,
		CLERIC_T1 = /datum/action/cooldown/spell/chain_of_torment,
		CLERIC_T2 = /datum/action/cooldown/spell/veil_of_spirits,
		CLERIC_T3 = /datum/action/cooldown/spell/revival_spark,
	)

#define ALL_ABYSSANCTUM_DOCTRINE list(/datum/patron/abyssanctum/purifier, /datum/patron/abyssanctum/curator, /datum/patron/abyssanctum/tideweaver)

/datum/patron/abyssanctum/silent
	name = "Silent Doctrine"
	domain = "WIP"
	flaws = "Reckless, Stubborn, Destructive, Indecise"
	worshippers = "."
	sins = "Fear, Hubris, Forgetfulness"
	boons = "None."
	added_traits = list(TRAIT_KAIZOKU) //Leech Immune will change later.
	devotion_holder = /datum/devotion/abyssanctum/silent
	confess_lines = list(
		"ABYSSOR COMMANDS THE WAVES!",
		"THE OCEAN'S FURY IS ABYSSOR'S WILL!",
		"I AM DRAWN BY THE PULL OF THE TIDE!",
	)
	storyteller = /datum/storyteller/abyssor

/datum/devotion/abyssanctum/silent
	miracles = list(
	)

/*
GLOBAL_LIST_INIT(abyssanctum_speak, world.file2list('strings/rt/abyssanctum_speak.txt'))

/datum/emote/living/pray/run_emote(mob/user, params, type_override, intentional)
	. = ..()

	if(istype(patron, /datum/patron/abyssanctum))
		if(GLOB.abyssanctum_speak && length(GLOB.abyssanctum_speak))
			var/abyssangel = pick(GLOB.abyssanctum_speak)
			to_chat(follower, span_notice("<i>[abyssangel]</i>"))
*/
