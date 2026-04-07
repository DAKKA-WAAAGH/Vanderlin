
/datum/job/kaizoku/mastersohei
	title = "Warpriest Tideseeker"
	tutorial = "High-ranking Tideseeker who hold authority within multiple shrines and tideseekers \
	within their influence. Often in charge of militant activities, these senior warriors are in \
	search of demonic corruption to dismantle, following the will of Abyssor under the words of \
	the Prophet. Their duty is to organize expeditions and ensure Abyssanctum artifacts are protected from thieves."
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACE_NATIVE_PLAYERS // Tideseekers are as tight-recruited as champions, since they are 'modern' offshoots.
	display_order = KZ_ELDERTIDER
	department_flag = FACTION_ABYSSANCTUM
	job_flags = (JOB_ANNOUNCE_ARRIVAL | JOB_SHOW_IN_CREDITS | JOB_EQUIP_RANK | JOB_NEW_PLAYER_JOINABLE)
	faction = FACTION_TOWN
	total_positions = 1
	spawn_positions = 1
	allowed_patrons = list(/datum/patron/abyssanctum/tideweaver)

	bypass_lastclass = TRUE
	outfit = /datum/outfit/job/kaizoku/mastersohei
	// min_pq = 0 ; Stonekeep Todo - Vanderlin removed PQ, reimplement it later.
	selection_color = "#c2a45d"
	cmode_music = 'modular/kaizoku/sound/combat/combat_emperor.ogg'
	// spells = list(
	//	/obj/effect/proc_holder/spell/self/convertrole/sohei,
	/// )

/datum/outfit/job/kaizoku/mastersohei/pre_equip(mob/living/carbon/human/H)
	..()
	head = /obj/item/clothing/head/helmet/heavy/necked/soheidemon
	wrists = /obj/item/clothing/neck/psycross/silver/abyssanctum
	shirt = /obj/item/clothing/suit/roguetown/shirt/eastshirt2
	armor = /obj/item/clothing/armor/chainmail/hauberk/kusari
	pants = /obj/item/clothing/pants/chainlegs/sendan
	shoes = /obj/item/clothing/shoes/shortboots/cloudhead
	belt = /obj/item/storage/belt/kaizoku/leather/daisho/random
	beltl = /obj/item/storage/belt/pouch/coins/mid
	ring = /obj/item/clothing/ring/silver
	cloak = /obj/item/clothing/cloak/odoshisohei
	neck = /obj/item/clothing/neck/chaincoif/karuta_zukin/random
	gloves = /obj/item/clothing/gloves/chain/kikko
	r_hand = /obj/item/weapon/polearm/halberd/bisento
	if(H.mind)
		H.adjust_skillrank(/datum/skill/combat/axesmaces, 2, TRUE)
		H.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
		H.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
		H.adjust_skillrank(/datum/skill/combat/polearms, 3, TRUE)
		H.adjust_skillrank(/datum/skill/combat/shields, 3, TRUE)
		H.adjust_skillrank(/datum/skill/misc/climbing, 1, TRUE)
		H.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
		H.adjust_skillrank(/datum/skill/misc/reading, 3, TRUE)
		H.adjust_skillrank(/datum/skill/magic/holy, 2, TRUE)
		H.adjust_skillrank(/datum/skill/craft/cooking, 1, TRUE)
		H.change_stat("strength", 2)
		H.change_stat("perception", 2)
		H.change_stat("intelligence", 2)
		H.change_stat("constitution", 1)
		H.change_stat("endurance", 1)
		H.change_stat("speed", -2) //Differently of templars, they don't have CHURN. Tideweaver focus only.

	/* This content will be replaced with the SMITE system
	var/datum/devotion/cleric_holder/C = new /datum/devotion/cleric_holder(H, H.patron)
	C.update_devotion(50, 50)
	C.holder_mob = H
	C.grant_spells_sohei(H)
	H.verbs += list(/mob/living/carbon/human/proc/devotionreport, /mob/living/carbon/human/proc/clericpray)
	H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/icebind)
	*/
	ADD_TRAIT(H, TRAIT_HEAVYARMOR, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC) //It's meant to be only heavy armor, but Kusari is medium. Idk how templar is doing, but in my testing, the armor was freaked.
	ADD_TRAIT(H, TRAIT_NOBLE, TRAIT_GENERIC)

/datum/job/kaizoku/mastersohei/after_spawn(mob/living/carbon/human/spawned, client/player_client)
	. = ..()

	spawned.verbs |= /mob/living/carbon/human/proc/faith_test
	spawned.verbs |= /mob/living/carbon/human/proc/torture_victim
	// spawned.verbs |= /mob/living/carbon/human/proc/view_inquisition // Fix this later.

	spawned.hud_used?.shutdown_bloodpool()
	spawned.hud_used?.initialize_bloodpool()
	spawned.hud_used?.bloodpool.set_fill_color("#dcdddb")
	spawned.hud_used?.bloodpool?.name = "Psydon's Grace: [spawned.bloodpool]"
	spawned.hud_used?.bloodpool?.desc = "Devotion: [spawned.bloodpool]/[spawned.maxbloodpool]"
	spawned.maxbloodpool = 1000

	var/prev_real_name = spawned.real_name
	var/prev_name = spawned.name
	var/honorary = "Elder" // Change this later.
	if(spawned.pronouns == SHE_HER)
		honorary = "Eldary" // Change this later.
	spawned.real_name = "[honorary] [prev_real_name]"
	spawned.name = "[honorary] [prev_name]"

	var/datum/species/species = spawned.dna?.species
	if(!species)
		return
	//species.native_language = "Old Psydonic"
	//species.accent_language = species.get_accent(species.native_language)

/mob/living/carbon/human/proc/torture_victim()
	set name = "Extract Confession"
	set category = "Inquisition"

	var/obj/item/grabbing/I = get_active_held_item()
	var/mob/living/carbon/human/H
	if(!istype(I) || !ishuman(I.grabbed))
		return
	H = I.grabbed
	if(H == src)
		to_chat(src, span_warning("I won't torture myself!"))
		return
	if(!HAS_TRAIT(H, TRAIT_RESTRAINED) && !H.buckled)
		to_chat(src, span_warning("[H] needs to be restrained or buckled first!"))
		return
	if(H.stat == DEAD)
		to_chat(src, span_warning("[H] is dead already..."))
		return

	// Anti-spam check
	if(HAS_TRAIT(H, TRAIT_RECENTLY_TORTURED))
		to_chat(src, span_warning("[H] needs time to recover before being tortured again!"))
		return

	var/painpercent = (H.get_complex_pain() / (H.STAEND * 12)) * 100
	if(painpercent < 100)
		to_chat(src, span_warning("Not ready to speak yet."))
		return
	if(!do_after(src, 4 SECONDS, H))
		return
	if(!HAS_TRAIT(H, TRAIT_RESTRAINED) && !H.buckled)
		to_chat(src, span_warning("[H] needs to be restrained or buckled first!"))
		return
	if(H.stat == DEAD)
		to_chat(src, span_warning("[H] is dead already..."))
		return
	if(H.add_stress(/datum/stress_event/tortured))
		SEND_SIGNAL(src, COMSIG_TORTURE_PERFORMED, H)

		// Add torture cooldown
		ADD_TRAIT(H, TRAIT_RECENTLY_TORTURED, TRAIT_GENERIC)
		addtimer(TRAIT_CALLBACK_REMOVE(H, TRAIT_RECENTLY_TORTURED, TRAIT_GENERIC), 3 MINUTES)

		var/static/list/torture_lines = list(
			"CONFESS YOUR WRONGDOINGS!",
			"TELL ME YOUR SECRETS!",
			"SPEAK THE TRUTH!",
			"YOU WILL SPEAK!",
			"TELL ME!",
			"THE PAIN HAS ONLY BEGUN, CONFESS!",
		)
		say(pick(torture_lines), spans = list("torture"))
		H.emote("painscream")
		H.confession_time("antag", src)

/mob/living/carbon/human/proc/faith_test()
	set name = "Test Faith"
	set category = "Inquisition"

	var/obj/item/grabbing/I = get_active_held_item()
	var/mob/living/carbon/human/H
	if(!istype(I) || !ishuman(I.grabbed))
		return
	H = I.grabbed
	if(H == src)
		to_chat(src, span_warning("I won't torture myself!"))
		return
	if(!HAS_TRAIT(H, TRAIT_RESTRAINED) && !H.buckled)
		to_chat(src, span_warning("[H] needs to be restrained or buckled first!"))
		return
	if(H.stat == DEAD)
		to_chat(src, span_warning("[H] is dead already..."))
		return

	// Anti-spam check
	if(HAS_TRAIT(H, TRAIT_RECENTLY_TORTURED))
		to_chat(src, span_warning("[H] needs time to recover before being tortured again!"))
		return

	var/painpercent = (H.get_complex_pain() / (H.STAEND * 12)) * 100
	if(painpercent < 100)
		to_chat(src, span_warning("Not ready to speak yet."))
		return
	if(!do_after(src, 4 SECONDS, H))
		return
	if(!HAS_TRAIT(H, TRAIT_RESTRAINED) && !H.buckled)
		to_chat(src, span_warning("[H] needs to be restrained or buckled first!"))
		return
	if(H.stat == DEAD)
		to_chat(src, span_warning("[H] is dead already..."))
		return
	if(H.add_stress(/datum/stress_event/tortured))
		SEND_SIGNAL(src, COMSIG_TORTURE_PERFORMED, H)

		// Add torture cooldown
		ADD_TRAIT(H, TRAIT_RECENTLY_TORTURED, TRAIT_GENERIC)
		addtimer(TRAIT_CALLBACK_REMOVE(H, TRAIT_RECENTLY_TORTURED, TRAIT_GENERIC), 30 SECONDS)

		var/static/list/faith_lines = list(
			"DO YOU DENY THE ABYSS AND ITS ANGELS?",
			"WHO IS YOUR GOD?",
			"ARE YOU FAITHFUL?",
			"TO WHICH SHEPHERD DO YOU FLOCK TO?",
		)
		say(pick(faith_lines), spans = list("torture"))
		H.emote("painscream")
		H.confession_time("patron", src)

/mob/living/carbon/human/proc/confession_time(confession_type = "antag", mob/living/carbon/human/user)
	var/timerid = addtimer(CALLBACK(src, PROC_REF(confess_sins), confession_type, FALSE, user), 10 SECONDS, TIMER_STOPPABLE)
	var/static/list/options = list("RESIST!!", "CONFESS!!")
	var/responsey = browser_input_list(src, "Resist torture?", "TEST OF PAIN", options)

	if(SStimer.timer_id_dict[timerid])
		deltimer(timerid)
	else
		to_chat(src, span_warning("Too late..."))
		return
	if(responsey == "RESIST!!")
		confess_sins(confession_type, resist=TRUE, interrogator=user)
	else
		confess_sins(confession_type, resist=FALSE, interrogator=user)

/mob/living/carbon/human/proc/confess_sins(confession_type = "antag", resist, mob/living/carbon/human/interrogator, torture=TRUE, obj/item/paper/inqslip/confession/confession_paper, false_result)
	if(stat == DEAD)
		return
	var/static/list/innocent_lines = list(
		"I DON'T KNOW!",
		"STOP THIS MADNESS!!",
		"I DON'T DESERVE THIS!",
		"THE PAIN!",
		"I HAVE NOTHING TO SAY...!",
		"WHY ME?!",
		"I'M INNOCENT!",
		"I AM NO SINNER!",
	)
	var/resist_chance = 0
	var/false_confession_chance = 0
	var/is_innocent = TRUE

	if(resist)
		to_chat(src, span_boldwarning("I attempt to resist the torture!"))
		resist_chance = (STAINT + STAEND) + 10
		if(istype(buckled, /obj/structure/fluff/walldeco/chains))
			resist_chance -= 15
		if(confession_type == "antag")
			resist_chance += 25

	// Check if they're actually guilty
	if(confession_type == "antag")
		for(var/datum/antagonist/antag in mind?.antag_datums)
			if(length(antag.confess_lines))
				is_innocent = FALSE
				break
	else if(confession_type == "patron")
		if(ispath(false_result, /datum/patron))
			is_innocent = FALSE
		else if(length(patron?.confess_lines))
			is_innocent = FALSE

	// Calculate false confession chance for innocents under torture
	if(is_innocent && !resist)
		false_confession_chance = 100 - (STAINT + STAEND) // Low willpower = higher chance to falsely confess
		false_confession_chance = CLAMP(false_confession_chance, 20, 80) // Between 20-80%

	if(!prob(resist_chance))
		var/list/confessions = list()
		var/datum/antag_type = null
		var/is_false_confession = FALSE

		switch(confession_type)
			if("antag")
				if(!false_result)
					for(var/datum/antagonist/antag in mind?.antag_datums)
						if(!length(antag.confess_lines))
							continue
						confessions += antag.confess_lines
						antag_type = antag.type
						break

					// If innocent and failed to resist, chance of false confession
					if(!length(confessions) && prob(false_confession_chance))
						is_false_confession = TRUE
						// Pick a random antag type to falsely confess to
						var/static/list/false_antag_types = list(
							/datum/antagonist/bandit,
							/datum/antagonist/maniac,
							/datum/antagonist/zizocultist
						)
						antag_type = pick(false_antag_types)
						confessions += list("I... I AM GUILTY!", "YES! I CONFESS!", "I DID IT!")

			if("patron")
				if(ispath(false_result, /datum/patron))
					var/datum/patron/fake_patron = new false_result()
					if(length(fake_patron.confess_lines))
						confessions += fake_patron.confess_lines
						antag_type = fake_patron.type
				else
					if(length(patron?.confess_lines))
						confessions += patron.confess_lines
						antag_type = patron.type

					// If innocent and failed to resist, chance of false confession
					if(!length(confessions) && prob(false_confession_chance))
						is_false_confession = TRUE
						var/static/list/false_patron_types = list(
							/datum/patron/inhumen/matthios,
							/datum/patron/inhumen/zizo,
							/datum/patron/inhumen/graggar
						)
						antag_type = pick(false_patron_types)
						confessions += list("I WORSHIP THE FORBIDDEN!", "I FOLLOW THE DARK PATH!", "I AM A HERETIC!")

		// Apply stress penalties for torturing innocents/faithful
		if(torture && interrogator && confession_type == "patron")
			var/datum/patron/interrogator_patron = interrogator.patron
			var/datum/patron/victim_patron = patron
			switch(interrogator_patron.associated_faith.type)
				if(/datum/faith/abyssanctum) //Stonekeep Edit
					// Essentially, they are free to do it to anyone but abyssanctum members.
					// Let's be honest, it is no secret that "The Ten" should only be really tolerated on paper.
					if(ispath(victim_patron.type, /datum/patron/divine))
						interrogator.add_stress(/datum/stress_event/torture_small_penalty)
					//else if(victim_patron.type == /datum/patron/psydon/progressive) // Feel free to do it to psydonics.
						//interrogator.add_stress(/datum/stress_event/torture_small_penalty)
					//else if(victim_patron.type == /datum/patron/godless/naivety)
						//interrogator.add_stress(/datum/stress_event/torture_small_penalty)
					else if(victim_patron.type == /datum/patron/abyssanctum)
						interrogator.add_stress(/datum/stress_event/torture_large_penalty)

		if(length(confessions))
			if(torture)
				say(pick(confessions), spans = list("torture"), forced = TRUE)
			else
				say(pick(confessions), forced = TRUE)

			var/obj/item/paper/inqslip/confession/held_confession
			if(istype(confession_paper))
				held_confession = confession_paper
			else if(interrogator?.is_holding_item_of_type(/obj/item/paper/inqslip/confession))
				held_confession = interrogator.is_holding_item_of_type(/obj/item/paper/inqslip/confession)

			if(held_confession && !held_confession.signed)
				// Mark if this is a false confession
				if(is_false_confession)
					held_confession.false_confession = TRUE
					to_chat(interrogator, span_danger("Something seems off about this confession..."))


				switch(antag_type)
					if(/datum/antagonist/bandit)
						held_confession.bad_type = "AN OUTLAW OF THE THIEF-LORD"
						held_confession.antag = initial(antag_type:name)
					if(/datum/patron/inhumen/matthios)
						held_confession.bad_type = "A FOLLOWER OF THE THIEF-LORD"
						held_confession.antag = "worshiper of " + initial(antag_type:name)
					if(/datum/antagonist/maniac)
						held_confession.bad_type = "A MANIAC DELUDED BY MADNESS"
						held_confession.antag = initial(antag_type:name)
					if(/datum/antagonist/assassin)
						held_confession.bad_type = "A DEATH CULTIST"
						held_confession.antag = initial(antag_type:name)
					if(/datum/antagonist/zizocultist)
						held_confession.bad_type = "A SERVANT OF THE FORBIDDEN ONE"
						held_confession.antag = initial(antag_type:name)
					if(/datum/antagonist/zizocultist/leader)
						held_confession.bad_type = "A SERVANT OF THE FORBIDDEN ONE"
						held_confession.antag = initial(antag_type:name)
					if(/datum/patron/inhumen/zizo)
						held_confession.bad_type = "A FOLLOWER OF THE FORBIDDEN ONE"
						held_confession.antag = "worshiper of " + initial(antag_type:name)
					if(/datum/antagonist/werewolf)
						var/datum/antagonist/werewolf/werewolf_antag = mind.has_antag_datum(/datum/antagonist/werewolf, TRUE)
						if(werewolf_antag.transformed)
							return
						held_confession.bad_type = "A BEARER OF DENDOR'S CURSE"
						held_confession.antag = initial(antag_type:name)
					if(/datum/antagonist/werewolf/lesser)
						var/datum/antagonist/werewolf/werewolf_antag = mind.has_antag_datum(/datum/antagonist/werewolf, TRUE)
						if(werewolf_antag.transformed)
							return
						held_confession.bad_type = "A BEARER OF DENDOR'S CURSE"
						held_confession.antag = initial(antag_type:name)
					if(/datum/antagonist/vampire)
						held_confession.bad_type = "A SCION OF KAINE"
						held_confession.antag = initial(antag_type:name)
					if(/datum/antagonist/vampire/lord)
						held_confession.bad_type = "THE BLOOD-LORD OF VANDERLIN"
						held_confession.antag = initial(antag_type:name)
					if(/datum/antagonist/vampire/lords_spawn)
						held_confession.bad_type = "AN UNDERLING OF THE BLOOD-LORD"
						held_confession.antag = initial(antag_type:name)
					if(/datum/patron/inhumen/graggar)
						held_confession.bad_type = "A FOLLOWER OF THE DARK SUN"
						held_confession.antag = "worshiper of " + initial(antag_type:name)
					if(/datum/patron/godless/godless)
						held_confession.bad_type = "A DAMNED ANTI-THEIST"
						held_confession.antag = "worshiper of nothing"
					if(/datum/patron/godless/autotheist)
						held_confession.bad_type = "A DELUSIONAL SELF-PROCLAIMED GOD"
						held_confession.antag = "worshiper of nothing"
					if(/datum/patron/godless/defiant)
						held_confession.bad_type = "A DAMNED CHAINBREAKER"
						held_confession.antag = "worshiper of nothing"
					if(/datum/patron/godless/dystheist)
						held_confession.bad_type = "A SPURNER OF THE DIVINE"
						held_confession.antag = "worshiper of nothing"
					if(/datum/patron/godless/naivety)
						held_confession.bad_type = "A IGNORANT FOOL"
						held_confession.antag = "worshiper of nothing"
					if(/datum/patron/godless/rashan)
						held_confession.bad_type = "A FOLLOWER OF A FALSE GOD"
						held_confession.antag = "worshiper of the false god, Rashan-Kahl"
					if(/datum/patron/godless/galadros)
						held_confession.bad_type = "A WORSHIPPER OF THE DRACONIC"
						held_confession.antag = "worshiper of the false god, Galadros"
					/* Stonekeep Edit - We don't have Baotha on Stonekeep lore.
					if(/datum/patron/inhumen/baotha)
						held_confession.bad_type = "A FOLLOWER OF THE REMORSELESS RUINER"
						held_confession.antag = "worshiper of " + initial(antag_type:name)
					*/
					else
						return

				if(HAS_TRAIT_FROM(src, TRAIT_CONFESSED_FOR, held_confession.bad_type))
					visible_message(span_warning("[name] has already confessed for this!"), "I have confessed this!")
					return
				ADD_TRAIT(src, TRAIT_HAS_CONFESSED, TRAIT_GENERIC)
				ADD_TRAIT(src, TRAIT_CONFESSED_FOR, held_confession.bad_type)
			return
		else
			if(torture)
				say(pick(innocent_lines), spans = list("torture"), forced = TRUE)
			else
				say(pick(innocent_lines), forced = TRUE)
			return
	to_chat(src, span_good("I resist the torture!"))
	say(pick(innocent_lines), spans = list("torture"), forced = TRUE)
	return
