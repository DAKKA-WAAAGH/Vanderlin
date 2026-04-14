/turf/closed/wall/mineral/stone/abyssal
	name = "ishigaki wall"
	desc = "Stone locked into stone with pressure alone, each corner interconnected, as wall that shakes yet does not slide will never break like mortar do."
	//icon = 	'modular/kaizoku/icons/tileset/abyssalstone.dmi'
	//icon_state = MAP_SWITCH("abyssal", "abyssal-0")
	icon = 	'modular/kaizoku/icons/tileset/spine_alt.dmi'
	icon_state = MAP_SWITCH("spine", "spine-0")
	sheet_type = /obj/item/natural/stone
	break_sound = 'modular/kaizoku/sound/combat/hits/onstone/stonedeath.ogg'
	attacked_sound = list('modular/kaizoku/sound/combat/hits/onstone/wallhit.ogg', 'modular/kaizoku/sound/combat/hits/onstone/wallhit2.ogg', 'modular/kaizoku/sound/combat/hits/onstone/wallhit3.ogg')
	above_floor = /turf/open/floor/blocks
	baseturfs = list(/turf/open/floor/blocks)
	climbdiff = 1
	damage_deflection = 10

/turf/closed/wall/mineral/stone/abyssal/window
	name = "ishigaki window"
	desc = "A wound upon the wall rimmed into a sacred vacancy, where Abyssor's sigil watches the impure."
	opacity = FALSE
	max_integrity = 800

/turf/closed/wall/mineral/stone/window/CanPass(atom/movable/mover, turf/target)
	if(istype(mover) && ((mover.pass_flags & PASSTABLE) || (mover.pass_flags & PASSGRILLE)) )
		return 1
	return ..()

/turf/closed/wall/mineral/stone/abyssal/window/Initialize()
	. = ..()
	icon_state = "spine"
	var/mutable_appearance/M = mutable_appearance(icon, "spinehole", layer = ABOVE_NORMAL_TURF_LAYER)
	add_overlay(M)

/turf/closed/wall/mineral/stone/abyssal/external
	name = "external ishigaki wall"
	icon = 'modular/kaizoku/icons/tileset/spine.dmi'

/turf/closed/wall/mineral/stone/abyssal/external/window
	opacity = FALSE
	max_integrity = 800

/turf/closed/wall/mineral/stone/abyssal/external/window/CanPass(atom/movable/mover, turf/target)
	if(istype(mover) && ((mover.pass_flags & PASSTABLE) || (mover.pass_flags & PASSGRILLE)) )
		return 1
	return ..()

/turf/closed/wall/mineral/stone/abyssal/external/window/Initialize()
	. = ..()
	icon_state = "spine"
	var/mutable_appearance/M = mutable_appearance(icon, "spinehole", layer = ABOVE_NORMAL_TURF_LAYER)
	add_overlay(M)

/turf/closed/wall/mineral/stone/abyssal/external
	name = "external ishigaki wall"
	icon = 'modular/kaizoku/icons/tileset/spine.dmi'

/turf/closed/wall/mineral/stone/abyssal/external/window
	opacity = FALSE
	max_integrity = 800

/turf/closed/wall/mineral/stone/abyssal/external/window/CanPass(atom/movable/mover, turf/target)
	if(istype(mover) && ((mover.pass_flags & PASSTABLE) || (mover.pass_flags & PASSGRILLE)) )
		return 1
	return ..()

/turf/closed/wall/mineral/stone/abyssal/external/window/Initialize()
	. = ..()
	icon_state = "spine"
	var/mutable_appearance/M = mutable_appearance(icon, "spinehole", layer = ABOVE_NORMAL_TURF_LAYER)
	add_overlay(M)

/turf/closed/wall/mineral/wood/abyssal
	icon_state = "vectorial"
	desc = "Wooden wall of abyssal architecture that uses wooden joinery that fits together seamlessly."
	icon = 	'modular/kaizoku/icons/tileset/vectorial.dmi'
	icon_state = "vectorial"
	break_sound = 'modular/kaizoku/sound/combat/hits/onwood/destroywalldoor.ogg'
	attacked_sound = list('modular/kaizoku/sound/combat/hits/onwood/woodimpact (1).ogg','modular/kaizoku/sound/combat/hits/onwood/woodimpact (2).ogg')
	above_floor = /turf/open/floor/woodturned
	baseturfs = list(/turf/open/floor/woodturned)
	neighborlay = "dirtedge"
	climbdiff = 3

/turf/closed/wall/mineral/wood/abyssal/window
	name = "wagoya no sama"
	desc = "A murderhole on a wooden wall that lacks nails and screws."
	opacity = FALSE
	max_integrity = 550

/turf/closed/wall/mineral/wood/abyssal/window/CanPass(atom/movable/mover, turf/target)
	if(istype(mover) && ((mover.pass_flags & PASSTABLE) || (mover.pass_flags & PASSGRILLE)) )
		return 1
	return ..()

/turf/closed/wall/mineral/wood/abyssal/window/Initialize()
	. = ..()
	var/mutable_appearance/M = mutable_appearance(icon, "vectoryehole", layer = ABOVE_NORMAL_TURF_LAYER)
	add_overlay(M)

/turf/closed/wall/mineral/wood/fractal
	name = "fractal wall"
	desc = "Lattice of recursion intersecting in a fractal geometry, portraying the holy spiral."
	icon = 	'modular/kaizoku/icons/tileset/fractal.dmi'
	icon_state = MAP_SWITCH("fractal", "fractal-0")
	blade_dulling = DULLING_BASHCHOP
	max_integrity = 1100
	break_sound = 'modular/kaizoku/sound/combat/hits/onwood/destroywalldoor.ogg'
	attacked_sound = list('modular/kaizoku/sound/combat/hits/onwood/woodimpact (1).ogg','modular/kaizoku/sound/combat/hits/onwood/woodimpact (2).ogg')
//	sheet_type = /obj/item/grown/log/tree/lumber
	above_floor = /turf/open/floor/ruinedwood
	baseturfs = list(/turf/open/floor/ruinedwood)
	neighborlay = "dirtedge"
	climbdiff = 3
	explosion_block = 4
	hardness = 7

	burn_power = 200
	spread_chance = 0.8

/turf/closed/wall/mineral/wood/fractal/window
	name = "fractal window"
	desc = "Lattice of recursion intersecting in the shape of a opening, showing the symbol of Abyssanctum."
	opacity = FALSE
	max_integrity = 550

/turf/closed/wall/mineral/wood/fractal/window/CanPass(atom/movable/mover, turf/target)
	if(istype(mover) && ((mover.pass_flags & PASSTABLE) || (mover.pass_flags & PASSGRILLE)) )
		return 1
	return ..()

/turf/closed/wall/mineral/wood/fractal/window/Initialize()
	. = ..()
	var/mutable_appearance/M = mutable_appearance(icon, "fractalhole", layer = ABOVE_NORMAL_TURF_LAYER)
	add_overlay(M)

/turf/closed/wall/mineral/stone/gladiatora
	name = "coliseum wall"
	desc = "Sand dunes compacted from consecrated pain. It thirsts not for water, but for blood. FEED IT."
	icon = 	'modular/kaizoku/icons/tileset/gladiatora.dmi'
	icon_state = MAP_SWITCH("gladiatora", "gladiatora-0")
	sheet_type = /obj/item/natural/dirtclod
	break_sound = 'modular/kaizoku/sound/combat/hits/onstone/stonedeath.ogg'
	attacked_sound = list('modular/kaizoku/sound/combat/hits/onstone/wallhit.ogg', 'modular/kaizoku/sound/combat/hits/onstone/wallhit2.ogg', 'modular/kaizoku/sound/combat/hits/onstone/wallhit3.ogg')
	above_floor = /turf/open/floor/blocks
	baseturfs = list(/turf/open/floor/blocks)
	climbdiff = 0
	damage_deflection = 10

/turf/closed/wall/mineral/stone/gladiatora/window
	name = "coliseum window"
	desc = "A wound upon the compacted dunes. ARE YOU NOT ENTERTAINED?"
	opacity = FALSE
	max_integrity = 800

/turf/closed/wall/mineral/stone/gladiatora/CanPass(atom/movable/mover, turf/target)
	if(istype(mover) && ((mover.pass_flags & PASSTABLE) || (mover.pass_flags & PASSGRILLE)) )
		return 1
	return ..()

/turf/closed/wall/mineral/stone/gladiatora/window/Initialize()
	. = ..()
	var/mutable_appearance/M = mutable_appearance(icon, "gladiatorahole", layer = ABOVE_NORMAL_TURF_LAYER)
	add_overlay(M)

