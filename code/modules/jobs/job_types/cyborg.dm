/datum/job/cyborg
	title = "Cyborg"
	auto_deadmin_role_flags = DEADMIN_POSITION_SILICON
	faction = FACTION_STATION
	total_positions = 0
	spawn_positions = 3	// SKYRAT EDIT: Original value (1)
	supervisors = "your laws and the AI" //Nodrak
	selection_color = "#ddffdd"
	spawn_type = /mob/living/silicon/robot
	minimal_player_age = 21
	exp_requirements = 120
	exp_type = EXP_TYPE_CREW

	display_order = JOB_DISPLAY_ORDER_CYBORG
	departments = DEPARTMENT_SILICON
	random_spawns_possible = FALSE
	job_flags = JOB_NEW_PLAYER_JOINABLE | JOB_EQUIP_RANK


/datum/job/cyborg/after_spawn(mob/living/spawned, client/player_client)
	. = ..()
	if(!iscyborg(spawned))
		return
	spawned.gender = NEUTER
	var/mob/living/silicon/robot/robot_spawn = spawned
	robot_spawn.notify_ai(NEW_BORG)


/datum/job/cyborg/radio_help_message(mob/M)
	to_chat(M, "<b>Prefix your message with :b to speak with other cyborgs and AI.</b>")
