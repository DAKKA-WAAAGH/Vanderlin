// The split between citizen types are simple and straightforward;
// City citizens lives in safety, working mundane jobs that avoids conflict in all ways possible.
// They are not trained for combat, and the skills should ALWAYS reflect that.
// Foresters are a special type, skillfull in SURVIVAL and COMBAT, but below guards and way below soldiers.
// Just as much they have self-defense weapons and cheap armor. They have a chance to not be pushovers.
// Of course, they lack combat perks and have main stats similar to civilians, but at least they have skills.
// In contrast, low-lives are outcasts that thrives on chaos, yet does not have actual combat training.
// At least mostly - since some are antagonistic, or 'almost' antagonistic.
// So they must rely on special abilities and tricks to spice up a round without being combat.


/datum/job/advclass/forester
	title = "Forester"
	tutorial = "You've been privileged by decree or entrusted by bloodline to take \
	dominion over the forests and far away lands, granted rights to hunt and harvest \
	where others cannot do such lawfully. Stay together with other foresters and handle \
	your activities with care, as you might be the first to be attacked by bandits or \
	invasion forces. At least, you are stronger than the average citizen."
	allowed_sexes = list(MALE, FEMALE)
	category_tags = list(CTAG_FORESTER)
	cmode_music = 'sound/music/cmode/towner/CombatBeggar.ogg'
	allowed_ages = ALL_AGES_LIST_BLOOMING

/datum/job/advclass/forester/timbercollier
	title = "Timber Collier"
	tutorial = "You've been treating Dendor's children with the care it deserves, \
	at the edge of an axe and the fire of an kiln, turning the living into the useful. \
	Of course, people requires wood as it is, other needs potash for glass, others need \
	fuel for their forges, and by all ways, you cut it all down as the dendorite \
	refugees calls you bloody murderer. That's a compliment for your goob job."
	outfit = /datum/outfit/advclass/forester/timbercollier
	category_tags = list(CTAG_FORESTER)

/datum/outfit/advclass/forester/timbercollier
	head = /obj/item/clothing/head/headband/makers
	pants = /obj/item/clothing/pants/tights/makers
	shoes = /obj/item/clothing/shoes/shortboots
	belt = /obj/item/storage/belt/leather
	cloak = /obj/item/clothing/cloak/apron/makers
	backl = /obj/item/weapon/axe/iron  // Lumberjack tool
	shirt = /obj/item/clothing/shirt/shortshirt/makers
	neck = /obj/item/storage/belt/pouch/coins/poor
	gloves = /obj/item/clothing/gloves/leather

/datum/outfit/advclass/forester/timbercollier/pre_equip(mob/living/carbon/human/H)
	..()
	if(H.mind)
		H.adjust_skillrank(/datum/skill/combat/axesmaces, 3, TRUE) //Foresters are stronger.
		H.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
		H.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
		H.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
		H.adjust_skillrank(/datum/skill/craft/crafting, 2, TRUE)
		H.adjust_skillrank(/datum/skill/craft/smelting, 4, TRUE)  //So they can freely smelt things. Coal making business too.
		H.adjust_skillrank(/datum/skill/labor/lumberjacking, 3, TRUE)  //Lumberjack skills
		H.adjust_skillrank(/datum/skill/craft/carpentry, 2, TRUE)  //Timbercolliers are fine with being carpenters.
		H.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
		H.adjust_skillrank(/datum/skill/craft/alchemy, 1, TRUE)  //For potash making, of course.
		ADD_TRAIT(H, TRAIT_MALUMFIRE, TRAIT_GENERIC)
		if(H.age == AGE_OLD)
			H.adjust_skillrank(/datum/skill/craft/smelting, pick(0,1), TRUE)
	H.change_stat("strength", 1)
	H.change_stat("constitution", 1)

/datum/job/advclass/forester/pathfinder
	title = "Pathfinder"
	tutorial = "You are a pathfinder, venturing into the forests to harvest resin for shipbuilding, set traps, and hunt animals for meat. \
	Your knowledge of the woods helps you survive and provide resources to the community."
	outfit = /datum/outfit/advclass/forester/pathfinder
	category_tags = list(CTAG_FORESTER)

/datum/outfit/advclass/forester/pathfinder
	head = /obj/item/clothing/head/roguehood/colored/green
	shirt = /obj/item/clothing/shirt/undershirt/colored/green
	pants = /obj/item/clothing/pants/tights/colored/green
	shoes = /obj/item/clothing/shoes/shortboots
	belt = /obj/item/storage/belt/leather
	cloak = /obj/item/clothing/cloak/raincloak/colored/green
	backl = /obj/item/weapon/bow/shortbow
	beltr = /obj/item/weapon/knife/hunting
	neck = /obj/item/storage/belt/pouch/coins/poor

/datum/outfit/advclass/forester/pathfinder/pre_equip(mob/living/carbon/human/H)
	..()
	if(H.mind)
		H.adjust_skillrank(/datum/skill/combat/bows, 3, TRUE) //Foresters are stronger.
		H.adjust_skillrank(/datum/skill/combat/knives, 3, TRUE)
		H.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
		H.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
		H.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
		H.adjust_skillrank(/datum/skill/misc/sneaking, 3, TRUE)
		H.adjust_skillrank(/datum/skill/craft/traps, 3, TRUE)
		H.adjust_skillrank(/datum/skill/craft/crafting, 2, TRUE)
		H.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
		H.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
		H.adjust_skillrank(/datum/skill/misc/swimming, 1, TRUE)
		ADD_TRAIT(H, TRAIT_FORAGER, TRAIT_GENERIC)
		if(H.age == AGE_OLD)
			H.adjust_skillrank(/datum/skill/misc/sneaking, 1, TRUE)
	H.change_stat("perception", 2)
	H.change_stat("speed", 1)

/datum/job/advclass/forester/waterswayer
	title = "Waterswayer"
	tutorial = "You've been working around and about rivers and streams all your life, \
	be it in spiritual means or practical ones, your work provides foods and materials \
	to the society, and under imperial law, protein intake has been mandatory for decades, \
	so you fish, forage and gather herbs so the community can thrive."
	category_tags = list(CTAG_FORESTER)

/datum/outfit/advclass/forester/waterswayer
	head = /obj/item/clothing/head/roguehood/colored/blue
	shirt = /obj/item/clothing/shirt/undershirt/colored/blue
	pants = /obj/item/clothing/pants/tights/colored/blue
	shoes = /obj/item/clothing/shoes/shortboots
	belt = /obj/item/storage/belt/leather
	cloak = /obj/item/clothing/cloak/raincloak/colored/blue
	backl = /obj/item/weapon/fishingrod
	beltr = /obj/item/weapon/knife
	neck = /obj/item/storage/belt/pouch/coins/poor

/datum/outfit/advclass/forester/waterswayer/pre_equip(mob/living/carbon/human/H)
	..()
	if(H.mind)
		H.adjust_skillrank(/datum/skill/combat/knives, 1, TRUE)
		H.adjust_skillrank(/datum/skill/misc/athletics, 1, TRUE)
		H.adjust_skillrank(/datum/skill/misc/swimming, 3, TRUE)
		H.adjust_skillrank(/datum/skill/craft/crafting, 2, TRUE)
		H.adjust_skillrank(/datum/skill/labor/fishing, 4, TRUE)
		H.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
		H.adjust_skillrank(/datum/skill/misc/climbing, 1, TRUE)
		H.adjust_skillrank(/datum/skill/craft/alchemy, 1, TRUE)  // For herbs.
		ADD_TRAIT(H, TRAIT_FORAGER, TRAIT_GENERIC)
		if(H.age == AGE_OLD)
			H.adjust_skillrank(/datum/skill/labor/fishing, 1, TRUE)
	H.change_stat("perception", 1)
	H.change_stat("endurance", 1)
