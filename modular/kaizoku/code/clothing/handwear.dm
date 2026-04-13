/obj/item/clothing/wrists/bracers/kote
	name = "armored sleeve"
	desc = "Armored sleeves and gloves part of the zamurai sangu set."
	icon_state = "kote"
	item_state = "kote"
	icon = 'modular/kaizoku/icons/clothingicon/wrists.dmi'
	mob_overlay_icon = 'modular/kaizoku/icons/clothing/wrists.dmi'
	sleeved = 'modular/kaizoku/icons/clothing/wrists.dmi'
	body_parts_covered = ARMS|HANDS
	color = null
	detail_tag = "_det"

/obj/item/clothing/wrists/bracers/kote/cursed/Initialize()
	. = ..()
	name = "soulbinded kote"
	ADD_TRAIT(src, TRAIT_NODROP, CURSED_ITEM_TRAIT)

/obj/item/clothing/wrists/bracers/mountainstar
	name = "weeping god-patterned bracers"
	desc = "Y-shaped steel plates marks this bracer everywhere it is looked upon, most proper for the Weeping God."
	icon = 'modular/kaizoku/icons/clothingicon/wrists.dmi'
	mob_overlay_icon ='modular/kaizoku/icons/clothing/wrists.dmi'
	sleeved = 'modular/kaizoku/icons/clothing/wrists.dmi'
	icon_state = "mountainstar"
	item_state = "mountainstar"

/obj/item/clothing/wrists/kaizoku/dragonwrap
	name = "dragon wrappings"
	desc = "fireproof cloth wrappings to cover the arms and hands. It is completely made of asbestos and resin keeping its toxicity in place. For now."
	slot_flags = ITEM_SLOT_WRISTS
	icon_state = "dragonwrap"
	item_state = "dragonwrap"
	icon = 'modular/kaizoku/icons/clothingicon/wrists.dmi'
	mob_overlay_icon ='modular/kaizoku/icons/clothing/wrists.dmi'
	sleeved = 'modular/kaizoku/icons/clothing/wrists.dmi'
	armor = list("blunt" = 5, "slash" = 5, "stab" = 5, "piercing" = 5, "fire" = 100, "acid" = 50)
	resistance_flags = FIRE_PROOF | ACID_PROOF

/obj/item/clothing/wrists/bracers/leather/khudagach
	name = "abyssal leather bracers"
	desc = "Oil-boiled leather bracers made to protect the forearms and wrists of abyssariad archers, light cavalry and farming folk."
	icon_state = "khudagach"
	item_state = "khudagach"
	icon = 'modular/kaizoku/icons/clothingicon/wrists.dmi'
	mob_overlay_icon ='modular/kaizoku/icons/clothing/wrists.dmi'
	sleeved = 'modular/kaizoku/icons/clothing/wrists.dmi'

/obj/item/clothing/wrists/bracers/bonebracer
	name = "bone bracers"
	desc = "the bracers made of bone, usually created and used by tribalistic Undines."
	armor = ARMOR_PADDED
	icon = 'modular/kaizoku/icons/clothingicon/wrists.dmi'
	mob_overlay_icon ='modular/kaizoku/icons/clothing/wrists.dmi'
	sleeved = 'modular/kaizoku/icons/clothing/wrists.dmi'
	icon_state = "bonebracers"
	item_state = "bonebracers"
	prevent_crits = list(BCLASS_CUT, BCLASS_CHOP, BCLASS_TWIST)
	resistance_flags = null
	blocksound = SOFTHIT
	smeltresult = /obj/item/fertilizer/ash
	blade_dulling = DULLING_BASHCHOP
	break_sound = 'modular/kaizoku/sound/foley/cloth_rip.ogg'
	drop_sound = 'modular/kaizoku/sound/foley/dropsound/cloth_drop.ogg'
	anvilrepair = null
	sewrepair = FALSE

/obj/item/clothing/wrists/shrinekeeper
	slot_flags = ITEM_SLOT_WRISTS
	name = "purificators"
	desc = "Blessed gauntlets for those who believes they can punch spirits."
	icon = 'modular/kaizoku/icons/clothingicon/wrists.dmi'
	mob_overlay_icon ='modular/kaizoku/icons/clothing/wrists.dmi'
	sleeved = 'modular/kaizoku/icons/clothing/wrists.dmi'
	icon_state = "shrinekeeper_gauntlet"
	sleevetype = "shirt"
	resistance_flags = FLAMMABLE
	sewrepair = TRUE
	anvilrepair = null
	alternate_worn_layer = BELT_LAYER //Keep them exposed above armor and tabards.

//area for zamurai for the sake of easeness

/obj/item/clothing/armor/gambeson/light/hitatare/zamurai
	detail_tag = "_det"
	detail_color = CLOTHING_WHITE
	r_sleeve_status = SLEEVE_NORMAL
	l_sleeve_status = SLEEVE_NORMAL
	var/picked = FALSE
	colorgrenz = TRUE

/obj/item/clothing/armor/gambeson/light/hitatare/zamurai/proc/get_player_input()
	if(!ishuman(loc))
		return

	var/list/colors = list(
		"PURPLE"="#865c9c",
		"RED"="#933030",
		"BROWN"="#685542",
		"GREEN"="#79763f",
		"BLUE"="#395480",
		"YELLOW"="#b5b004",
		"TEAL"="#249589",
		"STEEL"="#ffffff",
		"ORANGE"="#b86f0c",
		"Royal Majenta"="#962e5c")

	var/mob/living/carbon/human/L = loc

	var/det_choice = input(L, "Color of your lacquered plates", "Choose a light tone") as anything in colors
	var/base_choice = input(L, "Color of the padding", "Choose a dark tone") as anything in colors

	var/det_color = colors[det_choice]
	var/base_color = colors[base_choice]

	picked = TRUE
	detail_color = det_color
	update_icon()

	for(var/obj/item/clothing/V in L.get_equipped_items(FALSE))
		if(V.colorgrenz)
			V.detail_color = det_color
			if(istype(V, /obj/item/clothing/armor/medium/surcoat/heartfelt/abyssariad/zamurai))
				var/obj/item/clothing/armor/medium/surcoat/heartfelt/abyssariad/zamurai/S = V
				S.base_color = base_color
			else if(istype(V, /obj/item/clothing/wrists/bracers/kote/zamurai))
				var/obj/item/clothing/wrists/bracers/kote/zamurai/K = V
				K.base_color = base_color
			V.update_icon()

	L.regenerate_icons()

/obj/item/clothing/armor/gambeson/light/hitatare/zamurai/Initialize()
	. = ..()
	if(!picked)
		var/mob/living/carbon/human/L = loc
		if(!istype(L))
			return
		if(!L.client)
			return
		INVOKE_ASYNC(src, PROC_REF(get_player_input))

/obj/item/clothing/armor/medium/surcoat/heartfelt/abyssariad/zamurai
	detail_tag = "_det"
	colorgrenz = TRUE
	var/base_color = null

/obj/item/clothing/armor/medium/surcoat/heartfelt/abyssariad/zamurai/update_icon()
	. = ..()
	cut_overlays()
	if(base_color)
		color = base_color
	else
		color = initial(color)
	if(get_detail_tag())
		var/mutable_appearance/pic = mutable_appearance(icon(icon, "[icon_state][detail_tag]"))
		pic.appearance_flags = RESET_COLOR
		if(get_detail_color())
			pic.color = get_detail_color()
		add_overlay(pic)

/obj/item/clothing/wrists/bracers/kote/zamurai
	detail_tag = "_det"
	colorgrenz = TRUE
	var/base_color = null

/obj/item/clothing/wrists/bracers/kote/zamurai/update_icon()
	. = ..()
	cut_overlays()
	if(base_color)
		color = base_color
	else
		color = initial(color)
	if(get_detail_tag())
		var/mutable_appearance/pic = mutable_appearance(icon(icon, "[icon_state][detail_tag]"))
		pic.appearance_flags = RESET_COLOR
		if(get_detail_color())
			pic.color = get_detail_color()
		add_overlay(pic)

/obj/item/clothing/wrists/bracers/kote/zamurai/update_overlays(mob/living/carbon/human/H)
	. = ..()

	if(base_color)
		for(var/image/I in overlays)
			if(I.icon == mob_overlay_icon && I.icon_state == icon_state)
				I.color = base_color
