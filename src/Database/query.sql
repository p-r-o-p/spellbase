USE dnd_db;

SELECT  spell.name AS "Name",
        spell.level AS "Level",
        (SELECT school.name FROM school WHERE school.id = spell_school.school_id) AS "School",
        casting_spell_time_unit.quantity AS "Casting time",
        (SELECT time_unit.name FROM time_unit WHERE time_unit.id = casting_spell_time_unit.time_unit_id) AS "Casting time unit",
        duration_spell_time_unit.quantity AS "Duration time",
        (SELECT time_unit.name FROM time_unit WHERE time_unit.id = duration_spell_time_unit.time_unit_id) AS "Duration time unit",
        spell.reach AS "Range",
        spell.is_touch AS "Touch",
        spell.is_self AS "Self",
        spell.is_verbal AS "Verbal",
        spell.is_somatic AS "Somatic",
        duration_spell_time_unit.quantity AS "Duration",
        (SELECT time_unit.name FROM time_unit WHERE time_unit.id = duration_spell_time_unit.time_unit_id) AS "Duration unit",
        spell.description AS "Description"
FROM spell
  LEFT JOIN spell_school
    ON spell.id = spell_school.spell_id
  LEFT JOIN casting_spell_time_unit
    ON spell.id = casting_spell_time_unit.spell_id
  LEFT JOIN duration_spell_time_unit
    ON spell.id = duration_spell_time_unit.spell_id
  LEFT JOIN spell_expansion
    ON spell.id = spell_expansion.spell_id
WHERE spell.id = 4 OR spell.id = 5
ORDER BY Name ASC
\G
