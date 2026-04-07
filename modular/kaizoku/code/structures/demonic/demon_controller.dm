/datum/demon_hive
	var/list/cores = list()
	var/list/corruptions = list()
	var/list/cocoons = list()
	var/obj/structure/demon/gateway/gateway
	var/is_active = FALSE
	var/colony_level = 1
	var/spread_delay_override = 0
	var/next_hallucination_at = 0
	var/hallucination_count = 0
	var/total_corruption_area = 0
	var/first_colony_railings_placed = FALSE
	var/second_colony_railings_placed = FALSE

/datum/demon_hive/proc/pick_slowdown_delay()
	var/list/buckets = list(3,5,8,12,15,20,25,30)
	return pick(buckets)

/datum/demon_hive/proc/maybe_apply_slowdown(chance)
	if(prob(chance))
		var/delay = pick_slowdown_delay()
		if(delay > spread_delay_override)
			spread_delay_override = delay

/datum/demon_hive/proc/start(anchor_loc)
	if(is_active)
		return
	is_active = TRUE
	if(!gateway || QDELETED(gateway))
		gateway = new /obj/structure/demon/gateway(anchor_loc)
	next_hallucination_at = world.time
	pulse()

/datum/demon_hive/proc/pulse()
	if(!is_active)
		return

	var/old_level = colony_level
	colony_level = (total_corruption_area >= 150) ? 2 : 1

	if(old_level != colony_level && colony_level == 2)
		visible_message("<span class='userdanger'>... The dark star relives... ONCE... MORE!!!</span>")
		upgrade_first_colony_structures()
		place_second_colony_railings()
		for(var/obj/structure/demon/spawner/SpG in range(FIRST_COLONY_RANGE * 2, gateway)) //Colony upgraded? Force all spawners to second-colony rules.
			if(get_dist(gateway, SpG) <= FIRST_COLONY_RANGE)
				SpG.apply_colony_rules(2)

	if(colony_level == 1 && total_corruption_area >= 75 && !first_colony_railings_placed)
		place_first_colony_railings()
		first_colony_railings_placed = TRUE

	if(world.time >= next_hallucination_at && gateway && !QDELETED(gateway))
		send_random_hallucination()
		next_hallucination_at = world.time + rand(HALLU_MIN_INTERVAL, HALLU_MAX_INTERVAL)

	call_later(CALLBACK(src, /datum/demon_hive/proc/pulse), 15)

/datum/demon_hive/proc/place_first_colony_railings()
	if(!gateway)
		return
	for(var/obj/effect/demon/corruption/Cor in range(FIRST_COLONY_RANGE, gateway))
		for(var/dir_card in GLOB.demon_spread_dirs)
			var/turf/Tc = get_step(Cor, dir_card)
			if(!Tc || !(locate(/obj/effect/demon/corruption) in Tc))
				if(!(locate(/obj/structure/demon/railing) in Cor.loc))
					var/obj/structure/demon/railing/R1 = new(Cor.loc)
					R1.dir = dir_card
				break

/datum/demon_hive/proc/place_second_colony_railings() //Second tier - second line of protection.
	if(!gateway || second_colony_railings_placed)
		return
	second_colony_railings_placed = TRUE
	for(var/obj/effect/demon/corruption/Cor2 in range(SECOND_COLONY_RANGE, gateway))
		var/dist = get_dist(gateway, Cor2)
		if(dist <= FIRST_COLONY_RANGE)
			continue
		for(var/dir_card2 in GLOB.demon_spread_dirs)
			var/turf/Tc2 = get_step(Cor2, dir_card2)
			if(!Tc2 || !(locate(/obj/effect/demon/corruption) in Tc2))
				if(!(locate(/obj/structure/demon/railing) in Cor2.loc))
					var/obj/structure/demon/railing/R2 = new(Cor2.loc)
					R2.dir = dir_card2
				break

/datum/demon_hive/proc/upgrade_first_colony_structures()
	if(!gateway)
		return
	for(var/obj/structure/demon/expansion/CoUp in cores)
		if(get_dist(gateway, CoUp) <= FIRST_COLONY_RANGE)
			CoUp.upgrade_to_second_colony()
	for(var/obj/structure/demon/turret/TuUp in range(FIRST_COLONY_RANGE * 2, gateway))
		if(get_dist(gateway, TuUp) <= FIRST_COLONY_RANGE)
			TuUp.upgrade_to_second_colony()
	for(var/obj/structure/demon/spawner/SpUp in range(FIRST_COLONY_RANGE * 2, gateway))
		if(get_dist(gateway, SpUp) <= FIRST_COLONY_RANGE)
			SpUp.apply_colony_rules(2)

/datum/demon_hive/proc/send_random_hallucination()
	var/list/messages = list(
		" ...Flesh, always flesh... more flesh...",
		" ...I am power, I am the victor, I will feast on the lamentations of this world...",
		"...Mama, mama save me...",
		"... Lick the spewing hearts of your enemies, feast on the veins...",
		"... The Dark Star, The True God, Master, Sini-Star ...",
		"... Rip, Rip, tendons, ribbons, splatter it all...",
		"... Yes that's right, squirm on it. Bleed on the knife, it likes the way you twist...",
		"... The first squirt of hot blood, to the victor goes the spoils...",
		" ... The rush of it, when the light of their eyes fade, when hope is driven from their hearts..."
	)
	var/message = pick(messages)
	var/list/targets = list()
	for(var/mob/living/carbon/human/Hall in world)
		targets += Hall
	if(targets.len)
		var/mob/target = pick(targets)
		to_chat(target, "<span class='cult'>[message]</span>")
		hallucination_count++

/datum/demon_hive/proc/on_core_created(obj/structure/demon/expansion/C_new)
	if(!cores)
		cores = list()
	cores |= C_new

/datum/demon_hive/proc/on_core_destroyed(obj/structure/demon/expansion/C_gone)
	if(cores)
		cores -= C_gone
	for(var/obj/effect/demon/corruption/Corr in world)
		if(Corr.parent_core == C_gone)
			qdel(Corr)
	maybe_apply_slowdown(60)
	if((!gateway || QDELETED(gateway)) && (!cores || !cores.len))
		die()

/datum/demon_hive/proc/on_corruption_created(obj/effect/demon/corruption/C_make)
	if(!corruptions)
		corruptions = list()
	corruptions |= C_make
	total_corruption_area++

/datum/demon_hive/proc/on_corruption_destroyed(obj/effect/demon/corruption/C_break)
	if(corruptions)
		corruptions -= C_break
	total_corruption_area = max(0, total_corruption_area-1)
	maybe_apply_slowdown(5)

/datum/demon_hive/proc/on_cocoon_created(obj/structure/demon/cocoon/Cc_new)
	if(!cocoons)
		cocoons = list()
	cocoons |= Cc_new

/datum/demon_hive/proc/on_cocoon_destroyed(obj/structure/demon/cocoon/Cc_gone)
	if(cocoons)
		cocoons -= Cc_gone

/datum/demon_hive/proc/die()
	is_active = FALSE
	if(cores)
		for(var/obj/structure/demon/expansion/Cdie in cores)
			if(!QDELETED(Cdie))
				spawn(rand(10,60))
					if(!QDELETED(Cdie))
						qdel(Cdie)
	if(corruptions)
		for(var/obj/effect/demon/corruption/Corrdie in corruptions)
			if(!QDELETED(Corrdie))
				qdel(Corrdie)
	if(cocoons)
		for(var/obj/structure/demon/cocoon/Cocdie in cocoons)
			if(!QDELETED(Cocdie))
				qdel(Cocdie)
	DEMON_HIVE = null
	qdel(src)

/datum/demon_hive/proc/next_spread_delay(base_seconds)
	if(spread_delay_override > 0)
		return max(base_seconds, spread_delay_override)
	return base_seconds
