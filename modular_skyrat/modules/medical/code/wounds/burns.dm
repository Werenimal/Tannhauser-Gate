
/*
	Burn wounds
*/

// TODO: well, a lot really, but specifically I want to add potential fusing of clothing/equipment on the affected area, and limb infections, though those may go in body part code
/datum/wound/burn
	name = "Burn Wound"
	a_or_from = "from"
	wound_type = WOUND_BURN
	processes = TRUE
	sound_effect = 'sound/effects/wounds/sizzle1.ogg'
	wound_flags = (FLESH_WOUND | ACCEPTS_GAUZE)

	treatable_by = list(/obj/item/stack/medical/ointment, /obj/item/stack/medical/mesh) // sterilizer and alcohol will require reagent treatments, coming soon

		// Flesh damage vars
	/// How much damage to our flesh we currently have. Once both this and infestation reach 0, the wound is considered healed
	var/flesh_damage = 5
	/// Our current counter for how much flesh regeneration we have stacked from regenerative mesh/synthflesh/whatever, decrements each tick and lowers flesh_damage
	var/flesh_healing = 0

		// Infestation vars (only for severe and critical)
	/// How quickly infection breeds on this burn if we don't have disinfectant
	var/infestation_rate = 0
	/// Our current level of infection
	var/infestation = 0
	/// Our current level of sanitization/anti-infection, from disinfectants/alcohol/UV lights. While positive, totally pauses and slowly reverses infestation effects each tick
	var/sanitization = 0

	/// Once we reach infestation beyond WOUND_INFESTATION_SEPSIS, we get this many warnings before the limb is completely paralyzed (you'd have to ignore a really bad burn for a really long time for this to happen)
	var/strikes_to_lose_limb = 3


/datum/wound/burn/handle_process()
	. = ..()
	if(strikes_to_lose_limb == 0) // we've already hit sepsis, nothing more to do
		victim.adjustToxLoss(0.5)
		if(prob(1))
			victim.visible_message(span_danger("The infection on the remnants of [victim]'s [parse_zone(limb.body_zone)] shift and bubble nauseatingly!"), span_warning("You can feel the infection on the remnants of your [parse_zone(limb.body_zone)] coursing through your veins!"), vision_distance = COMBAT_MESSAGE_RANGE)
		return

	if(victim.reagents)
		if(victim.reagents.has_reagent(/datum/reagent/medicine/spaceacillin))
			sanitization += 0.9
		if(victim.reagents.has_reagent(/datum/reagent/space_cleaner/sterilizine/))
			sanitization += 0.9
		if(victim.reagents.has_reagent(/datum/reagent/medicine/mine_salve))
			sanitization += 0.3
			flesh_healing += 0.5

	var/bandage_factor = 1 // good bandages multiply the length of flesh healing
	if(limb.current_gauze && limb.current_gauze.seep_gauze(WOUND_BURN_SANITIZATION_RATE, GAUZE_STAIN_PUS))
		bandage_factor = limb.current_gauze.sanitisation_factor


	// if we have little/no infection, the limb doesn't have much burn damage, and our nutrition is good, heal some flesh
	if(infestation <= WOUND_INFECTION_MODERATE && (limb.burn_dam < 5) && (victim.nutrition >= NUTRITION_LEVEL_FED))
		flesh_healing += 0.2

	if(flesh_healing > 0)
		flesh_damage = max(0, flesh_damage - 0.5)
		flesh_healing = max(0, flesh_healing - (0.5 * bandage_factor)) // good bandages multiply the length of flesh healing

	// here's the check to see if we're cleared up
	if((flesh_damage <= 0) && (infestation <= 1))
		to_chat(victim, span_green("The burns on your [parse_zone(limb.body_zone)] have cleared up!"))
		qdel(src)
		return

	// sanitization is checked after the clearing check but before the actual ill-effects, because we freeze the effects of infection while we have sanitization
	if(sanitization > 0)
		infestation = max(0, infestation - WOUND_BURN_SANITIZATION_RATE)
		sanitization = max(0, sanitization - (WOUND_BURN_SANITIZATION_RATE * bandage_factor))
		return

	infestation += infestation_rate

	switch(infestation)
		if(0 to WOUND_INFECTION_MODERATE)
		if(WOUND_INFECTION_MODERATE to WOUND_INFECTION_SEVERE)
			if(prob(30))
				victim.adjustToxLoss(0.2)
				if(prob(6))
					to_chat(victim, span_warning("The blisters on your [parse_zone(limb.body_zone)] ooze a strange pus..."))
		if(WOUND_INFECTION_SEVERE to WOUND_INFECTION_CRITICAL)
			if(!disabling && prob(2))
				to_chat(victim, span_warning("<b>Your [parse_zone(limb.body_zone)] completely locks up, as you struggle for control against the infection!</b>"))
				set_disabling(TRUE)
			else if(disabling && prob(8))
				to_chat(victim, span_notice("You regain sensation in your [parse_zone(limb.body_zone)], but it's still in terrible shape!"))
				set_disabling(FALSE)
			else if(prob(20))
				victim.adjustToxLoss(0.5)
		if(WOUND_INFECTION_CRITICAL to WOUND_INFECTION_SEPTIC)
			if(!disabling && prob(3))
				to_chat(victim, span_warning("<b>You suddenly lose all sensation of the festering infection in your [parse_zone(limb.body_zone)]!</b>"))
				set_disabling(TRUE)
			else if(disabling && prob(3))
				to_chat(victim, span_notice("You can barely feel your [parse_zone(limb.body_zone)] again, and you have to strain to retain motor control!"))
				set_disabling(FALSE)
			else if(prob(1))
				to_chat(victim, span_warning("You contemplate life without your [parse_zone(limb.body_zone)]..."))
				victim.adjustToxLoss(0.75)
			else if(prob(4))
				victim.adjustToxLoss(1)
		if(WOUND_INFECTION_SEPTIC to INFINITY)
			if(prob(infestation))
				switch(strikes_to_lose_limb)
					if(3 to INFINITY)
						to_chat(victim, span_deadsay("The skin on your [parse_zone(limb.body_zone)] is literally dripping off, you feel awful!"))
					if(2)
						to_chat(victim, span_deadsay("<b>The infection in your [parse_zone(limb.body_zone)] is literally dripping off, you feel horrible!</b>"))
					if(1)
						to_chat(victim, span_deadsay("<b>Infection has just about completely claimed your [parse_zone(limb.body_zone)]!</b>"))
					if(0)
						to_chat(victim, span_deadsay("<b>The last of the nerve endings in your [parse_zone(limb.body_zone)] wither away, as the infection completely paralyzes your joint connector.</b>"))
						threshold_penalty = 120 // piss easy to destroy
						var/datum/brain_trauma/severe/paralysis/sepsis = new (limb.body_zone)
						victim.gain_trauma(sepsis)
				strikes_to_lose_limb--

/datum/wound/burn/get_examine_description(mob/user)
	if(strikes_to_lose_limb <= 0)
		return span_deadsay("<B>[victim.p_their(TRUE)] [parse_zone(limb.body_zone)] has locked up completely and is non-functional. Amputate or augment limb immediately, or place the patient in a cryotube.</B>")

	var/list/condition = list("[victim.p_their(TRUE)] [parse_zone(limb.body_zone)] [examine_desc]")
	if(limb.current_gauze)
		var/bandage_condition
		switch(limb.current_gauze.absorption_capacity)
			if(0 to 1.25)
				bandage_condition = "nearly ruined"
			if(1.25 to 2.75)
				bandage_condition = "badly worn"
			if(2.75 to 4)
				bandage_condition = "slightly pus-stained"
			if(4 to INFINITY)
				bandage_condition = "clean"

		condition += " underneath a dressing of [bandage_condition] [limb.current_gauze.name]"
	else
		switch(infestation)
			if(WOUND_INFECTION_MODERATE to WOUND_INFECTION_SEVERE)
				condition += ", <span class='deadsay'>with small spots of discoloration along the nearby veins!</span>"
			if(WOUND_INFECTION_SEVERE to WOUND_INFECTION_CRITICAL)
				condition += ", <span class='deadsay'>with growing clouds of infection.</span>"
			if(WOUND_INFECTION_CRITICAL to WOUND_INFECTION_SEPTIC)
				condition += ", <span class='deadsay'>with streaks of rotten, pulsating infection!</span>"
			if(WOUND_INFECTION_SEPTIC to INFINITY)
				return span_deadsay("<B>[victim.p_their(TRUE)] [parse_zone(limb.body_zone)] is a mess of charred skin and infected rot!</B>")
			else
				condition += "!"

	return "<B>[condition.Join()]</B>"

/datum/wound/burn/get_scanner_description(mob/user)
	if(strikes_to_lose_limb == 0)
		var/oopsie = "Type: [name]\nSeverity: [severity_text()]"
		oopsie += "<div class='ml-3'>Infection Level: <span class='deadsay'>The bodypart has suffered complete sepsis and must be removed. Amputate or augment limb immediately.</span></div>"
		return oopsie

	. = ..()
	. += "<div class='ml-3'>"

	if(infestation <= sanitization && flesh_damage <= flesh_healing)
		. += "No further treatment required: Burns will heal shortly."
	else
		switch(infestation)
			if(WOUND_INFECTION_MODERATE to WOUND_INFECTION_SEVERE)
				. += "Infection Level: Moderate\n"
			if(WOUND_INFECTION_SEVERE to WOUND_INFECTION_CRITICAL)
				. += "Infection Level: Severe\n"
			if(WOUND_INFECTION_CRITICAL to WOUND_INFECTION_SEPTIC)
				. += "Infection Level: <span class='deadsay'>CRITICAL</span>\n"
			if(WOUND_INFECTION_SEPTIC to INFINITY)
				. += "Infection Level: <span class='deadsay'>LOSS IMMINENT</span>\n"
		if(infestation > sanitization)
			. += "\tSurgical debridement, antiobiotics/sterilizers, or regenerative mesh will rid infection. Paramedic UV penlights are also effective.\n"

		if(flesh_damage > 0)
			. += "Flesh damage detected: Application of ointment, regenerative mesh, Synthflesh, or ingestion of \"Miner's Salve\" will repair damaged flesh. Good nutrition, rest, and keeping the wound clean can also slowly repair flesh.\n"
	. += "</div>"

/*
	new burn common procs
*/

/// if someone is using ointment or mesh on our burns
/datum/wound/burn/proc/ointmentmesh(obj/item/stack/medical/treatment_item, mob/user)
	user.visible_message(span_notice("[user] begins applying [treatment_item] to [victim]'s [parse_zone(limb.body_zone)]..."), span_notice("You begin applying [treatment_item] to [user == victim ? "your" : "[victim]'s"] [parse_zone(limb.body_zone)]..."))
	if(!do_after(user, (user == victim ? treatment_item.self_delay : treatment_item.other_delay), extra_checks = CALLBACK(src, PROC_REF(still_exists))))
		return

	limb.heal_damage(treatment_item.heal_brute, treatment_item.heal_burn)
	user.visible_message(span_green("[user] applies [treatment_item] to [victim]."), span_green("You apply [treatment_item] to [user == victim ? "your" : "[victim]'s"] [parse_zone(limb.body_zone)]."))
	treatment_item.use(1)
	sanitization += treatment_item.sanitization
	flesh_healing += treatment_item.flesh_regeneration

	if((infestation <= 0 || sanitization >= infestation) && (flesh_damage <= 0 || flesh_healing > flesh_damage))
		to_chat(user, span_notice("You've done all you can with [treatment_item], now you must wait for the flesh on [victim]'s [parse_zone(limb.body_zone)] to recover."))
	else
		try_treating(treatment_item, user)

/// Paramedic UV penlights
/datum/wound/burn/proc/uv(obj/item/flashlight/pen/paramedic/penlight_used, mob/user)
	if(!COOLDOWN_FINISHED(penlight_used, uv_cooldown))
		to_chat(user, span_notice("[penlight_used] is still recharging!"))
		return
	if(infestation <= 0 || infestation < sanitization)
		to_chat(user, span_notice("There's no infection to treat on [victim]'s [parse_zone(limb.body_zone)]!"))
		return

	user.visible_message(span_notice("[user] flashes the burns on [victim]'s [limb] with [penlight_used]."), span_notice("You flash the burns on [user == victim ? "your" : "[victim]'s"] [parse_zone(limb.body_zone)] with [penlight_used]."), vision_distance=COMBAT_MESSAGE_RANGE)
	sanitization += penlight_used.uv_power
	COOLDOWN_START(penlight_used, uv_cooldown, penlight_used.uv_cooldown_length)

/datum/wound/burn/treat(obj/item/treatment_item, mob/user)
	if(istype(treatment_item, /obj/item/stack/medical/ointment))
		ointmentmesh(treatment_item, user)
	else if(istype(treatment_item, /obj/item/stack/medical/mesh))
		var/obj/item/stack/medical/mesh/mesh_check = treatment_item
		if(!mesh_check.is_open)
			to_chat(user, span_warning("You need to open [mesh_check] first."))
			return
		ointmentmesh(mesh_check, user)
	else if(istype(treatment_item, /obj/item/flashlight/pen/paramedic))
		uv(treatment_item, user)

// people complained about burns not healing on stasis beds, so in addition to checking if it's cured, they also get the special ability to very slowly heal on stasis beds if they have the healing effects stored
/datum/wound/burn/on_stasis()
	. = ..()
	if(flesh_healing > 0)
		flesh_damage = max(0, flesh_damage - 0.2)
	if((flesh_damage <= 0) && (infestation <= WOUND_INFECTION_MODERATE))
		to_chat(victim, span_green("The burns on your [parse_zone(limb.body_zone)] have cleared up!"))
		qdel(src)
		return
	if(sanitization > 0)
		infestation = max(0, infestation - WOUND_BURN_SANITIZATION_RATE * 0.2)

/datum/wound/burn/on_synthflesh(amount)
	flesh_healing += amount * 0.5 // 20u patch will heal 10 flesh standard

// we don't even care about first degree burns, straight to second
/datum/wound/burn/moderate
	name = "Second Degree Burns"
	desc = "Patient is suffering considerable burns with mild skin penetration, weakening limb integrity and increased burning sensations."
	treat_text = "Recommended application of topical ointment or regenerative mesh to affected region."
	examine_desc = "is badly burned and breaking out in blisters"
	occur_text = "breaks out with violent red burns"
	severity = WOUND_SEVERITY_MODERATE
	damage_mulitplier_penalty = 1.1
	threshold_minimum = 40
	threshold_penalty = 30 // burns cause significant decrease in limb integrity compared to other wounds
	status_effect_type = /datum/status_effect/wound/burn/moderate
	flesh_damage = 5
	scar_keyword = "burnmoderate"

/datum/wound/burn/severe
	name = "Third Degree Burns"
	desc = "Patient is suffering extreme burns with full skin penetration, creating serious risk of infection and greatly reduced limb integrity."
	treat_text = "Recommended immediate disinfection and excision of any infected skin, followed by bandaging and ointment. If the limb has locked up, it must be amputated, augmented or treated with cryogenics."
	examine_desc = "appears seriously charred, with aggressive red splotches"
	occur_text = "chars rapidly, exposing ruined tissue and spreading angry red burns"
	severity = WOUND_SEVERITY_SEVERE
	damage_mulitplier_penalty = 1.2
	threshold_minimum = 80
	threshold_penalty = 40
	status_effect_type = /datum/status_effect/wound/burn/severe
	treatable_by = list(/obj/item/flashlight/pen/paramedic, /obj/item/stack/medical/ointment, /obj/item/stack/medical/mesh)
	infestation_rate = 0.05 // appx 13 minutes to reach sepsis without any treatment
	flesh_damage = 12.5
	scar_keyword = "burnsevere"

/datum/wound/burn/critical
	name = "Catastrophic Burns"
	desc = "Patient is suffering near complete loss of tissue and significantly charred muscle and bone, creating life-threatening risk of infection and negligible limb integrity."
	treat_text = "Immediate surgical debriding of any infected skin, followed by potent tissue regeneration formula and bandaging. If the limb has locked up, it must be amputated, augmented or treated with cryogenics."
	examine_desc = "is a ruined mess of blanched bone, melted fat, and charred tissue"
	occur_text = "vaporizes as flesh, bone, and fat melt together in a horrifying mess"
	severity = WOUND_SEVERITY_CRITICAL
	damage_mulitplier_penalty = 1.3
	sound_effect = 'sound/effects/wounds/sizzle2.ogg'
	threshold_minimum = 140
	threshold_penalty = 80
	status_effect_type = /datum/status_effect/wound/burn/critical
	treatable_by = list(/obj/item/flashlight/pen/paramedic, /obj/item/stack/medical/ointment, /obj/item/stack/medical/mesh)
	infestation_rate = 0.15 // appx 4.33 minutes to reach sepsis without any treatment
	flesh_damage = 20
	scar_keyword = "burncritical"

///special severe wound caused by sparring interference or other god related punishments.
/datum/wound/burn/severe/brand
	name = "Holy Brand"
	desc = "Patient is suffering extreme burns from a strange brand marking, creating serious risk of infection and greatly reduced limb integrity."
	examine_desc = "appears to have holy symbols painfully branded into their flesh, leaving severe burns."
	occur_text = "chars rapidly into a strange pattern of holy symbols, burned into the flesh."
