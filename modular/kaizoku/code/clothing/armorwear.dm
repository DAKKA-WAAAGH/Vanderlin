/obj/item/clothing/armor/medium/surcoat/heartfelt
	name = "heartfelt kikko gusoku"
	desc = "A lordly protection in Heartfelt colors. Masterfully crafted coat of hexagon plates, for important nobility."
	icon = 'modular/kaizoku/icons/clothingicon/armor.dmi'
	mob_overlay_icon = 'modular/kaizoku/icons/clothing/armor.dmi'
	sleeved = 'modular/kaizoku/icons/helpers/sleeves_armor.dmi'
	icon_state = "heartfelt_kikko"
	item_state = "heartfelt_kikko"
	allowed_sex = list(MALE,FEMALE)
	sellprice = VALUE_SNOWFLAKE_STEEL+BONUS_VALUE_SMALL

	body_parts_covered = COVERAGE_FULL

/obj/item/clothing/armor/medium/surcoat/heartfelt/Initialize()
	. = ..()
	AddComponent(/datum/component/item_equipped_movement_rustle, custom_sounds = SFX_OUTLANDER_PLATE_COAT_STEP)

//................ Armored surcoat (Heartfelt Hand) ............... //
/obj/item/clothing/armor/medium/surcoat/heartfelt/hand
	name = "turtleshell royal coat"
	desc = "A suit of defensive plates donned by heartfeltian aristocracy. Crafted from rare silks sourced from Fog Islands."
	icon_state = "heartfelt_kikkocoat"
	item_state = "heartfelt_kikkocoat"

/obj/item/clothing/armor/medium/surcoat/heartfelt/hand/female
	name = "turtleshell royal dress"
	icon_state = "heartfelt_kikkodress"
	item_state = "heartfelt_kikkodress"

/obj/item/clothing/armor/leather/vest/muneate //exists only for the drip.
	name = "leather chestguard"
	desc = "The 'Muneate', designed for casual archers. Its effectiveness strictly limited to reflecting the slap of a bowstring, proper for horse archery."
	icon_state = "muneate"
	item_state = "muneate"
	icon = 'modular/kaizoku/icons/clothingicon/armor.dmi'
	mob_overlay_icon = 'modular/kaizoku/icons/clothing/armor.dmi'
	sleeved = 'modular/kaizoku/icons/helpers/sleeves_armor.dmi'

/obj/item/clothing/armor/leather/vest/muneate/random/Initialize()
	color = pick(GLOB.peasant_dyes)
	..()

/obj/item/clothing/armor/leather/vest/muneate/kappa
	color = CLOTHING_FOREST_GREEN

/obj/item/clothing/armor/plate/nanbando
	name = "abyssal half-plate"
	desc = "Refined abyssal steel cuirass that features additional shoulder protection. Prized and used by high-ranking zamurais."
	icon = 'modular/kaizoku/icons/clothingicon/armor.dmi'
	mob_overlay_icon = 'modular/kaizoku/icons/clothing/armor.dmi'
	sleeved = 'modular/kaizoku/icons/helpers/sleeves_armor.dmi'
	icon_state = "nanbando"
	item_state = "nanbando"

/obj/item/clothing/armor/plate/nanbando/Initialize()
	. = ..()
	AddComponent(/datum/component/item_equipped_movement_rustle, custom_sounds = SFX_PLATE_STEP)

/obj/item/clothing/armor/cuirass/nanbando
	name = "abyssal cuirass"
	desc = "Proper refined protection for the chest made of true, reliable spring steel."
	icon = 'modular/kaizoku/icons/clothingicon/armor.dmi'
	mob_overlay_icon = 'modular/kaizoku/icons/clothing/armor.dmi'
	sleeved = 'modular/kaizoku/icons/helpers/sleeves_armor.dmi'
	icon_state = "nanbandoc"
	item_state = "nanbandoc"

/obj/item/clothing/armor/cuirass/nanbando/Initialize()
	. = ..()
	AddComponent(/datum/component/item_equipped_movement_rustle, custom_sounds = SFX_PLATE_STEP)

/obj/item/clothing/armor/plate/full/nanbando
	name = "abyssal full plate"
	desc = "A complete set of abyssariad steel armor, refined and with additional auxiliary parts for protection."
	icon = 'modular/kaizoku/icons/clothingicon/armor.dmi'
	mob_overlay_icon = 'modular/kaizoku/icons/clothing/armor.dmi'
	sleeved = 'modular/kaizoku/icons/helpers/sleeves_armor.dmi'
	icon_state = "nanbandofull"

/obj/item/clothing/armor/plate/full/nanbando/Initialize()
	. = ..()
	AddComponent(/datum/component/item_equipped_movement_rustle, custom_sounds = SFX_LAMELLAR_STEP)

/obj/item/clothing/armor/plate/full/nanbando/cursed/Initialize()
	. = ..()
	name = "soulbinded nanban-do-gusoku"
	ADD_TRAIT(src, TRAIT_NODROP, CURSED_ITEM_TRAIT)

/obj/item/clothing/armor/plate/full/nanbando/cursed/dropped(mob/living/carbon/human/user)
	. = ..()
	if(QDELETED(src))
		return
	qdel(src)

/obj/item/clothing/armor/chainmail/tatami
	name = "steel foldable armor"
	desc = "The 'Kozane-Tatami Do', a mass-produced, foldable armor made of steel lamellae integrated into chainmail, a staple in fog island's military."
	icon = 'modular/kaizoku/icons/clothingicon/armor.dmi'
	mob_overlay_icon = 'modular/kaizoku/icons/clothing/armor.dmi'
	sleeved = 'modular/kaizoku/icons/helpers/sleeves_armor.dmi'
	icon_state = "laminartatami"

/obj/item/clothing/armor/chainmail/tatami/Initialize()
	. = ..()
	AddComponent(/datum/component/item_equipped_movement_rustle, custom_sounds = SFX_CHAIN_STEP)

/obj/item/clothing/armor/chainmail/iron/tatami
	name = "iron foldable armor"
	desc = "The 'Tatami karuta-gane'. A foldable lightweight armor with lacquered iron squares or tiles on padded chains."
	icon = 'modular/kaizoku/icons/clothingicon/armor.dmi'
	mob_overlay_icon = 'modular/kaizoku/icons/clothing/armor.dmi'
	sleeved = 'modular/kaizoku/icons/helpers/sleeves_armor.dmi'
	icon_state = "tatami"

/obj/item/clothing/armor/chainmail/iron/tatami/Initialize()
	. = ..()
	AddComponent(/datum/component/item_equipped_movement_rustle, custom_sounds = SFX_CHAIN_STEP)

/obj/item/clothing/armor/chainmail/hauberk/kusari
	name = "chainmail robe"
	desc = "The 'Kusari katabira'. It is made of riveted steel rings with slim plates at the elbows. It extends down to cover the legs and arms."
	icon = 'modular/kaizoku/icons/clothingicon/armor.dmi'
	mob_overlay_icon = 'modular/kaizoku/icons/clothing/armor.dmi'
	sleeved = 'modular/kaizoku/icons/helpers/sleeves_armor.dmi'
	icon_state = "kusari"
	item_state = "kusari"

/obj/item/clothing/armor/chainmail/hauberk/kusari/Initialize()
	. = ..()
	AddComponent(/datum/component/item_equipped_movement_rustle, custom_sounds = SFX_CHAIN_STEP)

/obj/item/clothing/armor/plate/mirror/iron
	name = "iron mirror armor"
	desc = "Usually used with a Kusari Katabira, this armor's frame is defined by polished iron plates with a central metal disk."
	icon = 'modular/kaizoku/icons/clothingicon/armor.dmi'
	mob_overlay_icon = 'modular/kaizoku/icons/clothing/armor.dmi'
	sleeved = 'modular/kaizoku/icons/helpers/sleeves_armor.dmi'
	icon_state = "imirrorarmor"
	max_integrity = INTEGRITY_STANDARD
	armor = ARMOR_SCALE
	smeltresult = /obj/item/ingot/iron
	armor_class = AC_MEDIUM
	sellprice = 20

/obj/item/clothing/armor/plate/mirror/iron/Initialize()
	. = ..()
	AddComponent(/datum/component/item_equipped_movement_rustle, custom_sounds = SFX_PLATE_STEP)

/obj/item/clothing/armor/plate/mirror
	name = "steel mirror armor"
	icon_state = "mirrorarmor"
	desc = "Usually used with a Kusari Katabira, this armor's frame is defined by polished steel plates with a central metal disk."
	icon = 'modular/kaizoku/icons/clothingicon/armor.dmi'
	mob_overlay_icon = 'modular/kaizoku/icons/clothing/armor.dmi'
	sleeved = 'modular/kaizoku/icons/helpers/sleeves_armor.dmi'
	icon_state = "mirrorarmor"

/obj/item/clothing/armor/plate/mirror/Initialize()
	. = ..()
	AddComponent(/datum/component/item_equipped_movement_rustle, custom_sounds = SFX_PLATE_STEP)

/obj/item/clothing/armor/brigandine/oyoroi
	name = "great lamellar armor"
	desc = "The 'O-yoroi', a heavy-duty lamellar armor favored by high-ranking zamurais on horseback, with pauldrons functioning similarly to shields in battle."
	desc = "Usually used with a Kusari Katabira, this armor's frame is defined by polished steel plates with a central metal disk."
	icon = 'modular/kaizoku/icons/clothingicon/armor.dmi'
	mob_overlay_icon = 'modular/kaizoku/icons/clothing/armor.dmi'
	sleeved = 'modular/kaizoku/icons/helpers/sleeves_armor.dmi'
	icon_state = "halfoyoroi"

/obj/item/clothing/armor/brigandine/oyoroi/Initialize()
	. = ..()
	AddComponent(/datum/component/item_equipped_movement_rustle, custom_sounds = SFX_LAMELLAR_STEP)

/obj/item/clothing/armor/brigandine/oyoroi/update_icon()
	. = ..()
	cut_overlays()
	if(get_detail_tag())
		var/mutable_appearance/pic = mutable_appearance(icon(icon, "[icon_state][detail_tag]"))
		pic.appearance_flags = RESET_COLOR
		if(get_detail_color())
			pic.color = get_detail_color()
		add_overlay(pic)

/obj/item/clothing/suit/armor/brigandine/oyoroi/cursed
	name = "soulbinded o-yoroi gusoku"

/obj/item/clothing/armor/brigandine/oyoroi/cursed/Initialize()
	. = ..()
	ADD_TRAIT(src, TRAIT_NODROP, CURSED_ITEM_TRAIT)

/obj/item/clothing/armor/brigandine/oyoroi/cursed/dropped(mob/living/carbon/human/user)
	. = ..()
	if(QDELETED(src))
		return
	qdel(src)

/obj/item/clothing/armor/brigandine/oyoroi/royal/Initialize()
	. = ..()
	detail_tag = "_met"
	update_icon()

/obj/item/clothing/armor/brigandine/oyoroi/captain/lordcolor(primary, secondary)
	detail_tag = "_met"
	detail_color = primary
	update_icon()
	if(ismob(loc))
		var/mob/L = loc
		L.update_inv_armor()

/obj/item/clothing/armor/brigandine/oyoroi/oyoroigusoku
	name = "complete great lamellar armor"
	desc = "The 'O-yoroi gusoku', a heavy-duty lamellar armor favored by high-ranking zamurais on horseback, with pauldrons functioning similarly to shields in battle."
	icon_state = "oyoroi"
	body_parts_covered = CHEST|GROIN|VITALS|LEGS|ARMS

/obj/item/clothing/armor/brigandine/oyoroi/oyoroigusoku/Initialize()
	. = ..()
	detail_tag = "_met"
	detail_color = GLOB.lordprimary
	update_icon()

/obj/item/clothing/armor/brigandine/oyoroi/oyoroigusoku/cursed/Initialize()
	. = ..()
	name = "soulbinded o-yoroi gusoku"
	ADD_TRAIT(src, TRAIT_NODROP, CURSED_ITEM_TRAIT)

/obj/item/clothing/armor/brigandine/oyoroi/oyoroigusoku/cursed/dropped(mob/living/carbon/human/user)
	. = ..()
	if(QDELETED(src))
		return
	qdel(src)

/obj/item/clothing/armor/brigandine/oyoroi/oyoroigusoku/Initialize()
	. = ..()
	AddComponent(/datum/component/item_equipped_movement_rustle, custom_sounds = SFX_LAMELLAR_STEP)

/obj/item/clothing/armor/cuirass/iron/sanmaido
	name = "three-plates cuirass"
	desc = "The 'San mai-do', a cost-effective cuirass composed of three main iron plates riveted together. It is favored by poor foot soldiers and warrior monks."
	icon = 'modular/kaizoku/icons/clothingicon/armor.dmi'
	mob_overlay_icon = 'modular/kaizoku/icons/clothing/armor.dmi'
	sleeved = 'modular/kaizoku/icons/helpers/sleeves_armor.dmi'
	icon_state = "sanmaido"

/obj/item/clothing/armor/cuirass/iron/sanmaido/Initialize()
	. = ..()
	AddComponent(/datum/component/item_equipped_movement_rustle, custom_sounds = SFX_PLATE_STEP)

/obj/item/clothing/armor/leather/abyssal
	name = "leather cuirass"
	desc = "Also know as 'Tiejia', this is an leather armor featuring rectangular leather lamellae laced together to cover vital organs."
	icon = 'modular/kaizoku/icons/clothingicon/armor.dmi'
	mob_overlay_icon = 'modular/kaizoku/icons/clothing/armor.dmi'
	sleeved = 'modular/kaizoku/icons/helpers/sleeves_armor.dmi'
	icon_state = "tiejia"

/obj/item/clothing/armor/leather/hide/dustwalker
	name = "rawhide dynasty armor" //Han dynasty leather armor
	desc = "The 'Khatag Teghelgah'. It is designed to be used by abyssariad light cavalry and horse archers on the heart of Fog Island."
	icon = 'modular/kaizoku/icons/clothingicon/armor.dmi'
	mob_overlay_icon = 'modular/kaizoku/icons/clothing/armor.dmi'
	sleeved = 'modular/kaizoku/icons/helpers/sleeves_armor.dmi'
	icon_state = "arisan_khuyag"

/obj/item/clothing/armor/leather/splint/kikko //This one is more realistic than Studded Leather armor. A reminder that Studded leather armor is a misinterpretation of a Brigandine.
	name = "turtleshell jacket"
	desc = "The 'Kikko-Jaketto', essentially a leather jacket with metal hexagon plates in a pattern similar to a turtle's shell."
	icon = 'modular/kaizoku/icons/clothingicon/armor.dmi'
	mob_overlay_icon = 'modular/kaizoku/icons/clothing/armor.dmi'
	sleeved = 'modular/kaizoku/icons/helpers/sleeves_armor.dmi'
	icon_state = "kikko"
	adjustable = CAN_CADJUST

/obj/item/clothing/armor/leather/splint/kikko/random/Initialize()
	. = ..()
	color = pick("#a32121", "#8747b1", "#3d3a36", "#414143", "#685542", "#428138", "#264d26", "#537bc6", "#b5b004", "#249589", "#ffffff", "#bd6606", "#962e5c")

/obj/item/clothing/armor/leather/splint/kikko/military/Initialize()
	. = ..()
	color = pick("#534b40", "#685542", "#264d26")

/obj/item/clothing/armor/leather/splint/kikko/AdjustClothes(mob/user)
	if(loc == user)
		if(adjustable == CAN_CADJUST)
			adjustable = CADJUSTED
			if(toggle_icon_state)
				icon_state = "[initial(icon_state)]_open"
			flags_inv = null
			body_parts_covered = CHEST
			if(ishuman(user))
				var/mob/living/carbon/H = user
				H.update_inv_armor()
		else if(adjustable == CADJUSTED)
			ResetAdjust(user)
			if(user)
				if(ishuman(user))
					var/mob/living/carbon/H = user
					H.update_inv_armor()

/obj/item/clothing/armor/leather/hide/shozoku
	name = "stealth attire"
	desc = "The secondary attire for shinobis and kunoichis to blend into the night, the use is not suitable for daylight."
	icon = 'modular/kaizoku/icons/clothingicon/armor.dmi'
	mob_overlay_icon = 'modular/kaizoku/icons/clothing/armor.dmi'
	sleeved = 'modular/kaizoku/icons/helpers/sleeves_armor.dmi'
	icon_state = "shinobi"
	item_state = "shinobi"
	blocksound = SOFTHIT

/obj/item/clothing/armor/chainmail/rattan //New armor; Iron-to-steel tier.
	slot_flags = ITEM_SLOT_ARMOR
	name = "rattan armor"
	desc = "A flexible and durable full-body coat crafted from oil-boiled rattan and layered iron wires. By being easily repairable, it is used by LinYou Wokous."
	icon = 'modular/kaizoku/icons/clothingicon/armor.dmi'
	mob_overlay_icon = 'modular/kaizoku/icons/clothing/armor.dmi'
	sleeved = 'modular/kaizoku/icons/helpers/sleeves_armor.dmi'
	icon_state = "rattan"
	item_state = "rattan"
	sellprice = VALUE_IRON_ARMOR+10

	armor = ARMOR_MAILLE_IRON
	max_integrity = INTEGRITY_STANDARD
	prevent_crits = ALL_EXCEPT_BLUNT_AND_STAB
	sewrepair = TRUE //this armor's utility.

//New Rare Heartfelt equipment
/obj/item/clothing/armor/medium/surcoat/heartfelt/abyssariad
	name = "abyssariad kikko gusoku"
	desc = "Reforged in a more recent standard to better equip low-ranking zamurai after the Rebellion of Three Waves, this armor replaces the expensive O-Yoroi lamellar."
	body_parts_covered = CHEST|GROIN|VITALS|LEGS //does not protect the arms. Countering the Brigandine that protects the arms, but not legs.
	icon_state = "kikkoabyssal"
	item_state = "kikkoabyssal"
	sellprice = 65 //not unique.

/obj/item/clothing/armor/medium/surcoat/heartfelt/abyssariad/Initialize()
	. = ..()
	AddComponent(/datum/component/item_equipped_movement_rustle, custom_sounds = SFX_PLATE_STEP)

/obj/item/clothing/armor/leather/vest/kaizoku
	name = "kaizoku's waitao"
	icon_state = "waitao_coat"
	color = null
	desc = "Foglander silken coats of coastal culture, proudly used by the sons of Kaizoku, or just artistic folk."
	icon = 'modular/kaizoku/icons/clothingicon/armor.dmi'
	mob_overlay_icon = 'modular/kaizoku/icons/clothing/armor.dmi'
	sleeved = 'modular/kaizoku/icons/helpers/sleeves_armor.dmi'
	body_parts_covered = CHEST|VITALS|LEGS
	sellprice = 45

/obj/item/clothing/armor/brigandine/godwenkai
	slot_flags = ITEM_SLOT_ARMOR
	name = "Y-wenkai armor" //This is the Shan Wen Kia armor, but the downwards 'Y' is upwards now, so I can't name it <mountain patterned armor>
	desc = "The ancient Y-wenkai, a heavy armor made with overlapping arrangement of armor plates, assembled with the symbol of the Weeping God. This is used by Abyssariad Champions who still lingers on this world, honoring the Weeper who fed Abyssor."
	icon_state = "godwenkai"
	icon = 'modular/kaizoku/icons/clothingicon/armor.dmi'
	mob_overlay_icon = 'modular/kaizoku/icons/clothing/armor.dmi'
	sleeved = 'modular/kaizoku/icons/helpers/sleeves_armor.dmi'

/obj/item/clothing/armor/brigandine/godwenkai/update_icon()
	. = ..()
	return

/obj/item/clothing/armor/brigandine/godwenkai/Initialize()
	. = ..()
	AddComponent(/datum/component/item_equipped_movement_rustle, custom_sounds = SFX_LAMELLAR_STEP)

/obj/item/clothing/armor/gambeson/ruankai
	slot_flags = ITEM_SLOT_ARMOR|ITEM_SLOT_SHIRT
	name = "padded ruankai"
	desc = "Made of layered cloth quilted together, it became a cushioning armor sufficient to withstand a horse's kick."
	icon_state = "ruankai"
	icon = 'modular/kaizoku/icons/clothingicon/armor.dmi'
	mob_overlay_icon = 'modular/kaizoku/icons/clothing/armor.dmi'
	sleeved = 'modular/kaizoku/icons/helpers/sleeves_armor.dmi'

/obj/item/clothing/armor/gambeson/light/hitatare
	name = "yoroi hitatare"
	desc = "A traditional Abyssariad padded robe with wide sleeves, made to be worn beneath armor. It is comfortable and thick, but not very protective compared to a ruankai, but can be used all the time without raising suspicion."
	icon_state = "yoroihitatare"
	icon = 'modular/kaizoku/icons/clothingicon/armor.dmi'
	mob_overlay_icon = 'modular/kaizoku/icons/clothing/armor.dmi'
	sleeved = 'modular/kaizoku/icons/helpers/sleeves_armor.dmi'

// Randomized color Hitatare
/obj/item/clothing/armor/gambeson/light/hitatare/random/Initialize()
	color = pick(GLOB.peasant_dyes)
	..()

// Randomized color Hitatare
/obj/item/clothing/armor/gambeson/light/hitatare/rich/Initialize()
	color = pick_assoc(GLOB.noble_dyes)
	..()

// Ronin Hitatare
/obj/item/clothing/armor/gambeson/light/hitatare/ronin
	color = CLOTHING_SOOT_BLACK

// Eidolon Hitatare
/obj/item/clothing/armor/gambeson/light/hitatare/eidolon
	color = CLOTHING_EIDOLON

/obj/item/clothing/armor/gambeson/heavy/deelcoat
	name = "reinforced warcoat"
	desc = "A loose-fitting Abyssariad warcoat, typically made of horse leather and traditionally used by the Dustwalkers."
	icon_state = "deel"
	icon = 'modular/kaizoku/icons/clothingicon/armor.dmi'
	mob_overlay_icon = 'modular/kaizoku/icons/clothing/armor.dmi'
	sleeved = 'modular/kaizoku/icons/helpers/sleeves_armor.dmi'

/obj/item/clothing/armor/leather/jacket/firecoat
	name = "stormforger coat"
	desc = "Asbestos-layered, loose-fitting coat used by stormforgers to protect against the dangerous ambers of lava casting."
	icon_state = "stormforger"
	icon = 'modular/kaizoku/icons/clothingicon/armor.dmi'
	mob_overlay_icon = 'modular/kaizoku/icons/clothing/armor.dmi'
	sleeved = 'modular/kaizoku/icons/helpers/sleeves_armor.dmi'
	resistance_flags = FIRE_PROOF

/obj/item/clothing/armor/leather/splint/ninjakappa //same as studded leather armor
	name = "tribalistic bronze cuirass"
	desc = "layered armor of bronze plates sewn into oil-boiled leather. Used by Undines in shinobi operations."
	icon_state = "ninjakappa"
	item_state = "ninjakappa"
	icon = 'modular/kaizoku/icons/clothingicon/armor.dmi'
	mob_overlay_icon = 'modular/kaizoku/icons/clothing/armor.dmi'
	sleeved = 'modular/kaizoku/icons/helpers/sleeves_armor.dmi'

/obj/item/clothing/armor/leather/splint/ninjakappa/Initialize()
	. = ..()
	AddComponent(/datum/component/item_equipped_movement_rustle, custom_sounds = SFX_PLATE_STEP)

/obj/item/clothing/armor/rare/myrmidon
	name = "myrmidon mingguang kai" // that's "明光铠", not the genshin character.
	desc = "Ocean-blessed overlapping steel plates joined by butchered demonhide threads and orichalcum infusion, \
	long purified with abyssor sigils and symbols of the Weeper. Each steel layer is engraved: \
	\"By the Heavenly Emperor's command. For the abyss against all odds.\""
	icon_state = "myrmidon"
	item_state = "myrmidon"
	allowed_race = list("abyssariad")
	sleevetype = null
	max_integrity = INTEGRITY_STRONGEST+100 //Chest + Pants - Everything is on a single armor. Breaks easier since it gets battered everywhere, so it requires more endurance.
	icon = 'modular/kaizoku/icons/clothingicon/armor.dmi'
	mob_overlay_icon = 'modular/kaizoku/icons/clothing/armor.dmi'
	sleeved = 'modular/kaizoku/icons/helpers/sleeves_armor.dmi'
	body_parts_covered = CHEST|GROIN|ARMS|VITALS|LEGS //Pays off by not having other limbparts.

/obj/item/clothing/armor/rare/myrmidon/Initialize()
	. = ..()
	AddComponent(/datum/component/item_equipped_movement_rustle, custom_sounds = SFX_LAMELLAR_STEP)

/obj/item/clothing/armor/ceramic
	name = "tribal coverings"
	desc = "A more well-designed armor made with sturdy animal bones. Suitable for tribals whom uses little metallurgy."
	icon_state = "nacre_covering"
	icon = 'modular/kaizoku/icons/clothingicon/armor.dmi'
	mob_overlay_icon = 'modular/kaizoku/icons/clothing/armor.dmi'
	sleeved = 'modular/kaizoku/icons/helpers/sleeves_armor.dmi'
	armor = ARMOR_LEATHER_BAD
	blocksound = SOFTHIT
	blade_dulling = DULLING_BASHCHOP
	body_parts_covered = CHEST|GROIN|VITALS
	prevent_crits = list(BCLASS_CUT, BCLASS_CHOP, BCLASS_STAB) // Bones are ceramic-like. These are horrible against blunt.
	armor_class = AC_MEDIUM
	max_integrity = INTEGRITY_POOR
	anvilrepair = null //You can't repair 'ceramic' armor. You will need to make a new armor instead.
	smeltresult = /obj/item/fertilizer/ash
	sewrepair = FALSE
	slot_flags = ITEM_SLOT_ARMOR

/obj/item/clothing/armor/ceramic/Initialize()
	. = ..()
	AddComponent(/datum/component/item_equipped_movement_rustle, custom_sounds = SFX_PLATE_STEP)

/obj/item/clothing/armor/ceramic/reinforced
	name = "marauder trollhunter armor"
	desc = "The heavy armor used by the tribalistic undine marauder forces under the flag of abyssariads from the Fog Islands. Made of ceramic-like material from lava forges."
	icon_state = "marauder_chest"
	icon = 'modular/kaizoku/icons/clothingicon/armor.dmi'
	mob_overlay_icon = 'modular/kaizoku/icons/clothing/armor.dmi'
	sleeved = 'modular/kaizoku/icons/helpers/sleeves_armor.dmi'
	prevent_crits = list(BCLASS_CUT, BCLASS_CHOP, BCLASS_STAB) // Bones are ceramic-like. These are horrible against blunt.
	blade_dulling = DULLING_BASHCHOP
	body_parts_covered = CHEST|VITALS|ARMS|GROIN //Protects an acceptable large range of places for such relatively cost-y armor. I hope.
	armor = ARMOR_LEATHER_GOOD
	max_integrity = INTEGRITY_STANDARD
	equip_delay_self = 40
	armor_class = AC_MEDIUM

/obj/item/clothing/armor/ceramic/reinforced/Initialize()
	. = ..()
	AddComponent(/datum/component/item_equipped_movement_rustle, custom_sounds = SFX_PLATE_STEP)

/obj/item/clothing/armor/ceramic/light
	name = "bone coverings"
	desc = "An simple, primitive armor made of chiseled bones bound with fibers and sinews. Stronger than gambesons, but requires conquering tough dendor's creatures to make."
	icon = 'modular/kaizoku/icons/clothingicon/armor.dmi'
	mob_overlay_icon = 'modular/kaizoku/icons/clothing/armor.dmi'
	sleeved = 'modular/kaizoku/icons/helpers/sleeves_armor.dmi'
	armor = ARMOR_LEATHER
	icon_state = "ivory_coverings"
	slot_flags = ITEM_SLOT_ARMOR|ITEM_SLOT_SHIRT
	blocksound = SOFTHIT
	blade_dulling = DULLING_BASHCHOP
	body_parts_covered = CHEST|GROIN
	max_integrity = 100 //breaks quickly
	prevent_crits = list(BCLASS_CUT, BCLASS_STAB) //Bones acts similar to ceramics, it will crack with blunt damage.
	armor_class = AC_LIGHT

/obj/item/clothing/armor/ceramic/light/Initialize()
	. = ..()
	AddComponent(/datum/component/item_equipped_movement_rustle, custom_sounds = SFX_PLATE_STEP)

/obj/item/clothing/armor/medium/scale/shanwenkai
	name = "imperial weepersmail"
	desc = "Layered, flexible steel scales with the shape of Weeper's symbol for armor. Cheaper design compared to the Myrmidon armor for the foglander imperial army."
	icon_state = "shanwenkai"
	icon = 'modular/kaizoku/icons/clothingicon/armor.dmi'
	mob_overlay_icon = 'modular/kaizoku/icons/clothing/armor.dmi'
	sleeved = 'modular/kaizoku/icons/helpers/sleeves_armor.dmi'

/obj/item/clothing/armor/medium/scale/shanwenkai/Initialize()
	. = ..()
	AddComponent(/datum/component/item_equipped_movement_rustle, custom_sounds = SFX_CHAIN_STEP)

/obj/item/clothing/armor/leather/jacket/custodian //Pretty much the stonekeep version of gatemaster armor.
	name = "scout battlecoat"
	desc = "A islander gear made of interconnected hexagonal iron plates stitched under a thick coat. Treated in oil, it became waterproof and proper for naval engagement."
	icon_state = "hflcustodian"
	icon = 'modular/kaizoku/icons/clothingicon/armor.dmi'
	mob_overlay_icon = 'modular/kaizoku/icons/clothing/armor.dmi'
	sleeved = 'modular/kaizoku/icons/helpers/sleeves_armor.dmi'
	blocksound = SOFTHIT
	slot_flags = ITEM_SLOT_ARMOR
	armor = ARMOR_MAILLE_IRON
	body_parts_covered = COVERAGE_ALL_BUT_LEGS //Not sure yet if I should implement the same crit resists as that leather 'studded' armor.
	max_integrity = INTEGRITY_STRONG
	salvage_result = /obj/item/natural/cloth

/obj/item/clothing/armor/leather/jacket/custodian/Initialize()
	. = ..()
	if(GLOB.lordprimary)
		update_icon()

/obj/item/clothing/armor/leather/jacket/custodian/update_icon()
	. = ..()
	cut_overlays()
	if(icon_state)
		var/mutable_appearance/base = mutable_appearance(icon, icon_state)
		base.alpha = 255
		base.appearance_flags = RESET_COLOR
		add_overlay(base)
	if(GLOB.lordprimary)
		var/mutable_appearance/det = mutable_appearance(icon, "[icon_state]_det")
		det.appearance_flags = RESET_COLOR
		det.color = GLOB.lordprimary
		add_overlay(det)

/obj/item/clothing/armor/leather/jacket/custodian/Initialize()
	. = ..()
	AddComponent(/datum/component/item_equipped_movement_rustle, custom_sounds = SFX_PLATE_STEP)

/obj/item/clothing/armor/leather/jacket/custodian/foglander
	name = "imperial battlecoat"
	desc = "Thick coat with slim plates bound internally to belt-like leather reinforcements. Proper light armor for the imperial army's cavalry."
	icon_state = "fflcustodian"

/obj/item/clothing/armor/leather/jacket/custodian/foglander/Initialize()
	. = ..()
	AddComponent(/datum/component/item_equipped_movement_rustle, custom_sounds = SFX_PLATE_STEP)

/obj/item/clothing/armor/cuirass/custodian
	name = "coastal cuirass"
	desc = "A refined cuirass made of spring steel for coastal housecarls. Flexible, sturdy armor that gives all the required leeway to move."
	icon_state = "flscustodian"
	item_state = "flscustodian"
	icon = 'modular/kaizoku/icons/clothingicon/armor.dmi'
	mob_overlay_icon = 'modular/kaizoku/icons/clothing/armor.dmi'
	sleeved = 'modular/kaizoku/icons/helpers/sleeves_armor.dmi'

/obj/item/clothing/armor/cuirass/custodian/Initialize()
	. = ..()
	AddComponent(/datum/component/item_equipped_movement_rustle, custom_sounds = SFX_PLATE_STEP)

/obj/item/clothing/armor/cuirass/shuhen
	name = "shuhen cuirass"
	desc = "Plate and lamellar bound into padded leather. A proper cuirass for the Shuhen that requires that each inch of their skin remains covered."
	icon_state = "zigmaster"
	item_state = "zigmaster"
	icon = 'modular/kaizoku/icons/clothingicon/armor.dmi'
	mob_overlay_icon = 'modular/kaizoku/icons/clothing/armor.dmi'
	sleeved = 'modular/kaizoku/icons/helpers/sleeves_armor.dmi'

/obj/item/clothing/armor/cuirass/zinger/Initialize()
	. = ..()
	if(GLOB.lordprimary)
		update_icon()

/obj/item/clothing/armor/cuirass/zinger/update_icon()
	. = ..()
	cut_overlays()
	if(icon_state)
		var/mutable_appearance/base = mutable_appearance(icon, icon_state)
		base.alpha = 255
		base.appearance_flags = RESET_COLOR
		add_overlay(base)
	if(GLOB.lordprimary)
		var/mutable_appearance/det = mutable_appearance(icon, "[icon_state]_det")
		det.appearance_flags = RESET_COLOR
		det.color = GLOB.lordprimary
		add_overlay(det)

/obj/item/clothing/armor/cuirass/shuhen/Initialize()
	. = ..()
	AddComponent(/datum/component/item_equipped_movement_rustle, custom_sounds = SFX_LAMELLAR_STEP)

/obj/item/clothing/armor/chainmail/hauberk/custodian
	name = "custodian chainrobes"
	desc = "A large robe made of chains, essentially a mixture between the hauberk and a kusari katabira, which both are already the same thing."
	icon_state = "custodianchain"
	item_state = "custodianchain"
	icon = 'modular/kaizoku/icons/clothingicon/armor.dmi'
	mob_overlay_icon = 'modular/kaizoku/icons/clothing/armor.dmi'
	sleeved = 'modular/kaizoku/icons/helpers/sleeves_armor.dmi'

/obj/item/clothing/armor/chainmail/hauberk/custodian/Initialize()
	. = ..()
	if(GLOB.lordprimary)
		update_icon()

/obj/item/clothing/armor/chainmail/hauberk/update_icon()
	. = ..()
	cut_overlays()
	if(icon_state)
		var/mutable_appearance/base = mutable_appearance(icon, icon_state)
		base.alpha = 255
		base.appearance_flags = RESET_COLOR
		add_overlay(base)
	if(GLOB.lordprimary)
		var/mutable_appearance/det = mutable_appearance(icon, "[icon_state]_det")
		det.appearance_flags = RESET_COLOR
		det.color = GLOB.lordprimary
		add_overlay(det)

/obj/item/clothing/armor/chainmail/hauberk/custodian/Initialize()
	. = ..()
	AddComponent(/datum/component/item_equipped_movement_rustle, custom_sounds = SFX_CHAIN_STEP)

/obj/item/clothing/armor/brigandine/custzamurai
	name = "brigandine-of-knives"
	icon_state = "flccustodian"
	desc = "Brigandine made in traditional Shuhen metallurgy, with huge edged plates covering the shoulders before the shape of a cuirass is visible."
	icon = 'modular/kaizoku/icons/clothingicon/armor.dmi'
	mob_overlay_icon = 'modular/kaizoku/icons/clothing/armor.dmi'
	sleeved = 'modular/kaizoku/icons/helpers/sleeves_armor.dmi'

/obj/item/clothing/armor/brigandine/custzamurai/Initialize()
	. = ..()
	AddComponent(/datum/component/item_equipped_movement_rustle, custom_sounds = SFX_PLATE_STEP)

/obj/item/clothing/armor/brigandine/custknight
	name = "plated brigandine"
	desc = "Coastal brigandine proper for a knightly warrior. Well adjusted, it barely makes swimming harder, proper for those whom lives by the sea."
	icon_state = "hlccustodian"
	icon = 'modular/kaizoku/icons/clothingicon/armor.dmi'
	mob_overlay_icon = 'modular/kaizoku/icons/clothing/armor.dmi'
	sleeved = 'modular/kaizoku/icons/helpers/sleeves_armor.dmi'

/obj/item/clothing/armor/brigandine/custknight/Initialize()
	. = ..()
	AddComponent(/datum/component/item_equipped_movement_rustle, custom_sounds = SFX_PLATE_STEP)
