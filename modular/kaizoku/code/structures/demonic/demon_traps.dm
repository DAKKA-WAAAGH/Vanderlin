/obj/structure/demon/tentacle
	name = "LEIMYOMA"
	desc = "... Smooth fibrous tissues elongated into coiling appendages that disperses poison... You better not have fun ideas with it, degenerate."
	icon = 'modular/kaizoku/icons/mapset/carcinoma_64x64.dmi'
	icon_state = "tentacle"
	anchored = TRUE
	max_integrity = 200
	density = FALSE
	layer = OBJ_LAYER

/obj/structure/demon/tentacle/Crossed(atom/movable/AM)
	. = ..()
	if(!isliving(AM))
		return
	var/mob/living/L = AM
	if(FACTION_CABAL in (L.faction || list()))
		return
	L.Paralyze(20)
	if(istype(L, /mob/living/carbon))
		var/mob/living/carbon/Ccar = L
		if(Ccar.reagents)
			if(prob(50))
				Ccar.reagents.add_reagent(/datum/reagent/berrypoison, 0.5)
			else
				Ccar.reagents.add_reagent(/datum/reagent/stampoison, 1)

/obj/structure/demon/tendril
	name = "MESOTHELIOMA"
	desc = "Protector of the malignant cores, corrupted tree with joint tissues with sharp bones as blades. Even dendor shall weep."
	icon = 'modular/kaizoku/icons/mapset/carcinoma_64x64.dmi'
	icon_state = "slashtree"
	anchored = TRUE
	density = TRUE
	layer = OBJ_LAYER
	pixel_x = -16
	var/radius = 2
	var/active = FALSE
	max_integrity = 200
	var/anchor_gateway
	attacked_sound = list('modular/kaizoku/sound/woosh/zatana_nimble(1).ogg','modular/kaizoku/sound/woosh/zatana_nimble(2).ogg','modular/kaizoku/sound/woosh/zatana_nimble(3).ogg')

/obj/structure/demon/tendril/Initialize()
	. = ..()
	call_later(CALLBACK(src, /obj/structure/demon/tendril/proc/tick), 3)

/obj/structure/demon/tendril/proc/tick()
	if(QDELETED(src))
		return
	var/list/targets = list()
	for(var/mob/living/L in range(radius, src))
		if(L.stat != DEAD && !((FACTION_CABAL in (L.faction || list())) || ("infernal" in (L.faction || list()))))
			targets += L
	active = targets.len > 0
	if(active)
		lash(targets)
	call_later(CALLBACK(src, /obj/structure/demon/tendril/proc/tick), active ? 3 : 8)

/obj/structure/demon/tendril/proc/lash(list/targets)
	if(!targets.len)
		return

	flick("slashtree_attack", src)
	playsound(get_turf(src), pick(attacked_sound), 100)

	for(var/mob/living/Lt3 in targets)
		if(Lt3.stat == DEAD)
			continue
		var/list/limb_zones = list(BODY_ZONE_L_ARM, BODY_ZONE_R_ARM, BODY_ZONE_L_LEG, BODY_ZONE_R_LEG, BODY_ZONE_CHEST, BODY_ZONE_HEAD)
		var/zone = pick(limb_zones)
		var/obj/item/bodypart/target_bp = Lt3.get_bodypart(zone)
		var/damage = rand(20,40) //Don't stay near this.
		var/wound_class = BCLASS_CUT
		var/protected = FALSE

		if(target_bp && zone == BODY_ZONE_HEAD) //Checks for head protection.
			var/obj/item/clothing/C = Lt3.get_item_by_slot(ITEM_SLOT_HEAD)
			if(istype(C) && islist(C.prevent_crits) && (wound_class in C.prevent_crits))
				protected = TRUE
				to_chat(Lt3, "<span class='notice'>[C] catches the barbs from [src]!</span>")
		//Seems vulnerable...
		if(target_bp && zone == BODY_ZONE_HEAD && !protected)
			var/obj/item/I = Lt3.get_item_by_slot(ITEM_SLOT_HEAD) //If the head is unprotected even with a headslot, push it off.
			if(I)
				Lt3.doUnEquip(I)
				I.forceMove(get_turf(Lt3))
			Lt3.visible_message(
				"<span class='danger'>Barbed tendrils from [src] scythe across [Lt3]'s neck, severing the head!</span>",
				"<span class='userdanger'>A barbed lash bites your neck—your head is torn free!</span>"
			)
			var/obj/item/bodypart/head = Lt3.get_bodypart(BODY_ZONE_HEAD)
			if(head)
				head.dismember()
			Lt3.emote("scream")
			continue
		if(protected) //The head was protected? Then continue with a normal behavior.
			continue

		Lt3.visible_message(
			"<span class='danger'>Barbed tendrils whip from [src], raking [Lt3]'s [parse_zone(zone)]!</span>",
			"<span class='userdanger'>Barbed tendrils rake your [parse_zone(zone)]!</span>"
		)
		Lt3.apply_damage(damage, BRUTE, zone)

		if(target_bp)
			var/datum/wound/W
			if(prob(15))
				W = new /datum/wound/slash/large()
			else if(prob(35))
				W = new ((damage > 10) ? /datum/wound/slash : /datum/wound/slash/small)
			if(W)
				W.apply_to_bodypart(target_bp, FALSE, TRUE)
				Lt3.visible_message("<span class='warning'>[Lt3]'s [parse_zone(zone)] is torn open by barbs!</span>")

/obj/structure/demon/tendril/attackby(obj/item/I, mob/user, params)
	. = ..()
	if(QDELETED(src))
		return

/obj/structure/demon/turret
	name = "ANGIOSARCOMA"
	desc = "... Swollen blood vessels compacted into a maligned mass in mockery of the steadfast, coughing gouts of blistering rot ..."
	icon = 'modular/kaizoku/icons/mapset/carcinoma_64x64.dmi'
	icon_state = "turret"
	anchored = TRUE
	density = TRUE
	layer = OBJ_LAYER
	max_integrity = 200
	var/fire_cooldown = 6 SECONDS
	var/last_fire = 0
	var/range = 6

/obj/structure/demon/turret/Initialize()
	. = ..()
	START_PROCESSING(SSfastprocess, src)

/obj/structure/demon/turret/Destroy()
	STOP_PROCESSING(SSfastprocess, src)
	return ..()

/obj/structure/demon/turret/proc/upgrade_to_second_colony()
	if(is_second_colony)
		return
	is_second_colony = TRUE
	max_integrity = round(max_integrity * 1.5)
	atom_integrity = max_integrity
	fire_cooldown = 5 SECONDS
	range = 8
	visible_message("<span class='danger'>[src] hums... the fibers contracting.</span>")

/obj/structure/demon/turret/process()
	if(QDELETED(src) || !DEMON_HIVE || !DEMON_HIVE.is_active)
		return
	if(world.time < last_fire + fire_cooldown)
		return
	var/mob/living/target = null
	for(var/mob/living/Ltt in oview(range, src))
		if(!(FACTION_CABAL in (Ltt.faction || list())))
			if(!target || get_dist(src, Ltt) < get_dist(src, target))
				target = Ltt
	if(target)
		fire_at_target(target)
		last_fire = world.time

/obj/structure/demon/turret/proc/fire_at_target(mob/living/target)
	if(!target || QDELETED(target))
		return
	dir = get_dir(src, target)
	var/obj/projectile/demon/glop/P = new /obj/projectile/demon/glop(get_turf(src))
	P.firer = src
	P.fired_from = src
	P.is_second_colony = is_second_colony
	var/base = dir2angle(get_dir(src, target))
	var/spread = rand(-6, 6)
	P.fire(base + spread)
	flick("turret_crack", src)
	playsound(get_turf(src), 'sound/foley/meatslap.ogg', 60, FALSE)

/obj/projectile/demon/glop
	name = "rot"
	icon = 'modular/kaizoku/icons/mapset/carcinoma_32x32.dmi'
	icon_state = "rot"
	speed = 2
	range = 12
	damage = 0
	var/is_second_colony = FALSE

/obj/projectile/demon/glop/on_hit(atom/target, blocked)
	if(isliving(target))
		var/mob/living/Lhit = target
		var/dmg = is_second_colony ? rand(30,20) : rand(20,10)
		Lhit.adjustFireLoss(dmg)
		Lhit.visible_message("<span class='danger'>rot splashes over [Lhit]!</span>", "<span class='userdanger'>The glop rot burns your flesh!</span>")
	return ..()

/obj/structure/demon/railing
	name = "GLIOMA"
	desc = "... Only the disgrace can thread, doorways leading to the mouth of dispair ..."
	icon = 'modular/kaizoku/icons/mapset/carcinoma_32x32.dmi'
	icon_state = "fence"
	density = TRUE
	anchored = TRUE
	flags_1 = ON_BORDER_1
	climbable = TRUE
	var/pass_crawl = FALSE
	layer = ABOVE_MOB_LAYER

/obj/structure/demon/railing/CanPass(atom/movable/mover, turf/target)
	. = ..()
	if(isobserver(mover))
		return TRUE
	if(istype(mover, /mob/camera))
		return TRUE
	if(istype(mover, /obj/projectile))
		return TRUE
	if(mover.throwing)
		return TRUE
	if(isliving(mover))
		var/mob/living/M = mover
		if(FACTION_CABAL in (M.faction || list()))
			return TRUE
		if(dir in list(NORTHEAST, NORTHWEST, SOUTHEAST, SOUTHWEST))
			return FALSE
		if(get_dir(loc, target) == dir)
			return FALSE
	return TRUE

/obj/structure/demon/railing/CanAStarPass(ID, to_dir, requester)
	if(isliving(requester))
		var/mob/living/Mr = requester
		if(FACTION_CABAL in (Mr.faction || list()))
			return TRUE
		if(to_dir == dir)
			return FALSE
	return TRUE

/obj/structure/demon/railing/do_climb(atom/movable/A, mob/user)
	if(isliving(user))
		var/mob/living/Mu = user
		if(!(FACTION_CABAL in (Mu.faction || list())))
			to_chat(Mu, "<span class='warning'>The bones from that thing would impale you alive.</span>")
			return FALSE
	return ..()

/obj/structure/demon/railing/Initialize()
	. = ..()
	update_icon()
	refresh_neighbors()

/obj/structure/demon/railing/proc/refresh_neighbors()
	for(var/d in list(NORTH, SOUTH, EAST, WEST))
		var/turf/T = get_step(src, d)
		if(T)
			for(var/obj/structure/demon/railing/R in T)
				R.update_icon()

/obj/structure/demon/railing/update_icon()
	. = ..()
	var/list/adjacent = list()
	for(var/d in list(NORTH, SOUTH, EAST, WEST))
		var/turf/T = get_step(src, d)
		if(T && !(locate(/obj/effect/demon/corruption) in T))
			adjacent += d
	if((NORTH in adjacent) && (EAST in adjacent))
		dir = NORTHEAST
	else if((NORTH in adjacent) && (WEST in adjacent))
		dir = NORTHWEST
	else if((SOUTH in adjacent) && (EAST in adjacent))
		dir = SOUTHEAST
	else if((SOUTH in adjacent) && (WEST in adjacent))
		dir = SOUTHWEST
	// For straight edges, dir remains as set during placement
	icon_state = "fence_[lowertext(dir2text(dir))]"

/obj/structure/demon/mine
	name = "HEMAGNGIOMA"
	desc = "... Blood vessel... ready to burst into a spray of acidic pus..."
	icon = 'modular/kaizoku/icons/mapset/carcinoma_64x64.dmi'
	icon_state = "mine"
	anchored = TRUE
	density = FALSE
	layer = OBJ_LAYER - 0.1
	max_integrity = 100
	alpha = 180
	var/armed = TRUE
	var/explosion_damage = 25

/obj/structure/demon/mine/Crossed(atom/movable/AM)
	. = ..()
	if(!armed)
		return
	if(isliving(AM))
		var/mob/living/Lm = AM
		if(!(FACTION_CABAL in (Lm.faction || list())))
			explode(Lm)

/obj/structure/demon/mine/proc/explode(mob/living/trigger_mob = null)
	if(!armed)
		return
	armed = FALSE

	visible_message("<span class='userdanger'>[src]'s acidic pus is sprayed as it explodes!</span>")
	playsound(get_turf(src), 'sound/misc/explode/explosionclose (1).ogg', 100, FALSE)

	new /obj/effect/temp_visual/explosion(get_turf(src))

	for(var/mob/living/Lme in range(2, src))
		if(FACTION_CABAL in (Lme.faction || list()))
			continue
		var/distance = get_dist(src, Lme)
		var/damage_mult = 1.0
		switch(distance)
			if(0)
				damage_mult = 1.5
			if(1)
				damage_mult = 1.0
			if(2)
				damage_mult = 0.5
		var/acid_damage = round(explosion_damage * damage_mult)
		var/fire_damage = round((explosion_damage * 0.7) * damage_mult)
		Lme.adjustFireLoss(fire_damage)
		Lme.adjustBruteLoss(acid_damage)
		Lme.visible_message("<span class='danger'>[Lme] is caught in the acidic explosion!</span>",
				  "<span class='userdanger'>Fetid smell- and extreme burn.</span>")
		if(distance <= 1)
			if(istype(Lme, /mob/living/carbon))
				var/mob/living/carbon/Cme = Lme
				if(Cme.reagents)
					Cme.apply_status_effect(/datum/status_effect/debuff/acidsplash, 2)
		shake_camera(Lme, 5, 4)

	for(var/obj/O in range(1, src))
		if(istype(O, /obj/structure/demon))
			continue
		if(istype(O, /atom/movable) && istype(O, /obj))
			if(istype(O, /obj/structure))
				var/obj/structure/OS = O
				OS.take_damage(explosion_damage, BURN)
