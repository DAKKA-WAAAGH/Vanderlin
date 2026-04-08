
// Fleshrippers - originals from Kaizoku.
// The idea is, essentially, a persistent brute damage dealer that won't cause bleeding.
// In the future, we will be able to use it to stitch wounds with a better "Less medicine skill-to-effectiveness ratio."
// Won't make a huge different if you have the skill, so in these cases, stick to the standard ways.
// however, may bring infections (when we code these) and it is more difficult to get.
// The tamed version should aid in pest control for plants, without biting people.
// This might have greater importance for 'Divine seeds' systems I've been thinking about.

/// chance_modifier_type options:
#define INFESTATION_MODIFIER_NONE 0       // No movement-based modifiers
#define INFESTATION_MODIFIER_MOVEMENT 1   // Apply movement intent modifiers (for ticks)

/// Standard embedding configuration for parasitic fauna
#define PARASITIC_EMBEDDING list(\
	"embed_chance" = 100,\
	"embedded_unsafe_removal_time" = 0,\
	"embedded_pain_chance" = 0,\
	"embedded_fall_chance" = 0,\
	"embedded_bloodloss" = 0)

/obj/item/natural/worms/parasitic
	embedding = PARASITIC_EMBEDDING
	/// Time this parasite can stay attached before dropping off. Zero disables timeout.
	var/max_embed_duration = 0
	/// World time when this parasite should detach, if timed.
	var/embed_expire_time = 0

/obj/item/natural/worms/parasitic/embedded(atom/embedded_target, obj/item/bodypart/part)
	. = ..()
	if(max_embed_duration)
		embed_expire_time = world.time + max_embed_duration

/obj/item/natural/worms/parasitic/unembedded(mob/living/owner)
	. = ..()
	embed_expire_time = 0
	if(!QDELETED(src))
		addtimer(CALLBACK(src, PROC_REF(handle_detached_cleanup)), 1)

/obj/item/natural/worms/parasitic/dropped(mob/user, silent = FALSE)
	. = ..()
	if(QDELETED(src))
		return
	addtimer(CALLBACK(src, PROC_REF(handle_detached_cleanup)), 1)

/obj/item/natural/worms/parasitic/proc/handle_detached_cleanup()
	if(QDELETED(src))
		return
	if(ismob(loc))
		return
	qdel(src)

/obj/item/natural/worms/parasitic/proc/embed_duration_expired()
	return (embed_expire_time && world.time >= embed_expire_time)

/obj/item/natural/worms/parasitic/proc/detach_from_host(mob/living/user, obj/item/bodypart/bodypart)
	if(bodypart)
		bodypart.remove_embedded_object(src)
		return TRUE
	if(user)
		user.simple_remove_embedded_object(src)
		return TRUE
	return FALSE

/obj/item/natural/worms/ant
	parent_type = /obj/item/natural/worms/parasitic
	name = "Wild fleshripper"
	desc = "Native little creacher that aids in suturing wounds and killing pests. \
	This wild crawler is wild and aggressive."
	icon = 'modular/kaizoku/icons/mapset/florafauna.dmi'
	icon_state = "ant"
	baitpenalty = 0
	isbait = FALSE
	fishloot = null
	var/bite_damage = 5
	var/itch_cooldown = 5 SECONDS
	var/next_msg_time = 0
	max_embed_duration = 2 MINUTES

/obj/item/natural/worms/ant/on_embed_life(mob/living/user, obj/item/bodypart/bodypart) //Later on, add "Allergy" perk reaction.
	if(!user || !bodypart)
		return FALSE
	if(embed_duration_expired())
		detach_from_host(user, bodypart)
		return TRUE
	if(world.time >= next_msg_time) //Perhaps later, we will make 'insect sensitive' perk.
		if(bite_damage)
			bodypart.receive_damage(bite_damage, 5) //Small ouchie. Ants ain't well know for killing people.
		var/list/pain_messages = list(
			"ARGH! Something has stung me!",
			"OW! Something bit me!?",
			"GAH! I feel a sharp pain!",
			"ACK! Something's biting into my flesh!",
			"UGH! There's something crawling under my clothes!",
			"OUCH! Sharp teeth digs into my skin!" //Yes. I know it's mandibles, fck off.
		)
		to_chat(user, "<span class='warning'>[pick(pain_messages)]</span>")
		next_msg_time = world.time + itch_cooldown //Exists only to prevent spamming messages
	return FALSE

/obj/structure/anthill
	name = "wild crawler hive"
	desc = "A busy dirt mound filled of wild fleshrippers."
	icon = 'modular/kaizoku/icons/mapset/florafauna.dmi'
	icon_state = "anthill"
	anchored = TRUE
	density = TRUE
	max_integrity = 300 //Make them struggle to break these. Might just make the crawler hive respawn after a day, on the same spot.

/obj/structure/anthill/Initialize()
	. = ..()
	AddComponent(/datum/component/infestation_aura, /obj/item/natural/worms/ant, chance = 12, cooldown = 40, radius = 6)


// Kaizoku Original; A blood-drainer.
// Similar to the leech, but does not heal at all.
// All it does, is just drains player's blood.
// Found in every grass with low chance - the description gives the idea of it being a invasive species.
// It will just 'disappear' when dropped.
// Cannot be used as bait. Should HOPEFULLY cause diseases in the future.

/obj/item/natural/worms/tick
	parent_type = /obj/item/natural/worms/parasitic
	name = "tick"
	desc = "Bothersome disease-bringer not native to Fog Islands, the symbol of the first invasion done by grenzelhoft."
	icon = 'modular/kaizoku/icons/mapset/florafauna.dmi'
	icon_state = "tick"
	baitpenalty = 0
	isbait = FALSE
	fishloot = null
	color = null
	var/blood_succ = 1
	/// Total blood this tick can drain before it drops off.
	var/max_blood_drain = 25
	/// Running total of blood drained from the current host.
	var/total_blood_drain = 0
	var/itch_chance = 10
	var/itch_cooldown = 25
	var/next_msg_time = 0
	max_embed_duration = 3 MINUTES

/obj/item/natural/worms/tick/embedded(atom/embedded_target, obj/item/bodypart/part)
	total_blood_drain = 0
	return ..()

/obj/item/natural/worms/tick/on_embed_life(mob/living/user, obj/item/bodypart/bodypart)
	if(!user || !bodypart)
		return FALSE
	if(embed_duration_expired())
		detach_from_host(user, bodypart)
		return TRUE

	var/drain = blood_succ
	if(HAS_TRAIT(user, TRAIT_LEECHIMMUNE))
		drain *= 0.05

	var/actual_drain = min(user.blood_volume, drain)
	user.blood_volume = max(user.blood_volume - actual_drain, 0)
	total_blood_drain += actual_drain

	if(world.time >= next_msg_time)
		if(prob(itch_chance))
			var/list/itch_messages = list(
				"Your [bodypart.name] itches...",
				"You feel something crawling on your [bodypart.name]...",
				"Your [bodypart.name] feels irritated...",
				"There's an annoying itch on your [bodypart.name]...",
				"Your [bodypart.name] tingles uncomfortably..."
			)
			to_chat(user, "<span class='notice'>[pick(itch_messages)]</span>")
		next_msg_time = world.time + itch_cooldown

	if(total_blood_drain >= max_blood_drain || user.blood_volume <= 0)
		detach_from_host(user, bodypart)
		return TRUE

	return FALSE

/datum/component/tick_infested
	var/tick_chance = 3
	var/tick_cooldown = 70
	var/next_infest_time = 0

/datum/component/tick_infested/Initialize(chance = 3, cooldown = 70)
	tick_chance = clamp(chance, 0, 100)
	tick_cooldown = max(0, cooldown)
	RegisterSignal(get_turf(parent), COMSIG_ATOM_ENTERED, PROC_REF(on_mob_entered))
	return ..()

/datum/component/tick_infested/Destroy()
	UnregisterSignal(get_turf(parent), COMSIG_ATOM_ENTERED)
	return ..()

/datum/component/tick_infested/proc/on_mob_entered(turf/source, atom/movable/arrived, atom/old_loc)
	if(world.time < next_infest_time)
		return

	var/mob/living/carbon/C = try_get_valid_target(arrived)
	if(!C)
		return

	var/chance_modifier = calculate_chance_modifier(C)

	if(!prob(chance_modifier))
		return

	infest_target(C)
	next_infest_time = world.time + tick_cooldown

/datum/component/tick_infested/proc/try_get_valid_target(atom/movable/arrived)
	if(!isliving(arrived))
		return null

	var/mob/living/carbon/C = arrived
	if(!iscarbon(C))
		return null

	if(C.stat == DEAD || C.blood_volume <= 0)
		return null

	if(C.throwing)
		return null

	return C

/datum/component/tick_infested/proc/calculate_chance_modifier(mob/living/carbon/C)
	var/chance_modifier = tick_chance
	switch(C.m_intent)
		if(MOVE_INTENT_RUN)
			chance_modifier = tick_chance * 0.5
		if(MOVE_INTENT_SNEAK)
			chance_modifier = tick_chance * 3.0
	return chance_modifier

/datum/component/tick_infested/proc/infest_target(mob/living/carbon/target)
	if(target.has_embedded_object(/obj/item/natural/worms/tick))
		return

	var/list/valid_parts = list()
	for(var/obj/item/bodypart/BP in target.bodyparts)
		if(!BP.skeletonized)
			valid_parts += BP

	if(!length(valid_parts))
		return

	var/obj/item/bodypart/target_part = pick(valid_parts)
	var/parasite = new /obj/item/natural/worms/tick(target)
	target_part.add_embedded_object(parasite, silent = TRUE, crit_message = FALSE)

/obj/structure/flora/grass/plagued/heavy/Initialize() //only used for testing.
	. = ..()
	AddComponent(/datum/component/tick_infested, 12, 45)

/datum/component/infestation_aura
	var/parasite_type
	var/aura_radius = 6
	var/infest_chance = 12
	var/infest_cooldown = 40
	var/next_infest_time = 0
	var/chance_modifier_type = INFESTATION_MODIFIER_NONE

/datum/component/infestation_aura/Initialize(parasite, chance = 12, cooldown = 40, radius = 6, modifier_type = INFESTATION_MODIFIER_NONE)
	parasite_type = parasite
	infest_chance = clamp(chance, 0, 100)
	infest_cooldown = max(0, cooldown)
	aura_radius = max(0, radius)
	chance_modifier_type = modifier_type

	for(var/turf/T in range(aura_radius, parent))
		RegisterSignal(T, COMSIG_ATOM_ENTERED, PROC_REF(on_mob_entered))
	return ..()

/datum/component/infestation_aura/Destroy()
	for(var/turf/T in range(aura_radius, parent))
		UnregisterSignal(T, COMSIG_ATOM_ENTERED)
	return ..()

/datum/component/infestation_aura/proc/on_mob_entered(turf/source, atom/movable/arrived, atom/old_loc)
	if(world.time < next_infest_time)
		return

	var/mob/living/carbon/C = try_get_valid_target(arrived)
	if(!C)
		return

	var/chance = infest_chance
	if(chance_modifier_type == INFESTATION_MODIFIER_MOVEMENT)
		chance = calculate_movement_modifier(C)

	if(!prob(chance))
		return

	infest_target(C)
	next_infest_time = world.time + infest_cooldown

/datum/component/infestation_aura/proc/try_get_valid_target(atom/movable/arrived)
	if(!isliving(arrived))
		return null

	var/mob/living/carbon/C = arrived
	if(!iscarbon(C))
		return null

	if(C.throwing)
		return null

	return C

/datum/component/infestation_aura/proc/calculate_movement_modifier(mob/living/carbon/C)
	var/modifier = infest_chance
	switch(C.m_intent)
		if(MOVE_INTENT_RUN)
			modifier = infest_chance * 0.5
		if(MOVE_INTENT_SNEAK)
			modifier = infest_chance * 3.0
	return modifier

/datum/component/infestation_aura/proc/infest_target(mob/living/carbon/target)
	if(target.has_embedded_object(parasite_type))
		return

	var/list/valid_parts = list()
	for(var/obj/item/bodypart/BP in target.bodyparts)
		if(!BP.skeletonized)
			valid_parts += BP

	if(!length(valid_parts))
		return

	var/obj/item/bodypart/target_part = pick(valid_parts)
	var/parasite = new parasite_type(target)
	target_part.add_embedded_object(parasite, silent = TRUE, crit_message = FALSE)
