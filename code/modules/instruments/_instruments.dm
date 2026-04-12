
/obj/item/instrument
	name = ""
	desc = ""
	icon = 'icons/roguetown/items/music.dmi'
	icon_state = ""
	mob_overlay_icon = 'icons/roguetown/onmob/onmob.dmi'
	lefthand_file = 'icons/roguetown/onmob/lefthand.dmi'
	righthand_file = 'icons/roguetown/onmob/righthand.dmi'
	experimental_inhand = FALSE
	possible_item_intents = list(INTENT_USE)
	slot_flags = ITEM_SLOT_HIP|ITEM_SLOT_BACK_R|ITEM_SLOT_BACK_L
	can_parry = FALSE
	force = 0
	minstr = 0
	wbalance = 0
	throwforce = 0
	throw_range = 4
	blade_dulling = DULLING_BASH
	max_integrity = 80 // Flimsy instruments of wood.
	destroy_message = "falls apart!"
	dropshrink = 0.8
	grid_height = 64
	grid_width = 32
	wdefense = BAD_PARRY
	var/datum/looping_sound/instrument/soundloop
	var/list/song_list = list()
	var/playing = FALSE
	var/instrument_buff
	var/icon_prefix
	/// Instrument is in some other holder such as an organ or item.
	var/not_held
	/// Should the instrument only buff the owner's inspiration audience?
	var/target_audience_only = FALSE

/datum/looping_sound/instrument
	mid_length = 2400
	volume = 100
	falloff_exponent = 2
	extra_range = 5
	persistent_loop = TRUE
	sound_group = /datum/sound_group/instruments

/datum/looping_sound/instrument/on_stop(mob/M)
	. = ..()
	if(istype(parent, /obj/item/instrument))
		var/obj/item/instrument/instrument = parent
		instrument.terminate_playing(M)

/obj/item/instrument/getonmobprop(tag)
	. = ..()
	if(tag)
		switch(tag)
			if("gen")
				return list("shrink" = 0.4,"sx" = 0,"sy" = 2,"sx" = 0,"sy" = 2,"wx" = -1,"wy" = 2,"ex" = 5,"ey" = 1,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 0,"nflip" = 8,"sflip" = 8,"wflip" = 8,"eflip" = 0)
			if("onbelt")
				return list("shrink" = 0.3,"sx" = -2,"sy" = -5,"nx" = 4,"ny" = -5,"wx" = 0,"wy" = -5,"ex" = 2,"ey" = -5,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 0,"nflip" = 0,"sflip" = 0,"wflip" = 0,"eflip" = 0,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0)

/obj/item/instrument/Initialize()
	. = ..()
	soundloop = new(src, FALSE)

/obj/item/instrument/Destroy()
	terminate_playing(loc)
	QDEL_NULL(soundloop)
	. = ..()

/obj/item/instrument/process()
	var/source
	if(!ishuman(loc))
		var/atom/thing = loc
		if(ishuman(thing?.loc))
			source = thing.loc
		else if(istype(thing, /obj/item/organ))
			var/obj/item/organ/O = thing
			source = O.owner
	else
		source = loc

	if(!playing || !ishuman(source))
		terminate_playing(source)
		return PROCESS_KILL

	var/mob/living/carbon/human/user = source
	if(!user.has_status_effect(/datum/status_effect/buff/playing_music)) //someone that isnt't the musician is somehow holding it
		terminate_playing(user)
		return PROCESS_KILL

	if(!not_held)
		if(user.get_inactive_held_item() && user.get_skill_level(/datum/skill/misc/music) < 4)
			terminate_playing(user)
			return PROCESS_KILL
	user.apply_status_effect(/datum/status_effect/buff/playing_music) // Handles regular stress event in tick()
	var/boon = user?.get_learning_boon(/datum/skill/misc/music)
	user?.adjust_experience(/datum/skill/misc/music, ceil((user.STAINT*0.2) * boon) * 0.3) // And gain exp

	if(!HAS_TRAIT(user, TRAIT_BARDIC_TRAINING))
		return

	for(var/obj/structure/soil/soil in view(5, source))
		var/distance = max(1, get_dist(source, soil))
		soil.process_npk_growth(round(2 / distance, 0.1))

	for(var/obj/item/reagent_containers/food/snacks/smallrat/I in view(4, user))
		if(I.loc != user)
			step_towards(I, user)

	if(!instrument_buff)
		return

	for(var/mob/living/carbon/listener in hearers(5, source))
		if(!listener.client)
			continue
		if(!listener.can_hear()) // Only good people who can hear music will get buffed
			continue
		var/bypass_checks = FALSE
		if(user == listener)
			bypass_checks = TRUE
		if(user.inspiration)
			if(target_audience_only)
				if(bypass_checks || user.inspiration.check_in_audience(listener))
					listener.apply_status_effect(instrument_buff)
				continue
			else if(user.inspiration.check_in_audience(listener))
				bypass_checks = TRUE
		if(!bypass_checks && !user.faction_check_mob(listener))
			continue
		listener.apply_status_effect(instrument_buff)

/obj/item/instrument/proc/terminate_playing(mob/living/user)
	playing = FALSE
	STOP_PROCESSING(SSprocessing, src)
	if(istype(user))
		user.remove_status_effect(/datum/status_effect/buff/playing_music)
	instrument_buff = null
	target_audience_only = initial(target_audience_only)
	if(soundloop)
		soundloop.stop()
	if(icon_prefix)
		lower_from_mouth()
	// Prevents an exploit
	for(var/mob/living/L in hearers(7, loc))
		for(var/datum/status_effect/bardicbuff/b in L.status_effects)
			L.remove_status_effect(b) // All applicable bard buffs stopped

/obj/item/instrument/equipped(mob/living/user, slot)
	. = ..()
	if(!playing)
		return
	if(!istype(user) || !(slot & ITEM_SLOT_HANDS))
		terminate_playing(user)
		return

/obj/item/instrument/dropped(mob/user, silent)
	if(playing)
		terminate_playing(user)
	. = ..()

/obj/item/instrument/attack_self(mob/living/user, params)
	. = ..()
	if(.)
		return
	if(!isliving(user) || user.stat || (HAS_TRAIT(user, TRAIT_RESTRAINED)))
		return
	user.changeNext_move(CLICK_CD_MELEE)
	if(playing)
		terminate_playing(user)
		return
	var/music_level = user.get_skill_level(/datum/skill/misc/music)
	if(!not_held && user.get_inactive_held_item() && music_level < 4) //DUAL WIELDING BARDS
		return
	for(var/obj/item/instrument/I in user.held_items) //sorry it's too annoying
		if(I.playing)
			return

	var/curfile = input(user, "Which song do you want to play?", "Pick a song", name) as null|anything in song_list
	if(!curfile)
		return
	curfile = song_list[curfile]
	if(!curfile)
		return
	if(!not_held)
		if(!user.is_holding(src) || (user.get_inactive_held_item() && music_level < 4))
			return
	for(var/obj/item/instrument/I in user.held_items) //sorry it's too annoying
		if(I.playing)
			return

	var/note_color = "#7f7f7f" // uses MMO item rarity color grading
	var/stress_event = /datum/stress_event/music
	switch(music_level)
		if(1)
			stress_event = /datum/stress_event/music
		if(2)
			note_color = "#ffffff"
			stress_event = /datum/stress_event/music/two
		if(3)
			note_color = "#1eff00"
			stress_event = /datum/stress_event/music/three
		if(4)
			note_color = "#0070dd"
			stress_event = /datum/stress_event/music/four
		if(5)
			note_color = "#a335ee"
			stress_event = /datum/stress_event/music/five
		if(6)
			note_color = "#ff8000"
			stress_event = /datum/stress_event/music/six

	// BARDIC BUFFS CODE START //
	if(HAS_TRAIT(user, TRAIT_BARDIC_TRAINING)) // Non-bards will never get this prompt. Prompt doesn't show if you cancel song selection either.
		var/list/buffs2pick = list()
		switch(music_level) // There has to be a better way to do this, but so far all I've tried doesn't work as intended.
			if(1) // T1
				buffs2pick += list("Noc's Brilliance (+1 INT)" = /datum/status_effect/bardicbuff/intelligence)
			if(1 to 2) // T2
				buffs2pick += list("Noc's Brilliance (+1 INT)" = /datum/status_effect/bardicbuff/intelligence,
								"Malum's Resilience (+1 END)" = /datum/status_effect/bardicbuff/endurance)
			if(1 to 3) // T3
				buffs2pick += list("Noc's Brilliance (+1 INT)" = /datum/status_effect/bardicbuff/intelligence,
								"Malum's Resilience (+1 END)" = /datum/status_effect/bardicbuff/endurance,
								"Pestra's Blessing (+1 CON)" = /datum/status_effect/bardicbuff/constitution)
			if(1 to 4) // T4
				buffs2pick += list("Noc's Brilliance (+1 INT)" = /datum/status_effect/bardicbuff/intelligence,
								"Malum's Perseverance (+1 END)" = /datum/status_effect/bardicbuff/endurance,
								"Pestra's Blessing (+1 CON)" = /datum/status_effect/bardicbuff/constitution,
								"Xylix's Alacrity (+1 SPD)" = /datum/status_effect/bardicbuff/speed)
			if(1 to 5) // T5
				buffs2pick += list("Noc's Brilliance (+1 INT)" = /datum/status_effect/bardicbuff/intelligence,
								"Malum's Perseverance (+1 END)" = /datum/status_effect/bardicbuff/endurance,
								"Pestra's Blessing (+1 CON)" = /datum/status_effect/bardicbuff/constitution,
								"Xylix's Alacrity (+1 SPD)" = /datum/status_effect/bardicbuff/speed,
								"Ravox's Righteous Fury (+1 STR, +1 PER)" = /datum/status_effect/bardicbuff/ravox)
			if(6 to INFINITY) // Legendary onwards
				buffs2pick += list("Noc's Brilliance (+1 INT)" = /datum/status_effect/bardicbuff/intelligence,
								"Malum's Perseverance (+1 END)" = /datum/status_effect/bardicbuff/endurance,
								"Pestra's Blessing (+1 CON)" = /datum/status_effect/bardicbuff/constitution,
								"Xylix's Alacrity (+1 SPD)" = /datum/status_effect/bardicbuff/speed,
								"Ravox's Righteous Fury (+1 STR, +1 PER)" = /datum/status_effect/bardicbuff/ravox,
								"Astrata's Awakening (+energy, +stamina, +1 FOR)" = /datum/status_effect/bardicbuff/awaken) // TAKE THE LAND THAT MUST BE TAKEN
			else // debug
				message_admins("<span class='warning'>[key_name(usr)] is a bard with zero music skill and couldn't choose a buff.</span>")
		var/buff2use = browser_input_list(user, "Which buff to add to your song?", "Bardic Buffs", buffs2pick)
		if(buff2use) // Prevents runtime
			instrument_buff = buffs2pick[buff2use] // This is to pick the buff and disregard the name defined at list level.
		else
			to_chat(user, "I decided not to bestow any boons to my music.")

	playing = TRUE
	soundloop.mid_sounds = list(curfile)
	soundloop.cursound = null
	soundloop.set_parent(user)
	soundloop.start()
	user.apply_status_effect(/datum/status_effect/buff/playing_music, stress_event, note_color)
	record_round_statistic(STATS_SONGS_PLAYED)
	if(icon_prefix)
		lift_to_mouth()
	START_PROCESSING(SSprocessing, src)

/obj/item/instrument/attack_self_secondary(mob/user, list/modifiers)
	. = ..()
	if(!ishuman(user))
		return
	var/mob/living/carbon/human/human_user = user
	if(!human_user.inspiration)
		return
	target_audience_only = !target_audience_only
	to_chat(user, span_notice("[target_audience_only ? "You will now play only for your audience." : "You will now play for everyone nearby."]"))

/obj/item/instrument/proc/lift_to_mouth()
	icon_state = "[icon_prefix]_play"

/obj/item/instrument/proc/lower_from_mouth()
	icon_state = "[icon_prefix]"



/obj/item/instrument/lute
	name = "lute"
	desc = "The favored instrument of Eora, made of wood and simple string."
	possible_item_intents = list(MACE_WDSTRIKE)
	force = 5
	icon_state = "lute"
	item_state = "lute"
	song_list = list(
	"Abyssor's Second Shanty" = 'sound/blank.ogg',
	"A Knight's Return" = 'sound/blank.ogg',
	"Amongst Fare Friends" = 'sound/blank.ogg',
	"The Road Traveled by Few" = 'sound/blank.ogg',
	"Tip Thine Tankard" = 'sound/blank.ogg',
	"A Reed On the Wind" = 'sound/blank.ogg',
	"Jests On Steel Ears" = 'sound/blank.ogg',
	"Merchant in the Mire" = 'sound/blank.ogg',
	"Soilson's Song" = 'sound/blank.ogg')

/obj/item/instrument/accord
	name = "accordion"
	desc = "A complex piece of dwarven intuition, composed of metal, wood, hide and ivory. Favored by Abyssorian bards."
	icon_state = "accordion"
	item_state = "accordion"
	song_list = list(
	"Her Healing Tears" = 'sound/blank.ogg',
	"Peddler's Tale" = 'sound/blank.ogg',
	"We Toil Together" = 'sound/blank.ogg',
	"Just One More, Tavern Wench" = 'sound/blank.ogg',
	"Moonlight Carnival" = 'sound/blank.ogg',
	"'Ye Best Be Goin'" = 'sound/blank.ogg',
	"Song of the Falconeer" = 'sound/blank.ogg',
	"Dwarven Frolick" = 'sound/blank.ogg',
	"Beloved Blue" = 'sound/blank.ogg',
	)

/obj/item/instrument/guitar
	name = "guitar"
	desc = "A corrupted lute, a heritage instrument of Tiefling pedigree."
	possible_item_intents = list(MACE_WDSTRIKE)
	icon_state = "guitar"
	item_state = "guitar"
	song_list = list(
	"Fire-Cast Shadows" = 'sound/blank.ogg',
	"The Forced Hand" = 'sound/blank.ogg',
	"Regrets Unpaid" = 'sound/blank.ogg',
	"'Took the Mammon and Ran'" = 'sound/blank.ogg',
	"Poor Man's Tithe" = 'sound/blank.ogg',
	"In His Arms Ye'll Find Me" = 'sound/blank.ogg',
	"Sunset Ballad" = 'sound/blank.ogg',
	"Romanza" = 'sound/blank.ogg',
	"Malaguena" = 'sound/blank.ogg',
	"Song of the Archer" = 'sound/blank.ogg',
	"The Mask" = 'sound/blank.ogg',
	"Evolvado" = 'sound/blank.ogg',
	"Asturias" = 'sound/blank.ogg',
	"The Fools Journey" = 'sound/blank.ogg',
	"Prelude to Sorrow" = 'sound/blank.ogg',
	"The Queen's High Seas" = 'sound/blank.ogg',
	"El Odio" = 'sound/blank.ogg',
	"Danza De Las Lanzas" = 'sound/blank.ogg',
	"The Feline, Forever Returning" = 'sound/blank.ogg',
	"El Beso Carmesí" = 'sound/blank.ogg',
	)

/obj/item/instrument/harp
	name = "lyre"
	desc = "An elven instrument of a great and proud heritage."
	icon_state = "harp"
	item_state = "harp"
	song_list = list(
	"Abyssor's Second Shanty" = 'sound/blank.ogg',
	"Through Thine Window, He Glanced" = 'sound/blank.ogg',
	"The Lady of Red Silks" = 'sound/blank.ogg',
	"Eora Doth Watches" = 'sound/blank.ogg',
	"Dance of the Mages" = 'sound/blank.ogg',
	"Trickster Wisps" = 'sound/blank.ogg',
	"On the Breeze" = 'sound/blank.ogg',
	"Never Enough" = 'sound/blank.ogg',
	"Sundered Heart" = 'sound/blank.ogg',
	"Corridors of Time" = 'sound/blank.ogg',
	"Determination" = 'sound/blank.ogg',
	)

/obj/item/instrument/harp/turbulenta
	not_held = TRUE

/obj/item/instrument/flute // small rats approach a little when begin playing
	name = "flute"
	desc = "A cacophonous wind-instrument, played primarily by humens all around Psydonia."
	icon_state = "flute"
	icon_prefix = "flute" // used for inhands switch
	dropshrink = 0.6
	w_class = WEIGHT_CLASS_SMALL
	song_list = list(
	"Abyssor's Second Shanty" = 'sound/blank.ogg',
	"Half-Dragon's Ten Mammon" = 'sound/blank.ogg',
	"The Local Favorite" = 'sound/blank.ogg',
	"Rous in the Cellar" = 'sound/blank.ogg',
	"Her Boots, So Incandescent" = 'sound/blank.ogg',
	"Moondust Minx" = 'sound/blank.ogg',
	"Quest to the Ends" = 'sound/blank.ogg',
	"Flower Melody" = 'sound/blank.ogg',
	"Noble Solace" = 'sound/blank.ogg',
	"Spit Shine" = 'sound/blank.ogg',
	)

/obj/item/instrument/drum
	name = "drum"
	desc = "The adopted instrument of Aasimar, used for signaling and rhythmic marches alike."
	icon_state = "drum"
	item_state = "drum"
	song_list = list(
	"Barbarian's Moot" = 'sound/blank.ogg',
	"Muster the Wardens" = 'sound/blank.ogg',
	"The Earth That Quakes" = 'sound/blank.ogg',
	"Marching Beat" = 'sound/blank.ogg',
	"Desert Heat" = 'sound/blank.ogg')

/obj/item/instrument/hurdygurdy
	name = "hurdy-gurdy"
	desc = "A knob-driven, wooden string instrument that reminds you of the oceans far."
	icon_state = "hurdygurdy"
	song_list = list("Ruler's One Ring" = 'sound/blank.ogg',
	"Tangled Trod" = 'sound/blank.ogg',
	"Motus" = 'sound/blank.ogg',
	"Becalmed" = 'sound/blank.ogg',
	"The Bloody Throne" = 'sound/blank.ogg',
	"We Shall Sail Together" = 'sound/blank.ogg'
	)
	experimental_inhand = TRUE //temporary inhand sprite

/obj/item/instrument/viola
	name = "viola"
	desc = "The prim and proper Viola, often the first instrument nobles are taught."
	icon_state = "viola"
	song_list = list(
	"Abyssor's Second Shanty" = 'sound/blank.ogg',
	"Far Flung Tale" = 'sound/blank.ogg',
	"G Major Cello Suite No. 1" = 'sound/blank.ogg',
	"Ursine's Home" = 'sound/blank.ogg',
	"Mead, Gold and Blood" = 'sound/blank.ogg',
	"Gasgow's Reel" = 'sound/blank.ogg',
	)
	experimental_inhand = TRUE

/obj/item/instrument/vocals
	name = "vocalist's talisman"
	desc = "This talisman emanates a small shimmer of light. When held, it can amplify and even change one's voice."
	icon_state = "vtalisman"
	song_list = list("Harpy's Call (Feminine)" = 'sound/blank.ogg',
	"Necra's Lullaby (Feminine)" = 'sound/blank.ogg',
	"Death Touched Aasimar (Feminine)" = 'sound/blank.ogg',
	"Our Mother, Our Divine (Feminine)" = 'sound/blank.ogg',
	"Wed, Forever More (Feminine)" = 'sound/blank.ogg',
	"Paper Boats (Feminine + Vocals)" = 'sound/blank.ogg',
	"The Dragon's Blood Surges (Masculine)" = 'sound/blank.ogg',
	"Timeless Temple (Masculine)" = 'sound/blank.ogg',
	"Angel's Earnt Halo (Masculine)" = 'sound/blank.ogg',
	"A Fabled Choir (Masculine)" = 'sound/blank.ogg',
	"A Pained Farewell (Masculine + Feminine)" = 'sound/blank.ogg'
	)
	experimental_inhand = TRUE

/obj/item/instrument/vocals/harpy_vocals
	name = "harpy's song"
	icon_state = "harpysong"		//Pulsating heart energy thing.
	desc = "The blessed essence of harpysong. How did you get this... you monster!"
	icon = 'icons/obj/surgery.dmi'
	not_held = TRUE

/obj/item/instrument/psyaltery
	name = "psyaltery"
	desc = "A traditional form of boxed zither or box-harp that may be played plucked, with a plectrum or with hammers. They are particularly associated with divine beings, Aasimar and liturgies."
	icon_state = "psyaltery"
	song_list = list(
	"Disciples Tower" = 'sound/blank.ogg',
	"Green Sleeves" = 'sound/blank.ogg',
	"Midyear Melancholy" = 'sound/blank.ogg',
	"Santa Psydonia" = 'sound/blank.ogg',
	"Le Venardine" = 'sound/blank.ogg',
	"Azurea Fair" = 'sound/blank.ogg',
	"Amoroso" = 'sound/blank.ogg',
	"Lupian's Lullaby" = 'sound/blank.ogg',
	"White Wine Before Breakfast" = 'sound/blank.ogg',
	"Chevalier de Valeur" = 'sound/blank.ogg')
