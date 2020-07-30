<?php

require_once 'vendor/autoload.php';

use Medoo\Medoo;

$db = new Medoo([
    'database_type' => 'mysql',
    'database_name' => getenv('MYSQL_DATABASE'),
    'server' => getenv('MYSQL_HOST'),
    'username' => getenv('MYSQL_USER'),
    'password' => getenv('MYSQL_PASSWORD'),
]);

printf("Creating tables.\n");

$status = $db->create("spell", [
    "id" => ["INTEGER(32)", "UNSIGNED", "NOT NULL", "AUTO_INCREMENT"],
    "name" => ["VARCHAR(60)", "NOT NULL", "UNIQUE"],
    "level" => ["INTEGER(32)", "UNSIGNED", "NOT NULL"],
    "is_ritual" => ["BOOLEAN", "NOT NULL"],
    "reach" => ["INTEGER(32)", "UNSIGNED", "NOT NULL"],
    "is_touch" => ["BOOLEAN", "NOT NULL"],
    "is_self" => ["BOOLEAN", "NOT NULL"],
    "is_concentration" => ["BOOLEAN", "NOT NULL"],
    "is_verbal" => ["BOOLEAN", "NOT NULL"],
    "is_somatic" => ["BOOLEAN", "NOT NULL"],
    "materials" => ["TEXT"],
    "description" => ["TEXT", "NOT NULL"],
    "PRIMARY KEY (id)",
]);

$db->create("school", [
    "id" => ["INTEGER(32)", "UNSIGNED", "NOT NULL", "AUTO_INCREMENT",],
    "name" => ["VARCHAR(30)", "NOT NULL"],
    "description" => ["TEXT", "NOT NULL"],
    "PRIMARY KEY (id)",
]);

$db->create("time_unit", [
    "id" => ["INTEGER(32)", "UNSIGNED", "NOT NULL", "AUTO_INCREMENT"],
    "name" => ["VARCHAR(60)", "NOT NULL"],
    "PRIMARY KEY (id)",
]);

$db->create("class", [
    "id" => ["INTEGER(32)", "UNSIGNED", "NOT NULL", "AUTO_INCREMENT"],
    "name" => ["VARCHAR(30)", "NOT NULL"],
    "PRIMARY KEY (id)",
]);

$db->create("expansion", [
    "id" => ["INTEGER(32)", "UNSIGNED", "NOT NULL", "AUTO_INCREMENT"],
    "name" => ["VARCHAR(60)", "NOT NULL"],
    "PRIMARY KEY (id)",
]);

$db->create("class_spell", [
    "id" => ["INTEGER(32)", "UNSIGNED", "NOT NULL", "AUTO_INCREMENT"],
    "class_id" => ["INTEGER(32)", "UNSIGNED", "NOT NULL"],
    "spell_id" => ["INTEGER(32)", "UNSIGNED", "NOT NULL"],
    "PRIMARY KEY (id)",
    "FOREIGN KEY (class_id) REFERENCES class(id)",
    "FOREIGN KEY (spell_id) REFERENCES spell(id)",
]);

$db->create("casting_spell_time_unit", [
    "id" => ["INTEGER(32)", "UNSIGNED", "NOT NULL", "AUTO_INCREMENT"],
    "spell_id" => ["INTEGER(32)", "UNSIGNED", "NOT NULL"],
    "time_unit_id" => ["INTEGER(32)", "UNSIGNED", "NOT NULL"],
    "quantity" => ["INTEGER(32)", "UNSIGNED", "NOT NULL"],
    "PRIMARY KEY (id)",
    "FOREIGN KEY (spell_id) REFERENCES spell(id)",
    "FOREIGN KEY (time_unit_id) REFERENCES time_unit(id)",
]);

$db->create("duration_spell_time_unit", [
    "id" => ["INTEGER(32)", "UNSIGNED", "NOT NULL", "AUTO_INCREMENT"],
    "spell_id" => ["INTEGER(32)", "UNSIGNED", "NOT NULL"],
    "time_unit_id" => ["INTEGER(32)", "UNSIGNED", "NOT NULL"],
    "quantity" => ["INTEGER(32)", "UNSIGNED"],
    "note" => ["VARCHAR(60)"],
    "PRIMARY KEY (id)",
    "FOREIGN KEY (spell_id) REFERENCES spell(id)",
    "FOREIGN KEY (time_unit_id) REFERENCES time_unit(id)",
]);

$db->create("spell_school", [
    "id" => ["INTEGER(32)", "UNSIGNED", "NOT NULL", "AUTO_INCREMENT"],
    "spell_id" => ["INTEGER(32)", "UNSIGNED", "NOT NULL"],
    "school_id" => ["INTEGER(32)", "UNSIGNED", "NOT NULL"],
    "PRIMARY KEY (id)",
    "FOREIGN KEY (spell_id) REFERENCES spell(id)",
    "FOREIGN KEY (school_id) REFERENCES school(id)",
]);

$db->create("spell_expansion", [
    "id" => ["INTEGER(32)", "UNSIGNED", "NOT NULL", "AUTO_INCREMENT"],
    "spell_id" => ["INTEGER(32)", "UNSIGNED", "NOT NULL"],
    "expansion_id" => ["INTEGER(32)", "UNSIGNED", "NOT NULL"],
    "PRIMARY KEY (id)",
    "FOREIGN KEY (spell_id) REFERENCES spell(id)",
    "FOREIGN KEY (expansion_id) REFERENCES expansion(id)"
]);

printf("Tables created.\n");
printf("Populating tables.\n");

$spells = parseCsvFile("src/spells.csv", true);

/*array(11) {
  ["Name"]=>
  string(27) "Abi-Dalzim's Horrid Wilting"
  ["Source"]=>
  string(3) "XGE"
  ["Level"]=>
  string(3) "8th"
  ["Casting Time"]=>
  string(6) "Action"
  ["Duration"]=>
  string(13) "Instantaneous"
  ["School"]=>
  string(10) "Necromancy"
  ["Range"]=>
  string(8) "150 feet"
  ["Components"]=>
  string(25) "V, S, M (a bit of sponge)"
  ["Classes"]=>
  string(16) "Sorcerer, Wizard"
  ["Text"]=>
  string(487) "You draw the moisture from every creature in a 30-foot cube centered on a point you choose within range. Each creature in that area must make a Constitution saving throw. Constructs and undead ar
en't affected, and plants and water elementals make this saving throw with disadvantage. A creature takes 12d8 necrotic damage on a failed save, or half as much damage on a successful one.Nonmagical plants in t
he area that aren't creatures, such as trees and shrubs, wither and die instantly."
  ["At Higher Levels"]=>
  string(0) ""
}*/
foreach ($spells as $spell) {
    var_dump($spell);
    /*$db->insert('spell', [

    ]);*/
}

/**
 * Transforms a component string into an array.
 *
 * @param string $components
 *   The component string.
 * @return array
 *   The components as an array.
 */
function splitComponents(string $components): array
{
    $components = explode("M (", $components);
    $componentArray = [];

    if (substr($components[0], 0, 1) == "V" || substr($components[0], 0, 1) == "S") {
        $flags = explode(", ", $components[0]);
        $componentArray['is_verbal'] = in_array('V', $flags);
        $componentArray['is_somatic'] = in_array('S', $flags);
    }

    if (!empty($components[1])) {
        if (substr($components[1], -1, 1) == ")") {
            $componentArray['materials'] = ucfirst(substr($components[1], 0, strlen($components[1]) - 1));
        }
    }

    return $componentArray;
}

/**
 * Maps a level string to an integer.
 *
 * @param string $level
 *   The level string.
 * @return int
 *   The level as an integer.
 */
function mapSpellLevel(string $level): int
{
    switch ($level) {
        case "Cantrip":
            return 0;
        case "1st":
            return 1;
        case "2nd":
            return 2;
        case "3rd":
            return 3;
        case "4th":
            return 4;
        case "5th":
            return 5;
        case "6th":
            return 6;
        case "7th":
            return 7;
        case "8th":
            return 8;
        case "9th":
            return 9;
    }
    return -1;
}

/**
 * Parses a CSV file and converts its content into an array.
 *
 * @param string $file
 *   The path to the CSV file.
 * @param bool $useHeader
 *   If the first line of the file used for column headers.
 * @return array
 *   The CSV data in array form.
 */
function parseCsvFile(string $file, bool $useHeader = false): array
{
    $csv = array_map('str_getcsv', file($file, FILE_SKIP_EMPTY_LINES));
    if (!$useHeader) {
        return $csv;
    }
    $keys = array_shift($csv);

    foreach ($csv as $key => $value) {
        $csv[$key] = array_combine($keys, $value);
    }
    return $csv;
}
