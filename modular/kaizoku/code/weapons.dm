// =================================================================
// ========================		SHIELD	============================

/obj/item/weapon/shield/wood/rattan //The description about the firearm projectiles protection is actually real for this shield, pretty neat thing to include here. It won't change gamewise tho
	name = "rattan shield"
	desc = "A lightweight rattan shield woven with leather padding and hardened in oil, known for keeping shrapnel and firearm projectiles stuck after being shot at. \nIt can exceptionally block attacks but is more brittle than metal."
	icon = 'modular/kaizoku/icons/weapons/32.dmi'
	icon_state = "rattanshield"
	dropshrink = 0.8
	coverage = 50
	max_integrity = 150


/obj/item/weapon/shield/wood/rattan/getonmobprop(tag)
	. = ..()
	if(tag)
		switch(tag)
			if("gen")
				return list("shrink" = 0.6,"sx" = -5,"sy" = -1,"nx" = 6,"ny" = -1,"wx" = 0,"wy" = -2,"ex" = 0,"ey" = -2,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 0,"nflip" = 0,"sflip" = 0,"wflip" = 1,"eflip" = 0)
			if("onback")
				return list("shrink" = 0.6,"sx" = 1,"sy" = 4,"nx" = 1,"ny" = 2,"wx" = 3,"wy" = 3,"ex" = 0,"ey" = 2,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 0,"nflip" = 8,"sflip" = 0,"wflip" = 0,"eflip" = 0,"northabove" = 1,"southabove" = 0,"eastabove" = 0,"westabove" = 0)

/obj/item/weapon/shield/tower/abyssaltower
	name = "abyssal towershield"
	desc = "The legendary shield frame named 'Naraku-kai no Tate', long used by Abyssariad champions in the old age against demonic incursions on Fog Islands. It has resemblance with Aasimar's tower shields, which was proper for the time."
	icon_state = "abyssaltower"
	icon = 'modular/kaizoku/icons/weapons/32.dmi'
	force = 15
	throwforce = 10
	throw_speed = 1
	throw_range = 3
	wlength = WLENGTH_NORMAL
	wbalance = -1 // Heavy, big shield
	resistance_flags = FLAMMABLE
	wdefense = 6
	coverage = 65
	parrysound = list('sound/combat/parry/shield/towershield (1).ogg','sound/combat/parry/shield/towershield (2).ogg','sound/combat/parry/shield/towershield (3).ogg')
	max_integrity = 300
	smeltresult = /obj/item/ingot/iron // Made with an iron ingot, let us recover it

/obj/item/weapon/shield/abyssaltower/dustcurse/dropped()
	. = ..()
	name = "Dustcurse abyssal towershield"
	minstr = 0 //asset solely to be used by NPCs. This will not be found on the hands of players.
	to_chat(src, "<span class='warning'>A haunting wind scatters [usr] into dust, sweeping it back to the ocean!</span>")
	if(QDELETED(src))
		return
	qdel(src)

/obj/item/weapon/shield/tower/metal/abyssal
	name = "spiked steel aegis"
	desc = "Light steel spikes are visible on this shield to protect the user against the chaotic close-quarter skirmishes where grappling and flanking is common, but can be caught on enemy armor and weapons."
	icon_state = "aegis"
	icon = 'modular/kaizoku/icons/weapons/32.dmi'
	possible_item_intents = list(/datum/intent/shield/bash/metal, /datum/intent/shield/block/metal)
	force = 20
	throwforce = 10
	throw_speed = 1
	throw_range = 3
	wlength = WLENGTH_NORMAL
	resistance_flags = null
	flags_1 = CONDUCT_1
	wdefense = 7
	coverage = 70
	attacked_sound = list('sound/combat/parry/shield/metalshield (1).ogg','sound/combat/parry/shield/metalshield (2).ogg','sound/combat/parry/shield/metalshield (3).ogg')
	parrysound = list('sound/combat/parry/shield/metalshield (1).ogg','sound/combat/parry/shield/metalshield (2).ogg','sound/combat/parry/shield/metalshield (3).ogg')
	max_integrity = 500
	blade_dulling = DULLING_BASH
	sellprice = 30
	smeltresult = /obj/item/ingot/steel // Made with steel, let us repurpose it

/obj/item/weapon/shield/tower/metal/abyssal/getonmobprop(tag)
	if(tag)
		switch(tag)
			if("gen")
				return list("shrink" = 0.6,"sx" = -5,"sy" = -1,"nx" = 6,"ny" = -1,"wx" = 0,"wy" = -2,"ex" = 0,"ey" = -2,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 0,"nflip" = 0,"sflip" = 0,"wflip" = 1,"eflip" = 0)
			if("onback")
				return list("shrink" = 0.6,"sx" = 1,"sy" = 4,"nx" = 1,"ny" = 2,"wx" = 3,"wy" = 3,"ex" = 0,"ey" = 2,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 0,"nflip" = 8,"sflip" = 0,"wflip" = 0,"eflip" = 0,"northabove" = 1,"southabove" = 0,"eastabove" = 0,"westabove" = 0)
	return ..()

/obj/item/weapon/shield/tower/metal/attack_hand(mob/user)
		..()

/obj/item/weapon/shield/tower/metal/abyssal/dustcurse/dropped()
	. = ..()
	name = "Dustcurse spiked steel aegis"
	minstr = 0 //asset solely to be used by NPCs. This will not be found on the hands of players.
	to_chat(src, "<span class='warning'>A haunting wind scatters [usr] into dust, sweeping it back to the ocean!</span>")
	if(QDELETED(src))
		return
	qdel(src)


// =================================================================
// ========================		AXE		============================

/obj/item/weapon/axe/battle/ono
	slot_flags = ITEM_SLOT_HIP
	name = "nagai ono"
	desc = "A battleaxe of Abyssariad design with a longer handle and shorter blade. The increased leverage, reduced weight, and smaller striking area give it greater use against armor."
	icon_state = "ono"
	parrysound = list('sound/combat/parry/wood/parrywood (1).ogg', 'sound/combat/parry/wood/parrywood (2).ogg', 'sound/combat/parry/wood/parrywood (3).ogg')
	minstr = 8
	icon = 'modular/kaizoku/icons/weapons/32.dmi'
	max_integrity = INTEGRITY_STANDARD
	wdefense = GOOD_PARRY

/obj/item/weapon/axe/battle/ono/getonmobprop(tag)
	if(tag)
		switch(tag)
			if("gen")
				return list("shrink" = 0.6,"sx" = -12,"sy" = -10,"nx" = 12,"ny" = -10,"wx" = -8,"wy" = -7,"ex" = 3,"ey" = -9,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 90,"sturn" = -90,"wturn" = -90,"eturn" = 90,"nflip" = 0,"sflip" = 8,"wflip" = 8,"eflip" = 0)
			if("wielded")
				return list("shrink" = 0.6,"sx" = -12,"sy" = 3,"nx" = 12,"ny" = 2,"wx" = -8,"wy" = 2,"ex" = 4,"ey" = 2,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 0,"nflip" = 0,"sflip" = 8,"wflip" = 8,"eflip" = 0)
			if("onbelt")
				return list("shrink" = 0.3,"sx" = -2,"sy" = -5,"nx" = 4,"ny" = -5,"wx" = 0,"wy" = -5,"ex" = 2,"ey" = -5,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 0,"nflip" = 0,"sflip" = 0,"wflip" = 0,"eflip" = 0)
	return ..()

/obj/item/weapon/axe/battle/ono/fogono
	slot_flags = ITEM_SLOT_HIP
	name = "custodian ono"
	desc = "Originally a survival tool reforged to celebrate the dwarven raids, now used to breach armored targets."
	icon_state = "fogaxe"
	minstr = 10
	icon = 'modular/kaizoku/icons/weapons/32.dmi'

/obj/item/weapon/axe/battle/ono/fogono/examine(mob/user)
	. = ..()
	if(ishuman(user))
		var/mob/living/carbon/human/H = user
		if(H.dna?.species?.id == "dwarf")
			to_chat(H, span_warning("TWO HEADED AXE? THIS WILL GO RIGHT TO THE BOOK OF GRUDGES!"))
			H.adjust_eye_blur(rand(3, 6) SECONDS)
			for(var/obj/item/bodypart/BP in H.bodyparts)
				if(BP.body_zone == BODY_ZONE_HEAD)
					BP.lingering_pain += rand(25, 40)
					break

/obj/item/weapon/thrown/ono
	slot_flags = ITEM_SLOT_HIP
	force = 15
	possible_item_intents = list(/datum/intent/axe/cut, /datum/intent/axe/chop) //Added chop because the throwing Ono is still suitable for woodcutting. It's a hatchet.
	name = "nage ono"
	desc = "A well-balanced, short-handled Abyssariad axe designed for throwing."
	icon = 'modular/kaizoku/icons/weapons/32.dmi'
	icon_state = "throwing_ono"
	max_blade_int = 500
	smeltresult = /obj/item/fertilizer/ash
	parrysound = list('sound/combat/parry/wood/parrywood (1).ogg', 'sound/combat/parry/wood/parrywood (2).ogg', 'sound/combat/parry/wood/parrywood (3).ogg')
	swingsound = BLADEWOOSH_MED
	wlength = WLENGTH_SHORT
	associated_skill = /datum/skill/combat/axesmaces
	minstr = 6
	max_blade_int = 200
	max_integrity = 300
	wdefense = 3
	throwforce = 40
	axe_cut = 5 //You'd be surprised to know that the axe head design for throwing is the same one for cutting wood, but lighter.
	embedding = list("embedded_pain_multiplier" = 3, "embed_chance" = 20, "embedded_fall_chance" = 60)

/obj/item/weapon/axe/iron/changfu
	name = "iron changfu"
	desc = "The tool of justice, hardwork and destruction, all in one."
	icon_state = "changfu"
	icon = 'modular/kaizoku/icons/weapons/32.dmi'
	wdefense = AVERAGE_PARRY
	axe_cut = 3 //Not as viable for cutting as the other one, less than a hatchet in fact.

/obj/item/weapon/axe/adze
	name = "custodian adze"
	desc = "A mixture between a demolition adze and a lip adze for wall breaking and fine carving alike."
	icon_state = "adze"
	icon = 'modular/kaizoku/icons/mapset/tradesector32.dmi'
	parrysound = "parrywood"
	force = DAMAGE_AXE
	force_wielded = DAMAGE_AXE_WIELD
	possible_item_intents = list(/datum/intent/axe/cut,/datum/intent/axe/chop)
	max_blade_int = 500
	max_integrity = INTEGRITY_STRONGEST
	melting_material = /datum/material/steel
	melt_amount = 75
	resistance_flags = FIRE_PROOF
	gripped_intents = list(/datum/intent/axe/cut,/datum/intent/axe/chop)
	wdefense = AVERAGE_PARRY
	minstr = 6
	sellprice = 35
	axe_cut = 15 // Better than iron
	tool_behaviour = TOOL_ADZE

/obj/item/weapon/axe/adze/getonmobprop(tag)
	if(tag)
		switch(tag)
			if("gen")
				return list("shrink" = 0.6,"sx" = -12,"sy" = -10,"nx" = 12,"ny" = -10,"wx" = -8,"wy" = -7,"ex" = 3,"ey" = -9,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 90,"sturn" = -90,"wturn" = -90,"eturn" = 90,"nflip" = 0,"sflip" = 8,"wflip" = 8,"eflip" = 0)
			if("wielded")
				return list("shrink" = 0.6,"sx" = -12,"sy" = 3,"nx" = 12,"ny" = 2,"wx" = -8,"wy" = 2,"ex" = 4,"ey" = 2,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 0,"nflip" = 0,"sflip" = 8,"wflip" = 8,"eflip" = 0)
			if("onbelt")
				return list("shrink" = 0.3,"sx" = -2,"sy" = -5,"nx" = 4,"ny" = -5,"wx" = 0,"wy" = -5,"ex" = 2,"ey" = -5,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 0,"nflip" = 0,"sflip" = 0,"wflip" = 0,"eflip" = 0)
	return ..()

/obj/item/weapon/axe/adze/attack_atom(atom/attacked_atom, mob/living/user)
	if(istype(attacked_atom, /turf/closed/wall))
		return apply_wall_damage(attacked_atom, user)

	else if(istype(attacked_atom, /obj/structure/door))
		return apply_door_damage(attacked_atom, user)

	return ..()

/obj/item/weapon/axe/adze/proc/apply_wall_damage(turf/closed/wall/W, mob/living/user)
	var/bonus_damage = 50
	if(user.incapacitated() || !user.CanReach(W, src))
		return

	user.do_attack_animation(W, used_item = src)
	W.take_damage(bonus_damage, BRUTE, "blunt", 0)
	visible_message("<span class='danger'>[W]'s surface cracks loudly from the impact!</span>")
	playsound(W, pick(
		'sound/combat/parry/shield/towershield (1).ogg',
		'sound/combat/parry/shield/towershield (2).ogg',
		'sound/combat/parry/shield/towershield (3).ogg'), 50, TRUE)

	if(prob(33))
		var/datum/effect_system/spark_spread/S = new()
		var/turf/front = get_step(user, user.dir)
		S.set_up(1, 1, front)
		S.start()

	return TRUE

/obj/item/weapon/axe/adze/proc/apply_door_damage(obj/structure/door/D, mob/living/user)
	var/bonus_damage = 30
	if(user.incapacitated() || !user.CanReach(D, src))
		return

	user.do_attack_animation(D, used_item = src)
	D.take_damage(bonus_damage, BRUTE, "blunt", 0)
	visible_message("<span class='danger'>[D] shudders violently from the blow!</span>")
	playsound(D, pick(
		'sound/combat/parry/shield/towershield (1).ogg',
		'sound/combat/parry/shield/towershield (2).ogg',
		'sound/combat/parry/shield/towershield (3).ogg'), 50, TRUE)

	if(prob(33))
		var/datum/effect_system/spark_spread/S = new()
		var/turf/front = get_step(user, user.dir)
		S.set_up(1, 1, front)
		S.start()

	return TRUE

// =================================================================
// ========================		MACE	============================

/obj/item/weapon/mace/goden/otsuchi
	force = 10
	force_wielded = 25
	possible_item_intents = list(/datum/intent/mace/strike)
	gripped_intents = list(/datum/intent/mace/strike/heavy, /datum/intent/mace/smash/heavy)
	name = "otsuchi"
	desc = "A wooden greathammer of Abyssariad make, heavy enough to give any warrior pause."
	icon_state = "otsuchi"
	icon = 'modular/kaizoku/icons/weapons/64.dmi'
	sharpness = IS_BLUNT
	wlength = WLENGTH_GREAT
	w_class = WEIGHT_CLASS_BULKY
	slot_flags = ITEM_SLOT_BACK
	associated_skill = /datum/skill/combat/axesmaces
	smeltresult = /obj/item/fertilizer/ash
	swingsound = BLUNTWOOSH_HUGE
	max_integrity = 250
	minstr = 10
	wdefense = 3
	pixel_y = -16
	pixel_x = -16
	inhand_x_dimension = 64
	inhand_y_dimension = 64
	bigboy = TRUE
	gripsprite = TRUE

/obj/item/weapon/mace/goden/kanabo
	name = "kanabo"
	desc = "A heavy two handed club, reinforced with a plentiful of iron studs."
	icon_state = "kanabo"
	possible_item_intents = list(/datum/intent/mace/strike/heavy)
	gripped_intents = list(/datum/intent/mace/smash/heavy) //Can't spear people, but can make them bleed due to spikes.
	sharpness = IS_SHARP
	icon = 'modular/kaizoku/icons/weapons/64.dmi'
	parrysound = "parrywood"
	swingsound = BLUNTWOOSH_MED
	pixel_y = -16
	pixel_x = -16
	inhand_x_dimension = 64
	inhand_y_dimension = 64
	bigboy = TRUE
	gripsprite = TRUE
	slowdown = 1

/obj/item/weapon/mace/goden/kanabo/dustcurse/dropped()
	. = ..()
	name = "Dustcurse kanabo"
	to_chat(src, "<span class='warning'>A haunting wind scatters [usr] into dust, sweeping it back to the ocean!</span>")
	minstr = 0 //asset solely to be used by NPCs. This will not be found on the hands of players.
	if(QDELETED(src))
		return
	qdel(src)

/obj/item/weapon/mace/goden/steel/tetsubo
	name = "tetsubo"
	desc = "A heavier variant of the kanabo, fitted with a steel sleeve bearing menacing spikes and favored by ogrun warlords."
	icon_state = "tetsubo"
	possible_item_intents = list(/datum/intent/mace/strike/heavy)
	gripped_intents = list(/datum/intent/mace/smash/heavy) //Can't spear people, but can make them bleed due to spikes.
	sharpness = IS_SHARP
	icon = 'modular/kaizoku/icons/weapons/64.dmi'
	pixel_y = -16
	pixel_x = -16
	inhand_x_dimension = 64
	inhand_y_dimension = 64

/obj/item/weapon/mace/goden/steel/tetsubo/dustcurse/dropped()
	. = ..()
	name = "Dustcurse tetsubo"
	minstr = 0 //asset solely to be used by NPCs. This will not be found on the hands of players.
	to_chat(src, "<span class='warning'>A haunting wind scatters [usr] into dust, sweeping it back to the ocean!</span>")
	if(QDELETED(src))
		return
	qdel(src)

/obj/item/weapon/mace/ararebo
	name = "ararebo"
	icon = 'modular/kaizoku/icons/weapons/32.dmi'
	icon_state = "ararebo"
	desc = "A large, iron-capped club used by Abyssariads as a armor-breaking tool."

/obj/item/weapon/mace/ararebo/dustcurse/dropped()
	. = ..()
	name = "Dustcurse ararebo"
	to_chat(src, "<span class='warning'>A haunting wind scatters [usr] into dust, sweeping it back to the ocean!</span>")
	if(QDELETED(src))
		return
	qdel(src)

/obj/item/weapon/mace/ararebo/obsidian
	name = "obsidian club"
	icon_state = "obsidian_club"
	desc = "A large, wooden club with sharp flakes of obsidian embedded into it."
	max_integrity = 150
	wlength = WLENGTH_SHORT
	w_class = WEIGHT_CLASS_NORMAL
	sharpness = IS_SHARP
	wbalance = -1
	minstr = 0
	wdefense = 3

/obj/item/weapon/mace/steel/ararebo
	name = "steel ararebo"
	icon = 'modular/kaizoku/icons/weapons/32.dmi'
	icon_state = "sararebo"
	desc = "A large, steel-capped club used by Abyssariads as a armor-breaking tool."

/obj/item/weapon/mace/steel/ararebo/dustcurse/dropped()
	. = ..()
	name = "Dustcurse steel ararebo"
	to_chat(src, "<span class='warning'>A haunting wind scatters [usr] into dust, sweeping it back to the ocean!</span>")
	if(QDELETED(src))
		return
	qdel(src)

/obj/item/weapon/mace/cudgel/rungu
	force = 15
	force_wielded = 20
	name = "rungu club"
	desc = "A more well defined, chiseled and ashed wooden club that can be throw at enemies. Used by Undine warriors."
	icon_state = "rungu"
	icon = 'modular/kaizoku/icons/weapons/32.dmi'
	wbalance = 0
	wdefense = 1
	wlength = WLENGTH_NORMAL
	w_class = WEIGHT_CLASS_NORMAL
	max_integrity = 150
	possible_item_intents = list(/datum/intent/mace/strike/wood)
	gripped_intents = list(/datum/intent/mace/strike/wood, /datum/intent/mace/smash/wood)
	smeltresult = /obj/item/fertilizer/ash
	minstr = 0
	throwforce = 25

/obj/item/weapon/mace/cudgel/jitte
	name = "jitte"
	desc = "An abyssariad guard weapon. The hook along the shaft allows the club to arrest a blade that has been parried."
	icon = 'modular/kaizoku/icons/weapons/32.dmi'
	icon_state = "jitte"
	wdefense = 4


// =================================================================
// ========================		FLAIL	============================

/datum/intent/flail/cut
	name = "cut"
	blade_class = BCLASS_CUT
	attack_verb = list("cuts", "slashes")
	hitsound = list('sound/combat/hits/blunt/flailhit.ogg')
	swingdelay = 5
	penfactor = AP_AXE_CHOP
	icon_state = "incut"
	misscost = 5
	reach = 2
	recovery = 10
	chargedloop = /datum/looping_sound/flailswing
	keep_looping = TRUE
	chargetime = 5
	no_early_release = TRUE

/datum/intent/flail/cut/chop
	name = "chop"
	chargetime = 5
	no_early_release = TRUE
	penfactor = AP_FLAIL_SMASH
	recovery = 10
	damfactor = 1.2
	chargedloop = /datum/looping_sound/flailswing
	keep_looping = TRUE
	icon_state = "inchop"
	blade_class = BCLASS_CHOP
	attack_verb = list("chops")
	hitsound = list('sound/combat/hits/blunt/flailhit.ogg')
	misscost = 10
	chargetime = 10


/obj/item/weapon/flail/sflail/kusarifundo
	name = "kusari fundo"
	icon = 'modular/kaizoku/icons/weapons/32.dmi'
	desc = "A pair of heavy steel weights connected by a long chain."
	icon_state = "kusarifundo"

/obj/item/weapon/flail/nunchaku
	force = 20
	w_class = WEIGHT_CLASS_SMALL
	name = "nunchaku"
	icon = 'modular/kaizoku/icons/weapons/32.dmi'
	desc = "A pair of wooden rods linked by a short chain, designed for concealment and often used by Abyssariad Plowmen."
	icon_state = "nunchaku"

/obj/item/weapon/flail/kusarigama
	possible_item_intents = list(/datum/intent/flail/strike, /datum/intent/flail/strike/smash, /datum/intent/flail/cut, /datum/intent/flail/cut/chop)
	name = "kusarigama"
	desc = "A handle with a sickle-like blade, featuring a chain that ends in a spiked ball."
	icon_state = "kusarigama"
	icon = 'modular/kaizoku/icons/weapons/32.dmi'
	sharpness = IS_SHARP
	blade_dulling = DULLING_BASHCHOP
	smeltresult = /obj/item/ingot/steel
	parrysound = list('sound/combat/parry/parrygen.ogg')
	swingsound = BLUNTWOOSH_MED

/obj/item/weapon/flail/kusarigama/peasant
	force = DAMAGE_WEAK_FLAIL
	name = "handmade kusarigama"
	desc = "A handle with a sickle-like blade and a chain with spiked ball, quickly assembled from an actual plowmen's sickle - it is clearly homemade."
	icon_state = "kusarigama_homemade"
	smeltresult = /obj/item/ingot/iron



// =================================================================
// ========================		KNIFE	============================

/obj/item/weapon/knife/dagger/kunai //Practically a villager knife with more utility. It helps others to climb walls.
	name = "kunai"
	desc = "A simple stabbing weapon made of iron which originated as a masonry or gardening tool, useful for climbing walls in similar ways to pitons."
	icon = 'modular/kaizoku/icons/weapons/32.dmi'
	icon_state = "kunai"
	force = 8

/obj/item/weapon/knife/kaiken
	name = "iron kaiken"
	desc = "Combat knife proper for usage in areas that has weapon laws."
	icon = 'modular/kaizoku/icons/weapons/32.dmi'
	icon_state = "kaiken"
	possible_item_intents = list(/datum/intent/dagger/thrust, /datum/intent/dagger/cut)
	force = DAMAGE_DAGGER
	smeltresult = null
	sellprice = 15

/obj/item/weapon/knife/steel/tanto
	name = "steel tanto"
	desc = "Initially a companion blade to the tachi in a zamurai's daisho, it has been replaced by the wakizashi only time ago."
	icon = 'modular/kaizoku/icons/weapons/32.dmi'
	icon_state = "tanto"
	possible_item_intents = list(/datum/intent/dagger/cut, /datum/intent/dagger/thrust, /datum/intent/dagger/chop)
	force = DAMAGE_DAGGER+2
	smeltresult = null
	wdefense = AVERAGE_PARRY
	wbalance = VERY_HARD_TO_DODGE
	sellprice = 20

/obj/item/weapon/knife/hunting/sai //I love gundam for helping me on my request on this sai. I love HIM!!!!!!!!!!!!! -Monochrome
	name = "sai"
	desc = "A dagger with a sharply-tapered central rod with two prongs at the cross-guards, excels in jabbing and defending against other weapons."
	icon = 'modular/kaizoku/icons/weapons/32.dmi'
	icon_state = "sai"
	possible_item_intents = list(/datum/intent/dagger/thrust)
	w_class = WEIGHT_CLASS_NORMAL
	force = 10
	wdefense = 4 //With another Sai = 8
	//dual_wield = 2 //For now, the only weapon with dual_wield. The 2 is a MULTIPLICATOR. Later I will make the hook swords, which is a direct update.


// =================================================================
// ========================		POLEARM	============================

/obj/item/weapon/polearm/spear/yari
	name = "su yari"
	desc = "A long, straight-headed spear of Abyssariad design, often used by sea raiders to fend off light cavalry on in-land offensives."
	icon_state = "suyari"
	icon = 'modular/kaizoku/icons/weapons/64.dmi'
	pixel_y = -16
	pixel_x = -16
	inhand_x_dimension = 64
	inhand_y_dimension = 64
	bigboy = TRUE
	gripsprite = TRUE
	smeltresult = /obj/item/ingot/iron
	dropshrink = 0.8
	blade_dulling = DULLING_BASHCHOP

/obj/item/weapon/polearm/spear/yari/katakama
	name = "katakama yari"
	desc = "An evolution of the su yari, recognizable for a single scythe-like tang perpendicular to the main point for better defense."
	icon_state = "katakamayari"
	wdefense = 5
	smeltresult = /obj/item/ingot/iron
	max_blade_int = 150
	max_integrity = 400

/obj/item/weapon/polearm/spear/billhook/jumonji
	name = "jumonji yari"
	desc = "This one features an elongated tang on each side that is the same length as the forward point."
	icon_state = "jumonjiyari"

/obj/item/weapon/polearm/halberd/bardiche/naginata
	name = "naginata"
	desc = "Its earliest form being a zatana blade mounted upon a long wooden pole, the naginata was the first polearm to come into widespread use by the Abyssariad."
	icon = 'modular/kaizoku/icons/weapons/64.dmi'
	icon_state = "naginata"
	dropshrink = 0.8

/obj/item/weapon/polearm/halberd/bardiche/naginata/dustcurse/dropped()
	. = ..()
	name = "Dustcurse naginata"
	minstr = 0 //asset solely to be used by NPCs. This will not be found on the hands of players.
	to_chat(src, "<span class='warning'>A haunting wind scatters [usr] into dust, sweeping it back to the ocean!</span>")
	if(QDELETED(src))
		return
	qdel(src)

/obj/item/weapon/polearm/halberd/bardiche/naginata/tsukushi //make two instead of only one
	name = "tsukushi naginata"
	desc = "A cheaper, easier to construct iron naginata with a blade held by its guard instead of its tang."
	force_wielded = DAMAGE_SPEAR_WIELD+3
	icon_state = "surplusnaginata"
	smeltresult = /obj/item/ingot/iron
	dropshrink = 0.8
	wdefense = 4
	slot_flags = ITEM_SLOT_BACK

/obj/item/weapon/polearm/halberd/bisento //Giving the Bisento storeable 'back' because, otherwise, people will SUFFER spawning with it. Too bugged for my taste.
	name = "bisento"
	desc = "The Bisento is the direct evolution of the old, outdated Champion Guandao. Akin to a large cleaver or a broad axe."
	icon_state = "bisento"
	dropshrink = 0.8
	icon = 'modular/kaizoku/icons/weapons/64.dmi'

/obj/item/weapon/polearm/halberd/bisento/dustcurse/dropped()
	. = ..()
	name = "Dustcurse bisento"
	minstr = 0 //asset solely to be used by NPCs. This will not be found on the hands of players.
	to_chat(src, "<span class='warning'>A haunting wind scatters [usr] into dust, sweeping it back to the ocean!</span>")
	if(QDELETED(src))
		return
	qdel(src)

/obj/item/weapon/polearm/spear/stone/obsidian //direct upgrade to the stone one.
	force = DAMAGE_SPEAR+2
	force_wielded = DAMAGE_SPEAR+4
	throwforce = DAMAGE_SPEAR
	name = "obsidian spear"
	desc = "A spear with a surprisingly sharp edge from vulcanic glass. Used by Undine tribes."
	icon_state = "obsidian_spear"
	icon = 'modular/kaizoku/icons/weapons/64.dmi'
	pixel_y = -16
	pixel_x = -16
	inhand_x_dimension = 64
	inhand_y_dimension = 64
	smeltresult = /obj/item/fertilizer/ash
	max_blade_int = 100

/obj/item/weapon/polearm/woodstaff/quarterstaff/bostaff
	name = "bo staff"
	desc = "the bo, or 'abyssariad quarterstaff', is a simple weapon used in martial arts to entrap, strike and sweep the enemy."
	icon_state = "bostaff"
	icon = 'modular/kaizoku/icons/weapons/64.dmi'
	bigboy = TRUE

/obj/item/weapon/polearm/firelance
	name = "sanctiflux firelance"
	desc = "The new iteration of the ancient abyssariad 'Widowmaker', the harbinger of purification against zizodemons, tieflings and grenzelhoft."
	icon = 'modular/kaizoku/icons/weapons/firelance.dmi'
	icon_state = "firelance"
	possible_item_intents = list(/datum/intent/polearm/thrust/open, /datum/intent/polearm/cut) //More effective at cutting while it is open. However, it is worse at thrusting.
	slot_flags = ITEM_SLOT_BACK
	w_class = WEIGHT_CLASS_BULKY
	can_parry = TRUE
	wlength = WLENGTH_GREAT
	bigboy = TRUE
	gripsprite = FALSE
	resistance_flags = FLAMMABLE // Weapon made mostly of wood
	max_integrity = INTEGRITY_STANDARD
	minstr = 8
	smeltresult = /obj/item/ingot/steel
	associated_skill = /datum/skill/combat/polearms
	drop_sound = 'sound/foley/dropsound/wooden_drop.ogg'
	parrysound = list('sound/combat/parry/wood/parrywood (1).ogg', 'sound/combat/parry/wood/parrywood (2).ogg', 'sound/combat/parry/wood/parrywood (3).ogg')
	dropshrink = 0.8
	blade_dulling = DULLING_BASHCHOP
	wlength = WLENGTH_LONG
	sharpness = IS_BLUNT
	minstr = 8
	sellprice = 400

	var/cocked = FALSE
	var/lit = FALSE
	var/range = 5
	var/fuel_source = FALSE
	var/fuze = 30

/obj/item/weapon/polearm/firelance/proc/ignite(mob/living/user)
	if(lit)
		to_chat(user.loc, "<span class='warning'>The Firelance's fuse is already ignited and fierce as a bull.</span>")
		return

	if(!fuel_source)
		to_chat(user.loc, "<span class='warning'>You cannot burn your enemies without a gourd with sanctiflux.</span>")
		return

	if(cocked)
		to_chat(user, "<span class='info'>The firelance's fuze starts to rebel in sparking lights.</span>")
		user.visible_message("<span class='warning'>[user] lights a firelance! FUCKING RUN!</span>","<span class='info'>I light the firelance.</span>")
		playsound(get_turf(src), 'sound/items/firelight.ogg', 100)

		lit = TRUE
		update_icon()
		spawn(20)
			if(lit)
				playsound(get_turf(src),  pick('sound/misc/explode/incendiary (1).ogg','sound/misc/explode/incendiary (2).ogg'), 100)
				flamefire(user)
				fuel_source = FALSE
				lit = FALSE
				update_icon()
	else
		return

/obj/item/weapon/polearm/firelance/proc/flamefire(mob/living/user)
	if(!user)
		return

	var/turf/start = get_turf(user) 	// VERY important. It determine user's position and firing direction. May remove it for handmade fuels.
	if(!start)
		return

	var/delta_x = 0
	var/delta_y = 0
	switch(user.dir)
		if(NORTH) delta_y = 1
		if(EAST) delta_x = 1
		if(SOUTH) delta_y = -1
		if(WEST) delta_x = -1

	for(var/distance in 1 to range) // This fire pattern widens every second tile. This will be the Abyssariad/Heartfelt 'military' standard.
		var/width = distance / 2 // Calculate when it widens
		for(var/offset in -width to width) // Control the width itself
			var/turf/current_turf
			if(delta_x) // Horizontal spread
				current_turf = locate(start.x + (delta_x * distance), start.y + offset, start.z)
			else if(delta_y) // Vertical spread
				current_turf = locate(start.x + offset, start.y + (delta_y * distance), start.z)

			if(current_turf)
				// Ignite the tile
				new /obj/effect/oilspill(current_turf)
				current_turf.hotspot_expose(500, 30, 1)

				for(var/mob/living/L in current_turf.contents)
					if(iscarbon(L) && L != user)
						L.visible_message("<span class='danger'>[L] is engulfed in flames!</span>")
						L.adjustFireLoss(rand(10, 20)) //Enough damage to ensure the player will move away.
						L.adjust_fire_stacks(3) //New addition for bugfix.
						L.IgniteMob()
	playsound(src.loc, 'modular/kaizoku/sound/spells/firelance.ogg', 100)
	cocked = FALSE
	fuel_source = FALSE // Consume  fuel after use
	update_icon()

/obj/item/weapon/polearm/firelance/dropped(mob/living/user)
	. = ..()
	if(fuel_source)
		to_chat(src, "<span class='info'>[user] dropped the [usr] with its gourd's cap unsealed, hissing quietly, as it tells the tales of widowmaking by doing the obvious.</span>")
		user.adjust_fire_stacks(3)
		user.IgniteMob()
		flamefire(user)

/obj/item/weapon/polearm/firelance/attack_self(mob/living/user)
	if(lit) // safeguard
		return
	else
		if(cocked && !fuel_source)
			to_chat(user, "<span class='info'>You open the blades. It only requires a source of fuel.</span>")
			cocked = FALSE
			update_icon()
			possible_item_intents = list(/datum/intent/polearm/thrust/open, /datum/intent/polearm/cut) //More effective at cutting while it is open. However, it is worse at thrusting.
			return
		if(!cocked && !fuel_source)
			var/obj/item/bodypart/limb
			var/list/limb_list = list(BODY_ZONE_L_ARM, BODY_ZONE_R_ARM)
			for(var/zone in limb_list)
				limb = user.get_bodypart(zone)
				if(limb)
					playsound(src,'sound/misc/guillotine.ogg', rand(30,60), TRUE)
					to_chat(user, "<span class='danger'>By pressing the arm against the empty firelance, [user]'s [limb] was snatched off!</span>")
					limb.dismember()
					qdel(limb)
					user.emote("scream")
					cocked = TRUE
					update_icon()
					return
		if(!cocked && fuel_source)
			to_chat(user, "<span class='info'>You start spinning the mechanisms, watching the jagged blades close. The weapon is now ready, but it needs to be lit.</span>")
			if(do_after(user, 60 - user.STASTR, target = user))
				playsound(user, 'sound/combat/Ranged/crossbow_medium_reload-01.ogg', 100, FALSE)
				cocked = TRUE
				possible_item_intents = list(SPEAR_THRUST, /datum/intent/polearm/cut/close) //More effective at thrusting while it is closed. However, it is worse at cutting.
				update_icon()
			return
		else
			to_chat(user, "<span class='warning'>Fuel spills due to misuse, rendering the weapon unprepared.</span>")
			cocked = FALSE
			fuel_source = FALSE
			update_icon()

/obj/item/weapon/polearm/firelance/attackby(obj/item/I, mob/living/user)
	if(!istype(I, /obj/item/sanctiflux))
		to_chat(user, "<span class='warning'>[I] is not a valid fuel source!</span>")
		return
	else
		if(fuel_source) // If it already has a fuel source, you can't insert a new one.
			to_chat(user, "<span class='warning'>The firelance already has a gourd on.</span>")
			return
		if(cocked)
			to_chat(user, "<span class='warning'>I cannot put the gourd inside if the blades are on the way.</span>")
			return
		if(!cocked)
			fuel_source = TRUE
			update_icon()
			qdel(I)
			to_chat(user, "<span class='info'>I press the gourd against the insertion hole.</span>")
			..()

/obj/item/weapon/polearm/firelance/spark_act()
	ignite(usr)

/obj/item/weapon/polearm/firelance/fire_act()
	ignite(usr)

/obj/item/weapon/polearm/firelance/update_icon()
	. = ..()
	if(lit)
		icon_state = "firelance_lit"
	else
		if(!cocked)
			if(fuel_source)
				icon_state = "firelance_oil"
			else
				icon_state = "firelance"
		else
			if(fuel_source)
				icon_state = "firelance_cocked_oil"
			else
				icon_state = "firelance_cocked"

/datum/intent/polearm/thrust/open
	damfactor = 0.8

/datum/intent/polearm/cut/close
	damfactor = 0.8

/obj/item/sanctiflux //Remember to make the firelance cause damage as soon as it starts.
	name = "sanctiflux gourd"
	desc = "The abyssariad answer to demonic corruption, purger of zizo and men, as one secret at a time."
	icon = 'modular/kaizoku/icons/weapons/items.dmi'
	icon_state = "gourd"
	w_class = WEIGHT_CLASS_SMALL
	slot_flags = ITEM_SLOT_HIP

/obj/effect/oilspill
	anchored = TRUE
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	icon = 'modular/kaizoku/icons/tileset/fire.dmi'
	icon_state = "newfire"
	layer = GASFIRE_LAYER

	var/life = 120 // Lifespan of the fire in ticks. May decrease later, but I prefer to keep its area-denial use.

/obj/effect/oilspill/Initialize()
	. = ..()
	for(var/mob/living/carbon/human/H in view(2, src)) 	// Sate pyromaniac addiction. I don't even know if that thing works, but anyway.
		if(H.has_quirk(/datum/quirk/vice/pyromaniac))
			H.sate_addiction(/datum/quirk/vice/pyromaniac)
	setDir(pick(GLOB.cardinals))
	START_PROCESSING(SSfastprocess, src)
	return

/obj/effect/oilspill/process()
	life--
	if(life <= 0)
		qdel(src)
		return

/obj/effect/oilspill/Destroy()
	STOP_PROCESSING(SSfastprocess, src)
	set_light(0)
	return ..()

/obj/effect/oilspill/Crossed(atom/movable/AM, oldLoc)
	..()
	if(isliving(AM))
		var/mob/living/L = AM
		L.fire_act(20, 40)


/*
			This is for later, for when I make different types of oilfuel, all of abyssariad or heartfelt making. Possibly the handmade alternative.
	//This following code spreads the fire in a linear pattern, the first one I made.
	for(var/distance in 1 to range)
		var/turf/current_turf = locate(start.x + (delta_x * distance), start.y + (delta_y * distance), start.z)
		if(!current_turf || current_turf.density) // Stop if obstructed
			break
	// This following code spreads the fire in a triangle pattern.
	for(var/distance in 1 to range)
		for(var/offset in -distance to distance)
			var/turf/current_turf
			if(delta_x) // Horizontal spread (EAST/WEST)
				current_turf = locate(start.x + (delta_x * distance), start.y + offset, start.z)
			else if(delta_y) // Vertical spread (NORTH/SOUTH)
				current_turf = locate(start.x + offset, start.y + (delta_y * distance), start.z)
	//This following code preads the fire in diagonal around the player.
	var/list/diagonal_directions = list(
		list(1, 1),  // NORTHEAST
		list(1, -1), // SOUTHEAST
		list(-1, -1),// SOUTHWEST
		list(-1, 1)  // NORTHWEST
	)
	// Loop through each diagonal direction
	for(var/dir_offset in diagonal_directions)
		var/delta_x = dir_offset[1]
		var/delta_y = dir_offset[2]
		// Generate the fire pattern for the given direction
		for(var/distance in 1 to range)
			var/turf/current_turf = locate(start.x + (delta_x * distance), start.y + (delta_y * distance), start.z)
*/


/obj/item/weapon/tetsubishi //I humbly request someone to cook the 'jump' not causing damage.
	name = "tetsubishi"
	desc = "a sharp spike object used to slow down pursuer, often used by abyssariad shinobis, it has been massproduced and shipped to Heartfell."
	icon_state = "tetsubishi"
	icon = 'modular/kaizoku/icons/weapons/32.dmi'
	force = 5
	throwforce = 10
	w_class = WEIGHT_CLASS_SMALL
	block_chance = 0
	armor_penetration = 5
	sharpness = IS_SHARP
	can_parry = FALSE
	wlength = 6
	sellprice = 1
	has_inspect_verb = TRUE
	parrysound = list('sound/combat/parry/parrygen.ogg')
	anvilrepair = /datum/skill/craft/weaponsmithing
	obj_flags = CAN_BE_HIT
	blade_dulling = DULLING_BASH
	max_integrity = 60
	wdefense = 3
	experimental_onhip = TRUE
	experimental_onback = TRUE
	embedding = list(
		"embed_chance" = 60,
		"embedded_pain_multiplier" = 1,
		"embedded_fall_chance" = 0,
	)
	attack_verb = list("stabbed", "slashed", "sliced", "cut")
	hitsound = 'sound/blank.ogg'
	var/icon_prefix

/obj/item/weapon/tetsubishi/Initialize()
	. = ..()
	AddComponent(/datum/component/kaizoku/caltrop, 20, 30, 100, CALTROP_BYPASS_SHOES)

/obj/item/weapon/tetsubishi/Crossed(mob/living/L)
	playsound(loc, 'sound/foley/flesh_rem2.ogg', TRUE)
	return ..()

/datum/component/kaizoku/caltrop //Less laggy alternative for the server-destroying OG caltrops.
	var/min_damage
	var/max_damage
	var/probability
	var/flags

	var/cooldown = 0

/datum/component/kaizoku/caltrop/Initialize(_min_damage = 0, _max_damage = 0, _probability = 100,  _flags = NONE)
	min_damage = _min_damage
	max_damage = max(_min_damage, _max_damage)
	probability = _probability
	flags = _flags

	RegisterSignal(parent, list(COMSIG_MOVABLE_CROSSED), PROC_REF(Crossed))

/datum/component/kaizoku/caltrop/proc/Crossed(datum/source, atom/movable/AM)
	var/atom/A = parent
	if(!prob(probability))
		return

	if(ishuman(AM))
		var/mob/living/carbon/human/H = AM
		if((flags & CALTROP_IGNORE_WALKERS) && H.m_intent == MOVE_INTENT_WALK)
			return

		var/picked_def_zone = pick(BODY_ZONE_L_LEG, BODY_ZONE_R_LEG)
		var/obj/item/bodypart/O = H.get_bodypart(picked_def_zone)
		if(!istype(O))
			return

		var/feetCover = (H.wear_armor && (H.wear_armor.body_parts_covered & FEET)) || (H.wear_pants && (H.wear_pants.body_parts_covered & FEET))

		if(!(flags & CALTROP_BYPASS_SHOES) && (H.shoes || feetCover))
			return

		if((H.movement_type & FLYING) || H.buckled)
			return

		var/damage = rand(min_damage, max_damage)
		H.apply_damage(damage, BRUTE, picked_def_zone)


		if(cooldown < world.time - 10) //cooldown to avoid message spam.
			if(!H.incapacitated(IGNORE_GRAB))
				H.visible_message("<span class='danger'>[H] steps on [A] as it pierces skin.</span>", \
						"<span class='danger'>I feel my feet being pierced as I step on [A]!</span>")
			else
				H.visible_message("<span class='danger'>[H] slides their bodies on [A]!</span>", \
						"<span class='danger'>I slide on [A]!</span>")

			cooldown = world.time
		H.Stun(60)

/obj/item/throwing_star/ninja
	name = "throwing star"
	desc = "a simple distracting tool used to cause a commotion and bleeding so its user can scramble."
	icon_state = "shuriken"
	icon = 'modular/kaizoku/icons/weapons/32.dmi'


// =================================================================
// ========================		SWORD	============================

/obj/item/weapon/sword/uchigatana
	name = "uchigatana"
	desc = "The primary sidearm for the Abyssariad and Heartfelt footsoldiers. Like most Zatanas, its curved blade favor chopping strikes."
	icon = 'modular/kaizoku/icons/weapons/32.dmi'
	icon_state = "uchigatana"
	swingsound = ZATANA_WOOSH
	smeltresult = /obj/item/ingot/steel

/obj/item/weapon/sword/uchigatana/Initialize()
	. = ..()
	var/design = rand(1, 3) //This system will be standardized to other weapons.
	switch(design)
		if(1)
			name = "islander uchigatana"
			desc = "A shorter zatana design with circular handguard and heartfelt-influenced pommel. The curveness of the blade makes it better at cutting than thrusting."
		if(2)
			name = "traditional uchigatana"
			desc = "The primary sidearm for the Abyssariad and Heartfelt footsoldiers. Like most Zatanas, its curved blade favor chopping strikes."
		if(3)
			name = "shirasaya uchigatana"
			desc = "The cheaper adaptation of the uchigatana with an complete lack of handguard and no tsuka ito. Like most Zatanas, its curved blade favor chopping strikes."
	icon_state = "uchigatana[design]"

/obj/item/weapon/sword/uchigatana/fire //Experimental weapon. Not to be found ingame.
	name = "fire uchigatana"
	desc = "Experimental uchigatana funded by the Fog island's court, now infused with sanctiflux under its blade. It releases oil and sparks to lit most enemies."

/obj/item/weapon/sword/uchigatana/fire/attack(mob/M, mob/living/carbon/human/user)
	if(ismob(M))
		fire_effect(M, user)
		..()

/obj/item/weapon/sword/uchigatana/fire/proc/fire_effect(mob/living/L, mob/user)
	L.adjust_fire_stacks(1)
	L.IgniteMob()
	addtimer(CALLBACK(L, TYPE_PROC_REF(/mob/living, ExtinguishMob)), 5 SECONDS)
	if(user)
		L.lastattacker = user.real_name
		L.lastattackerckey = user.ckey
		L.visible_message("<span class='danger'>[user] has ignited [L] with [src]!</span>", \
								"<span class='danger'>[user] has ignited you with [src]!</span>")
	playsound(loc, 'sound/blank.ogg', 50, TRUE, -1)
	return

/obj/item/weapon/sword/long/tachi
	name = "tachi"
	desc = "A long, curved Zatana of Abyssariad make, introduced during the development of cavalry tactics."
	icon = 'modular/kaizoku/icons/weapons/64.dmi'
	icon_state = "tachi"
	item_state = "tachi"
	swingsound = ZATANA_WOOSH

/obj/item/weapon/sword/long/tachi/dustcurse/dropped()
	. = ..()
	name = "Dustcurse tachi"
	minstr = 0 //asset solely to be used by NPCs. This will not be found on the hands of players.
	to_chat(src, "<span class='warning'>A haunting wind scatters [usr] into dust, sweeping it back to the ocean!</span>")
	if(QDELETED(src))
		return
	qdel(src)

/obj/item/weapon/sword/long/greatsword/zwei/okatana
	name = "o-katana"
	desc = "With the size comparable to a Tachi, the o-katana has a straighter blade most suitable for footsoldiers rather than cavalry."
	icon = 'modular/kaizoku/icons/weapons/64.dmi'
	icon_state = "okatana"
	item_state = "okatana"
	swingsound = ZATANA_WOOSH

/obj/item/weapon/sword/long/greatsword/zwei/okatana/getonmobprop(tag)
	. = ..()
	if(tag)
		switch(tag)
			if("gen")
				return list("shrink" = 0.5,"sx" = -14,"sy" = -8,"nx" = 15,"ny" = -7,"wx" = -10,"wy" = -5,"ex" = 7,"ey" = -6,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = -13,"sturn" = 110,"wturn" = -60,"eturn" = -30,"nflip" = 1,"sflip" = 1,"wflip" = 8,"eflip" = 1)
			if("onback")
				return list("shrink" = 0.5,"sx" = -1,"sy" = 2,"nx" = 0,"ny" = 2,"wx" = 2,"wy" = 1,"ex" = 0,"ey" = 1,"nturn" = 0,"sturn" = 0,"wturn" = 70,"eturn" = 15,"nflip" = 1,"sflip" = 1,"wflip" = 1,"eflip" = 1,"northabove" = 1,"southabove" = 0,"eastabove" = 0,"westabove" = 0)
			if("wielded")
				return list("shrink" = 0.6,"sx" = 6,"sy" = -2,"nx" = -4,"ny" = 2,"wx" = -8,"wy" = -1,"ex" = 8,"ey" = 3,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 15,"sturn" = -200,"wturn" = -160,"eturn" = -25,"nflip" = 8,"sflip" = 8,"wflip" = 0,"eflip" = 0)
			if("onbelt")
				return list("shrink" = 0.6,"sx" = -4,"sy" = -6,"nx" = 5,"ny" = -6,"wx" = 0,"wy" = -6,"ex" = -1,"ey" = -6,"nturn" = 100,"sturn" = 156,"wturn" = 90,"eturn" = 180,"nflip" = 0,"sflip" = 0,"wflip" = 0,"eflip" = 0,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0)

/obj/item/weapon/sword/long/greatsword/nodachi
	name = "nodachi"
	desc = "Greatsword wielded in open battlefields just as it is a ceremonial blade. It breaks spearlines and shields on a whim."
	icon_state = "nodachi"
	icon = 'modular/kaizoku/icons/weapons/64.dmi'
	parrysound = "bladedlarge"

/obj/item/weapon/sword/iron/jian
	name = "iron jian"
	icon_state = "jian1"
	icon = 'modular/kaizoku/icons/weapons/32.dmi'

/obj/item/weapon/sword/iron/jian/Initialize()
	. = ..()
	var/design = rand(1, 6) //This system will be standardized to other weapons.
	switch(design)
		if(1)
			name = "monk jian"
			desc = "A simple, double-edged iron sword. With a short guard and slim grip, it is easier to use in martial arts that requires constant flick of the wrist."
		if(2)
			name = "frontierman jian"
			desc = "A simple, double-edged iron sword. With a thicker pommel and stretched guard, it becomes more proper as sideweapons during sieges for overhead attacks."
		if(3)
			name = "guardsman jian"
			desc = "A simple, double-edged iron sword of abyssariad with parrying hooks at cost of slashing effectiveness."
		if(4)
			name = "foreigner jian"
			desc = "A simple, double-edged iron sword of abyssariad design with heartfelt influence, taking smithing standards from Zweihanders."
		if(5)
			name = "heartfelt jian"
			desc = "A simple, double-edged iron sword of abyssariad design with heartfelt influence. Keeping a rather imperial style of guard."
		if(6)
			name = "duelist jian"
			desc = "A simple, double-edged iron sword of abyssariad design with hand protection that resembles one side of the firelance apparatus. Usually used for training."
	icon_state = "jian[design]"

/obj/item/weapon/sword/scimitar/messer/dao
	name = "iron dao"
	desc = "A single edged iron saber of Abyssariad making for horseback use. Suitable for chopping."
	icon_state = "dao"
	icon = 'modular/kaizoku/icons/weapons/32.dmi'

/obj/item/weapon/sword/scimitar/falchion/yuntoudao
	name = "yuntoudao"
	desc = "A expensive Abyssariad saber with wide middle and tapered ends in a 'willow-leaf' shape."
	icon_state = "yuntoudao"
	icon = 'modular/kaizoku/icons/weapons/32.dmi'

/obj/item/weapon/sword/short/jian
	name = "short steel jian"
	desc = "A simple, shortened version of the double-edged Jian. This is usually given to Abyssariad citizens as a right for self-defense by the emperor's will."
	icon = 'modular/kaizoku/icons/weapons/32.dmi'
	icon_state = "shortjian"

/obj/item/weapon/sword/short/wakizashi
	name = "wakizashi"
	icon_state = "wakizashi1"
	icon = 'modular/kaizoku/icons/weapons/32.dmi'
	possible_item_intents = list(/datum/intent/sword/cut/sorii, /datum/intent/sword/thrust/sorii)
	swingsound = ZATANA_WOOSH

/obj/item/weapon/sword/short/wakizashi/Initialize()
	. = ..()
	var/design = rand(1, 3) //This system will be standardized to other weapons.
	switch(design)
		if(1)
			name = "wakizashi zatana"
			desc = "A shorter zatana design with circular handguard and heartfelt-influenced pommel. The curveness of the blade makes it better at cutting than thrusting."
		if(2)
			name = "traditional wakizashi"
			desc = "The traditional wakizashi used by abyssariads for centuries, with a lack of a pommel and a broader handguard for hand protection. The sorii of the blade improves the cutting power."
		if(3)
			name = "shirasaya wakizashi"
			desc = "The cheaper adaptation of the Wakizashi with an complete lack of handguard and no tsuka ito."
	icon_state = "wakizashi[design]"

/datum/intent/sword/cut/sorii //It is the reverse of the Shortsword.
	clickcd = 10
	penfactor = 30

/datum/intent/sword/thrust/sorii
	clickcd = 10
	damfactor = 0.85

/obj/item/weapon/sword/sabre/piandao
	name = "piandao"
	desc = "An curved abyssariad sword with a broad, single-edged blade that ends in a heavier curve for powerful and fast sweeping strikes."
	icon_state = "piandao"
	icon = 'modular/kaizoku/icons/weapons/32.dmi'

/obj/item/weapon/sword/sabre/piandao/dec
	name = "decorated piandao"
	desc = "The Abyssariad saber with the hilt covered in gold and letters reflecting the user's family lineage."
	icon_state = "piandaodec"
	max_integrity = 550
	sellprice = 140

/obj/item/weapon/sword/dragonslayer //It's a sword, yes. It will be used as a sword? My dudes we moving that one like warhammers at this point. So it's blunt at this point.
	name = "dragonslayer eclipse sword"
	desc = "Dragonslayers uses swords too big to be called a sword. Massive, thick, heavy and far too rough. Indeed, they use a heap of raw iron. These are not crafted for finesse, but for raw carnage in steel to obliterate Dragon's almost impenetrable skin."
	gripped_intents = list(/datum/intent/dragonslayer/smash, /datum/intent/polearm/chop) //This is practically a mace... that can chop off heads since it's sharp.
	icon_state = "eclipse_sword"
	resistance_flags = FIRE_PROOF
	smeltresult = /obj/item/ingot/steel
	max_integrity = 500
	force = 5 //You won't get ANYTHING by using in one hand. Trust me. EVEN IF YOU COULD.
	force_wielded = 40 // I thought Gundam would nerf it. He buffed it instead. What a World!
	slowdown = 1
	wbalance = -1
	sellprice = 300
	w_class = WEIGHT_CLASS_HUGE
	wbalance = -1 //haha... yeah.
	wdefense = 3
	minstr = 14
	associated_skill = /datum/skill/combat/axesmaces //if you tell me that fighting with this sword is LIKE a sword, I will kill you (ingame)-Mono
	icon = 'modular/kaizoku/icons/weapons/64.dmi'
	slot_flags = ITEM_SLOT_BACK
	parrysound = "largeblade"
	pickup_sound = "brandish_blade"
	bigboy = TRUE

/datum/intent/dragonslayer/smash
	name = "smash"
	icon_state = "insmash"
	attack_verb = list("clangs")
	animname = "smash"
	blade_class = BCLASS_CHOP
	hitsound = list('modular/kaizoku/sound/dragonslayer.ogg')
	penfactor = 30
	damfactor = 1.2
	chargetime = 5
	swingdelay = 5
	misscost = 35
	warnie = "mobwarning"



// =================================================================
// ========================		BOW & ARROW	========================

/obj/projectile/bullet/reusable/arrow/poison/fog
	name = "fog arrow"
	desc = "An arrow with it's tip drenched in a powerful sedative."
	icon = 'modular/kaizoku/icons/weapons/ammo.dmi'
	icon_state = "arrowfog_proj"
	ammo_type = /obj/item/ammo_casing/caseless/arrow

/obj/item/ammo_casing/caseless/arrow/poison/fog
	name = "fog arrow"
	desc = "An arrow with it's tip drenched in a powerful sedative."
	projectile_type = /obj/projectile/bullet/reusable/arrow/poison/fog
	icon = 'modular/kaizoku/icons/weapons/ammo.dmi'
	icon_state = "arrow_fog"

/obj/projectile/bullet/reusable/arrow/poison/fog/Initialize()
	. = ..()
	create_reagents(50, NO_REACT)

/obj/projectile/bullet/reusable/arrow/poison/fog/on_hit(atom/target, blocked = FALSE)
	if(iscarbon(target))
		var/mob/living/carbon/M = target
		if(blocked != 100) // not completely blocked
			if(M.can_inject(null, FALSE, def_zone, piercing)) // Pass the hit zone to see if it can inject by whether it hit the head or the body.
				..()
				reagents.reaction(M, INJECT)
				reagents.trans_to(M, reagents.total_volume)
				return BULLET_ACT_HIT
			else
				blocked = 100
				target.visible_message("<span class='danger'>\The [src] was deflected!</span>", \
									   "<span class='danger'>My armor protected me against \the [src]!</span>")

	..(target, blocked)
	DISABLE_BITFIELD(reagents.flags, NO_REACT)
	reagents.handle_reactions()
	return BULLET_ACT_HIT

/obj/projectile/bullet/reusable/arrow/poison/fog/Initialize()
	. = ..()
	reagents.add_reagent(/datum/reagent/fogblight, 5)

/obj/item/ammo_casing/caseless/bolt/poison/fog
	name = "fog bolt"
	desc = "A bolt dipped with a potent sedative."
	projectile_type = /obj/projectile/bullet/reusable/bolt/poison/fog
	possible_item_intents = list(/datum/intent/dagger/cut, /datum/intent/dagger/thrust)
	icon = 'modular/kaizoku/icons/weapons/ammo.dmi'
	icon_state = "bolt_fog"

/obj/projectile/bullet/reusable/bolt/poison/fog
	name = "fog bolt"
	desc = "A bolt dipped with a potent sedative."
	damage = 35
	damage_type = BRUTE
	icon = 'modular/kaizoku/icons/weapons/ammo.dmi'
	icon_state = "boltfogn_proj"
	ammo_type = /obj/item/ammo_casing/caseless/bolt

/obj/projectile/bullet/reusable/bolt/poison/fog/Initialize()
	. = ..()
	create_reagents(50, NO_REACT)

/obj/projectile/bullet/reusable/bolt/poison/fog/on_hit(atom/target, blocked = FALSE)
	if(iscarbon(target))
		var/mob/living/carbon/M = target
		if(blocked != 100) // not completely blocked
			if(M.can_inject(null, FALSE, def_zone, piercing)) // Pass the hit zone to see if it can inject by whether it hit the head or the body.
				..()
				reagents.reaction(M, INJECT)
				reagents.trans_to(M, reagents.total_volume)
				return BULLET_ACT_HIT
			else
				blocked = 100
				target.visible_message("<span class='danger'>\The [src] was deflected!</span>", \
									   "<span class='danger'>My armor protected me against \the [src]!</span>")

	..(target, blocked)
	DISABLE_BITFIELD(reagents.flags, NO_REACT)
	reagents.handle_reactions()
	return BULLET_ACT_HIT

/obj/projectile/bullet/reusable/bolt/poison/fog/Initialize()
	. = ..()
	reagents.add_reagent(/datum/reagent/fogblight, 5)




/obj/item/gun/ballistic/revolver/grenadelauncher/bow/hankyu
	name = "hankyu bow"
	desc = "A smaller version of the asymmetrical bow named Yumi. It must be shot overhead, and it is perfect for horseback use."
	icon = 'modular/kaizoku/icons/weapons/bows.dmi'
	icon_state = "hankyubow"
	item_state = "hankyubow"
	base_icon = "hankyubow"

/obj/item/gun/ballistic/revolver/grenadelauncher/bow/long/yumi
	name = "yumi bow"
	desc = "The asymmetrical and elegant piece of Kyudo warfare, hard-hitting and powerful, bringing fear to orcish hordes and demons on a whim."
	icon = 'modular/kaizoku/icons/weapons/bows.dmi'
	icon_state = "yumibow"
	item_state = "yumibow"
	base_icon = "yumibow"

/obj/item/weapon/sickle/kama	// iron sword worse integrity
	possible_item_intents = list(/datum/intent/axe/cut,/datum/intent/axe/chop,MACE_STRIKE,/datum/intent/flailthresh)
	name = "kama"
	desc = "Originally created for the harvesting of rice, the kama has also found popularity as a commoner's weapon thanks to its axe-like design. On occasion, one is combined with a length of chain to make a kusari gama."
	icon_state = "kama"
	icon = 'modular/kaizoku/icons/weapons/32.dmi'
	associated_skill = /datum/skill/combat/axesmaces
	force = DAMAGE_SWORD-1
	force_wielded = DAMAGE_SWORD_WIELD-1
	max_blade_int = 100
	max_integrity = INTEGRITY_STANDARD
	blade_dulling = DULLING_BASHCHOP
	wdefense = GOOD_PARRY

// =================================================================================
// ========================		FOGLANDER TRADESECTOR		========================

/obj/structure/kaizoku/crate
	name = "illegal immigrant crate"
	desc = "Something scratches from the inside. It is written on the wood, 'Deported Illegal Immigrant. Exiled for petty crimes.'"
	icon = 'modular/kaizoku/icons/mapset/tradesector32.dmi'
	icon_state = "animal_cage"
	anchored = FALSE
	var/mob_path = /mob/living/carbon/human/species/human/northern

/obj/structure/kaizoku/crate/attackby(obj/item/W, mob/living/user)
	if(istype(W, /obj/item/weapon/knife))
		to_chat(user, "<span class='danger'>You cut off the straps holding the wood planks together.</span>")
		playsound(src, 'sound/misc/slide_wood (1).ogg', 50, TRUE)
		new mob_path(get_turf(src)) // Spawn the mob
		qdel(src) // Remove the crate
	else
		to_chat(user, "<span class='warning'>You need a knife to cut this open.</span>")

/obj/structure/kaizoku/crate/fogbeast
	name = "fogbeast crate"
	desc = "Something neighs from the inside. The crate is unusually heavy."
	mob_path = /mob/living/simple_animal/hostile/retaliate/fogbeast/tame

/obj/item/gun/ballistic/revolver/grenadelauncher/handcannon
	name = "Lungsclap handcannon"
	desc = "Mass forged foglander handcannon, cheaper version of raided dwarven schematics. \
	Currently outdated by Barotrauma barkirons and Lungsnappers."
	icon = 'modular/kaizoku/icons/mapset/tradesector64.dmi'
	icon_state = "handcannon_ramrod"
	item_state = "handcannon_ramrod"
	bigboy = TRUE
	recoil = 10
	randomspread = 3
	spread = 4
	force = 12
//	experimental_inhand = FALSE	ROGTODO missing icons
//	experimental_onback = FALSE
	var/click_delay = 0.5
	var/obj/item/ramrod/rod
	cartridge_wording = "ball"
	var/rammed = FALSE
	var/powdered = FALSE
	var/inserted = FALSE
	var/fuse_lit = FALSE
	load_sound = 'sound/foley/nockarrow.ogg'
	fire_sound = 'sound/combat/Ranged/muskshoot.ogg'
	equip_sound = 'sound/foley/gun_equip.ogg'
	pickup_sound = 'sound/foley/gun_equip.ogg'
	drop_sound = 'sound/foley/gun_drop.ogg'
	dropshrink = 1
	associated_skill = /datum/skill/combat/firearms
	possible_item_intents = list(/datum/intent/mace/strike)
	sharpness = IS_BLUNT
	mag_type = /obj/item/ammo_box/magazine/internal/shot/musk
	bigboy = TRUE
	gripsprite = TRUE
	wlength = WLENGTH_LONG
	w_class = WEIGHT_CLASS_BULKY
	slot_flags = ITEM_SLOT_BACK
	sellprice = 150
	damfactor = 1.2 // Can't aim with it, and there is a randomized 'when to shoot'. It should pack a punch accordingly, since on my testings, it was very mid.

/obj/item/gun/ballistic/revolver/grenadelauncher/handcannon/Initialize()
	. = ..()
	var/obj/item/ramrod/rrod = new(src)
	rod = rrod
	update_icon()

/obj/item/gun/ballistic/revolver/grenadelauncher/handcannon/attackby(obj/item/I, mob/user, params)
	if(istype(I, /obj/item/ammo_casing/caseless/bullet))
		if(user.get_skill_level(/datum/skill/combat/firearms) <= 0)
			to_chat(user, "<span class='warning'>I don't know how to do this!</span>")
			return
		if(!powdered)
			to_chat(user, "<span class='warning'>Lacking in blastpowder, you think twice before putting the projectile inside. You don't need to waste your time pulling it out.</span>")
			return
		if(inserted)
			to_chat(user, "<span class='warning'>You attempt to put the projectile inside, but something hard already occupies the space.</span>")
			return
		var/loadtime = 5 - (user.get_skill_level(/datum/skill/combat/firearms) / 2)
		if(do_after(user, loadtime SECONDS, src))
			inserted = TRUE
			chambered = I
			I.forceMove(src)
			to_chat(user, "<span class='info'>You hear the ball of lead bouncing inside the barrel until it meets cushioning blastpowder.</span>")
			playsound(src.loc, 'sound/combat/Ranged/muskclick.ogg', 70)
		return

	else if(istype(I, /obj/item/reagent_containers/glass/bottle/aflask))
		if(user.get_skill_level(/datum/skill/combat/firearms) <= 0)
			to_chat(user, "<span class='warning'>I don't know how to do this!</span>")
			return
		if(powdered)
			to_chat(user, "<span class='warning'>If you put more gunpowder than it already has, you risk exploding the barrel.</span>")
			return
		if(I.reagents.get_reagent_amount(/datum/reagent/blastpowder) >= 5)
			var/loadtime = 5 - (user.get_skill_level(/datum/skill/combat/firearms) / 2)
			if(do_after(user, loadtime SECONDS, src))
				I.reagents.remove_reagent(/datum/reagent/blastpowder, 5)
				powdered = TRUE
				to_chat(user, "<span class='info'>You pour gunpowder into the handcannon.</span>")
				playsound(src.loc, 'sound/foley/gunpowder_fill.ogg', 70)
			return
		else
			to_chat(user, "<span class='warning'>Not enough blastpowder to charge it.</span>")
			return

	else if(istype(I, /obj/item/ramrod))
		var/ramtime = 5.5 - (user.get_skill_level(/datum/skill/combat/firearms) / 2)
		if(!powdered || !inserted)
			to_chat(user, "<span class='warning'>You must load both blastpowder and a ball before tamping!</span>")
			return
		if(rammed)
			to_chat(user, "<span class='warning'>Already tamped!</span>")
			return
		if(do_after(user, ramtime SECONDS, src))
			rammed = TRUE
			to_chat(user, "<span class='info'>You use [I] to tamp down the load.</span>")
			playsound(src.loc, 'sound/foley/nockarrow.ogg', 70)
			update_icon()
			return

	else if(istype(I, /obj/item/flashlight/flare/torch) || istype(I, /obj/item/flint))
		if(fuse_lit)
			to_chat(user, "<span class='warning'>The fuse is already lit and spitting sparks!</span>")
			return
		if(!chambered || !rammed || !powdered || !inserted)
			to_chat(user, "<span class='warning'>The contents are still loose.</span>")
			return
		fire(user)
		return
	..()

/obj/item/gun/ballistic/revolver/grenadelauncher/handcannon/MiddleClick(mob/user, params)
	. = ..()
	if(ishuman(user))
		var/mob/living/carbon/human/H = user
		if(rod)
			H.put_in_hands(rod)
			rod = null
			to_chat(user, "<span class='info'>You remove the ramrod from [src].</span>")
		else if(istype(H.get_active_held_item(), /obj/item/ramrod))
			var/obj/item/ramrod/rrod = H.get_active_held_item()
			rrod.forceMove(src)
			rod = rrod
			to_chat(user, "<span class='info'>You place the ramrod into [src].</span>")
		playsound(src.loc, 'sound/foley/struggle.ogg', 100)
	update_icon()

/obj/item/gun/ballistic/revolver/grenadelauncher/handcannon/proc/tamp(mob/user)
	if(!powdered || !inserted)
		to_chat(user, "<span class='warning'>You hilt the ramrod inside the handcannon. It is empty, having nothing to be tampered for.</span>")
		return
	if(rammed)
		to_chat(user, "<span class='warning'>You tamp the handcannon, but the blastpowder is already compacted and ready.</span>")
		return
	rammed = TRUE
	to_chat(user, "<span class='info'>You use the ramrod to tamp down the load.</span>")
	playsound(src.loc, 'sound/foley/nockarrow.ogg', 70)
	update_icon()

/obj/item/gun/ballistic/revolver/grenadelauncher/handcannon/update_icon()
	. = ..()
	if(rod)
		icon_state = "handcannon_ramrod"
	else
		icon_state = "handcannon_noram"
	update_icon_state()

/obj/item/gun/ballistic/revolver/grenadelauncher/handcannon/proc/fire(mob/living/user)
	if(!chambered || !rammed || !powdered || !inserted)
		to_chat(user, "<span class='warning'>The handcannon is not ready to fire.</span>")
		return
	if(fuse_lit)
		to_chat(user, "<span class='warning'>The fuse is already lit.</span>")
		return

	fuse_lit = TRUE
	to_chat(src.loc, "<span class='warning'>[user] positions the fuse near the ignition point.</span>")
	playsound(src.loc, 'sound/items/firelight.ogg', 100)

	var/random_delay = rand(20, 60)

	spawn(random_delay)
		if(QDELETED(src))
			return
		if(QDELETED(user))
			fuse_lit = FALSE
			update_icon()
			return

		to_chat(src.loc, "<span class='danger'>The fuse loudly sparks and the handcannon roars to life!</span>")
		playsound(src.loc, 'modular/kaizoku/sound/hwanchafire.ogg', 100)

		for(var/mob/living/carbon/H in hearers(5, user))
			shake_camera(H, 4, 3)
			H.adjust_eye_blur(3 SECONDS)
			H.playsound_local(get_turf(H), 'sound/foley/tinnitus.ogg', 70)
		step(user, get_dir(user, turn(user.dir, 180)))

		new /obj/effect/particle_effect/smoke(get_turf(user))
		var/turf/start = get_turf(user)
		var/dir = user.dir
		var/obj/projectile/bullet/reusable/bullet/random/shot = new /obj/projectile/bullet/reusable/bullet/random(start)
		shot.firer = user
		shot.fired_from = src
		if(user.client && user.client.chargedprog >= 100)
			shot.accuracy += 10
		if(user.STAPER > 8)
			shot.accuracy += (user.STAPER - 8) * 3
			shot.bonus_accuracy += (user.STAPER - 8)
			if(user.STAPER > 10)
				shot.damage *= (user.STAPER / 10)

		shot.damage *= damfactor
		shot.bonus_accuracy += (user.get_skill_level(/datum/skill/combat/firearms) * 2)

		shot.fire(dir2angle(dir))

		if(chambered)
			qdel(chambered)
		chambered = null
		rammed = FALSE
		powdered = FALSE
		inserted = FALSE
		fuse_lit = FALSE
		update_icon()

/obj/projectile/bullet/reusable/bullet/random/on_hit(atom/target, blocked = FALSE)
	if(isliving(target))
		var/mob/living/L = target
		var/list/limb_zones = list(
			BODY_ZONE_L_ARM,
			BODY_ZONE_R_ARM,
			BODY_ZONE_L_LEG,
			BODY_ZONE_R_LEG,
			BODY_ZONE_HEAD,
			BODY_ZONE_CHEST
		)
		var/zone = pick(limb_zones)
		L.apply_damage(damage, damage_type, zone, firer)
		if(zone == BODY_ZONE_HEAD || zone == BODY_ZONE_CHEST)
			L.Knockdown(3 SECONDS)

	return TRUE

/obj/item/gun/ballistic/revolver/grenadelauncher/chukonu
	name = "repeating crossbow"
	desc = "Crossbow of Foglandedr creation with a lever for repeating fire. It causes less damage, but its rapid-fire compensates for it."
	icon = 'modular/kaizoku/icons/weapons/bows.dmi'
	icon_state = "chukonu0"
	item_state = "chukonu"
	possible_item_intents = list(/datum/intent/shoot/crossbow, /datum/intent/arc/crossbow, INTENT_GENERIC)
	mag_type = /obj/item/ammo_box/magazine/internal/shot/xxbow
	slot_flags = ITEM_SLOT_BACK
	w_class = WEIGHT_CLASS_BULKY
	randomspread = 1
	spread = 0
	can_parry = TRUE
	force = 10
	var/cocked = FALSE
	cartridge_wording = "bolt"
	load_sound = 'sound/foley/nockarrow.ogg'
	fire_sound = 'sound/combat/Ranged/crossbow-small-shot-02.ogg'
	associated_skill = /datum/skill/combat/crossbows
	damfactor = 0.7 //less string power. May decrease it further or see a way to decrease crit chance.

/obj/item/gun/ballistic/revolver/grenadelauncher/chukonu/attackby(obj/item/A, mob/user, params)
	if(istype(A, /obj/item/ammo_box) || istype(A, /obj/item/ammo_casing))
		..()

/obj/item/gun/ballistic/revolver/grenadelauncher/chukonu/attack_self(mob/living/user)
	if(cocked && chambered)
		hipfire(user)
		return
	if(cocked)
		to_chat(user, "<span class='warning'>You carefully decock the crossbow.</span>")
		cocked = FALSE
	else
		if(user.usable_hands < 2)
			return FALSE
		if(user.get_inactive_held_item())
			to_chat(user, "<span class='warning'>You require two hands to stirrup the weapon.</span>")
			return FALSE
		to_chat(user, "<span class='info'>You stir the repeating crossbow...</span>")
		if(do_after(user, 20 - user.STASTR, target = user))
			playsound(user, 'sound/combat/Ranged/crossbow_medium_reload-01.ogg', 100, FALSE)
			cocked = TRUE
	update_icon()

/obj/item/gun/ballistic/revolver/grenadelauncher/chukonu/proc/hipfire(mob/living/user)
	if(!user || !cocked || !chambered)
		return
	var/obj/item/ammo_casing/CB = chambered
	var/obj/projectile/BB = CB.BB
	if(!BB)
		to_chat(user, "<span class='warning'>You have no more bolts to hipfire.</span>")
		return
	var/dir = user.dir
	var/turf/start_turf = get_turf(user)
	var/turf/target_turf = get_step(start_turf, dir)

	var/obj/projectile/fired_proj = new BB.type(target_turf)
	fired_proj.firer = user
	fired_proj.fired_from = src

	var/spread_angle = rand(-12, 12) //You are not aiming. So you will not have accuracy.
	fired_proj.fire(dir2angle(dir) + spread_angle) //You also won't be able to aim at a limb. It will always be the chest.

	to_chat(user, "<span class='notice'>You rapidly fire the repeating crossbow!</span>")

	playsound(user, fire_sound, 80, FALSE)
	cocked = FALSE
	chambered = null
	chamber_next_round()
	update_icon()

/obj/item/gun/ballistic/revolver/grenadelauncher/chukonu/process_fire(atom/target, mob/living/user, message = TRUE, params = null, zone_override = "", bonus_spread = 0)
	if(user.usable_hands < 2)
		return FALSE
	if(user.get_inactive_held_item())
		to_chat(user, "<span class='warning'>You require a free hand to pull the lever.</span>")
		return FALSE
	if(!cocked)
		to_chat(user, "<span class='warning'>You must stir the crossbow before firing!</span>")
		return
	if(!chambered)
		to_chat(user, "<span class='warning'>There's no bolt in the chamber!</span>")
		return

	var/obj/item/ammo_casing/CB = chambered
	var/obj/projectile/BB = CB.BB

	if(BB)
		if(user.client && user.client.chargedprog >= 100)
			BB.accuracy += 15
		if(user.STAPER > 8)
			BB.accuracy += (user.STAPER - 8) * 4
			BB.bonus_accuracy += (user.STAPER - 8)
			if(user.STAPER > 10)
				BB.damage *= (user.STAPER / 10)
		BB.damage *= damfactor
		BB.bonus_accuracy += (user.get_skill_level(/datum/skill/combat/crossbows) * 3)

	..()

	cocked = FALSE
	chambered = null //Annihillate what was just shot.
	chamber_next_round()
	update_icon()

/obj/item/gun/ballistic/revolver/grenadelauncher/chukonu/proc/chamber_next_round()
	if(chambered)
		qdel(chambered)
		chambered = null

	if(magazine) //We got one on the magazine? used it.
		var/obj/item/ammo_casing/CB = magazine.get_round()
		if(CB)
			if(chambered)
				qdel(chambered)
			chambered = CB

/obj/item/gun/ballistic/revolver/grenadelauncher/chukonu/proc/unload_bolts(mob/living/user)
	if(!magazine || !magazine.ammo_count())
		to_chat(user, "<span class='warning'>There are no bolts to remove!</span>")
		return
	var/num_unloaded = 0
	for(var/obj/item/ammo_casing/CB in get_ammo_list(FALSE, TRUE))
		CB.forceMove(drop_location())
		CB.bounce_away(FALSE, NONE)
		num_unloaded++
	to_chat(user, "<span class='notice'>You remove [num_unloaded] bolt\s from the crossbow.</span>")
	playsound(user, eject_sound, eject_sound_volume, eject_sound_vary)
	update_icon()

/obj/item/ammo_box/magazine/internal/shot/xxbow
	ammo_type = /obj/item/ammo_casing/caseless/bolt
	caliber = "regbolt"
	max_ammo = 8
	start_empty = TRUE

/obj/item/gun/ballistic/revolver/grenadelauncher/chukonu/update_icon()
	. = ..()
	if(cocked)
		icon_state = "chukonu1"
	else
		icon_state = "chukonu0"
	cut_overlays()
	if(chambered)
		var/obj/item/ammo_casing/CB = chambered
		var/bolt_overlay = get_bolt_overlay(CB)
		if(bolt_overlay)
			add_overlay(bolt_overlay)
	if(ismob(loc))
		var/mob/M = loc
		M.update_inv_hands()

/obj/item/gun/ballistic/revolver/grenadelauncher/chukonu/proc/get_bolt_overlay(obj/item/ammo_casing/CB)
	if(!CB)
		return null

	var/overlay_icon = "normal" //Overlay for normal bolts, or bolts someone else made which the creator forgot to make an overlay for the Repeating Crossbow

	switch(CB.type)
		if(/obj/item/ammo_casing/caseless/bolt/pyro)
			overlay_icon = "fire"
		if(/obj/item/ammo_casing/caseless/bolt/poison)
			overlay_icon = "poison"
		if(/obj/item/ammo_casing/caseless/bolt/poison/fog)
			overlay_icon = "fog"

	return mutable_appearance('modular/kaizoku/icons/weapons/bows.dmi', overlay_icon)

/obj/item/gun/ballistic/revolver/grenadelauncher/chukonu/examine(mob/user)
	. = ..()
	var/remaining_ammo = 0
	if(magazine)
		remaining_ammo = magazine.ammo_count()

	var/status = "The crossbow is "
	if(cocked)
		status += "cocked and ready to fire."
	else
		status += "not cocked."

	. += "<span class='info'>[status]</span>"
	. += "<span class='info'>It has [remaining_ammo] bolts remaining in the magazine.</span>"

/*
// ========== SASUMATA CODE ==========
This code is more of a proof of concept.
The mechanics surrounding it is, as far I can see,
requires a lot of polishment, but it is finished.
However, its functionality is intriguing.
It is playable unless testing says otherwise.
May or may not be removed.

The mancatcher is a weapon made to kill off these pesky speed metas.
And this is their purpose and reason. This should REMAIN at its core existence.

Only efficient if used by two sasumata users.
// ========== SASUMATA CODE ==========
*/

/obj/effect/sasumata_link
	name = "sasumata polearm"
	icon = 'modular/kaizoku/icons/weapons/64.dmi'
	icon_state = "sasumatanim"
	layer = EFFECTS_LAYER
	anchored = TRUE
	mouse_opacity = 0
	opacity = 0
	var/mob/living/carbon/human/user = null
	var/mob/living/carbon/human/target = null

/obj/effect/sasumata_link/New(loc, mob/living/carbon/human/user_mob, mob/living/carbon/human/target_mob)
	..()
	user = user_mob
	target = target_mob
	update_link()
	addtimer(CALLBACK(src, PROC_REF(update_link)), 1)

/obj/effect/sasumata_link/proc/update_link()
	if(!user || !target || isnull(user) || isnull(target) || isnull(user.loc) || isnull(target.loc))
		qdel(src)
		return
	var/turf/user_turf = get_turf(user)
	var/turf/target_turf = get_turf(target)
	if(user_turf && target_turf)
		icon_state = "sasumatanim"
		dir = get_dir(user_turf, target_turf)
		var/midx = (user_turf.x + target_turf.x) / 2
		var/midy = (user_turf.y + target_turf.y) / 2
		var/z = user_turf.z
		loc = locate(midx, midy, z)
	addtimer(CALLBACK(src, PROC_REF(update_link)), 2)

/obj/item/weapon/polearm/mancatcher
	name = "sasumata"
	desc = "A unique polearm featuring a spring-action pincer on the end. Made for capturing lowly criminals."
	icon_state = "sasumata"
	icon = 'modular/kaizoku/icons/weapons/64.dmi'
	force = 10
	force_wielded = 20
	wlength = WLENGTH_GREAT
	w_class = WEIGHT_CLASS_BULKY
	slot_flags = ITEM_SLOT_BACK
	blade_dulling = DULLING_BASHCHOP
	pixel_y = -16
	pixel_x = -16
	inhand_x_dimension = 64
	inhand_y_dimension = 64
	max_blade_int = 120
	max_integrity = 200
	wdefense = 5
	bigboy = TRUE
	associated_skill = /datum/skill/combat/polearms
	possible_item_intents = list(/datum/intent/polearm/bash, /datum/intent/polearm/cut)
	gripped_intents = list(/datum/intent/polearm/cut, /datum/intent/polearm/thrust/mancatcher_grab)
	var/last_grab_attempt = 0

/obj/item/weapon/polearm/mancatcher/attack(mob/living/carbon/human/target, mob/living/carbon/human/user)
	if(!user || !target || user == target || QDELETED(user) || QDELETED(target)) return ..()
	if(user.used_intent && istype(user.used_intent, /datum/intent/polearm/thrust/mancatcher_grab))
		if(world.time < last_grab_attempt + 15) //1,5 seconds. Hopefully.
			to_chat(user, "<span class='warning'>My stance is not steady yet.</span>")
			return
		last_grab_attempt = world.time
		if(target.IsUnconscious()) return
		if(!target.IsKnockdown() && user.is_sasumata_wielded(src))
			if(!(user in (target.sasumata_grappled_by || list())))
				src.play_sasumata_animation(user, target)
				start_grapple(user, target)
			else
				grapple_tick(user, target, attack_progress = TRUE)
			return
		else if(target.IsKnockdown() && user.is_sasumata_wielded(src))
			hold_knockdown(user, target)
			return
	return ..()

/obj/item/weapon/polearm/mancatcher/proc/play_sasumata_animation(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(!user || !target) return
	var/dir = get_dir(user, target)
	user.dir = dir
	if(istype(user, /mob/living/carbon/human) && istype(target, /mob/living/carbon/human))
		user.do_attack_animation(target, visual_effect_icon = "sasumatanim", used_item = src, used_intent = (user.used_intent ? user.used_intent : null))

/obj/item/weapon/polearm/mancatcher/proc/start_grapple(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(target.sasumata_grappled_by && length(target.sasumata_grappled_by) > 0 && !(user in target.sasumata_grappled_by))
		to_chat(user, "<span class='notice'>[target] is overwhelmed by multiple polearms!</span>")
		to_chat(target, "<span class='danger'>Multiple sasumatas seize me at once!</span>")
		target.Knockdown(40)
		return

	if(!target.sasumata_grappled_by)
		target.sasumata_grappled_by = list()
	if(!(user in target.sasumata_grappled_by))
		target.sasumata_grappled_by += user

	if(!target.sasumata_grapple_stacks)
		target.sasumata_grapple_stacks = list()
	target.sasumata_grapple_stacks[user] = list("state" = "offbalance", "progress" = 0, "tick_time" = world.time)

	user.StaminaLoss(10)
	target.OffBalance(80)
	to_chat(user, "<span class='notice'>I catch [target] with my sasumata!</span>")
	to_chat(target, "<span class='danger'>I struggle to keep my footing.</span>")
	RegisterSignal(user, COMSIG_MOVABLE_MOVED, /obj/item/weapon/polearm/mancatcher/proc/sasumata_moved)
	RegisterSignal(target, COMSIG_MOVABLE_MOVED, /obj/item/weapon/polearm/mancatcher/proc/sasumata_moved)
	user.sasumata_grapple_target = target
	target.sasumata_grapple_user = user

	grapple_tick(user, target, FALSE)

/obj/item/weapon/polearm/mancatcher/proc/sasumata_moved(mob/living/carbon/human/moved_mob)
	var/mob/living/carbon/human/user = moved_mob
	var/mob/living/carbon/human/target = user.sasumata_grapple_target
	if(!target)
		target = user.sasumata_grapple_user
		user = moved_mob
	if(!user || !target) return
	if(get_dist(user, target) > 2)
		end_grapple(user, target)

/obj/item/weapon/polearm/mancatcher/proc/grapple_tick(mob/living/carbon/human/user, mob/living/carbon/human/target, attack_progress = FALSE)
	if(QDELETED(user) || QDELETED(target) || !(user in target.sasumata_grappled_by)) return

	if(get_dist(user, target) > 2)
		to_chat(user, "<span class='warning'>My grip slips.</span>")
		to_chat(target, "<span class='danger'>I manage to tear myself away. It hurts.</span>")
		end_grapple(user, target)
		return

	if(!user.is_sasumata_wielded(src))
		to_chat(user, "<span class='danger'>I can't keep my grip without both hands.</span>")
		to_chat(target, "<span class='notice'>The mancatcher's wrist relents.</span>")
		end_grapple(user, target)
		return

	if(!(src in user.contents))
		to_chat(user, "<span class='danger'>My grasp falters.</span>")
		to_chat(target, "<span class='notice'>[user]'s weapon slips free.</span>")
		end_grapple(user, target)
		return

	if(user.IsUnconscious() || user.stat != CONSCIOUS)
		to_chat(user, "<span class='danger'>My hold vanishes, and now, [user] is escaping.</span>")
		to_chat(target, "<span class='notice'>I feel the grip loosen as [user] collapses, what a nimrod.</span>")
		end_grapple(user, target)
		return
	if(QDELETED(target) || target.stat == DEAD)
		end_grapple(user, target)
		return

	user.show_sasumata_link(target, src)

	if(!target.sasumata_grapple_stacks) target.sasumata_grapple_stacks = list()
	var/list/user_stack = target.sasumata_grapple_stacks[user]
	if(!user_stack)
		user_stack = list("state" = "offbalance", "progress" = 0, "tick_time" = world.time)
		target.sasumata_grapple_stacks[user] = user_stack

	var/user_stat = (user.STACON || 10)
	var/target_stat = (target.STACON || 10)
	var/stat_diff = user_stat - target_stat
	var/stage = user_stack["state"]

	var/required
	if(stat_diff >= 4)
		required = 1
	else if(stat_diff == 3)
		required = 2
	else if(stat_diff == 2)
		required = 3
	else if(stat_diff == 1)
		required = 4
	else if(stat_diff == 0)
		required = 5
	else
		required = 6 + abs(stat_diff)

	if(!attack_progress)
		user.StaminaLoss(3)
		target.StaminaLoss(3)
		addtimer(CALLBACK(src, PROC_REF(grapple_tick), user, target), 25)
		return

	if(attack_progress)
		if(stage == "offbalance")
			user_stack["progress"]++
			to_chat(user, "<span class='info'>Progress ([target]): [user_stack["progress"]]/[required] ([required - user_stack["progress"]] to immobilize)</span>")
			if(user_stack["progress"] == 1)
				to_chat(user, "<span class='warning'>[target] staggers in my hold!.</span>")
				to_chat(target, "<span class='danger'>I feel my footing fail as [user] forces me off balance!</span>")
			user.StaminaLoss(6)
			target.StaminaLoss(6)
			if(user_stat <= target_stat)
				to_chat(user, "<span class='warning'>[target]'s resilience strains my strength. I need help!</span>")
			if(user_stack["progress"] >= required)
				target.OffBalance(80)
				user_stack["state"] = "immobilize"
				user_stack["progress"] = 0
				to_chat(user, "<span class='warning'>[target] is losing the ability to move. Keep pressuring!</span>")
				to_chat(target, "<span class='danger'>My muscles lock up as the hold becomes impossible to escape.</span>")
		else if(stage == "immobilize")
			user_stack["progress"]++
			to_chat(user, "<span class='info'>Progress ([target]): [user_stack["progress"]]/[required] ([required - user_stack["progress"]] to knockdown)</span>")
			if(user_stack["progress"] == 1)
				to_chat(user, "<span class='warning'>[target] is nearly immobilized by the mancatcher.</span>")
				to_chat(target, "<span class='danger'>My joints lock painfully as I am pinned to the ground!</span>")
			user.StaminaLoss(6)
			target.StaminaLoss(6)
			if(user_stat <= target_stat)
				to_chat(user, "<span class='warning'>[target] is too strong. I need another mancatcher user!</span>")
			if(user_stack["progress"] >= required)
				target.Immobilize(40)
				user_stack["state"] = "knockdown"
				user_stack["progress"] = 0
				to_chat(user, "<span class='notice'>I force [target] to the ground, pinning them in place!</span>")
				to_chat(target, "<span class='danger'>My legs give out as I am pinned in place!</span>")
				src.warn_adjacent_guards(target)
		else if(stage == "knockdown")
			target.Knockdown(50)
			user.StaminaLoss(1)
			target.StaminaLoss(10)
			to_chat(user, "<span class='notice'>I manage to keep [target] pinned into the ground..</span>")
			to_chat(target, "<span class='danger'>I am helpless...</span>")
			user.show_sasumata_link(target, src)
			addtimer(CALLBACK(src, PROC_REF(hold_knockdown), user, target), 20)
			return

	if(length(target.sasumata_grappled_by) > 1)
		target.Knockdown(40)
		to_chat(user, "<span class='notice'>With help from another, I overwhelm [target] instantly!</span>")
		to_chat(target, "<span class='danger'>Multiple polearms bear down—I am instantly pinned!</span>")
		end_grapple(user, target)
		return

	if(user.StaminaLoss(0) || user.IsUnconscious())
		to_chat(user, "<span class='danger'>My strength fades and my grip fails.</span>")
		to_chat(target, "<span class='notice'>I feel the hold weaken as [user] tires out.</span>")
		end_grapple(user, target)
		return

	if((!target.IsOffBalanced() && !target.IsImmobilized() && !target.IsKnockdown()) && user_stack["state"] != "knockdown")
		to_chat(user, "<span class='notice'>[target] slips free from my hold.</span>")
		to_chat(target, "<span class='notice'>I finally break free from [user]'s hold!</span>")
		end_grapple(user, target)
		return

/obj/item/weapon/polearm/mancatcher/proc/hold_knockdown(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(QDELETED(user) || QDELETED(target) || !(user in target.sasumata_grappled_by)) return

	if(get_dist(user, target) > 2 || !user.is_sasumata_wielded(src) || !(src in user.contents) || user.IsUnconscious() || user.stat != CONSCIOUS)
		end_grapple(user, target)
		return

	target.Knockdown(40)
	user.StaminaLoss(1)
	target.StaminaLoss(10)
	user.show_sasumata_link(target, src)
	addtimer(CALLBACK(src, PROC_REF(hold_knockdown), user, target), 20)

/obj/item/weapon/polearm/mancatcher/proc/end_grapple(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(!target || !islist(target.sasumata_grappled_by)) return
	target.sasumata_grappled_by -= user
	if(target.sasumata_grapple_stacks)
		target.sasumata_grapple_stacks -= user
	if(!length(target.sasumata_grappled_by))
		target.sasumata_grappled_by = null
		target.sasumata_grapple_stacks = null
		to_chat(user, "<span class='notice'>[target] is no longer restrained by my polearm.</span>")
		to_chat(target, "<span class='notice'>I am finally free from [user]'s polearm.</span>")
	if(user && !QDELETED(user)) {
		user.remove_sasumata_link()
		user.sasumata_grapple_target = null
		UnregisterSignal(user, COMSIG_MOVABLE_MOVED, /obj/item/weapon/polearm/mancatcher/proc/sasumata_moved)
	}
	if(target && !QDELETED(target)) {
		target.remove_sasumata_link()
		target.sasumata_grapple_user = null
		UnregisterSignal(target, COMSIG_MOVABLE_MOVED, /obj/item/weapon/polearm/mancatcher/proc/sasumata_moved)
	}

/mob/living/carbon/human/proc/show_sasumata_link(mob/living/carbon/human/target, obj/item/weapon/polearm/mancatcher/weapon)
	if(!src || !target || isnull(src) || isnull(target))
		return
	if(!src.sasumata_link_effect)
		src.sasumata_link_effect = new /obj/effect/sasumata_link(get_turf(src), src, target)

/mob/living/carbon/human/proc/remove_sasumata_link()
	if(src.sasumata_link_effect)
		qdel(src.sasumata_link_effect)
		src.sasumata_link_effect = null

/mob/living/carbon/human
	var/obj/item/weapon/polearm/mancatcher/sasumata_grapple_item


/mob/living/carbon/human/var/obj/effect/sasumata_link/sasumata_link_effect
/mob/living/carbon/human/var/list/sasumata_grappled_by
/mob/living/carbon/human/var/list/sasumata_grapple_stacks
/mob/living/carbon/human/var/sasumata_grapple_target
/mob/living/carbon/human/var/sasumata_grapple_user

/mob/living/carbon/human/proc/StaminaLoss(amount)
	stamina += amount
	if(stamina >= maximum_stamina)
		stamina = maximum_stamina
		to_chat(src, "<span class='danger'>Your wrist is sprained.</span>")
		src.Paralyze(20)
		src.Stun(20)
	if(src.sasumata_grapple_item && src.sasumata_grapple_user)
		src.sasumata_grapple_item.end_grapple(src.sasumata_grapple_user, src)
	if(src.sasumata_grapple_item && src.sasumata_grapple_target)
		src.sasumata_grapple_item.end_grapple(src, src.sasumata_grapple_target)
		return TRUE

/mob/living/carbon/human/proc/is_sasumata_wielded(obj/item/weapon/polearm/mancatcher/W)
	return (W && HAS_TRAIT(W, TRAIT_WIELDED) && (get_active_held_item() == W || get_inactive_held_item() == W))

/obj/item/weapon/polearm/mancatcher/proc/warn_adjacent_guards(mob/living/carbon/human/target, mob/living/carbon/human/grappler)
	var/list/guards_warned = list()
	for(var/mob/living/carbon/human/G in orange(1, target))
		if(G == grappler) continue
		if(G.get_active_held_item() && istype(G.get_active_held_item(), /obj/item/weapon/polearm/mancatcher))
			to_chat(G, "<span class='warning'>Stand back just one step to hold the polearm, or [target] may push themselves free!</span>")
			guards_warned += G
	addtimer(CALLBACK(src, PROC_REF(check_adjacent_guards), target, grappler, guards_warned), 12)

/obj/item/weapon/polearm/mancatcher/proc/check_adjacent_guards(mob/living/carbon/human/target, mob/living/carbon/human/grappler, list/guards_warned)
	for(var/mob/living/carbon/human/G in guards_warned)
		if(G.loc && get_dist(G, target) == 1)
			to_chat(target, "<span class='success'>With leverage on my side, I push the mancatcher's head away!</span>")
			to_chat(grappler, "<span class='danger'>[target] overwhelms your wrist for being too close to them!</span>")
			for(var/mob/living/carbon/human/G2 in guards_warned)
				to_chat(G2, "<span class='danger'>[target] escapes!</span>")
			end_grapple(grappler, target)
			break

/datum/intent/polearm/thrust/mancatcher_grab
	name = "grab"
	blade_class = BCLASS_TWIST
	attack_verb = list("grabs", "captures", "catches")
	animname = "grab"
	icon_state = "ingrab"
	reach = 2
	chargetime = 1
	warnie = "mobwarning"
	hitsound = list('sound/foley/grab.ogg')
	penfactor = AP_POLEARM_THRUST
	swingdelay = 1
	misscost = 8

/obj/item/weapon/sword/rapier/starfang
	name = "sky lance"
	desc = "The blade of champions, the very sword whom named the Abyssariad Skylancers during blood apotheosis. \
	Every inch of the blade was developed for stabbing motions, onfoot or when flying."
	icon = 'modular/kaizoku/icons/weapons/64.dmi'
	icon_state = "skylance"

/obj/item/weapon/sword/rapier/ironestoc/tigerfang
	name = "tigerfang"
	desc = "A blade of foglander origin developed to be a cheaper alternative to the sky lance. \
	Commonly used by duelists, coincidently following the same spirit as the estoc fighting style."
	icon_state = "tigerfang"
	icon = 'modular/kaizoku/icons/weapons/32.dmi'
