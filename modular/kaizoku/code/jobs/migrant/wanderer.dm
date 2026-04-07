GLOBAL_VAR_INIT(adventurer_hugbox_duration, 30 SECONDS)
GLOBAL_VAR_INIT(adventurer_hugbox_duration_still, 3 MINUTES)

/datum/job/kaizoku/wanderer
	title = "Wayfarer" // Kaizoku Edit - Start
	tutorial = "Drifters, vandals and adventurers whoms steps are a gamble against the storm. \
	Whatever cast them into this life is up to the wind to decide, \
	they are no heroes, nothing but a blade with no masters nor promise of tomorrow. \
	The thrill and money guides these aspiring warriors into glory, \
	but most of them are lost to history, names scattered and forgotten." // Kaizoku Edit - End
	/*title = "Adventurer"
	tutorial = "Hero of nothing, adventurer by trade. \
	Whatever led you to this fate is up to the wind to decide, \
	and you've never fancied yourself for much other than the thrill. \
	Someday your pride is going to catch up to you, \
	and you're going to find out why most men don't end up in the annals of history." */
	department_flag = FACTIONLESS
	job_flags = (JOB_ANNOUNCE_ARRIVAL | JOB_NEW_PLAYER_JOINABLE | JOB_EQUIP_RANK)
	display_order = KZ_WANDERER
	faction = FACTION_FOREIGNERS
	total_positions = 14
	spawn_positions = 14
	// min_pq = 0 ; Stonekeep Todo - Vanderlin removed PQ, reimplement it later.
	bypass_lastclass = TRUE

	allowed_races = RACES_PLAYER_ALL

	outfit = null
	outfit_female = null
	job_reopens_slots_on_death = TRUE
	same_job_respawn_delay = 15 MINUTES
	advclass_cat_rolls = list(CTAG_WANDERER = 15)
	is_foreigner = TRUE
	can_have_apprentices = FALSE
	scales = TRUE
	selection_color = "#d7d8df"		// STONEKEEP EDIT


/datum/outfit/kaizoku/wayfarer // Reminder message
	var/merc_ad = "<br><font color='#855b14'><span class='bold'>If I wanted to make mammons by selling my services, or completing quests, the Mercenary guild would be a good place to start.</span></font><br>"

/datum/outfit/kaizoku/wayfarer/post_equip(mob/living/carbon/human/H)
	..()
	to_chat(H, merc_ad)

/datum/job/kaizoku/wayfarer/set_spawn_and_total_positions(count)
	// Calculate the new spawn positions
	var/new_spawn = adventurer_slot_formula(count)

	// Sync everything
	spawn_positions = new_spawn
	total_positions_so_far = new_spawn
	total_positions = new_spawn

	return spawn_positions

/datum/job/kaizoku/wayfarer/get_total_positions()
	var/slots = adventurer_slot_formula(get_total_town_members())

	if(slots <= total_positions_so_far)
		slots = total_positions_so_far
	else
		total_positions_so_far = slots

	return slots

/datum/job/advclass/kaizoku/wanderer
	abstract_type = /datum/job/advclass/kaizoku/wanderer
	category_tags = list(CTAG_WANDERER)

/datum/job/advclass/kaizoku/wanderer/rare
	abstract_type = /datum/job/advclass/kaizoku/wanderer/rare
	roll_chance = 30
