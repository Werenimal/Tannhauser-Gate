/*
 * # robot_defines
 *
 * Definitions for /mob/living/silicon/robot and its children, including AI shells.
 *
 */

/mob/living/silicon/robot
	name = "Cyborg"
	real_name = "Cyborg"
	icon = 'icons/mob/silicon/robots.dmi' //SKYRAT EDIT - Modified in modular_skyrat\modules\altborgs\code\robot_defines.dm (to allow for custom transformation animations)
	icon_state = "robot"
	maxHealth = 100
	health = 100
	bubble_icon = "robot"
	designation = "Default" //used for displaying the prefix & getting the current model of cyborg
	has_limbs = TRUE
	hud_type = /datum/hud/robot

	///Represents the cyborg's model (engineering, medical, etc.)
	var/obj/item/robot_model/model = null

	radio = /obj/item/radio/borg

	blocks_emissive = EMISSIVE_BLOCK_UNIQUE
	light_system = MOVABLE_LIGHT_DIRECTIONAL
	light_on = FALSE


	//AI shell
	var/shell = FALSE
	var/deployed = FALSE
	var/mob/living/silicon/ai/mainframe = null
	var/datum/action/innate/undeployment/undeployment_action = new


	// Parts
	var/custom_name = ""
	var/braintype = "Cyborg"
	var/obj/item/mmi/mmi = null
	///Used for deconstruction to remember what the borg was constructed out of.
	var/obj/item/robot_suit/robot_suit = null
	///If this is a path, this gets created as an object in Initialize.
	var/obj/item/stock_parts/cell/cell = /obj/item/stock_parts/cell/high

	///If the lamp isn't broken.
	var/lamp_functional = TRUE
	///If the lamp is turned on
	var/lamp_enabled = FALSE
	///Set lamp color
	var/lamp_color = COLOR_WHITE
	///Set to true if a doomsday event is locking our lamp to on and RED
	var/lamp_doom = FALSE
	///Lamp brightness. Starts at 3, but can be 1 - 5.
	var/lamp_intensity = 3

	var/mutable_appearance/eye_lights


	// Hud
	var/atom/movable/screen/inv1 = null
	var/atom/movable/screen/inv2 = null
	var/atom/movable/screen/inv3 = null
	var/atom/movable/screen/hands = null

	///Used to determine whether they have the module menu shown or not
	var/shown_robot_modules = FALSE
	var/atom/movable/screen/robot_modules_background

	///Lamp button reference
	var/atom/movable/screen/robot/lamp/lampButton

	///The reference to the built-in tablet that borgs carry.
	var/atom/movable/screen/robot/modpc/interfaceButton

	var/sight_mode = 0
	hud_possible = list(ANTAG_HUD, DIAG_STAT_HUD, DIAG_HUD, DIAG_BATT_HUD, DIAG_TRACK_HUD)


	// Modules (tool slots)
	var/obj/item/module_active = null
	held_items = list(null, null, null) //we use held_items for the module holding, because that makes sense to do!

	///For checking which modules are disabled or not.
	var/disabled_modules


	// Status
	var/mob/living/silicon/ai/connected_ai = null

	var/opened = FALSE
	var/emag_cooldown = 0
	var/wiresexposed = FALSE

	var/lawupdate = TRUE //Cyborgs will sync their laws with their AI by default
	///Used to determine if a borg shows up on the robotics console.  Setting to TRUE hides them.
	var/scrambledcodes = FALSE
	///Boolean of whether the borg is locked down or not
	var/lockcharge = FALSE
	///Boolean of whether the borg was locked by its AI or nothing
	var/ai_lockdown = FALSE
	///Random serial number generated for each cyborg upon its initialization
	var/ident = 0
	var/locked = TRUE
	var/list/req_access = list(ACCESS_ROBOTICS)

	///Whether the robot has no charge left.
	var/low_power_mode = FALSE
	///So they can initialize sparks whenever/N
	var/datum/effect_system/spark_spread/spark_system

	///Jetpack-like effect.
	var/ionpulse = FALSE
	///Jetpack-like effect.
	var/ionpulse_on = FALSE
	///Ionpulse effect.
	var/datum/effect_system/trail_follow/ion/ion_trail


	// Misc
	var/toner = 0
	var/tonermax = 40

	var/list/upgrades = list()

	var/hasExpanded = FALSE
	var/obj/item/hat
	var/hat_offset = -3

	///What types of mobs are allowed to ride/buckle to this mob
	var/static/list/can_ride_typecache = typecacheof(/mob/living/carbon/human)
	can_buckle = TRUE
	buckle_lying = FALSE

	/// the last health before updating - to check net change in health
	var/previous_health
	/// Station alert datum for showing alerts UI
	var/datum/station_alert/alert_control

// Defining specific kinds of robots
///This is the subtype that gets created by robot suits. It's needed so that those kind of borgs don't have a useless cell in them
/mob/living/silicon/robot/nocell
	cell = null

/mob/living/silicon/robot/shell
	shell = TRUE
	cell = null

/mob/living/silicon/robot/model
	var/set_model = /obj/item/robot_model

/mob/living/silicon/robot/model/Initialize(mapload)
	. = ..()
	INVOKE_ASYNC(model, TYPE_PROC_REF(/obj/item/robot_model, transform_to), set_model, TRUE)

/mob/living/silicon/robot/model/clown
	set_model = /obj/item/robot_model/clown
	icon_state = "clown"

/mob/living/silicon/robot/model/engineering
	set_model = /obj/item/robot_model/engineering
	icon_state = "engineer"

/mob/living/silicon/robot/model/janitor
	set_model = /obj/item/robot_model/janitor
	icon_state = "janitor"

/mob/living/silicon/robot/model/medical
	set_model = /obj/item/robot_model/medical
	icon_state = "medical"

/mob/living/silicon/robot/model/miner
	set_model = /obj/item/robot_model/miner
	icon_state = "miner"

/mob/living/silicon/robot/model/peacekeeper
	set_model = /obj/item/robot_model/peacekeeper
	icon_state = "peace"

/mob/living/silicon/robot/model/security
	set_model = /obj/item/robot_model/security
	icon_state = "sec"

/mob/living/silicon/robot/model/service
	set_model = /obj/item/robot_model/service
	icon_state = "brobot"

/mob/living/silicon/robot/model/syndicate
	icon_state = "synd_sec"
	faction = list(ROLE_SYNDICATE)
	bubble_icon = "syndibot"
	req_access = list(ACCESS_SYNDICATE)
	lawupdate = FALSE
	scrambledcodes = TRUE // These are rogue borgs.
	ionpulse = TRUE
	var/playstyle_string = "<span class='big bold'>You are a Syndicate assault cyborg!</span><br>\
		<b>You are armed with powerful offensive tools to aid you in your mission: help the operatives secure the nuclear authentication disk. \
		Your cyborg LMG will slowly produce ammunition from your power supply, and your operative pinpointer will find and locate fellow nuclear operatives. \
		<i>Help the operatives secure the disk at all costs!</i></b>"
	set_model = /obj/item/robot_model/syndicate
	cell = /obj/item/stock_parts/cell/hyper
	radio = /obj/item/radio/borg/syndicate

/mob/living/silicon/robot/model/syndicate/proc/show_playstyle()
	if(playstyle_string)
		to_chat(src, playstyle_string)

/mob/living/silicon/robot/model/syndicate/medical
	icon_state = "synd_medical"
	playstyle_string = "<span class='big bold'>You are a Syndicate medical cyborg!</span><br>\
		<b>You are armed with powerful medical tools to aid you in your mission: help the operatives secure the nuclear authentication disk. \
		Your hypospray will produce Restorative Nanites, a wonder-drug that will heal most types of bodily damages, including clone and brain damage. It also produces morphine for offense. \
		Your defibrillator paddles can revive operatives through their suits, or can be used on harm intent to shock enemies! \
		Your energy saw functions as a circular saw, but can be activated to deal more damage, and your operative pinpointer will find and locate fellow nuclear operatives. \
		<i>Help the operatives secure the disk at all costs!</i></b>"
	set_model = /obj/item/robot_model/syndicate_medical

/mob/living/silicon/robot/model/syndicate/saboteur
	icon_state = "synd_engi"
	playstyle_string = "<span class='big bold'>You are a Syndicate saboteur cyborg!</span><br>\
		<b>You are armed with robust engineering tools to aid you in your mission: help the operatives secure the nuclear authentication disk. \
		Your destination tagger will allow you to stealthily traverse the disposal network across the station \
		Your welder will allow you to repair the operatives' exosuits, but also yourself and your fellow cyborgs \
		Your cyborg chameleon projector allows you to assume the appearance and registered name of a Nanotrasen engineering borg, and undertake covert actions on the station \
		Be aware that almost any physical contact or incidental damage will break your camouflage \
		<i>Help the operatives secure the disk at all costs!</i></b>"
	set_model = /obj/item/robot_model/saboteur

/mob/living/silicon/robot/model/syndicate/kiltborg
	set_model = /obj/item/robot_model/syndicate/kiltborg
	icon_state = "peace"
