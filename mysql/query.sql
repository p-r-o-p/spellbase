USE dnd_db;

SELECT  spell.name AS "Name",
        spell.level AS "Level",
        casting_spell_time_unit.quantity AS "Casting time",
        (SELECT time_unit.name FROM time_unit WHERE time_unit.id = casting_spell_time_unit.time_unit_id) AS "Casting time unit",
        spell.reach AS "Range",
        (SELECT shape.name FROM shape WHERE shape.id = spell_shape.shape_id) AS "Shape type",
        spell_shape.size AS "Shape size",
        spell.is_touch AS "Touch",
        spell.is_self AS "Self",
        spell.is_verbal AS "Verbal",
        spell.is_somatic AS "Somatic",
        (SELECT GROUP_CONCAT(material.name SEPARATOR ", ")
          FROM material, spell_material
          WHERE material.id = spell_material.material_id
            AND spell.id = spell_material.spell_id)
          AS "Material",
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
  LEFT JOIN time_unit
    ON casting_spell_time_unit.time_unit_id = time_unit.id
  LEFT JOIN spell_shape
    ON spell.id = spell_shape.spell_id
  LEFT JOIN shape
    ON spell_shape.shape_id = shape.id
  LEFT JOIN spell_expansion
    ON spell.id = spell_expansion.spell_id
  LEFT JOIN expansion
    ON spell_expansion.expansion_id = expansion.id
WHERE spell.name = "Animal Friendship"
ORDER BY Name ASC
\G
