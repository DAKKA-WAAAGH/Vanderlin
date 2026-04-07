/datum/job/kaizoku/sieger
	title = "Imperial Engineer"
	department_flag = FACTION_IMPERIAL
	total_positions = 2
	spawn_positions = 2
	job_flags = (JOB_ANNOUNCE_ARRIVAL | JOB_SHOW_IN_CREDITS | JOB_EQUIP_RANK | JOB_NEW_PLAYER_JOINABLE)
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_CITIZEN_PLAYERS //To be this job, you require studies. Only citizens have this right.
	allowed_ages = list(AGE_ADULT, AGE_MIDDLEAGED, AGE_IMMORTAL)
	display_order = KZ_SIEGER
	tutorial = "You are a naval siege engineer who takes mathematics to absolute terms. \
	You repel the threat of greater powers on the snap of a hope, or the end of the fuse. \
	You've been hired by the Quartermaster to ensure that the walls of the tower will never \
	be breached, while making sure the wall of others will crumble, and by Abyssor \
	above, you know how far walls can go both ways."

	give_bank_account = 30
	// min_pq = 0 ; Stonekeep Todo - Vanderlin removed PQ, reimplement it later.
	selection_color = "#920909"
	outfit = /datum/outfit/job/kaizoku/sieger
	cmode_music = 'sound/music/cmode/nobility/CombatKnight.ogg' //going to change for another one.

/datum/outfit/job/kaizoku/sieger/pre_equip(mob/living/carbon/human/H)
	..()
	belt = /obj/item/storage/belt/leather
	beltl = /obj/item/goblin_bomb //As a treat.
	beltr = /obj/item/weapon/axe/adze
	neck = /obj/item/storage/belt/pouch/coins/poor
	gloves = /obj/item/clothing/gloves/leather/abyssal
	shirt = /obj/item/clothing/armor/gambeson/heavy/battleshirt // Recognition sake.
	pants = /obj/item/clothing/pants/trou/tobi/random
	backl = /obj/item/storage/backpack/satchel
	if(H.dna.species?.id != "abyssariad" && H.dna.species.name != "Undine")
		head = /obj/item/clothing/head/helmet/leather/paddedt
		armor = /obj/item/clothing/armor/leather/jacket/custodian
	else
		head = /obj/item/clothing/head/helmet/leather/paddedt/alt
		armor = /obj/item/clothing/armor/leather/jacket/custodian/foglander
	backpack_contents = list(/obj/item/flint = 1, /obj/item/natural/bundle/stoneblock/four = 1) //WIP. add siege machine crafter here.

	if(H.mind)
		H.adjust_skillrank(/datum/skill/combat/swords, 1, TRUE)
		H.adjust_skillrank(/datum/skill/combat/axesmaces, 3, TRUE) //You are Garrison, you are a Sapper type of unit. Wielding axes should be a norm. Can be decreased to 2 later.
		H.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE) //You're more combat-oriented than most 'working' roles, plus, your work is exhausting.
		H.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
		H.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
		H.adjust_skillrank(/datum/skill/misc/swimming, pick(0,0,1), TRUE)
		H.adjust_skillrank(/datum/skill/misc/climbing, 1, TRUE) //You are not the best at warfare.
		H.adjust_skillrank(/datum/skill/craft/crafting, pick(1,2,2), TRUE)
		H.adjust_skillrank(/datum/skill/craft/carpentry, pick(1,1,2), TRUE) // Part of your duty.
		H.adjust_skillrank(/datum/skill/craft/engineering, 4, TRUE) // Require to create bombs, catapults, etc. Your true MAIN thing.
		H.adjust_skillrank(/datum/skill/craft/traps, 3, TRUE) // For craftable beartraps
		H.adjust_skillrank(/datum/skill/misc/reading, 3, TRUE) // You know math, so you should be >WELL< literate.
		H.adjust_skillrank(/datum/skill/misc/sewing, pick(1,1,2), TRUE) //Rope making. Unless that's crafting, if so, decrease to 1 or zero.
		H.adjust_skillrank(/datum/skill/craft/smelting, 2, TRUE) //For making iron bars. You will need them. Hopefully this isn't a gamechanger, if it is, remove.
		H.change_stat("strength", 1)
		H.change_stat("endurance", 2) // More endurance for the lack of 'malum fire' perk. If it isn't fair, tell me. (+0.5p)
		H.change_stat("constitution", 2) // More constitution because it makes /sense/ for someone that have to break down walls. Tell me if it isn't fair. (+0.5p)
		H.change_stat("speed", -1)
		// END and COST is valued as 0.5 points ; (+0.5p) + (+0.5p) = 1 additional point for the replacement of malum fire smiths usually have. Sieger is no smith.

/obj/item/roguemachine/siegebuilder
	name = "siege workspace"
	desc = "To quickly deploy and create siege machines, custodian engineers makes use of this portable table."
	icon = 'modular/kaizoku/icons/mapset/furniture_32x32.dmi'
	icon_state = "siegeworkshop"
	density = TRUE
	anchored = TRUE
	w_class = WEIGHT_CLASS_GIGANTIC
	blade_dulling = DULLING_BASH

	var/list/stored_goods = list(
		/obj/item/grown/log/tree = 0,
		/obj/item/natural/bundle/plank = 0,
		/obj/item/rope = 0,
		/obj/item/ingot/iron = 0
	)
	var/list/build_options = list(
		"Catapult Assembly (1 Big Log)" = list(type = /obj/structure/siege/catapult/base, req = /obj/item/grown/log/tree, time = 30),
		"Firewagon Assembly (1 Big Log)" = list(type = /obj/structure/siege/hwancha/base, req = /obj/item/grown/log/tree, time = 40),
		"Make Launcher Arm (1 Big Log > 1 Rope)" = list(type = /obj/item/siege_part/launcher_arm, req = /obj/item/grown/log/tree, time = 25),
		"Make Wheel (1 Plank)" = list(type = /obj/item/siege_part/wheel_unfinished, req = /obj/item/natural/bundle/plank, time = 15),
		"Make Launch Pad (1 Plank)" = list(type = /obj/item/siege_part/launchpad, req = /obj/item/natural/bundle/plank, time = 10),
		"Make Iron Straps x3 (1 Iron)" = list(type = /obj/item/siege_part/iron_strap, req = /obj/item/ingot/iron, time = 25, amount = 3),
		"Make Sight Rail (1 Plank)" = list(type = /obj/item/siege_part/sightrail, req = /obj/item/natural/bundle/plank, time = 25),
		"Make Winch & Pulley (1 Iron)" = list(type = /obj/item/siege_part/winch_pulley, req = /obj/item/ingot/iron, time = 25),
		"Make Goblinoid Mindbreaker (1 Iron)" = list(type = /obj/item/siege_part/goblinoid_mindbreaker, req = /obj/item/ingot/iron, time = 25),
		"Make Goblinoid Cage (1 Iron)" = list(type = /obj/item/siege_part/goblinoid_cage, req = /obj/item/ingot/iron, time = 25),
		"Make Sanctiflux Barrel (1 Plank >1 fyritius)" = list(type = /obj/item/siege_part/sanctifluxbarrel_unfinished, req = /obj/item/natural/bundle/plank, time = 25),
		"Make Sanctiflux Starter (1 Iron)" = list(type = /obj/item/siege_part/sanctiflux_starter, req = /obj/item/ingot/iron, time = 25),
		"Make Automata Core (1 Iron > 1 Meat)" = list(type = /obj/item/siege_part/automata_core, req = /obj/item/ingot/iron, time = 25),
		"Make Iron Gear (1 Iron)" = list(type = /obj/item/gear/metal, req = /obj/item/ingot/iron, time = 25)
	)

/obj/item/roguemachine/siegebuilder/attackby(obj/item/I, mob/user)
	var/T = I.type
	if(!isnull(stored_goods[T]))
		qdel(I)
		stored_goods[T] += 1
		to_chat(user, span_notice("You insert the [initial(I.name)] under the table."))
	else
		. = ..()

/obj/item/roguemachine/siegebuilder/attack_hand(mob/user)
	if(!Adjacent(user))
		to_chat(user, span_warning("You're too far to use the siege workspace."))
		return

	user.changeNext_move(CLICK_CD_MELEE)

	var/content = "<center><b>... SAW, CHISEL AND ADZE ...</b></center><hr>"
	content += "<b>... MATERIALS UNDER THE TABLE...</b><br>"

	for(var/T in stored_goods)
		var/amt = stored_goods[T]
		var/obj/item/preview = new T
		content += "[preview.name]: [amt]<br>"
		qdel(preview)

	content += "<hr><b>... THE ASSEMBLIES ...</b><br>"
	for(var/option in build_options)
		if(findtext(option, "Assembly"))
			content += "<a href='byond://?src=[REF(src)];build=[option]'>[option]</a><br>"

	content += "<hr><b>... THE PARTS ...</b><br>"
	for(var/option in build_options)
		if(!findtext(option, "Assembly"))
			content += "<a href='byond://?src=[REF(src)];build=[option]'>[option]</a><br>"

	var/datum/browser/popup = new(user, "SIEGEBUILDER", "", 400, 500)
	popup.set_content(content)
	popup.open()

/obj/item/roguemachine/siegebuilder/Topic(href, href_list)
	. = ..()
	if(href_list["build"])
		var/option = href_list["build"]
		var/list/info = build_options[option]
		if(!info)
			return

		var/req = info["req"]
		var/type = info["type"]
		var/time = info["time"]
		var/amount = info["amount"] || 1

		if(stored_goods[req] < 1)
			var/obj/item/preview = new req
			var/item_name = preview.name
			qdel(preview)
			to_chat(usr, span_warning("Insufficient [item_name] to build that."))
			return

		to_chat(usr, span_notice("You begin constructing the [option]..."))
		if(!do_after(usr, time))
			to_chat(usr, span_warning("You failed to complete the construction."))
			return

		stored_goods[req] -= 1
		var/turf/T = get_turf(usr)
		var/list/spawned = list()
		for(var/i in 1 to amount)
			var/obj/O = new type(T)
			spawned += O.name

		if(amount > 1)
			to_chat(usr, span_notice("You successfully construct a bundle of [amount] [spawned[1]]s!"))
		else
			to_chat(usr, span_notice("You successfully construct [spawned[1]]!"))

/obj/structure/siege/catapult/base
	name = "catapult Assembly Platform"
	desc = "A wooden frame used by siege engineers to assemble siege weapons. Insert parts in order."
	icon = 'icons/roguetown/misc/machines.dmi'
	icon_state = "mbox0"
	anchored = TRUE
	density = TRUE
	var/step = 0
	var/finished = FALSE

/obj/structure/siege/catapult/base/attackby(obj/item/I, mob/user)
	if(finished)
		to_chat(user, "The catapult is already assembled.")
		return

	switch(step)
		if(0 to 1)
			if(istype(I, /obj/item/natural/bundle/plank))
				step++
				qdel(I)
				icon_state = "catapult_[step]"
				update_desc()
			else
				to_chat(user, "You require a large, uncut wooden log.")
		if(2)
			if(I.tool_behaviour == TOOL_ADZE)
				step++
				icon_state = "catapult_[step]"
				update_desc()
			else
				to_chat(user, "You must hammer the beams into place.")
		if(3)
			if(istype(I, /obj/item/ingot/iron))
				step++
				qdel(I)
				icon_state = "catapult_[step]"
				update_desc()
			else
				to_chat(user, "You need iron bars for reinforcement.")
		if(4)
			if(istype(I, /obj/item/siege_part/launcher_finished))
				step++
				qdel(I)
				icon_state = "catapult_[step]"
				update_desc()
			else
				to_chat(user, "You need a launcher arm.")
		if(5)
			if(I.tool_behaviour == TOOL_ADZE)
				finished = TRUE
				icon_state = "catapult_done"
				to_chat(user, "<span class='notice'>The catapult is complete!</span>")
				// Optionally spawn a usable catapult here
				update_desc()

/obj/structure/siege/catapult/base/update_desc()
	. = ..()
	switch(step)
		if(0 to 1) desc = "You need a large log. Current step: [step]."
		if(2) desc = "Use a adze to reinforce the beams."
		if(3) desc = "Insert iron bars."
		if(4) desc = "Attach the launcher arm."
		if(5) desc = "Hammer the launcher into place."
		else if(finished) desc = "The catapult is fully assembled and ready."

/obj/structure/siege/hwancha/base
	name = "firewagon assembly"
	desc = "You need a wooden plank to begin framing."
	icon = 'modular/kaizoku/icons/mapset/tradesector32.dmi'
	icon_state = "" //not working.
	anchored = TRUE
	density = TRUE
	var/step = 0
	var/finished = FALSE

/obj/structure/siege/hwancha/base/attackby(obj/item/I, mob/user)
	if(finished)
		to_chat(user, "The firewagon is already assembled.")
		return

	switch(step)
		if(0)
			if(istype(I, /obj/item/natural/wood/plank))
				step++
				qdel(I)
				icon_state = "hwancha_[step]"
				update_desc()
			else
				to_chat(user, "You need a wooden plank to begin framing.")
		if(1)
			if(istype(I, /obj/item/grown/log/tree/small))
				step++
				qdel(I)
				icon_state = "hwancha_[step]"
				update_desc()
			else
				to_chat(user, "Insert a small log for base stability.")
		if(2)
			if(istype(I, /obj/item/siege_part/wheel))
				step++
				qdel(I)
				icon_state = "hwancha_[step]"
				update_desc()
			else
				to_chat(user, "Add a wooden wheel upon the lower frame.")
		if(3)
			if(istype(I, /obj/item/siege_part/wheel))
				step++
				qdel(I)
				icon_state = "hwancha_[step]"
				update_desc()
			else
				to_chat(user, "Add another wooden wheel upon the frame.")
		if(4)
			if(I.tool_behaviour == TOOL_ADZE)
				step++
				icon_state = "hwancha_[step]"
				update_desc()
			else
				to_chat(user, "Push the wheels into the frame using an adze.")
		if(5)
			if(istype(I, /obj/item/siege_part/sanctiflux_starter))
				step++
				qdel(I)
				icon_state = "hwancha_[step]"
				update_desc()
			else
				to_chat(user, "Attach a saintstarter upon the higher frame.")
		if(6)
			if(istype(I, /obj/item/grown/log/tree/stake))
				step++
				qdel(I)
				icon_state = "hwancha_[step]"
				update_desc()
			else
				to_chat(user, "Mount the first stake for elevation and balance.")
		if(7)
			if(istype(I, /obj/item/grown/log/tree/stake))
				step++
				qdel(I)
				icon_state = "hwancha_[step]"
				update_desc()
			else
				to_chat(user, "Mount the second stake for elevation and balance.")
		if(8)
			if(I.tool_behaviour == TOOL_ADZE)
				step++
				icon_state = "hwancha_[step]"
				update_desc()
			else
				to_chat(user, "Use the adze to bring the stakes into the frame.")
		if(9)
			if(istype(I, /obj/item/siege_part/launchpad))
				new /obj/structure/firewagon(get_turf(src))
				to_chat(user, "<span class='notice'>As you mount the launchpad, you see yourself front-to-front with a beast.</span>")
				qdel(I)
				qdel(src)
			else
				to_chat(user, "You need to install the aiming launchpad to finish the assembly.")

/obj/structure/siege/hwancha/base/update_desc()
	. = ..()
	switch(step)
		if(0) desc = "Overlap the frame of the firewagon with a plank."
		if(1) desc = "Adjust the frame with another plank for balance."
		if(2) desc = "Add a wooden wheel upon the lower frame."
		if(3) desc = "Add another wooden wheel upon the frame."
		if(4) desc = "Push the wheels into the frame using an adze."
		if(5) desc = "Attach a saintstarter upon the higher frame."
		if(6) desc = "Mount the first stake for elevation and balance."
		if(7) desc = "Mount the second stake for elevation and balance."
		if(8) desc = "Use the adze to bring the stakes into the frame."
		if(9) desc = "Install the launchpad."

/obj/item/siege_part
	name = "You should not see this"
	desc = "You should not see this"
	icon = 'modular/kaizoku/icons/mapset/tradesector32.dmi'
	icon_state = "artisankit"

/obj/item/siege_part/launcher_arm
	name = "unfinished launcher arm"
	desc = "The component of a catapult used to launch large projectiles. It requires a rope before becoming usable."
	icon_state = "launcherarm"

/obj/item/siege_part/launcher_arm/attackby(obj/item/I, mob/user)
	if(istype(I, /obj/item/rope))
		new /obj/item/siege_part/launcher_finished(get_turf(src))
		to_chat(user, span_notice("You finish the launcher arm using the rope."))
		qdel(I)
		qdel(src)

/obj/item/siege_part/launcher_finished
	name = "launcher arm"
	desc = "The component of a catapult used to launch large projectiles with a tension rope below it."
	icon_state = "launcherarm_finished"

/obj/item/siege_part/wheel_unfinished
	name = "unfinished wheel"
	desc = "Wheels are the backbone of the world. However, to get one, you will need spokes. Four sticks will do."
	icon_state = "wheel"

/obj/item/siege_part/wheel_unfinished/attackby(obj/item/I, mob/user)
	if(istype(I, /obj/item/natural/bundle/stick))
		var/obj/item/natural/bundle/stick/B = I
		if(B.amount < 4)
			to_chat(user, span_warning("You need at least 4 sticks to complete the wheel."))
			return
		B.amount -= 4
		B.update_bundle()
		to_chat(user, span_notice("You insert 4 sticks from the bundle and finish the wooden wheel."))
		new /obj/item/siege_part/wheel(get_turf(src))
		qdel(src)
		if(B.amount <= 0)
			qdel(B)
	else
		return ..()

/obj/item/siege_part/wheel
	name = "wooden wheel"
	desc = "Essential for the mobility of many siege weapons that can be pulled or pushed, with spokes connecting the wheel's rim to its central hub."
	icon_state = "wheel_finished"

/obj/item/siege_part/launchpad
	name = "launchpad"
	desc = "A solid square meant to withstand the force of repeated launches of blackpowder."
	icon_state = "launchpad"

/obj/item/siege_part/iron_strap
	name = "iron straps"
	desc = "Different types of straps to secure wooden assets firmly."
	icon_state = "ironstrap"

/obj/item/siege_part/sightrail
	name = "sight rail"
	desc = "A very crude rail for mounting sights on some siege weapons, with written markings to discover the distance."
	icon_state = "sightrail"

/obj/item/siege_part/winch_pulley
	name = "winch and pulley"
	desc = "A winch and pulley system used to apply gradual force to siege components. Enables controlled tension or lifting."
	icon_state = "winchpulley"

/obj/item/siege_part/sanctifluxbarrel_unfinished
	name = "unfinished sanctiflux barrel"
	desc = "A cylindrical base for holy oil, it just lacks a fyritius flower."
	icon_state = "saintbarrel_unfinished"

/obj/item/siege_part/sanctifluxbarrel_unfinished/attackby(obj/item/I, mob/user, params)
	if(istype(I, /obj/item/reagent_containers/food/snacks/produce/fyritius)) //Replace this with a brain system.
		new /obj/item/siege_part/sanctifluxbarrel_finished(loc)
		to_chat(user, span_notice("You place [I] into the barrel."))
		qdel(I)
		qdel(src)

/obj/item/siege_part/sanctifluxbarrel_finished
	name = "sanctiflux barrel"
	desc = "A holy-oil containment with fermented fyritius flower to catalyze ignitions."
	icon_state = "saintbarrel"

/obj/item/siege_part/sanctiflux_starter
	name = "sanctiflux starter"
	desc = "Unique ignition device used to ignite sanctiflux."
	icon_state = "saintstarter"

/obj/item/siege_part/automata_core
	name = "unfinished haniwa core"
	desc = "Standardized haniwa core of Foglander origin that requires the brain of an \
	fallen warrior too worthy to rot, or a brainwashed individual."
	icon_state = "golemcore_unfinished"

/obj/item/siege_part/automata_core/attackby(obj/item/I, mob/user, params)
	if(istype(I, /obj/item/reagent_containers/food/snacks/meat))
		new /obj/item/siege_part/automata_core_finished(loc)
		to_chat(user, span_notice("You bind the meat into the automata's core. It begins pulsating."))
		qdel(I)
		qdel(src)

/obj/item/siege_part/automata_core_finished
	name = "automata core"
	desc = "A pulsing, partially living core meant to power crude war automata."
	icon_state = "golemcore"

/obj/item/siege_part/goblinoid_mindbreaker
	name = "goblinoid mindbreaker"
	desc = "When your nation's children relies on torturing goblins for entertainment, \
	you end up with the know-hows to make them suffer even more. Only works on green goblins."
	icon_state = "mindbreaker"

/obj/item/siege_part/goblinoid_cage //btw, make a system to capture goblins + Put 'Mindbreaker' and THEN Sanctiflux barrel.
	name = "goblinoid cage"
	desc = "A reinforced cage to house the usual green, marshland goblinoids. Proper for Mindbreaker usage."
	icon_state = "goblingate"

// =================================================================================
// ========================	       	FIREWAGON	        	========================

/obj/structure/firewagon
	name = "abyssal firewagon"
	desc = "The doom of warships, the equinox storms from the foglander coastlines whom each arrow ensures new widows upon the world."
	icon = 'modular/kaizoku/icons/mapset/tradesector32.dmi'
	icon_state = "firewagon"
	anchored = FALSE
	density = TRUE
	max_integrity = 9999
	drag_slowdown = 1
	w_class = WEIGHT_CLASS_GIGANTIC
	var/obj/item/firewagonrockets/loaded = null  //Since we can't have nice things.

/obj/structure/firewagon/attackby(obj/item/I, mob/user, params)
	if(istype(I, /obj/item/firewagonrockets))
		if(loaded)
			to_chat(user, "<span class='warning'>The firewagon is already loaded!</span>")
			return

		user.visible_message("<span class='notice'>[user] starts loading [I] into [src].</span>")
		if(!do_after(user, 10 SECONDS, src))
			return

		I.forceMove(src)
		loaded = I
		user.visible_message("<span class='notice'>[user] loads [I] into [src].</span>")
		return

	if(istype(I, /obj/item/flashlight/flare/torch))
		var/obj/item/flashlight/flare/torch/LR = I
		if(!loaded)
			to_chat(user, "<span class='warning'>There's nothing to ignite.</span>")
			return
		if(LR.on)
			playsound(src.loc, 'modular/kaizoku/sound/hwanchafire.ogg', 100)
			user.visible_message("<span class='danger'>[user] lights [src]!</span>")
			fire(user)
		return

	..()

/obj/structure/firewagon/proc/fire(mob/firer)
	if(!loaded)
		return

	for(var/mob/living/carbon/H in hearers(7, src))
		shake_camera(H, 6, 5)
		H.adjust_eye_blur(4 SECONDS)
		H.playsound_local(get_turf(H), 'sound/foley/tinnitus.ogg', 75, FALSE)

	flick("hwancha_fire", src)

	var/pellets = 8
	var/spread = 30
	var/projectile_type = /obj/projectile/bullet/reusable/arrow

	if(istype(loaded, /obj/item/firewagonrockets/pyro))
		projectile_type = /obj/projectile/bullet/reusable/arrow/pyro

	for (var/i = 1, i <= pellets, i++)
		var/obj/projectile/bullet/reusable/arrow/fired_projectile = new projectile_type(get_turf(src))
		fired_projectile.firer = firer
		fired_projectile.fired_from = src

		var/spread_angle = rand(-spread, spread)
		fired_projectile.fire(dir2angle(dir) + spread_angle)

	QDEL_NULL(loaded)
	sleep(2)

/obj/item/firewagonrockets
	name = "firewagon storm-maker"
	desc = "A wooden container filled of arrows for usage in a Firewagon."
	icon_state = "firewagon_ammo"
	icon = 'modular/kaizoku/icons/mapset/tradesector32.dmi'

/obj/item/firewagonrockets/pyro
	name = "firewagon inferno-maker"
	desc = "A wooden container filled of pyroarrows for usage in a Firewagon."
	icon_state = "firefirewagon_ammo"
	icon = 'modular/kaizoku/icons/mapset/tradesector32.dmi'


// =================================================================================
// ========================		FOGLANDER CATAPULT		============================

/obj/structure/weapon/catapult
	name = "siege onager"
	desc = "The custodian version of the grenzelhoftean mangonel with better range and power. \
	Cheap, lever-based siege engine that must be manually cranked before each shot. \
	Developed to be quickly assembled, differently of the more expensive trebuchet."
	icon_state = "catapult_released"
	icon = 'modular/kaizoku/icons/mapset/siegeunits.dmi'
	anchored = FALSE
	density = TRUE
	w_class = WEIGHT_CLASS_GIGANTIC
	drag_slowdown = 1
	var/cranked = FALSE
	var/loaded = FALSE
	var/secured = FALSE
	var/obj/item/natural/rock/projectile
	var/launch_distance = 0
	var/launch_z = null
	var/turf/aim_target
	var/mechtime = 20 SECONDS

/obj/structure/weapon/catapult/attackby(obj/item/I, mob/user)
	if(istype(I, /obj/item/weapon/axe/adze)) //Sieger check, and ensure no silliness business with aiming system if it moves.
		if(cranked)
			to_chat(user, "<span class='warning'>You must release the crank before moving the catapult.</span>")
			return
		to_chat(user, "<span class='info'>You start working with the wheels using the adze for leverage.</span>")
		if(do_after(user, mechtime * (1 / (user.get_skill_level(/datum/skill/craft/engineering) + 1)), src))
			secured = !secured
			anchored = secured
			var/state = secured ? "secured" : "unsecured"
			to_chat(user, "<span class='warning'>The catapult is now [state].</span>")
			return

	if(istype(I, /obj/item/natural/rock))
		if(!cranked)
			to_chat(user, "<span class='warning'>You cannot reach the stone up there. You need to crank the catapult's arm beforehand.</span>")
			return
		if(loaded)
			to_chat(user, "<span class='warning'>No space for another stone.</span>")
			return
		to_chat(user, "<span class='info'>You start putting the stone on the catapult arm.</span>")
		if(do_after(user, mechtime * (1 / (user.get_skill_level(/datum/skill/craft/engineering) + 1)), src))
			projectile = I
			loaded = TRUE
			user.dropItemToGround(I)
			I.forceMove(src)
			icon_state = cranked ? "catapult_rock" : "catapult_throw_rock"
			to_chat(user, "<span class='warning'>You place the heavy stone on the catapult arm.</span>")
			return
	..()

/obj/structure/weapon/catapult/attack_hand_secondary(mob/user)
	if(!secured)
		to_chat(user, "<span class='warning'>You require an adze to ensure stability of the wheels before shooting.</span>")
		return
	launch_distance = input(user, "Set the strength (distance):", "Range", launch_distance) as null|num
	if(isnull(launch_distance))
		return
	if(launch_distance < 0)
		launch_distance = 0
	if(launch_distance > 30)
		to_chat(user, "<span class='warning'>It cannot go past 30. Use a trebuchet if you want more.</span>")
		launch_distance = 30

	var/chosen_z = input(user, "Align the curvature (height):", "Z-level", launch_z ? launch_z : z) as null|num //Requests Z-level information. Automatically defaults the surface.
	if(isnull(chosen_z))
		return
	if(chosen_z < z)
		to_chat(user, "<span class='warning'>You cannot curve downwards. You will shoot the soil.</span>") //Denies underground sniping.
		return
	launch_z = chosen_z
	if(!launch_z)
		return

	to_chat(user, "<span class='info'>Target range set to [launch_distance] tiles forward on Z-level [launch_z]</span>")

	var/turf/final_target = get_ranged_target_turf(src, dir, launch_distance) //Outcome of the targetting, finding a tile based on chosen direction and range.

	if(launch_z && launch_z != z) //In case the user selected a different Z-level of the surface.
		final_target = locate(final_target.x, final_target.y, launch_z)

		while(final_target && !istype(final_target, /turf/open/openspace)) // Check for openspaces. If there is any, it will fall down.
			var/turf/above = get_step_multiz(final_target, UP)
			if(!above) break
			final_target = above //The only way to actually shoot 'undeground', is to actually have somewhere for it to fall upon.
	else
		for(var/i = 1, i <= launch_distance, i++) //If it is aiming on the same Z-level, check every tile in range for obstruction. Only happens on the surface.
			var/turf/check = get_ranged_target_turf(src, dir, i)
			if(istype(check, /turf/closed/wall)) //If the line finds a wall, it stops aiming further. You cannot see past that.
				final_target = check
				to_chat(user, "You aim towards the target. But there was something on the way.")
				break
	aim_target = final_target //True aiming reference.
	to_chat(user, "<span class='info'>Catapult aim set at ([aim_target.x], [aim_target.y], z=[aim_target.z])</span>")

/obj/structure/weapon/catapult/attack_hand(mob/user)
	if(!secured)
		to_chat(user, "<span class='warning'>It would be stupid to crank the catapult without securing its wheels first.</span>")
		return

	if(cranked && loaded)
		to_chat(user, "<span class='warning'>You cannot release the crank while a rock is loaded. The rock would fall on you.</span>")
		return

	to_chat(user, "<span class='info'>You start changing the catapult's arm current state.</span>")
	if(do_after(user, mechtime * (1 / (user.get_skill_level(/datum/skill/craft/engineering) + 1)), src))
		cranked = !cranked
		var/action_text = cranked ? "crank the catapult arm" : "release the catapult arm"
		to_chat(user, "<span class='warning'>You [action_text].</span>")
		icon_state = cranked ? (loaded ? "catapult_crank_rock" : "catapult_crank") : "catapult"

/obj/structure/weapon/catapult/MiddleClick(mob/user, params)
	if(!cranked || !loaded || !secured)
		to_chat(user, "<span class='warning'>The catapult is not properly prepared to shoot.</span>")
		return
	if(launch_distance <= 1)
		to_chat(user, "<span class='danger'>That would be suicide.</span>")
		return
	fire(user)

/obj/structure/weapon/catapult/proc/fire(mob/user)
	cranked = FALSE
	loaded = FALSE
	icon_state = projectile ? "catapult_throw_rock" : "catapult_throw"
	visible_message("<span class='danger'>The catapult swings something heavy towards the skies!</span>")

	var/obj/item/natural/rock/current_proj = projectile
	projectile = null

	var/turf/impact_turf = aim_target
	if(!impact_turf)
		return

	var/icon_variant = "rock"
	if(current_proj?.icon_state)
		icon_variant = "[current_proj.icon_state]"
	new /obj/effect/impact_marker(get_turf(impact_turf), icon_variant)

	spawn(5)
		icon_state = "catapult_released"

	spawn(30)
		if(current_proj)
			QDEL_NULL(current_proj)

		if(istype(impact_turf, /turf/closed/wall))
			impact_turf.take_damage(1100, user)

		for(var/mob/living/M in get_turf(impact_turf))
			to_chat(M, "<span class='danger'>...Nothing. Just the undermaiden's embrace.</span>")
			M.gib()

		for(var/turf/T in range(2, impact_turf))
			if(T.z == impact_turf.z && !(T in range(1, impact_turf)))
				for(var/mob/living/M in T)
					if(!M.stat)
						to_chat(M, "<span class='warning'>You feel your body being hurled down due to flying debris!</span>")
						M.adjustBruteLoss(250)
						M.Stun(3)

		for(var/turf/T in range(3, impact_turf))
			if(T.z == impact_turf.z && !(T in range(2, impact_turf)))
				for(var/mob/living/M in T)
					if(!M.stat)
						to_chat(M, "<span class='notice'>Pain. Gravel is brought into your chest worse than a punch.</span>")
						M.adjustBruteLoss(150)
						M.Paralyze(2)
		for(var/turf/closed/wall/W in range(2, impact_turf))
			if(W.z == impact_turf.z && !(W in range(1, impact_turf)))
				W.take_damage(600, user)

		for(var/i = 1, i <= 6, i++)
			spawn(i * 2)
				if(impact_turf)
					var/obj/item/natural/stone/S = new /obj/item/natural/stone(get_turf(impact_turf))
					var/list/adjacent = list()
					for(var/turf/T in range(7, impact_turf))
						if(T.z == impact_turf.z && get_dist(T, impact_turf) <= 7)
							adjacent += T
					var/turf/T = pick(adjacent)
					if(T)
						S.safe_throw_at(T, 8, 1, user)

					var/obj/projectile/bullet/stonefrag/fragproj = new /obj/projectile/bullet/stonefrag(get_turf(impact_turf))
					fragproj.firer = user
					fragproj.fired_from = src
					fragproj.fire(rand(0, 359))

		new /obj/effect/particle_effect/smoke(impact_turf)

/obj/effect/impact_marker
	name = "impact marker"
	icon = 'modular/kaizoku/icons/mapset/96x96_effect.dmi'
	icon_state = "shadow"
	anchored = TRUE
	density = FALSE
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	layer = EFFECTS_LAYER
	pixel_x = -32
	pixel_y = -32

/obj/effect/impact_marker/Initialize()
	. = ..()
	QDEL_IN(src, 3 SECONDS)

/obj/projectile/bullet/stonefrag
	name = "stone shard projectile"
	ammo_type = /obj/item/natural/stone
	hitsound = list('sound/combat/hits/blunt/genblunt (1).ogg','sound/combat/hits/blunt/genblunt (2).ogg','sound/combat/hits/blunt/genblunt (3).ogg')
	damage = 20
	damage_type = BRUTE
	icon = 'icons/roguetown/items/natural.dmi'
	icon_state = "stone1"
	range = 20
	embedchance = 100
	armor_penetration = 10
	flag = "piercing"
	speed = 0.35
	woundclass = BCLASS_BLUNT

/obj/projectile/bullet/stonefrag/on_hit(atom/target, blocked)
	. = ..()
	if(ismob(target) && istype(target, /mob/living/carbon/human))
		var/mob/living/carbon/human/C = target
		if(C && !HAS_TRAIT(C, TRAIT_PIERCEIMMUNE) && C.bodyparts && length(C.bodyparts))
			var/list/valid_parts = list()
			for(var/obj/item/bodypart/BP in C.bodyparts)
				if(BP.owner)
					valid_parts += BP
			if(length(valid_parts))
				var/obj/item/bodypart/L = pick(valid_parts)
				if(L)
					L.try_crit(woundclass, 20, C, L.body_zone)
					if(prob(50))
						C.Stun(20)
						to_chat(C, "<span class='danger'>Debris weights against your body!</span>")
						C.visible_message("<span class='danger'>[C] is knocked off their feet by the debris!</span>")

// =================================================================================
// ========================		FOGLANDER OIL WAGON		========================


/obj/structure/siege/oilwagoon
	name = "oil wagoon"
	desc = "A rickety wooden wagon loaded with highly flammable oil. Meant to turn the battlefield into a blazing inferno."
	icon = 'modular/kaizoku/icons/mapset/furniture_32x32.dmi'
	icon_state = "abyssalbench_2" //Placeholder
	anchored = FALSE
	density = TRUE
	var/max_distance = 16
	var/moved_tiles = 0
	var/list/oil_trail = list()
	var/lit = FALSE
	var/active = FALSE

/obj/structure/siege/oilwagoon/attackby(obj/item/I, mob/user)
	if(istype(I, /obj/item/weapon/axe/adze))
		if(active || lit) return
		active = TRUE
		user.visible_message("<span class='notice'>[user] strikes the oil wagon.</span>")
		spawn(0)
			push(get_dir(user, src), user)

/obj/structure/siege/oilwagoon/proc/push(dir, mob/user)
	set waitfor = FALSE
	moved_tiles = 0
	while(moved_tiles < max_distance)
		var/turf/next = get_step(src, dir)
		if(!next || !isturf(next) || next.density || locate(/obj/structure) in next)
			break
		step_to(src, next)
		moved_tiles++
		var/obj/effect/oilspill/oil = new(next)
		oil_trail += oil
		for(var/mob/living/carbon/human/M in next)
			var/thrust_power = 3
			M.dir = turn(dir, 180)
			if(prob(60))
				var/list/side_dirs = list(turn(dir, 90), turn(dir, -90))
				var/dir_choice = pick(side_dirs)
				var/turf/side_target = get_step(M, dir_choice)
				if(side_target && isturf(side_target) && !side_target.density)
					M.throw_at(side_target, thrust_power, 1)
				M.Knockdown(30)
				to_chat(M, "<span class='danger'>You're knocked aside!</span>")
			else
				var/turf/front = get_step(M, dir)
				if(front && isturf(front) && !front.density)
					M.throw_at(front, thrust_power, 1)
				M.Paralyze(30)
				to_chat(M, "<span class='danger'>You're slammed forward by the wagon!</span>")
			M.apply_damage(5, "brute", "chest")
		sleep(3)

	ignite_wagon()

/obj/structure/siege/oilwagoon/fire_act()
	ignite_wagon()

/obj/structure/siege/oilwagoon/spark_act()
	ignite_wagon()

/obj/structure/siege/oilwagoon/ex_act()
	ignite_wagon()

/obj/structure/siege/oilwagoon/proc/ignite_wagon()
	if(lit)
		return
	lit = TRUE
	visible_message("<span class='danger'>The oil wagon ignites!</span>")
	var/turf/T = get_turf(src)
	if(T)
		playsound(T, pick('sound/misc/explode/bottlebomb (1).ogg','sound/misc/explode/bottlebomb (2).ogg'), 100)
		explosion(T, light_impact_range = 1, hotspot_range = 2, smoke = TRUE)

		var/datum/effect_system/smoke_spread/S = new /datum/effect_system/smoke_spread
		S.set_up(4, T)
		S.start()

	for(var/obj/effect/oilspill/O in oil_trail)
		if(QDELETED(O))
			continue
		O.life += 60
	qdel(src)

/obj/structure/siege/oilwagoon/proc/explode_and_smoke()
	var/turf/T = get_turf(src)
	if(!T) return
	visible_message("<span class='warning'>The oil wagon detonates in a fiery explosion!</span>")
	explosion(T, 1, 2, smoke = TRUE, soundin = pick('sound/misc/explode/bottlebomb (1).ogg','sound/misc/explode/bottlebomb (2).ogg'))
	var/datum/effect_system/smoke_spread/S = new /datum/effect_system/smoke_spread
	S.set_up(3, T)
	S.start()
	new /obj/item/fertilizer/ash(T)
	qdel(src)

//Oil cauldron

/obj/structure/siege/boiling_cauldron
	name = "boiling oil cauldron"
	desc = "A heavy iron pot filled with scalding oil, mounted atop the wall."
	icon = 'modular/kaizoku/icons/mapset/frontierjustice32.dmi'
	icon_state = "experimental2" //Placeholder
	anchored = TRUE
	density = TRUE
	dir = SOUTH
	var/active = FALSE
	var/uses = 0
	var/max_uses = 5
	var/spill_interval = 20

/obj/structure/siege/boiling_cauldron/attack_hand(mob/user)
	if(!user || user.stat)
		return
	if(active || uses >= max_uses)
		return
	to_chat(user, span_notice("You tip the cauldron..."))
	icon_state = "experimental1"
	active = TRUE
	uses++
	spill_oil_repeatedly()

/obj/structure/siege/boiling_cauldron/proc/spill_oil_repeatedly()
	spawn()
		for(var/i = 0; i < 5; i++)
			spill_oil()
			sleep(spill_interval)
		active = FALSE
		if(uses >= max_uses)
			icon_state = "experimental_empty"

/obj/structure/siege/boiling_cauldron/proc/spill_oil()
	var/list/affected_tiles = list()
	var/turf/initial = get_turf(src)
	var/direction = get_dir(src, get_step(initial, dir))

	for(var/i = 1, i <= 1, i++)
		var/turf/T = initial
		T = get_step(T, direction)
		if(!T)
			continue
		var/turf/fall_turf = T
		while(istype(fall_turf, /turf/open/openspace) || fall_turf.z > 1)
			var/next_z = fall_turf.z - 1
			if(next_z <= 0)
				break
			var/next = locate(fall_turf.x, fall_turf.y, next_z)
			if(!next || fall_turf.density)
				break
			fall_turf = next
			if(!istype(fall_turf, /turf/open/openspace))
				break

		if(!fall_turf || fall_turf.density)
			continue
		affected_tiles += fall_turf

		for(var/dir_offset in list(turn(direction, 90), turn(direction, -90)))
			var/turf/side = get_step(fall_turf, dir_offset)
			if(side && !side.density)
				affected_tiles += side

	for(var/turf/T in affected_tiles)
		for(var/mob/living/carbon/human/H in T.contents)
			burn_body_with_oil(H)
			to_chat(H, span_danger("Boiling oil splashes upon you from above!"))

/proc/burn_body_with_oil(var/mob/living/carbon/human/H)
	for(var/zone in list("head", "chest", "groin", "l_arm", "r_arm", "l_leg", "r_leg"))
		H.apply_damage(40, BURN, zone)

/obj/structure/siege/boiling_cauldron/attackby(obj/item/W, mob/user)
	if(istype(W, /obj/item/weapon/axe/adze))
		anchored = FALSE
		to_chat(user, span_notice("You pry the cauldron loose."))
/*
/obj/structure/siege/boiling_cauldron/attack_self(mob/user)
	if(!anchored)
		dir = turn(dir, 90)
		overlays.Cut()
		to_chat(user, span_notice("You rotate the cauldron."))
*/

#define BOMB_LIFESPAN 120
#define BOMB_ARMTIME 20
#define BOMB_TRIGGER_TIME 30
#define BB_TARGET "clockbomb_target"
#define AI_BEHAVIOR_NONE 0

// ===================== ITEM ========================

/obj/item/goblin_bomb
	name = "goblin bomb"
	icon = 'modular/kaizoku/icons/mapset/tradesector32.dmi'
	icon_state = "goblingate_captured"
	desc = "A goblin, brainwashed with a foglander device and ready to perceive a chosen target as food."
	w_class = WEIGHT_CLASS_NORMAL
	slot_flags = ITEM_SLOT_HIP
	var/active = FALSE
	possible_item_intents = list(/datum/intent/goblin_bomber/attack)

/datum/intent/goblin_bomber/attack
	name = "Deploy"
	icon_state = "inuse"
	chargetime = 0
	noaa = TRUE
	rmb_ranged = TRUE

/datum/intent/goblin_bomber/attack/rmb_ranged(atom/target, mob/user)
	var/obj/item/goblin_bomb/bombitem = user.get_active_held_item()
	if(QDELETED(target) || QDELETED(user))
		return
	if(ismob(target) || istype(target, /turf/closed/wall))
		bombitem.active = TRUE
		var/mob/living/simple_animal/hostile/clockbomb_goblin/G = new(get_turf(user))
		G.goblin_bomber_target = target
		G.summoner = user
		G.arming = TRUE
		G.arm_tick = world.time + BOMB_ARMTIME
		G.icon_state = G.icon_state_prepare
		G.last_seen_target = (ismob(target) ? get_turf(target) : target)
		G.visible_message("<span class='info'>A brainwashed goblin is unleashed!</span>")
		G.ai_controller = new /datum/ai_controller/clockbomb(G)
		user.dropItemToGround(bombitem)
		qdel(bombitem)
	else
		to_chat(user, "<span class='warning'>There is now way you can make this Goblin believe the target is food.</span>")

// ===================== GOBLIN MOB =====================

/mob/living/simple_animal/hostile/clockbomb_goblin
	name = "goblin bomber"
	icon = 'modular/kaizoku/icons/weapons/goblinbomber.dmi'
	icon_state = "goblin_bomber"
	health = 120
	maxHealth = 120
	move_to_delay = 1
	var/atom/goblin_bomber_target = null
	var/mob/living/summoner = null
	var/tick_life = BOMB_LIFESPAN
	var/arming = FALSE
	var/arm_tick = 0
	var/triggered = FALSE
	var/trigger_tick = 0
	var/icon_state_idle = "goblin_bomber"
	var/icon_state_triggered = "goblin_triggered"
	var/icon_state_dead = "goblin_dead"
	var/icon_state_prepare = "goblin_prepare"
	var/last_seen_target = null
	var/mob/living/pounced_target = null
	var/pounced_tick = 0
	var/pounce_duration = 30
	var/pounce_resisted = FALSE
	var/has_exploded = FALSE

/mob/living/simple_animal/hostile/clockbomb_goblin/Initialize()
	. = ..()
	icon_state = icon_state_prepare
	RegisterSignal(src, COMSIG_HUMAN_DISARM_HIT, PROC_REF(on_shoved))

/mob/living/simple_animal/hostile/clockbomb_goblin/Life()
	..()
	tick_life--

	if(pounced_target)
		if(QDELETED(pounced_target) || !ismob(pounced_target) || !pounced_target.loc)
			if(istype(pounced_target, /mob/living/carbon/human))
				var/mob/living/carbon/human/H = pounced_target
				H.remove_goblin_pounced_overlay()
			remove_pounce_overlay()
			if(stat != DEAD)
				stat = DEAD
				death()
			return
		else
			if(src.loc != pounced_target)
				loc = pounced_target
			pixel_y = 21
			pixel_x = 0
			if(world.time >= pounced_tick && stat != DEAD)
				stat = DEAD
				death()
			return

	if(tick_life <= 0 || (!goblin_bomber_target && !last_seen_target) || (goblin_bomber_target && QDELETED(goblin_bomber_target)) || (goblin_bomber_target && get_dist(src, goblin_bomber_target) > 20))
		if(stat != DEAD)
			stat = DEAD
			death()
		return

	if(ismob(goblin_bomber_target) && !QDELETED(goblin_bomber_target))
		last_seen_target = get_turf(goblin_bomber_target)
	else if(!ismob(goblin_bomber_target) && isturf(goblin_bomber_target))
		last_seen_target = goblin_bomber_target

	if(arming)
		if(world.time < arm_tick)
			return
		arming = FALSE
		icon_state = icon_state_idle
		if(summoner)
			to_chat(summoner, "<span class='notice'>[src] stands up, triggered.</span>")
		return

	icon_state = (triggered && world.time % 2 == 0) ? icon_state_triggered : icon_state_idle
	chase_target()
	if(triggered && world.time >= trigger_tick && stat != DEAD)
		stat = DEAD
		death()

/mob/living/simple_animal/hostile/clockbomb_goblin/proc/try_pounce(mob/living/carbon/human/target)
	if(triggered || arming || !target || !ismob(target))
		return
	if(QDELETED(target) || !target.loc || !isturf(target.loc))
		return

	pounced_target = target
	pounced_tick = world.time + pounce_duration
	invisibility = 101
	loc = target
	icon_state = icon_state_triggered
	RegisterSignal(target, COMSIG_HUMAN_DISARM_HIT, PROC_REF(target_shoved))
	pounced_target = target
	if(istype(target, /mob/living/carbon/human))
		var/mob/living/carbon/human/H = target
		H.add_goblin_pounced_overlay(src)

	visible_message("<span class='warning'>[src] leaps and clamps onto [target]!")

/mob/living/simple_animal/hostile/clockbomb_goblin/proc/remove_pounce_overlay()
	if(pounced_target && istype(pounced_target, /mob/living/carbon/human))
		var/mob/living/carbon/human/H = pounced_target
		H.remove_goblin_pounced_overlay()
		UnregisterSignal(pounced_target, COMSIG_HUMAN_DISARM_HIT)
		pounced_target = null
	invisibility = 0
	pounced_target = null
	loc = get_turf(src)
	pixel_x = 0
	pixel_y = 0
	icon_state = icon_state_idle


/mob/living/simple_animal/hostile/clockbomb_goblin/proc/target_shoved(user, zone)
	if(!pounced_target)
		return
	remove_pounce_overlay()
	if(stat != DEAD)
		stat = DEAD
		visible_message("<span class='danger'>[src] is knocked loose and starts ticking faster!</span>")
		death()

/mob/living/simple_animal/hostile/clockbomb_goblin/proc/chase_target()
	if(arming)
		return
	var/turf/T = null
	if(goblin_bomber_target && ismob(goblin_bomber_target) && !QDELETED(goblin_bomber_target))
		T = get_turf(goblin_bomber_target)
	else if(last_seen_target)
		T = last_seen_target
	if(!T)
		return
	if(get_dist(src, T) > 1)
		step_towards(src, T)
		if(summoner)
			to_chat(summoner, "<span class='info'>[src] moves towards ([T.x], [T.y], [T.z])</span>")
	else
		if(ismob(goblin_bomber_target) && !triggered && !pounced_target)
			src.try_pounce(goblin_bomber_target)
		else if(!triggered)
			triggered = TRUE
			trigger_tick = world.time + BOMB_TRIGGER_TIME
			icon_state = icon_state_triggered
			visible_message("<span class='warning'>The goblin's explosive wheel fills with pressure.</span>")
			if(summoner)
				to_chat(summoner, "<span class='notice'>[src] is about to explode.</span>")

/mob/living/simple_animal/hostile/clockbomb_goblin/proc/on_shoved(user, zone)
	if(pounced_target)
		remove_pounce_overlay()
		visible_message("<span class='warning'>[src] is knocked off.</span>")
	else if(stat != DEAD)
		stat = DEAD
		visible_message("<span class='danger'>[src] is knocked off and starts ticking faster.</span>")
		death()

/mob/living/simple_animal/hostile/clockbomb_goblin/proc/explode()
	if(stat == DEAD || has_exploded)
		return
	stat = DEAD
	death()

/mob/living/simple_animal/hostile/clockbomb_goblin/Destroy()
	if(pounced_target && istype(pounced_target, /mob/living/carbon/human))
		var/mob/living/carbon/human/H = pounced_target
		H.remove_goblin_pounced_overlay()
	..()

/mob/living/carbon/human
	var/image/goblin_pounced_overlay = null

/mob/living/carbon/human/proc/add_goblin_pounced_overlay(var/mob/living/simple_animal/hostile/clockbomb_goblin/G)
	if(goblin_pounced_overlay)
		cut_overlay(goblin_pounced_overlay)
		goblin_pounced_overlay = null
	goblin_pounced_overlay = image(G.icon, G.icon_state_triggered, G.dir)
	goblin_pounced_overlay.pixel_x = 0
	goblin_pounced_overlay.pixel_y = 21
	add_overlay(goblin_pounced_overlay)

/mob/living/carbon/human/proc/remove_goblin_pounced_overlay()
	if(goblin_pounced_overlay)
		cut_overlay(goblin_pounced_overlay)
		goblin_pounced_overlay = null

/datum/ai_controller/clockbomb
	parent_type = /datum/ai_controller
	ai_movement = null
	blackboard = list(
		BB_TARGET = null,
	)
	planning_subtrees = list(
		/datum/ai_planning_subtree/clockbomb_plan,
	)
	idle_behavior = null

/datum/ai_controller/clockbomb/New(mob)
	..()
	src.pawn = mob

/datum/ai_controller/clockbomb/proc/Tick()
	if(src.pawn && planning_subtrees.len)
		for(var/path in planning_subtrees)
			var/datum/ai_planning_subtree/tree = new path
			tree.SelectBehaviors(src, 0)

/datum/ai_planning_subtree/clockbomb_plan/SelectBehaviors(datum/ai_controller/controller, delta_time)
	var/mob/living/simple_animal/hostile/clockbomb_goblin/G = controller.pawn
	if(!G || (!G.goblin_bomber_target && !G.last_seen_target))
		return
	if(G.arming || G.triggered)
		return
	controller.blackboard["clockbomb_target"] = G.goblin_bomber_target
	var/turf/T = null
	if(G.goblin_bomber_target && ismob(G.goblin_bomber_target) && !QDELETED(G.goblin_bomber_target))
		T = get_turf(G.goblin_bomber_target)
	else if(G.last_seen_target)
		T = G.last_seen_target
	if(!T)
		return
	if(get_dist(G, T) <= 1)
		if(ismob(G.goblin_bomber_target) && !G.triggered && !G.pounced_target)
			G.try_pounce(G.goblin_bomber_target)
		else if(!G.triggered)
			G.triggered = TRUE
			G.trigger_tick = world.time + BOMB_TRIGGER_TIME
			G.icon_state = G.icon_state_triggered
			G.visible_message("<span class='warning'>The goblin gear starts ticking!</span>")
			if(G.summoner)
				to_chat(G.summoner, "<span class='notice'>[G] is about to explode!</span>")
	else
		step_towards(G, T)

/proc/soft_explosion(turf/center, devastation_range, heavy_impact_range, light_impact_range, flash_range = 0, soundin = 'sound/misc/explode/explosion.ogg')
	playsound(center, soundin, 80, 1)
	var/datum/effect_system/E = new /datum/effect_system/explosion
	E.set_up(center)
	E.start()
	for(var/mob/living/L in range(light_impact_range, center))
		var/dist = get_dist(center, L)
		if(dist < devastation_range)
			L.ex_act(EXPLODE_DEVASTATE)
			L.apply_damage(180, BRUTE)
			L.apply_damage(90, BURN)
			if(istype(L, /mob/living/carbon/human)) //Experimentation proved that armors protects your limbs.
				var/mob/living/carbon/human/H = L
				var/list/limb_zones = list(BODY_ZONE_L_ARM, BODY_ZONE_R_ARM, BODY_ZONE_L_LEG, BODY_ZONE_R_LEG)
				var/obj/item/bodypart/limb
				var/list/limbs_found = list()
				for(var/zone in limb_zones)
					limb = H.get_bodypart(zone)
					if(limb)
						limbs_found += limb
				if(limbs_found.len) //Automatically dismember at least a limb.
					var/obj/item/bodypart/dismembered = pick(limbs_found)
					dismembered.dismember()
					H.emote("scream")
				else
					H.gib() //If the human mob has no limbs, they will simply gib.
			else if(L.health < 400) //If; The Mob is too tough, they will not gib.
				if(istype(L, /mob/living/simple_animal))
					L.gib() //Waste of resources. This is intended.
				else
					L.death(0) //Or just die, if you can't gib.
			else
				L.apply_damage(400, BRUTE) //If the simple mob managed to survive this explosion, take 400 dmg.
		else if(dist < heavy_impact_range) //Otherwise, receive acceptable damage.
			L.ex_act(EXPLODE_HEAVY)
			L.apply_damage(90, BRUTE)
		else
			L.ex_act(EXPLODE_LIGHT) //Or little damage.
			L.apply_damage(45, BRUTE)
	for(var/obj/O in range(light_impact_range, center))
		var/dist = get_dist(center, O)
		if(istype(O, /obj/structure/door))
			if(dist < devastation_range)
				O.ex_act(EXPLODE_DEVASTATE)
			else if(dist < heavy_impact_range)
				O.ex_act(EXPLODE_HEAVY)
			else
				O.ex_act(EXPLODE_LIGHT)
	for(var/turf/T in range(light_impact_range, center))
		if(istype(T, /turf/closed/wall))
			var/dist = get_dist(center, T)
			if(dist < devastation_range)
				T.take_damage(1100, null)
			else if(dist < heavy_impact_range)
				T.take_damage(500, null)
			else
				T.take_damage(200, null)
	if(flash_range)
		for(var/mob/living/L in range(flash_range, center))
			L.flash_act()


/mob/living/simple_animal/hostile/clockbomb_goblin/death()
	if(has_exploded || QDELETED(src))
		return
	. = ..()
	has_exploded = TRUE
	icon_state = icon_state_dead

	addtimer(CALLBACK(src, .proc/do_delayed_explosion), 5 SECONDS)

/mob/living/simple_animal/hostile/clockbomb_goblin/proc/do_delayed_explosion()
	if(QDELETED(src))
		return
	soft_explosion(get_turf(src), 2, 2, 3)
	qdel(src)

////////////////////////////////////////////////////////////////////////////////
// Abyssal Hellsbane
////////////////////////////////////////////////////////////////////////////////

/obj/machinery/holy_purifier/core
	name = "abyssal hellsbane"
	desc = "Overglorified stomach rendered as steel. It breaks down corpses and souls into oils and cores considered sacred."
	icon = 'modular/kaizoku/icons/mapset/tradesector32.dmi'
	icon_state = "hellsbane"
	density = FALSE
	anchored = TRUE
	var/active = FALSE
	var/oil_storage = 0
	var/required_oil_for_output = 5
	var/obj/machinery/holy_purifier/vessel/linked_vessel = null
	var/obj/machinery/holy_purifier/lever/linked_lever = null
	var/obj/machinery/holy_purifier/door/linked_door = null
	var/list/railings = list()

/obj/machinery/holy_purifier/core/Cross(atom/movable/mover, turf/target, height=1.5, air_group = 0)
	if(!isliving(mover))
		return TRUE
	var/move_dir = get_dir(src, mover.loc)
	if(move_dir != SOUTH && get_dir(mover.loc, src) != SOUTH)
		return FALSE

	return TRUE

/obj/machinery/holy_purifier/core/New()
	..()
	spawn(1)
		link_parts()
		spawn(2)
			setup_invisible_railings()
			spawn_door()

/obj/machinery/holy_purifier/core/proc/link_parts()
	linked_vessel = locate(/obj/machinery/holy_purifier/vessel) in orange(2, src)
	linked_lever = locate(/obj/machinery/holy_purifier/lever) in orange(3, src)
	if(linked_lever)
		linked_lever.linked_core = src

/obj/machinery/holy_purifier/core/proc/setup_invisible_railings()
	for(var/dir in list(NORTH))
		var/turf/T = get_step(src, dir)
		if(T)
			var/obj/structure/hellsbane_barrier/B = new /obj/structure/hellsbane_barrier(T)
			B.dir = dir
			B.linked_core = src
			railings += B

/obj/machinery/holy_purifier/core/proc/spawn_door()
	if(!linked_door)
		var/turf/T = get_step(src, SOUTH)
		if(T)
			linked_door = new /obj/machinery/holy_purifier/door(T)
			linked_door.linked_core = src
			linked_door.open_gate()

/obj/machinery/holy_purifier/core/proc/toggle_activation(mob/user)
	if(active) return
	link_parts()
	if(!linked_vessel || !linked_lever || !linked_door)
		return
	active = TRUE
	if(linked_door)
		linked_door.close_gate()
	density = TRUE
	linked_lever.update_icon()
	new /obj/effect/hellsbane_animation(loc, src)

/obj/machinery/holy_purifier/core/proc/process_conversion()
	if(oil_storage >= required_oil_for_output && linked_vessel)
		linked_vessel.produce_oil(oil_storage)
		oil_storage = 0

	linked_door?.open_gate()
	density = FALSE
	active = FALSE
	linked_lever?.update_icon()

/obj/machinery/holy_purifier/core/proc/do_smashing()
	for(var/mob/living/carbon/human/H in loc)
		H.gib()
		oil_storage += 4
	for(var/obj/item/bodypart/B in loc)
		oil_storage += 2
		qdel(B)
	for(var/obj/item/organ/O in loc)
		oil_storage += 1
		qdel(O)
	for(var/obj/effect/decal/cleanable/blood/Z in loc)
		oil_storage += 1
		qdel(Z)
	for(var/obj/structure/soul/S in loc)
		linked_vessel?.produce_melded_t4()
		qdel(S)

/obj/machinery/holy_purifier/lever
	name = "Sacred Lever"
	desc = "A lever used to begin the sacred rite of purification."
	icon = 'modular/kaizoku/icons/mapset/tradesector32.dmi'
	icon_state = "lever_on"
	density = TRUE
	anchored = TRUE
	var/obj/machinery/holy_purifier/core/linked_core = null

/obj/machinery/holy_purifier/lever/attack_hand(mob/user)
	if(!linked_core)
		linked_core = locate(/obj/machinery/holy_purifier/core) in orange(3, src)
		if(linked_core)
			linked_core.linked_lever = src
	linked_core?.toggle_activation(user)

/obj/machinery/holy_purifier/lever/update_icon()
	. = ..()
	if(linked_core)
		icon_state = linked_core.active ? "lever_off" : "lever_on"

/obj/machinery/holy_purifier/vessel
	name = "Blessed Vessel"
	desc = "A sacred vessel that receives and solidifies holy oil."
	icon = 'modular/kaizoku/icons/mapset/tradesector32.dmi'
	icon_state = "oilmaker"
	density = TRUE
	anchored = TRUE
	var/oil_amount = 0
	var/oil_output_step = 10
	var/processing = FALSE

/obj/machinery/holy_purifier/vessel/proc/produce_oil(amount)
	oil_amount += amount
	if(!processing)
		processing = TRUE
		spawn(0) slow_output()

/obj/machinery/holy_purifier/vessel/proc/slow_output()
	if(oil_amount < oil_output_step)
		processing = FALSE
		return
	oil_amount -= oil_output_step
	new /obj/item/sanctiflux(loc)
	spawn(20) slow_output()

/obj/machinery/holy_purifier/vessel/proc/produce_melded_t4()
	visible_message("<span class='boldannounce'>The Blessed Vessel glows with an intense light before producing a warped artifact!</span>")
	new /obj/item/natural/melded/t4(loc)

/obj/machinery/holy_purifier/door
	name = ""
	desc = ""
	icon = 'modular/kaizoku/icons/mapset/tradesector32.dmi'
	icon_state = "hellsbane_gate"
	density = FALSE
	anchored = TRUE
	var/obj/machinery/holy_purifier/core/linked_core = null

/obj/machinery/holy_purifier/door/proc/open_gate()
	density = FALSE

/obj/machinery/holy_purifier/door/proc/close_gate()
	density = TRUE

/obj/structure/hellsbane_barrier
	name = null
	desc = null
	icon = null
	density = TRUE
	anchored = TRUE
	mouse_opacity = 0
	layer = EFFECTS_LAYER
	var/obj/machinery/holy_purifier/core/linked_core = null

/obj/effect/hellsbane_animation
	name = null
	icon = 'modular/kaizoku/icons/mapset/hellsbane_fall.dmi'
	layer = EFFECTS_LAYER
	anchored = TRUE
	density = FALSE
	mouse_opacity = 0
	var/obj/machinery/holy_purifier/core/linked_core

/obj/effect/hellsbane_animation/New(loc, obj/machinery/holy_purifier/core/C)
	..()
	linked_core = C
	src.loc = C.loc
	icon_state = "hellsbane_fall"
	spawn(15)
		start_idle_shake()

/obj/effect/hellsbane_animation/proc/start_idle_shake()
	if(!linked_core || !linked_core.active)
		qdel(src)
		return
	icon_state = "hellsbane"
	linked_core.do_smashing()
	shake_for_duration()

/obj/effect/hellsbane_animation/proc/shake_for_duration()
	var/shake_time = 0
	var/max_shake_time = 50
	shake_loop(shake_time, max_shake_time)

/obj/effect/hellsbane_animation/proc/shake_loop(current_time, max_time)
	if(!linked_core || !linked_core.active || current_time >= max_time)
		end_animation()
		return

	pixel_x = rand(-2, 2)
	pixel_y = rand(-2, 2)
	spawn(1)
		shake_loop(current_time + 1, max_time)

/obj/effect/hellsbane_animation/proc/end_animation()
	pixel_x = 0
	pixel_y = 0
	icon_state = "hellsbane_lift"

	spawn(15)
		linked_core?.process_conversion()
		qdel(src)
