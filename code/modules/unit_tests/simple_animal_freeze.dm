/// Tests that no new simple_animal subtypes are added.
/datum/unit_test/simple_animal_freeze
	// !!! DO NOT ADD NEW ENTRIES TO THIS LIST !!!
	// NO new simple animals are allowed.
	// Use the new basic mobs system instead.
	// If you are refactoring a simple_animal, REMOVE it from this list
	var/list/allowed_types = list(
		/mob/living/simple_animal/bot,
		/mob/living/simple_animal/bot/cleanbot,
		/mob/living/simple_animal/bot/cleanbot/autopatrol,
		/mob/living/simple_animal/bot/cleanbot/medbay,
		/mob/living/simple_animal/bot/firebot,
		/mob/living/simple_animal/bot/floorbot,
		/mob/living/simple_animal/bot/hygienebot,
		/mob/living/simple_animal/bot/medbot,
		/mob/living/simple_animal/bot/medbot/autopatrol,
		/mob/living/simple_animal/bot/medbot/derelict,
		/mob/living/simple_animal/bot/medbot/mysterious,
		/mob/living/simple_animal/bot/medbot/stationary,
		/mob/living/simple_animal/bot/mulebot,
		/mob/living/simple_animal/bot/mulebot/paranormal,
		/mob/living/simple_animal/bot/secbot,
		/mob/living/simple_animal/bot/secbot/beepsky,
		/mob/living/simple_animal/bot/secbot/beepsky/armsky,
		/mob/living/simple_animal/bot/secbot/beepsky/jr,
		/mob/living/simple_animal/bot/secbot/beepsky/officer,
		/mob/living/simple_animal/bot/secbot/beepsky/ofitser,
		/mob/living/simple_animal/bot/secbot/ed209,
		/mob/living/simple_animal/bot/secbot/genesky,
		/mob/living/simple_animal/bot/secbot/grievous,
		/mob/living/simple_animal/bot/secbot/grievous/toy,
		/mob/living/simple_animal/bot/secbot/honkbot,
		/mob/living/simple_animal/bot/secbot/pingsky,
		/mob/living/simple_animal/bot/vibebot,
		/mob/living/simple_animal/chick,
		/mob/living/simple_animal/chick/holo,
		/mob/living/simple_animal/crab,
		/mob/living/simple_animal/crab/coffee,
		/mob/living/simple_animal/crab/evil,
		/mob/living/simple_animal/crab/evil/kreb,
		/mob/living/simple_animal/crab/jon,
		/mob/living/simple_animal/crab/kreb,
		/mob/living/simple_animal/drone,
		/mob/living/simple_animal/drone/classic,
		/mob/living/simple_animal/drone/derelict,
		/mob/living/simple_animal/drone/polymorphed,
		/mob/living/simple_animal/drone/snowflake,
		/mob/living/simple_animal/drone/snowflake/bardrone,
		/mob/living/simple_animal/drone/syndrone,
		/mob/living/simple_animal/drone/syndrone/badass,
		/mob/living/simple_animal/holodeck_monkey,
		/mob/living/simple_animal/hostile,
		/mob/living/simple_animal/hostile/alien,
		/mob/living/simple_animal/hostile/alien/drone,
		/mob/living/simple_animal/hostile/alien/maid,
		/mob/living/simple_animal/hostile/alien/maid/barmaid,
		/mob/living/simple_animal/hostile/alien/queen,
		/mob/living/simple_animal/hostile/alien/queen/large,
		/mob/living/simple_animal/hostile/alien/sentinel,
		/mob/living/simple_animal/hostile/ant,
		/mob/living/simple_animal/hostile/asteroid,
		/mob/living/simple_animal/hostile/asteroid/basilisk,
		/mob/living/simple_animal/hostile/asteroid/basilisk/watcher,
		/mob/living/simple_animal/hostile/asteroid/basilisk/watcher/icewing,
		/mob/living/simple_animal/hostile/asteroid/basilisk/watcher/magmawing,
		/mob/living/simple_animal/hostile/asteroid/basilisk/watcher/random,
		/mob/living/simple_animal/hostile/asteroid/basilisk/watcher/tendril,
		/mob/living/simple_animal/hostile/asteroid/brimdemon,
		/mob/living/simple_animal/hostile/asteroid/curseblob,
		/mob/living/simple_animal/hostile/asteroid/elite,
		/mob/living/simple_animal/hostile/asteroid/elite/broodmother,
		/mob/living/simple_animal/hostile/asteroid/elite/broodmother_child,
		/mob/living/simple_animal/hostile/asteroid/elite/herald,
		/mob/living/simple_animal/hostile/asteroid/elite/herald/mirror,
		/mob/living/simple_animal/hostile/asteroid/elite/legionnaire,
		/mob/living/simple_animal/hostile/asteroid/elite/legionnairehead,
		/mob/living/simple_animal/hostile/asteroid/elite/pandora,
		/mob/living/simple_animal/hostile/asteroid/goldgrub,
		/mob/living/simple_animal/hostile/asteroid/goliath,
		/mob/living/simple_animal/hostile/asteroid/goliath/beast,
		/mob/living/simple_animal/hostile/asteroid/goliath/beast/ancient,
		/mob/living/simple_animal/hostile/asteroid/goliath/beast/random,
		/mob/living/simple_animal/hostile/asteroid/goliath/beast/tendril,
		/mob/living/simple_animal/hostile/asteroid/gutlunch,
		/mob/living/simple_animal/hostile/asteroid/gutlunch/grublunch,
		/mob/living/simple_animal/hostile/asteroid/gutlunch/gubbuck,
		/mob/living/simple_animal/hostile/asteroid/gutlunch/guthen,
		/mob/living/simple_animal/hostile/asteroid/hivelord,
		/mob/living/simple_animal/hostile/asteroid/hivelord/legion,
		/mob/living/simple_animal/hostile/asteroid/hivelord/legion/advanced,
		/mob/living/simple_animal/hostile/asteroid/hivelord/legion/dwarf,
		/mob/living/simple_animal/hostile/asteroid/hivelord/legion/random,
		/mob/living/simple_animal/hostile/asteroid/hivelord/legion/snow,
		/mob/living/simple_animal/hostile/asteroid/hivelord/legion/snow/portal,
		/mob/living/simple_animal/hostile/asteroid/hivelord/legion/tendril,
		/mob/living/simple_animal/hostile/asteroid/hivelordbrood,
		/mob/living/simple_animal/hostile/asteroid/hivelordbrood/legion,
		/mob/living/simple_animal/hostile/asteroid/hivelordbrood/legion/advanced,
		/mob/living/simple_animal/hostile/asteroid/hivelordbrood/legion/snow,
		/mob/living/simple_animal/hostile/asteroid/ice_demon,
		/mob/living/simple_animal/hostile/asteroid/ice_whelp,
		/mob/living/simple_animal/hostile/asteroid/lobstrosity,
		/mob/living/simple_animal/hostile/asteroid/lobstrosity/lava,
		/mob/living/simple_animal/hostile/asteroid/polarbear,
		/mob/living/simple_animal/hostile/asteroid/polarbear/lesser,
		/mob/living/simple_animal/hostile/asteroid/wolf,
		/mob/living/simple_animal/hostile/bear,
		/mob/living/simple_animal/hostile/bear/butter,
		/mob/living/simple_animal/hostile/bear/fightpit,
		/mob/living/simple_animal/hostile/bear/hudson,
		/mob/living/simple_animal/hostile/bear/russian,
		/mob/living/simple_animal/hostile/bear/snow,
		/mob/living/simple_animal/hostile/bee,
		/mob/living/simple_animal/hostile/bee/queen,
		/mob/living/simple_animal/hostile/bee/short,
		/mob/living/simple_animal/hostile/bee/toxin,
		/mob/living/simple_animal/hostile/big_legion,
		/mob/living/simple_animal/hostile/blob,
		/mob/living/simple_animal/hostile/blob/blobbernaut,
		/mob/living/simple_animal/hostile/blob/blobbernaut/independent,
		/mob/living/simple_animal/hostile/blob/blobspore,
		/mob/living/simple_animal/hostile/blob/blobspore/independent,
		/mob/living/simple_animal/hostile/blob/blobspore/weak,
		/mob/living/simple_animal/hostile/boss,
		/mob/living/simple_animal/hostile/boss/paper_wizard,
		/mob/living/simple_animal/hostile/boss/paper_wizard/copy,
		/mob/living/simple_animal/hostile/construct,
		/mob/living/simple_animal/hostile/construct/artificer,
		/mob/living/simple_animal/hostile/construct/artificer/angelic,
		/mob/living/simple_animal/hostile/construct/artificer/hostile,
		/mob/living/simple_animal/hostile/construct/artificer/mystic,
		/mob/living/simple_animal/hostile/construct/artificer/noncult,
		/mob/living/simple_animal/hostile/construct/harvester,
		/mob/living/simple_animal/hostile/construct/juggernaut,
		/mob/living/simple_animal/hostile/construct/juggernaut/angelic,
		/mob/living/simple_animal/hostile/construct/juggernaut/hostile,
		/mob/living/simple_animal/hostile/construct/juggernaut/mystic,
		/mob/living/simple_animal/hostile/construct/juggernaut/noncult,
		/mob/living/simple_animal/hostile/construct/proteon,
		/mob/living/simple_animal/hostile/construct/proteon/hostile,
		/mob/living/simple_animal/hostile/construct/wraith,
		/mob/living/simple_animal/hostile/construct/wraith/angelic,
		/mob/living/simple_animal/hostile/construct/wraith/hostile,
		/mob/living/simple_animal/hostile/construct/wraith/mystic,
		/mob/living/simple_animal/hostile/construct/wraith/noncult,
		/mob/living/simple_animal/hostile/dark_wizard,
		/mob/living/simple_animal/hostile/eyeball,
		/mob/living/simple_animal/hostile/gorilla,
		/mob/living/simple_animal/hostile/gorilla/cargo_domestic,
		/mob/living/simple_animal/hostile/guardian,
		/mob/living/simple_animal/hostile/guardian/assassin,
		/mob/living/simple_animal/hostile/guardian/charger,
		/mob/living/simple_animal/hostile/guardian/dextrous,
		/mob/living/simple_animal/hostile/guardian/explosive,
		/mob/living/simple_animal/hostile/guardian/gaseous,
		/mob/living/simple_animal/hostile/guardian/gravitokinetic,
		/mob/living/simple_animal/hostile/guardian/lightning,
		/mob/living/simple_animal/hostile/guardian/protector,
		/mob/living/simple_animal/hostile/guardian/ranged,
		/mob/living/simple_animal/hostile/guardian/standard,
		/mob/living/simple_animal/hostile/guardian/support,
		/mob/living/simple_animal/hostile/headcrab,
		/mob/living/simple_animal/hostile/heretic_summon,
		/mob/living/simple_animal/hostile/heretic_summon/armsy,
		/mob/living/simple_animal/hostile/heretic_summon/armsy/prime,
		/mob/living/simple_animal/hostile/heretic_summon/ash_spirit,
		/mob/living/simple_animal/hostile/heretic_summon/maid_in_the_mirror,
		/mob/living/simple_animal/hostile/heretic_summon/raw_prophet,
		/mob/living/simple_animal/hostile/heretic_summon/rust_spirit,
		/mob/living/simple_animal/hostile/heretic_summon/stalker,
		/mob/living/simple_animal/hostile/hivebot,
		/mob/living/simple_animal/hostile/hivebot/mechanic,
		/mob/living/simple_animal/hostile/hivebot/range,
		/mob/living/simple_animal/hostile/hivebot/rapid,
		/mob/living/simple_animal/hostile/hivebot/strong,
		/mob/living/simple_animal/hostile/illusion,
		/mob/living/simple_animal/hostile/illusion/escape,
		/mob/living/simple_animal/hostile/illusion/mirage,
		/mob/living/simple_animal/hostile/imp,
		/mob/living/simple_animal/hostile/imp/slaughter,
		/mob/living/simple_animal/hostile/imp/slaughter/engine_demon,
		/mob/living/simple_animal/hostile/imp/slaughter/laughter,
		/mob/living/simple_animal/hostile/jungle,
		/mob/living/simple_animal/hostile/jungle/leaper,
		/mob/living/simple_animal/hostile/jungle/mega_arachnid,
		/mob/living/simple_animal/hostile/jungle/mook,
		/mob/living/simple_animal/hostile/jungle/seedling,
		/mob/living/simple_animal/hostile/megafauna,
		/mob/living/simple_animal/hostile/megafauna/blood_drunk_miner,
		/mob/living/simple_animal/hostile/megafauna/blood_drunk_miner/doom,
		/mob/living/simple_animal/hostile/megafauna/blood_drunk_miner/guidance,
		/mob/living/simple_animal/hostile/megafauna/blood_drunk_miner/hunter,
		/mob/living/simple_animal/hostile/megafauna/bubblegum,
		/mob/living/simple_animal/hostile/megafauna/bubblegum/hallucination,
		/mob/living/simple_animal/hostile/megafauna/clockwork_defender,
		/mob/living/simple_animal/hostile/megafauna/colossus,
		/mob/living/simple_animal/hostile/megafauna/demonic_frost_miner,
		/mob/living/simple_animal/hostile/megafauna/dragon,
		/mob/living/simple_animal/hostile/megafauna/dragon/lesser,
		/mob/living/simple_animal/hostile/megafauna/hierophant,
		/mob/living/simple_animal/hostile/megafauna/legion,
		/mob/living/simple_animal/hostile/megafauna/legion/medium,
		/mob/living/simple_animal/hostile/megafauna/legion/medium/eye,
		/mob/living/simple_animal/hostile/megafauna/legion/medium/left,
		/mob/living/simple_animal/hostile/megafauna/legion/medium/right,
		/mob/living/simple_animal/hostile/megafauna/legion/small,
		/mob/living/simple_animal/hostile/megafauna/wendigo,
		/mob/living/simple_animal/hostile/mimic,
		/mob/living/simple_animal/hostile/mimic/copy,
		/mob/living/simple_animal/hostile/mimic/copy/machine,
		/mob/living/simple_animal/hostile/mimic/copy/ranged,
		/mob/living/simple_animal/hostile/mimic/crate,
		/mob/living/simple_animal/hostile/mimic/xenobio,
		/mob/living/simple_animal/hostile/mining_drone,
		/mob/living/simple_animal/hostile/morph,
		/mob/living/simple_animal/hostile/mushroom,
		/mob/living/simple_animal/hostile/nanotrasen,
		/mob/living/simple_animal/hostile/nanotrasen/elite,
		/mob/living/simple_animal/hostile/nanotrasen/ranged,
		/mob/living/simple_animal/hostile/nanotrasen/ranged/assault,
		/mob/living/simple_animal/hostile/nanotrasen/ranged/smg,
		/mob/living/simple_animal/hostile/nanotrasen/screaming,
		/mob/living/simple_animal/hostile/ooze,
		/mob/living/simple_animal/hostile/ooze/gelatinous,
		/mob/living/simple_animal/hostile/ooze/grapes,
		/mob/living/simple_animal/hostile/pirate,
		/mob/living/simple_animal/hostile/pirate/melee,
		/mob/living/simple_animal/hostile/pirate/melee/space,
		/mob/living/simple_animal/hostile/pirate/ranged,
		/mob/living/simple_animal/hostile/pirate/ranged/space,
		/mob/living/simple_animal/hostile/regalrat,
		/mob/living/simple_animal/hostile/regalrat/controlled,
		/mob/living/simple_animal/hostile/retaliate,
		/mob/living/simple_animal/hostile/retaliate/clown,
		/mob/living/simple_animal/hostile/retaliate/clown/banana,
		/mob/living/simple_animal/hostile/retaliate/clown/clownhulk,
		/mob/living/simple_animal/hostile/retaliate/clown/clownhulk/chlown,
		/mob/living/simple_animal/hostile/retaliate/clown/clownhulk/destroyer,
		/mob/living/simple_animal/hostile/retaliate/clown/clownhulk/honcmunculus,
		/mob/living/simple_animal/hostile/retaliate/clown/fleshclown,
		/mob/living/simple_animal/hostile/retaliate/clown/honkling,
		/mob/living/simple_animal/hostile/retaliate/clown/longface,
		/mob/living/simple_animal/hostile/retaliate/clown/lube,
		/mob/living/simple_animal/hostile/retaliate/clown/mutant,
		/mob/living/simple_animal/hostile/retaliate/clown/mutant/glutton,
		/mob/living/simple_animal/hostile/retaliate/clown/mutant/slow,
		/mob/living/simple_animal/hostile/retaliate/goat,
		/mob/living/simple_animal/hostile/retaliate/goose,
		/mob/living/simple_animal/hostile/retaliate/goose/vomit,
		/mob/living/simple_animal/hostile/retaliate/nanotrasenpeace,
		/mob/living/simple_animal/hostile/retaliate/nanotrasenpeace/ranged,
		/mob/living/simple_animal/hostile/retaliate/snake,
		/mob/living/simple_animal/hostile/retaliate/spaceman,
		/mob/living/simple_animal/hostile/retaliate/trader,
		/mob/living/simple_animal/hostile/retaliate/trader/mrbones,
		/mob/living/simple_animal/hostile/skeleton,
		/mob/living/simple_animal/hostile/skeleton/eskimo,
		/mob/living/simple_animal/hostile/skeleton/ice,
		/mob/living/simple_animal/hostile/skeleton/plasmaminer,
		/mob/living/simple_animal/hostile/skeleton/plasmaminer/jackhammer,
		/mob/living/simple_animal/hostile/skeleton/templar,
		/mob/living/simple_animal/hostile/smspider,
		/mob/living/simple_animal/hostile/smspider/overcharged,
		/mob/living/simple_animal/hostile/space_dragon,
		/mob/living/simple_animal/hostile/vatbeast,
		/mob/living/simple_animal/hostile/venus_human_trap,
		/mob/living/simple_animal/hostile/wizard,
		/mob/living/simple_animal/hostile/zombie,
		/mob/living/simple_animal/parrot,
		/mob/living/simple_animal/parrot/natural,
		/mob/living/simple_animal/parrot/poly,
		/mob/living/simple_animal/parrot/poly/ghost,
		/mob/living/simple_animal/pet,
		/mob/living/simple_animal/pet/cat,
		/mob/living/simple_animal/pet/cat/_proc,
		/mob/living/simple_animal/pet/cat/breadcat,
		/mob/living/simple_animal/pet/cat/cak,
		/mob/living/simple_animal/pet/cat/jerry,
		/mob/living/simple_animal/pet/cat/kitten,
		/mob/living/simple_animal/pet/cat/original,
		/mob/living/simple_animal/pet/cat/runtime,
		/mob/living/simple_animal/pet/cat/space,
		/mob/living/simple_animal/pet/fox,
		/mob/living/simple_animal/pet/fox/renault,
		/mob/living/simple_animal/pet/gondola,
		/mob/living/simple_animal/pet/gondola/gondolapod,
		/mob/living/simple_animal/pet/penguin,
		/mob/living/simple_animal/pet/penguin/baby,
		/mob/living/simple_animal/pet/penguin/emperor,
		/mob/living/simple_animal/pet/penguin/emperor/shamebrero,
		/mob/living/simple_animal/revenant,
		/mob/living/simple_animal/robot_customer,
		/mob/living/simple_animal/shade,
		/mob/living/simple_animal/slime,
		/mob/living/simple_animal/slime/pet,
		/mob/living/simple_animal/slime/random,
		/mob/living/simple_animal/slime/transformed_slime,
		/mob/living/simple_animal/sloth,
		/mob/living/simple_animal/sloth/citrus,
		/mob/living/simple_animal/sloth/paperwork,
		/mob/living/simple_animal/soulscythe,

		//MODULAR SKYRAT ENTRIES
		//PLEASE REFACTOR THESE AS YOU CAN
		/mob/living/simple_animal/crab/shuffle,
		/mob/living/simple_animal/hostile/bear/wojtek,
		/mob/living/simple_animal/hostile/bigcrab,
		/mob/living/simple_animal/hostile/biohazard_blob,
		/mob/living/simple_animal/hostile/biohazard_blob/centaur,
		/mob/living/simple_animal/hostile/biohazard_blob/diseased_rat,
		/mob/living/simple_animal/hostile/biohazard_blob/electric_mosquito,
		/mob/living/simple_animal/hostile/biohazard_blob/oil_shambler,
		/mob/living/simple_animal/hostile/blackmesa,
		/mob/living/simple_animal/hostile/blackmesa/blackops,
		/mob/living/simple_animal/hostile/blackmesa/blackops/ranged,
		/mob/living/simple_animal/hostile/blackmesa/hecu,
		/mob/living/simple_animal/hostile/blackmesa/hecu/ranged,
		/mob/living/simple_animal/hostile/blackmesa/hecu/ranged/smg,
		/mob/living/simple_animal/hostile/blackmesa/sec,
		/mob/living/simple_animal/hostile/blackmesa/sec/ranged,
		/mob/living/simple_animal/hostile/blackmesa/xen,
		/mob/living/simple_animal/hostile/blackmesa/xen/bullsquid,
		/mob/living/simple_animal/hostile/blackmesa/xen/headcrab,
		/mob/living/simple_animal/hostile/blackmesa/xen/headcrab/fast,
		/mob/living/simple_animal/hostile/blackmesa/xen/headcrab_zombie,
		/mob/living/simple_animal/hostile/blackmesa/xen/headcrab_zombie/gordon_freeman,
		/mob/living/simple_animal/hostile/blackmesa/xen/headcrab_zombie/guard,
		/mob/living/simple_animal/hostile/blackmesa/xen/headcrab_zombie/hecu,
		/mob/living/simple_animal/hostile/blackmesa/xen/headcrab_zombie/hev,
		/mob/living/simple_animal/hostile/blackmesa/xen/headcrab_zombie/scientist,
		/mob/living/simple_animal/hostile/blackmesa/xen/houndeye,
		/mob/living/simple_animal/hostile/blackmesa/xen/nihilanth,
		/mob/living/simple_animal/hostile/blackmesa/xen/vortigaunt,
		/mob/living/simple_animal/hostile/blackmesa/xen/vortigaunt/slave,
		/mob/living/simple_animal/hostile/cazador,
		/mob/living/simple_animal/hostile/cult,
		/mob/living/simple_animal/hostile/cult/assassin,
		/mob/living/simple_animal/hostile/cult/ghost,
		/mob/living/simple_animal/hostile/cult/horror,
		/mob/living/simple_animal/hostile/cult/magic,
		/mob/living/simple_animal/hostile/cult/magic/elite,
		/mob/living/simple_animal/hostile/cult/mannequin,
		/mob/living/simple_animal/hostile/cult/spear,
		/mob/living/simple_animal/hostile/cult/warrior,
		/mob/living/simple_animal/hostile/devourdem,
		/mob/living/simple_animal/hostile/engorge,
		/mob/living/simple_animal/hostile/evilborg,
		/mob/living/simple_animal/hostile/evilborg/bigguy,
		/mob/living/simple_animal/hostile/evilborg/dog,
		/mob/living/simple_animal/hostile/evilborg/dogstrong,
		/mob/living/simple_animal/hostile/evilborg/engi,
		/mob/living/simple_animal/hostile/evilborg/heavy,
		/mob/living/simple_animal/hostile/evilborg/peace,
		/mob/living/simple_animal/hostile/evilborg/protect,
		/mob/living/simple_animal/hostile/evilborg/roomba,
		/mob/living/simple_animal/hostile/evilborg/sec,
		/mob/living/simple_animal/hostile/looter,
		/mob/living/simple_animal/hostile/looter/big,
		/mob/living/simple_animal/hostile/looter/crusher,
		/mob/living/simple_animal/hostile/looter/ranged,
		/mob/living/simple_animal/hostile/looter/ranged/space,
		/mob/living/simple_animal/hostile/looter/ranged/space/laser,
		/mob/living/simple_animal/hostile/mannequin,
		/mob/living/simple_animal/hostile/megafauna/bubblegum/no_gps,
		/mob/living/simple_animal/hostile/megafauna/gladiator,
		/mob/living/simple_animal/hostile/megafauna/hierophant/astrum,
		/mob/living/simple_animal/hostile/mining_drone/interdyne,
		/mob/living/simple_animal/hostile/mutantliz,
		/mob/living/simple_animal/hostile/plantmutant,
		/mob/living/simple_animal/hostile/scorpion,
		/mob/living/simple_animal/hostile/syndimouse,
		/mob/living/simple_animal/hostile/trog,
		/mob/living/simple_animal/hostile/true_changeling,
		/mob/living/simple_animal/hostile/vox,
		/mob/living/simple_animal/hostile/vox/melee,
		/mob/living/simple_animal/hostile/vox/ranged,
		/mob/living/simple_animal/hostile/vox/ranged/laser,
		/mob/living/simple_animal/hostile/vox/ranged/space,
		/mob/living/simple_animal/hostile/vox/ranged/space/laser,
		/mob/living/simple_animal/hostile/zombie/cheesezombie,
		/mob/living/simple_animal/hostile/zombie/nocorpse,
		/mob/living/simple_animal/pet/gondola/funky,
		/mob/living/simple_animal/pet/poppy,

		// DO NOT ADD NEW ENTRIES TO THIS LIST
		// READ THE COMMENT ABOVE

		//MODULAR SKYRAT ENTRIES
		//PLEASE REFACTOR THESE AS YOU CAN

		/mob/living/simple_animal/pet/redpanda,
		/mob/living/simple_animal/pet/redpanda/zesty,
		/mob/living/simple_animal/pet/plushie,

		// DO NOT ADD NEW ENTRIES TO THIS LIST
		// READ THE COMMENT ABOVE

	)

/datum/unit_test/simple_animal_freeze/Run()
	var/list/seen = list()

	// Sanity check, to prevent people from just doing a mass find and replace
	for (var/allowed_type in allowed_types)
		if (allowed_type in seen)
			TEST_FAIL("[allowed_type] is in the allowlist more than once")
		else
			seen[allowed_type] = TRUE

		TEST_ASSERT(ispath(allowed_type, /mob/living/simple_animal), "[allowed_type] is not a simple_animal. Remove it from the list.")

	for (var/subtype in subtypesof(/mob/living/simple_animal))
		if (!(subtype in allowed_types))
			TEST_FAIL("No new simple_animal subtypes are allowed. Please refactor [subtype] into a basic mob.")
