/datum/job/kaizoku/spectacler //They are, essentially, an barbarian version of the Dungeoneer.
	title = "Custodian Spectacler"
	tutorial = "Proper nations of arts allows it to bridge everything, even the warfare and justice system. \
	The clans wants justice without causing outcries as the civilians calls for blood, and so, their spectacler follows, \
	serving the crown's law with bloodsport punishment as the last god a criminal mind will ever meet. \
	A judge and spectacle at once, Entertain the public, execute the unredeemable and safekeep the caged. You are the star of this show."
	department_flag = FACTION_MILITARY
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_CITIZEN_PLAYERS
	allowed_ages = list(AGE_ADULT, AGE_MIDDLEAGED, AGE_IMMORTAL)
	job_flags = (JOB_ANNOUNCE_ARRIVAL | JOB_SHOW_IN_CREDITS | JOB_EQUIP_RANK | JOB_NEW_PLAYER_JOINABLE)
	display_order = KZ_SPECTACLER
	faction = FACTION_TOWN
	total_positions = 1
	spawn_positions = 1
	// min_pq = 0 ; Stonekeep Todo - Vanderlin removed PQ, reimplement it later.

	allowed_sexes = list(MALE, FEMALE)
	//Every single race can be a Gladiator. If you can fight GOOD, you can join, you little social pariah.

	outfit = /datum/outfit/job/kaizoku/spectacler
	give_bank_account = 50

	cmode_music = 'sound/music/cmode/nobility/CombatDungeoneer.ogg'

/datum/outfit/kaizoku/spectacler/pre_equip(mob/living/carbon/human/H)
	//head = /obj/item/clothing/head/helmet/nasal
	mask = /obj/item/clothing/face/skullmask
	cloak = /obj/item/clothing/cloak/raincloak/furcloak/colored/brown
	wrists = /obj/item/clothing/wrists/bracers/leather
	//pants = /obj/item/clothing/pants/trou/leather/advanced
	//shoes = /obj/item/clothing/shoes/boots/leather/advanced
	//gloves = /obj/item/clothing/gloves/leather/advanced
	backr = /obj/item/storage/backpack/satchel
	beltr = /obj/item/weapon/whip/antique
	belt = /obj/item/storage/belt/leather
	//neck =	/obj/item/clothing/neck/chaincoif/iron
	//armor = /obj/item/clothing/armor/leather/advanced
	backpack_contents = list(
		/obj/item/weapon/knife/hunting = 1,
		/obj/item/flashlight/flare/torch/lantern = 1,
		/obj/item/storage/belt/pouch/coins/poor = 1,
		/obj/item/rope/chain = 1,
		/obj/item/weapon/scabbard/knife = 1,
	)
	H.add_spell(/datum/action/cooldown/spell/undirected/barbrage)
	H.adjust_skillrank(/datum/skill/combat/axesmaces, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/wrestling, 4, TRUE)
	H.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/swords, 3, TRUE)
	H.adjust_skillrank(/datum/skill/craft/tanning, 1, TRUE)
	H.adjust_skillrank(/datum/skill/misc/swimming, 4, TRUE)
	H.adjust_skillrank(/datum/skill/misc/climbing, 4, TRUE)
	H.adjust_skillrank(/datum/skill/misc/athletics, 4, TRUE)
	H.adjust_skillrank(/datum/skill/craft/cooking, 1, TRUE)
	H.adjust_skillrank(/datum/skill/labor/butchering, 1, TRUE)
	H.adjust_skillrank(/datum/skill/misc/medicine, 1, TRUE)
	H.adjust_skillrank(/datum/skill/craft/tanning, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/sneaking, 3, TRUE)
	H.change_stat(STATKEY_STR, 3)
	H.change_stat(STATKEY_PER, -1)
	H.change_stat(STATKEY_END, 1)
	H.change_stat(STATKEY_CON, 2)
	H.change_stat(STATKEY_INT, -1)
	H.change_stat(STATKEY_SPD, 1)

	ADD_TRAIT(H, TRAIT_STEELHEARTED, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_STRONGBITE, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_CRITICAL_RESISTANCE, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_NOPAINSTUN, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_INHUMENCAMP, TRAIT_GENERIC)

/datum/outfit/kaizoku/spectacler/post_equip(mob/living/carbon/human/H)
	var/static/list/selectableweapon = list( \
		"MY BARE HANDS!!!" = /obj/item/weapon/knife/dagger/steel, \
		"Great Axe" = /obj/item/weapon/greataxe/steel, \
		"Mace" = /obj/item/weapon/mace/goden/steel, \
		"Sword" = /obj/item/weapon/sword/arming \
		)
	var/choice = H.select_equippable(H, selectableweapon, message = "Choose Your Specialisation", title = "BERSERKER")
	if(!choice)
		return
	switch(choice)
		if("MY BARE HANDS!!!")
			H.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
			H.adjust_skillrank(/datum/skill/combat/knives, 4, TRUE)
		if("Great Axe")
			H.clamped_adjust_skillrank(/datum/skill/combat/axesmaces, 4, 4, TRUE)
		if("Mace")
			H.clamped_adjust_skillrank(/datum/skill/combat/axesmaces, 4, 4, TRUE)
		if("Sword")
			H.clamped_adjust_skillrank(/datum/skill/combat/swords, 4, 4, TRUE)
	// wretch_select_bounty(H)

/datum/outfit/job/kaizoku/spectacler/pre_equip(mob/living/carbon/human/H)
	..()
	H.adjust_skillrank(/datum/skill/combat/axesmaces, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/swords, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/bows, 2, TRUE)  //funger reference
	H.adjust_skillrank(/datum/skill/craft/crafting, 1, TRUE)
	H.adjust_skillrank(/datum/skill/craft/tanning, 1, TRUE)
	H.adjust_skillrank(/datum/skill/misc/swimming, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/riding, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/sewing, 2, TRUE)
	H.adjust_skillrank(/datum/skill/craft/cooking, 1, TRUE)
	H.adjust_skillrank(/datum/skill/misc/athletics, 4, TRUE)
	H.add_spell(new /datum/action/cooldown/spell/undirected/barbrage)

	shoes = /obj/item/clothing/shoes/simpleshoes
	wrists = /obj/item/clothing/wrists/bracers/kaizoku/scissorblade
	cloak = /obj/item/clothing/cloak/raincloak/furcloak/colored/brown
	belt = /obj/item/storage/belt/leather
	beltr = /obj/item/weapon/whip/antique
	beltl = /obj/item/storage/keyring/dungeoneer
	neck = /obj/item/clothing/neck/gorget/lazerrain
	// head = /obj/item/clothing/head/helmet/heavy/gladiator/murmillo // Fix this
	backr = /obj/item/weapon/shield/tower

	H.change_stat("strength", 3)
	H.change_stat("endurance", 2)
	H.change_stat("constitution", 2)
	H.change_stat("intelligence", -2)

	ADD_TRAIT(H, TRAIT_STEELHEARTED, TRAIT_GENERIC)
	// ADD_TRAIT(H, TRAIT_NOSTINK, TRAIT_GENERIC) // I got the feeling this god removed.
	ADD_TRAIT(H, TRAIT_CRITICAL_RESISTANCE, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_NOPAINSTUN, TRAIT_GENERIC)
	H.verbs |= /mob/living/carbon/human/proc/torture_victim

/obj/item/clothing/wrists/bracers/kaizoku/scissorblade
	name = "arbellas limb"
	desc = "The powerful limb of an arbellas attached to a semicircular blade usually used by cobblers, but the watchers always require a show, so a beating it is."
	icon_state = "arbellas"
	item_state = "arbellas"
	icon = 'modular/kaizoku/icons/clothingicon/wrists.dmi'
	mob_overlay_icon = 'modular/kaizoku/icons/clothing/wrists.dmi'
	sleeved = 'modular/kaizoku/icons/clothing/wrists.dmi'
	body_parts_covered = ARMS|HANDS
	slot_flags = ITEM_SLOT_WRISTS
	force = 15
	throwforce = 10
	resistance_flags = FLAMMABLE
	fiber_salvage = FALSE
	anvilrepair = /datum/skill/craft/engineering
	smeltresult = /obj/item/ingot/steel

	var/obj/item/weapon/clobber/blade_presence
	var/switchhand = "right" // "right" or "left"

/obj/item/clothing/wrists/bracers/kaizoku/scissorblade/Initialize()
	. = ..()
	ADD_TRAIT(src, TRAIT_NODROP, CURSED_ITEM_TRAIT)

/obj/item/clothing/wrists/bracers/kaizoku/scissorblade/attack_hand_secondary(mob/user)
	if(blade_presence)
		if(blade_presence.loc == user)
			blade_presence.forceMove(src)
			to_chat(user, "<span class='notice'>With a push of the thumb, the blade retracts inwards.</span>")
			blade_presence = null
		else
			to_chat(user, "<span class='warning'>You've lost your blade, and now, your limb is useless until repaired.</span>")
			qdel(blade_presence)
			blade_presence = null
		return

	var/obj/item/weapon/clobber/blade = new /obj/item/weapon/clobber(get_turf(user))
	blade.wrist_ref = src

	var/obj/item/target_hand = (switchhand == "right") ? user.get_active_held_item() : user.get_inactive_held_item()
	if(!target_hand)
		if(switchhand == "right")
			user.put_in_r_hand(blade)
		else
			user.put_in_l_hand(blade)
		to_chat(user, "<span class='combat'>You release the clobber's blade.</span>")
		blade_presence = blade
	else
		to_chat(user, "<span class='warning'>The [switchhand] hand is busy with something else.</span>")
		qdel(blade)

/obj/item/clothing/wrists/bracers/kaizoku/scissorblade/MiddleClick(mob/living/carbon/human/user)
	switchhand = (switchhand == "right") ? "left" : "right"
	to_chat(user, "<span class='notice'>You clamp the limb to your [switchhand] arm.</span>")

/obj/item/clothing/wrists/bracers/kaizoku/scissorblade/dropped(mob/living/user)
	. = ..()
	if(blade_presence && istype(blade_presence.loc, /mob))
		var/mob/living/M = blade_presence.loc
		if(blade_presence in M.contents)
			M.dropItemToGround(blade_presence)
	qdel(blade_presence)
	blade_presence = null

/obj/item/weapon/clobber
	name = "clobber tool"
	desc = "A retractable clobber tool. This one will surely punch deep holes into your victims."
	icon = 'modular/kaizoku/icons/weapons/32.dmi'
	icon_state = "kaiken"
	item_state = "kaiken"
	force = 20
	throwforce = 10
	w_class = WEIGHT_CLASS_SMALL
	flags_1 = CONDUCT_1
	associated_skill = /datum/skill/combat/knives
	hitsound = 'sound/combat/hits/bladed/genchop (2).ogg'
	var/obj/item/clothing/wrists/bracers/kaizoku/scissorblade/wrist_ref

/obj/item/weapon/clobber/Initialize()
	. = ..()
	ADD_TRAIT(src, TRAIT_NODROP, CURSED_ITEM_TRAIT)

/obj/item/weapon/clobber/dropped(mob/living/user)
	. = ..()
	if(wrist_ref && (!istype(wrist_ref.loc, /mob) || wrist_ref.loc != user))
		qdel(src)
