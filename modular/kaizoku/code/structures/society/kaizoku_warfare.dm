/obj/structure/loomshot
	name = ""
	desc = ""
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	icon = 'modular/kaizoku/icons/mapset/warfare64x64.dmi'
	icon_state = "loomshot_closed"
	anchored = TRUE
	density = TRUE
	layer = OBJ_LAYER
	max_integrity = 500

	var/long_range = 9      // Long distance threshold
	var/medium_range = 4    // Medium distance threshold
	var/short_range = 2     // Short distance (shotgun mode)

	var/fire_delay = 0.3 SECONDS
	var/last_fire = 0

	var/open_time = 1.4 SECONDS
	var/reset_time = 6 SECONDS
	var/volley_pause = 1.5 SECONDS

	var/volley_size = 6
	var/volley_shots = 0
	var/volleys_fired = 0
	var/max_volleys = 4

	var/opened = FALSE
	var/firing = FALSE
	var/opening = FALSE
	var/resetting = FALSE
	var/in_volley_pause = FALSE

	var/locked_dir = SOUTH
	var/mob/living/current_target = null

	var/list/suppressed_ever = list()
	var/list/soldier_names = list("Custodian Loader", "Custodian Charger")
	var/last_speaker_index = 0

	var/list/loader_aggro_lines
	var/list/loader_reset_lines
	var/list/loader_lower_lines
	var/list/loader_raise_lines

	var/list/charger_aggro_lines
	var/list/charger_reset_lines
	var/list/charger_lower_lines
	var/list/charger_raise_lines

	var/list/charger_retreat_lines
	var/list/loader_retreat_lines

	var/dialogue_active = FALSE
	var/current_range_mode = "long"

	var/announced_medium = FALSE
	var/announced_short = FALSE
	var/is_destroyed = FALSE

/obj/structure/loomshot/proc/update_visibility()
	if(opened)
		name = "clocker loomshot"
		desc = "Experimental foglander defensive siege weaponry that shoots volleys of low-velocity shards at intruders."
		mouse_opacity = MOUSE_OPACITY_OPAQUE
	else
		name = ""
		desc = ""
		mouse_opacity = MOUSE_OPACITY_TRANSPARENT

/obj/structure/loomshot/Initialize()
	. = ..()
	START_PROCESSING(SSfastprocess, src)

	loader_aggro_lines  = load_speech_file("modular/kaizoku/code/strings/loomsquad/loader_aggro.txt")
	loader_reset_lines  = load_speech_file("modular/kaizoku/code/strings/loomsquad/loader_reset.txt")
	loader_lower_lines  = load_speech_file("modular/kaizoku/code/strings/loomsquad/loader_lower.txt")
	loader_raise_lines  = load_speech_file("modular/kaizoku/code/strings/loomsquad/loader_raise.txt")

	charger_aggro_lines = load_speech_file("modular/kaizoku/code/strings/loomsquad/charger_aggro.txt")
	charger_reset_lines = load_speech_file("modular/kaizoku/code/strings/loomsquad/charger_reset.txt")
	charger_lower_lines = load_speech_file("modular/kaizoku/code/strings/loomsquad/charger_lower.txt")
	charger_raise_lines = load_speech_file("modular/kaizoku/code/strings/loomsquad/charger_raise.txt")

	charger_retreat_lines = load_speech_file("modular/kaizoku/code/strings/loomsquad/charger_wounded.txt")
	loader_retreat_lines = load_speech_file("modular/kaizoku/code/strings/loomsquad/loader_warning.txt")

/obj/structure/loomshot/proc/load_speech_file(path)
	var/text = file2text(path)
	if(!text)
		return list()

	var/list/L = list()
	for(var/line in splittext(text, "\n"))
		line = trim(line)
		if(!line)
			continue
		L += line
	return L

/obj/structure/loomshot/process()
	if(QDELETED(src))
		return
	// Don't do anything while opening, resetting, or pausing between volleys
	if(opening || resetting || in_volley_pause)
		return
	if(firing)
		handle_firing()
		return
	if(!opened)	// If not firing, look for targets
		var/mob/living/target = find_target()
		if(target)
			current_target = target
			start_sequence()

/obj/structure/loomshot/proc/handle_firing()
	if(!current_target || QDELETED(current_target) || current_target.stat >= UNCONSCIOUS)
		stop_firing()
		return
	var/dist = get_dist(src, current_target)
	if(dist > long_range)
		stop_firing()
		return
	update_locked_dir()

	// Validate target still exists and is conscious
	var/new_range_mode = "long"
	if(dist <= short_range)
		new_range_mode = "short"
	else if(dist <= medium_range)
		new_range_mode = "medium"

	// Announce range mode changes ONCE per combat sequence
	if(new_range_mode != current_range_mode)
		current_range_mode = new_range_mode
		if(new_range_mode == "short" && !announced_short)
			announced_short = TRUE
			shotgun_speech()
			visible_message("<span class='danger'>The loomshot's barrels swing down to point-blank range!</span>")
		else if(new_range_mode == "medium" && !announced_medium)
			announced_medium = TRUE
			speak_lower_weapon()
			visible_message("<span class='warning'>The loomshot's arch lowers - lying down won't save you now!</span>")
	if(world.time < last_fire + fire_delay)
		return

	if(dist <= short_range)	// SHORT RANGE: Fire entire volley at once (shotgun mode)
		for(var/i = 1 to volley_size)
			fire_loomshot_projectile(dist, "short")
		volley_shots = volley_size
		last_fire = world.time
	else
		fire_loomshot_projectile(dist, (dist <= medium_range ? "medium" : "long")) // MEDIUM/LONG RANGE: Fire single bullets
		volley_shots++
		last_fire = world.time

	if(volley_shots >= volley_size)
		volley_shots = 0
		volleys_fired++

		if(volleys_fired >= max_volleys)
			stop_firing()
		else
			firing = FALSE
			in_volley_pause = TRUE
			addtimer(CALLBACK(src, .proc/resume_firing), volley_pause)

/obj/structure/loomshot/proc/fire_loomshot_projectile(dist, range_mode)
	var/turf/start_turf = get_turf(src)
	if(!start_turf)
		return

	var/obj/projectile/bullet/loomshot/P = new(start_turf)
	P.firer = src
	P.fired_from = src
	P.loomshot_parent = src
	P.starting = start_turf

	switch(range_mode)
		if("short")
			P.ignore_lying = FALSE
			P.accuracy = 95
			P.damage = 60
			playsound(get_turf(src), 'modular/kaizoku/sound/warfaresounds/loomshot_shotgun.ogg', 70, FALSE)
		if("medium")
			P.ignore_lying = FALSE
			P.accuracy = 65
			P.damage = 50
			playsound(get_turf(src), 'modular/kaizoku/sound/warfaresounds/loomshot_actingup.ogg', 70, FALSE)
		if("long")
			P.ignore_lying = TRUE
			P.accuracy = 80
			P.damage = 50
			playsound(get_turf(src), 'modular/kaizoku/sound/warfaresounds/loomshot_actingup.ogg', 70, FALSE)
	P.preparePixelProjectile(current_target, src)
	P.fire()

/obj/structure/loomshot/proc/resume_firing()
	if(QDELETED(src))
		return

	in_volley_pause = FALSE

	if(!current_target || QDELETED(current_target) || current_target.stat >= UNCONSCIOUS)
		stop_firing()
		return

	var/dist = get_dist(src, current_target)
	if(dist > long_range)
		stop_firing()
		return

	firing = TRUE

/obj/structure/loomshot/proc/start_sequence()
	if(!current_target || QDELETED(current_target))
		return

	opening = TRUE
	opened = TRUE
	update_visibility()
	update_locked_dir()

	icon_state = "loomshot_open"
	flick("loomshot_open_animated", src)

	aggro_speech()

	addtimer(CALLBACK(src, .proc/begin_firing), open_time)

/obj/structure/loomshot/proc/begin_firing()
	if(QDELETED(src))
		return
	if(!current_target || QDELETED(current_target) || current_target.stat >= UNCONSCIOUS)
		stop_firing()
		return

	opening = FALSE
	firing = TRUE
	volley_shots = 0
	volleys_fired = 0
	last_fire = 0
	current_range_mode = "long"

/obj/structure/loomshot/proc/stop_firing()
	if(QDELETED(src))
		return

	firing = FALSE
	in_volley_pause = FALSE
	resetting = TRUE

	speak_reset()
	addtimer(CALLBACK(src, .proc/finish_reset), reset_time)

/obj/structure/loomshot/proc/finish_reset()
	if(QDELETED(src))
		return
	icon_state = "loomshot_closed"
	flick("loomshot_closed_animated", src)
	addtimer(CALLBACK(src, .proc/complete_reset), 1 SECONDS)

/obj/structure/loomshot/proc/complete_reset()
	if(QDELETED(src))
		return

	resetting = FALSE
	opened = FALSE
	update_visibility()
	volley_shots = 0
	volleys_fired = 0
	last_fire = 0
	current_range_mode = "long"
	current_target = null
	announced_medium = FALSE
	announced_short = FALSE

	suppressed_ever.Cut()

/obj/structure/loomshot/proc/find_target()
	for(var/mob/living/L in oview(long_range, src))
		if(QDELETED(L))
			continue
		if(L.stat >= UNCONSCIOUS)
			continue
		if(L.client)
			return L
	for(var/mob/living/L in oview(long_range, src))
		if(QDELETED(L))
			continue
		if(L.stat >= UNCONSCIOUS)
			continue
		return L

	return null

/obj/structure/loomshot/proc/apply_suppression(mob/living/L)
	if(QDELETED(L))
		return
	if(L in suppressed_ever)
		return

	suppressed_ever += L
	L.Knockdown(3 SECONDS)

	L.visible_message(
		"<span class='danger'>A storm of bolts pins [L] down!</span>",
		"<span class='userdanger'>You are pinned by suppressive fire!</span>"
	)

/obj/structure/loomshot/proc/update_locked_dir()
	if(!current_target || QDELETED(current_target))
		return

	var/dx = current_target.x - src.x
	var/dy = current_target.y - src.y

	if(abs(dx) >= abs(dy))
		locked_dir = (dx > 0) ? EAST : WEST
	else
		locked_dir = (dy > 0) ? NORTH : SOUTH

	dir = locked_dir

/obj/structure/loomshot/proc/aggro_speech()
	if(!current_target || QDELETED(current_target))
		return
	var/speaker = rotate_speaker()
	var/speech_list = (speaker == "Custodian Loader") ? loader_aggro_lines : charger_aggro_lines
	if(speech_list && length(speech_list))
		var/speech = pick(speech_list)
		visible_message("<span class='say'><b>[speaker]</b> shouts, \"[speech]\"</span>")

/obj/structure/loomshot/proc/speak_reset()
	var/speaker = rotate_speaker()
	var/speech_list = (speaker == "Custodian Loader") ? loader_reset_lines : charger_reset_lines
	if(speech_list && length(speech_list))
		var/speech = pick(speech_list)
		visible_message("<span class='say'><b>[speaker]</b> says, \"[speech]\"</span>")

/obj/structure/loomshot/proc/speak_lower_weapon()
	var/speaker = rotate_speaker()
	var/speech_list = (speaker == "Custodian Loader") ? loader_lower_lines : charger_lower_lines
	if(speech_list && length(speech_list))
		var/speech = pick(speech_list)
		visible_message("<span class='say'><b>[speaker]</b> yells, \"[speech]\"</span>")

/obj/structure/loomshot/proc/shotgun_speech()
	var/speaker = rotate_speaker()
	var/list/lines = list(
		"Bastard is too close. Give 'em the hells.",
		"Loading the sluggets!",
		"CLOSE UP!",
		"Close enough for hell!",
		"Parry this!"
	)
	visible_message("<span class='say'><b>[speaker]</b> roars, \"[pick(lines)]\"</span>")

/obj/structure/loomshot/proc/rotate_speaker()
	last_speaker_index++
	if(last_speaker_index > soldier_names.len)
		last_speaker_index = 1
	return soldier_names[last_speaker_index]

/obj/structure/loomshot/Destroy()
	STOP_PROCESSING(SSfastprocess, src)

	name = ""
	desc = ""
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT

	icon_state = "loomshot_destroyed"
	flick("loomshot_destroyed_animated", src)

	soft_explosion(get_turf(src), 4, 4, 4)

	. = ..()

/obj/item/ammo_casing/caseless/loomshot
	name = "lead pelletize"
	desc = "Byproducts from lead ball fabrication. Used in experimental foglander war machines."
	projectile_type = /obj/projectile/bullet/loomshot
	caliber = "loomshot"
	icon = 'modular/kaizoku/icons/weapons/ammo.dmi'
	icon_state = "loomshot"
	dropshrink = 0.5
	possible_item_intents = list(/datum/intent/use)
	force = 2

/obj/projectile/bullet/loomshot
	name = "pelletize"
	damage = 50
	damage_type = BRUTE
	icon = 'modular/kaizoku/icons/weapons/ammo.dmi'
	icon_state = "loomshot_proj"
	range = 20
	hitsound = 'sound/combat/hits/hi_arrow2.ogg'
	embedchance = 80
	armor_penetration = 40
	woundclass = BCLASS_BLUNT
	flag = "blunt"
	speed = 0.4
	accuracy = 75
	var/ignore_lying = FALSE
	var/obj/structure/loomshot/loomshot_parent = null

/obj/projectile/bullet/loomshot/can_hit_target(atom/target, direct_target = FALSE, ignore_loc = FALSE)
	if(isliving(target))
		var/mob/living/L = target
		if(L.body_position == LYING_DOWN && ignore_lying)
			return FALSE
	return ..()

/obj/projectile/bullet/loomshot/on_hit(atom/target, blocked = FALSE)
	. = ..()
	if(!isliving(target))
		return
	var/mob/living/L = target
	if(loomshot_parent)
		loomshot_parent.apply_suppression(L)

/obj/structure/loomshot/atom_destruction(damage_flag)
	if(is_destroyed)
		return TRUE
	is_destroyed = TRUE
	bombingthemselves()
	return ..(damage_flag)

/obj/structure/loomshot/proc/bombingthemselves()
	if(QDELETED(src))
		return

	STOP_PROCESSING(SSfastprocess, src)
	firing = FALSE
	opening = FALSE
	resetting = FALSE
	in_volley_pause = FALSE
	current_target = null

	mouse_opacity = MOUSE_OPACITY_OPAQUE
	density = FALSE

	flick("loomshot_destruction_animated", src)
	icon_state = "loomshot_destruction"
	visible_message("<span class='userdanger'>Explosive barrels has been lit!</span>")

	addtimer(CALLBACK(src, .proc/explosion_warning_3), 2 SECONDS)
	addtimer(CALLBACK(src, .proc/explosion_warning_2), 3.5 SECONDS)
	addtimer(CALLBACK(src, .proc/explosion_warning_1), 4.5 SECONDS)
	addtimer(CALLBACK(src, .proc/detonate), 5 SECONDS)

/obj/structure/loomshot/proc/explosion_warning_3()
	if(QDELETED(src))
		return
	visible_message("<span class='danger'>Sparks starts to be released from below.</span>")
	shake(1, 20)

/obj/structure/loomshot/proc/explosion_warning_2()
	if(QDELETED(src))
		return
	visible_message("<span class='danger'>Smoke pours out of the Loomshot.</span>")
	shake(2, 30)

/obj/structure/loomshot/proc/explosion_warning_1()
	if(QDELETED(src))
		return
	visible_message("<span class='userdanger'>Something has hit blackpowder.</span>")
	shake(3, 40)

/obj/structure/loomshot/proc/detonate()
	if(QDELETED(src))
		return
	visible_message("<span class='userdanger'>The Loomshot explodes into shrapnels.</span>")
	soft_explosion(get_turf(src), 4, 4, 4)

	new /obj/structure/loomshot_broken(get_turf(src))
	qdel(src)

/obj/structure/loomshot/proc/shake(strength, duration)
	var/ox = pixel_x
	var/oy = pixel_y
	for(var/i = 1 to duration)
		pixel_x = ox + (i % 2 ? strength : -strength)
		pixel_y = oy + (i % 2 ? -strength : strength)
		sleep(1)
	pixel_x = ox
	pixel_y = oy

/obj/structure/loomshot_broken
/obj/structure/loomshot_broken
	name = "destroyed loomshot"
	desc = "A shattered loomshot, torn apart by internal detonation."
	icon = 'modular/kaizoku/icons/mapset/warfare64x64.dmi'
	icon_state = "loomshot_destruction"
	anchored = TRUE
	density = FALSE
	layer = OBJ_LAYER
	mouse_opacity = MOUSE_OPACITY_OPAQUE
	resistance_flags = INDESTRUCTIBLE
