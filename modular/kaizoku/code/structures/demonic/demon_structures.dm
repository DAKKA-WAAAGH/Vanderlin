//Helpers and proc definitions
/proc/call_later(proc_ref, delay_seconds)
	addtimer(proc_ref, max(1, delay_seconds) SECONDS)

/proc/visible_message(msg)
	world << msg

var/global/datum/demon_hive/DEMON_HIVE
var/global/list/demon_spread_dirs = list(NORTH, SOUTH, EAST, WEST)
var/global/list/demon_all_dirs = list(NORTH, SOUTH, EAST, WEST, NORTHEAST, NORTHWEST, SOUTHEAST, SOUTHWEST)
var/global/list/DEMON_SPAWNER_MATURE_TYPES = list(
	/mob/living/simple_animal/hostile/retaliate/infernal/watcher,
	/mob/living/simple_animal/hostile/retaliate/blood,
	/mob/living/simple_animal/hostile/retaliate/demon/succubus
)

/mob/living/var/ichor_next_burn_tick = 0

/proc/is_valid_corruption_turf(turf/T)
	if(!T)
		return FALSE
	if(T.density)
		return FALSE
	if(istype(T, /turf/open/openspace))
		return FALSE
	if(locate(/obj/effect/demon/corruption) in T)
		return FALSE
	// if(locate(/obj/effect/holy_ground) in T) return FALSE // Unfinished
	return TRUE

/proc/is_good_structure_spot(turf/T) //This code avoids the structures from spawning too close to each other.
	if(!T)
		return FALSE
	for(var/obj/structure/demon/DS in range(STRUCTURE_MIN_SPACING, T))
		if(istype(DS, /obj/structure/demon/railing)) //ignore railings & cocoons These are free game.
			continue
		if(istype(DS, /obj/structure/demon/cocoon))
			continue
		return FALSE
	return TRUE

/proc/pick_spread_out_spot(list/candidates) //The candidates are filtered for validity, nearest demon structure.
	if(!candidates || !candidates.len)
		return null
	var/turf/best = null
	var/best_score = -1
	for(var/turf/Ts in candidates)
		var/min_dist = 999
		for(var/obj/structure/demon/DS2 in range(12, Ts))
			if(istype(DS2, /obj/structure/demon/railing) || istype(DS2, /obj/structure/demon/cocoon))
				continue
			var/d_calc = max(abs(DS2.x - Ts.x), abs(DS2.y - Ts.y))
			if(d_calc < min_dist)
				min_dist = d_calc
		if(min_dist > best_score)
			best_score = min_dist
			best = Ts
	return best

/proc/remove_corruption_at(turf/T)
	if(!T) return
	for(var/obj/effect/demon/corruption/C in T)
		qdel(C)

/proc/pick_near_owner_spot(atom/owner, list/candidates, max_range = 2)
	if(!owner || !candidates || !candidates.len)
		return null
	var/turf/best = null
	var/best_dist = 1e9
	for(var/turf/T in candidates)
		var/d = get_dist(owner, T)
		if(max_range && d > max_range)
			continue
		if(d < best_dist)
			best_dist = d
			best = T
	if(!best)
		for(var/turf/T2 in candidates)
			var/d2 = get_dist(owner, T2)
			if(d2 < best_dist)
				best_dist = d2
				best = T2
	return best

/proc/SpawnDemonIncursion(turf/center, cores = 2)
	if(!center)
		return
	if(!DEMON_HIVE)
		DEMON_HIVE = new
	new /obj/structure/demon/gateway(center)
	cores = min(cores, 2)
	var/list/radials = list(NORTH, SOUTH, EAST, WEST)
	for(var/i=1, i<=cores, i++)
		var/dir_pick = pick(radials)
		radials -= dir_pick
		var/turf/Tc5 = get_step(center, dir_pick)
		for(var/attempts = 0; attempts < 10; attempts++)
			Tc5 = locate(center.x + rand(-8, 8), center.y + rand(-8, 8), center.z)
			if(Tc5 && !Tc5.density && get_dist(center, Tc5) >= MIN_CORE_DISTANCE)
				break
		if(Tc5 && !Tc5.density)
			if(is_good_structure_spot(Tc5))
				var/obj/structure/demon/cocoon/Cc6 = new /obj/structure/demon/cocoon(Tc5)
				Cc6.cocoon_type = "core"
				Cc6.maturation_time = 120 SECONDS
	DEMON_HIVE.start(center)

/proc/DemonHiveStatus()
	if(!DEMON_HIVE)
		return "No demon hive active"
	var/colony_status = (DEMON_HIVE.colony_level == 2) ? "Second Colony" : "First Colony"
	return "Cores: [DEMON_HIVE.cores?.len || 0] | Corruption: [DEMON_HIVE.corruptions?.len || 0] | Cocoons: [DEMON_HIVE.cocoons?.len || 0] | Hallu Sent: [DEMON_HIVE.hallucination_count] | Colony: [colony_status]"

// ---------------------------------------------------

//testing shit
/*
/obj/structure/demon/gateway/reagent_act(datum/reagent/R, amount)
	if(istype(R, /datum/reagent/water/holywater))
		_apply_damage(round(amount * 3))
		visible_message("<span class='warning'>[src] sizzles and steams from the holy water!</span>")
		return

/obj/structure/demon/expansion/reagent_act(datum/reagent/R, amount)
	if(istype(R, /datum/reagent/water/holywater))
		_apply_damage(round(amount * 2))
		visible_message("<span class='warning'>[src] smolders under the holy water!</span>")
		return

/obj/effect/demon/corruption/proc/reagent_act(datum/reagent/R, amount)
	if(istype(R, /datum/reagent/water/holywater))
		qdel(src)
		return
*/
