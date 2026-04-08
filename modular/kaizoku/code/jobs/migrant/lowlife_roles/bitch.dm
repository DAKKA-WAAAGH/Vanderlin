/datum/job/advclass/kaizoku/lowlife/bitch// Reminder: Give them disease.
	title = "Bitch"
	tutorial = "Daily life is spiced with mysteries, yet prostitution \
	where it is forbidden is no mystery, as plenty of migrants fall \
	into this snare for rice and bread, while some other seeks to bring \
	eorite ways to the culturally prudish natives. Regardless, to live \
	as a bitch is a life running from the law, without panderer's \
	loopholes and protection like the massagers."
	allowed_sexes = list(MALE, FEMALE)
	outfit = /datum/outfit/job/lowlife/bitch
	category_tags = list(CTAG_LOWLIFE)
	cmode_music = 'sound/music/cmode/towner/CombatBeggar.ogg'
	allowed_ages = list(AGE_ADULT, AGE_MIDDLEAGED, AGE_OLD)

/datum/outfit/job/lowlife/bitch/pre_equip(mob/living/carbon/human/H)
	..()
	belt = /obj/item/storage/belt/leather/rope
	beltr = /obj/item/key/bathhouse
	beltl = /obj/item/storage/belt/pouch/nitemaiden //CHange clothes and remove this.
	shoes = /obj/item/clothing/shoes/shortboots
	if(H.mind)
		H.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE) // Might remove, and instead give them knives.
		H.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
		H.adjust_skillrank(/datum/skill/misc/sneaking, 2, TRUE)
		H.adjust_skillrank(/datum/skill/misc/stealing, pick(2,3,4), TRUE)
		H.adjust_skillrank(/datum/skill/misc/riding, 3, TRUE)//we know why
		H.adjust_skillrank(/datum/skill/misc/music, 2, TRUE)
		H.adjust_skillrank(/datum/skill/craft/crafting, 1, TRUE)
		H.adjust_skillrank(/datum/skill/misc/athletics, 1, TRUE)
		H.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
		H.adjust_skillrank(/datum/skill/craft/cooking, 1, TRUE)
	H.change_stat(STATKEY_STR, -1)
	H.change_stat(STATKEY_LCK, 1)
	H.change_stat(STATKEY_END, 1)
	H.change_stat(STATKEY_PER, 1)
	H.change_stat(STATKEY_SPD, 1)
	ADD_TRAIT(H, TRAIT_GOODLOVER, TRAIT_GENERIC)

	if(!(H.patron == /datum/patron/divine/eora || /datum/patron/inhumen/zizo))
		H.set_patron(/datum/patron/divine/eora, TRUE)
