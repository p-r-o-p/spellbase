use dnd_db;

-- Make certain the spell table is not polluted with old data.
SET FOREIGN_KEY_CHECKS = 0;
TRUNCATE spell;
SET FOREIGN_KEY_CHECKS = 1;
INSERT INTO spell (name, level, is_ritual, reach, is_touch, is_self, is_concentration, is_verbal, is_somatic, description)
VALUES ("Acid Splash", 0, FALSE, 60, FALSE, FALSE, FALSE, TRUE, TRUE, "You hurl a bubble of acid. Chose one creature within range, or choose two creatures within range that are within 5 feet of each other. A target must succed on a Dexterity saving throw or take 1d6 acid damage.\n\nThis spell's damage increases by 1d6 when you reach 5th level (2d6), 11th level (3d6) and 17th level (4d6)."),
("Aid", 2, FALSE, 30, FALSE, FALSE, FALSE, TRUE, TRUE, "Your spell bolsters your allies with toughness and resolve. Choose up to three creatures within range. Each target's hit point maximum and current hit points increase by 5 for the duration.\n\nWhen you cast this spell using a spell slot of 3rd or higher, a target's hit points increase by an additional 5 for each slot level above 2nd."),
("Alarm", 1, TRUE, 30, FALSE, FALSE, FALSE, TRUE, TRUE, "You set an alarm against unwanted intrusion. Choose a door, a window, or an area within range that is no larger than a 20-foot cube. Until the spell ends, an alarm alerts you whenever a Tiny or larger creature touches or enters the warded area. When you cast the spell, you can designate creatures that won't set off the alarm. You also choose whether the alarm is mental or audible.\n\nA mental alarm alerts you with a ping in your mind if you are within 1 mile of the warded area. This ping awakens you, if you are sleeping.\n\nAn audible alarm produces the sound of a hand bell for 10 seconds within 60 feet."),
("Alter Self", 2, FALSE, 0, FALSE, TRUE, TRUE, TRUE, TRUE, "You assume a different form. When you cast this spell, choose one of the following options, the effect of which last for the duration of the spell. While the spell lasts,you can end one option as an action to gain the benefits of a different one.\n\nAcquatic Adaption. You adapt your body to an aquatic environment, sprouting gills and growing webbing between your fingers. You can breathe underwater and gain swimming speed equal to your walking speed.\n\nChange Appearance. You transform your appearance. You decide what you look like, including your height, weight, facial features, sound of your voice, hair length, coloration, and distinguishing characteristics, if any. You can make yourself appear as any race, though non of your statistics change. You also can't appear as a creature of a different size than you, and your basic shape stays the same; if you're bipedal, you can't use this spell to become quadrupedal, for instance. At any time for the duration of the spell, you can use your action to change your appearance in this way again.\n\nNatural Weapons. You grow claws, fangs, spines, horns, or a different natural weapon of your choice. Your unarmed strikes deal 1d6 bludgeoning, piercing, or slashing damage, as appropiate to the natural weapon you chose, and you are proficient with your unarmed strikes. Finally the weapon is magic and you have a +1 bonus to the attack and damage rolls you make using it."),
("Animal Friendship", 1, FALSE, 30, FALSE, FALSE, FALSE, TRUE, TRUE, "This spell lets your convince a beast that you mean it no harm. Choose a beast that you can see within range. It must see and hear you. If the beast's Intelligence is 4 or higher, the spell fails. Otherwise, the beast must succed on a Wisdom saving throw or be charmed by you for the spell's duration. If you or one of your companions harms the target, the spell ends.\n\nWhen you cast this spell using a spell slot of 2nd level or higher, you can affect one additional beast for each slot level above 1st.");


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


-- Make certain the shape table is not polluted with old data.
SET FOREIGN_KEY_CHECKS = 0;
TRUNCATE shape;
SET FOREIGN_KEY_CHECKS = 1;
INSERT INTO shape (name, description)
VALUES ("Cone", "A cone extends in a direction you choose from its point of origin. A cone's width at a given point is equal to that point's distance from the point of origin.\n\nA cone's point of origin is not included in the cones area of effect, unless you decide otherwise."),
("Cube", "You select a cube's point of origin, which lies anywhere on a face of the cubic effect. The cube's size is expressed as the length of each side.\n\nA cube's point of origin is not included in the cube's area effect, unless you decide otherwise."),
("Cylinder", "A cylinder's point of origin is the center of a circle of a particular radius, as given in the spells description. The circle must be either on the ground, or at the height of the spell effect. The energy in a cylinder expands in straight lines from the point of origin to the perimeter of the circle, forming the base of the cylinder. The spell's effect then shoots up from the base or down from the top, to a distance equal to the height of the cylinder.\n\nA cylinder's point of origin is included in the cylinder's area of effect."),
("Line", "A line extends from it's point of origin in a straight path up to its length and covers an area definde by its width.\n\nA line's point of origin is not included in the line's area of effect, unless you decide otherwise."),
("Sphere", "You select a sphere's point of origin, and the sphere extends outward from that point. The sphere's size is expressed as a radius in feet that extends from the point.\n\nA sphere's point of origin is included in the sphere's area of effect.");


-- Make certain the material table is not polluted with old data.
SET FOREIGN_KEY_CHECKS = 0;
TRUNCATE material;
SET FOREIGN_KEY_CHECKS = 1;
INSERT INTO material (name)
VALUES ("A tiny strip of white cloth"),
("A tiny bell"),
("A piece of fine silver wire"),
("A morsel of food");


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
((SELECT spell.id FROM spell WHERe spell.name = "Animal Friendship"), (SELECT time_unit.id FROM time_unit WHERE time_unit.name = "Action"), 1);


-- Make certain the spell_school table is not polluted with old data.
SET FOREIGN_KEY_CHECKS = 0;
TRUNCATE spell_school;
SET FOREIGN_KEY_CHECKS = 1;
INSERT INTO spell_school (spell_id, school_id)
VALUES ((SELECT spell.id FROM spell WHERE spell.name = "Acid Splash"), (SELECT school.id FROM school WHERE school.name = "Conjuration")),
((SELECT spell.id FROM spell WHERE spell.name = "Aid"), (SELECT school.id FROM school WHERE school.name = "Abjuration")),
((SELECT spell.id FROM spell WHERE spell.name = "Alarm"), (SELECT school.id FROM school WHERE school.name = "Abjuration")),
((SELECT spell.id FROM spell WHERE spell.name = "Alter Self"), (SELECT school.id FROM school WHERE school.name = "Transmutation")),
((SELECT spell.id FROM spell WHERE spell.name = "Animal Friendship"), (SELECT school.id FROM school WHERE school.name = "Enchantment"));

-- Make certain the duration_spell_time_unit table is not polluted with old data.
SET FOREIGN_KEY_CHECKS = 0;
TRUNCATE duration_spell_time_unit;
SET FOREIGN_KEY_CHECKS = 1;
INSERT INTO duration_spell_time_unit (spell_id, time_unit_id, quantity, note)
VALUES ((SELECT spell.id FROM spell WHERE spell.name = "Acid Splash"), (SELECT time_unit.id FROM time_unit WHERE time_unit.name = "Minute"), 0, NULL),
((SELECT spell.id FROM spell WHERE spell.name = "Aid"), (SELECT time_unit.id FROM time_unit WHERE time_unit.name = "Minute"), 8 * 60, NULL),
((SELECT spell.id FROM spell WHERE spell.name = "Alarm"), (SELECT time_unit.id FROM time_unit WHERE time_unit.name = "Minute"), 8 * 60, NULL),
((SELECT spell.id FROM spell WHERE spell.name = "Alter Self"), (SELECT time_unit.id FROM time_unit WHERE time_unit.name = "Minute"), 60, NULL),
((SELECT spell.id FROM spell WHERE spell.name = "Animal Friendship"), (SELECT time_unit.id FROM time_unit WHERE time_unit.name = "Minute"), 24 * 60, NULL);

-- Make certain the spell_shape table is not polluted with old data.
SET FOREIGN_KEY_CHECKS = 0;
TRUNCATE spell_shape;
SET FOREIGN_KEY_CHECKS = 1;


-- Make certain the spell_material table is not polluted with old data.
SET FOREIGN_KEY_CHECKS = 0;
TRUNCATE spell_material;
SET FOREIGN_KEY_CHECKS = 1;
INSERT INTO spell_material (spell_id, material_id, is_consumed)
VALUES ((SELECT spell.id FROM spell WHERE spell.name = "Aid"), (SELECT material.id FROM material WHERE material.name = "A tiny strip of white cloth"), FALSE),
((SELECT spell.id FROM spell WHERE spell.name = "Alarm"), (SELECT material.id FROM material WHERE material.name = "A tiny bell"), FALSE),
((SELECT spell.id FROM spell WHERE spell.name = "Alarm"), (SELECT material.id FROM material WHERE material.name = "A piece of fine silver wire"), FALSE),
((SELECT spell.id FROM spell WHERE spell.name = "Animal Friendship"), (SELECT material.id FROM material WHERE material.name = "A morsel of food"), FALSE);


-- Make certain the spell_expansion table is not polluted with old data.
SET FOREIGN_KEY_CHECKS = 0;
TRUNCATE spell_expansion;
SET FOREIGN_KEY_CHECKS = 1;
INSERT INTO spell_expansion (spell_id, expansion_id)
VALUES ((SELECT spell.id FROM spell WHERE spell.name = "Acid Splash"), (SELECT expansion.id FROM expansion WHERE expansion.name = "Player's Handbook")),
((SELECT spell.id FROM spell WHERE spell.name = "Aid"), (SELECT expansion.id FROM expansion WHERE expansion.name = "Player's Handbook")),
((SELECT spell.id FROM spell WHERE spell.name = "Alarm"), (SELECT expansion.id FROM expansion WHERE expansion.name = "Player's Handbook"))
((SELECT spell.id FROM spell WHERE spell.name = "Alter Self"), (SELECT expansion.id FROM expansion WHERE expansion.name = "Player's Handbook")),
((SELECT spell.id FROM spell WHERE spell.name = "Animal"), (SELECT expansion.id FROM expanion WHERE expansion.name = "Player's Handbook"));
