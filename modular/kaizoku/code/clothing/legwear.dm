/obj/item/clothing/pants/chainlegs/iron/haidate_tatami
	name = "foldable thighguard"
	desc = "The 'Haidate Tatami', a flexible thigh guard with interlocking scales sewn into the fabric. Ideal for agility during battle."
	gender = PLURAL
	icon = 'modular/kaizoku/icons/clothingicon/pants.dmi'
	mob_overlay_icon = 'modular/kaizoku/icons/clothing/pants.dmi'
	icon_state = "haidate_tatami"
	item_state = "haidate_tatami"
	sleeved = 'modular/kaizoku/icons/helpers/sleeves_pants.dmi'
	alternate_worn_layer = SHOESLEEVE_LAYER

/obj/item/clothing/pants/chainlegs/iron/haidate_tatami/Initialize()
	. = ..()
	AddComponent(/datum/component/item_equipped_movement_rustle, custom_sounds = SFX_CHAIN_STEP)

/obj/item/clothing/pants/chainlegs/sendan
	name = "segmented thighguard"
	desc = "A 'sendan tatami', a segmented thigh armor with overlapping plates that allows engagement in prolonged combat, without causing mobility issues."
	icon_state = "haidate_sendan"
	icon = 'modular/kaizoku/icons/clothingicon/pants.dmi'
	mob_overlay_icon = 'modular/kaizoku/icons/clothing/pants.dmi'
	sleeved = 'modular/kaizoku/icons/helpers/sleeves_pants.dmi'
	alternate_worn_layer = SHOESLEEVE_LAYER

/obj/item/clothing/pants/chainlegs/sendan/Initialize()
	. = ..()
	AddComponent(/datum/component/item_equipped_movement_rustle, custom_sounds = SFX_CHAIN_STEP)

/obj/item/clothing/pants/chainlegs/sendan/cursed/Initialize()
	. = ..()
	name = "soulbinded thighguard"
	ADD_TRAIT(src, TRAIT_NODROP, CURSED_ITEM_TRAIT)

/obj/item/clothing/pants/platelegs/yoroihakama
	name = "steel plated trousers"
	desc = "The 'Yoroi-Hakama', essentially a Hakama with plate reinforcement, with protuding plates protecting the hips, and many interlocking steel plates under the cloth."
	gender = PLURAL
	icon = 'modular/kaizoku/icons/clothingicon/pants.dmi'
	mob_overlay_icon = 'modular/kaizoku/icons/clothing/pants.dmi'
	sleeved = 'modular/kaizoku/icons/helpers/sleeves_pants.dmi'
	icon_state = "yoroihakama"
	item_state = "yoroihakama"
	alternate_worn_layer = SHOESLEEVE_LAYER

/obj/item/clothing/pants/platelegs/yoroihakama/Initialize()
	. = ..()
	AddComponent(/datum/component/item_equipped_movement_rustle, custom_sounds = SFX_PLATE_STEP)

/obj/item/clothing/pants/kaizoku/yoroihakama/update_icon()
	. = ..()
	cut_overlays()
	if(get_detail_tag())
		var/mutable_appearance/pic = mutable_appearance(icon(icon, "[icon_state][detail_tag]"))
		pic.appearance_flags = RESET_COLOR
		if(get_detail_color())
			pic.color = get_detail_color()
		add_overlay(pic)

/obj/item/clothing/pants/trou/tobi
	name = "tobi pants"
	desc = "Baggy pants of abyssariad design. Suitable for those who works the field and avoid horseback."
	icon_state = "tobi"
	item_state = "tobi"
	icon = 'modular/kaizoku/icons/clothingicon/pants.dmi'
	mob_overlay_icon = 'modular/kaizoku/icons/clothing/pants.dmi'
	sleeved = 'modular/kaizoku/icons/helpers/sleeves_pants.dmi'

/obj/item/clothing/pants/trou/tobi/random/Initialize()
	color = pick(GLOB.peasant_dyes)
	..()

/obj/item/clothing/pants/trou/tobi/tideweaver
	name = "tideweaver tobi pants"
	color = CLOTHING_TIDEWEAVER

/obj/item/clothing/pants/trou/tobi/purifier
	name = "purifier tobi pants"
	color = CLOTHING_PURIFIER

/obj/item/clothing/pants/trou/tobi/curator
	name = "curator tobi pants"
	color = CLOTHING_CURATOR

/obj/item/clothing/pants/trou/tobi/dark
	color = CLOTHING_SOOT_BLACK

/obj/item/clothing/pants/trou/tobi/kabukimono
	color = CLOTHING_KABUKIMONO

/obj/item/clothing/pants/trou/tobi/dragonslayer
	desc = "Baggy pants of abyssariad design. This one is coated in asbestos, and may be just as dangerous."
	color = "#3d4681"
	armor = list("blunt" = 30, "slash" = 30, "stab" = 20, "piercing" = 10, "fire" = 100, "acid" = 0)

/obj/item/clothing/pants/trou/leather/fur
	name = "thick tobi"
	icon_state = "furpants"
	desc = "A tobi made out of Dendor's beloved guardians - so Abyssor's beloved guardians can use it."
	icon = 'modular/kaizoku/icons/clothingicon/pants.dmi'
	mob_overlay_icon = 'modular/kaizoku/icons/clothing/pants.dmi'
	sleeved = 'modular/kaizoku/icons/helpers/sleeves_pants.dmi'

/obj/item/clothing/pants/trou/leather/fur/random/Initialize()
	color = pick(GLOB.peasant_dyes)
	..()

/obj/item/clothing/pants/trou/leather/fur/dragonslayer
	resistance_flags = FIRE_PROOF | ACID_PROOF
	color = CLOTHING_RED_OCHRE

/obj/item/clothing/pants/tights/hakama
	name = "abyssal trouser"
	icon_state = "hakama"
	alternate_worn_layer = SHOESLEEVE_LAYER
	desc = "Suitable for the Abyssariad-cultured, in which large battle-skirts does not hurt their masculinity, differently of the frail Imperial counterpart."
	icon = 'modular/kaizoku/icons/clothingicon/pants.dmi'
	mob_overlay_icon = 'modular/kaizoku/icons/clothing/pants.dmi'
	sleeved = 'modular/kaizoku/icons/helpers/sleeves_pants.dmi'

/obj/item/clothing/pants/tights/hakama/random/Initialize()
	color = pick(GLOB.peasant_dyes)
	..()

/obj/item/clothing/pants/tights/hakama/eidolon
	color = CLOTHING_EIDOLON

/obj/item/clothing/pants/tights/hakama/curator
	color = CLOTHING_CURATOR

/obj/item/clothing/pants/trou/leather/shinobizubon
	name = "shinobi zubon"
	desc = "Traditional flexible pants with loose fit around the legs with hardened leather tied under the cloth and ankles to prevent snagging and noise."
	gender = PLURAL
	icon = 'modular/kaizoku/icons/clothingicon/pants.dmi'
	mob_overlay_icon = 'modular/kaizoku/icons/clothing/pants.dmi'
	sleeved = 'modular/kaizoku/icons/helpers/sleeves_pants.dmi'
	icon_state = "shinobizubon"
	item_state = "shinobizubon"
	blocksound = SOFTHIT
	blade_dulling = DULLING_BASHCHOP
	r_sleeve_status = SLEEVE_NORMAL
	l_sleeve_status = SLEEVE_NORMAL

/obj/item/clothing/pants/kaizoku/ceramic
	name = "marauder chausses"
	desc = "Bone chausses chiseled into a mimicry of shells, equal to a lamellar of mollusk shells, so it better absorb and disperse impact."
	gender = PLURAL
	icon = 'modular/kaizoku/icons/clothingicon/pants.dmi'
	mob_overlay_icon = 'modular/kaizoku/icons/clothing/pants.dmi'
	sleeved = 'modular/kaizoku/icons/helpers/sleeves_pants.dmi'
	icon_state = "marauder_leg"
	item_state = "marauder_leg"
	sewrepair = FALSE
	armor = ARMOR_LEATHER
	max_integrity =  INTEGRITY_POOR
	prevent_crits = list(BCLASS_CUT, BCLASS_CHOP, BCLASS_BLUNT)
	armor_class = AC_MEDIUM
	body_parts_covered = GROIN|LEGS|FEET
	blocksound = PLATEHIT
	var/do_sound = FALSE
	drop_sound = 'modular/kaizoku/sound/foley/dropsound/armor_drop_lamellar.ogg'
	anvilrepair = /datum/skill/craft/armorsmithing
	alternate_worn_layer = SHOESLEEVE_LAYER

/obj/item/clothing/pants/kaizoku/ceramic/Initialize()
	. = ..()
	AddComponent(/datum/component/item_equipped_movement_rustle, custom_sounds = SFX_PLATE_STEP)

/obj/item/clothing/pants/platelegs/weepershanwenkai
	name = "Y-wenkai lowerhalf"
	desc = "Lower part of a Y-wenkai armor, relics of abyssariad championage for those of high-ranking deeply bound to Abyssanctum. Usually made of bronze, the grasp of the current era brought high-quality steel to the table."
	icon = 'modular/kaizoku/icons/clothingicon/pants.dmi'
	mob_overlay_icon = 'modular/kaizoku/icons/clothing/pants.dmi'
	sleeved = 'modular/kaizoku/icons/helpers/sleeves_pants.dmi'
	icon_state = "weepershanwenkai"
	item_state = "weepershanwenkai"
	gender = PLURAL
	alternate_worn_layer = SHOESLEEVE_LAYER

/obj/item/clothing/pants/platelegs/weepershanwenkai/Initialize()
	. = ..()
	AddComponent(/datum/component/item_equipped_movement_rustle, custom_sounds = SFX_LAMELLAR_STEP)

/obj/item/clothing/pants/kaizoku/ceramic/light
	name = "ivory leg plates"
	desc = "The leg protection proper for Undine warriors."
	icon = 'modular/kaizoku/icons/clothingicon/pants.dmi'
	mob_overlay_icon = 'modular/kaizoku/icons/clothing/pants.dmi'
	sleeved = 'modular/kaizoku/icons/helpers/sleeves_pants.dmi'
	max_integrity = INTEGRITY_WORST
	armor = ARMOR_LEATHER_BAD
	prevent_crits = list(BCLASS_CHOP, BCLASS_BLUNT)
	body_parts_covered = LEGS|FEET
	gender = PLURAL
	icon_state = "ivory_legs"
	item_state = "ivory_legs"

/obj/item/clothing/pants/kaizoku/ceramic/light/Initialize()
	. = ..()
	AddComponent(/datum/component/item_equipped_movement_rustle, custom_sounds = SFX_PLATE_STEP)

/obj/item/clothing/pants/kaizoku/tribal
	name = "tribal lowerhalf"
	desc = "piece of clothings usually used by Undine tribesmen of all genders."
	icon_state = "tribalcloth"
	icon = 'modular/kaizoku/icons/clothingicon/pants.dmi'
	mob_overlay_icon = 'modular/kaizoku/icons/clothing/pants.dmi'
	sleeved = 'modular/kaizoku/icons/helpers/sleeves_pants.dmi'
