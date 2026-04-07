/**
 * Run when a client is put in this mob or reconnects to byond and their client was on this mob
 *
 * Things it does:
 * * Adds player to player_list
 * * sets lastKnownIP
 * * sets computer_id
 * * logs the login
 * * tells the world to update it's status (for player count)
 * * create mob huds for the mob if needed
 * * reset next_move to 1
 * * parent call
 * * if the client exists set the perspective to the mob loc
 * * call on_log on the loc (sigh)
 * * reload the huds for the mob
 * * reload all full screen huds attached to this mob
 * * load any global alternate apperances
 * * sync the mind datum via sync_mind()
 * * call any client login callbacks that exist
 * * grant any actions the mob has to the client
 * * calls [auto_deadmin_on_login](mob.html#proc/auto_deadmin_on_login)
 * * send signal COMSIG_MOB_CLIENT_LOGIN
 */


/mob/Login()
	if(QDELETED(src) || QDELETED(client))
		return
	GLOB.player_list |= src
	lastKnownIP	= client.address
	computer_id	= client.computer_id
	log_access("Mob Login: [key_name(src)] was assigned to a [type]")
	world.update_status()
	client.screen = list()				//remove hud items just in case
	client.images = list()

	if(!hud_used)
		create_mob_hud()
	if(hud_used && client && client.prefs)
		hud_used.show_hud(hud_used.hud_version)
		hud_used.update_ui_style(ui_style2icon(client.prefs.UI_style))
	setup_frill_mask_overlay()

	next_move = 1

	..()
	SEND_SIGNAL(src, COMSIG_MOB_LOGIN)

	if (client && key != client.key)
		key = client.key
	reset_perspective(loc)

	if(loc)
		loc.on_log(TRUE)

	//readd this mob's HUDs (antag, med, etc)
	reload_huds()

	reload_fullscreen() // Reload any fullscreen overlays this mob has.

	add_click_catcher()

	sync_mind()

	//Reload alternate appearances
	for(var/v in GLOB.active_alternate_appearances)
		if(!v)
			continue
		var/datum/atom_hud/alternate_appearance/AA = v
		AA.onNewMob(src)

	update_client_colour()
	update_mouse_pointer()
	update_ambience_area(get_area(src))

	if(!can_hear())
		stop_sound_channel(CHANNEL_AMBIENCE)

	if(client)
		if(client.player_details.player_actions.len)
			for(var/datum/action/A in client.player_details.player_actions)
				A.Grant(src)

		for(var/datum/callback/CB as anything in client.player_details.post_login_callbacks)
			CB.Invoke()
		log_played_names(client.ckey,name,real_name)
		auto_deadmin_on_login()

	if(SSticker.current_state == GAME_STATE_FINISHED)
		do_game_over()

	log_message("Client [key_name(src)] has taken ownership of mob [src]([src.type])", LOG_OWNERSHIP)
	enable_client_mobs_in_contents(client)

	SEND_SIGNAL(src, COMSIG_MOB_CLIENT_LOGIN, client)
	addtimer(CALLBACK(src, PROC_REF(send_pref_messages)), 2 SECONDS)
	if(client.holder)
		client.hearallasghost()
	resend_all_uis()
	if(client)
		client.preload_music()

/mob/var/atom/movable/screen/frill_mask_overlay/frill_mask_overlay = null
/mob/var/frill_mask_signals_set = FALSE
/mob/var/frill_mask_last_dir = null
/mob/var/frill_mask_last_state = null
/mob/var/frill_mask_last_x = null
/mob/var/frill_mask_last_y = null

/mob/proc/setup_frill_mask_overlay()
	if(!client)
		return
	if(!isliving(src))
		return
	if(!frill_mask_overlay)
		frill_mask_overlay = new /atom/movable/screen/frill_mask_overlay()
		frill_mask_overlay.pixel_x = -112
		frill_mask_overlay.pixel_y = 16

	client.screen += frill_mask_overlay

	update_frill_mask_direction(src, dir)

	if(!frill_mask_signals_set)
		RegisterSignal(src, COMSIG_ATOM_DIR_CHANGE, PROC_REF(update_frill_mask_direction))
		frill_mask_signals_set = TRUE

/mob/proc/update_frill_mask_direction(atom/source, new_dir)
	SIGNAL_HANDLER
	if(!frill_mask_overlay)
		return
	if(new_dir == frill_mask_last_dir)
		return

	var/target_state = "south"
	var/offset_x = 0
	var/offset_y = 0
	var/base_x = -120
	var/base_y = -120

	switch(new_dir)
		if(NORTH)
			target_state = "north"
		if(SOUTH)
			target_state = "south"
			offset_x = 16
			offset_y = -100
		if(EAST)
			target_state = "east"
			offset_x = 120
			offset_y = 8
		if(WEST)
			target_state = "west"
			offset_x = -100
			offset_y = 8

	var/new_x = base_x + offset_x
	var/new_y = base_y + offset_y
	if(target_state == frill_mask_last_state && new_x == frill_mask_last_x && new_y == frill_mask_last_y)
		return

	frill_mask_overlay.icon_state = target_state
	frill_mask_overlay.screen_loc = "CENTER:[new_x],CENTER:[new_y]"
	frill_mask_last_dir = new_dir
	frill_mask_last_state = target_state
	frill_mask_last_x = new_x
	frill_mask_last_y = new_y

/mob/proc/on_frill_mask_pre_move(datum/source, list/move_args)
	SIGNAL_HANDLER
	var/new_dir = move_args[MOVE_ARG_DIRECTION]
	if(new_dir)
		update_frill_mask_direction(src, new_dir)

/mob/living/face_atom(atom/A)
	var/olddir = dir
	. = ..()
	if(dir != olddir)
		update_frill_mask_direction(src, dir)

/mob/proc/send_pref_messages()
	if(client?.prefs)
		for(var/message in client.prefs.preference_message_list)
			to_chat(src, message)

/**
 * Checks if the attached client is an admin and may deadmin them
 *
 * Configs:
 * * flag/auto_deadmin_players
 * * client.prefs?.toggles & DEADMIN_ALWAYS
 * * User is antag and flag/auto_deadmin_antagonists or client.prefs?.toggles & DEADMIN_ANTAGONIST
 * * or if their job demands a deadminning SSjob.handle_auto_deadmin_roles()
 *
 * Called from [login](mob.html#proc/Login)
 */
/mob/proc/auto_deadmin_on_login() //return true if they're not an admin at the end.
	if(!client?.holder)
		return TRUE
	if(CONFIG_GET(flag/auto_deadmin_players) || (client.prefs?.toggles & DEADMIN_ALWAYS))
		return client.holder.auto_deadmin()
	if(mind.has_antag_datum(/datum/antagonist) && (CONFIG_GET(flag/auto_deadmin_antagonists) || client.prefs?.toggles & DEADMIN_ANTAGONIST))
		return client.holder.auto_deadmin()
	if(job)
		return SSjob.handle_auto_deadmin_roles(client, job)
