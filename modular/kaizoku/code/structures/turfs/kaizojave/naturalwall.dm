/turf/closed/wall/natural/kaizojave
	uses_integrity = TRUE
	name = "natural kaizojave wall"
	desc = "Woops! This was not meant to to appear. Warn an coder or admin!"
	icon = 'modular/kaizoku/icons/tileset/newwallset/natural/graniterock.dmi'
	icon_state = "wall0"
	base_icon_state = "wall"
	smoothing_flags = SMOOTH_BITMASK
	smoothing_groups = SMOOTH_GROUP_KAIZOJAVE_NATURAL_WALL
	smoothing_list = SMOOTH_GROUP_KAIZOJAVE_NATURAL_WALL
	baseturfs = /turf/open/floor/naturalstone
	above_floor = /turf/open/floor/naturalstone
	wallclimb = TRUE
	explosion_block = 10
	hardness = 8
	blade_dulling = DULLING_PICK
	max_integrity = 700
	damage_deflection = 10
	break_sound = 'sound/combat/hits/onstone/stonedeath.ogg'
	attacked_sound = list('sound/combat/hits/onrock/onrock (1).ogg', 'sound/combat/hits/onrock/onrock (2).ogg', 'sound/combat/hits/onrock/onrock (3).ogg', 'sound/combat/hits/onrock/onrock (4).ogg')
	var/icon/frill_icon = 'modular/kaizoku/icons/tileset/newwallset/natural/graniterock_frill.dmi'
	var/wall_variety = "stone"
	var/mob/living/lastminer = null
	var/obj/item/mineralType = null
	var/obj/item/natural/rock/rockType = null
	var/mineralAmt = 1
	var/spread = 0
	var/spreadChance = 0
	var/unbreakable = FALSE
	var/stone_drop_min = 1
	var/stone_drop_max = 2
	var/log_drop_min = 0
	var/log_drop_max = 0
	var/merge_setup_id = "stone"
	var/front_wall_variant_count = 3
	var/front_wall_variant = 0

/turf/closed/wall/natural/kaizojave/examine()
	. += ..()
	var/material_text = get_material_examine_line()
	if(material_text)
		. += material_text

	if(uses_integrity)
		var/healthpercent = (atom_integrity / max_integrity) * 100
		var/damage_text = get_damage_examine_line(healthpercent)
		if(damage_text)
			. += damage_text

/turf/closed/wall/natural/kaizojave/proc/get_material_examine_line()
	return "It looks barren."

/turf/closed/wall/natural/kaizojave/proc/get_damage_examine_line(healthpercent)
	switch(healthpercent)
		if(75 to 99)
			return "... You cannot tell if the few chips on it is natural or not."
		if(50 to 74)
			return "... Visible unnatural hairline cracks due to impacts."
		if(25 to 49)
			return "...It has deep fractures running through it."
		if(1 to 24)
			return "<span class='warning'>This rock formation is about to fall!!</span>"
	return null

/turf/closed/wall/natural/kaizojave/Initialize(mapload)
	. = ..()
	if(uses_integrity && max_integrity)
		atom_integrity = max_integrity

	if(front_wall_variant_count > 0)
		front_wall_variant = rand(0, front_wall_variant_count - 1)

	QUEUE_SMOOTH(src)
	QUEUE_SMOOTH_NEIGHBORS(src)

	if(frill_icon)
		AddElement(/datum/element/frill, frill_icon)

	return INITIALIZE_HINT_NORMAL

/turf/closed/wall/natural/kaizojave/Destroy()
	lastminer = null
	return ..()

/turf/closed/wall/natural/kaizojave/attackby(obj/item/W, mob/living/user, params)
	if(unbreakable)
		to_chat(user, span_warning("Compressed, dense rock far too stable to be breakable with normal hand tools."))
		return TRUE

	if(log_drop_max <= 0 && user?.used_intent && (user.used_intent.blade_class == BCLASS_CUT || user.used_intent.blade_class == BCLASS_CHOP))
		to_chat(user, span_warning("My [W] scrapes and damages against it. It is not useful at all!"))
		return TRUE

	if(user)
		lastminer = user

	return ..()

/turf/closed/wall/natural/kaizojave/proc/apply_mining_quality(obj/item/item, mob/living/user)
	if(!user || !istype(item, /obj/item/ore))
		return

	var/mining_skill = user.get_skill_level(/datum/skill/labor/mining) + user.get_inspirational_bonus()
	var/base_chance = 5
	var/skill_bonus = mining_skill * 2
	var/luck_bonus = 0

	if(user.stat_roll(STATKEY_LCK, 3, 15))
		luck_bonus = 10

	var/total_chance = base_chance + skill_bonus + luck_bonus
	var/quality = 1
	if(prob(total_chance))
		quality = 2
		if(prob(total_chance / 3))
			quality = 3
			if(prob(total_chance / 6))
				quality = 4
	item.set_quality(quality)

/turf/closed/wall/natural/kaizojave/proc/spawn_natural_wall_drops(turf/drop_turf)
	if(!drop_turf)
		return

	if(log_drop_max > 0)
		visible_message(span_notice("\The [src] collapses into a pile of material."))
		for(var/i in 1 to rand(log_drop_min, log_drop_max))
			new /obj/item/grown/log/tree/small(drop_turf)
		if(prob(10))
			new /obj/effect/decal/cleanable/debris/wood(drop_turf)
		return

	for(var/i in 1 to rand(stone_drop_min, stone_drop_max))
		new /obj/item/natural/stone(drop_turf)

	if(mineralType && mineralAmt > 0)
		if(prob(33))
			var/obj/item/ore/new_ore = new mineralType(drop_turf)
			apply_mining_quality(new_ore, lastminer)
		if(rockType)
			var/obj/item/natural/rock/new_rock = new rockType(drop_turf)
			apply_mining_quality(new_rock, lastminer)
			if(prob(23))
				var/obj/item/natural/rock/bonus_rock = new rockType(drop_turf)
				apply_mining_quality(bonus_rock, lastminer)

/turf/closed/wall/natural/kaizojave/atom_destruction(damage_flag)
	if(unbreakable)
		return

	spawn_natural_wall_drops(get_turf(src))
	return ..()

/turf/closed/wall/natural/kaizojave/proc/get_destroyed_turf_type()
	var/turf/runtime_candidate = pick_open_baseturf_type(baseturfs)
	var/turf/default_candidate = pick_open_baseturf_type(initial(baseturfs))
	var/turf/neighbor_candidate = get_neighbor_floor_consensus_type()

	if(runtime_candidate)
		if(neighbor_candidate && default_candidate && runtime_candidate == default_candidate && neighbor_candidate != runtime_candidate)
			return neighbor_candidate
		return runtime_candidate

	if(neighbor_candidate)
		return neighbor_candidate

	if(default_candidate)
		return default_candidate

	return /turf/open/floor/naturalstone

/turf/closed/wall/natural/kaizojave/proc/pick_open_baseturf_type(source_baseturfs)
	if(ispath(source_baseturfs, /turf/open) && !ispath(source_baseturfs, /turf/open/openspace))
		return source_baseturfs

	if(!islist(source_baseturfs) || !length(source_baseturfs))
		return null

	var/list/baseturf_list = source_baseturfs
	for(var/i in baseturf_list.len to 1 step -1)
		var/candidate_type = baseturf_list[i]
		if(ispath(candidate_type, /turf/baseturf_skipover))
			continue
		if(ispath(candidate_type, /turf/closed/wall))
			continue
		if(ispath(candidate_type, /turf/open) && !ispath(candidate_type, /turf/open/openspace))
			return candidate_type

	return null

/turf/closed/wall/natural/kaizojave/proc/get_neighbor_floor_consensus_type()
	var/list/type_weights = list()
	for(var/direction in GLOB.cardinals)
		var/turf/neighbor = get_step(src, direction)
		if(!neighbor || isclosedturf(neighbor) || istype(neighbor, /turf/open/openspace))
			continue

		var/turf/neighbor_type = neighbor.type
		type_weights[neighbor_type] = (type_weights[neighbor_type] || 0) + 1

	if(!length(type_weights))
		return null

	var/turf/best_type = null
	var/best_weight = -1
	for(var/turf/candidate_type as anything in type_weights)
		var/weight = type_weights[candidate_type]
		if(weight > best_weight)
			best_type = candidate_type
			best_weight = weight

	return best_type

/turf/closed/wall/natural/kaizojave/dismantle_wall(devastated = 0, explode = 0)
	playsound(src, 'sound/blank.ogg', 100, TRUE)
	var/turf/target_turf_type = get_destroyed_turf_type()
	var/turf/new_turf = ChangeTurf(target_turf_type, flags = CHANGETURF_INHERIT_AIR | CHANGETURF_FORCEOP)

	if(!new_turf || istype(new_turf, /turf/closed/wall))
		new_turf = ChangeTurf(/turf/open/floor/naturalstone, flags = CHANGETURF_INHERIT_AIR | CHANGETURF_FORCEOP)

	if(new_turf)
		QUEUE_SMOOTH_NEIGHBORS(new_turf)

/turf/closed/wall/natural/kaizojave/proc/check_suppress_frill_for_doors_windows()
	var/turf/south_turf = get_step(src, SOUTH)
	if(!south_turf)
		return FALSE
	return istype(south_turf, /turf/closed/wall/natural/kaizojave)

/turf/closed/wall/natural/kaizojave/proc/check_vertical_door_window_south()
	return null

/turf/closed/wall/natural/kaizojave/proc/check_vertical_door_window_north()
	return null

/turf/closed/wall/natural/kaizojave/proc/get_vertical_door_window_type(turf/scan_turf)
	return null

/turf/closed/wall/natural/kaizojave/proc/is_mergeable_connector(atom/movable/candidate)
	return FALSE

/turf/closed/wall/natural/kaizojave/proc/has_mergeable_connector_on_turf(turf/neighbor)
	return FALSE

/turf/closed/wall/natural/kaizojave/bitmask_smooth()
	var/new_junction = NONE

	for(var/direction in GLOB.cardinals)
		var/turf/cardinal_neighbor = get_step(src, direction)
		if(is_kaizojave_wall(cardinal_neighbor))
			new_junction |= direction

	for(var/direction in list(NORTHWEST, NORTHEAST, SOUTHWEST, SOUTHEAST))
		var/list/cardinal_dirs = list()
		switch(direction)
			if(NORTHWEST)
				cardinal_dirs = list(NORTH, WEST)
			if(NORTHEAST)
				cardinal_dirs = list(NORTH, EAST)
			if(SOUTHWEST)
				cardinal_dirs = list(SOUTH, WEST)
			if(SOUTHEAST)
				cardinal_dirs = list(SOUTH, EAST)

		var/has_cardinal = new_junction
		var/can_smooth_diag = TRUE
		for(var/cardinal in cardinal_dirs)
			if(!(has_cardinal & cardinal))
				can_smooth_diag = FALSE
				break

		if(can_smooth_diag)
			var/turf/diag_neighbor = get_step(src, direction)
			if(is_kaizojave_wall(diag_neighbor))
				new_junction |= direction

	set_smoothed_icon_state(new_junction)

/turf/closed/wall/natural/kaizojave/proc/apply_frill_cover_overlay()
	return

/turf/closed/wall/natural/kaizojave/proc/should_use_window_coverup()
	return FALSE

/turf/closed/wall/natural/kaizojave/proc/get_window_coverup_state()
	return null

/turf/closed/wall/natural/kaizojave/proc/get_merge_setup_id()
	return merge_setup_id

/turf/closed/wall/natural/kaizojave/proc/can_merge_with_natural_wall(turf/closed/wall/natural/kaizojave/other_wall)
	if(!other_wall)
		return FALSE
	return (get_merge_setup_id() == other_wall.get_merge_setup_id())

/turf/closed/wall/natural/kaizojave/proc/is_kaizojave_wall(turf/neighbor)
	if(!istype(neighbor, /turf/closed/wall/natural/kaizojave))
		return FALSE
	var/turf/closed/wall/natural/kaizojave/other_wall = neighbor
	return can_merge_with_natural_wall(other_wall)

/turf/closed/wall/natural/kaizojave/proc/is_back_wall(turf/neighbor)
	if(!is_kaizojave_wall(neighbor))
		return FALSE
	var/turf/south_turf = get_step(neighbor, SOUTH)
	return istype(south_turf, /turf/closed/wall/natural/kaizojave)

/turf/closed/wall/natural/kaizojave/proc/is_front_wall(turf/neighbor)
	if(!is_kaizojave_wall(neighbor))
		return FALSE
	return !is_back_wall(neighbor)

/turf/closed/wall/natural/kaizojave/proc/get_consolidated_wall_state(has_south_wall, east_is_wall, west_is_wall, east_is_back, west_is_back, east_is_front, west_is_front, se_is_back, sw_is_back, se_back_has_north_wall, sw_back_has_north_wall)
	if(!has_south_wall)
		var/continues_east = east_is_front
		var/continues_west = west_is_front

		if(!continues_east && !continues_west)
			return "wall0"
		if(continues_east && !continues_west)
			return "wall2"
		if(!continues_east && continues_west)
			return "wall3"
		return "wall4"

	var/comp_back_sw = sw_is_back && !sw_back_has_north_wall
	var/comp_back_se = se_is_back && !se_back_has_north_wall
	if(comp_back_sw || comp_back_se)
		if(comp_back_sw && comp_back_se)
			return "wall12"
		if(comp_back_sw && east_is_back)
			return "wall10"
		if(comp_back_se && west_is_back)
			return "wall11"
		if(comp_back_sw && !east_is_back)
			return "wall8"
		if(comp_back_se && !west_is_back)
			return "wall9"

	if(!east_is_back && !west_is_back)
		return "wall1"
	if(east_is_back && !west_is_back)
		return "wall5"
	if(!east_is_back && west_is_back)
		return "wall6"
	return "wall7"

/turf/closed/wall/natural/kaizojave/proc/resolve_icon_state(base_state)
	if(!front_wall_variant_count)
		return base_state
	switch(base_state)
		if("wall0", "wall2", "wall3", "wall4")
			var/candidate = "[base_state]_[front_wall_variant]"
			if(candidate in icon_states(icon))
				return candidate
	return base_state

/turf/closed/wall/natural/kaizojave/set_smoothed_icon_state(new_junction)
	var/turf/south_neighbor = get_step(src, SOUTH)
	var/turf/west_neighbor = get_step(src, WEST)
	var/turf/east_neighbor = get_step(src, EAST)
	var/turf/sw_neighbor = get_step(src, SOUTHWEST)
	var/turf/se_neighbor = get_step(src, SOUTHEAST)

	var/has_south_wall = is_kaizojave_wall(south_neighbor)
	var/west_is_wall = is_kaizojave_wall(west_neighbor)
	var/east_is_wall = is_kaizojave_wall(east_neighbor)
	var/west_is_back = is_back_wall(west_neighbor)
	var/east_is_back = is_back_wall(east_neighbor)
	var/west_is_front = is_front_wall(west_neighbor)
	var/east_is_front = is_front_wall(east_neighbor)
	var/sw_is_back = is_back_wall(sw_neighbor)
	var/se_is_back = is_back_wall(se_neighbor)
	var/sw_back_has_north_wall = FALSE
	var/se_back_has_north_wall = FALSE
	if(sw_neighbor)
		sw_back_has_north_wall = is_kaizojave_wall(get_step(sw_neighbor, NORTH))
	if(se_neighbor)
		se_back_has_north_wall = is_kaizojave_wall(get_step(se_neighbor, NORTH))

	var/consolidated = get_consolidated_wall_state(has_south_wall, east_is_wall, west_is_wall, east_is_back, west_is_back, east_is_front, west_is_front, se_is_back, sw_is_back, se_back_has_north_wall, sw_back_has_north_wall)
	var/frill_junction = new_junction
	if(west_is_wall)
		frill_junction |= WEST_JUNCTION
	else
		frill_junction &= ~WEST_JUNCTION
	if(east_is_wall)
		frill_junction |= EAST_JUNCTION
	else
		frill_junction &= ~EAST_JUNCTION

	icon_state = resolve_icon_state(consolidated)
	SEND_SIGNAL(src, COMSIG_ATOM_SET_SMOOTHED_ICON_STATE, frill_junction)

/turf/closed/wall/natural/kaizojave/rock
	name = "rock wall"
	desc = "A weathered natural stone wall face."

/turf/closed/wall/natural/kaizojave/rock/get_material_examine_line()
	return "It looks barren."

/turf/closed/wall/natural/kaizojave/rock/get_damage_examine_line(healthpercent)
	switch(healthpercent)
		if(75 to 99)
			return "Only a few fresh chips mark the stone."
		if(50 to 74)
			return "Hairline cracks spread across the formation."
		if(25 to 49)
			return "Deep fractures run through the rock face."
		if(1 to 24)
			return "<span class='warning'>The rock formation is close to collapsing!</span>"
	return null

/turf/closed/wall/natural/kaizojave/bamboo
	name = "bamboo wall"
	desc = "A dense stand of living bamboo that blocks the way."
	icon = 'modular/kaizoku/icons/tileset/newwallset/natural/greenbamboo_frill.dmi'
	frill_icon = 'modular/kaizoku/icons/tileset/newwallset/natural/greenbamboo_frill.dmi'
	wall_variety = "wood"
	explosion_block = 3
	hardness = 5
	blade_dulling = DULLING_CUT
	max_integrity = 450
	break_sound = 'sound/misc/woodhit.ogg'
	attacked_sound = 'sound/misc/woodhit.ogg'
	baseturfs = /turf/open/floor/dirt
	above_floor = /turf/open/floor/dirt
	stone_drop_min = 0
	stone_drop_max = 0
	log_drop_min = 1
	log_drop_max = 2
	merge_setup_id = "bamboo"

/turf/closed/wall/natural/kaizojave/bamboo/get_material_examine_line()
	return "The stalks are tightly packed and hard to pass through."

/turf/closed/wall/natural/kaizojave/bamboo/get_damage_examine_line(healthpercent)
	switch(healthpercent)
		if(75 to 99)
			return "Only a few splinters are missing from the stand."
		if(50 to 74)
			return "Several stalks are cut and fraying."
		if(25 to 49)
			return "The bamboo stand is badly hacked apart."
		if(1 to 24)
			return "<span class='warning'>The bamboo stand is about to give way!</span>"
	return null

/turf/closed/wall/natural/kaizojave/bedrock
	name = "bedrock"
	desc = "Ancient stone that refuses all attempts at shaping."
	unbreakable = TRUE
	max_integrity = 10000000
	damage_deflection = 99999999
	stone_drop_min = 0
	stone_drop_max = 0

/turf/closed/wall/natural/kaizojave/bedrock/attackby(obj/item/I, mob/user, params)
	to_chat(user, span_warning("This is far too sturdy to be destroyed!"))
	return TRUE

/turf/closed/wall/natural/kaizojave/bedrock/acid_melt()
	return

/turf/closed/wall/natural/kaizojave/bedrock/Melt()
	to_be_destroyed = FALSE
	return src

/proc/get_natural_ore_wall_path(ore_key)
	switch(lowertext("[ore_key]"))
		if("iron")
			return /turf/closed/wall/natural/kaizojave/rock/iron
		if("copper")
			return /turf/closed/wall/natural/kaizojave/rock/copper
		if("silver")
			return /turf/closed/wall/natural/kaizojave/rock/silver
		if("gold")
			return /turf/closed/wall/natural/kaizojave/rock/gold
		if("mana", "mana crystal")
			return /turf/closed/wall/natural/kaizojave/rock/mana_crystal
		if("cinnabar")
			return /turf/closed/wall/natural/kaizojave/rock/cinnabar
		if("coal")
			return /turf/closed/wall/natural/kaizojave/rock/coal
		if("tin")
			return /turf/closed/wall/natural/kaizojave/rock/tin
		if("salt")
			return /turf/closed/wall/natural/kaizojave/rock/salt
		if("gems", "gemeralds")
			return /turf/closed/wall/natural/kaizojave/rock/gemeralds
	return /turf/closed/wall/natural/kaizojave/rock/iron

/proc/place_natural_ore_deposit_clustered(turf/T, ore_type)
	if(!T)
		return
	var/turf_type = get_natural_ore_wall_path(ore_type)
	T.ChangeTurf(turf_type, flags = CHANGETURF_SKIP)

/turf/closed/wall/natural/kaizojave/random
	name = "rock wall"
	desc = "A natural rock face that may hide useful seams beneath it."
	var/list/mineralSpawnChanceList = list(/turf/closed/wall/natural/kaizojave/rock/salt = 20, /turf/closed/wall/natural/kaizojave/rock/copper = 15, /turf/closed/wall/natural/kaizojave/rock/tin = 12, /turf/closed/wall/natural/kaizojave/rock/iron = 5, /turf/closed/wall/natural/kaizojave/rock/coal = 5)
	var/mineralChance = 30

/turf/closed/wall/natural/kaizojave/random/Initialize(mapload)
	. = ..()
	if(prob(mineralChance))
		var/runtime_baseturfs = baseturfs
		var/runtime_above_floor = above_floor
		var/path = pickweight(mineralSpawnChanceList)
		var/turf/T = ChangeTurf(path, flags = CHANGETURF_IGNORE_AIR)
		if(istype(T, /turf/closed/wall/natural/kaizojave))
			var/turf/closed/wall/natural/kaizojave/M = T
			M.mineralAmt = rand(1, 5)
			M.baseturfs = runtime_baseturfs
			M.above_floor = runtime_above_floor

/turf/closed/wall/natural/kaizojave/random/med
	mineralChance = 50
	mineralSpawnChanceList = list(
		/turf/closed/wall/natural/kaizojave/rock/salt = 20,
		/turf/closed/wall/natural/kaizojave/rock/iron = 25,
		/turf/closed/wall/natural/kaizojave/rock/coal = 20,
		/turf/closed/wall/natural/kaizojave/rock/copper = 10,
		/turf/closed/wall/natural/kaizojave/rock/tin = 10,
		/turf/closed/wall/natural/kaizojave/rock/silver = 1
	)

/turf/closed/wall/natural/kaizojave/random/high
	mineralChance = 70
	mineralSpawnChanceList = list(
		/turf/closed/wall/natural/kaizojave/rock/mana_crystal = 15,
		/turf/closed/wall/natural/kaizojave/rock/cinnabar = 5,
		/turf/closed/wall/natural/kaizojave/rock/gold = 15,
		/turf/closed/wall/natural/kaizojave/rock/iron = 25,
		/turf/closed/wall/natural/kaizojave/rock/silver = 15
	)

/turf/closed/wall/natural/kaizojave/random/low_nonval
	mineralChance = 30
	mineralSpawnChanceList = list(
		/turf/closed/wall/natural/kaizojave/rock/copper = 15,
		/turf/closed/wall/natural/kaizojave/rock/tin = 15,
		/turf/closed/wall/natural/kaizojave/rock/iron = 25,
		/turf/closed/wall/natural/kaizojave/rock/coal = 20
	)

/turf/closed/wall/natural/kaizojave/random/med_nonval
	mineralChance = 50
	mineralSpawnChanceList = list(
		/turf/closed/wall/natural/kaizojave/rock/copper = 15,
		/turf/closed/wall/natural/kaizojave/rock/tin = 15,
		/turf/closed/wall/natural/kaizojave/rock/iron = 25,
		/turf/closed/wall/natural/kaizojave/rock/coal = 20
	)

/turf/closed/wall/natural/kaizojave/random/high_nonval
	mineralChance = 70
	mineralSpawnChanceList = list(
		/turf/closed/wall/natural/kaizojave/rock/mana_crystal = 10,
		/turf/closed/wall/natural/kaizojave/rock/copper = 15,
		/turf/closed/wall/natural/kaizojave/rock/tin = 15,
		/turf/closed/wall/natural/kaizojave/rock/iron = 25,
		/turf/closed/wall/natural/kaizojave/rock/coal = 20
	)

/turf/closed/wall/natural/kaizojave/random/low_valuable
	mineralChance = 30
	mineralSpawnChanceList = list(
		/turf/closed/wall/natural/kaizojave/rock/mana_crystal = 10,
		/turf/closed/wall/natural/kaizojave/rock/gold = 40,
		/turf/closed/wall/natural/kaizojave/rock/gemeralds = 20,
		/turf/closed/wall/natural/kaizojave/rock/silver = 40
	)

/turf/closed/wall/natural/kaizojave/random/med_valuable
	mineralChance = 50
	mineralSpawnChanceList = list(
		/turf/closed/wall/natural/kaizojave/rock/mana_crystal = 10,
		/turf/closed/wall/natural/kaizojave/rock/gold = 40,
		/turf/closed/wall/natural/kaizojave/rock/gemeralds = 20,
		/turf/closed/wall/natural/kaizojave/rock/silver = 40
	)

/turf/closed/wall/natural/kaizojave/random/high_valuable
	mineralChance = 70
	mineralSpawnChanceList = list(
		/turf/closed/wall/natural/kaizojave/rock/mana_crystal = 10,
		/turf/closed/wall/natural/kaizojave/rock/gold = 40,
		/turf/closed/wall/natural/kaizojave/rock/gemeralds = 20,
		/turf/closed/wall/natural/kaizojave/rock/silver = 40
	)

/turf/closed/wall/natural/kaizojave/rock/copper
	name = "rock wall"
	mineralType = /obj/item/ore/copper
	rockType = /obj/item/natural/rock/copper
	spreadChance = 4
	spread = 3

/turf/closed/wall/natural/kaizojave/rock/tin
	name = "rock wall"
	mineralType = /obj/item/ore/tin
	rockType = /obj/item/natural/rock/tin
	spreadChance = 15
	spread = 5

/turf/closed/wall/natural/kaizojave/rock/silver
	name = "rock wall"
	mineralType = /obj/item/ore/silver
	rockType = /obj/item/natural/rock/silver
	spreadChance = 2
	spread = 2

/turf/closed/wall/natural/kaizojave/rock/gold
	name = "rock wall"
	mineralType = /obj/item/ore/gold
	rockType = /obj/item/natural/rock/gold
	spreadChance = 2
	spread = 2

/turf/closed/wall/natural/kaizojave/rock/salt
	name = "rock wall"
	mineralType = /obj/item/reagent_containers/powder/salt
	rockType = /obj/item/natural/rock/salt
	spreadChance = 12
	spread = 3

/turf/closed/wall/natural/kaizojave/rock/cinnabar
	name = "rock wall"
	mineralType = /obj/item/ore/cinnabar
	rockType = /obj/item/natural/rock/cinnabar
	spreadChance = 23
	spread = 5

/turf/closed/wall/natural/kaizojave/rock/mana_crystal
	name = "rock wall"
	mineralType = /obj/item/mana_battery/mana_crystal/standard
	rockType = /obj/item/natural/rock/mana_crystal
	spreadChance = 23
	spread = 5

/turf/closed/wall/natural/kaizojave/rock/iron
	name = "rock wall"
	mineralType = /obj/item/ore/iron
	rockType = /obj/item/natural/rock/iron
	spreadChance = 5
	spread = 3

/turf/closed/wall/natural/kaizojave/rock/coal
	name = "rock wall"
	mineralType = /obj/item/ore/coal
	rockType = /obj/item/natural/rock/coal
	spreadChance = 3
	spread = 4

/turf/closed/wall/natural/kaizojave/rock/gemeralds
	name = "rock wall"
	mineralType = /obj/item/gem
	rockType = /obj/item/natural/rock/gemerald
	spreadChance = 3
	spread = 2
