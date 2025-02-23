/mob/living/simple_animal/hostile/retaliate/rogue/gator
	icon = 'icons/roguetown/mob/monster/gator.dmi'
	name = "gator"
	desc = "Vicious and patient creachers; tales have been told of passersby being grabbed and dragged underwater, never to be seen again."
	icon_state = "gator"
	icon_living = "gator"
	icon_dead = "gator-dead"

	faction = list("gators") // to-do
	turns_per_move = 4
	move_to_delay = 2
	vision_range = 5
	aggro_vision_range = 5
	
	// One of these daes, they'll drop Gator leather
	botched_butcher_results = list(/obj/item/reagent_containers/food/snacks/rogue/meat/mince = 1)
	butcher_results = list(/obj/item/reagent_containers/food/snacks/rogue/meat/mince = 1,
						/obj/item/alch/bone = 2)
	perfect_butcher_results = list(/obj/item/reagent_containers/food/snacks/rogue/meat/steak = 1,
						/obj/item/alch/sinew = 1,
						 /obj/item/alch/bone = 4)

	health = GATOR_HEALTH // to-do
	maxHealth = SPIDER_HEALTH // to-do
	food_type = list(/obj/item/bodypart,
					/obj/item/organ,
					/obj/item/reagent_containers/food/snacks/rogue/meat)

	base_intents = list(/datum/intent/simple/bite)
	attack_sound = list('sound/vo/mobs/gator/attack (1).ogg','sound/vo/mobs/gator/attack (2).ogg','sound/vo/mobs/gator/attack (3).ogg','sound/vo/mobs/gator/attack (4).ogg') // to-do
	melee_damage_lower = 17
	melee_damage_upper = 22

	TOTALCON = 6
	TOTALSTR = 10
	TOTALSPD = 10

	retreat_distance = 0
	minimum_distance = 0
	deaggroprob = 0
	defprob = 35
	defdrain = 5
	attack_same = FALSE
	retreat_health = 0.2

	aggressive = TRUE
	stat_attack = UNCONSCIOUS
	body_eater = TRUE

	ai_controller = /datum/ai_controller/troll // to-do
	AIStatus = AI_OFF
	can_have_ai = FALSE

// to-do
/*
/mob/living/simple_animal/hostile/retaliate/rogue/spider/mutated
	icon = 'icons/roguetown/mob/monster/spider.dmi'
	name = "skallax spider"
	icon_state = "skallax"
	icon_living = "skallax"
	icon_dead = "skallax-dead"

	health = SPIDER_HEALTH+10
	maxHealth = SPIDER_HEALTH+10

	base_intents = list(/datum/intent/simple/bite)
*/

/mob/living/simple_animal/hostile/retaliate/rogue/gator/Initialize()
	. = ..()
	gender = MALE
	if(prob(33))
		gender = FEMALE
	update_icon()

	AddElement(/datum/element/ai_flee_while_injured, 0.75, retreat_health)
	ai_controller.set_blackboard_key(BB_BASIC_FOODS, food_type)
	//ADD_TRAIT(src, TRAIT_WEBWALK, TRAIT_GENERIC) // to-do

// dunno if this is needed to function
/*
/mob/living/simple_animal/hostile/retaliate/rogue/gator/AttackingTarget()
	. = ..()
	if(. && isliving(target))
		var/mob/living/L = target
		if(L.reagents)
			L.reagents.add_reagent(/datum/reagent/toxin/venom, 1)
*/

/mob/living/simple_animal/hostile/retaliate/rogue/gator/find_food()
	. = ..()
	if(!.)
		return eat_bodies()

/mob/living/simple_animal/hostile/retaliate/rogue/gator/death(gibbed)
	..()
	update_icon()


/mob/living/simple_animal/hostile/retaliate/rogue/gator/update_icon()
	cut_overlays()
	..()
	if(stat != DEAD)
		var/mutable_appearance/eye_lights = mutable_appearance(icon, "gator-eyes") // to-do
		eye_lights.plane = 19
		eye_lights.layer = 19
		add_overlay(eye_lights)

/mob/living/simple_animal/hostile/retaliate/rogue/gator/get_sound(input)
	switch(input)
		if("aggro")
			return pick('sound/vo/mobs/gator/aggro (1).ogg','sound/vo/mobs/gator/aggro (2).ogg','sound/vo/mobs/gator/aggro (3).ogg','sound/vo/mobs/gator/aggro (4).ogg')
		if("pain")
			return pick('sound/vo/mobs/gator/pain.ogg')
		if("death")
			return pick('sound/vo/mobs/gator/death.ogg')
		if("idle")
			return pick('sound/vo/mobs/gator/idle (1).ogg','sound/vo/mobs/gator/idle (2).ogg','sound/vo/mobs/gator/idle (3).ogg','sound/vo/mobs/gator/idle (4).ogg')

/mob/living/simple_animal/hostile/retaliate/rogue/gator/taunted(mob/user)
	emote("aggro")
	Retaliate()
	GiveTarget(user)
	return

// unsure whether to do anything with this
/*
/mob/living/simple_animal/hostile/retaliate/rogue/gator/Life() 
	..()
	if(stat == CONSCIOUS)
		if(!target)
			if(production >= 100)
				production = 0
				visible_message("<span class='alertalien'>[src] creates some honey.</span>")
				var/turf/T = get_turf(src)
				playsound(T, pick('sound/vo/mobs/spider/speak (1).ogg','sound/vo/mobs/spider/speak (2).ogg','sound/vo/mobs/spider/speak (3).ogg','sound/vo/mobs/spider/speak (4).ogg'), 100, TRUE, -1)
				new /obj/item/reagent_containers/food/snacks/spiderhoney(T)
	if(pulledby && !tame)
		if(HAS_TRAIT(pulledby, TRAIT_WEBWALK))
			return
		Retaliate()
		GiveTarget(pulledby)
*/

/mob/living/simple_animal/hostile/retaliate/rogue/gator/simple_limb_hit(zone)
	if(!zone)
		return ""
	switch(zone)
		if(BODY_ZONE_PRECISE_R_EYE)
			return "head"
		if(BODY_ZONE_PRECISE_L_EYE)
			return "head"
		if(BODY_ZONE_PRECISE_NOSE)
			return "snout"
		if(BODY_ZONE_PRECISE_MOUTH)
			return "mouth"
		if(BODY_ZONE_PRECISE_SKULL)
			return "head"
		if(BODY_ZONE_PRECISE_EARS)
			return "head"
		if(BODY_ZONE_PRECISE_NECK)
			return "neck"
		if(BODY_ZONE_PRECISE_L_HAND)
			return "foreleg"
		if(BODY_ZONE_PRECISE_R_HAND)
			return "foreleg"
		if(BODY_ZONE_PRECISE_L_FOOT)
			return "leg"
		if(BODY_ZONE_PRECISE_R_FOOT)
			return "leg"
		if(BODY_ZONE_PRECISE_STOMACH)
			return "stomach"
		if(BODY_ZONE_PRECISE_GROIN)
			return "tail"
		if(BODY_ZONE_HEAD)
			return "head"
		if(BODY_ZONE_R_LEG)
			return "leg"
		if(BODY_ZONE_L_LEG)
			return "leg"
		if(BODY_ZONE_R_ARM)
			return "foreleg"
		if(BODY_ZONE_L_ARM)
			return "foreleg"
	return ..()
