/datum/ai_controller/demon/goonpack
	movement_delay = 0.6 SECONDS
	ai_movement = /datum/ai_movement/hybrid_pathing

	blackboard = list(
		BB_TARGETTING_DATUM = new /datum/targetting_datum/basic/allow_items()
	)
	planning_subtrees = list(
		/datum/ai_planning_subtree/aggro_find_target,
		/datum/ai_planning_subtree/basic_melee_attack_subtree/goonpack
	)
	idle_behavior = /datum/idle_behavior/idle_random_walk

/datum/ai_planning_subtree/basic_melee_attack_subtree/goonpack
	melee_attack_behavior = /datum/ai_behavior/basic_melee_attack/goonpack

/datum/ai_behavior/basic_melee_attack/goonpack
	action_cooldown = 0.2 SECONDS
	behavior_flags = AI_BEHAVIOR_REQUIRE_MOVEMENT | AI_BEHAVIOR_REQUIRE_REACH | AI_BEHAVIOR_CAN_PLAN_DURING_EXECUTION

/datum/ai_behavior/basic_melee_attack/goonpack/perform(delta_time, datum/ai_controller/C, target_key, td_key, hide_key)
	var/mob/living/simple_animal/basic = C.pawn //Not using ..() here. The global cooldowns are DESTROYING my special attack code.
	if(!istype(basic, /mob/living/simple_animal/hostile/demon/goonpack))
		finish_action(C, FALSE, target_key)
		return

	var/mob/living/simple_animal/hostile/demon/goonpack/G = basic
	var/atom/target = C.blackboard[target_key]
	var/datum/targetting_datum/TD = C.blackboard[td_key]

	if(QDELETED(target) || !TD || !TD.can_attack(basic, target))
		finish_action(C, FALSE, target_key)
		return

	if(ismob(target))
		if(target:stat == DEAD)
			finish_action(C, FALSE, target_key)
			return

	var/atom/hiding_target = TD.find_hidden_mobs(basic, target) //Because it is important to respect hidden targets.
	C.set_blackboard_key(hide_key, hiding_target)

	if(ismob(target))
		basic.face_atom(target)

	var/list/possible_intents = list()
	for(var/datum/intent/intent as anything in basic.possible_a_intents)
		if(istype(intent, /datum/intent/unarmed/help) || istype(intent, /datum/intent/unarmed/shove) || istype(intent, /datum/intent/unarmed/grab))
			continue
		possible_intents |= intent

	if(length(possible_intents))
		basic.a_intent = pick(possible_intents)
		basic.used_intent = basic.a_intent

	if(!basic.CanReach(hiding_target || target))
		finish_action(C, FALSE, target_key)
		return
	C.ai_interact(hiding_target || target, TRUE, TRUE)

	if(G.pack_size > 1) //This is meant to increase the amount of attacks depending of how many demons are around. Does not work 100%, sadly.
		var/extras = G.pack_size - 1
		for(var/i = 1, i <= extras, i++) //I will come back to this when I'm less stressed.
			C.ai_interact(hiding_target || target, TRUE, TRUE)
	if(G.pack_size >= 2 && G.CanSpecial() && prob(G.special_prob))
		if(isliving(target))
			if(G.TryDogpile(target)) //Special attack!
				G.MarkSpecialUsed()
	finish_action(C, TRUE, target_key)

/mob/living/simple_animal/hostile/demon/goonpack/sinful1
	name = "gaki"
	sinful_index = 1

/mob/living/simple_animal/hostile/demon/goonpack/sinful2
	name = "akaname"
	sinful_index = 2

/mob/living/simple_animal/hostile/demon/goonpack/sinful3
	name = "the infected"
	sinful_index = 3

/mob/living/simple_animal/hostile/demon/goonpack
	name = "gaki"
	desc = "Minor manifestation of greed, insatiable hunger and hoarding of earthly desires brought this humen soul into damnation."
	faction = list("demons","cabal","graggar")

	ai_controller = /datum/ai_controller/demon/goonpack

	density = TRUE
	speed = 1
	icon = 'modular/kaizoku/icons/mobs/sinful.dmi'
	icon_state = "sinful1"
	icon_living = "sinful1"
	icon_dead = "sinful1_dead"

	see_in_dark = 8
	move_to_delay = 7
	vision_range = 6
	aggro_vision_range = 6
	minimum_distance = 0
	retreat_distance = 0
	var/range = 6 // for ai_aggro_system
	base_intents = list(/datum/intent/unarmed/claw, /datum/intent/simple/bigbite) //Their default melee behavior. Sourced from normal animals.

	var/pack_size = 1 //Maximum of three friend boyz
	var/max_pack_size = 3
	var/member_hp = 55
	health = 120
	maxHealth = 120

	// melee baseline (AI uses this; our behavior flurries on top)
	melee_damage_lower = 15
	melee_damage_upper = 25
	melee_attack_cooldown = 12
	next_click = 0
	var/special_cooldown = 45 //Special attacks for dogpilling system.
	var/special_prob = 15   //15% chance of dealing a special attack.
	var/post_special_delay = 6
	var/last_special_time = 0
	var/power_disarm_base = 14
	var/power_offbalance_base = 16
	var/power_kd_base = 18
	var/sinful_index = 0 //Variants; 0 is random.
	var/base_icon_ref = null //Little sad system for the sake of keeping deathstates working. Very "sorry" code. Someone replace this.
	var/base_living_state_ref = null
	var/base_dead_state_ref = null
	var/flip_on_death_cached = FALSE
	var/list/member_overlays = null //Overlay for the GANG
	var/list/member_states = null
	var/list/member_healths = null
	var/static/list/offsets_pack = list(
		list(  0,  0), // center mob. 'The Leader' and last one to die.
		list(-13,  0),
		list( 13,  0)
	)
	var/next_merge_time = 0

/mob/living/simple_animal/hostile/demon/goonpack/Initialize()
	. = ..()
	AddComponent(/datum/component/ai_aggro_system, 10, range)
	if(sinful_index <= 0 || sinful_index > 3) //Chooses a random variant.
		sinful_index = rand(1, 3)

	switch(sinful_index)
		if(1)
			name = "gaki"
			desc = "Minor manifestation of greed, insatiable hunger and hoarding of \
			earthly desires brought this humen soul into damnation."
		if(2)
			name = "akaname"
			desc = "Minor manifestation of sloth. Whom creeps through filth and neglect, \
			feeding on the laziness and thriving where effort has decayed."
		if(3)
			name = "the infected"
			desc = "Minor manifestation of wrath. A mind of festered rage controls the vessel\
			of an invasive force from the mainland, grenzelhoft in flesh and clothes."

	var/L = "sinful[sinful_index]"
	var/D = "sinful[sinful_index]_dead"
	icon_state = L
	if("icon_living" in vars)
		vars["icon_living"] = L
	if("icon_dead" in vars)
		vars["icon_dead"] = D

	base_icon_ref = icon
	base_living_state_ref = (("icon_living" in vars) && vars["icon_living"]) ? vars["icon_living"] : icon_state
	base_dead_state_ref = (("icon_dead" in vars) && vars["icon_dead"]) ? vars["icon_dead"] : "[base_living_state_ref]_dead"
	if(("flip_on_death" in vars) && vars["flip_on_death"])
		flip_on_death_cached = TRUE

	if(!islist(member_states)) 	// Initialize member arrays
		member_states = list()
	if(!islist(member_healths))
		member_healths = list()
	member_states.Cut()
	member_healths.Cut()
	for(var/i = 1, i <= pack_size, i++)
		member_healths += member_hp // one slot per member

	SyncVitalsToMembers()
	RebuildOverlays()

/mob/living/simple_animal/hostile/demon/goonpack/Life()
	. = ..()
	if(stat == DEAD)
		return
	if(world.time >= next_merge_time)
		TryMergeNearby()
		next_merge_time = world.time + 10 // ~0.1s on 1ds tick servers

/mob/living/simple_animal/hostile/demon/goonpack/Destroy()
	ClearOverlays()
	return ..()

// ============================ DAMAGE & HEALTH ============================

/mob/living/simple_animal/hostile/demon/goonpack/proc/RescalePackHealth()
	maxHealth = max(1, pack_size * member_hp)
	health = clamp(health, 1, maxHealth)

/mob/living/simple_animal/hostile/demon/goonpack/proc/GPStat(mob/living/L, key, def=6)
	if(!L)
		return def
	if(!(key in L.vars))
		return def
	var/v = L.vars[key]
	return isnum(v) ? v : def

/mob/living/simple_animal/hostile/demon/goonpack/proc/SyncVitalsToMembers()
	var/total = 0
	if(member_healths)
		for(var/h in member_healths)
			if(isnum(h))
				total += h
	maxHealth = max(0, pack_size * member_hp)
	if(pack_size <= 0)
		health = 0
	else
		health = max(1, min(total, maxHealth))

/mob/living/simple_animal/hostile/demon/goonpack/apply_damage(damage = 0, damagetype = BRUTE, def_zone = null, blocked = 0, forced = FALSE, spread_damage = FALSE)
	if(damage <= 0 || pack_size <= 0)
		return 0 //No damage dealt, so ignore it.
	var/dmg = max(0, damage - (blocked || 0)) //Blocked? no damage.
	while(dmg > 0 && pack_size > 0) // if we have members left, chew from the back line toward the leader. Otherwise the leader will DIE instantly.
		var/idx = member_healths.len// target the LAST member
		var/hp = member_healths[idx]
		var/take = min(dmg, hp)
		hp -= take
		dmg -= take
		if(hp <= 0)
			PopMember(idx) //Kills this member. However, if it is the final one, does not spawn their body. Let /death do it.
		else
			member_healths[idx] = hp
	SyncVitalsToMembers() //sync vitals
	if(pack_size <= 0 && stat != DEAD) //All members gone? Then spawn the real corpse.
		death(FALSE)
	return damage

// =============================== OVERLAYS ================================

/mob/living/simple_animal/hostile/demon/goonpack/proc/ClearOverlays() //Clean the deadass
	if(!member_overlays)
		return
	for(var/image/I in member_overlays)
		overlays -= I
	member_overlays.Cut()

/mob/living/simple_animal/hostile/demon/goonpack/proc/RebuildOverlays() //Rebuild the deadass
	ClearOverlays()
	member_overlays = list()
	while(length(member_states) > max(0, pack_size - 1)) //Ensures the pack size always matches. Otherwise we will have very naught bugs.
		member_states.Cut(member_states.len, member_states.len+1)
	while(length(member_states) < max(0, pack_size - 1))
		member_states += base_living_state_ref

	var/limit = min(length(member_states), max(0, length(offsets_pack) - 1))
	for(var/i = 1, i <= limit, i++)
		var/list/off = offsets_pack[i + 1]
		var/ist = member_states[i]
		var/image/I = image(base_icon_ref, ist)
		I.pixel_x = off[1]
		I.pixel_y = off[2]
		I.layer   = MOB_LAYER
		I.appearance_flags = PIXEL_SCALE | KEEP_TOGETHER
		member_overlays += I
		overlays += I


/mob/living/simple_animal/hostile/demon/goonpack/proc/PopMember(idx)
	if(pack_size <= 1)
		pack_size = 0 //Last member > don't spawn an corpse effect.
		if(member_healths)
			member_healths.Cut()
		if(member_states)
			member_states.Cut()
		ClearOverlays()
		return

	var/popped_state = base_living_state_ref
	if(member_states && member_states.len) // overlays to member type. Avoid spawning the wrong body.
		popped_state = member_states[member_states.len]
		member_states.Cut(member_states.len, member_states.len+1)
	if(member_healths && member_healths.len >= idx) //Remove the HP slot after killing the last member.
		member_healths.Cut(idx, idx+1)
	if(member_overlays && member_overlays.len) //And finally, remove the last overlay image.
		var/image/oi = member_overlays[member_overlays.len]
		overlays -= oi
		member_overlays.Cut(member_overlays.len, member_overlays.len+1)
	pack_size = max(0, pack_size - 1)
	SpawnMemberRemains(popped_state)



/mob/living/simple_animal/hostile/demon/goonpack/proc/SpawnMemberRemains(living_state)
	var/turf/T = get_turf(src)
	if(!T) //Somehow this runtimed, so I gave this check. I hate this.
		return

	var/use_live = living_state ? living_state : base_living_state_ref
	var/dead_guess = "[use_live]_dead" //Choose deadtype.
	var/list/all_states = icon_states(base_icon_ref)
	var/use_dead = (all_states && (dead_guess in all_states)) ? dead_guess : base_dead_state_ref

	var/obj/effect/decal/remains/goon/R = new(T)
	R.icon = base_icon_ref
	R.icon_state = use_dead
	R.pixel_x = pick(-10, 10)
	R.pixel_y = pick(-6, 6)
	spawn(6 SECONDS) //Despawns after six seconds. They are too weak to be corpse-worthy.
	qdel(R)


// ============================== MERGING LOGIC =============================

/mob/living/simple_animal/hostile/demon/goonpack/proc/TryMergeNearby()
	if(pack_size >= max_pack_size)
		return
	var/mob/living/simple_animal/hostile/demon/goonpack/other = null //Pick any gangfriend nearby.
	for(var/mob/living/simple_animal/hostile/demon/goonpack/G in range(1, src))
		if(G == src || G.stat == DEAD)
			continue
		if(G.pack_size <= 0)
			continue
		other = G
		break
	if(!other)
		return
	DoMergeWith(other)

/mob/living/simple_animal/hostile/demon/goonpack/proc/DoMergeWith(mob/living/simple_animal/hostile/demon/goonpack/other)
	if(!other || other == src)
		return
	if(pack_size >= max_pack_size || other.pack_size <= 0)
		return

	var/mob/living/simple_animal/hostile/demon/goonpack/host = src
	var/mob/living/simple_animal/hostile/demon/goonpack/guest = other
	if(other.pack_size > pack_size)
		host = other; guest = src
	if(host == guest)
		return

	if(host != src)
		return //If we are not host, let it absorb us.

	var/free_slots = max_pack_size - host.pack_size
	var/transfer = clamp(guest.pack_size, 0, free_slots)
	if(transfer <= 0)
		return

	host.member_states  = list() //Absorb code.
	host.member_healths = list()
	guest.member_states = list()
	guest.member_healths = list()

	for(var/i = 1, i <= transfer, i++)
		host.member_states  += guest.base_living_state_ref
		host.member_healths += host.member_hp

	host.pack_size += transfer
	host.SyncVitalsToMembers()
	host.RebuildOverlays()
	host.visible_message(span_warning("[host] brings over [guest] into their swarm!"))

	guest.pack_size -= transfer
	while(guest.member_states.len > max(0, guest.pack_size - 1))
		guest.member_states.Cut(guest.member_states.len, guest.member_states.len+1)
	while(guest.member_healths.len > guest.pack_size)
		guest.member_healths.Cut(guest.member_healths.len, guest.member_healths.len+1)
	guest.SyncVitalsToMembers()
	guest.RebuildOverlays()

	if(guest.pack_size <= 0)
		qdel(guest)

// ============================== SPECIAL MOVES ==============================

/mob/living/simple_animal/hostile/demon/goonpack/proc/NowTime()
	return world.time

/mob/living/simple_animal/hostile/demon/goonpack/proc/CanSpecial()
	return (pack_size >= 2) && (NowTime() >= last_special_time + special_cooldown)

/mob/living/simple_animal/hostile/demon/goonpack/proc/MarkSpecialUsed()
	last_special_time = NowTime()

// pull target stats safely (defaults if missing)
/mob/living/simple_animal/hostile/demon/goonpack/proc/GetStatSafe(mob/living/L, key, def=6)
	if(!L)
		return def
	if(!(key in L.vars))
		return def
	var/v = L.vars[key]
	return isnum(v) ? v : def

//The system is simple:
// Dogpile: 2 = disarm
// 3 = offbalance.
// The more swarmers, the more abilities they have.

/mob/living/simple_animal/hostile/demon/goonpack/proc/TryDogpile(mob/living/L)
	if(!L)
		return FALSE
	if(get_dist(src, L) > 1)
		return FALSE

	var/succeeded = FALSE
	var/list/msg = list()

	var/sSTR = GetStatSafe(L, "STASTR", 6)
	var/sCON = GetStatSafe(L, "STACON", 6)
	if(pack_size >= 2) //Disarm system made to make these creatures hell to battle with. Disarm vs Strength
		var/obj/item/W = L.get_active_held_item()
		if(W && (power_disarm_base + rand(1,6)) > (sSTR + rand(1,6)))
			L.dropItemToGround(W)
			var/turf/t = get_edge_target_turf(src, get_dir(src, get_step_away(L, src)))
			if(t) W.throw_at(t, 3, 1)
			msg += "[src] rips [W] from [L]'s hands!"
			succeeded = TRUE

	if(pack_size >= 3 && (power_offbalance_base + rand(1,6)) > (sCON + rand(1,6))) //Set people offbalance.
		L.OffBalance(10)
		msg += "[src]'s swarm presses against [L]!"
		succeeded = TRUE
	L.apply_damage(rand(2,3) * clamp(pack_size, 1, max_pack_size), BRUTE, BODY_ZONE_CHEST) //Chip damage from the swarm's weight.
	if(succeeded)
		visible_message(span_danger(jointext(msg, " ")))
	else
		visible_message(span_warning("[L] endures the weight!."))
	return TRUE

// ========================= PLACEABLE SINFUL VARIANTS ========================

/mob/living/simple_animal/hostile/demon/goonpack/sinful1
	name = "gaki"
	sinful_index = 1

/mob/living/simple_animal/hostile/demon/goonpack/sinful2
	name = "akaname"
	sinful_index = 2

/mob/living/simple_animal/hostile/demon/goonpack/sinful3
	name = "the infected"
	sinful_index = 3

// ============================ REMAINS EFFECT ============================

/obj/effect/decal/remains/goon
	name = "remains"
	gender = PLURAL
	anchored = TRUE
	density = FALSE
	layer = MOB_LAYER - 0.1
	mouse_opacity = 0
	appearance_flags = PIXEL_SCALE | KEEP_TOGETHER

/mob/living/simple_animal/hostile/demon/goonpack/death(gibbed)
	. = ..()
	if(pack_size <= 0)
		qdel(src)
