//THESE WALLS ARE kaizojave'S WALLS! ALL RECOGNITION GOES TO THEIR ORIGINAL CREATORS!

// The previous comment from Mojave Sun were removed as it is outdated under our new, cursed system.
// Later down the line, I shall make an text explaining this file.

#ifndef NORTH_JUNCTION
#define NORTH_JUNCTION		NORTH
#define SOUTH_JUNCTION		SOUTH
#define EAST_JUNCTION		EAST
#define WEST_JUNCTION		WEST
#define NORTHEAST_JUNCTION	(1<<4)
#define SOUTHEAST_JUNCTION	(1<<5)
#define SOUTHWEST_JUNCTION	(1<<6)
#define NORTHWEST_JUNCTION	(1<<7)
#endif

/atom
	var/mutable_appearance/top_left_corner = null
	var/mutable_appearance/top_right_corner = null
	var/mutable_appearance/bottom_right_corner = null
	var/mutable_appearance/bottom_left_corner = null

/atom/movable
	var/can_be_unanchored = FALSE

/turf/closed
	var/list/fixed_underlay = null


DEFINE_BITFIELD(smoothing_junction, list(
	"NORTH_JUNCTION" = NORTH_JUNCTION,
	"SOUTH_JUNCTION" = SOUTH_JUNCTION,
	"EAST_JUNCTION" = EAST_JUNCTION,
	"WEST_JUNCTION" = WEST_JUNCTION,
	"NORTHEAST_JUNCTION" = NORTHEAST_JUNCTION,
	"SOUTHEAST_JUNCTION" = SOUTHEAST_JUNCTION,
	"SOUTHWEST_JUNCTION" = SOUTHWEST_JUNCTION,
	"NORTHWEST_JUNCTION" = NORTHWEST_JUNCTION,
))

//#define NO_ADJ_FOUND 0
//#define ADJ_FOUND 1
//#define NULLTURF_BORDER 2

//#define DEFAULT_UNDERLAY_ICON 'icons/turf/floors.dmi'
//#define DEFAULT_UNDERLAY_ICON_STATE "plating"

// Kaizojave's own macro for adjacency smoothing
#define KJ_SET_ADJ_IN_DIR(direction, direction_flag) \
do { \
	var/turf/neighbor = get_step(src, direction); \
	if(!neighbor) { \
		if(src.smoothing_flags & SMOOTH_BORDER) { \
			new_junction |= direction_flag; \
		}; \
	} \
	else { \
		if(!isnull(neighbor.smoothing_groups)) { \
			for(var/target in src.smoothing_list) { \
				if(!(src.smoothing_list[target] & neighbor.smoothing_groups[target])) { \
					continue; \
				}; \
				new_junction |= direction_flag; \
				break; \
			}; \
		}; \
		if(!(new_junction & direction_flag) && src.smoothing_flags & SMOOTH_OBJ) { \
			for(var/obj/thing in neighbor) { \
				if(!thing.anchored || isnull(thing.smoothing_groups)) { \
					continue; \
				}; \
				for(var/target in src.smoothing_list) { \
					if(!(src.smoothing_list[target] & thing.smoothing_groups[target])) { \
						continue; \
					}; \
					new_junction |= direction_flag; \
					break; \
				}; \
				if(new_junction & direction_flag) { \
					break; \
				}; \
			}; \
		}; \
	}; \
} while(FALSE)

///Scans all adjacent turfs to find targets to smooth with.
/atom/proc/calculate_adjacencies()
	. = NONE

	if(!loc)
		return

	for(var/direction in GLOB.cardinals)
		switch(find_type_in_direction(direction))
			if(NULLTURF_BORDER)
				if((smoothing_flags & SMOOTH_BORDER))
					. |= direction //BYOND and smooth dirs are the same for cardinals
			if(ADJ_FOUND)
				. |= direction //BYOND and smooth dirs are the same for cardinals

	if(. & NORTH_JUNCTION)
		if(. & WEST_JUNCTION)
			switch(find_type_in_direction(NORTHWEST))
				if(NULLTURF_BORDER)
					if((smoothing_flags & SMOOTH_BORDER))
						. |= NORTHWEST_JUNCTION
				if(ADJ_FOUND)
					. |= NORTHWEST_JUNCTION

		if(. & EAST_JUNCTION)
			switch(find_type_in_direction(NORTHEAST))
				if(NULLTURF_BORDER)
					if((smoothing_flags & SMOOTH_BORDER))
						. |= NORTHEAST_JUNCTION
				if(ADJ_FOUND)
					. |= NORTHEAST_JUNCTION

	if(. & SOUTH_JUNCTION)
		if(. & WEST_JUNCTION)
			switch(find_type_in_direction(SOUTHWEST))
				if(NULLTURF_BORDER)
					if((smoothing_flags & SMOOTH_BORDER))
						. |= SOUTHWEST_JUNCTION
				if(ADJ_FOUND)
					. |= SOUTHWEST_JUNCTION

		if(. & EAST_JUNCTION)
			switch(find_type_in_direction(SOUTHEAST))
				if(NULLTURF_BORDER)
					if((smoothing_flags & SMOOTH_BORDER))
						. |= SOUTHEAST_JUNCTION
				if(ADJ_FOUND)
					. |= SOUTHEAST_JUNCTION


/atom/movable/calculate_adjacencies()
	if(can_be_unanchored && !anchored)
		return NONE
	return ..()

// Base smooth_icon is in code/__HELPERS/icon_smoothing.dm
// This override handles corner-based smoothing
/atom/smooth_icon()
	smoothing_flags &= ~SMOOTH_QUEUED
	if (!z)
		CRASH("[type] called smooth_icon() without being on a z-level")
	if(smoothing_flags & SMOOTH_CORNERS)
		if(smoothing_flags & SMOOTH_DIAGONAL_CORNERS)
			corners_diagonal_smooth(calculate_adjacencies())
		else
			corners_cardinal_smooth(calculate_adjacencies())
		SEND_SIGNAL(src, COMSIG_ATOM_SMOOTHED_ICON)
		update_appearance(~UPDATE_SMOOTHING)
	else if(smoothing_flags & SMOOTH_BITMASK)
		..() // Call base bitmask smoothing
	else if(smoothing_flags & SMOOTH_BITMASK_CARDINALS)
		..() // Call base cardinal bitmask smoothing
	else if(smoothing_flags & SMOOTH_EDGE)
		..() // Fall back to base edge smoothing instead of crashing
	else
		CRASH("smooth_icon called for [src] with smoothing_flags == [smoothing_flags]")


/atom/proc/corners_diagonal_smooth(adjacencies)
	switch(adjacencies)
		if(NORTH_JUNCTION|WEST_JUNCTION)
			replace_smooth_overlays("d-se","d-se-0")
		if(NORTH_JUNCTION|EAST_JUNCTION)
			replace_smooth_overlays("d-sw","d-sw-0")
		if(SOUTH_JUNCTION|WEST_JUNCTION)
			replace_smooth_overlays("d-ne","d-ne-0")
		if(SOUTH_JUNCTION|EAST_JUNCTION)
			replace_smooth_overlays("d-nw","d-nw-0")

		if(NORTH_JUNCTION|WEST_JUNCTION|NORTHWEST_JUNCTION)
			replace_smooth_overlays("d-se","d-se-1")
		if(NORTH_JUNCTION|EAST_JUNCTION|NORTHEAST_JUNCTION)
			replace_smooth_overlays("d-sw","d-sw-1")
		if(SOUTH_JUNCTION|WEST_JUNCTION|SOUTHWEST_JUNCTION)
			replace_smooth_overlays("d-ne","d-ne-1")
		if(SOUTH_JUNCTION|EAST_JUNCTION|SOUTHEAST_JUNCTION)
			replace_smooth_overlays("d-nw","d-nw-1")

		else
			corners_cardinal_smooth(adjacencies)
			return FALSE

	icon_state = ""
	return TRUE


/atom/proc/corners_cardinal_smooth(adjacencies)
	var/mutable_appearance/temp_ma

	var/nw = "1-i" //NW CORNER
	if((adjacencies & NORTH_JUNCTION) && (adjacencies & WEST_JUNCTION))
		if(adjacencies & NORTHWEST_JUNCTION)
			nw = "1-f"
		else
			nw = "1-nw"
	else
		if(adjacencies & NORTH_JUNCTION)
			nw = "1-n"
		else if(adjacencies & WEST_JUNCTION)
			nw = "1-w"
	temp_ma = mutable_appearance(icon, nw)
	nw = temp_ma.appearance

	var/ne = "2-i" //NE CORNER
	if((adjacencies & NORTH_JUNCTION) && (adjacencies & EAST_JUNCTION))
		if(adjacencies & NORTHEAST_JUNCTION)
			ne = "2-f"
		else
			ne = "2-ne"
	else
		if(adjacencies & NORTH_JUNCTION)
			ne = "2-n"
		else if(adjacencies & EAST_JUNCTION)
			ne = "2-e"
	temp_ma = mutable_appearance(icon, ne)
	ne = temp_ma.appearance

	var/sw = "3-i" //SW CORNER
	if((adjacencies & SOUTH_JUNCTION) && (adjacencies & WEST_JUNCTION))
		if(adjacencies & SOUTHWEST_JUNCTION)
			sw = "3-f"
		else
			sw = "3-sw"
	else
		if(adjacencies & SOUTH_JUNCTION)
			sw = "3-s"
		else if(adjacencies & WEST_JUNCTION)
			sw = "3-w"
	temp_ma = mutable_appearance(icon, sw)
	sw = temp_ma.appearance

	var/se = "4-i" //SE CORNER
	if((adjacencies & SOUTH_JUNCTION) && (adjacencies & EAST_JUNCTION))
		if(adjacencies & SOUTHEAST_JUNCTION)
			se = "4-f"
		else
			se = "4-se"
	else
		if(adjacencies & SOUTH_JUNCTION)
			se = "4-s"
		else if(adjacencies & EAST_JUNCTION)
			se = "4-e"
	temp_ma = mutable_appearance(icon, se)
	se = temp_ma.appearance

	var/list/new_overlays

	if(top_left_corner != nw)
		cut_overlay(top_left_corner)
		top_left_corner = nw
		if(!new_overlays) { new_overlays = list(); } new_overlays += nw
	if(top_right_corner != ne)
		cut_overlay(top_right_corner)
		top_right_corner = ne
		if(!new_overlays) { new_overlays = list(); } new_overlays += ne
	if(bottom_right_corner != sw)
		cut_overlay(bottom_right_corner)
		bottom_right_corner = sw
		if(!new_overlays) { new_overlays = list(); } new_overlays += sw
	if(bottom_left_corner != se)
		cut_overlay(bottom_left_corner)
		bottom_left_corner = se
		if(!new_overlays) { new_overlays = list(); } new_overlays += se
	if(new_overlays)
		add_overlay(new_overlays)


/atom/proc/find_type_in_direction(direction) ///Scans direction to find targets to smooth with.

	var/turf/target_turf = get_step(src, direction)
	if(!target_turf)
		return NULLTURF_BORDER

	if(isnull(smoothing_list)) //special case in which it will only smooth with itself
		if(isturf(src))
			return (type == target_turf.type) ? ADJ_FOUND : NO_ADJ_FOUND
		var/atom/matching_obj = locate(type) in target_turf
		return (matching_obj && matching_obj.type == type) ? ADJ_FOUND : NO_ADJ_FOUND

	if(!isnull(target_turf.smoothing_groups))
		for(var/target in smoothing_list)
			if(!(smoothing_list[target] & target_turf.smoothing_groups[target]))
				continue
			return ADJ_FOUND

	if(smoothing_flags & SMOOTH_OBJ)
		for(var/am in target_turf)
			var/atom/movable/thing = am
			if(!thing.anchored || isnull(thing.smoothing_groups))
				continue
			for(var/target in smoothing_list)
				if(!(smoothing_list[target] & thing.smoothing_groups[target]))
					continue
				return ADJ_FOUND

	return NO_ADJ_FOUND

/atom/proc/bitmask_smooth()
	var/new_junction = NONE

	for(var/direction in GLOB.cardinals) //Cardinal case first.
		KJ_SET_ADJ_IN_DIR(direction, direction)

	if(!(new_junction & (NORTH|SOUTH)) || !(new_junction & (EAST|WEST)))
		set_smoothed_icon_state(new_junction)
		return

	if(new_junction & NORTH_JUNCTION)
		if(new_junction & WEST_JUNCTION)
			KJ_SET_ADJ_IN_DIR(NORTHWEST, NORTHWEST_JUNCTION)

		if(new_junction & EAST_JUNCTION)
			KJ_SET_ADJ_IN_DIR(NORTHEAST, NORTHEAST_JUNCTION)

	if(new_junction & SOUTH_JUNCTION)
		if(new_junction & WEST_JUNCTION)
			KJ_SET_ADJ_IN_DIR(SOUTHWEST, SOUTHWEST_JUNCTION)

		if(new_junction & EAST_JUNCTION)
			KJ_SET_ADJ_IN_DIR(SOUTHEAST, SOUTHEAST_JUNCTION)

	set_smoothed_icon_state(new_junction)

/turf/closed/set_smoothed_icon_state(new_junction)
	. = ..()
	if(smoothing_flags & SMOOTH_DIAGONAL_CORNERS)
		switch(new_junction)
			if(
				NORTH_JUNCTION|WEST_JUNCTION,
				NORTH_JUNCTION|EAST_JUNCTION,
				SOUTH_JUNCTION|WEST_JUNCTION,
				SOUTH_JUNCTION|EAST_JUNCTION,
				NORTH_JUNCTION|WEST_JUNCTION|NORTHWEST_JUNCTION,
				NORTH_JUNCTION|EAST_JUNCTION|NORTHEAST_JUNCTION,
				SOUTH_JUNCTION|WEST_JUNCTION|SOUTHWEST_JUNCTION,
				SOUTH_JUNCTION|EAST_JUNCTION|SOUTHEAST_JUNCTION
				)
				icon_state = "[base_icon_state]-[smoothing_junction]-d"
				if(!fixed_underlay && new_junction != .) // Mutable underlays?
					var/junction_dir = reverse_ndir(smoothing_junction)
					var/turned_adjacency = REVERSE_DIR(junction_dir)
					var/turf/neighbor_turf = get_step(src, turned_adjacency & (NORTH|SOUTH))
					var/mutable_appearance/underlay_appearance = mutable_appearance(layer = TURF_LAYER, plane = FLOOR_PLANE)
					if(!neighbor_turf.get_smooth_underlay_icon(underlay_appearance, src, turned_adjacency))
						neighbor_turf = get_step(src, turned_adjacency & (EAST|WEST))

						if(!neighbor_turf.get_smooth_underlay_icon(underlay_appearance, src, turned_adjacency))
							neighbor_turf = get_step(src, turned_adjacency)

							if(!neighbor_turf.get_smooth_underlay_icon(underlay_appearance, src, turned_adjacency))
								if(!get_smooth_underlay_icon(underlay_appearance, src, turned_adjacency)) //if all else fails, ask our own turf
									underlay_appearance.icon = DEFAULT_UNDERLAY_ICON
									underlay_appearance.icon_state = DEFAULT_UNDERLAY_ICON_STATE
					underlays += underlay_appearance

/turf/open/floor/set_smoothed_icon_state(new_junction)
	if(broken || burnt)
		return
	return ..()

/atom/proc/clear_smooth_overlays()
	cut_overlay(top_left_corner)
	top_left_corner = null
	cut_overlay(top_right_corner)
	top_right_corner = null
	cut_overlay(bottom_right_corner)
	bottom_right_corner = null
	cut_overlay(bottom_left_corner)
	bottom_left_corner = null

/// Essentially, this takes icon states as text
/atom/proc/replace_smooth_overlays(nw, ne, sw, se)
	clear_smooth_overlays()
	var/mutable_appearance/temp_ma

	temp_ma = mutable_appearance(icon, nw)
	nw = temp_ma.appearance

	temp_ma = mutable_appearance(icon, ne)
	ne = temp_ma.appearance

	temp_ma = mutable_appearance(icon, sw)
	sw = temp_ma.appearance

	temp_ma = mutable_appearance(icon, se)
	se = temp_ma.appearance

	var/list/new_overlays = list()

	top_left_corner = nw
	new_overlays += nw

	top_right_corner = ne
	new_overlays += ne

	bottom_left_corner = sw
	new_overlays += sw

	bottom_right_corner = se
	new_overlays += se

	add_overlay(new_overlays)


/proc/reverse_ndir(ndir)
	switch(ndir)
		if(NORTH_JUNCTION)
			return NORTH
		if(SOUTH_JUNCTION)
			return SOUTH
		if(WEST_JUNCTION)
			return WEST
		if(EAST_JUNCTION)
			return EAST
		if(NORTHWEST_JUNCTION)
			return NORTHWEST
		if(NORTHEAST_JUNCTION)
			return NORTHEAST
		if(SOUTHEAST_JUNCTION)
			return SOUTHEAST
		if(SOUTHWEST_JUNCTION)
			return SOUTHWEST
		if(NORTH_JUNCTION | WEST_JUNCTION)
			return NORTHWEST
		if(NORTH_JUNCTION | EAST_JUNCTION)
			return NORTHEAST
		if(SOUTH_JUNCTION | WEST_JUNCTION)
			return SOUTHWEST
		if(SOUTH_JUNCTION | EAST_JUNCTION)
			return SOUTHEAST
		if(NORTH_JUNCTION | WEST_JUNCTION | NORTHWEST_JUNCTION)
			return NORTHWEST
		if(NORTH_JUNCTION | EAST_JUNCTION | NORTHEAST_JUNCTION)
			return NORTHEAST
		if(SOUTH_JUNCTION | WEST_JUNCTION | SOUTHWEST_JUNCTION)
			return SOUTHWEST
		if(SOUTH_JUNCTION | EAST_JUNCTION | SOUTHEAST_JUNCTION)
			return SOUTHEAST
		else
			return NONE
