// This file was removed from Vanderlin Upstream.
// In the future, merge this:
// with code\__HELPERS\_lists.dm, or code\__DEFINES\components.dm.

#define SMOOTH_CORNERS (1<<6)
#define SMOOTH_DIAGONAL_CORNERS (1<<7)

// Signal for smoothing icon state changes
#define COMSIG_ATOM_SET_SMOOTHED_ICON_STATE "atom_set_smoothed_icon_state"

// Keybinding signal for frill toggle
#define COMSIG_KB_CLIENT_MINIMALHUD_DOWN "keybinding_client_minimalhud_down"

// Global mob login signal
#define COMSIG_GLOB_MOB_LOGGED_IN "!mob_logged_in"

// HTML flags
#define HTML_USE_INITAL_ICON_1 (1<<29)

// Traits for climbable element
#define TRAIT_CLIMBABLE "climbable"
#define TRAIT_FREERUNNING "freerunning"

// Plane defines for wallening rendering system
#define WALL_PLANE -50
#define OVER_TILE_PLANE -51
#define UNDER_FRILL_PLANE 245
#define UNDER_FRILL_RENDER_TARGET "*UNDER_RENDER_TARGET"
#define FRILL_PLANE 246
#define OVER_FRILL_PLANE 247
#define FRILL_MASK_PLANE 248
#define FRILL_MASK_RENDER_TARGET "*FRILL_MASK_RENDER_TARGET"
// Mask/filter keys
#define FRILL_FLOOR_CUT "frill floor cut"
#define FRILL_GAME_CUT "frill game cut"
#define FRILL_MOB_MASK "frill mob mask"
//#define LAZYACCESS(L, I) (L ? (isnum(I) ? (I > 0 && I <= length(L) ? L[I] : null) : L[I]) : null)
//#define LAZYADD(L, I) if(!L) { L = list(); } L += I;
//#define LAZYREMOVEASSOC(L, K, V) if(L) { if(L[K]) { L[K] -= V; if(!length(L[K])) L -= K; } if(!length(L)) L = null; }

#define is_type_in_typecache(A, L) (A && length(L) && L[(ispath(A) ? A : A:type)])
