#define SPEC_ID_HUMEN "human"
#define SPEC_ID_DWARF "dwarf"
#define SPEC_ID_AASIMAR "aasimar"
#define SPEC_ID_ELF "elf"
#define SPEC_ID_TIEFLING "tiefling"
#define SPEC_ID_CHANGELING "changeling"
#define SPEC_ID_SKYLANCER "skylancer"
#define SPEC_ID_OGRUN "ogrun"
#define SPEC_ID_UNDINE "undine"
#define SPEC_ID_SUNSCORNED "sunscorned"
#define SPEC_ID_VESSEL "vessel"
#define SPEC_ID_GROVELING "groveling"
#define SPEC_ID_DENMORIAN "denmorian"

#define SPEC_ID_ORC	"orc"
#define SPEC_ID_GOBLIN	"goblin"
#define SPEC_ID_ROUSMAN	"rousman"
#define SPEC_ID_ZIZOMBIE "zizombie"

/// List of all species
#define ALL_RACES_LIST list(\
	SPEC_ID_HUMEN,\
	SPEC_ID_DWARF,\
	SPEC_ID_AASIMAR,\
	SPEC_ID_ELF,\
	SPEC_ID_TIEFLING,\
	SPEC_ID_CHANGELING,\
	SPEC_ID_SKYLANCER,\
	SPEC_ID_OGRUN,\
	SPEC_ID_UNDINE,\
	SPEC_ID_SUNSCORNED,\
	SPEC_ID_VESSEL,\
	SPEC_ID_GROVELING,\
	SPEC_ID_DENMORIAN,\
	SPEC_ID_ORC,\
	SPEC_ID_GOBLIN,\
	SPEC_ID_ROUSMAN,\
	SPEC_ID_ZIZOMBIE,\
)

/// Species where females get underwear, dwarves handled seperately
#define RACES_UNDERWEAR_FEMALE list(\
	SPEC_ID_HUMEN,\
	SPEC_ID_AASIMAR,\
	SPEC_ID_ELF,\
	SPEC_ID_TIEFLING,\
	SPEC_ID_CHANGELING,\
	SPEC_ID_SKYLANCER,\
	SPEC_ID_OGRUN,\
	SPEC_ID_UNDINE,\
	SPEC_ID_SUNSCORNED,\
	SPEC_ID_VESSEL,\
	SPEC_ID_GROVELING,\
	SPEC_ID_DENMORIAN,\
)

/// Species where males get underwear, identical to above, elves handled seperately
#define RACES_UNDERWEAR_MALE list(\
	SPEC_ID_HUMEN,\
	SPEC_ID_AASIMAR,\
	SPEC_ID_TIEFLING,\
	SPEC_ID_CHANGELING,\
	SPEC_ID_OGRUN,\
	SPEC_ID_SUNSCORNED,\
	SPEC_ID_VESSEL,\
	SPEC_ID_GROVELING,\
	SPEC_ID_DENMORIAN,\
)

// ============ USING NAME
/// All playable species from character selection menu.
#define RACES_PLAYER_ALL list(\
	SPEC_ID_HUMEN,\
	SPEC_ID_DWARF,\
	SPEC_ID_AASIMAR,\
	SPEC_ID_ELF,\
	SPEC_ID_TIEFLING,\
	SPEC_ID_CHANGELING,\
	SPEC_ID_SKYLANCER,\
	SPEC_ID_OGRUN,\
	SPEC_ID_UNDINE,\
	SPEC_ID_SUNSCORNED,\
	SPEC_ID_VESSEL,\
	SPEC_ID_GROVELING,\
	SPEC_ID_DENMORIAN,\
)

//Essentially all Citizen roles. Does not include thirdclass players, that are non-citizens.
#define RACES_CITIZEN_PLAYERS list(\
	SPEC_ID_HUMEN,\
	SPEC_ID_DWARF,\
	SPEC_ID_CHANGELING,\
	SPEC_ID_SKYLANCER,\
	SPEC_ID_OGRUN,\
	SPEC_ID_UNDINE,\
	SPEC_ID_AASIMAR,\
	SPEC_ID_ELF,\
	SPEC_ID_SUNSCORNED,\
	SPEC_ID_VESSEL,\
)

// Native races only. Only for matters related to the ancient champions or Capital Guard.
#define RACE_NATIVE_PLAYERS list(\
	SPEC_ID_CHANGELING,\
	SPEC_ID_SKYLANCER,\
	SPEC_ID_OGRUN,\
	SPEC_ID_UNDINE,\
)

/// First class citizens. Highly important members of society that
// have all citizen rights and right to rule.
// The explanation is simple - First class members receives rights
// from the main Government imperial regime and the sovereignty's land.
// May change 'Undine' to 'Vessel' later.
// Humen and Dwarves are not natives, and will swap out between First and Second class citizens.
#define RACES_FIRSTCLASS_PLAYERS list(\
	SPEC_ID_HUMEN,\
	SPEC_ID_DWARF,\
	SPEC_ID_CHANGELING,\
	SPEC_ID_SKYLANCER,\
	SPEC_ID_OGRUN,\
	SPEC_ID_UNDINE,\
)

// Second class citizens, specifically. They still majorly
// of citizen rights, but has no right to rule.
// The explanation is simple - Second class members receives
// rights from the sovereignty's land, but not the imperial regime.
#define RACES_SECONDCLASS_PLAYERS list(\
	SPEC_ID_AASIMAR,\
	SPEC_ID_ELF,\
	SPEC_ID_SUNSCORNED,\
	SPEC_ID_VESSEL,\
)

// Non-citizens, specifically. They don't have citizen rights,
// and can be victims of tsujigiri. Pretty much made to be bullied
#define RACES_THIRDCLASS_PLAYERS list(\
	SPEC_ID_GROVELING,\
	SPEC_ID_DENMORIAN,\
	SPEC_ID_TIEFLING,\
)

#define RACES_NOTNATIVE list(\
	SPEC_ID_HUMEN,\
	SPEC_ID_DWARF,\
	SPEC_ID_AASIMAR,\
	SPEC_ID_ELF,\
	SPEC_ID_TIEFLING,\
	SPEC_ID_SUNSCORNED,\
	SPEC_ID_VESSEL,\
	SPEC_ID_GROVELING,\
	SPEC_ID_DENMORIAN,\
)

#define NON_HERETICAL list(\
	SPEC_ID_HUMEN,\
	SPEC_ID_DWARF,\
	SPEC_ID_AASIMAR,\
	SPEC_ID_ELF,\
	SPEC_ID_CHANGELING,\
	SPEC_ID_SKYLANCER,\
	SPEC_ID_OGRUN,\
	SPEC_ID_UNDINE,\
	SPEC_ID_VESSEL,\
)

//The ultimate racists
#define RACES_NOTNATIVE_NONHERETICAL list(\
	SPEC_ID_HUMEN,\
	SPEC_ID_DWARF,\
	SPEC_ID_AASIMAR,\
	SPEC_ID_ELF,\
)

/// Species who are affiliated with Grenzelhoft or Psydon specifically. Aka, antags.
#define RACES_PLAYER_GRENZ list(\
	SPEC_ID_HUMEN,\
	SPEC_ID_DWARF,\
	SPEC_ID_AASIMAR,\
)

/// Species who are affiliated with Zybantine
#define RACES_PLAYER_ZYBANTINE list(\
	SPEC_ID_HUMEN,\
	SPEC_ID_ELF,\
	SPEC_ID_DWARF,\
)

/// We only have one type of elf on Kaizoku. They are split similarly.
#define RACES_PLAYER_ELF_ALL list(\
	SPEC_ID_ELF,\
)

/// Species that use the base human body, adjusted or otherwise.
#define SPECIES_BASE_BODY list(\
	SPEC_ID_HUMEN,\
	SPEC_ID_CHANGELING,\
	SPEC_ID_SKYLANCER,\
	SPEC_ID_OGRUN,\
	SPEC_ID_AASIMAR,\
	SPEC_ID_ELF,\
	SPEC_ID_SUNSCORNED,\
	SPEC_ID_VESSEL,\
	SPEC_ID_ZIZOMBIE,\
)
