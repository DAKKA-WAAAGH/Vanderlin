/obj/item/clothing/head/takuhatsugasa
	name = "alms umbrella hat"
	icon_state = "takuhatsugasa"
	desc = "A type of hat worn by monks during their begging rounds - or when punching demons into submission."
	icon = 'modular/kaizoku/icons/clothingicon/head.dmi'
	mob_overlay_icon = 'modular/kaizoku/icons/clothing/head.dmi'
	flags_inv = HIDEEARS

	armor = ARMOR_PADDED
	body_parts_covered = HEAD|HAIR|EARS
	prevent_crits =  MINOR_CRITICALS
	max_integrity = INTEGRITY_POOR

/obj/item/clothing/head/tengai
	name = "lay-monk hat"
	icon_state = "tengai"
	flags_inv = HIDEEARS|HIDEFACE|HIDEHAIR|HIDEFACIALHAIR
	desc = "A wide-brimmed hat traditionally worn by wandering monks of the Abyssanctum fold."
	bloody_icon = 'icons/effects/blood64x64.dmi'
	bloody_icon_state = "helmetblood_big"
	icon = 'modular/kaizoku/icons/clothingicon/head.dmi'
	mob_overlay_icon = 'modular/kaizoku/icons/clothingoldbodies/head64.dmi'
	flags_inv = HIDEEARS

	armor = ARMOR_PADDED
	body_parts_covered = HEAD|HAIR|EARS
	prevent_crits =  MINOR_CRITICALS
	max_integrity = INTEGRITY_POOR

/obj/item/clothing/head/tengai/curator
	name = "curator lay-monk hat"
	icon_state = "stengai"
	desc = "A tengai painted in red tar traditionally worn by Abyssanctum curators."
	bloody_icon_state = "helmetblood"
	flags_inv = HIDEEARS|HIDEFACE

/obj/item/clothing/head/tengai/gasa
	name = "umbrella hat"
	icon_state = "gasa"
	desc = "A conical straw hat used to protect from the sun and rain. Commonly used by commoners, or casually by the Zamurais and their retainers."
	flags_inv = HIDEEARS

/obj/item/clothing/head/lilly
	name = "small lilypad"
	icon_state = "lilypad_small"
	desc = "a small lilypad used by Undines to protect from sun and rain. This comes as a intercultural exchange mimicking Abyssariad's gasas."
	icon = 'modular/kaizoku/icons/clothingicon/head.dmi'
	mob_overlay_icon = 'modular/kaizoku/icons/clothing/head.dmi'

/obj/item/clothing/head/lilly/medium
	name = "medium lilypad"
	icon_state = "lilypad_medium"
	desc = "a medium lilypad used by Undines to protect from sun and rain. This comes as a intercultural exchange mimicking Abyssariad's gasas."

/obj/item/clothing/head/lilly/big
	name = "big lilypad"
	icon_state = "lilypad_big"
	desc = "a big lilypad used by Undines to protect from sun and rain. This comes as a intercultural exchange mimicking Abyssariad's gasas."

/obj/item/clothing/head/tengai/roningasa
	name = "roningasa"
	icon_state = "roningasa"
	flags_inv = HIDEEARS|HIDEFACE
	desc = "A hat typically worn by the masterless shuhen zamurais, the ronins."
	bloody_icon_state = null

/obj/item/clothing/head/tengai/torioigasa
	name = "birdchaser umbrella hat"
	icon_state = "torioigasa"
	desc = "A traditional Abyssariad hat designed for long travels on the murklands. Most used by commoners."
	bloody_icon_state = null

/obj/item/clothing/head/tengai/sandogasa
	name = "large umbrella hat"
	icon_state = "sandogasa"
	flags_inv = HIDEEARS
	desc = "A large hat providing ample shade and protection from the elements, including rain."
	bloody_icon_state = null
	flags_inv = HIDEEARS|HIDEFACE

/obj/item/clothing/head/tengai/sandogasa/curator
	name = "curator large umbrella hat"
	icon_state = "ssandogasa"
	desc = "A sandogasa painted in red tar traditionally worn by Abyssanctum curator."
	bloody_icon_state = null
	flags_inv = HIDEEARS|HIDEFACE

/obj/item/clothing/head/soheicloth
	name = "tideweaver coverings"
	desc = "Blessed fabric bathed in holy water, keeping a tideweaver protected from corruptive gases - and providing anonymity."
	icon_state = "soheicloth"
	body_parts_covered = HEAD|HAIR
	body_parts_covered = HEAD|HAIR|EARS|MOUTH
	flags_inv = HIDEEARS|HIDEFACE|HIDEHAIR|HIDEFACIALHAIR //it is not hiding facial hair when put on the neck. No idea how to fix.
	slot_flags = ITEM_SLOT_NECK|ITEM_SLOT_HEAD
	alternate_worn_layer = MOUTH_LAYER
	icon = 'modular/kaizoku/icons/clothingicon/head.dmi'
	mob_overlay_icon = 'modular/kaizoku/icons/clothing/head.dmi'
	blocksound = SOFTHIT
	equip_sound = 'sound/foley/equip/cloak_equip.ogg'
	pickup_sound = 'sound/foley/equip/cloak_take_off.ogg'
	break_sound = 'sound/foley/cloth_rip.ogg'
	drop_sound = 'sound/foley/dropsound/cloth_drop.ogg'
	sewrepair = TRUE
	anvilrepair = null
	resistance_flags = FLAMMABLE // Made of leather
	smeltresult = /obj/item/fertilizer/ash
	armor = ARMOR_LEATHER
	body_parts_covered = NECK|HAIR|EARS|HEAD
	max_integrity = INTEGRITY_POOR
	prevent_crits = CUT_AND_MINOR_CRITS

/obj/item/clothing/head/soheicloth/tideweaver
	name = "tideweaver sohei coverings"
	color = CLOTHING_TIDEWEAVER

/obj/item/clothing/head/soheicloth/purifier
	name = "purifier sohei coverings"
	color = CLOTHING_PURIFIER

/obj/item/clothing/head/soheicloth/curator
	name = "curator sohei coverings"
	color = CLOTHING_CURATOR

/obj/item/clothing/head/shinobi_zukin
	name = "shinobi hood"
	icon_state = "shinobi_zukin"
	flags_inv = HIDEEARS|HIDEFACE|HIDEHAIR|HIDEFACIALHAIR
	desc = "A hood worn by members of Shinobi clans to conceal their identity and blend into the shadows. Unsuitable for espionage for being too obvious."
	icon = 'modular/kaizoku/icons/clothingicon/head.dmi'
	mob_overlay_icon = 'modular/kaizoku/icons/clothing/head.dmi'

/obj/item/clothing/head/helmet/zijinguan
	name = "footsoldier helmet" //This is actually a ming dynasty helmet
	desc = "A cost-effective Myrmidon helmet from the age of guardianship, the current symbol of Abyssariad military culture for commoners."
	icon_state = "zijinguan"
	flags_inv = HIDEEARS
	icon = 'modular/kaizoku/icons/clothingicon/head.dmi' // Remove the nose protection later.
	mob_overlay_icon = 'modular/kaizoku/icons/clothingoldbodies/head64.dmi'
	bloody_icon = 'icons/effects/blood64x64.dmi'
	bloody_icon_state = "helmetblood_big"
	detail_tag = "_detail"
	dynamic_hair_suffix = ""

/obj/item/clothing/head/helmet/zijinguan/update_icon()
	. = ..()
	cut_overlays()
	if(get_detail_tag())
		var/mutable_appearance/pic = mutable_appearance(icon(icon, "[icon_state][detail_tag]"))
		pic.appearance_flags = RESET_COLOR
		if(get_detail_color())
			pic.color = get_detail_color()
		add_overlay(pic)

/obj/item/clothing/head/helmet/zijinguan/Initialize()
	. = ..()
	if(GLOB.lordprimary)
		detail_color = GLOB.lordprimary
	else
		detail_color = "#8B0000" // Fallback color
	update_icon()

/obj/item/clothing/head/helmet/sallet/tosei_kabuto
	name = "riveted helmet"
	desc = "Forged from riveted steel in a radial pattern, this gives a strong foundation for a \
	helmet capable of protecting even against musket balls. Don't expect to be safe from the whip effect on the neck, but your skull will stay in place."
	icon_state = "tosei_kabuto"
	icon = 'modular/kaizoku/icons/clothingicon/head.dmi'
	mob_overlay_icon = 'modular/kaizoku/icons/clothingoldbodies/head64.dmi'
	bloody_icon = 'icons/effects/blood64x64.dmi'
	bloody_icon_state = "helmetblood_big"

/obj/item/clothing/head/helmet/sallet/tosei_kabuto/cursed/Initialize()
	. = ..()
	name = "soulbinded tosei kabuto"
	ADD_TRAIT(src, TRAIT_NODROP, CURSED_ITEM_TRAIT)

/obj/item/clothing/head/helmet/sallet/tosei_kabuto/cursed/dropped(mob/living/carbon/human/user)
	. = ..()
	if(QDELETED(src))
		return
	qdel(src)

/obj/item/clothing/head/helmet/visored/sallet/tosei_kabuto
	name = "masked riveted helmet"
	desc = "Forged from riveted steel in a radial pattern, this gives a strong foundation for a \
	helmet capable of protecting even against musket balls. Don't expect to be safe from the whip effect on the neck, but your skull will stay in place."
	icon_state = "toseikabuto_visor"
	icon = 'modular/kaizoku/icons/clothingicon/head.dmi'
	mob_overlay_icon = 'modular/kaizoku/icons/clothingoldbodies/head64.dmi'
	bloody_icon = 'icons/effects/blood64x64.dmi'
	bloody_icon_state = "helmetblood_big"

/obj/item/clothing/head/helmet/visored/sallet/tosei_kabuto/cursed/Initialize()
	. = ..()
	name = "soulbinded masked tosei kabuto"
	ADD_TRAIT(src, TRAIT_NODROP, CURSED_ITEM_TRAIT)

/obj/item/clothing/head/helmet/visored/sallet/tosei_kabuto/cursed/dropped(mob/living/carbon/human/user)
	. = ..()
	if(QDELETED(src))
		return
	qdel(src)

/obj/item/clothing/head/helmet/visored/zunari //knight helmet.
	name = "layered zamurai helmet"
	desc = "The 'Etchu Zunari Kabuto' helmet, with forward-overlapping brow plates to deflect blows and arrows, while shielding from the sun and sweat."
	icon_state = "zunari_kabuto"
	icon = 'modular/kaizoku/icons/clothingicon/head.dmi'
	mob_overlay_icon = 'modular/kaizoku/icons/clothing/head.dmi'
	adjustable = CAN_CADJUST
	emote_environment = 3
	block2add = FOV_RIGHT|FOV_LEFT
	flags_inv = HIDEEARS|HIDEFACE|HIDEHAIR
	body_parts_covered = HEAD_EXCEPT_MOUTH
	detail_tag = "_det"

/obj/item/clothing/head/helmet/visored/zunari/cursed/Initialize()
	. = ..()
	name = "soulbinded zunari kabuto"
	ADD_TRAIT(src, TRAIT_NODROP, CURSED_ITEM_TRAIT)

/obj/item/clothing/head/helmet/visored/zunari/cursed/dropped(mob/living/carbon/human/user)
	. = ..()
	if(QDELETED(src))
		return
	qdel(src)

/obj/item/clothing/head/helmet/leather/malgai
	name = "leather malgai"
	desc = "Traditional dustwalker leather helmet for those who dwells \
	on the center of Fog islands on horseback, where the great steppes exists."
	icon_state = "malgai"
	icon = 'modular/kaizoku/icons/clothingicon/head.dmi'
	mob_overlay_icon = 'modular/kaizoku/icons/clothing/head.dmi'

/obj/item/clothing/head/helmet/leather/malgai/kaizoku
	name = "kaizoku hat"
	desc = "A distinguished hat with three sides of the brim turned up and laced, \
	forming a triangle. Usually used by the Coastal people of Fog Islands - or rich fellows."
	icon_state = "tricorn"

/obj/item/clothing/head/helmet/leather/malgai/duulga //same changes of 'leather' to 'hide' has been brought over to this hat + mouth protection, because Mongol hat go brrtt
	name = "abyssal leather helmet"
	desc = "The thick, oil-boiled layered 'arisan duulga' used by Abyssariads Dustwalkers \
	from the arid steppelands on the heart of the Fog Islands."
	icon_state = "arisan_duulga"
	armor = ARMOR_LEATHER_GOOD
	prevent_crits = list(BCLASS_BLUNT, BCLASS_TWIST)
	body_parts_covered = HEAD|HAIR|EARS|NOSE|MOUTH
	resistance_flags = FLAMMABLE // Made of leather
	smeltresult = /obj/item/fertilizer/ash
	anvilrepair = null
	max_integrity = INTEGRITY_STANDARD
	sewrepair = TRUE
	blocksound = SOFTHIT
	sellprice = 25
	icon = 'modular/kaizoku/icons/clothingicon/head.dmi'
	mob_overlay_icon = 'modular/kaizoku/icons/clothing/head.dmi'

/*
/obj/item/clothing/head/helmet/kaizoku
	name = "template BUGREPORT"
	icon = 'modular/kaizoku/icons/clothingicon/head.dmi'
	mob_overlay_icon = 'modular/kaizoku/icons/clothing/head.dmi'
	icon_state = ""
	sellprice = VALUE_CHEAP_IRON_HELMET
	max_integrity = INTEGRITY_POOR
*/

/obj/item/clothing/head/helmet/kaizoku/heartfelt
	name = "heartfelt zunari kabuto"
	desc = "An Etchu Zunari kabuto with Heartfelt markings. It lacks a demonic \
	mask for intimidation purposes - yet remains just as effective, besides showing \
	the incredible artistic value that upholds Heartfelt's culture."
	icon_state = "heartfelt_kabuto"
	body_parts_covered = HEAD|HAIR|EARS //maskless, protects less of the face.
	flags_inv = HIDEEARS
	mob_overlay_icon = 'modular/kaizoku/icons/clothingoldbodies/head64.dmi'
	icon = 'modular/kaizoku/icons/clothingicon/head.dmi'
	bloody_icon = 'icons/effects/blood64x64.dmi'
	bloody_icon_state = "helmetblood_big"
	emote_environment = 3
	sellprice = VALUE_STEEL_HELMET+BONUS_VALUE_SMALL
	clothing_flags = CANT_SLEEP_IN
	armor = ARMOR_PLATE
	armor_class = AC_HEAVY
	prevent_crits = ALL_CRITICAL_HITS
	max_integrity = INTEGRITY_STRONG

/obj/item/clothing/head/helmet/skullcap/hachigane //This is, in essence, a skullcap.
	name = "forehead protector"
	desc = "The 'Hachigane', a simple, lamellar head protection made for humble monks, ronins and the poor - with the material often gathered from iron panning."
	icon_state = "hachi-gane"
	mob_overlay_icon = 'modular/kaizoku/icons/clothing/head.dmi'
	icon = 'modular/kaizoku/icons/clothingicon/head.dmi'

/obj/item/clothing/head/helmet/skullcap/hachigane/tideweaver
	name = "tideweaver forehead protector"
	desc = "Simple, lamellar head protection. Marked in yellow for the mountainous magicians and monks who praises Abyssor's thunders."
	color = CLOTHING_TIDEWEAVER

/obj/item/clothing/head/helmet/skullcap/hachigane/purifier
	name = "purifier forehead protector"
	desc = "Simple, lamellar head protection. Marked in light blue for the expeditionary magicians and monks of Abyssanctum's faith, long married to the seas."
	color = CLOTHING_PURIFIER

/obj/item/clothing/head/helmet/skullcap/hachigane/curator
	name = "curator forehead protector"
	desc = "Simple, lamellar head protection. Marked in red for the soilgazers of Abyssanctum's faith, those bent in ensuring no plague shall reach their blessed islands. "
	color = CLOTHING_CURATOR

/obj/item/clothing/head/helmet/ironpot/rattan
	name = "tengpai dou"
	icon_state = "rattan_helmet"
	desc = "A cheap abyssariad helmet made from stripped, oil boiled rattan and iron. \
	Often used by the humble LinYou warriors. Less protective, but can be easily repaired."
	mob_overlay_icon = 'modular/kaizoku/icons/clothingoldbodies/head64.dmi'
	icon = 'modular/kaizoku/icons/clothingicon/head.dmi'
	bloody_icon = 'icons/effects/blood64x64.dmi'
	bloody_icon_state = "helmetblood_big"
	sewrepair = TRUE

/obj/item/clothing/head/helmet/heavy/bronzepot //hopefully asking someone to draw this helmet.
	name = "relic of urn"
	icon_state = "bronzeb"
	desc = "The eternal relic of the Champions of the Urn, used by Eidolon Skylancers, \
	the Demonslayers of the Abyssal order. It cannot be removed, forever one with the user \
	- molten and grafted into skin, but the infused arcane bends light upon itself for clear sight."
	smeltresult = /obj/item/ingot/steel //Intentional. The helmet is not actually made of bronze. It is just a lingering apotheosis-age term for that internal-mirror design.
	flags_inv = HIDEEARS|HIDEFACE|HIDEHAIR|HIDEFACIALHAIR
	icon = 'modular/kaizoku/icons/clothingicon/head.dmi'
	mob_overlay_icon = 'modular/kaizoku/icons/clothingoldbodies/head64.dmi'
	bloody_icon = 'icons/effects/blood64x64.dmi'
	bloody_icon_state = "helmetblood_big"
	block2add = null //Can easily see - cannot remove the helmet. This is your new skull.
	adjustable = CAN_CADJUST
	clothing_flags = null

/obj/item/clothing/head/helmet/heavy/bronzepot/AdjustClothes(mob/user)
	if(loc == user)
		playsound(user, "sound/items/visor.ogg", 50, TRUE, -1)
		if(adjustable == CAN_CADJUST)
			adjustable = CADJUSTED
			icon_state = "[initial(icon_state)]_raised"
			body_parts_covered = HEAD|HAIR|EARS
			flags_inv = HIDEEARS|HIDEHAIR
			flags_cover = null
			prevent_crits = list(BCLASS_CUT, BCLASS_CHOP, BCLASS_BLUNT) // Vulnerable to eye stabbing while visor is open
			if(ishuman(user))
				var/mob/living/carbon/H = user
				H.update_inv_head()
		else if(adjustable == CADJUSTED)
			ResetAdjust(user)
			prevent_crits = ALL_CRITICAL_HITS
			body_parts_covered = FULL_HEAD
			flags_inv = HIDEEARS|HIDEFACE|HIDEHAIR
			flags_cover = HEADCOVERSEYES | HEADCOVERSMOUTH
			if(user)
				if(ishuman(user))
					var/mob/living/carbon/H = user
					H.update_inv_head()
	else // Failsafe.
		to_chat(user, "<span class='warning'>How the hell you removed your external cranium? PUT IT BACK, EIDOLON.</span>")
		return

/obj/item/clothing/head/helmet/heavy/bronzepot/Initialize()
	. = ..()
	ADD_TRAIT(src, TRAIT_NODROP, CURSED_ITEM_TRAIT) //It is molten on the user's head.

/obj/item/clothing/head/helmet/heavy/bronzepot/dropped(mob/living/carbon/human/user)
	. = ..()
	if(QDELETED(src))
		return
	qdel(src)

/obj/item/clothing/head/helmet/heavy/bronzepot/dropped(mob/living/carbon/human/user)
	. = ..()
	if(QDELETED(src))
		return
	qdel(src)

/obj/item/clothing/head/helmet/visored/abyssalchampion //hounskull tier.
	name = "winged helmet"
	desc = "The traditional winged helmet of ancient design with a protective mask covering it. \
	It has foundations on the ancient myrmidon guardian helmets."
	icon_state = "abyssal_champion"
	item_state = "abyssal_champion"
	icon = 'modular/kaizoku/icons/clothingicon/head.dmi'
	mob_overlay_icon = 'modular/kaizoku/icons/clothing/head.dmi'
	emote_environment = 3
	block2add = FOV_RIGHT|FOV_LEFT

	armor = ARMOR_PLATE

/obj/item/clothing/head/helmet/heavy/necked/soheidemon
	name = "warpriest battle cowl"
	desc = "A fabric blessed both in holy water and steel. A mask-like metal reinforcement \
	covered with yellow silk protects the skull of these tideweaver warriors."
	icon_state = "soheidemon"
	item_state = "soheidemon"
	icon = 'modular/kaizoku/icons/clothingicon/head.dmi'
	mob_overlay_icon = 'modular/kaizoku/icons/clothingoldbodies/head64.dmi'
	bloody_icon = 'icons/effects/blood64x64.dmi'
	bloody_icon_state = "helmetblood_big"

// 'bone-tier' Undine equipments.

/obj/item/clothing/head/wizhat/onmyoji
	name = "stormcaller warhat"
	desc = "Surprisingly huge hats used by stormcaller whom take part of the abyssal championage in warfare. The hat shadows hides the eyes from the lower castes."
	icon_state = "abyssalhat"
	icon = 'modular/kaizoku/icons/clothingicon/head.dmi'
	mob_overlay_icon = 'modular/kaizoku/icons/clothingoldbodies/head64.dmi'
	bloody_icon = 'icons/effects/blood64x64.dmi'
	resistance_flags = FLAMMABLE
	bloody_icon = 'icons/effects/blood64x64.dmi'
	bloody_icon_state = "helmetblood_big"

/obj/item/clothing/head/wizhat/onmyoji/random/Initialize()
	. = ..()
	color = pick("#4756d8", "#759259", "#bf6f39", "#c1b144")

/obj/item/clothing/head/wizhat/onmyoji/tideweaver
	name = "tideweaver stormcaller warhat"
	color = CLOTHING_TIDEWEAVER

/obj/item/clothing/head/wizhat/onmyoji/purifier
	name = "purifier stormcaller warhat"
	color = CLOTHING_PURIFIER

/obj/item/clothing/head/wizhat/onmyoji/curator
	name = "curator stormcaller warhat"
	color = CLOTHING_CURATOR

/obj/item/clothing/head/wizhat/onmyoji/black
	color = CLOTHING_SOOT_BLACK

/obj/item/clothing/head/wizhat/onmyoji/eboshi
	name = "eboshi hat"
	desc = "traditional stormcallers hats for those who desires to practice natural sciences and divinations rather than warfare."
	icon_state = "eboshihat"
	icon = 'modular/kaizoku/icons/clothingicon/head.dmi'
	mob_overlay_icon = 'modular/kaizoku/icons/clothingoldbodies/head64.dmi'
	bloody_icon = 'icons/effects/blood64x64.dmi'
	sellprice = 100
	resistance_flags = FLAMMABLE
	bloody_icon = 'icons/effects/blood64x64.dmi'
	bloody_icon_state = "helmetblood_big"

/obj/item/clothing/head/wizhat/onmyoji/eboshi/Initialize()
	color = pick_assoc(GLOB.noble_dyes)
	..()

/obj/item/clothing/head/rare/myrmidon
	name = "myrmidon helmet"
	desc = "The warrior-priests bound to divine oath, consecrated to fight in the abyss as \
	extensions of the Heavenly Emperor. It became reference for the current day zijinguan and winged helmets."
	icon_state = "myrmidon"
	item_state = "myrmidon"
	allowed_sex = list(MALE, FEMALE)
	allowed_race = list("abyssariad")
	flags_inv = HIDEEARS
	clothing_flags = CANT_SLEEP_IN
	body_parts_covered = HEAD|HAIR|EARS|NOSE|MOUTH
	icon = 'modular/kaizoku/icons/clothingicon/head.dmi'
	mob_overlay_icon = 'modular/kaizoku/icons/clothingoldbodies/head64.dmi'
	bloody_icon = 'icons/effects/blood64x64.dmi'
	bloody_icon_state = "helmetblood_big"
	flags_inv = HIDEEARS|HIDEFACE|HIDEHAIR|HIDEFACIALHAIR

/obj/item/clothing/head/rare/dragonslayer
	name = "dragonslayer helmet"
	icon_state = "dragonslayer"
	item_state = "dragonslayer"
	desc = "The hallmark of the Dragonslayers, those born to endure the blazing infernos from \
	the sons of magma. The asbestos materials excels in resisting the intense heat of dragonfire and wizardry."
	flags_inv = HIDEEARS|HIDEFACE|HIDEHAIR|HIDEFACIALHAIR
	resistance_flags = FIRE_PROOF | ACID_PROOF
	icon = 'modular/kaizoku/icons/clothingicon/head.dmi'
	mob_overlay_icon = 'modular/kaizoku/icons/clothingoldbodies/head64.dmi'
	bloody_icon = 'icons/effects/blood64x64.dmi'
	bloody_icon_state = "helmetblood_big"

/obj/item/clothing/head/bardhat/bloodhunter
	name = "scrapped hat"
	desc = "An Coastal hat that has been scrapped with sharp tools and hardened in oil, \
	meant to convey one's status to not only destroy such expensive piece - but to keep it raised like thorns."
	icon_state = "bloodhunter"
	icon = 'modular/kaizoku/icons/clothingicon/head.dmi'
	mob_overlay_icon = 'modular/kaizoku/icons/clothing/head.dmi'

/obj/item/clothing/head/bardhat/bloodhunter/yharnam
	name = "bloodhunter hat"
	color = "#0e305c"

/obj/item/clothing/head/helmet/leather/malgai/kaizoku/female
	name = "lady hat"
	desc = "A hat produced by abyssariad and heartfeltean hands for the most beautiful of ladies. Or rich, that is."
	icon_state = "heartfelthandf"
	icon = 'modular/kaizoku/icons/clothingicon/head.dmi'
	mob_overlay_icon = 'modular/kaizoku/icons/clothing/head.dmi'

//temple helmet
//................ Abyssor Shrinekeeper ............... //
/obj/item/clothing/head/padded/shrinekeeper
	name = "shrinekeeper kabuto"
	desc = "A gift to new Abyssanctum devotees and a badge of their shrinekeeping duties, referencing guardianship of old, this helm is crafted from the enamel of deep-sea leviathans to protect the head of shrinekeepers."
	icon = 'modular/kaizoku/icons/clothingicon/head.dmi'
	mob_overlay_icon = 'modular/kaizoku/icons/clothing/head.dmi'
	icon_state = "shrinekeeper_kabuto"
	flags_inv = HIDEEARS | HIDEHAIR | HIDEFACIALHAIR

	armor = ARMOR_WEAK
	prevent_crits = MINOR_CRITICALS

/obj/item/clothing/head/helmet/ceramic
	name = "bone tribal helmet"
	icon_state = "ivory_head"
	desc = "A simple, protective bone helmet made from the creatures of the land."
	slot_flags = ITEM_SLOT_HEAD|ITEM_SLOT_HIP
	body_parts_covered = HEAD|HAIR
	prevent_crits = list(BCLASS_STAB) //This one is too thin to actually protect someone beyond stabbing wounds. Cut would have too much 'blunt'.
	resistance_flags = FIRE_PROOF
	icon_state = "ivory_head"
	armor = ARMOR_PADDED
	anvilrepair = null
	smeltresult = /obj/item/fertilizer/ash
	sewrepair = FALSE
	blocksound = SOFTHIT
	sellprice = 10
	max_integrity = INTEGRITY_POOR
	icon = 'modular/kaizoku/icons/clothingicon/head.dmi'
	mob_overlay_icon = 'modular/kaizoku/icons/clothing/head.dmi'

/obj/item/clothing/head/helmet/ceramic/medium
	name = "bone ravanger helmet"
	icon_state = "ravager_head"
	desc = "The helmets commonly used by Undine warriors or common riverdwellers who took upon themselves to protect their heads against goblinoid invasions."
	prevent_crits = list(BCLASS_CUT, BCLASS_STAB) //Bones are not good against blunt.
	body_parts_covered = HEAD|HAIR|EARS
	flags_inv = HIDEEARS
	max_integrity = INTEGRITY_STANDARD
	flags_cover = HEADCOVERSEYES | HEADCOVERSMOUTH
	armor = ARMOR_PADDED_GOOD
	icon = 'modular/kaizoku/icons/clothingicon/head.dmi'
	mob_overlay_icon = 'modular/kaizoku/icons/clothingoldbodies/head64.dmi'
	bloody_icon = 'icons/effects/blood64x64.dmi'
	bloody_icon_state = "helmetblood_big"

/obj/item/clothing/head/helmet/ceramic/reinforced
	name = "marauder trollhunter helmet"
	icon_state = "marauder_head"
	desc = "The full bone helmet that became the symbol of the unison of the Undine tribes and the Abyssariads, taking reference from the Championage's Dragonslayer helmets."
	prevent_crits = list(BCLASS_CUT, BCLASS_CHOP, BCLASS_STAB) //Bones are not good against blunt.
	body_parts_covered = HEAD|EARS|HAIR|NOSE|EYES|FACE
	flags_inv = HIDEEARS
	max_integrity = INTEGRITY_STANDARD
	flags_cover = HEADCOVERSEYES | HEADCOVERSMOUTH
	armor = ARMOR_LEATHER_BAD
	block2add = FOV_RIGHT|FOV_LEFT
	bloody_icon_state = null
	icon = 'modular/kaizoku/icons/clothingicon/head.dmi'
	mob_overlay_icon = 'modular/kaizoku/icons/clothingoldbodies/head64.dmi'
	bloody_icon = 'icons/effects/blood64x64.dmi'
	bloody_icon_state = "helmetblood_big"

/obj/item/clothing/head/helmet/visored/zunari/zamurai
	detail_tag = "_det"
	colorgrenz = TRUE
	base_icon_state = "zunari_kabuto"

/obj/item/clothing/head/helmet/visored/zunari/zamurai/update_icon()
	. = ..()
	cut_overlays()
	var/visor_suffix = ""
	if(adjustable == CADJUSTED)
		visor_suffix = "_raised"
	icon_state = "[base_icon_state][visor_suffix]"
	color = initial(color)

	if(get_detail_tag())
		var/overlay_icon_state = "[base_icon_state][get_detail_tag()][visor_suffix]"
		var/mutable_appearance/pic = mutable_appearance(icon(icon, overlay_icon_state))
		pic.appearance_flags = RESET_COLOR
		if(get_detail_color())
			pic.color = get_detail_color()
		add_overlay(pic)

/obj/item/clothing/head/helmet/visored/zunari/zamurai/AdjustClothes(mob/user)
	if(loc == user)
		playsound(user, "sound/items/visor.ogg", 50, TRUE, -1)
		if(adjustable == CAN_CADJUST)
			adjustable = CADJUSTED
			body_parts_covered = COVERAGE_HEAD
			flags_inv = HIDEEARS
			flags_cover = null
			prevent_crits = list(BCLASS_CUT, BCLASS_CHOP, BCLASS_BLUNT)
			block2add = null
		else if(adjustable == CADJUSTED)
			ResetAdjust(user)

		if(istype(src, /obj/item/clothing/head/helmet/visored/zunari/zamurai))
			src:update_icon()

		if(ishuman(user))
			var/mob/living/carbon/H = user
			H.update_inv_head()

		user.update_fov_angles()
	else // Failsafe.
		to_chat(user, "<span class='warning'>Wear the helmet on your head to open and close the visor.</span>")
		return

/obj/item/clothing/head/helmet/leather/paddedt
	name = "grenadier bearskin"
	desc = "A furcap that was commonly used by coastal grenadiers in the past, became commonly used by light \
	soldiers over centuries, usually ceremonial, with leather padding it becomes protective."
	icon_state = "paddedt"
	icon = 'modular/kaizoku/icons/clothingicon/head.dmi'
	mob_overlay_icon = 'modular/kaizoku/icons/clothingoldbodies/head64.dmi'
	worn_x_dimension = 64
	worn_y_dimension = 64

/obj/item/clothing/head/helmet/leather/paddedt/Initialize()
	. = ..()
	if(GLOB.lordprimary)
		update_icon()

/obj/item/clothing/head/helmet/leather/paddedt/update_icon()
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

/obj/item/clothing/head/helmet/leather/paddedt/worn_overlays(isinhands, file2use, dummy_block)
	var/list/extras = ..(isinhands, file2use, dummy_block = dummy_block)
	if(GLOB.lordprimary)
		var/image/det_img = image(file2use, "[icon_state]_det")
		det_img.color = GLOB.lordprimary
		extras += det_img
	return extras

/obj/item/clothing/head/helmet/leather/paddedt/alt
	name = "cresthelm"
	desc = "Protective helmet with a padded leather cap and a crest, used by lowly members of Foglander's imperial retainers. \
	Typically worn by scouts and light infantry aiding the main forces to keep unruly zamurais at bay."
	icon_state = "paddedf"

/obj/item/clothing/neck/bevor/crabstain
	name = "crabstain bevor"
	desc = "A crab-like throat and neck protector favored by Shuhen guards, with jagged lips similar to carcinized sea creatures. \
			The ridged mechanisms can be opened with the tongue to allow the user to eat. With a Jingasa, it gives a crab-like look."
	icon_state = "crabstain"
	icon = 'modular/kaizoku/icons/clothingicon/neck.dmi'
	mob_overlay_icon = 'modular/kaizoku/icons/clothing/neck.dmi'
	adjustable = CAN_CADJUST
	alternate_worn_layer = MOUTH_LAYER

/obj/item/clothing/neck/bevor/crabstain/AdjustClothes(mob/user)
	if(loc == user)
		if(adjustable == CAN_CADJUST)
			adjustable = CADJUSTED
			if(toggle_icon_state)
				icon_state = "[initial(icon_state)]_open"
			flags_inv = null
			body_parts_covered = NECK|EARS
			if(ishuman(user))
				var/mob/living/carbon/H = user
				H.update_inv_neck()
		else if(adjustable == CADJUSTED)
			ResetAdjust(user)
			flags_inv = HIDEEARS|HIDEHAIR
			if(user)
				if(ishuman(user))
					var/mob/living/carbon/H = user
					H.update_inv_neck()

/obj/item/clothing/neck/gorget/lazerrain
	name = "lazerrain aegis"
	icon_state = "lazerrain"
	desc = "Compact, interlocking iron bands that slip beneath armor to ensure your neck will remain secured from slashes and punctures."
	icon = 'modular/kaizoku/icons/clothingicon/neck.dmi'
	mob_overlay_icon = 'modular/kaizoku/icons/clothing/neck.dmi'
	alternate_worn_layer = MOUTH_LAYER

/obj/item/clothing/cloak/raincloak/guardsman
	name = "coastal capelet"
	desc = "a shoulder-length cape used by coastal duelists. Proper for distractions and hide blades under."
	icon_state = "guardcloak"
	body_parts_covered = CHEST|GROIN
	slot_flags = ITEM_SLOT_ARMOR|ITEM_SLOT_CLOAK
	inhand_mod = FALSE
	hoodtype = null
	icon = 'modular/kaizoku/icons/clothingicon/cloaks.dmi'
	mob_overlay_icon = 'modular/kaizoku/icons/clothing/cloaks.dmi'
	sleeved = 'modular/kaizoku/icons/clothing/cloaks.dmi'

/obj/item/clothing/cloak/raincloak/guardsman/Initialize()
	. = ..()
	if(GLOB.lordprimary)
		lordcolor(GLOB.lordsecondary)
	else
		color = CLOTHING_BLOOD_RED

/obj/item/clothing/head/helmet/kettle/kaizoku
	name = "blasthammer kettle"
	desc = "A kettle based on the old Dustwalker blasthammer helmet but for the battlefield, from lava drops to fiery shrapnels and blows."
	icon_state = "firelancer_kettle"
	detail_tag = ""
	detail_color = null
	icon = 'modular/kaizoku/icons/clothingicon/head.dmi'
	mob_overlay_icon = 'modular/kaizoku/icons/clothingoldbodies/head64.dmi'

/obj/item/clothing/head/helmet/kettle/kaizoku/imperial
	name = "imperial siege kettle"
	desc = "Skull protector of Imperial design. It's square-like design deflect blows more predictably, most proper for maze warfare on the heavenly towers."
	icon_state = "hfs_kettle"

/obj/item/clothing/head/helmet/kettle/kaizoku/coastal
	name = "coastal pothat"
	desc = "Infantry headgear of Coastal design in a bowl-like silhouette, having a large brim protecting the eyes from the sun."
	icon_state = "ffs_kettle"

/obj/item/clothing/head/helmet/kettle/kaizoku/shuhen //the same as a Kettle. Just don't want the 64x64 bits.
	name = "armored umbrella helmet"
	desc = "The 'Jingasa', a metal gasa in conical shape. Mainly worn by Shuhen ashigarus, it has a wide brim to deflect projectiles and a gap within acting as a buffer zone."
	icon_state = "jingasa"
	flags_inv = HIDEEARS
	smeltresult = /obj/item/fertilizer/ash
	bloody_icon = 'icons/effects/blood.dmi'
	bloody_icon_state = "itemblood"
	worn_x_dimension = 32
	worn_y_dimension = 32
	icon = 'modular/kaizoku/icons/clothingicon/head.dmi'
	mob_overlay_icon = 'modular/kaizoku/icons/clothing/head.dmi'

/obj/item/clothing/head/helmet/guardsman
	name = "imperial helmet"
	desc = "Infantry headgear sourced from Foglander's imperial armies with a spade covering the nose. Traditionally used with a plume."
	icon = 'modular/kaizoku/icons/clothingicon/head.dmi'
	mob_overlay_icon = 'modular/kaizoku/icons/clothingoldbodies/head64.dmi'
	icon_state = "ffm_helmet"
	body_parts_covered = COVERAGE_HEAD_NOSE
	flags_inv = HIDEEARS|HIDEHAIR|HIDEFACE
	block2add = FOV_BEHIND
	max_integrity = INTEGRITY_STANDARD
	slot_flags = ITEM_SLOT_HEAD | ITEM_SLOT_HIP
	smeltresult = /obj/item/ingot/iron
	sellprice = VALUE_IRON_ARMOR_UNUSUAL
	item_weight = 6 * STEEL_MULTIPLIER

/obj/item/clothing/head/helmet/guardsman/Initialize()
	. = ..()
	if(GLOB.lordprimary)
		update_icon()

/obj/item/clothing/head/helmet/guardsman/update_icon()
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

/obj/item/clothing/head/helmet/guardsman/coastal
	name = "housecarl helmet"
	desc = "The headgear of a frontline Coastal warrior, with an overlapping falcon-like protection for the eyes."
	icon_state = "hfm_helmet"

/obj/item/clothing/head/helmet/guardsman/zinger
	name = "zingersman helmet"
	desc = "Important headgear of the shuhen zigmaster ronins, whom pays for their past mistakes with blood."
	icon_state = "zigmaster"

/obj/item/clothing/head/helmet/guardsman/zinger/Initialize()
	. = ..()
	if(GLOB.lordprimary)
		update_icon()

/obj/item/clothing/head/helmet/guardsman/zinger/update_icon()
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

/obj/item/clothing/head/helmet/visored/knight/custknight
	name = "housecarl knight helmet"
	desc = "Robust plated helmet that shields the loyal soul of an coastal guardian. Its visor can be lifted for higher visibility at the cost of eye protection."
	icon = 'modular/kaizoku/icons/clothingicon/head.dmi'
	mob_overlay_icon = 'modular/kaizoku/icons/clothingoldbodies/head64.dmi'
	icon_state = "hfhcustodian"

/obj/item/clothing/head/helmet/visored/knight/custknight/Initialize()
	. = ..()
	if(GLOB.lordprimary)
		update_icon()

/obj/item/clothing/head/helmet/visored/knight/custknight/update_icon()
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

/obj/item/clothing/head/helmet/visored/knight/custknight/custzamurai
	name = "plated zamurai helmet"
	desc = "A plated kabuto to guard the disciplined mind of an honorable Shuhen warrior. Its visor can be removed for higher visibility at the cost of eye protection."
	icon_state = "ffhcustodian"
