/* Comments: Has the soap that gives unique mood boost & removes tired when used by Massager on person in a bath tile
It´s pretty good. Also extra good mood boost for sex, but still a bit barebones. Expand a little cooking/serving? */


/datum/job/kaizoku/massager
	title = "Massager"
	department_flag = FACTION_MALEFACTORS
	total_positions = 3
	spawn_positions = 3

	allowed_races = RACES_PLAYER_ALL
	allowed_sexes = list(FEMALE) //put males too
	allowed_ages = list(AGE_ADULT, AGE_MIDDLEAGED, AGE_ANCIENT)
	tutorial = "You've been chosen for your beauty as you rotted in poverty, either a shamed \
	desecrant or a refugee with no work skills. Now, you lull people with seduction to be your \
	clients, and receive relaxing massages, baths... with a happy ending, just don't tell the last \
	option to the men of law. You may or may not have diseases, so you can adquire an certificate. \
	from the tower's serpentines."
	display_order = BATHMAID_ORDER

	outfit = /datum/outfit/job/kaizoku/massager	//Default outfit.
	// advclass_cat_rolls = list(CTAG_NITEMAIDEN= 20) // Not yet.
	give_bank_account = 25
	// min_pq = 0 ; Stonekeep Todo - Vanderlin removed PQ, reimplement it later.
	faction = FACTION_TOWN
	department_flag = FACTION_MALEFACTORS
	cmode_music = 'modular/kaizoku/sound/combat/combat_stormwarrior.ogg'


//Universal stuff for all nitemaidens
/datum/outfit/job/kaizoku/massager
	belt = /obj/item/storage/belt/leather/rope
	beltr = /obj/item/key/bathhouse
	beltl = /obj/item/storage/belt/pouch/nitemaiden
	shoes = /obj/item/clothing/shoes/shortboots

/datum/outfit/job/kaizoku/massager/pre_equip(mob/living/carbon/human/H)
	..()
	ADD_TRAIT(H, TRAIT_GOODLOVER, TRAIT_GENERIC)
	if(H.mind)
		H.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE) // To wrestle people out of the baths
		H.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
		H.adjust_skillrank(/datum/skill/misc/sneaking, 2, TRUE)
		H.adjust_skillrank(/datum/skill/misc/stealing, pick(2,3,4), TRUE)
		H.adjust_skillrank(/datum/skill/misc/riding, 3, TRUE)//we know why
		H.adjust_skillrank(/datum/skill/misc/music, 2, TRUE)
		H.adjust_skillrank(/datum/skill/craft/crafting, 1, TRUE)
		H.adjust_skillrank(/datum/skill/misc/athletics, 1, TRUE)
		H.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
		H.adjust_skillrank(/datum/skill/craft/cooking, 1, TRUE)

	H.change_stat(STATKEY_STR, -1)
	H.change_stat(STATKEY_LCK, 1)
	H.change_stat(STATKEY_END, 1)
	H.change_stat(STATKEY_PER, 1)
	H.change_stat(STATKEY_SPD, 1)

/obj/item/soap/bath
	icon = 'modular/stonekeep/icons/misc.dmi'
	icon_state = "soap_herbal"

/*
// Herbal soap
/obj/item/soap/bath
	name = "herbal soap"
	desc = "A soap made from various herbs."
	icon = 'modular/stonekeep/icons/misc.dmi'
	icon_state = "soap_herbal"
	w_class = WEIGHT_CLASS_TINY
	item_flags = NOBLUDGEON
	throwforce = 0
	throw_speed = 1
	throw_range = 7
	var/cleanspeed = 35 //slower than mop
	uses = 10

/obj/item/soap/bath/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/slippery, 80)

/obj/item/soap/bath/examine(mob/user)
	. = ..()
	var/max_uses = initial(uses)
	var/msg = "It looks like it was freshly made."
	if(uses != max_uses)
		var/percentage_left = uses / max_uses
		switch(percentage_left)
			if(0 to 0.2)
				msg = "There's just a tiny bit left of what it used to be, you're not sure it'll last much longer."
			if(0.21 to 0.4)
				msg = "It's dissolved quite a bit, but there's still some life to it."
			if(0.41 to 0.6)
				msg = "It's past its prime, but it's definitely still good."
			if(0.61 to 0.85)
				msg = "It's started to get a little smaller than it used to be, but it'll definitely still last for a while."
			else
				msg = "It's seen some light use, but it's still pretty fresh."
	. += "<span class='notice'>[msg]</span>"

/obj/item/soap/bath/attack(mob/living/carbon/human/target, mob/living/carbon/user)
	user.changeNext_move(CLICK_CD_MELEE)
	var/turf/bathspot = get_turf(target)				// Checks for being in a bath and being undressed
	if(!istype(bathspot, /turf/open/water/bath))
		if((!locate(/obj/structure/table/wood/bathtub) in target.loc))
			to_chat(user, span_warning("They must be in the bath water!"))
			return
	if(!ishuman(target))
		to_chat(user, span_warning("They don't want to be soaped..."))
		return

	if(istype(target.wear_armor, /obj/item/clothing))
		to_chat(user, span_warning("Can't get a proper bath with armor on."))
		return

	if(istype(target.wear_shirt, /obj/item/clothing))
		to_chat(user, span_warning("Can't get a proper bath with clothing on."))
		return

	if(istype(target.cloak, /obj/item/clothing))
		to_chat(user, span_warning("Can't get a proper bath with clothing on."))
		return

	if(istype(target.wear_pants, /obj/item/clothing))
		to_chat(user, span_warning("Can't get a proper bath with pants on."))
		return

	if(istype(target.shoes, /obj/item/clothing))
		to_chat(user, span_warning("Can't get a proper bath with shoes on."))
		return

	user.visible_message("<span class='info'>[user] begins scrubbing [target] with the [src].</span>")	// Applies the special bonus only if Nitemaiden using the soap
	playsound(src.loc, pick('sound/items/soaping.ogg'), 100)
	if(do_after(user, 5 SECONDS, target = target))
		if((user.job == "Nitemaiden"))
			user.visible_message(span_info("[user] expertly scrubs and soothes [target] with the [src]."))
			to_chat(target, span_warning("I feel so relaxed and clean!"))
			target.apply_status_effect(/datum/status_effect/buff/clean_plus)
	//		target.tiredness = 0
			target.remove_status_effect(/datum/status_effect/debuff/sleepytime)
		else
			user.visible_message(span_info("[user] tries their best to scrub [target] with the [src]."))
			to_chat(target, span_warning("Its worth a little soap in my eyes to get clean."))
		wash_atom(target, CLEAN_STRONG)
		uses -= 1
		if(uses == 0)
			qdel(src)
*/

/obj/item/storage/belt/pouch/nitemaiden
	populate_contents = list(
		/obj/item/paper/certificate/maybe,
		/obj/item/natural/cloth,
	)
