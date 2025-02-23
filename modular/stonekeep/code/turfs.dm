/* * * * * * * * * * * **
 *						*
 *		 Turfs			*
 *						*
 *						*
 * * * * * * * * * * * **/


/*--------------\
| Better Floors |
\--------------*/

/turf/open/floor/rogue/wood
	smooth_icon = 'modular/stonekeep/icons/wood.dmi'
/turf/open/floor/rogue/wood/nosmooth
	smooth_icon = 'modular/stonekeep/icons/wood.dmi'

/turf/open/floor/rogue/woodturned
	smooth_icon = 'modular/stonekeep/icons/wood_turned.dmi'
/turf/open/floor/rogue/woodturned/nosmooth/saiga
	smooth_icon = 'modular/stonekeep/icons/wood_turned.dmi'

/turf/open/floor/rogue/hexstone
	icon = 'modular/stonekeep/icons/turfs.dmi'

/turf/open/floor/rogue/cobble
	icon = 'modular/stonekeep/icons/turfs.dmi'

/turf/open/floor/rogue/herringbone
	icon = 'modular/stonekeep/icons/turfs.dmi'

/turf/open/floor/rogue/carpet/green
	icon = 'modular/stonekeep/icons/turfs.dmi'

/turf/open/floor/rogue/cobblerock/alt
	icon_state = "cobblerock_alt"
	icon = 'modular/stonekeep/icons/turfs.dmi'
	neighborlay = "cobblerock_alt"

/turf/open/floor/rogue/cobblerock/red
	icon = 'modular/stonekeep/icons/turfs.dmi'
	icon_state = "cobblerock_red"
	neighborlay = "cobblerock_red"



/turf/open/floor/rogue/cobblerock/cardinal_smooth(adjacencies)
	roguesmooth(adjacencies)

/turf/open/floor/rogue/cobble/mossy/Initialize()
	. = ..()
	dir = pick(GLOB.cardinals)

/turf/open/floor/rogue/sandstone
	icon = 'modular/stonekeep/icons/turfs.dmi'
	icon_state = "sandstone"
	footstep = FOOTSTEP_STONE
	barefootstep = FOOTSTEP_HARD_BAREFOOT
	clawfootstep = FOOTSTEP_HARD_CLAW
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY
	landsound = 'sound/foley/jumpland/stoneland.wav'
	smooth = SMOOTH_MORE
	canSmoothWith = list(/turf/closed/mineral/rogue,
						/turf/open/floor/rogue/herringbone,
						/turf/closed/mineral,
						/turf/closed/wall/mineral/rogue/stonebrick,
						/turf/closed/wall/mineral/rogue/wood,
						/turf/closed/wall/mineral/rogue/wooddark,
						/turf/closed/wall/mineral/rogue/stone,
						/turf/closed/wall/mineral/rogue/stone/moss,
						/turf/open/floor/rogue/cobble,
						/turf/open/floor/rogue/dirt,
						/turf/open/floor/rogue/grass,
						/turf/open/floor/rogue/grass/red,
						/turf/open/floor/rogue/grass/yel,
						/turf/open/floor/rogue/grass/cold,
						/turf/open/floor/rogue/snow,
						/turf/open/floor/rogue/snow/patchy,
						/turf/open/floor/rogue/snow/rough,
						/turf/open/floor/rogue/sandstone,
						/turf/open/floor/rogue/sandstone/temple)

/turf/open/floor/rogue/sandstone/shaded
	color = "#e5dfdf"

/turf/open/floor/rogue/sandstone/temple
	icon_state = "temple"
/turf/open/floor/rogue/sandstone/temple/Initialize()
	dir = pick(GLOB.cardinals)
	. = ..()

/turf/open/floor/rogue/sandstone/old
	icon_state = "sandstone_old"

/turf/open/floor/rogue/grass/mixyel/under_tree
	color = "#ff3535"
/turf/open/floor/rogue/grass/Initialize()
	color = "#ffffff"
	. = ..()


/turf/open/floor/rogue/grass/mixyel
	canSmoothWith = list(/turf/open/floor/rogue/grass,
	/turf/open/floor/rogue/snow,
	/turf/open/floor/rogue/dirt,)



/turf/open/floor/rogue/grass/yel
	canSmoothWith = list(/turf/open/floor/rogue/grass,
	/turf/open/floor/rogue/snow,
	/turf/open/floor/rogue/grass/mixyel)

// =================================================================================
/*--------\
| Washing |
\--------*/

/turf/open/water/bath
	wash_in = FALSE


/turf/open/floor/rogue/dirt
	canSmoothWith = list(/turf/open/floor/rogue/grass,
						/turf/open/floor/rogue/grass/red,
						/turf/open/floor/rogue/grass/yel,
						/turf/open/floor/rogue/grass/cold,
						/turf/open/floor/rogue/snow,
						/turf/open/floor/rogue/snow/patchy,
						/turf/open/floor/rogue/snow/rough,
						/turf/open/floor/rogue/hay)

/turf/open/floor/rogue/hay
	icon = 'modular/stonekeep/icons/turfs.dmi'
	icon_state = "hay"
	footstep = FOOTSTEP_GRASS
	barefootstep = FOOTSTEP_SOFT_BAREFOOT
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY
	tiled_dirt = FALSE
	landsound = 'sound/foley/jumpland/grassland.wav'
	slowdown = 0


/*	..................   Kaizoku Sand   ................... */
/turf/open/floor/rogue/sand
	icon = 'modular/stonekeep/icons/turfs.dmi'
	icon_state = "sand"
	footstep = FOOTSTEP_SAND
	barefootstep = FOOTSTEP_SOFT_BAREFOOT
	clawfootstep = FOOTSTEP_SAND
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY
	landsound = 'sound/foley/jumpland/dirtland.wav'
	neighborlay = "sandedges"
	smooth = SMOOTH_TRUE
	canSmoothWith = list(
		/turf/closed/mineral/rogue,
		/turf/closed/mineral,
		/turf/closed/wall/mineral/rogue/stonebrick,
		/turf/closed/wall/mineral/rogue/wood,
		/turf/closed/wall/mineral/rogue/wooddark,
		/turf/closed/wall/mineral/rogue/stone,
		/turf/closed/wall/mineral/rogue/stone/moss,
		/turf/open/floor/rogue/cobble,
		/turf/open/floor/rogue/dirt,
		/turf/open/floor/rogue/grass,
		/turf/open/floor/rogue/grass/red,
		/turf/open/floor/rogue/grass/yel,
		/turf/open/floor/rogue/grass/cold,
		/turf/open/floor/rogue/snow,
		/turf/open/floor/rogue/snow/patchy,
		/turf/open/floor/rogue/snow/rough
	)

/turf/open/floor/rogue/sand/cardinal_smooth(adjacencies)
	roguesmooth(adjacencies)

/turf/open/floor/rogue/sand/Initialize()
	dir = pick(GLOB.cardinals)
	. = ..()


/datum/mapGenerator/forest
	modules = list(/datum/mapGeneratorModule/ambushing,/datum/mapGeneratorModule/forestgrassturf,/datum/mapGeneratorModule/forest,/datum/mapGeneratorModule/forestroad,/datum/mapGeneratorModule/forestgrass,/datum/mapGeneratorModule/forestswampwaterturf,/datum/mapGeneratorModule/forestwaterturf, /datum/mapGeneratorModule/forest_undertree)


/datum/mapGeneratorModule/forest
	spawnableAtoms = list(/obj/structure/flora/newtree = 4,
							/obj/structure/flora/roguegrass/bush_meagre = 4,
							/obj/structure/flora/roguegrass/thorn_bush = 2,
							/obj/structure/flora/roguegrass = 80,
							/obj/structure/flora/roguegrass/herb/random = 7,
							/obj/item/natural/stone = 5,
							/obj/item/natural/rock = 6,
							/obj/item/grown/log/tree/stick = 5,
							/obj/structure/chair/bench/ancientlog = 3,
							/obj/structure/table/wood/treestump = 4,
							/obj/structure/closet/dirthole/closed/loot=6,
							/obj/item/restraints/legcuffs/beartrap/armed=0.1)
	spawnableTurfs = list(/turf/open/floor/rogue/dirt/road=80,
						/turf/open/water/swamp=25)
	allowed_areas = list(/area/rogue/outdoors/woods)

/datum/mapGeneratorModule/forestgrass
	clusterCheckFlags = CLUSTER_CHECK_SAME_ATOMS
	allowed_turfs = list(/turf/open/floor/rogue/grass)
	excluded_turfs = list(/turf/open/floor/rogue/grass/mixyel/under_tree)
	allowed_areas = list(/area/rogue/outdoors/woods)
	spawnableAtoms = list(/obj/structure/flora/roguetree = 0,
							/obj/structure/flora/roguegrass/bush_meagre = 6,
							/obj/structure/flora/roguegrass = 80,
							/obj/structure/flora/rogueflower/random = 6,
							/obj/structure/flora/roguegrass/herb/random = 2,
							/obj/structure/flora/roguegrass/pyroclasticflowers = 1,
							/obj/item/natural/stone = 6,
							/obj/item/natural/rock = 5,
							/obj/item/grown/log/tree/stick = 3,
							/obj/structure/chair/bench/ancientlog = 5)

/datum/mapGeneratorModule/forestwaterturf
	spawnableAtoms = list(/obj/structure/flora/roguegrass/water = 20,
	                        /obj/structure/flora/roguegrass/water/reeds = 25,
							/obj/structure/flora/roguegrass/stalky = 5,
	                        /obj/structure/kneestingers = 5)

/datum/mapGeneratorModule/forest_undertree
	clusterCheckFlags = CLUSTER_CHECK_SAME_ATOMS
	allowed_turfs = list(/turf/open/floor/rogue/grass/mixyel/under_tree)
	excluded_turfs = list()
	allowed_areas = list(/area/rogue/outdoors/woods)
	spawnableAtoms = list(/obj/structure/innocent_web = 10,
							/obj/structure/flora/rogueflower/random = 6,
							/obj/item/grown/log/tree/stick = 3,
							/obj/structure/flora/rogueflower/fallenleaves = 30)

/area/rogue/indoors/cave/volf
	name = "volf cave"
	icon_state = "cave"

/area/rogue/indoors/cave/spider
	name = "spider cave"
	icon_state = "cave"
