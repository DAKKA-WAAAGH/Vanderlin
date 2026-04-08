// IDEA: Core idea for this role revamp.
// Shrinekeepers are an direct revamped version of the Ravox Monk,
// They can never use weapons, not even polearms, and have slightly weaker stats compared to Monks.
// Infact, they are 'trainees', so they have to train their skills. Unarmed/grappling skill increases chances.
// The 'master' role is the abyssanctum version of the priest, the only one at highest capacity.
// However, they have the aspect of having an actual perk that allows them to be ACTUALLY effective warrior.
// As long the player manages to master the unarmed combat of this role, that is.

// Important aspects:
// -> Anti-undressing:
//     while on Combat Mode. Will instantly attack anyone trying to undress them.
//     Exception given when their hands are occupied (handcuffed) or unconscious.
// -> Wrist Nerve Strike:
//     6-seconds cooldown, 3 seconds effect. If the enemy holds an item and there is a disarm on the enemy's
// 	   'precise hand', a nerve will be striked, and the enemy cannot attack with said hand for a short moment. They can swap hands.
// -> Pivoting Disarm:
//     Grasp with one hand + Shove with another = Disarming, while instantly moving towards the enemy's behind.
//     If done against a limb rather than 'precisely hands', have a chance of instantly undressing the enemy's armor.
//     The chance is relatively low (22%) so the user needs to do it often for it to work. But it CAN.
// -> Target Enemy:
//      Use 'punch' with a right mouse click. Instead of beckoning them over aggressively in a insult, the player will be targetted.
//      Targetting is used for future moves, and also be a warning state for the enemy to be wary.
// 		Targetting is essentially the foundation of most of the functionalities on this code.
//      Active target is lost if they leave the range.
// -> Palm shock:
// 		Combat Mode + Aiming Chest + Shove on targetted enemy
// 		A forceful palm strike, causes minor knockback of one tile, if lose a const check, may cause off-balancing.
//      3-seconds cool down. Very low damage.
// -> Flying Scissor Takedown:
//     Run + Jump + Aiming legs = Both fall, but now you are 'aggressively grabbed' with the enemy's legs.
// -> Dempsey Roll = Combat Mode + Both hands Empty + User has moved at least 2-3 tiles in short succession towards
//     a targetted player; Player will start 'weaving' and gain slight dodge/parry bonus, and
//     after being attacked once, will apply 'gut punch' automatically on the enemy,
//     which will directly cause stamina damage and pain.
// -> Solar Plexus Blow => Enemy is off-balanced or stunned; Aiming at stomach.
//     Instantly causes short breathloss and speed slowdown, heavy stamina damage. Chance to make the enemy to fall.
//     If protected by armor superior to 40% blunt(10% punching power), nothing happened, unless using gloves to unlock more punching power.
//     If lose a constitution save, will have a short shock-induced seizure, as previously coded.
// -> Muzzle Clamp:
// 	   Mouth grab on a targetted beast NPC, will stop them from biting/basic attacks while they remain grabbed. Functional against volfs.
// => Jaw Splitter:
//     Done after muzzle clamp. Severe basic enemy damage. Forced stun to the NPC that we handle ourselves.
// => Spine Breaker:
//     Attacks the enemy from behind after targeted. Aim chest. Fuck 'em up, john. Chance to instantly paralyze the enemy, or severely damage them.
// => Sweep Kick
//     Kick + Legs.
//     Enemy is off-balanced or winded. If successful in the check, it will knock the enemy to the ground.
//     If failure, the enemy will be only more off-balanced.
// => Sweep Kick
//     Kick + Legs.
//     Enemy is off-balanced or winded. If successful in the check, it will knock the enemy to the ground.
//     If failure, the enemy will be only more off-balanced.
// => Axe kick
//     Enemy is prone. A downwards kick keeps their stun longer. On chest it deals stamina damage, on head dazes and makes their vision go black.
//     On limbs causes movement paralization.
// =>Shoulder throw
//     Aggressive grab on a targetted player, and simply shove on their stomach. After this is done,
//     the user will throw the enemy behind them, and into two valid destination tiles. Full-on falling down + stun.
//     Might end up getting on someone else, or wall, which means more damage. (For both)

/datum/advclass/combat/sk/abyss/shrinekeepers //Low-abyssanctum role, but its efficiency requires champion-tier levels entirely because of unarmed skills. They are NOT champions.
	name = "Shrinekeeper"
	allowed_sexes = list(MALE, FEMALE)
	tutorial = "The shrines needs to be cared of, and there is no one most suitable for such duty than the purifier branch. \
	Those who knows the art of folding clothes while people are still in them. The Involuntary Yoga Practicers. Bokh and Bajutsu.\
	They perform rituals to submit demonic spirits just as much they submit mortals with martial arts."
	allowed_races = list(
	"Changeling",
	"Skylancer",
	"Ogrun",
	"Undine")
	outfit = /datum/outfit/job/sk/adventurer/abyss/shrinekeepers
	category_tags = list(CTAG_ADVENTURER)
	vampcompat = FALSE
	pickprob = 100

/datum/outfit/job/sk/adventurer/abyss/shrinekeepers
	allowed_patrons = list(/datum/patron/divine/abyssor)

/datum/outfit/job/sk/adventurer/abyss/shrinekeepers/pre_equip(mob/living/carbon/human/H)
	..()
	neck = /obj/item/clothing/neck/psycross/silver/abyssanctum
	shoes = /obj/item/clothing/shoes/sandals/geta
	wrists = /obj/item/clothing/wrists/bracers/leather
	belt = /obj/item/storage/belt/leather/rope
	beltr = /obj/item/storage/belt/pouch/coins/poor
	backl = /obj/item/storage/backpack/backpack
	backr = /obj/item/weapon/polearm/woodstaff/quarterstaff/bostaff

	var/yesno = list("I wander and meditate.","I build shrines for Abyssor.")
	var/monk = input("Wayfarer or Settler?", "Wayfarer or Settler?") as anything in yesno
	switch(monk) //Just clothes.
		if("I wander and meditate.")
			head = /obj/item/clothing/head/takuhatsugasa
			cloak = /obj/item/clothing/cloak/raincloak/mino
			shirt = /obj/item/clothing/shirt/rags/monkgarb/random
			H.adjust_skillrank(/datum/skill/misc/medicine, 1, TRUE)
			H.set_blindness(0)
		if("I build shrines for Abyssor.")
			armor = /obj/item/clothing/shirt/robe/shrinekeeper
			shirt = /obj/item/clothing/shirt/tunic/kimono/random
			wrists = /obj/item/clothing/wrists/shrinekeeper
			H.adjust_skillrank(/datum/skill/craft/carpentry, 1, TRUE) //They lose 'Medicine' to have 'Carpetry', because Shrinekeepers... repair shrines.
			H.set_blindness(0)

	H.adjust_skillrank(/datum/skill/misc/reading, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/unarmed, 4, TRUE)
	H.adjust_skillrank(/datum/skill/combat/wrestling, 5, TRUE)
	H.adjust_skillrank(/datum/skill/combat/polearms, pick(1,1,2), TRUE) // Wood staff
	H.adjust_skillrank(/datum/skill/misc/sewing, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/athletics, pick(2,2,3), TRUE)

	H.change_stat(STATKEY_STR, 3)
	H.change_stat(STATKEY_PER, -1)
	H.change_stat(STATKEY_CON, 2)
	H.change_stat(STATKEY_END, 2)
	H.change_stat(STATKEY_SPD, 1)

	ADD_TRAIT(H, TRAIT_DODGEEXPERT, TRAIT_GENERIC)
