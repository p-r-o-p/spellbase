<?php

require_once __DIR__ . "/MaterialSimple.php";
require_once __DIR__ . "/SpellSimple.php";

/**
 * Handler class for the spell database.
 */
class DBHandler {

  public function __construct() {

  }

  /**
   * Generates the spell database.
   */
  public static function generate() {
    echo "Creating database.\n";
    exec("mysql -u root < " . __DIR__ . "/Database/create_db.sql");

    echo "Parsing spell list.\n";

    $spellsObject = DBHandler::getSpellInfo();

    $spells = [];
    $materials = [];
    $castingSpellTimeUnit = [];
    $durationSpellTimeUnit = [];

    foreach ($spellsObject as $spell) {
      if ($spell->name == "Animal Friendship") {
        $spells[$spell->name] = new SpellSimple($spell);

        if (isset($spell->components->materials_needed)) {
          $materialsRaw = explode(",", $spell->components->materials_needed[0]);

          foreach ($materialsRaw as $material) {
            $materialObj = new MaterialSimple($material);

            if (!array_key_exists($materialObj->getName(), $materials)) {
              $materials[$materialObj->getName()] = $materialObj;
            }
          }
        }
        //var_dump($spell);
        //var_dump($spells);
      }
    }
  }

  /**
   * Retrives the spell info object.
   *
   * @return \stdObject
   *  An object containing all the spells.
   */
  private function getSpellInfo() {
    $spellFilePath = __DIR__ . "/spells.json";
    $spellFile = fopen($spellFilePath, 'r');
    $spellsObject = json_decode(fread($spellFile, filesize($spellFilePath)));
    fclose($spellFile);

    if (is_null($spellsObject)) {
      die(json_last_error_msg());
    }

    return $spellsObject;
  }
}
