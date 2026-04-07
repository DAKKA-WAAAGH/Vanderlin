/datum/job/kaizoku/stormcaller
	title = "Stormcaller"
	department_flag = FACTION_ABYSSANCTUM
	total_positions = 1
	spawn_positions = 1
	job_flags = (JOB_ANNOUNCE_ARRIVAL | JOB_SHOW_IN_CREDITS | JOB_EQUIP_RANK | JOB_NEW_PLAYER_JOINABLE)
	display_order = KZ_ONMIOJI
	faction = FACTION_TOWN
	total_positions = 1
	spawn_positions = 1
	// min_pq = 0 ; Stonekeep Todo - Vanderlin removed PQ, reimplement it later.
	bypass_lastclass = TRUE
	selection_color = "#c2a45d"
	allowed_patrons = list(/datum/patron/abyssanctum/curator)

	//allowed_races = RACES_FIRSTCLASS_PLAYERS
	allowed_races = RACES_SECONDCLASS_PLAYERS

	allowed_ages = list(AGE_MIDDLEAGED, AGE_OLD, AGE_IMMORTAL)
	allowed_sexes = list(MALE, FEMALE)
	tutorial = "The Chosen of the pressuring depth, senior spiritcallers of Abyssor, sage of the oceans. \
	You are a celestial magician skilled in divination  and manifesting the powers of the sea as intermediaries \
	between the Abyssariads and the Abyssal realm. You've been empowered in the same way Abyssor was empowered, \
	in the depths of the Weeping God's pressuring tears, avoiding the connection to Zizo as many fleeting sorcerers do."
	outfit = /datum/outfit/job/kaizoku/stormcaller
	give_bank_account = 120
	cmode_music = 'sound/music/cmode/nobility/CombatCourtMagician.ogg'
	magic_user = TRUE

	spells = list(
		/datum/action/cooldown/spell/aoe/knock,
		/datum/action/cooldown/spell/undirected/jaunt/ethereal_jaunt,
		/datum/action/cooldown/spell/undirected/touch/prestidigitation,
	)
	spell_points = 17
	attunements_max = 6
	attunements_min = 4


/datum/outfit/job/kaizoku/stormcaller/pre_equip(mob/living/carbon/human/H)
	..()
	backr = /obj/item/storage/backpack/satchel
	backl = /obj/item/weapon/polearm/woodstaff/quarterstaff/bostaff
	cloak = /obj/item/clothing/cloak/black_cloak
	armor = /obj/item/clothing/shirt/robe/wizard/guardian/curator
	head = /obj/item/clothing/head/wizhat/onmyoji/curator
	pants = /obj/item/clothing/pants/trou/tobi/curator
	ring = /obj/item/clothing/ring/gold
	belt = /obj/item/storage/belt/leather/plaquesilver
	beltr = /obj/item/storage/keyring/mage
	shoes = /obj/item/clothing/shoes/shortboots/cloudhead
	backpack_contents = list(/obj/item/reagent_containers/glass/bottle/killersice = 1,  /obj/item/chalk = 1)
	if(H.mind)
		if(!(H.patron == /datum/patron/abyssanctum/curator))	//Magicians must follow Noc or Zizo to have access to magic.
			H.set_patron(/datum/patron/abyssanctum/curator, TRUE)

		H.adjust_skillrank(/datum/skill/misc/reading, 6, TRUE)
		H.adjust_skillrank(/datum/skill/magic/arcane, pick(6,5), TRUE)
		H.adjust_skillrank(/datum/skill/misc/riding, 2, TRUE)
		H.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
		H.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
		H.adjust_skillrank(/datum/skill/combat/polearms, 3, TRUE)
		H.adjust_skillrank(/datum/skill/craft/alchemy, 5, TRUE)
		if(H.age == AGE_OLD)
			var/prev_real_name = H.real_name
			var/prev_name = H.name
			var/honorary = "Onmyokai"
			H.real_name = "[honorary] [prev_real_name]"
			H.name = "[honorary] [prev_name]"
			armor = /obj/item/clothing/shirt/robe/colored/courtmage
			head = /obj/item/clothing/head/wizhat
			H.change_stat("speed", -1)
			H.change_stat("intelligence", 1)
			if(H.dna.species.id == "human")
				belt = /obj/item/storage/belt/leather/plaquegold
		ADD_TRAIT(H, TRAIT_SEEPRICES, TRAIT_GENERIC)
		ADD_TRAIT(H, TRAIT_LEGENDARY_ALCHEMIST, TRAIT_GENERIC)
		ADD_TRAIT(H, TRAIT_NOBLE, TRAIT_GENERIC)
		H.virginity = TRUE
		H.change_stat("strength", -2)
		H.change_stat("intelligence", 4)
		H.change_stat("constitution", -2)
		H.change_stat("speed", -2)



//............... Unique Court Mage Stuff ...........................
/obj/item/clothing/head/wizhat/onmyoji/curator
/obj/item/clothing/head/wizhat/onmyoji/curator/equipped(mob/living/user, slot)
	. = ..()
	if(user.mind && user.mind.assigned_role == "Stormcaller")
		if(slot == ITEM_SLOT_HEAD && istype(user))
			user.apply_status_effect(/datum/status_effect/buff/thinking_cap)
		else
			user.remove_status_effect(/datum/status_effect/buff/thinking_cap)
	else return

/obj/item/clothing/head/wizhat/onmyoji/curator/dropped(mob/living/user, slot)
	. = ..()
	user.remove_status_effect(/datum/status_effect/buff/thinking_cap)

/datum/status_effect/buff/thinking_cap
	id = "thinkingcap"
	alert_type = /atom/movable/screen/alert/status_effect/buff/thinking_cap
	effectedstats = list("intelligence" = 1)
	duration = 180 MINUTES

/datum/status_effect/buff/thinking_cap/on_apply()
	. = ..()
	if(iscarbon(owner))
		var/mob/living/carbon/C = owner
		C.remove_stress(/datum/stress_event/wheresmyhat)

/datum/status_effect/buff/thinking_cap/on_remove()
	. = ..()
	if(iscarbon(owner))
		var/mob/living/carbon/C = owner
		C.add_stress(/datum/stress_event/wheresmyhat)

/datum/stress_event/wheresmyhat
	timer = 10 MINUTES
	stress_change = 1
	desc = "<span class='red'>I miss my hat....</span>"

/atom/movable/screen/alert/status_effect/buff/thinking_cap
	name = "My mind is clear"
	desc = "<span class='nicegreen'>My hat deflects mind-clouding rays of Zizo...</span>\n"
	icon = 'icons/mob/actions/roguespells.dmi'
	icon_state = ""
