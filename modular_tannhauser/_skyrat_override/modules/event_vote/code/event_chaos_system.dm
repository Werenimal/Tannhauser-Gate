/// Tanhauser Override file for skyrat based event system


/// Increases the minimum time for moderately disruptive events
/datum/round_event_control/preset/moderate
	earliest_start = 30 MINUTES

/// Lowersa player count for highly disruptive events and increases the minimum time before they occur
/datum/round_event_control/preset/high
	earliest_start = 50 MINUTES
	min_players = 20

/// Changes Grey Tide to medium severity to cope with lack of AI support
/datum/round_event_control/grey_tide
	chaos_level = EVENT_CHAOS_MED


/// Meteors escalated in severity
/datum/round_event_control/meteor_wave/threatening
	chaos_level = EVENT_CHAOS_HIGH

/datum/round_event_control/meteor_wave
	chaos_level = EVENT_CHAOS_HIGH
