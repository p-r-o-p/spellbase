use dnd_db;

-- Make certain the spell table is not polluted with old data.
SET FOREIGN_KEY_CHECKS = 0;
TRUNCATE spell;
SET FOREIGN_KEY_CHECKS = 1;
-- Populate the spell table.
INSERT INTO spell (name, level, is_ritual, reach, is_touch, is_self, is_concentration, is_verbal, is_somatic, description)
VALUES ("Acid Splash", 0, FALSE, 60, FALSE, FALSE, FALSE, TRUE, TRUE, "You hurl a bubble of acid. Chose one creature within range, or choose two creatures within range that are within 5 feet of each other. A target must succed on a Dexterity saving throw or take 1d6 acid damage.\n\nThis spell's damage increases by 1d6 when you reach 5th level (2d6), 11th level (3d6) and 17th level (4d6)."),
("Aid", 2, FALSE, 30, FALSE, FALSE, FALSE, TRUE, TRUE, "Your spell bolsters your allies with toughness and resolve. Choose up to three creatures within range. Each target's hit point maximum and current hit points increase by 5 for the duration.\n\nWhen you cast this spell using a spell slot of 3rd or higher, a target's hit points increase by an additional 5 for each slot level above 2nd."),
("Alarm", 1, TRUE, 30, FALSE, FALSE, FALSE, TRUE, TRUE, "You set an alarm against unwanted intrusion. Choose a door, a window, or an area within range that is no larger than a 20-foot cube. Until the spell ends, an alarm alerts you whenever a Tiny or larger creature touches or enters the warded area. When you cast the spell, you can designate creatures that won't set off the alarm. You also choose whether the alarm is mental or audible.\n\nA mental alarm alerts you with a ping in your mind if you are within 1 mile of the warded area. This ping awakens you, if you are sleeping.\n\nAn audible alarm produces the sound of a hand bell for 10 seconds within 60 feet."),
("Alter Self", 2, FALSE, 0, FALSE, TRUE, TRUE, TRUE, TRUE, "You assume a different form. When you cast this spell, choose one of the following options, the effect of which last for the duration of the spell. While the spell lasts,you can end one option as an action to gain the benefits of a different one.\n\nAcquatic Adaption. You adapt your body to an aquatic environment, sprouting gills and growing webbing between your fingers. You can breathe underwater and gain swimming speed equal to your walking speed.\n\nChange Appearance. You transform your appearance. You decide what you look like, including your height, weight, facial features, sound of your voice, hair length, coloration, and distinguishing characteristics, if any. You can make yourself appear as any race, though non of your statistics change. You also can't appear as a creature of a different size than you, and your basic shape stays the same; if you're bipedal, you can't use this spell to become quadrupedal, for instance. At any time for the duration of the spell, you can use your action to change your appearance in this way again.\n\nNatural Weapons. You grow claws, fangs, spines, horns, or a different natural weapon of your choice. Your unarmed strikes deal 1d6 bludgeoning, piercing, or slashing damage, as appropiate to the natural weapon you chose, and you are proficient with your unarmed strikes. Finally the weapon is magic and you have a +1 bonus to the attack and damage rolls you make using it."),
("Animal Friendship", 1, FALSE, 30, FALSE, FALSE, FALSE, TRUE, TRUE, "This spell lets your convince a beast that you mean it no harm. Choose a beast that you can see within range. It must see and hear you. If the beast's Intelligence is 4 or higher, the spell fails. Otherwise, the beast must succed on a Wisdom saving throw or be charmed by you for the spell's duration. If you or one of your companions harms the target, the spell ends.\n\nWhen you cast this spell using a spell slot of 2nd level or higher, you can affect one additional beast for each slot level above 1st."),
("Animal Messenger", 2, TRUE, 30, FALSE, FALSE, FALSE, TRUE, TRUE, "By means of this spell, you use an animal to deliver a message. Choose a Tiny beast you can see within range, such as a squirrel, a blue jay, or a bat. You specify a location, which you must have visited, and a recipient who matches a general description, such as \"man or woman dressed in the uniform of the townguard\" or \"A red-haired dwarf wearing a pointed hat.\" You also speak a message of up to twenty-five words. The target beast travels for the duration of the spell towards the specified location, covering 50 miles per 24 hours for a flying messenger, or 25 miles for other animals.\n\nWhen the messenger arrives, it delivers yyour message to the creature that you described, replicating the sound of your voice. The messenger speaks only to a creature matching the description you gave. If the messenger doesn't reach it's destination before the spell ends, the message is lost, and the beast makes its way back to where you cast this spell.\n\nIf you cast this using a spell slot of 3rd level or higher, the duration of the spell increases by 48 hours for each slot above 2nd."),
("Animal Shapes", 8, FALSE, 30, FALSE, FALSE, TRUE, TRUE, TRUE, "Your magic turns others into beasts. Choose any number of willing creatures that you can see within range. You transform each target into the form of a Large or smaller beast witg challenge rating of 4 or lower. On subsequent turns, you can use your action to transform affected creatures into new forms.\n\nThe Transformation lasts for the duration for each target, or until the target drops to 0 hit points or dies. You can choose a different form for each target. A target's game statistics are replaced by the statistics of  the chosen beast, though the target retains its alignment and Intelligence, Wisdom and Charisma scores. The target assumes the hit points of its new form, and when it reverts to its normal form, it returns to the number of hit points it had before it was transformed. If it reverts as a result of dropping to 0 hit points, any excess damage carries over to its normal form. As long as the excess damage doesn't reduce the creature's normal form to 0 hit points, it isn't knocked unconcious. The creature is limited in the actions it can perform by the nature of its new form, and it can't speak or cast spells.\n\nThe target's gear melds into the new form. The target can't activate, wield, or otherwise benefit from any of its equipment."),
("Animate Dead", 3, FALSE, 10, FALSE, FALSE, FALSE, TRUE, TRUE, "This spell creates an undead servant. Choose a pile of bones or a corpse of a Medium or Small humanoid within range. Your spell imbues the target with a foul mimicry of life, raising it as an undead creature. The target becomes a skeleton if you chose bones or a zombie if you chose a corpse (the DM has the creature's game statistics).\n\nOn each of your turns, you can use a bonuss action to mentally command any creature you made within 60 feet of you (if you control multiple creatures, you can command any or all of them at the same time, issuing the same command to each one). You decide what action the creature will take and where it will move during its next turn, or you can issue a general command, such as to guard a particular chamber or corridor. If you issue no commands, the creature only defends itself against hostile creatures. Once given an order, the creature continues to follow it until the task is complete.\n\nThe Creature is under you control for 24 hours, after which it stops obeying any command you've given to it. To maintain control of the creature for another 24 hours, you must cast this spell on the creature again before the current 24-hour period ends. This use of the spell reasserts your control over up to 4 creatures you have animated with this spell, rather than animating a new one.\n\nWhen you cast this spell using a spell slot of 4th level or higher, you animate or reassert control over two additional undead creatures for each slot level above 3rd. Each of the creatures must come from a different corpse or pile of bones.");


-- Make certain the school table is not polluted with old data.
SET FOREIGN_KEY_CHECKS = 0;
TRUNCATE school;
SET FOREIGN_KEY_CHECKS = 1;
-- Populate the school table.
INSERT INTO school (name, description)
VALUES ("Abjuration", "Abjuration spells are protective in nature, though some of them have aggressive uses. The create magical barriers, negate harmful effects, harm trespassers or banish creatures to other planes of existence."),
("Conjuration", "Conjuration spells involve the transportation of objects and creatures from one location to another. Some spells summon creatures or objects to the caster's side, whereas others allow the caster to teleport to another location. Some conjurations create objects or effects out of nothing."),
("Divination", "Divination spells reveal information, whether in the form of secrets long forgotten, glimpses of the future, the location of hidden things, the truth behind illusions, or visions of distance people or places."),
("Enchantment", "Enchantment spells affect the minds of others, influencing or controlling their behavior. Such spells can make enemies see the caster as a friend, force creatures to take a course of action, or even control another creature like a puppet."),
("Evocation", "Evocation spells manupulate energy to produce a desired effect. Some call up blasts of fire or lightning. Others channel positive energy to heal wounds."),
("Illusion", "Illusion spells decieve the senses or minds of others. They cause people to see thinngs that are not there, to miss things that are there, to hear phantom noises, or to remember things that never happened. Some illusions create phantom images that any creature can see, but the most insidious illusions plant an image directly in the mind of the creature."),
("Necromancy", "Necromancy spells manipulate the energies of life and death. Such spells grant an extra reserve of life force, drain the life energy of another creature, create the undead, or even bring the dead back to life.\n\nCreating the undead through the use of necromancy spells such as 'animate dead' is not a good act, and only evil casters use such spells frequently."),
("Transmutation", "Transmutation spells change the properties of a creature, object or environment. They might turn an enemy into a harmless creature, bolster the strength of an ally, make an object move at the caster's command, or enhance a creature's innate healing abilities to rapidly recover from injury.");


-- Make certain the time_unit table is not polluted with old data.
SET FOREIGN_KEY_CHECKS = 0;
TRUNCATE time_unit;
SET FOREIGN_KEY_CHECKS = 1;
INSERT INTO time_unit (name)
VALUES ("Action"),
("Reaction"),
("Bonus action"),
("Minute");


-- Make certain the material table is not polluted with old data.
SET FOREIGN_KEY_CHECKS = 0;
TRUNCATE material;
SET FOREIGN_KEY_CHECKS = 1;
INSERT INTO material (name)
VALUES ("A tiny strip of white cloth"),
("A tiny bell"),
("A piece of fine silver wire"),
("A morsel of food"),
("A drop of blood"),
("A piece of flesh"),
("A pinch of bone dust");


-- Make certain the class table is not polluted with old data.
SET FOREIGN_KEY_CHECKS = 0;
TRUNCATE class;
SET FOREIGN_KEY_CHECKS = 1;
INSERT INTO class (name)
VALUES ("Bard"),
("Cleric"),
("Druid"),
("Paladin"),
("Ranger"),
("Sorcerer"),
("Warlock"),
("Wizard");


-- Make certain the expansion table is not polluted with old data.
SET FOREIGN_KEY_CHECKS = 0;
TRUNCATE expansion;
SET FOREIGN_KEY_CHECKS = 1;
-- Populate the expansion table
INSERT INTO expansion (name)
VALUES ("Player's Handbook");


-- Make certain the class_spell table is not polluted with old data.
SET FOREIGN_KEY_CHECKS = 0;
TRUNCATE class_spell;
SET FOREIGN_KEY_CHECKS = 1;


-- Make certain the casting_spell_time_unit table is not polluted with old data.
SET FOREIGN_KEY_CHECKS = 0;
TRUNCATE casting_spell_time_unit;
SET FOREIGN_KEY_CHECKS = 1;
INSERT INTO casting_spell_time_unit (spell_id, time_unit_id, quantity)
VALUES ((SELECT spell.id FROM spell WHERE spell.name = "Acid Splash"), (SELECT time_unit.id FROM time_unit WHERE time_unit.name = "Action"), 1),
((SELECT spell.id FROM spell WHERE spell.name = "Aid"), (SELECT time_unit.id FROM time_unit WHERE time_unit.name = "Action"), 1),
((SELECT spell.id FROM spell WHERE spell.name = "Alarm"), (SELECT time_unit.id FROM time_unit WHERE time_unit.name = "Minute"), 1),
((SELECT spell.id FROM spell WHERE spell.name = "Alter Self"), (SELECT time_unit.id FROM time_unit WHERE time_unit.name = "Action"), 1),
((SELECT spell.id FROM spell WHERE spell.name = "Animal Friendship"), (SELECT time_unit.id FROM time_unit WHERE time_unit.name = "Action"), 1),
((SELECT spell.id FROM spell WHERE spell.name = "Animal Messenger"), (SELECT time_unit.id FROM time_unit WHERE time_unit.name = "Action"), 1),
((SELECT spell.id FROM spell WHERE spell.name = "Animal Shapes"), (SELECT time_unit.id FROM time_unit WHERE time_unit.name = "Action"), 1),
((SELECT spell.id FROM spell WHERE spell.name = "Animate Dead"), (SELECT time_unit.id FROM time_unit WHERE time_unit.name = "Minute"), 1);


-- Make certain the spell_school table is not polluted with old data.
SET FOREIGN_KEY_CHECKS = 0;
TRUNCATE spell_school;
SET FOREIGN_KEY_CHECKS = 1;
INSERT INTO spell_school (spell_id, school_id)
VALUES ((SELECT spell.id FROM spell WHERE spell.name = "Acid Splash"), (SELECT school.id FROM school WHERE school.name = "Conjuration")),
((SELECT spell.id FROM spell WHERE spell.name = "Aid"), (SELECT school.id FROM school WHERE school.name = "Abjuration")),
((SELECT spell.id FROM spell WHERE spell.name = "Alarm"), (SELECT school.id FROM school WHERE school.name = "Abjuration")),
((SELECT spell.id FROM spell WHERE spell.name = "Alter Self"), (SELECT school.id FROM school WHERE school.name = "Transmutation")),
((SELECT spell.id FROM spell WHERE spell.name = "Animal Friendship"), (SELECT school.id FROM school WHERE school.name = "Enchantment")),
((SELECT spell.id FROM spell WHERE spell.name = "Animal Messenger"), (SELECT school.id FROM school WHERE school.name = "Enchantment")),
((SELECT spell.id FROM spell WHERE spell.name = "Animal Shapes"), (SELECT school.id FROM school WHERE school.name = "Transmutation")),
((SELECT spell.id FROM spell WHERE spell.name = "Animate Dead"), (SELECT school.id FROM school WHERE school.name = "Necromancy"));


-- Make certain the duration_spell_time_unit table is not polluted with old data.
SET FOREIGN_KEY_CHECKS = 0;
TRUNCATE duration_spell_time_unit;
SET FOREIGN_KEY_CHECKS = 1;
INSERT INTO duration_spell_time_unit (spell_id, time_unit_id, quantity, note)
VALUES ((SELECT spell.id FROM spell WHERE spell.name = "Acid Splash"), (SELECT time_unit.id FROM time_unit WHERE time_unit.name = "Minute"), 0, NULL),
((SELECT spell.id FROM spell WHERE spell.name = "Aid"), (SELECT time_unit.id FROM time_unit WHERE time_unit.name = "Minute"), 8 * 60, NULL),
((SELECT spell.id FROM spell WHERE spell.name = "Alarm"), (SELECT time_unit.id FROM time_unit WHERE time_unit.name = "Minute"), 8 * 60, NULL),
((SELECT spell.id FROM spell WHERE spell.name = "Alter Self"), (SELECT time_unit.id FROM time_unit WHERE time_unit.name = "Minute"), 60, NULL),
((SELECT spell.id FROM spell WHERE spell.name = "Animal Friendship"), (SELECT time_unit.id FROM time_unit WHERE time_unit.name = "Minute"), 24 * 60, NULL),
((SELECT spell.id FROM spell WHERE spell.name = "Animal Messenger"), (SELECT time_unit.id FROM time_unit WHERE time_unit.name = "Minute"), 24 * 60, NULL),
((SELECT spell.id FROM spell WHERE spell.name = "Animal Shapes"), (SELECT time_unit.id FROM time_unit WHERE time_unit.name = "Minute"), 24 * 60, NULL),
((SELECT spell.id FROM spell WHERE spell.name = "Animate Dead"), (SELECT time_unit.id FROM time_unit WHERE time_unit.name = "Minute"), 0, NULL);


-- Make certain the spell_material table is not polluted with old data.
SET FOREIGN_KEY_CHECKS = 0;
TRUNCATE spell_material;
SET FOREIGN_KEY_CHECKS = 1;
INSERT INTO spell_material (spell_id, material_id, is_consumed)
VALUES ((SELECT spell.id FROM spell WHERE spell.name = "Aid"), (SELECT material.id FROM material WHERE material.name = "A tiny strip of white cloth"), FALSE),
((SELECT spell.id FROM spell WHERE spell.name = "Alarm"), (SELECT material.id FROM material WHERE material.name = "A tiny bell"), FALSE),
((SELECT spell.id FROM spell WHERE spell.name = "Alarm"), (SELECT material.id FROM material WHERE material.name = "A piece of fine silver wire"), FALSE),
((SELECT spell.id FROM spell WHERE spell.name = "Animal Friendship"), (SELECT material.id FROM material WHERE material.name = "A morsel of food"), FALSE),
((SELECT spell.id FROM spell WHERE spell.name = "Animal Messenger"), (SELECT material.id FROM material WHERE material.name = "A morsel of food"), FALSE),
((SELECT spell.id FROM spell WHERE spell.name = "Animate Dead"), (SELECT material.id FROM material WHERE material.name = "A drop of blood"), FALSE),
((SELECT spell.id FROM spell WHERE spell.name = "Animate Dead"), (SELECT material.id FROM material WHERE material.name = "A piece of flesh"), FALSE),
((SELECT spell.id FROM spell WHERE spell.name = "Animate Dead"), (SELECT material.id FROM material WHERE material.name = "A pinch of bone dust"), FALSE);


-- Make certain the spell_expansion table is not polluted with old data.
SET FOREIGN_KEY_CHECKS = 0;
TRUNCATE spell_expansion;
SET FOREIGN_KEY_CHECKS = 1;
INSERT INTO spell_expansion (spell_id, expansion_id)
VALUES ((SELECT spell.id FROM spell WHERE spell.name = "Acid Splash"), (SELECT expansion.id FROM expansion WHERE expansion.name = "Player's Handbook")),
((SELECT spell.id FROM spell WHERE spell.name = "Aid"), (SELECT expansion.id FROM expansion WHERE expansion.name = "Player's Handbook")),
((SELECT spell.id FROM spell WHERE spell.name = "Alarm"), (SELECT expansion.id FROM expansion WHERE expansion.name = "Player's Handbook")),
((SELECT spell.id FROM spell WHERE spell.name = "Alter Self"), (SELECT expansion.id FROM expansion WHERE expansion.name = "Player's Handbook")),
((SELECT spell.id FROM spell WHERE spell.name = "Animal Friendship"), (SELECT expansion.id FROM expansion WHERE expansion.name = "Player's Handbook")),
((SELECT spell.id FROM spell WHERE spell.name = "Animal Messenger"), (SELECT expansion.id FROM expansion WHERE expansion.name = "Player's Handbook")),
((SELECT spell.id FROM spell WHERE spell.name = "Animal Shapes"), (SELECT expansion.id FROM expansion WHERE expansion.name = "Player's Handbook")),
((SELECT spell.id FROM spell WHERE spell.name = "Animate Dead"), (SELECT expansion.id FROM expansion WHERE expansion.name = "Player's Handbook"));
