/datum/reagent/fogblight
	name = "fogblight"
	description = "liquid concentrate from fog island's frogs. Used by shinobis."
	taste_description = ""
	reagent_state = LIQUID
	color = "#1f434d"
	metabolization_rate = 0.2

/datum/reagent/fogblight/on_mob_life(mob/living/carbon/M)
	switch(current_cycle)
		if(1 to 20)
			M.adjust_confusion(2 SECONDS)
			M.adjust_drowsiness(2 SECONDS)
		if(30 to 50)
			M.Sleeping(40, 0)
			. = 1
		if(51 to INFINITY)
			M.Sleeping(40, 0)
			M.adjustToxLoss((current_cycle - 50)*REM, 0)
			. = 1
	..()

/datum/reagent/fogblight/corruption
	name = "devilblight"
	description = "A corrupted mimicry of the fogblight. Some demons started to produce it after exposure."
	taste_description = "earthy"
	reagent_state = LIQUID
	color = "#3a5f66"
	metabolization_rate = 0.3 // Reduced from 0.5 for weaker effect
	var/crash_started = FALSE
	var/warning_stage = 0

/datum/reagent/fogblight/corruption/on_mob_life(mob/living/carbon/M)
	if(M.stat != UNCONSCIOUS)
		if(current_cycle <= 50)
			if(current_cycle % 15 == 0)
				switch(warning_stage)
					if(0)
						to_chat(M, "<span class='notice'>I feel slightly drowsy...</span>")
						warning_stage++
					if(1)
						to_chat(M, "<span class='notice'>I stifle a small yawn.</span>")
						M.emote("yawn")
						warning_stage++
					if(2)
						to_chat(M, "<span class='warning'>My eyelids feel heavy.</span>")
						warning_stage++
				M.adjust_drowsiness(1 SECONDS)
		else if(current_cycle <= 100)
			if(current_cycle % 20 == 0)
				var/list/sleepy_messages = list(
					"The... urge ... to rest.",
					"The world seems ... to sway....",
					"... thoughts feel ... sluggish...",
					"I was-... nodding off...?",
					"Everything seems so... peaceful and quiet..."
				)
				to_chat(M, "<span class='warning'>[pick(sleepy_messages)]</span>")
				if(prob(30))
					M.emote("yawn")
				M.adjust_drowsiness(2 SECONDS)
				M.adjust_confusion(1 SECONDS)

		// Heavy exposure - chance to fall asleep
		else if(current_cycle <= 200)
			M.adjust_drowsiness(3 SECONDS)
			M.adjust_confusion(2 SECONDS)
			if(current_cycle % 25 == 0 && prob(40)) // Only 40% chance to fall asleep
				to_chat(M, "<span class='danger'>I can't- My eyes, it doesn't-...</span>")
				M.Sleeping(50, 0)
		else
			if(!crash_started && prob(60)) // 60% chance to enter crash phase
				crash_started = TRUE
				to_chat(M, "<span class='userdanger'>...Over-vewh...overwhelm...med...!</span>")
				M.Sleeping(100, 0)
			else if(crash_started)
				M.adjustToxLoss(0.05, 0) // Reduced damage
	else
		if(crash_started)
			M.adjustToxLoss(0.05, 0) // Reduced damage
	. = ..()
