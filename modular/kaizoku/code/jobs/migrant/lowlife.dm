
/datum/job/kaizoku/lowlife
	title = "Low-life" //Change the tutorial.
	tutorial = "You belong to a social bubble know as 'Low-lives', a new fracture on \
	foglander life. Normal citizens enjoys rights and protections no state outside of \
	these islands provides, however, the lands cannot shield all who pours in from the \
	Denmorian swarms as the hate for the outsider fester dues to criminals exploiting \
	the generosity of the system, and now for many reasons, you are stranded on the \
	edge of society, with little ways to wiggle out of this."
	department_flag = FACTION_CITIZENS
	display_order = KZ_LOWLIFE
	job_flags = (JOB_ANNOUNCE_ARRIVAL | JOB_SHOW_IN_CREDITS | JOB_EQUIP_RANK | JOB_NEW_PLAYER_JOINABLE)
	total_positions = 15
	spawn_positions = 15
	// min_pq = 0 ; Stonekeep Todo - Vanderlin removed PQ, reimplement it later.
	bypass_lastclass = TRUE
	banned_leprosy = FALSE
	allowed_races = RACES_PLAYER_ALL
	outfit = null
	outfit_female = null
	can_random = FALSE
	advclass_cat_rolls = list(CTAG_LOWLIFE = 20)
	can_have_apprentices = FALSE
	is_foreigner = FALSE
	same_job_respawn_delay = 0

/datum/job/advclass/kaizoku/lowlife
	abstract_type = /datum/job/advclass/kaizoku/lowlife
	category_tags = list(CTAG_LOWLIFE)

/datum/job/advclass/kaizoku/lowlife/rare
	abstract_type = /datum/job/advclass/kaizoku/lowlife/rare
	roll_chance = 30

// Keeping this code here so we won't have 'bums' while still having bum NPCs.
// Disregard the following code;

/datum/job/vagrant/New()
	. = ..()
	peopleknowme = list()

/datum/job/vagrant/after_spawn(mob/living/spawned, client/player_client)
	..()
	if(ishuman(spawned))
		var/mob/living/carbon/human/stinky_boy = spawned
		if(prob(25))
			stinky_boy.set_hygiene(HYGIENE_LEVEL_DISGUSTING)
		else
			stinky_boy.set_hygiene(HYGIENE_LEVEL_DIRTY)

/datum/outfit/vagrant/pre_equip(mob/living/carbon/human/H)
	..()
	if(prob(20))
		head = /obj/item/clothing/head/knitcap
	if(prob(5))
		beltr = /obj/item/reagent_containers/powder/moondust
	if(prob(10))
		beltl = /obj/item/clothing/face/cigarette/rollie/cannabis
	if(prob(10))
		cloak = /obj/item/clothing/cloak/raincloak/colored/brown
	if(prob(10))
		gloves = /obj/item/clothing/gloves/fingerless
	if(H.gender == FEMALE)
		armor = /obj/item/clothing/shirt/rags
	else
		pants = /obj/item/clothing/pants/tights/colored/vagrant
		shirt = /obj/item/clothing/shirt/undershirt/colored/vagrant

	H.adjust_skillrank(/datum/skill/misc/sneaking, pick(1,2,3,4,5), TRUE)
	H.adjust_skillrank(/datum/skill/misc/stealing, pick(1,2,3,4,5), TRUE)
	H.adjust_skillrank(/datum/skill/misc/lockpicking, pick (1,2,3,4,5), TRUE) // thug life
	H.adjust_skillrank(/datum/skill/misc/climbing, pick(2,3,4,5), TRUE)
	H.adjust_skillrank(/datum/skill/combat/wrestling, pick(1,2,3), TRUE) // Street-fu
	H.adjust_skillrank(/datum/skill/combat/unarmed, pick(1,2,3), TRUE)
	H.adjust_skillrank(/datum/skill/craft/alchemy, pick(1,2,3), TRUE)
	H.base_fortune = rand(1, 20)
	H.recalculate_stats(FALSE)
	if(prob(5))
		r_hand = /obj/item/weapon/mace/woodclub
	H.change_stat(STATKEY_INT, -3)
	H.change_stat(STATKEY_CON, -2)
	H.change_stat(STATKEY_END, -2)

/datum/outfit/vagrant
	name = "Beggar"

