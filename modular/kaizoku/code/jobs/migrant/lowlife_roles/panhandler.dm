
/datum/job/advclass/kaizoku/lowlife/panhandler
	title = "Panhandler"
	tutorial = "You've been in this life of misery either as a branded criminal too dangerous \
	to find work, a follower of 'let it rot' philosophy, or simply unworthy of \
	becoming a benefitted for deceiving or bribing the civic order. Regardless, panhandlers \
	unbound to monasteries are despised and considered no different of society's parasites. \
	Now, forced to beg for food and kaichins, there is little for you to lose."
	allowed_sexes = list(MALE, FEMALE)
	outfit = /datum/outfit/job/lowlife/panhandler
	category_tags = list(CTAG_LOWLIFE)
	cmode_music = 'sound/blank.ogg'
	allowed_ages = ALL_AGES_LIST_BLOOMING

/datum/outfit/job/lowlife/panhandler/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	..()
	if(ishuman(H))
		var/mob/living/carbon/human/stinky_boy = H
		if(prob(25))
			stinky_boy.set_hygiene(HYGIENE_LEVEL_DISGUSTING)
		else
			stinky_boy.set_hygiene(HYGIENE_LEVEL_DIRTY)

/datum/outfit/job/lowlife/panhandler/pre_equip(mob/living/carbon/human/H)
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

/datum/outfit/job/lowlife/panhandler
	name = "Panhandler"

