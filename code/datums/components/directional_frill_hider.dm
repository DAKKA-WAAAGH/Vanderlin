
/atom/movable/screen/frill_direction_mask
	name = "frill direction mask"
	icon = 'code/__DEFINES/kaizojave/placeholder_icons/turf/walls/frill_direction_masks.dmi'
	icon_state = "frill_block_left"
	plane = FRILL_MASK_PLANE
	layer = FLOAT_LAYER
	appearance_flags = NO_CLIENT_COLOR | RESET_TRANSFORM | RESET_COLOR
	screen_loc = "CENTER"
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT

/datum/component/directional_frill_hider
	var/frill_icon_path
	var/current_dir = null
	var/atom/movable/screen/frill_direction_mask/mask_obj

/datum/component/directional_frill_hider/Initialize(icon_path)
	if(!ismob(parent))
		return COMPONENT_INCOMPATIBLE

	frill_icon_path = icon_path

	var/mob/target_mob = parent
	setup_mask(target_mob)
	on_direction_change(target_mob, target_mob.dir)
	RegisterSignal(parent, COMSIG_ATOM_DIR_CHANGE, PROC_REF(on_direction_change))

/datum/component/directional_frill_hider/Destroy()
	cleanup_mask()
	UnregisterSignal(parent, COMSIG_ATOM_DIR_CHANGE)
	return ..()

/datum/component/directional_frill_hider/proc/on_direction_change(atom/source, new_dir)
	SIGNAL_HANDLER
	var/mob/target = source

	if(!target.client)
		return
	current_dir = new_dir
	apply_direction(new_dir)

/datum/component/directional_frill_hider/proc/setup_mask(mob/target)
	if(!target.client)
		return
	if(mask_obj)
		cleanup_mask()
	mask_obj = new /atom/movable/screen/frill_direction_mask()
	mask_obj.icon = frill_icon_path
	if(!mask_obj.icon)
		mask_obj.icon = 'code/__DEFINES/kaizojave/placeholder_icons/turf/walls/frill_direction_masks.dmi'
	target.client.screen += mask_obj

/datum/component/directional_frill_hider/proc/apply_direction(dir)
	if(!mask_obj)
		return
	var/state = ""
	if(dir & EAST) // EAST, NORTHEAST, SOUTHEAST - block left frills
		state = "frill_block_left"
	else if(dir & WEST) // WEST, NORTHWEST, SOUTHWEST - block right frills
		state = "frill_block_right"
	else
		// NORTH or SOUTH - block nothing (back frills handled separately)
		state = ""

	if(state)
		mask_obj.icon_state = state
		mask_obj.alpha = 255
	else
		mask_obj.alpha = 0
	mask_obj.pixel_x = 0
	mask_obj.pixel_y = 0

/datum/component/directional_frill_hider/proc/cleanup_mask()
	var/mob/target = parent
	if(mask_obj)
		if(target && target.client)
			target.client.screen -= mask_obj
		qdel(mask_obj)
	mask_obj = null
