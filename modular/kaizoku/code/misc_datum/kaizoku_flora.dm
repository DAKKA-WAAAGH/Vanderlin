/obj/structure/flora/tree/abyssal
	name = "martyr blossom"
	desc = "Regarded as sacred by Abyssanctum, each blossom feeds on the corruptive burden of the earth, regardless of Dendor's corruption."
	icon = 'modular/kaizoku/icons/mapset/nature_64x64.dmi'
	icon_state = "tree"
	var/activated = 0
	max_integrity = 350

/obj/structure/flora/tree/abyssal/Initialize()
	. = ..()
	icon_state = "tree_[rand(1,8)]"

/obj/structure/flora/hollowtree
	parent_type = /obj/structure/flora/newtree
	name = "solvatis tree"
	desc = "Known as the vitalis arbor, this tree lives in symbiosis with mushrooms. The trunk is hollow and rich in fluid."
	icon = 'modular/kaizoku/icons/mapset/nature_32x32.dmi'
	icon_state = "hollowtree"
	var/base_state = null
	max_integrity = 250
	armor = list("blunt" = 0, "slash" = 0, "stab" = 0, "piercing" = 0, "fire" = -100, "acid" = 50)
	blade_dulling = DULLING_CUT
	opacity = 1
	density = 1
	climbable = FALSE
	static_debris = list(/obj/item/grown/log/tree = 1)
	obj_flags = CAN_BE_HIT | BLOCK_Z_IN_UP | BLOCK_Z_OUT_DOWN

/obj/structure/flora/hollowtree/Initialize()
	. = ..()
	GenerateTree()

/obj/structure/flora/hollowtree/update_icon()
	. = ..()
	cut_overlays()
	var/mutable_appearance/mutable = mutable_appearance(icon, "hollowtree")
	mutable.dir = dir
	add_overlay(mutable)

/obj/structure/flora/hollowtree/GenerateTree()
	dir = pick(GLOB.cardinals)
	SStreesetup.initialize_me |= src
	build_hollow_trunks()

/obj/structure/flora/hollowtree/proc/spawn_mushrooms()
	if(prob(60))
		var/list/dirs = list(NORTH, SOUTH, EAST, WEST)
		for(var/dir in dirs)
			if(prob(50))
				var/turf/T = get_step(src, dir)
				if(istype(T, /turf/open) && !locate(/obj/structure/flora/mushroom) in T)
					var/obj/structure/flora/mushroom/M = new(T)
					M.dir = dir

/obj/structure/flora/hollowtree/proc/build_hollow_trunks()
	var/obj/structure/flora/hollowtree/prev = src
	for(var/i in 1 to 2)
		var/turf/T = get_step_multiz(prev, UP)
		if(!istype(T, /turf/open/openspace))
			break
		var/obj/structure/flora/hollowtree/new_trunk = new /obj/structure/flora/hollowtree(T)
		new_trunk.dir = dir
		prev = new_trunk
		if(i == 1) src.spawn_mushrooms()
		new_trunk.build_leafs(i+1)

/obj/structure/flora/hollowtree/build_leafs(z_level)
	if(z_level < 2)
		return
	var/range = (z_level == 2) ? 2 : 3

	for(var/dx = -range to range)
		for(var/dy = -range to range)
			if(dx == 0 && dy == 0)
				continue

			var/abs_total = abs(dx) + abs(dy)
			if(z_level == 2 && abs_total > 3)
				continue
			if(z_level == 3 && abs_total > 4)
				continue

			var/turf/T = locate(src.x + dx, src.y + dy, src.z)
			if(!istype(T, /turf/open/openspace))
				continue
			if(locate(/obj/structure) in T)
				continue

			var/is_corner = (abs(dx) == abs(dy))
			var/obj/structure/flora/stepleaf/leaf
			if(is_corner)
				leaf = new /obj/structure/flora/stepleaf/solvatis/corner(T)
			else
				leaf = new /obj/structure/flora/stepleaf/solvatis(T)
			leaf.dir = get_dir(src, T)

/obj/structure/flora/stepleaf/solvatis
	parent_type = /obj/structure/flora/newleaf
	name = "solvatis leaves"
	desc = "A thick leafy canopy, strong enough to stand on."
	icon = 'modular/kaizoku/icons/mapset/frontierjustice32.dmi'
	icon_state = "center-leaf"
	climbable = TRUE
	max_integrity = 15
	obj_flags = CAN_BE_HIT | BLOCK_Z_OUT_DOWN
	static_debris = list(/obj/item/grown/log/tree/stick = 1)
	var/base_state
	density = FALSE
	max_integrity = 30

/obj/structure/flora/stepleaf/solvatis/corner
	icon_state = "corner-leaf"

/obj/structure/flora/mushroom
	name = "mushroom on solvatis"
	desc = "A ziitake, an mushroom used for nutritional purposes."
	icon = 'modular/kaizoku/icons/mapset/nature_32x32.dmi'
	icon_state = "mushroom_end1"
	density = FALSE
	max_integrity = 5
	static_debris = list(/obj/item/reagent_containers/food/snacks/produce/shiitake = 1)
	dir = NORTH

/obj/structure/flora/mushroom/Initialize()
	. = ..()
	icon_state = "mushroom_end[rand(1,4)]"

/obj/item/reagent_containers/food/snacks/produce/shiitake
	seed = null
	name = "ziitake"
	desc = "By Akhan, 3.1 'Blessed be what does not grow towards the corruption, as the crown of the purified defies what sinks the soul into damnation.'"
	icon = 'modular/kaizoku/icons/mapset/nature_32x32.dmi'
	icon_state = "shiitake"
	throwforce = 0
	w_class = WEIGHT_CLASS_TINY
	throw_speed = 1
	throw_range = 3
	list_reagents = list(/datum/reagent/consumable/nutriment = SNACK_POOR)
	dropshrink = 0.6
	rotprocess = null

/obj/structure/flora/mushroom
	name = "foreigner mushroom"
	desc = "Mushroom used for nutrition or medicinal purposes."
	icon = 'modular/kaizoku/icons/mapset/frontierjustice32.dmi'
	icon_state = "mushroom"
	density = FALSE
	max_integrity = 5
	static_debris = list(/obj/item/reagent_containers/food/snacks/produce/shiitake = 1)

/obj/structure/fauna/mindsmiter
	name = "mindsmiter"
	desc = "Detached zizoid hyperplasia that left its hive, it binds with trees as a parasite. \
	It feeds by draining the vitae of their victims with tendrils from below, but the core is harmless."
	icon = 'modular/kaizoku/icons/mapset/florafauna.dmi'
	icon_state = "mindsmiter"
	density = FALSE
	anchored = TRUE
	layer = EFFECTS_LAYER
	max_integrity = 100
	opacity = FALSE
	var/list/segments = list()
	var/electro_power = 30
	light_power = 1.5
	var/light_range = 1.5
	light_color = "#d64747"

/obj/structure/fauna/mindsmiter/Initialize()
	. = ..()
	set_light(light_power, light_range, light_range, l_color = light_color)
	maketendril()

/obj/structure/fauna/mindsmiter/Destroy()
	for(var/obj/structure/fauna/mindsmiter_tendril/R in segments)
		qdel(R)
	segments = null
	return ..()

/obj/structure/fauna/mindsmiter/proc/maketendril()
	var/turf/T = get_turf(src)
	if(!T)
		return

	var/turf/down = locate(T.x, T.y, T.z - 1)
	if(!down)
		return
	if(!istype(down, /turf/open))
		return

	var/obj/structure/fauna/mindsmiter_tendril/t = new(down)
	t.above = null
	t.below = null
	t.is_top = TRUE
	t.is_bottom = TRUE
	t.electro_power = electro_power
	t.update_icon()
	segments += t

/obj/structure/fauna/mindsmiter/atom_destruction(damage_flag)
	. = ..()
	if(!QDELETED(src))
		new /obj/item/reagent_containers/food/snacks/mindsmiter_scum(get_turf(src))
	for(var/obj/structure/fauna/mindsmiter_tendril/R in segments)
		qdel(R)
	qdel(src)
	return TRUE

/obj/structure/fauna/mindsmiter_tendril
	name = "mindsmiter tendril"
	desc = ""
	icon = 'modular/kaizoku/icons/mapset/florafauna.dmi'
	icon_state = "mindsmiter_tendril"
	mouse_opacity = 0
	density = FALSE
	anchored = TRUE
	layer = EFFECTS_LAYER
	max_integrity = 100
	opacity = FALSE
	resistance_flags = FLAMMABLE
	obj_flags = BLOCK_Z_OUT_DOWN | BLOCK_Z_IN_DOWN

	var/obj/structure/fauna/mindsmiter_tendril/above
	var/obj/structure/fauna/mindsmiter_tendril/below
	var/is_top = FALSE
	var/is_bottom = FALSE
	var/electro_power = 30
	light_power = 0.8
	var/light_range = 1.2
	light_color = "#7fd6ff"
	var/mob/living/consuming_target = null
	var/consumption_time = 60
	var/aoe_radius = 1 // 3x3 pulse

/obj/structure/fauna/mindsmiter_tendril/Initialize()
	. = ..()
	set_light(light_power, light_range, light_range, l_color = light_color)
	RegisterSignal(get_turf(src), COMSIG_TURF_ENTERED, PROC_REF(getstinged))
	RegisterSignal(get_turf(src), COMSIG_TURF_EXITED, PROC_REF(escapedthetendril))

/obj/structure/fauna/mindsmiter_tendril/update_icon()
	. = ..()
	icon_state = "mindsmiter_tendril"

/obj/structure/fauna/mindsmiter_tendril/Crossed(atom/movable/AM)
	. = ..()
	return

/obj/structure/fauna/mindsmiter_tendril/proc/getstinged(turf/source, atom/movable/AM)
	SIGNAL_HANDLER
	if(!isliving(AM))
		return

	var/mob/living/L = AM
	if(L.z != z)
		return
	if(HAS_TRAIT(L, TRAIT_KNEESTINGER_IMMUNITY))
		return

	torturetheguy(L)
	snare_victim(L, 40)
	area_lightning_pulse(L)
	spawn(0)
		punish_grabbers_now(L)

	addtimer(CALLBACK(src, PROC_REF(punish_grabbers_now), L), 1)
	addtimer(CALLBACK(src, PROC_REF(punish_grabbers_now), L), 3)
	addtimer(CALLBACK(src, PROC_REF(punish_grabbers_now), L), 6)
	addtimer(CALLBACK(src, PROC_REF(post_zap_unconscious_check), L), 50)

/obj/structure/fauna/mindsmiter_tendril/proc/escapedthetendril(turf/source, atom/movable/AM)
	SIGNAL_HANDLER
	if(!isliving(AM))
		return

	var/mob/living/L = AM
	if(consuming_target == L)
		consuming_target.anchored = FALSE
		consuming_target = null

/obj/structure/fauna/mindsmiter_tendril/proc/torturetheguy(mob/living/L)
	if(L.electrocute_act(electro_power, src))
		L.reagents?.add_reagent(/datum/reagent/fogblight/corruption, 5)
		L.update_sneak_invis(TRUE)
		if(L.throwing)
			L.throwing.finalize(FALSE)
		L.visible_message(span_warning("[L] convulses as tendrils wrap around [L.p_them()]!"))

/obj/structure/fauna/mindsmiter_tendril/proc/snare_victim(mob/living/L, duration)
	if(!L)
		return
	L.anchored = TRUE
	addtimer(CALLBACK(src, PROC_REF(unsnare_victim), L), duration)

/obj/structure/fauna/mindsmiter_tendril/proc/unsnare_victim(mob/living/L)
	if(!L || QDELETED(L))
		return
	L.anchored = FALSE

/obj/structure/fauna/mindsmiter_tendril/proc/area_lightning_pulse(mob/living/exempt)
	var/turf/center = get_turf(src)
	if(!center)
		return

	for(var/turf/T in range(1, center))
		var/ring = (get_dist(center, T) == 1)

		for(var/mob/living/M in T.contents)
			if(!M || M == exempt || M.stat == DEAD)
				continue

			var/pow = ring ? max(1, round(electro_power * 0.8)) : max(1, round(electro_power * 0.5))
			var/kd  = ring ? rand(25, 40) : rand(10, 20)

			M.electrocute_act(pow, src)
			M.visible_message(span_warning("[M] is shocked by arcing tendrils!"))
			M.Knockdown(kd)

/obj/structure/fauna/mindsmiter_tendril/proc/punish_grabbers_now(mob/living/victim)
	if(!victim || QDELETED(victim))
		return
	if(victim.pulledby && isliving(victim.pulledby))
		var/mob/living/P = victim.pulledby
		punish_grabber(P, victim)
	if(islist(victim.grabbedby))
		for(var/obj/item/grabbing/vgr in victim.grabbedby)
			if(vgr && vgr.grabbee && isliving(vgr.grabbee))
				punish_grabber(vgr.grabbee, victim)
	var/turf/center = get_turf(src)
	if(!center)
		return

	for(var/turf/T in range(1, center))
		for(var/mob/living/G in T.contents)
			if(!G || G == victim || G.stat == DEAD)
				continue
			if(is_grabber_of(G, victim))
				punish_grabber(G, victim)

/obj/structure/fauna/mindsmiter_tendril/proc/is_grabber_of(mob/living/G, mob/living/V)
	if(!G || !V)
		return FALSE
	if(G.pulling == V)
		return TRUE
	for(var/obj/item/grabbing/gr in G.contents)
		if(gr && gr.grabbed == V)
			return TRUE
	if(islist(V.grabbedby))
		for(var/obj/item/grabbing/vgr in V.grabbedby)
			if(vgr && vgr.grabbee == G)
				return TRUE

	return FALSE

/obj/structure/fauna/mindsmiter_tendril/proc/punish_grabber(mob/living/G, mob/living/V)
	var/pow = max(1, round(electro_power * 1.0))
	G.electrocute_act(pow, src)
	G.reagents?.add_reagent(/datum/reagent/fogblight/corruption, 3) // poison the aggressor
	G.visible_message(span_warning("[G] is shocked as tendrils lash at their arms!"))
	G.Knockdown(rand(40, 60))

	if(iscarbon(G))
		var/mob/living/carbon/C = G
		C.add_grab_fatigue(2)
		C.adjust_stamina(rand(10, 20))
	if(G.pulling == V)
		G.stop_pulling(FALSE)
	for(var/obj/item/grabbing/gr in G.contents)
		if(gr && gr.grabbed == V)
			qdel(gr)

	if(islist(V.grabbedby))
		var/list/to_delete = list()
		for(var/obj/item/grabbing/vgr in V.grabbedby)
			if(vgr && vgr.grabbee == G)
				to_delete += vgr
		for(var/obj/item/grabbing/delgr in to_delete)
			qdel(delgr)

/obj/structure/fauna/mindsmiter_tendril/proc/post_zap_unconscious_check(mob/living/L)
	if(consuming_target || !L || QDELETED(L))
		return

	var/turf/my_turf = get_turf(src)
	var/turf/mob_turf = get_turf(L)
	if(!my_turf || !mob_turf)
		return
	if(my_turf != mob_turf)
		return

	if(L.stat == DEAD || L.stat == UNCONSCIOUS)
		isthisvoreworthy(L)

/obj/structure/fauna/mindsmiter_tendril/proc/isthisvoreworthy(mob/living/L)
	if(consuming_target || !L || QDELETED(L))
		return

	var/turf/my_turf = get_turf(src)
	var/turf/mob_turf = get_turf(L)
	if(!my_turf || !mob_turf)
		return
	if(my_turf != mob_turf)
		return

	if(L.stat != DEAD && L.stat != UNCONSCIOUS)
		return

	consuming_target = L
	L.anchored = TRUE
	L.visible_message(span_warning("Unholy tendrils began to wrap [L] before pulling [L.p_them()] upwards!"))

	var/original_alpha = L.alpha
	var/steps = consumption_time / 3

	animate(L, pixel_y = L.pixel_y + 8,  alpha = original_alpha * 0.8, time = steps, easing = EASE_OUT)
	animate(pixel_y = L.pixel_y + 16, alpha = original_alpha * 0.5, time = steps, easing = EASE_OUT)
	animate(pixel_y = L.pixel_y + 32, alpha = 0,                         time = steps, easing = EASE_OUT)

	addtimer(CALLBACK(src, PROC_REF(makethefurrieshappywithvore)), consumption_time)

/obj/structure/fauna/mindsmiter_tendril/proc/makethefurrieshappywithvore()
	if(!consuming_target || QDELETED(consuming_target))
		consuming_target = null
		return

	var/mob/living/L = consuming_target
	consuming_target = null
	L.visible_message(span_warning("[L] has been consumed by maws above!"))
	if(ismob(L))
		L.gib()
	else
		qdel(L)

/obj/structure/fauna/mindsmiter_tendril/Destroy()
	if(consuming_target)
		consuming_target.anchored = FALSE
		consuming_target = null
	return ..()



/obj/item/reagent_containers/food/snacks/mindsmiter_scum
	name = "mindsmiter scum"
	desc = "A lump of raw, edible spongy tissue torn from a mindsmiter.\
	It reeks of corruption, and mostly only edible for changeling's purifying stomaches."
	icon = 'modular/kaizoku/icons/mapset/florafauna.dmi'
	icon_state = "mindsmiter_scum"
	w_class = WEIGHT_CLASS_SMALL
	resistance_flags = NONE

/obj/item/reagent_containers/food/snacks/mindsmiter_scum/Initialize()
	. = ..()
	create_reagents(30)
	src.reagents?.add_reagent(/datum/reagent/organpoison, 1.5)
	src.reagents?.add_reagent(/datum/reagent/consumable/nutriment, SNACK_DECENT)

//Methane!!!!!!!!!!!
/obj/effect/geyser_water
	name = ""
	desc = ""
	icon = 'icons/effects/liquids.dmi'
	icon_state = "puddle"
	color = "#7baeec"
	anchored = TRUE
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	layer = GASFIRE_LAYER
	plane = GAME_PLANE

	var/life = 3 SECONDS
	var/scald_low = 8
	var/scald_high = 15
	var/static/list/mob_cooldowns = list()
	var/list/connected = list("1" = 0, "2" = 0, "4" = 0, "8" = 0)

/obj/effect/geyser_water/Initialize()
	. = ..()
	if(locate(/obj/structure/boiling_geyser) in loc)
		qdel(src)
		return
	START_PROCESSING(SSfastprocess, src)
	setup_connections()

/obj/effect/geyser_water/Destroy()
	STOP_PROCESSING(SSfastprocess, src)
	cleanup_connections()
	return ..()

/obj/effect/geyser_water/proc/setup_connections()
	for(var/direction in GLOB.cardinals)
		var/turf/cardinal_turf = get_step(src, direction)
		for(var/obj/effect/geyser_water/other_water in cardinal_turf)
			set_connection(get_dir(src, other_water))
			other_water.set_connection(get_dir(other_water, src))

/obj/effect/geyser_water/proc/cleanup_connections()
	for(var/direction in GLOB.cardinals)
		var/turf/cardinal_turf = get_step(src, direction)
		for(var/obj/effect/geyser_water/other_water in cardinal_turf)
			other_water.unset_connection(get_dir(other_water, src))
			other_water.update_icon()

/obj/effect/geyser_water/proc/set_connection(dir)
	connected["[dir]"] = 1
	update_icon()

/obj/effect/geyser_water/proc/unset_connection(dir)
	connected["[dir]"] = 0
	update_icon()

/obj/effect/geyser_water/update_icon()
	. = ..()
	var/key = ""
	if(connected["1"]) key += "1"
	if(connected["2"]) key += "2"
	if(connected["4"]) key += "4"
	if(connected["8"]) key += "8"
	if(!length(key))
		icon_state = "puddle"
		return

	var/list/states = icon_states(icon)

	if(states && (key in states))
		icon_state = key
		return

	var/list/state_map = list(
		"1" = "1", "2" = "2", "4" = "4", "8" = "8",
		"12" = "21",   // N+S
		"48" = "84",   // E+W
		"14" = "14",   // N+E
		"18" = "18",   // N+W
		"24" = "24",   // S+E
		"28" = "28",   // S+W
		"128" = "218", // N+S+W
		"124" = "214", // N+S+E
		"148" = "184", // N+E+W
		"248" = "284", // S+E+W
		"1248" = "2184" // Center
	)

	var/alt = state_map[key]
	if(alt && states && (alt in states))
		icon_state = alt
	else
		icon_state = "puddle"

/obj/effect/geyser_water/process()
	life--

	if(life <= 20 && life % 5 == 0) //Last 2 seconds, for every half second
		var/turf/T = get_turf(src)
		var/datum/effect_system/steam_spread/steam = new
		steam.set_up(1, 0, T)
		steam.start()

	if(life <= 0)
		var/turf/T2 = get_turf(src)
		var/datum/effect_system/steam_spread/steam2 = new
		steam2.set_up(2, 0, T2)
		steam2.start()
		qdel(src)
		return

	if(life % 30 == 0) // Every 3 seconds, more or less. Lag is making this quite a wildcard.
		var/turf/T3 = get_turf(src)
		for(var/mob/living/L in T3.contents)
			if(L.stat == DEAD)
				continue
			L.visible_message("<span class='warning'>[L] gets scalded by boiling water!</span>")
			L.adjustFireLoss(rand(25, 50)) //Big burn damage.

/obj/effect/geyser_water/Crossed(atom/movable/AM, oldloc)
	. = ..()
	if(!ishuman(AM))
		return
	var/mob/living/carbon/human/H = AM
	if((H.movement_type & FLYING) || H.buckled)
		return
	var/picked_def_zone = pick(BODY_ZONE_L_LEG, BODY_ZONE_R_LEG) //Apply burn only to the legs.
	var/obj/item/bodypart/O = H.get_bodypart(picked_def_zone)
	if(!istype(O))
		return

	H.apply_damage(rand(10, 20), BURN, picked_def_zone)
	playsound(get_turf(src), pick('sound/misc/water_wade1.ogg','sound/misc/water_wade2.ogg','sound/misc/water_wade3.ogg','sound/misc/water_wade4.ogg'), 50, FALSE)

	var/mob_id = "\ref[H]"
	var/next_allowed = mob_cooldowns[mob_id]
	if(!isnum(next_allowed) || world.time >= next_allowed)
		H.visible_message(
			"<span class='danger'>[H] stumbles through scalding water.</span>",
			"<span class='danger'>My feet burn as I stumble into this.</span>"
		)
		mob_cooldowns[mob_id] = world.time + 50

/obj/effect/permanent_smoke
	name = ""
	desc = ""
	icon = 'icons/effects/96x96.dmi'
	icon_state = "smoke"
	color = "#404040"
	alpha = 40 //Not very visible.
	anchored = TRUE
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	layer = GASFIRE_LAYER
	plane = GAME_PLANE
	pixel_x = -32
	pixel_y = -32
	var/triggered = FALSE
	var/trigger_cooldown = 100 // 10 seconds
	var/last_trigger_time = 0
	var/invisible_duration = 50 // 5 seconds invisible after trigger

/obj/effect/permanent_smoke/Initialize()
	. = ..()
	START_PROCESSING(SSfastprocess, src)
	RegisterSignal(loc, COMSIG_ATOM_ENTERED, PROC_REF(check_thrown_items))

/obj/effect/permanent_smoke/Destroy()
	STOP_PROCESSING(SSfastprocess, src)
	UnregisterSignal(loc, COMSIG_ATOM_ENTERED)
	return ..()

/obj/effect/permanent_smoke/process()
	if(triggered && world.time >= last_trigger_time + invisible_duration)
		triggered = FALSE
		alpha = 40
		mouse_opacity = MOUSE_OPACITY_TRANSPARENT

/obj/effect/permanent_smoke/proc/check_thrown_items(datum/source, atom/movable/AM)
	SIGNAL_HANDLER
	if(!isitem(AM))
		return
	var/obj/item/I = AM
	if(I.throwing && is_fire_source(I))
		trigger_area_fire()

/obj/effect/permanent_smoke/Crossed(atom/movable/AM, oldloc)
	. = ..()
	if(triggered)
		return
	if(!isliving(AM))
		return
	var/mob/living/M = AM
	if(!check_mob_fire_sources(M))
		return
	if(world.time < last_trigger_time + trigger_cooldown)
		return

	trigger_area_fire()

/obj/effect/permanent_smoke/proc/check_mob_fire_sources(mob/living/M)
	for(var/obj/item/I in M.get_all_contents())
		if(is_fire_source(I))
			return TRUE
	return FALSE

/obj/effect/permanent_smoke/proc/is_fire_source(obj/item/I)
	if(istype(I, /obj/item/flashlight/flare))
		var/obj/item/flashlight/flare/F = I
		if(F.on)
			return TRUE
	if(istype(I, /obj/item/candle))
		var/obj/item/candle/C = I
		if(C.lit)
			return TRUE
	return FALSE

/obj/effect/permanent_smoke/proc/trigger_area_fire()
	triggered = TRUE
	last_trigger_time = world.time
	alpha = 0 // Become invisible
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT

	var/turf/center = get_turf(src)
	visible_message("<span class='danger'>Something ignites!</span>")
	create_area_fire(center, 1) //big boom

	new /obj/effect/permanentfiretrap(center)
	for(var/turf/T in range(1, center))
		for(var/mob/living/L in T.contents)
			if(L.stat == DEAD)
				continue
			L.adjustFireLoss(rand(15, 25))
			L.adjust_fire_stacks(5)
			L.IgniteMob()

/obj/effect/permanent_smoke/fire_act()
	if(world.time >= last_trigger_time + trigger_cooldown)
		trigger_area_fire()

/obj/effect/permanent_smoke/spark_act()
	if(world.time >= last_trigger_time + trigger_cooldown)
		trigger_area_fire()

/obj/effect/permanentfiretrap
	name = ""
	desc = ""
	icon = 'icons/effects/fire.dmi'
	icon_state = "fire"
	anchored = TRUE
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	layer = GASFIRE_LAYER
	plane = GAME_PLANE
	var/life = 300 // 30 seconds
	var/damage_tick = 30 // 3 seconds between damage
	var/last_damage_time = 0

/obj/effect/permanentfiretrap/Initialize()
	. = ..()
	START_PROCESSING(SSfastprocess, src)
	last_damage_time = world.time

/obj/effect/permanentfiretrap/Destroy()
	STOP_PROCESSING(SSfastprocess, src)
	return ..()

/obj/effect/permanentfiretrap/process()
	life--
	if(life <= 0)
		qdel(src)
		return

	if(world.time >= last_damage_time + damage_tick)
		auto_ignite_occupants()
		last_damage_time = world.time

/obj/effect/permanentfiretrap/proc/auto_ignite_occupants()
	var/turf/T = get_turf(src)
	for(var/mob/living/L in T.contents)
		if(L.stat == DEAD)
			continue
		L.adjustFireLoss(rand(10, 15))
		L.adjust_fire_stacks(2)
		L.IgniteMob()

/obj/effect/permanentfiretrap/Crossed(atom/movable/AM, oldloc)
	. = ..()
	if(isliving(AM))
		var/mob/living/L = AM
		if(L.stat != DEAD)
			L.adjustFireLoss(rand(8, 12))
			L.adjust_fire_stacks(3)
			L.IgniteMob()

/obj/effect/area_fire
	icon = 'icons/effects/fire.dmi'
	icon_state = "fire"
	anchored = TRUE
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	layer = GASFIRE_LAYER
	plane = GAME_PLANE
	var/life = 200 //Longer lasting than regular fire
	var/damage_tick = 20 //How often it damages (2 seconds)
	var/last_damage_time = 0

/obj/effect/area_fire/Initialize()
	. = ..()
	START_PROCESSING(SSfastprocess, src)
	last_damage_time = world.time

/obj/effect/area_fire/Destroy()
	STOP_PROCESSING(SSfastprocess, src)
	return ..()

/obj/effect/area_fire/process()
	life--
	if(life <= 0)
		qdel(src)
		return

	if(world.time >= last_damage_time + damage_tick)
		damage_occupants()
		last_damage_time = world.time

/obj/effect/area_fire/proc/damage_occupants()
	var/turf/T = get_turf(src)
	for(var/mob/living/L in T.contents)
		if(L.stat == DEAD)
			continue
		L.adjustFireLoss(rand(12, 20))
		L.adjust_fire_stacks(3)
		L.IgniteMob()

/proc/create_area_fire(turf/center, radius)
	if(!center)
		return
	playsound(center, pick('sound/misc/explode/bottlebomb (1).ogg','sound/misc/explode/bottlebomb (2).ogg'), 100)

	for(var/turf/T in range(radius, center))
		if(!locate(/obj/effect/area_fire) in T)
			new /obj/effect/area_fire(T)

/proc/create_normal_fire_explosion(turf/center, range = 1)
	if(!center)
		return
	playsound(center, pick('sound/misc/explode/bottlebomb (1).ogg','sound/misc/explode/bottlebomb (2).ogg'), 100)
	explosion(center, light_impact_range = range, hotspot_range = range + 1, smoke = TRUE)
	for(var/turf/T in range(range, center))
		if(prob(60))
			new /obj/effect/oilspill(T)

/obj/effect/methane_gas
	icon = 'icons/effects/96x96.dmi'
	icon_state = "smoke"
	color = "#f0f8f0"
	alpha = 60
	anchored = TRUE
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	layer = GASFIRE_LAYER
	plane = GAME_PLANE
	pixel_x = -32
	pixel_y = -32
	var/life = 150
	var/ignited = FALSE

/obj/effect/methane_gas/Initialize()
	. = ..()
	START_PROCESSING(SSfastprocess, src)
	RegisterSignal(loc, COMSIG_ATOM_ENTERED, PROC_REF(check_thrown_fire_source))

/obj/effect/methane_gas/Destroy()
	STOP_PROCESSING(SSfastprocess, src)
	UnregisterSignal(loc, COMSIG_ATOM_ENTERED)
	return ..()

/obj/effect/methane_gas/proc/check_thrown_fire_source(datum/source, atom/movable/AM)
	SIGNAL_HANDLER
	if(!isitem(AM))
		return

	var/obj/item/I = AM
	if(I.throwing && is_fire_source(I))
		ignite_gas_area()

/obj/effect/methane_gas/process()
	life--
	if(life <= 0)
		qdel(src)
		return
	if(!ignited && check_turf_fire_sources()) //Check for fire sources on the turf each tick. Sadly, I could not make it a walkable trigger.
		ignite_gas_area()

/obj/effect/methane_gas/proc/ignite_gas_area()
	if(color == "#ff0000")
		return
	color = "#ff0000"

	var/turf/center = get_turf(src)
	visible_message("<span class='danger'>The methane gas ignites!</span>")
	for(var/turf/T in range(1, center))
		for(var/obj/effect/methane_gas/other_gas in T)
			if(other_gas != src)
				qdel(other_gas)
	create_area_fire(center, 1)

	for(var/turf/T in range(1, center))
		for(var/mob/living/L in T.contents)
			L.adjustFireLoss(rand(18, 30))
			L.adjust_fire_stacks(5)
			L.IgniteMob()

	qdel(src)

/obj/effect/methane_gas/proc/check_turf_fire_sources()
	var/turf/T = get_turf(src)
	for(var/obj/item/I in T.contents)
		if(is_fire_source(I))
			return TRUE
	return FALSE

/obj/effect/methane_gas/Crossed(atom/movable/AM, oldloc)
	. = ..()
	if(ignited)
		return
	if(!isliving(AM))
		return

	var/mob/living/M = AM
	if(check_mob_fire_sources(M))
		ignite_gas_area()

/obj/effect/methane_gas/proc/check_mob_fire_sources(mob/living/M)
	for(var/obj/item/I in M.get_all_contents())
		if(is_fire_source(I))
			return TRUE
	return FALSE

/obj/effect/methane_gas/proc/is_fire_source(obj/item/I)
	if(istype(I, /obj/item/flashlight/flare))
		var/obj/item/flashlight/flare/F = I
		if(F.on)
			return TRUE
	if(istype(I, /obj/item/candle))
		var/obj/item/candle/C = I
		if(C.lit)
			return TRUE
	return FALSE

/obj/effect/methane_gas/fire_act()
	ignite_gas_area()

/obj/effect/methane_gas/spark_act()
	ignite_gas_area()

/obj/structure/methane_geyser
	name = "geyser"
	desc = "A natural fissure on the ground. This one hisses... without any smell."
	icon = 'modular/kaizoku/icons/zionwork/tileset.dmi'
	icon_state = "zion362_soil_crater"
	anchored = TRUE
	density = FALSE
	var/gas_range_min = 1
	var/gas_range_max = 4
	var/gas_release_cooldown = 5 MINUTES
	var/next_release_time = 0
	var/spreading = FALSE
	var/proximity_range = 6

/obj/structure/methane_geyser/Initialize()
	. = ..()
	START_PROCESSING(SSobj, src)
	setup_proximity_triggers()

/obj/structure/methane_geyser/Destroy()
	STOP_PROCESSING(SSobj, src)
	cleanup_proximity_triggers()
	return ..()

/obj/structure/methane_geyser/proc/setup_proximity_triggers()
	var/turf/center = get_turf(src)
	for(var/turf/T in range(proximity_range, center))
		RegisterSignal(T, COMSIG_ATOM_ENTERED, PROC_REF(proximity_trigger))

/obj/structure/methane_geyser/proc/cleanup_proximity_triggers()
	var/turf/center = get_turf(src)
	for(var/turf/T in range(proximity_range, center))
		UnregisterSignal(T, COMSIG_ATOM_ENTERED)

/obj/structure/methane_geyser/proc/proximity_trigger(datum/source, atom/movable/AM)
	SIGNAL_HANDLER
	if(!isliving(AM))
		return
	if(world.time < next_release_time)
		return
	if(prob(5))
		force_release_gas()

/obj/structure/methane_geyser/process()
	if(world.time < next_release_time)
		return

	release_gas()
	next_release_time = world.time + gas_release_cooldown

/obj/structure/methane_geyser/proc/force_release_gas()
	if(spreading)
		return

	visible_message("<span class='warning'>Coincidently, The geyser hisses...</span>")
	release_gas()

	var/remaining = next_release_time - world.time
	if(remaining <= 0)
		remaining = gas_release_cooldown
	next_release_time = world.time + max(1, round(remaining / 2))

/obj/structure/methane_geyser/proc/release_gas()
	if(spreading)
		return
	spreading = TRUE

	var/gas_range = rand(gas_range_min, gas_range_max)
	visible_message("<span class='warning'>The geyser hisses...</span>")

	progressive_gas_spread(0, gas_range)

/obj/structure/methane_geyser/proc/progressive_gas_spread(current_range, max_range)
	var/turf/center = get_turf(src)

	if(current_range == 0)
		if(!locate(/obj/effect/methane_gas) in center)
			new /obj/effect/methane_gas(center)
	else
		for(var/turf/T in range(current_range, center))
			var/distance = get_dist(center, T)
			if(distance == current_range)
				if(prob(80))
					if(!locate(/obj/effect/methane_gas) in T)
						new /obj/effect/methane_gas(T)

	if(current_range < max_range)
		spawn(15)
			progressive_gas_spread(current_range + 1, max_range)
	else
		spreading = FALSE

/obj/structure/boiling_geyser
	name = "geyser"
	desc = "A natural fissure on the ground. This one releases steam..."
	icon = 'modular/kaizoku/icons/zionwork/tileset.dmi'
	icon_state = "zion362_soil_crater"
	anchored = TRUE
	density = FALSE
	var/water_range_min = 1
	var/water_range_max = 4
	var/water_release_cooldown = 5 MINUTES
	var/next_release_time = 0
	var/spreading = FALSE
	var/proximity_range = 6

/obj/structure/boiling_geyser/Initialize()
	. = ..()
	START_PROCESSING(SSobj, src)
	setup_proximity_triggers()

/obj/structure/boiling_geyser/Destroy()
	STOP_PROCESSING(SSobj, src)
	cleanup_proximity_triggers()
	return ..()

/obj/structure/boiling_geyser/proc/setup_proximity_triggers()
	var/turf/center = get_turf(src)
	for(var/turf/T in range(proximity_range, center))
		RegisterSignal(T, COMSIG_ATOM_ENTERED, PROC_REF(proximity_trigger))

/obj/structure/boiling_geyser/proc/cleanup_proximity_triggers()
	var/turf/center = get_turf(src)
	for(var/turf/T in range(proximity_range, center))
		UnregisterSignal(T, COMSIG_ATOM_ENTERED)

/obj/structure/boiling_geyser/proc/proximity_trigger(datum/source, atom/movable/AM)
	SIGNAL_HANDLER
	if(!isliving(AM))
		return

	// Only one forced trigger per natural cycle
	if(world.time < next_release_time)
		return

	if(prob(5))
		force_release_water()

/obj/structure/boiling_geyser/process()
	if(world.time < next_release_time)
		return

	release_water()
	next_release_time = world.time + water_release_cooldown

/obj/structure/boiling_geyser/proc/force_release_water()
	if(spreading)
		return

	visible_message("<span class='warning'>The geyser rumbles...</span>")
	release_water()

	// Halve the remaining time (or half a fresh full cooldown if none scheduled)
	var/remaining = next_release_time - world.time
	if(remaining <= 0)
		remaining = water_release_cooldown
	next_release_time = world.time + max(1, round(remaining / 2))

/obj/structure/boiling_geyser/proc/release_water()
	if(spreading)
		return
	spreading = TRUE

	var/water_range = rand(water_range_min, water_range_max)
	visible_message("<span class='warning'>The geyser rumbles...</span>")

	spawn(10)
		visible_message("<span class='danger'>The geyser erupts!</span>")
		enhanced_water_spread(0, water_range)
		spawn((water_range * 8) + 20)
			spreading = FALSE

/obj/structure/boiling_geyser/proc/enhanced_water_spread(current_range, max_range)
	var/turf/center = get_turf(src)

	if(current_range == 0)
		new /obj/effect/geyser_water(center)
	else
		for(var/turf/T in range(current_range, center))
			var/distance = get_dist(center, T)
			if(distance == current_range)
				if(prob(85))
					new /obj/effect/geyser_water(T)
					for(var/mob/living/L in T.contents)
						if(L.stat == DEAD)
							continue

						var/push_strength = (max_range - current_range + 2) * 2
						var/push_dir = get_dir(center, L)

						spawn(0)
							for(var/i = 1 to 2)
								if(push_dir)
									var/turf/target = get_step(L, push_dir)
									if(target && !target.density)
										L.throw_at(target, push_strength, 2)
								sleep(5)

						L.Knockdown(30 + (push_strength * 5))
						L.visible_message("<span class='danger'>[L] is blasted!</span>")
						L.adjustFireLoss(rand(40, 80)) //big damage.

	if(current_range < max_range)
		spawn(8)
			enhanced_water_spread(current_range + 1, max_range)

/obj/structure/fogblight_geyser
	name = "geyser"
	desc = "A natural fissure on the ground. This one hisses... with an oppressive smell."
	icon = 'modular/kaizoku/icons/zionwork/tileset.dmi'
	icon_state = "zion362_soil_crater"
	anchored = TRUE
	density = FALSE
	var/fog_range_min = 1
	var/fog_range_max = 4
	var/fog_release_cooldown = 5 MINUTES
	var/next_release_time = 0
	var/spreading = FALSE
	var/proximity_range = 6

/obj/structure/fogblight_geyser/Initialize()
	. = ..()
	START_PROCESSING(SSobj, src)
	setup_proximity_triggers()

/obj/structure/fogblight_geyser/Destroy()
	STOP_PROCESSING(SSobj, src)
	cleanup_proximity_triggers()
	return ..()

/obj/structure/fogblight_geyser/proc/setup_proximity_triggers()
	var/turf/center = get_turf(src)
	for(var/turf/T in range(proximity_range, center))
		RegisterSignal(T, COMSIG_ATOM_ENTERED, PROC_REF(proximity_trigger))

/obj/structure/fogblight_geyser/proc/cleanup_proximity_triggers()
	var/turf/center = get_turf(src)
	for(var/turf/T in range(proximity_range, center))
		UnregisterSignal(T, COMSIG_ATOM_ENTERED)

/obj/structure/fogblight_geyser/proc/proximity_trigger(datum/source, atom/movable/AM)
	SIGNAL_HANDLER
	if(!isliving(AM))
		return
	if(world.time < next_release_time)
		return

	if(prob(5))
		force_release_fog()

/obj/structure/fogblight_geyser/process()
	if(world.time < next_release_time)
		return

	release_fog()
	next_release_time = world.time + fog_release_cooldown

/obj/structure/fogblight_geyser/proc/force_release_fog()
	if(spreading)
		return

	visible_message("<span class='warning'>The geyser begins to hizz...</span>")
	release_fog()

	var/remaining = next_release_time - world.time
	if(remaining <= 0)
		remaining = fog_release_cooldown
	next_release_time = world.time + max(1, round(remaining / 2))

/obj/structure/fogblight_geyser/proc/release_fog()
	if(spreading)
		return
	spreading = TRUE

	var/fog_range = rand(fog_range_min, fog_range_max)
	visible_message("<span class='warning'>Toxic fog is lifted!</span>")

	progressive_fog_spread(0, fog_range)

/obj/structure/fogblight_geyser/proc/progressive_fog_spread(current_range, max_range)
	var/turf/center = get_turf(src)

	if(current_range == 0)
		var/datum/reagents/R = new/datum/reagents(30)
		R.my_atom = src
		R.add_reagent(/datum/reagent/fogblight/corruption, 30)

		var/datum/effect_system/smoke_spread/chem/smoke = new
		smoke.set_up(R, 0, center, null)
		smoke.start()
	else
		for(var/turf/T in range(current_range, center))
			var/distance = get_dist(center, T)
			if(distance == current_range)
				if(prob(70))
					var/datum/reagents/R = new/datum/reagents(30)
					R.my_atom = src
					R.add_reagent(/datum/reagent/fogblight/corruption, 30)

					var/datum/effect_system/smoke_spread/chem/smoke = new
					smoke.set_up(R, 0, T, null)
					smoke.start()

	if(current_range < max_range)
		spawn(20)
			progressive_fog_spread(current_range + 1, max_range)
	else
		spreading = FALSE
