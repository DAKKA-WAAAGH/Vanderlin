
/obj/item/clothing/neck/chaincoif/karuta_zukin
	name = "foldable lamellae hood"
	desc = "The 'Karuta Zukin', a protective hood composed of rectangular plates sewn onto a fabric backing, offering a more solid \
	defense while remaining flexible."
	icon_state = "karuta_zukin"
	item_state = "karuta_zukin"
	icon = 'modular/kaizoku/icons/clothingicon/neck.dmi'
	mob_overlay_icon = 'modular/kaizoku/icons/clothing/neck.dmi'

/obj/item/clothing/neck/chaincoif/karuta_zukin/random/Initialize()
	. = ..()
	color = pick("#a32121", "#8747b1", "#3d3a36", "#414143", "#685542", "#428138", "#264d26", "#537bc6", "#b5b004", "#249589", "#ffffff", "#bd6606", "#962e5c")

/obj/item/clothing/neck/chaincoif/karuta_zukin/military/Initialize()
	. = ..()
	color = pick("#534b40", "#685542", "#264d26")

/obj/item/clothing/neck/chaincoif/karuta_zukin/kabukimono/Initialize()
	. = ..()
	color = "#9b874f"

/obj/item/clothing/neck/chaincoif/iron/kusari_zukin
	name = "iron kusari zukin"
	desc = "A hood made of riveted iron rings usually worn beneath or alongside a Kabuto. \
	It protects against cuts and slashes - but cannot spread blunt damage as efficiently."
	icon_state = "kusari_zukin"
	icon = 'modular/kaizoku/icons/clothingicon/neck.dmi'
	mob_overlay_icon = 'modular/kaizoku/icons/clothing/neck.dmi'
	detail_tag = "_det"

/obj/item/clothing/neck/psycross/silver/abyssanctum
	name = "trinomial anchor"
	desc = "Despair thee not at the abyssal depths, for where light doth fade, vessels of might shall be therein carved, as Abyssor guide their own."
	icon = 'modular/kaizoku/icons/clothingicon/neck.dmi'
	mob_overlay_icon = 'modular/kaizoku/icons/clothing/neck.dmi'
	icon_state = "abyssanctum"
	resistance_flags = FIRE_PROOF
	slot_flags = ITEM_SLOT_NECK|ITEM_SLOT_HIP|ITEM_SLOT_WRISTS

/obj/item/clothing/neck/mercmedal/toweryakko
	name = "soul compressor"
	desc = "A metallic device of Tower-Yakko legacy used to shackle criminal souls and demons to eternity. The once-feared power ceased when Tower-Yakko's moral decay led to their disgrace in the eyes of the emperor. "
	icon = 'modular/kaizoku/icons/clothingicon/neck.dmi'
	mob_overlay_icon = 'modular/kaizoku/icons/clothing/neck.dmi'
	icon_state = "soul_compressor"

/obj/item/clothing/neck/mercmedal/kabukimaru
	name = "hihiirokane beads"
	desc = "Hihiirokane, or 'Mythril', is a luminous, rare metal drawn from the abyssal depths where the pressure is hostile to most life. The Abyssariads holds the key to its mystery, a secret that dwarves would covet at any cost."
	icon = 'modular/kaizoku/icons/clothingicon/neck.dmi'
	mob_overlay_icon = 'modular/kaizoku/icons/clothing/neck.dmi'
	icon_state = "mythrilbeads"
