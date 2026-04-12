/datum/job/advclass/kaizoku/lowlife/pusher
	title = "Pusher"
	tutorial = "Most drugs are illegal on Fog Islands, yet it did not stop outsiders \
	from keeping the spice flowing while hidden among refugees. \
	Traffickers such as you feed the drug trade, despite the ruthless \
	syndicate of the panderer that claims dominion over it. Nonetheless, \
	a small prawn can still weave their network with Rockhillian's black \
	market, where the tunnels on the sewers have all the discreet contacts you need."
	allowed_sexes = list(MALE, FEMALE)
	outfit = /datum/outfit/kaizoku/lowlife/pusher
	category_tags = list(CTAG_LOWLIFE)
	cmode_music = 'sound/blank.ogg'
	allowed_ages = ALL_AGES_LIST_BLOOMING
	give_bank_account = 5 //You will need your bank account for this one.

/datum/outfit/kaizoku/lowlife/pusher
	head = /obj/item/clothing/head/roguehood/colored/black
	backl = /obj/item/storage/backpack/satchel/pusher
	shoes = /obj/item/clothing/shoes/simpleshoes
	beltl = /obj/item/storage/belt/pouch/coins/poor
	shirt = /obj/item/clothing/shirt/undershirt/colored/random
	pants = /obj/item/clothing/pants/tights/colored/random
	neck = /obj/item/storage/belt/pouch/cloth
	belt = /obj/item/storage/belt/leather/rope

/datum/outfit/kaizoku/lowlife/pusher/pre_equip(mob/living/carbon/human/H)
	..()
	if(H.mind)
		H.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
		H.adjust_skillrank(/datum/skill/combat/wrestling, 1, TRUE)
		H.adjust_skillrank(/datum/skill/combat/unarmed, 1, TRUE)
		H.adjust_skillrank(/datum/skill/misc/athletics, 1, TRUE)
		H.adjust_skillrank(/datum/skill/misc/sneaking, 3, TRUE)
		H.adjust_skillrank(/datum/skill/misc/stealing, 3, TRUE)
		H.adjust_skillrank(/datum/skill/misc/reading, 2, TRUE)
		H.adjust_skillrank(/datum/skill/craft/alchemy, pick(2,5), TRUE)
		H.adjust_skillrank(/datum/skill/misc/medicine, 1, TRUE)
		H.adjust_skillrank(/datum/skill/craft/crafting, 3, TRUE)
	H.change_stat(STATKEY_INT, 2)
	H.change_stat(STATKEY_PER, 1)
	H.change_stat(STATKEY_SPD, -1)
	ADD_TRAIT(H, TRAIT_FORAGER, TRAIT_GENERIC)

/obj/item/storage/backpack/satchel/pusher //Special satchel. Make it so only the pusher can see the altered description later.
	desc = "An special satchel to store drugs and paraphernalias. Seems similar to a normal satchel."
	populate_contents = list( //Change 'Canhold' later to, "This satchel feels weird" when used by a non-pusher.
		/obj/item/reagent_containers/powder/moondust,
		/obj/item/reagent_containers/powder/moondust,
		/obj/item/reagent_containers/powder/ozium,
		/obj/item/reagent_containers/powder/ozium,
		/obj/item/reagent_containers/powder/ozium,
		/obj/item/reagent_containers/powder/spice,
		/obj/item/reagent_containers/powder/spice,
		/obj/item/reagent_containers/powder/moondust_purest,
		/obj/item/storage/fancy/cigarettes/cannabis_zig,
		/obj/item/storage/fancy/cigarettes/cannabis_zig,
		/obj/item/storage/fancy/cigarettes/zig,
		/obj/item/storage/fancy/cigarettes/zig,
	)

/obj/item/storage/fancy/cigarettes/cannabis_zig
	name = "sweet zigbox"
	desc = ""
	icon_state = "zig"
	base_icon_state = "zig"
	contents_tag = "sweet zig"
	spawn_type = /obj/item/clothing/face/cigarette/rollie/cannabis
	component_type = /datum/component/storage/concrete/grid/zigbox
