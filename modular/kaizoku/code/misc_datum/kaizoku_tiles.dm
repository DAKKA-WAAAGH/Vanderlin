/turf/open/floor/fogsand
	icon = 'modular/stonekeep/icons/turfs.dmi'
	icon_state = "sand"
	footstep = FOOTSTEP_SAND
	barefootstep = FOOTSTEP_SOFT_BAREFOOT
	clawfootstep = FOOTSTEP_SAND
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY
	smoothing_flags = SMOOTH_EDGE
	smoothing_groups = SMOOTH_GROUP_OPEN_FLOOR + SMOOTH_GROUP_FLOOR_STONE + SMOOTH_GROUP_FLOOR_GRASS
	smoothing_list = SMOOTH_GROUP_FLOOR_DIRT_ROAD
	landsound = 'modular/kaizoku/sound/foley/jumpland/dirtland.ogg'
	neighborlay = "sandedge"

/turf/open/floor/fogsand/Initialize()
	dir = pick(GLOB.cardinals)
	. = ..()

/turf/open/floor/kaizocobble
	icon = 'modular/kaizoku/icons/mapset/kaizoku_tiles.dmi'
	icon_state = "kaizocobble1"
	footstep = FOOTSTEP_STONE
	barefootstep = FOOTSTEP_HARD_BAREFOOT
	clawfootstep = FOOTSTEP_HARD_CLAW
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY
	landsound = 'modular/kaizoku/sound/foley/jumpland/stoneland.ogg'
	smoothing_flags = SMOOTH_EDGE
	smoothing_groups = SMOOTH_GROUP_OPEN_FLOOR + SMOOTH_GROUP_FLOOR_STONE
	smoothing_list = SMOOTH_GROUP_FLOOR_DIRT_ROAD + SMOOTH_GROUP_FLOOR_GRASS
	neighborlay = "kaizocobbleedge"
	max_integrity = 1200

/turf/open/floor/kaizocobble/atom_destruction(damage_flag)
	. = ..()
	ChangeTurf(/turf/open/floor/dirt, flags = CHANGETURF_INHERIT_AIR)
	new /obj/item/natural/stone(src)

/turf/open/floor/kaizocobble/Initialize()
	. = ..()
	icon_state = "kaizocobble[rand(1,3)]"

/turf/open/floor/grass/fogfluff
	name = "fogfluffier tall"
	desc = "hetehehe, pepee."
	icon_state = "pufftile_tall1"
	neighborlay = "pufftile_small1edge"
	footstep = FOOTSTEP_GRASS
	barefootstep = FOOTSTEP_SOFT_BAREFOOT
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY
	landsound = 'modular/kaizoku/sound/foley/jumpland/grassland.ogg'
	slowdown = 0
	icon = 'modular/kaizoku/icons/mapset/kaizoku_pufftiles.dmi'
	smoothing_flags = SMOOTH_EDGE
	smoothing_groups = SMOOTH_GROUP_OPEN_FLOOR + SMOOTH_GROUP_FLOOR_STONE + SMOOTH_GROUP_FLOOR_GRASS
	smoothing_list = SMOOTH_GROUP_FLOOR_DIRT_ROAD
	max_integrity = 1200
	spread_chance = 2
	burn_power = 10

/turf/open/floor/grass/fogfluff/small
	name = "fogfluff"
	desc = "Remember Monochrome to change the name and description of this."
	icon_state = "pufftile_small1"
	neighborlay = "pufftile_small1edge"

/turf/open/floor/grass/fogfluff/small/Initialize()
	. = ..()
	icon_state = "[icon_state]_[rand(1,4)]"

/turf/open/floor/grass/fogfluff/medium
	name = "fogfluffer"
	desc = "hetehehe, pepee."
	icon_state = "pufftile_medium1"
	neighborlay = "pufftile_small1edge"

/turf/open/floor/grass/fogfluff/medium
	name = "fogfluffer"
	desc = "hetehehe, pepee."
	icon_state = "pufftile_medium1"
	neighborlay = "pufftile_small1edge"

/turf/open/floor/grass/fogfluff/tall
	name = "fogfluffier tall"
	desc = "hetehehe, pepee."
	icon_state = "pufftile_tall1"
	neighborlay = "pufftile_small1edge"

/turf/open/floor/grass/fogfluff/trimmed
	name = "fogfluffier trimmed"
	desc = "hetehehe, pepee."
	icon_state = "pufftile_trimmed1"
	neighborlay = "pufftile_small1edge"

/turf/open/floor/grass/fogfluff/trimmed/Initialize()
	. = ..()
	icon_state = "[icon_state]_[rand(1,4)]"

/turf/open/floor/grass/fogfluff/dark
	name = "fogfluffier dark"
	desc = "hetehehe, pepee."
	icon_state = "grasstide_1"
	neighborlay = "pufftile_small1edge"

/turf/open/floor/grass/fogfluff/dark/Initialize()
	. = ..()
	icon_state = "[icon_state]_[rand(1,4)]"

/turf/open/floor/grass/fogfluff/small_green
	name = "fogfluff green"
	desc = "Remember Monochrome to change the name and description of this."
	icon_state = "gpufftile_small1"
	neighborlay = "gpufftile_small1edge"
	smoothing_groups = SMOOTH_GROUP_OPEN_FLOOR + SMOOTH_GROUP_FLOOR_STONE

/turf/open/floor/grass/fogfluff/small_green/Initialize()
	. = ..()
	icon_state = "[icon_state]_[rand(1,4)]"

/turf/open/floor/grass/fogfluff/medium_green
	name = "fogfluffer green"
	desc = "hetehehe, pepee."
	icon_state = "gpufftile_medium1"
	neighborlay = "gpufftile_small1edge"
	smoothing_groups = SMOOTH_GROUP_OPEN_FLOOR + SMOOTH_GROUP_FLOOR_STONE

/turf/open/floor/grass/fogfluff/tall_green
	name = "fogfluffier tall green"
	desc = "hetehehe, pepee."
	icon_state = "gpufftile_tall1"
	neighborlay = "gpufftile_small1edge"
	smoothing_groups = SMOOTH_GROUP_OPEN_FLOOR + SMOOTH_GROUP_FLOOR_STONE

/turf/open/floor/grass/fogfluff/trimmed_green
	name = "fogfluffier trimmed green"
	desc = "hetehehe, pepee."
	icon_state = "gpufftile_trimmed1"
	neighborlay = "gpufftile_small1edge"
	smoothing_groups = SMOOTH_GROUP_OPEN_FLOOR + SMOOTH_GROUP_FLOOR_STONE

/turf/open/floor/grass/fogfluff/trimmed_green/Initialize()
	. = ..()
	icon_state = "[icon_state]_[rand(1,4)]"

/turf/open/floor/grass/fogfluff/dark_green
	name = "fogfluffier dark green"
	desc = "hetehehe, pepee."
	icon_state = "ggrasstide_1"
	neighborlay = "gpufftile_small1edge"
	smoothing_groups = SMOOTH_GROUP_OPEN_FLOOR + SMOOTH_GROUP_FLOOR_STONE

/turf/open/floor/grass/fogfluff/dark_green/Initialize()
	. = ..()
	icon_state = "[icon_state]_[rand(1,4)]"

/turf/open/floor/grass/fogfluff/small_blue
	name = "fogfluff blue"
	desc = "Remember Monochrome to change the name and description of this."
	icon_state = "bpufftile_small1"
	neighborlay = "bpufftile_small1edge"
	smoothing_groups = SMOOTH_GROUP_OPEN_FLOOR + SMOOTH_GROUP_FLOOR_STONE

/turf/open/floor/grass/fogfluff/small_blue/Initialize()
	. = ..()
	icon_state = "[icon_state]_[rand(1,4)]"

/turf/open/floor/grass/fogfluff/medium_blue
	name = "fogfluffer blue"
	desc = "hetehehe, pepee."
	icon_state = "bpufftile_medium1"
	neighborlay = "bpufftile_small1edge"
	smoothing_groups = SMOOTH_GROUP_OPEN_FLOOR + SMOOTH_GROUP_FLOOR_STONE

/turf/open/floor/grass/fogfluff/tall_blue
	name = "fogfluffier tall blue"
	desc = "hetehehe, pepee."
	icon_state = "bpufftile_tall1"
	neighborlay = "bpufftile_small1edge"
	smoothing_groups = SMOOTH_GROUP_OPEN_FLOOR + SMOOTH_GROUP_FLOOR_STONE

/turf/open/floor/grass/fogfluff/trimmed_blue
	name = "fogfluffier trimmed blue"
	desc = "hetehehe, pepee."
	icon_state = "bpufftile_trimmed1"
	neighborlay = "bpufftile_small1edge"
	smoothing_groups = SMOOTH_GROUP_OPEN_FLOOR + SMOOTH_GROUP_FLOOR_STONE

/turf/open/floor/grass/fogfluff/trimmed_blue/Initialize()
	. = ..()
	icon_state = "[icon_state]_[rand(1,4)]"

/turf/open/floor/grass/fogfluff/dark_blue
	name = "fogfluffier dark blue"
	desc = "hetehehe, pepee."
	icon_state = "bgrasstide_1"
	neighborlay = "bpufftile_small1edge"
	smoothing_groups = SMOOTH_GROUP_OPEN_FLOOR + SMOOTH_GROUP_FLOOR_STONE

/turf/open/floor/grass/fogfluff/dark_blue/Initialize()
	. = ..()
	icon_state = "[icon_state]_[rand(1,4)]"

// This is Zion's plants. If used on another server, request/credit Zion362.
#define ZION_FRONT SOUTH
#define ZION_BACK  NORTH
#define ZION_BASE_LAYER (BELOW_MOB_LAYER - 0.05) //This remains below mobs.

/obj/effect/ziongrass_cover //This is a self-cleaning cover effect.
	name = ""
	desc = ""
	anchored = TRUE
	density = FALSE
	layer = ABOVE_MOB_LAYER
	plane = GAME_PLANE_UPPER
	mouse_opacity = 0
	appearance_flags = PIXEL_SCALE | KEEP_TOGETHER
	var/overlay_icon = null
	var/overlay_state_front = "overlay_state_front"
	var/overlay_state_back  = "overlay_state_back"
	var/has_back_overlay = FALSE
	var/cover_jitter = 1
	var/linger = 6
	var/occupants = 0 //Runtime fixin'
	var/last_frontmost = null

/obj/effect/ziongrass_cover/proc/arm_poll()
	if(QDELETED(src))
		return
	addtimer(CALLBACK(src, PROC_REF(poll)), 3)

/obj/effect/ziongrass_cover/Destroy()
	. = ..()

/obj/effect/ziongrass_cover/proc/on_enter()
	occupants ++
	UpdateAppearance()
	Jiggle()

/obj/effect/ziongrass_cover/proc/on_exit()
	if(occupants > 0)
		occupants --
	if(occupants <= 0)
		addtimer(CALLBACK(src, PROC_REF(try_clear)), linger)

/obj/effect/ziongrass_cover/proc/try_clear()
	if(occupants <= 0)
		qdel(src)

/obj/effect/ziongrass_cover/proc/poll()
	if(occupants > 0)
		UpdateAppearance()
	arm_poll() //It will rearm regardless.

/obj/effect/ziongrass_cover/Initialize()
	. = ..()
	arm_poll()

/obj/structure/flora/ziongrass/Destroy()
	var/list/neighbors = list()
	for(var/d in list(ZION_FRONT, ZION_BACK))
		var/obj/structure/flora/ziongrass/Z = GetZionInDir(d)
		if(Z)
			neighbors += Z
	var/obj/effect/ziongrass_cover/C = FindCover() //Remove any active cover on this turf.
	if(C)
		qdel(C)

	var/turf/T = get_turf(src) //Unregister tile as exit signals.
	if(T)
		UnregisterSignal(T, COMSIG_TURF_ENTERED)
		UnregisterSignal(T, COMSIG_TURF_EXITED)

	for(var/obj/structure/flora/ziongrass/N in neighbors) //Refresh
		if(!QDELETED(N))
			N.RefreshSeam()
	for(var/obj/structure/flora/ziongrass/N in neighbors)
		if(!QDELETED(N))
			addtimer(CALLBACK(N, PROC_REF(RefreshSeam)), 1)
	return ..()

/obj/effect/ziongrass_cover/proc/Frontmostboy() //Refreshing local tiles. Check if there is any ziongrass the south.
	var/turf/T = loc
	if(!T)
		return TRUE
	var/turf/front = get_step(T, ZION_FRONT)
	if(!front)
		return TRUE
	return (locate(/obj/structure/flora/ziongrass) in front) ? FALSE : TRUE

/obj/effect/ziongrass_cover/proc/UpdateAppearance()
	var/is_front = Frontmostboy()
	if(last_frontmost == is_front && icon)
		return
	last_frontmost = is_front

	icon = overlay_icon
	if(is_front)
		icon_state = overlay_state_front
	else
		icon_state = has_back_overlay ? overlay_state_back : overlay_state_front

/obj/effect/ziongrass_cover/proc/Jiggle() //hehe jiggle my obols
	var/ox = pixel_x
	animate(src, pixel_x = ox + cover_jitter, time = 0.5)
	animate(pixel_x = ox - cover_jitter, time = 0.5)
	animate(pixel_x = ox, time = 0.5)

/obj/structure/flora/ziongrass
	name = "Zion grass" //Direct reference to zion362; Credits to the spriter.
	desc = "One of the 362 species of tall grass from Fog Islands. Used by ambushers." //Reference to the '362' from Zion's username.
	icon = 'modular/kaizoku/icons/zionwork/tileset.dmi'
	icon_state = "ziongrass"
	anchored = TRUE
	density = FALSE
	max_integrity = 25 //Tougher to slice. Just like Zion, maybe.
	attacked_sound = "plantcross"
	destroy_sound = "plantcross"
	debris = list(/obj/item/natural/fibers = 2)

	var/overlay_icon = 'modular/kaizoku/icons/zionwork/tileset.dmi'
	var/overlay_state_front = "overlay_state_front"
	var/overlay_state_back  = "overlay_state_back"
	var/cover_linger = 6
	var/cover_jitter = 1

/obj/structure/flora/ziongrass/Initialize()
	. = ..()
	layer = ZION_BASE_LAYER + (y * 0.0001)
	AddComponent(/datum/component/stepping_on_zion)
	var/turf/T = get_turf(src) //This registers the existing or entering of a player on te turf.
	if(T)
		RegisterSignal(T, COMSIG_TURF_ENTERED, PROC_REF(entered))
		RegisterSignal(T, COMSIG_TURF_EXITED, PROC_REF(exited))

	RefreshSeam()
	NotifyNeighbors()

/obj/structure/flora/ziongrass/Destroy()
	var/turf/T = get_turf(src)
	if(T)
		UnregisterSignal(T, COMSIG_TURF_ENTERED)
		UnregisterSignal(T, COMSIG_TURF_EXITED)
	NotifyNeighbors()
	return ..()

/obj/structure/flora/ziongrass/proc/RefreshSeam()
	var/has_front = HasZionInDir(ZION_FRONT)
	var/has_back  = HasZionInDir(ZION_BACK)
	if(has_front)
		icon_state = has_back ? "ziongrass_seamlesshead" : "ziongrass_seamlessend"
	else
		icon_state = has_back ? "ziongrass_seamless" : "ziongrass"

	// If there is an active cover on this turf, make it refresh now
	var/obj/effect/ziongrass_cover/C = FindCover()
	if(C) C.UpdateAppearance()

/obj/structure/flora/ziongrass/proc/NotifyNeighbors()
	for(var/d in list(ZION_FRONT, ZION_BACK))
		var/obj/structure/flora/ziongrass/Z = GetZionInDir(d)
		if(Z) Z.RefreshSeam()

/obj/structure/flora/ziongrass/proc/GetZionInDir(d)
	var/turf/T = get_step(src, d)
	if(!T)
		return null
	return locate(/obj/structure/flora/ziongrass) in T

/obj/structure/flora/ziongrass/proc/HasZionInDir(d)
	return !!GetZionInDir(d)

/obj/structure/flora/ziongrass/proc/FindCover()
	var/turf/T = get_turf(src)
	if(!T)
		return null
	return locate(/obj/effect/ziongrass_cover) in T

/obj/structure/flora/ziongrass/proc/GetOrCreateCover()
	var/obj/effect/ziongrass_cover/C = FindCover()
	if(C)
		return C

	var/turf/T = get_turf(src)
	if(!T)
		return null
	C = new /obj/effect/ziongrass_cover(T)
	C.overlay_icon = overlay_icon
	C.overlay_state_front = overlay_state_front
	C.overlay_state_back = overlay_state_back
	C.cover_jitter = cover_jitter
	C.linger = cover_linger //First, validates if the BACK OVERLAY exists before trying to use it.
	var/list/ov = icon_states(C.overlay_icon)
	C.has_back_overlay = (C.overlay_state_back in ov)
	C.UpdateAppearance()
	return C

/obj/structure/flora/ziongrass/proc/entered(turf/T, atom/movable/AM)
	SIGNAL_HANDLER
	if(!isliving(AM))
		return
	if(get_turf(AM) != get_turf(src))
		return
	var/obj/effect/ziongrass_cover/C = GetOrCreateCover()
	if(C)
		C.on_enter()

/obj/structure/flora/ziongrass/proc/exited(turf/T, atom/movable/AM)
	SIGNAL_HANDLER
	if(!isliving(AM))
		return
	var/obj/effect/ziongrass_cover/C = FindCover()
	if(C)
		C.on_exit()

/datum/component/stepping_on_zion //This rustles my jimmies. Haha. Sorry Zion, but I had to.
/datum/component/stepping_on_zion/Initialize()
	. = ..()
	RegisterSignal(parent, list(COMSIG_MOVABLE_CROSSED), PROC_REF(Crossed))

/datum/component/stepping_on_zion/proc/Crossed(datum/source, atom/movable/AM)
	var/obj/structure/flora/ziongrass/G = source
	if(!G || QDELETED(G))
		return
	if(!isliving(AM))
		return
	playsound(G.loc, "plantcross", 90, FALSE, -1)
	var/ox = G.pixel_x
	animate(G, pixel_x = ox+1, time = 0.5)
	animate(pixel_x = ox-1, time = 0.5)
	animate(pixel_x = ox,   time = 0.5)

	// If there’s an active cover, give it a little jiggle
	var/obj/effect/ziongrass_cover/C = G.FindCover()
	if(C)
		C.Jiggle()

/turf/open/floor/wood/kaizocobble
	icon = 'modular/kaizoku/icons/mapset/kaizoku_tiles.dmi'
	icon_state = "kaizocobble1"
	footstep = FOOTSTEP_STONE
	barefootstep = FOOTSTEP_HARD_BAREFOOT
	clawfootstep = FOOTSTEP_HARD_CLAW
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY
	landsound = 'modular/kaizoku/sound/foley/jumpland/stoneland.ogg'
	smoothing_flags = SMOOTH_EDGE
	smoothing_groups = SMOOTH_GROUP_OPEN_FLOOR + SMOOTH_GROUP_FLOOR_STONE
	smoothing_list = SMOOTH_GROUP_FLOOR_DIRT_ROAD + SMOOTH_GROUP_FLOOR_GRASS
	neighborlay = "kaizocobbleedge"
	max_integrity = 1200

/turf/open/floor/kaizocobble/atom_destruction(damage_flag)
	. = ..()
	ChangeTurf(/turf/open/floor/dirt, flags = CHANGETURF_INHERIT_AIR)
	new /obj/item/natural/stone(src)

/turf/open/floor/abyssplate
	icon = 'modular/kaizoku/icons/mapset/kaizoku_tiles.dmi'
	icon_state = "abyssplate"
	footstep = FOOTSTEP_STONE
	barefootstep = FOOTSTEP_HARD_BAREFOOT
	clawfootstep = FOOTSTEP_HARD_CLAW
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY
	landsound = 'modular/kaizoku/sound/foley/jumpland/stoneland.ogg'

/turf/open/floor/abyssflax
	icon = 'modular/kaizoku/icons/mapset/kaizoku_tiles.dmi'
	icon_state = "abyssflax"
	footstep = FOOTSTEP_STONE
	barefootstep = FOOTSTEP_HARD_BAREFOOT
	clawfootstep = FOOTSTEP_HARD_CLAW
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY
	landsound = 'modular/kaizoku/sound/foley/jumpland/stoneland.ogg'

/turf/open/floor/abyssflax_alt
	icon = 'modular/kaizoku/icons/mapset/kaizoku_tiles.dmi'
	icon_state = "abyssflax1"
	footstep = FOOTSTEP_STONE
	barefootstep = FOOTSTEP_HARD_BAREFOOT
	clawfootstep = FOOTSTEP_HARD_CLAW
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY
	landsound = 'modular/kaizoku/sound/foley/jumpland/stoneland.ogg'

/turf/open/floor/stonechis
	icon = 'modular/kaizoku/icons/mapset/kaizoku_tiles.dmi'
	icon_state = "stonechis1"
	footstep = FOOTSTEP_STONE
	barefootstep = FOOTSTEP_HARD_BAREFOOT
	clawfootstep = FOOTSTEP_HARD_CLAW
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY
	landsound = 'modular/kaizoku/sound/foley/jumpland/stoneland.ogg'

/turf/open/floor/stonegrate
	icon = 'modular/kaizoku/icons/mapset/kaizoku_tiles.dmi'
	icon_state = "stonegrate_open"
	footstep = FOOTSTEP_STONE
	barefootstep = FOOTSTEP_HARD_BAREFOOT
	clawfootstep = FOOTSTEP_HARD_CLAW
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY
	landsound = 'modular/kaizoku/sound/foley/jumpland/stoneland.ogg'

/turf/open/floor/stonegrate_close
	icon = 'modular/kaizoku/icons/mapset/kaizoku_tiles.dmi'
	icon_state = "stonegrate_close"
	footstep = FOOTSTEP_STONE
	barefootstep = FOOTSTEP_HARD_BAREFOOT
	clawfootstep = FOOTSTEP_HARD_CLAW
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY
	landsound = 'modular/kaizoku/sound/foley/jumpland/stoneland.ogg'

/turf/open/floor/starslab
	icon = 'modular/kaizoku/icons/mapset/kaizoku_tiles.dmi'
	icon_state = "starslab"
	footstep = FOOTSTEP_STONE
	barefootstep = FOOTSTEP_HARD_BAREFOOT
	clawfootstep = FOOTSTEP_HARD_CLAW
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY
	landsound = 'modular/kaizoku/sound/foley/jumpland/stoneland.ogg'

/turf/open/floor/quintessential
	icon = 'modular/kaizoku/icons/mapset/kaizoku_tiles.dmi'
	icon_state = "quintessential"
	footstep = FOOTSTEP_STONE
	barefootstep = FOOTSTEP_HARD_BAREFOOT
	clawfootstep = FOOTSTEP_HARD_CLAW
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY
	landsound = 'modular/kaizoku/sound/foley/jumpland/stoneland.ogg'

/turf/open/floor/petrichor
	icon = 'modular/kaizoku/icons/mapset/kaizoku_tiles.dmi'
	icon_state = "petrichor"
	footstep = FOOTSTEP_STONE
	barefootstep = FOOTSTEP_HARD_BAREFOOT
	clawfootstep = FOOTSTEP_HARD_CLAW
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY
	landsound = 'modular/kaizoku/sound/foley/jumpland/stoneland.ogg'

/turf/open/floor/syzygy
	icon = 'modular/kaizoku/icons/mapset/kaizoku_tiles.dmi'
	icon_state = "syzygy"
	footstep = FOOTSTEP_STONE
	barefootstep = FOOTSTEP_HARD_BAREFOOT
	clawfootstep = FOOTSTEP_HARD_CLAW
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY
	landsound = 'modular/kaizoku/sound/foley/jumpland/stoneland.ogg'

/turf/open/floor/bricketts
	icon = 'modular/kaizoku/icons/mapset/kaizoku_tiles.dmi'
	icon_state = "bricketts"
	footstep = FOOTSTEP_STONE
	barefootstep = FOOTSTEP_HARD_BAREFOOT
	clawfootstep = FOOTSTEP_HARD_CLAW
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY
	landsound = 'modular/kaizoku/sound/foley/jumpland/stoneland.ogg'

/turf/open/floor/reverted_bricks
	icon = 'modular/kaizoku/icons/mapset/kaizoku_tiles.dmi'
	icon_state = "reverted_bricks"
	footstep = FOOTSTEP_STONE
	barefootstep = FOOTSTEP_HARD_BAREFOOT
	clawfootstep = FOOTSTEP_HARD_CLAW
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY
	landsound = 'modular/kaizoku/sound/foley/jumpland/stoneland.ogg'

/turf/open/floor/abyssplate_dworf
	icon = 'modular/kaizoku/icons/mapset/kaizoku_tiles.dmi'
	icon_state = "abyssplate_dworf"
	footstep = FOOTSTEP_STONE
	barefootstep = FOOTSTEP_HARD_BAREFOOT
	clawfootstep = FOOTSTEP_HARD_CLAW
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY
	landsound = 'modular/kaizoku/sound/foley/jumpland/stoneland.ogg'

/turf/open/floor/ornabyss
	icon = 'modular/kaizoku/icons/mapset/kaizoku_tiles.dmi'
	icon_state = "ornabyss"
	neighborlay = "ornabyssedge"
	footstep = FOOTSTEP_STONE
	barefootstep = FOOTSTEP_HARD_BAREFOOT
	clawfootstep = FOOTSTEP_HARD_CLAW
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY
	landsound = 'modular/kaizoku/sound/foley/jumpland/stoneland.ogg'
	smoothing_flags = SMOOTH_EDGE
	smoothing_groups = SMOOTH_GROUP_OPEN_FLOOR


/turf/open/floor/ornaciv
	icon = 'modular/kaizoku/icons/mapset/kaizoku_tiles.dmi'
	icon_state = "ornaciv"
	neighborlay = "ornacivedge"
	footstep = FOOTSTEP_STONE
	barefootstep = FOOTSTEP_HARD_BAREFOOT
	clawfootstep = FOOTSTEP_HARD_CLAW
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY
	landsound = 'modular/kaizoku/sound/foley/jumpland/stoneland.ogg'
	smoothing_flags = SMOOTH_EDGE
	smoothing_groups = SMOOTH_GROUP_OPEN_FLOOR


/turf/open/floor/civnorm
	icon = 'modular/kaizoku/icons/mapset/kaizoku_tiles.dmi'
	icon_state = "civnorm"
	neighborlay = "civnormedge"
	footstep = FOOTSTEP_STONE
	barefootstep = FOOTSTEP_HARD_BAREFOOT
	clawfootstep = FOOTSTEP_HARD_CLAW
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY
	landsound = 'modular/kaizoku/sound/foley/jumpland/stoneland.ogg'
	smoothing_flags = SMOOTH_EDGE
	smoothing_groups = SMOOTH_GROUP_OPEN_FLOOR

/turf/open/floor/hardwood
	icon = 'modular/kaizoku/icons/mapset/kaizoku_tiles.dmi'
	icon_state = "hardwood"
	neighborlay = "woodedge"
	footstep = FOOTSTEP_WOOD
	barefootstep = FOOTSTEP_HARD_BAREFOOT
	clawfootstep = FOOTSTEP_WOOD_CLAW
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY
	landsound = 'modular/kaizoku/sound/foley/jumpland/woodland.ogg'
	smoothing_flags = SMOOTH_EDGE
	smoothing_groups = SMOOTH_GROUP_OPEN_FLOOR + SMOOTH_GROUP_FLOOR_STONE + SMOOTH_GROUP_FLOOR_WOOD
	smoothing_list = SMOOTH_GROUP_FLOOR_DIRT_ROAD + SMOOTH_GROUP_FLOOR_GRASS

/turf/open/floor/kaizowood
	icon = 'modular/kaizoku/icons/mapset/kaizoku_tiles.dmi'
	icon_state = "wood"
	neighborlay = "woodedge"
	footstep = FOOTSTEP_WOOD
	barefootstep = FOOTSTEP_HARD_BAREFOOT
	clawfootstep = FOOTSTEP_WOOD_CLAW
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY
	landsound = 'modular/kaizoku/sound/foley/jumpland/woodland.ogg'
	smoothing_flags = SMOOTH_EDGE
	smoothing_groups = SMOOTH_GROUP_OPEN_FLOOR + SMOOTH_GROUP_FLOOR_STONE + SMOOTH_GROUP_FLOOR_WOOD
	smoothing_list = SMOOTH_GROUP_FLOOR_DIRT_ROAD + SMOOTH_GROUP_FLOOR_GRASS

/turf/open/floor/shitwood
	icon = 'modular/kaizoku/icons/mapset/kaizoku_tiles.dmi'
	icon_state = "shitwood"
	neighborlay = "woodedge"
	footstep = FOOTSTEP_WOOD
	barefootstep = FOOTSTEP_HARD_BAREFOOT
	clawfootstep = FOOTSTEP_WOOD_CLAW
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY
	landsound = 'modular/kaizoku/sound/foley/jumpland/woodland.ogg'
	smoothing_flags = SMOOTH_EDGE
	smoothing_groups = SMOOTH_GROUP_OPEN_FLOOR + SMOOTH_GROUP_FLOOR_STONE + SMOOTH_GROUP_FLOOR_WOOD
	smoothing_list = SMOOTH_GROUP_FLOOR_DIRT_ROAD + SMOOTH_GROUP_FLOOR_GRASS

/turf/open/floor/tatami
	icon = 'modular/kaizoku/icons/mapset/kaizoku_tiles.dmi'
	icon_state = "tatami"
	neighborlay = "woodedge"
	footstep = FOOTSTEP_TATAMI
	barefootstep = FOOTSTEP_HARD_BAREFOOT
	clawfootstep = FOOTSTEP_HARD_CLAW
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY
	landsound = 'modular/kaizoku/sound/foley/jumpland/woodland.ogg'
	smoothing_flags = SMOOTH_EDGE
	smoothing_groups = SMOOTH_GROUP_OPEN_FLOOR + SMOOTH_GROUP_FLOOR_STONE + SMOOTH_GROUP_FLOOR_WOOD
	smoothing_list = SMOOTH_GROUP_FLOOR_DIRT_ROAD + SMOOTH_GROUP_FLOOR_GRASS

/turf/open/floor/abyssplate_chis
	icon = 'modular/kaizoku/icons/mapset/kaizoku_tiles.dmi'
	footstep = FOOTSTEP_STONE
	barefootstep = FOOTSTEP_HARD_BAREFOOT
	clawfootstep = FOOTSTEP_HARD_CLAW
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY
	landsound = 'modular/kaizoku/sound/foley/jumpland/stoneland.ogg'

/turf/open/floor/abyssplate_chis/Initialize()
	. = ..()
	icon_state = "abyssplate_chis[rand(1,5)]"

/turf/open/floor/stonechis
	icon = 'modular/kaizoku/icons/mapset/kaizoku_tiles.dmi'
	footstep = FOOTSTEP_STONE
	barefootstep = FOOTSTEP_HARD_BAREFOOT
	clawfootstep = FOOTSTEP_HARD_CLAW
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY
	landsound = 'modular/kaizoku/sound/foley/jumpland/stoneland.ogg'

/turf/open/floor/stonechis/Initialize()
	. = ..()
	icon_state = "stonechis[rand(1,7)]"

/turf/open/floor/stoneslab
	icon = 'modular/kaizoku/icons/mapset/kaizoku_tiles.dmi'
	footstep = FOOTSTEP_STONE
	barefootstep = FOOTSTEP_HARD_BAREFOOT
	clawfootstep = FOOTSTEP_HARD_CLAW
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY
	landsound = 'modular/kaizoku/sound/foley/jumpland/stoneland.ogg'

/turf/open/floor/stoneslab/Initialize()
	. = ..()
	icon_state = "stoneslab[rand(1,4)]"
