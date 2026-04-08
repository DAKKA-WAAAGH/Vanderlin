// Essentially an structure that chooses which structure to become later on the line.

/obj/structure/demon/cocoon
	name = "METAPLASIA"
	desc = "Flesh and bones folding into a different form. The sulfuric smell is too much to handle."
	icon = 'modular/kaizoku/icons/mapset/carcinoma_64x64.dmi'
	icon_state = "rebuild"
	max_integrity = 100
	anchored = TRUE
	density = TRUE
	layer = OBJ_LAYER
	var/cocoon_type = "turret" // turret, tendril, core, spawner, mine
	var/maturation_time = 120 SECONDS
	var/matures_at = 0
	var/obj/structure/demon/gateway/owner_gateway = null
	var/obj/structure/demon/expansion/owner_core = null
	var/datum/structure_slot/target_slot = null

/obj/structure/demon/cocoon/Initialize()
	. = ..()
	if(DEMON_HIVE)
		DEMON_HIVE.on_cocoon_created(src)
	matures_at = world.time + max(10, maturation_time)
	START_PROCESSING(SSfastprocess, src)

/obj/structure/demon/cocoon/Destroy()
	STOP_PROCESSING(SSfastprocess, src)
	if(target_slot)
		target_slot.clear_reservation()
	if(DEMON_HIVE)
		DEMON_HIVE.on_cocoon_destroyed(src)
	return ..()

/obj/structure/demon/cocoon/process()
	if(world.time >= matures_at)
		mature()

/obj/structure/demon/cocoon/proc/mature()
	if(QDELETED(src))
		return
	var/obj/structure/demon/created = null
	switch(cocoon_type)
		if("turret")
			created = new /obj/structure/demon/turret(loc)
		if("tendril")
			created = new /obj/structure/demon/tendril(loc)
		if("core")
			created = new /obj/structure/demon/expansion(loc)
		if("spawner")
			created = new /obj/structure/demon/spawner(loc)
		if("mine")
			created = new /obj/structure/demon/mine(loc)
	if(created && target_slot)
		target_slot.fill_slot(created)
	qdel(src)

/obj/structure/demon/cocoon/take_damage(amount, damage_type)
	. = ..()
	var/dmg = max(0, round(amount))
	if(dmg <= 0)
		return
	qdel(src)

// The Hyperplasia
// Essentially an Mob "Spawner"
// Very limited spawn amount until maturation; Low cooldown per respawn.
// Proper for spawning a BUNCH of enemies on the edges of a demon colony.

/mob/living/var/obj/structure/demon/spawner/spawner_parent = null

/obj/structure/demon/spawner
	name = "HYPERPLASIA"
	desc = "... malformed creatures are made from here..."
	icon = 'modular/kaizoku/icons/mapset/carcinoma_64x64.dmi'
	icon_state = "spawner"
	anchored = TRUE
	density = TRUE
	layer = OBJ_LAYER
	max_integrity = 300
	var/spawn_cooldown = 60 SECONDS
	var/next_spawn = 0
	var/owned_limit = 2
	var/check_radius = 8
	var/is_mature = FALSE
	var/matures_at = 0
	var/mature_delay = (60 SECONDS) // 20 minutes until it matures. ; 1200 seconds; put it 60 for testing.

/obj/structure/demon/spawner/Initialize()
	. = ..()
	apply_colony_rules(DEMON_HIVE ? DEMON_HIVE.colony_level : 1)
	matures_at = world.time + mature_delay
	START_PROCESSING(SSfastprocess, src)
	next_spawn = world.time + rand(5, 12)

/obj/structure/demon/spawner/Destroy()
	STOP_PROCESSING(SSfastprocess, src)
	return ..()

/obj/structure/demon/spawner/proc/apply_colony_rules(colony_level)
	if(colony_level >= 2)
		is_second_colony = TRUE
		owned_limit = 1
		spawn_cooldown = 120 SECONDS
	else
		is_second_colony = FALSE
		owned_limit = 2
		spawn_cooldown = 60 SECONDS

/obj/structure/demon/spawner/proc/become_mature(force_now = FALSE)
	if(is_mature && !force_now)
		return

	is_mature = TRUE
	if(max_integrity)
		max_integrity = round(max_integrity * 1.5)
		atom_integrity = max_integrity
	else
		if(!isnum(atom_integrity))
			atom_integrity = 0
		atom_integrity += 50
	if(icon_state != "spawner_mature")
		icon_state = "spawner_mature"
	if(name != "MATURE HYPERPLASIA")
		name = "MATURE HYPERPLASIA"
	visible_message("<span class='warning'>[src] contracts…</span>")


/obj/structure/demon/spawner/proc/get_spawn_list()
	var/list/base_pool = list( 	// Base pool (first colony / unmatured fallback)
		/mob/living/simple_animal/hostile/retaliate/infernal/imp,
		/mob/living/simple_animal/hostile/demon/goonpack,
		/mob/living/simple_animal/hostile/retaliate/lamia
	)
	if(is_mature && GLOB.DEMON_SPAWNER_MATURE_TYPES && GLOB.DEMON_SPAWNER_MATURE_TYPES.len) //Anti-runtime purposes, since you NEVER know.
		return GLOB.DEMON_SPAWNER_MATURE_TYPES
	return base_pool

/obj/structure/demon/spawner/process()
	if(!is_mature && world.time >= matures_at)
		become_mature()

	if(world.time < next_spawn)
		return

	var/owned_near = 0
	for(var/mob/living/Ls in view(check_radius, src))
		if(Ls.spawner_parent == src)
			owned_near++

	if(owned_near >= owned_limit)
		next_spawn = world.time + (spawn_cooldown / 2)
		return

	if(locate(/mob/living) in loc)
		next_spawn = world.time + (spawn_cooldown / 2)
		return

	var/list/_choices = get_spawn_list()
	var/mob_type = pick(_choices)

	var/mob/living/new_mob = new mob_type(loc)
	if(new_mob)
		if(!islist(new_mob.faction))
			new_mob.faction = list()
		if(!(FACTION_CABAL in new_mob.faction))
			new_mob.faction += FACTION_CABAL
		new_mob.spawner_parent = src
		visible_message("<span class='danger'>A [new_mob.name] sloughs out of [src]!</span>")

	next_spawn = world.time + spawn_cooldown

/obj/structure/demon/spawner/mature //If someone wants to spawn it already mature.
	name = "MATURE HYPERPLASIA"
	icon_state = "spawner_mature"

/obj/structure/demon/spawner/mature/Initialize()
	. = ..()
	become_mature(TRUE)
