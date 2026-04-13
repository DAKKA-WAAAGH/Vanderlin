/obj/structure/ritual/abyss_altar
	name = "Abyssanctum altar"
	desc = "A carved stone slab for thalassic rites. Set your offerings here."
	icon = 'icons/obj/structures.dmi'
	icon_state = "altar"
	anchored = TRUE
	density = TRUE
	can_buckle = TRUE
	layer = OBJ_LAYER
	var/list/available_slots = list()
	var/max_slots = 4

/obj/structure/ritual/abyss_altar/Initialize()
	. = ..()
	available_slots = list()
	// simple 2x2 grid offsets so items sit nicely on the slab
	available_slots += list(list("offset" = list("x" = -8 , "y" =  6), "item" = null))
	available_slots += list(list("offset" = list("x" =  8 , "y" =  6), "item" = null))
	available_slots += list(list("offset" = list("x" = -8 , "y" = -6), "item" = null))
	available_slots += list(list("offset" = list("x" =  8 , "y" = -6), "item" = null))
	return .

/obj/structure/ritual/abyss_altar/proc/item_cleanup()
	var/turf/T = get_turf(src)
	for(var/i = 1, i <= available_slots.len, i++)
		if(!(available_slots[i]["item"] in T.contents))
			available_slots[i]["item"] = null

/obj/structure/ritual/abyss_altar/attackby(obj/item/I, mob/user, params)
	. = ..()
	if(!istype(I))
		return

	item_cleanup()

	var/list/slot = null
	for(var/j = 1, j <= available_slots.len, j++)
		if(available_slots[j]["item"] == null)
			slot = available_slots[j]
			break

	if(!slot)
		to_chat(user, "<span class='notice'>There is no free space on [src] to place [I]!</span>")
		return

	if(user.unEquip(I, src.loc))
		I.pixel_x = slot["offset"]["x"]
		I.pixel_y = slot["offset"]["y"]
		slot["item"] = I
		to_chat(user, "<span class='notice'>I place [I] upon [src].</span>")

/obj/structure/ritual/abyss_altar/proc/get_items()
	var/list/L = list()
	for(var/obj/item/I in get_turf(src))
		if(I == src)
			continue
		L += I
	return L

/obj/structure/ritual/abyss_altar/proc/get_patient()
	for(var/mob/living/L in get_turf(src))
		return L
	return null

/obj/structure/ritual/abyss_altar/proc/get_total_holywater()
	var/total = 0
	for(var/atom/A in get_turf(src))
		if(A?.reagents)
			total += A.reagents.get_reagent_amount(/datum/reagent/water/holywater)
	return total

/obj/structure/ritual/abyss_altar/proc/consume_holywater(amount)
	var/remaining = max(0, amount)
	if(remaining <= 0)
		return 0
	for(var/atom/A in get_turf(src))
		if(!A?.reagents)
			continue
		var/have = A.reagents.get_reagent_amount(/datum/reagent/water/holywater)
		if(have <= 0)
			continue
		var/take = min(have, remaining)
		if(take > 0)
			A.reagents.remove_reagent(/datum/reagent/water/holywater, take)
			remaining -= take
			if(remaining <= 0)
				break
	return amount - remaining

/obj/structure/ritual/abyss_altar/proc/find_any_weapon()
	for(var/obj/item/I in get_turf(src))
		if(istype(I, /obj/item/weapon))
			return I
	return null

/obj/structure/ritual/abyss_altar/proc/find_item_of_type(path/typepath)
	for(var/obj/item/I in get_turf(src))
		if(istype(I, typepath))
			return I
	return null

/obj/structure/ritual/abyss_altar/proc/ritual_feedback(msg)
	visible_message("<span class='notice'>[src]: [msg]</span>")

// ---------------------------------------------------
// Abyssanctum Ritual Book
// Use on the altar to open a simple input() menu
// ---------------------------------------------------

/obj/item/book/ritual/abyssanctum
	name = "Abyssanctum codex"
	desc = "A sea-stained vellum codex of rites and reckonings."
	icon = 'icons/obj/library.dmi'
	icon_state = "book"
	w_class = ITEM_SIZE_SMALL

/obj/item/book/ritual/abyssanctum/attack_obj(obj/target, mob/living/user)
	. = ..()
	if(!istype(target, /obj/structure/ritual/abyss_altar))
		return

	var/obj/structure/ritual/abyss_altar/altar = target

	if(!is_abyssanctum(user))
		to_chat(user, "<span class='danger'>Only the Abyssanctum faithful may read these rites.</span>")
		return

	var/choice = input(user, "Choose an action:", "[name]") as null|anything in list("Perform Rituals", "Check Ritual Requirements", "Cancel")
	if(choice == "Cancel" || isnull(choice))
		return

	if(choice == "Check Ritual Requirements")
		show_ritual_requirements(user)
		return

	if(choice == "Perform Rituals")
		do_perform_menu(user, altar)
		return

/obj/item/book/ritual/abyssanctum/proc/do_perform_menu(mob/living/user, obj/structure/ritual/abyss_altar/altar)
	var/list/rits = GetAbyssRituals()
	var/list/names = list()
	for(var/datum/ritual/abyss/R in rits)
		names += R.name

	var/which = input(user, "Choose a ritual:", "Perform Rituals") as null|anything in names
	if(isnull(which)) return

	var/datum/ritual/abyss/chosen = null
	for(var/datum/ritual/abyss/R in rits)
		if(R.name == which) { chosen = R; break }
	if(!chosen) return

	// Build a preview text with desc + needs_text
	var/text = "<b>[chosen.name]</b>\n[chosen.desc]\n"
	if(chosen.needs_text && chosen.needs_text.len)
		text += "\n<b>Requirements:</b>\n"
		for(var/line in chosen.needs_text)
			text += "• [line]\n"

	var/confirm = input(user, text, "Confirm") as null|anything in list("Proceed", "Cancel")
	if(confirm != "Proceed") return

	if(!chosen.check_requirements(user, altar, silent = FALSE)) return

	if(!do_after(user, 3 SECONDS, target = altar))
		to_chat(user, "<span class='warning'>The tide of focus slips away.</span>")
		return

	chosen.perform(user, altar)

// ---------------------------------------------------
// Faith check: Only Abyssanctum can operate the book
// ---------------------------------------------------

/proc/is_abyssanctum(mob/living/user)
	if(!user)
		return FALSE

	// Your codebase may use .patron or .faith; check both safely
	if(user?.patron && istype(user.patron, /datum/patron/abyssanctum))
		return TRUE
	if(user?.faith && istype(user.faith, /datum/faith/abyssanctum))
		return TRUE

	// If you want to allow storytellers/admeme overrides, add here
	return FALSE

/ ---------------------------------------------------
// Ritual framework
// ---------------------------------------------------

GLOBAL_VAR_INIT(ABYSS_RITUALS, null)

/proc/GetAbyssRituals()
	if(ABYSS_RITUALS)
		return ABYSS_RITUALS

	ABYSS_RITUALS = list()
	ABYSS_RITUALS += new /datum/ritual/abyss/simple_consecration()
	ABYSS_RITUALS += new /datum/ritual/abyss/bless_weapon()
	ABYSS_RITUALS += new /datum/ritual/abyss/cursebreak()

	return ABYSS_RITUALS

/datum/ritual/abyss
	var/name = "Unnamed Ritual"
	var/desc = "A rite of the deep."
	var/list/needs_text = list()

/datum/ritual/abyss/proc/describe_requirements(mob/living/user)
	if(!user)
		return
	if(!needs_text || !needs_text.len)
		to_chat(user, "<span class='notice'><b>[name]</b>: No special requirements listed.</span>")
		return
	for(var/line in needs_text)
		to_chat(user, "<span class='notice'><b>[name]</b>: [line]</span>")

/datum/ritual/abyss/proc/check_requirements(mob/living/user, obj/structure/ritual/abyss_altar/altar, silent = FALSE)
	return TRUE

/datum/ritual/abyss/proc/perform(mob/living/user, obj/structure/ritual/abyss_altar/altar)
	return

// ---------------------------------------------------
// Ritual 1: Simple Consecration Field
// Needs: ≥ 50 Holy Water + a silver dagger on the altar
// Effect: Consacrate tiles in radius (SpawnHolyTileAt)
// ---------------------------------------------------

/datum/ritual/abyss/simple_consecration
	name = "Simple Consecration"
	desc = "Hallow the ground around the altar with blessed water and a silver instrument."
	needs_text = list(
		"Place a silver dagger on the altar.",
		"Provide at least 50u of Holy Water on the altar (any containers)."
	)

/datum/ritual/abyss/simple_consecration/check_requirements(mob/living/user, obj/structure/ritual/abyss_altar/altar, silent = FALSE)
	if(!altar)
		return FALSE

	var/holy = altar.get_total_holywater()
	if(holy < 50)
		if(!silent) to_chat(user, "<span class='warning'>Not enough holy water (need ≥ 50).</span>")
		return FALSE

	// Adjust the type path to your actual silver dagger
	var/obj/item/weapon/dagger/silver/D = altar.find_item_of_type(/obj/item/weapon/dagger/silver)
	if(!D)
		if(!silent) to_chat(user, "<span class='warning'>A silver dagger is required.</span>")
		return FALSE

	return TRUE

/datum/ritual/abyss/simple_consecration/perform(mob/living/user, obj/structure/ritual/abyss_altar/altar)
	if(!check_requirements(user, altar, silent = TRUE))
		return

	var/used = altar.consume_holywater(50)
	if(used < 50)
		to_chat(user, "<span class='warning'>The altar’s vessels ran dry mid-rite.</span>")
		return

	var/turf/center = get_turf(altar)
	if(!istype(center, /turf/open))
		to_chat(user, "<span class='warning'>This ground resists hallowing.</span>")
		return

	altar.ritual_feedback("The water mists outward, sanctifying the earth.")
	playsound(center, 'modular/kaizoku/sound/foley/water_land1.ogg', 100, FALSE)

	for(var/turf/open/T in range(3, center))
		SpawnHolyTileAt(T)

// ---------------------------------------------------
// Ritual 2: Bless Weapon
// Needs: ≥ 30 Holy Water + any weapon on the altar
// Effect: Blesses the weapon (uses your bless_weapon proc)
// ---------------------------------------------------

#define RITUAL_BLESS_DURATION (15 MINUTES)

/datum/ritual/abyss/bless_weapon
	name = "Bless Weapon"
	desc = "Consecrate a blade to pierce the profane; ignores demon resistances."
	needs_text = list(
		"Place a weapon on the altar.",
		"Provide at least 30u of Holy Water on the altar."
	)

/datum/ritual/abyss/bless_weapon/check_requirements(mob/living/user, obj/structure/ritual/abyss_altar/altar, silent = FALSE)
	if(!altar)
		return FALSE

	if(altar.get_total_holywater() < 30)
		if(!silent) to_chat(user, "<span class='warning'>Not enough holy water (need ≥ 30).</span>")
		return FALSE

	var/obj/item/weapon/W = altar.find_any_weapon()
	if(!W)
		if(!silent) to_chat(user, "<span class='warning'>A weapon must be placed on the altar.</span>")
		return FALSE

	return TRUE

/datum/ritual/abyss/bless_weapon/perform(mob/living/user, obj/structure/ritual/abyss_altar/altar)
	if(!check_requirements(user, altar, silent = TRUE))
		return

	var/obj/item/weapon/W = altar.find_any_weapon()
	if(!W)
		to_chat(user, "<span class='warning'>The weapon was moved.</span>")
		return

	var/used = altar.consume_holywater(30)
	if(used < 30)
		to_chat(user, "<span class='warning'>The altar’s vessels ran dry mid-rite.</span>")
		return

	if(W?.bless_weapon)
		W.bless_weapon(RITUAL_BLESS_DURATION)
		altar.ritual_feedback("The blade hums with a thalassic timbre.")
	else
		to_chat(user, "<span class='warning'>This weapon cannot hold a blessing.</span>")

#undef RITUAL_BLESS_DURATION

// ---------------------------------------------------
// Ritual 3: Cursebreak & Purification
// Needs: ≥ 80 Holy Water + a patient on the altar tile
// Effect: cleanse chemicals, remove debuffs, grant protection, consecrate tile
// ---------------------------------------------------

/datum/ritual/abyss/cursebreak
	name = "Cursebreak"
	desc = "Laver the afflicted, draw out banes and poisons, and gird them with grace."
	needs_text = list(
		"Bring the patient onto the altar (buckled or standing on it).",
		"Provide at least 80u of Holy Water on the altar."
	)

/datum/ritual/abyss/cursebreak/check_requirements(mob/living/user, obj/structure/ritual/abyss_altar/altar, silent = FALSE)
	if(!altar)
		return FALSE

	if(altar.get_total_holywater() < 80)
		if(!silent) to_chat(user, "<span class='warning'>Not enough holy water (need ≥ 80).</span>")
		return FALSE

	var/mob/living/P = altar.get_patient()
	if(!P)
		if(!silent) to_chat(user, "<span class='warning'>No patient is upon the altar.</span>")
		return FALSE

	return TRUE

/datum/ritual/abyss/cursebreak/perform(mob/living/user, obj/structure/ritual/abyss_altar/altar)
	if(!check_requirements(user, altar, silent = TRUE)) return

	var/mob/living/P = altar.get_patient()
	if(!P) { to_chat(user, "<span class='warning'>The patient moved away.</span>"); return }

	var/used = altar.consume_holywater(80)
	if(used < 80) { to_chat(user, "<span class='warning'>The altar’s vessels ran dry mid-rite.</span>"); return }

	var/turf/open/T = get_turf(altar)
	if(istype(T, /turf/open)) SpawnHolyTileAt(T)

	altar.ritual_feedback("Holy current flushes bane and blight from the patient.")
	playsound(altar, 'modular/kaizoku/sound/foley/water_land2.ogg', 100, FALSE)

	// --- Strip cursed-but-not-biological equipment ---
	if(ishuman(P))
		var/mob/living/carbon/human/H = P

		// full slot sweep; trim/extend as your codebase needs
		var/list/slots = list(
			ITEM_SLOT_HEAD, ITEM_SLOT_MASK, ITEM_SLOT_MOUTH,
			ITEM_SLOT_SHIRT, ITEM_SLOT_PANTS, ITEM_SLOT_GLOVES, ITEM_SLOT_SHOES,
			ITEM_SLOT_WRISTS, ITEM_SLOT_CLOAK, ITEM_SLOT_ARMOR,
			ITEM_SLOT_BACK_L, ITEM_SLOT_BACK_R,
			ITEM_SLOT_BELT, ITEM_SLOT_BELT_L, ITEM_SLOT_BELT_R,
			ITEM_SLOT_NECK, ITEM_SLOT_RING, ITEM_SLOT_HANDS
		)

		for(var/S in slots)
			var/obj/item/I = H.get_item_by_slot(S)
			if(!I) continue
			if(is_cursed_nodrop(I))
				if(!I.biological)
					// remove the curse
					REMOVE_TRAIT(I, TRAIT_NODROP, CURSED_ITEM_TRAIT)
					to_chat(H, "<span class='notice'>The curse on [I] loosens and falls away.</span>")
					// unequip if still worn
					if(H.isEquipped(I))
						H.doUnEquip(I)
						I.forceMove(get_turf(H))

		// hands too (active + inactive)
		var/obj/item/Ha = H.get_active_held_item()
		if(Ha && is_cursed_nodrop(Ha) && !Ha.biological)
			REMOVE_TRAIT(Ha, TRAIT_NODROP, CURSED_ITEM_TRAIT)
			H.dropItemToGround(Ha)

		var/obj/item/Hi = H.get_inactive_held_item()
		if(Hi && is_cursed_nodrop(Hi) && !Hi.biological)
			REMOVE_TRAIT(Hi, TRAIT_NODROP, CURSED_ITEM_TRAIT)
			H.dropItemToGround(Hi)

	// --- Purge chemicals, remove curses, and add holy boons ---
	if(P.reagents) P.reagents.clear_reagents()
	if(P?.remove_all_curse_effects)
		P.remove_all_curse_effects()
	else
		P.apply_status_effect(/datum/status_effect/holy_protection)
		P.apply_status_effect(/datum/status_effect/holy_resistance)

	// --- Cure Rot (mirrors your spell’s behavior) ---
	var/datum/antagonist/zombie/was_zombie = P.mind?.has_antag_datum(/datum/antagonist/zombie)
	if(was_zombie)
		if(was_zombie.become_rotman && prob(5)) // 5% chance to dodge rotman fate
			was_zombie.become_rotman = FALSE
		P.mind.remove_antag_datum(/datum/antagonist/zombie)
		P.death()
		if(!HAS_TRAIT(P, TRAIT_IWASUNZOMBIFIED))
			ADD_TRAIT(P, TRAIT_IWASUNZOMBIFIED, "[type]")

	var/datum/component/rot/rot = P.GetComponent(/datum/component/rot)
	if(rot) rot.amount = 0

	if(iscarbon(P))
		var/mob/living/carbon/C = P
		for(var/obj/item/bodypart/BP as anything in C.bodyparts)
			if(BP.rotted || BP.skeletonized)
				BP.rotted = FALSE
				BP.skeletonized = FALSE
				BP.update_limb()
				if(BP.can_be_disabled) BP.update_disabled()
		P.update_body()

	if(P.stat < DEAD)
		P.remove_client_colour(/datum/client_colour/monochrome/death)

	// funeral flag reset like your spell does
	if(ishuman(P))
		var/mob/living/carbon/human/HH = P
		if(HH.funeral)
			if(HH.client)
				to_chat(HH, span_warning("My funeral rites were undone!"))
			else
				var/mob/dead/observer/ghost = HH.get_ghost(TRUE, TRUE)
				if(ghost) to_chat(ghost, span_warning("My funeral rites were undone!"))
		HH.funeral = FALSE

	to_chat(P, "<span class='notice'>A cool tide passes through you, carrying filth away.</span>")
/datum/lecture/hearthcore/oathpledge/torch_of_guidance
	name = "Torch of Guidance"
	phrase = "Oxidate Lecture: Torch of Guidance."
	desc = "A lecture intricately aligned with the neural links to forewarn the user of perfil. The radiance will inspect and unveil the presence of plague, hostile fauna, monstrous entity hiding as people and traps."
	power = 50

/datum/lecture/hearthcore/oathpledge/torch_of_guidance/perform(mob/living/carbon/human/H, obj/item/implant/core_implant/C)
	var/was_triggired = FALSE
	log_and_message_admins("performed empowered reveal lecture")
	for(var/mob/living/carbon/superior_animal/S in range(14, H))
		if (S.stat != DEAD)
			to_chat(H, SPAN_WARNING("The radiance quivers in antecipation. Foes draw near. You sense a palpable, malevolent presence - a worthy adversary.")) //prints this for every superior_animal found in 14 tiles
			was_triggired = TRUE

	if(!was_triggired)
		for (var/mob/living/simple_animal/hostile/S in range(14, H)) //prints this for every hostile simple_animal found in 14 tiles
			if (S.stat != DEAD)
				to_chat(H, SPAN_WARNING("The radiance breaths in disappointment. A simple hostile brute is nearby, stupid and most likely unworthy of a fight."))
				was_triggired = TRUE

	if(locate(/obj/structure/wire_splicing || /obj/item/mine || /obj/item/mine_old || /obj/item/spider_shadow_trap || /obj/item/beartrap || /obj/item/emp_mine) in view(7, H)) //prints this only once if a trap was found in the user's view
		to_chat(H, SPAN_WARNING("The radiance triggers you a chemical warning. You must tread carefully, someone has laid curses and traps nearby."))
		was_triggired = TRUE

	for(var/mob/living/carbon/human/target in range(14, H)) //prints this for every implanted carrion organ found in 14 tiles
		for(var/organ in target.organs)
			if (organ in subtypesof(/obj/item/organ/internal/carrion))
				to_chat(H, SPAN_DANGER("The radiance shivers in disgust, now running boiling hot on your bloodstream to prepare you for what is to come. You feel danger, yet never afraid. The presence of a terrible plague is nearby."))
				was_triggired = TRUE

	if(!was_triggired) //nothing was triggered? print this
		to_chat(H, SPAN_NOTICE("There is nothing here. You feel safe."))

	return TRUE

