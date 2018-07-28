use dnd_db;

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


-- Populate the time_unit table.
INSERT INTO time_unit (name)
VALUES ("Action"),
("Reaction"),
("Bonus action"),
("Minute");


-- Populate the class table.
INSERT INTO class (name)
VALUES ("Bard"),
("Cleric"),
("Druid"),
("Paladin"),
("Ranger"),
("Sorcerer"),
("Warlock"),
("Wizard");



-- Populate the expansion table
INSERT INTO expansion (name)
VALUES ("Player's Handbook");
