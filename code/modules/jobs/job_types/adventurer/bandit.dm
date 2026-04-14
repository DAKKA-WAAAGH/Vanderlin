/datum/job/bandit //pysdon above there's like THREE bandit.dms now I'm so sorry. This one is latejoin bandits, the one in villain is the antag datum, and the one in the 'antag' folder is an old adventurer class we don't use. Good luck!
	title = "Bandit"
	tutorial = "Long ago, you fucked up, your crime considered more serious than gangster activity. \
	Now, you're being hunted down like an animal. There is eels on your body, \
	no one believes you!"
	department_flag = FACTION_VILLAIN
	job_flags = (JOB_EQUIP_RANK | JOB_NEW_PLAYER_JOINABLE | JOB_SHOW_IN_CREDITS)
	display_order = KZ_BANDIT
	faction = FACTION_NEUTRAL
	total_positions = 6
	spawn_positions = 4
	antag_job = TRUE

	advclass_cat_rolls = list(CTAG_BANDIT = 20)
	// blacklisted_species = list(SPEC_ID_HALFLING //Stonekeep Edit

	is_foreigner = TRUE
	job_reopens_slots_on_death = FALSE //no endless stream of bandits, unless the migration waves deem it so
	same_job_respawn_delay = 30 MINUTES

	can_have_apprentices = FALSE
	cmode_music = 'modular/kaizoku/sound/music/cmode/antag/combat_bandit2.ogg'

	traits = list(TRAIT_NOAMBUSH)

	antag_role = /datum/antagonist/bandit

	exp_type = list(EXP_TYPE_LIVING)
	exp_types_granted = list(EXP_TYPE_COMBAT)
	exp_requirements = list(
		EXP_TYPE_LIVING = 900
	)
/datum/job/advclass/bandit
	exp_types_granted = list(EXP_TYPE_COMBAT)
	spawn_with_torch = TRUE
