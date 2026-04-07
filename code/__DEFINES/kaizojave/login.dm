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

//Stonekeep Todo:
//What to do later: Make this character's player bound, not client bound.
//If you look at 'a distance', you will see it going far away from the player character.

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
		if(NORTH) // North is unused
			target_state = "north"
			//offset_x = -16
			//offset_y = 126
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

