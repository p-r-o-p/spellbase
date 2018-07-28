<?php

require_once __DIR__ . "/CastingSpellTimeUnit.php";
require_once __DIR__ . "/ClassSpell.php";
require_once __DIR__ . "/DurationSpellTimeUnit.php";
require_once __DIR__ . "/MaterialSimple.php";
require_once __DIR__ . "/SpellExpansion.php";
require_once __DIR__ . "/SpellMaterial.php";
require_once __DIR__ . "/SpellSchool.php";
require_once __DIR__ . "/SpellSimple.php";

/**
 * Handler class for the spell database.
 */
class DBHandler {

  /**
   * Executes a MySQL query and returns the result.
   *
   * @return mixed
   *  The result of the query.
   *
   * @throws \Exception
   *  If the query fails.
   */
  private function executeQuery(string $queryString) {
    $dbInfoPath = __DIR__ . "/../dbInfo.json";
    $dbInfoFile = fopen($dbInfoPath, "r");
    $dbInfo = json_decode(fread($dbInfoFile, filesize($dbInfoPath)));
    fclose($dbInfoFile);
    $user = $dbInfo->user;
    $password = $dbInfo->password;
    $database = $dbInfo->database;

    $db = new mysqli("localhost", $user, $password, $database);

    if ($db->connect_errno) {
      throw new \Exception($db->connect_error);
    }

    $db->autocommit(FALSE);
    $db->begin_transaction();
    $result = $db->query($queryString);

    if ($db->commit() !== TRUE) {
      throw new \Exception($db->error);
    }

    if ($db->errno) {
      throw new \Exception($db->error);
    }

    return $result;
  }

  /**
   * Generates the spell database.
   */
  public static function generate() {
    echo "Creating database.\n";
    exec("mysql -u root < " . __DIR__ . "/Database/create_db.sql");

    echo "Populating database with primitives.\n";
    exec("mysql -u root < " . __DIR__ . "/Database/populate_primitives.sql");

    try {
      echo "Parsing spell list.\n";
      $spellList = DBHandler::getSpellInfo();
      $spellElements = DBHandler::parseSpellList($spellList);
    }
    catch (Exception $e) {
      die($e->getMessage() . "\n");
    }

    try {
      echo "Populating the spell table.\n";
      DBHandler::populateSpellTable($spellElements["spells"]);
    }
    catch (Exception $e) {
      die($e->getMessage() . "\n");
    }

    try {
      echo "Populating the casting_spell_time_unit table.\n";
      DBHandler::populateCastingSpellTimeUnitTable($spellElements["castingSpellTimeUnits"]);
    }
    catch (Exception $e) {
      die($e->getMessage() . "\n");
    }

    try {
      echo "Populating the duration_spell_time_unit table.\n";
      DBHandler::populateDurationSpellTimeUnitTable($spellElements["durationSpellTimeUnits"]);
    }
    catch (Exception $e) {
      die($e->getMessage() . "\n");
    }

    try {
      echo "Populating the class_spell table.\n";
      DBHandler::populateClassSpellTable($spellElements["classSpells"]);
    }
    catch (Exception $e) {
      die($e->getMessage() . "\n");
    }

    try {
      echo "Populating the spell_school table.\n";
      DBHandler::populateSpellSchoolTable($spellElements["spellSchools"]);
    }
    catch (Exception $e) {
      die($e->getMessage() . "\n");
    }

    try {
      echo "Populating the spell_expansion table.\n";
      DBHandler::populateSpellExpansionTable($spellElements["spellExpansion"]);
    }
    catch (Exception $e) {
      die($e->getMessage() . "\n");
    }

    echo "Database populated.\n";
  }

  /**
   * Retrives the spell info object.
   *
   * @return \stdObject
   *  An object containing all the spells.
   *
   * @throws \Exception
   *  If unable to retrieve spell info.
   */
  private function getSpellInfo() {
    $filePath = __DIR__ . "/spells.json";

    if (!file_exists($filePath)) {
      throw new \Exception("$filePath doesn't exist.");
    }

    $file = fopen($filePath, 'r');

    if ($file === FALSE) {
      throw new \Exception("Unable to open $filePath.");
    }

    $fileContent = fread($file, filesize($filePath));

    if ($fileContent === FALSE) {
      throw new \Exception("Unable to read $filePath");
    }

    $spellsObject = json_decode($fileContent);
    fclose($file);

    if (is_null($spellsObject)) {
      throw new \Exception(json_last_error_msg());
    }

    return $spellsObject;
  }

  /**
   * Parses a list of spells, given as a json object.
   *
   * @return array
   *  The the collection of spell components.
   */
  private function parseSpellList(array $spellList) {
    $spells = [];
    //$materials = [];
    $castingSpellTimeUnits = [];
    $durationSpellTimeUnits = [];
    $classSpells = [];
    $spellExpansions = [];
    //$spellMaterial = [];
    $spellSchools = [];

    foreach ($spellList as $spell) {
      $spells[] = new SpellSimple($spell);

      /*if (isset($spell->components->materials_needed)) {
        $materialsRaw = explode(",", $spell->components->materials_needed[0]);

        foreach ($materialsRaw as $material) {
          $materialObj = new MaterialSimple($material);

          if (!array_key_exists($materialObj->getName(), $materials)) {
            $materials[$materialObj->getName()] = $materialObj;
          }
        }
      }*/

      $castingSpellTimeUnits[] = new CastingSpellTimeUnit($spell);
      $durationSpellTimeUnits[] = new DurationSpellTimeUnit($spell);
      $spellSchools[] = new SpellSchool($spell);
      $spellExpansions[] = new SpellExpansion($spell->name);

      foreach ($spell->classes as $class) {
        $classSpells[] = new ClassSpell($class, $spell->name);
      }
    }
    return [
      "spells" => $spells,
      //"materials" => $materials,
      "castingSpellTimeUnits" => $castingSpellTimeUnits,
      "durationSpellTimeUnits" => $durationSpellTimeUnits,
      "classSpells" => $classSpells,
      "spellSchools" => $spellSchools,
      //"spellMaterial" => $spellMaterial,
      "spellExpansion" => $spellExpansions,
    ];
  }

  /**
   * Populates the casting_spell_time_unit table.
   *
   * Requires spell table and time_unit table to be populated.
   *
   * @throws \Exception
   *  If the inserts fail.
   */
  private function populateCastingSpellTimeUnitTable(array $castingSpellTimeUnits) {
    $queryBase = <<<QB
INSERT INTO casting_spell_time_unit (spell_id, time_unit_id, quantity)
VALUES %s;
QB;
    $queryPartials = [];
    $queryPartial = <<<QP
((SELECT spell.id FROM spell WHERE spell.name = "%s"), (SELECT time_unit.id FROM time_unit WHERE time_unit.name = "%s"), %d)
QP;

    foreach ($castingSpellTimeUnits as $castingSpellTimeUnit) {
      $queryPartials[] = sprintf(
        $queryPartial,
        addslashes($castingSpellTimeUnit->getSpellName()),
        addslashes($castingSpellTimeUnit->getTimeUnitName()),
        $castingSpellTimeUnit->getQuantity()
      );
    }

    $queryString = sprintf($queryBase, implode(", ", $queryPartials));

    try {
      DBHandler::executeQuery($queryString);
    }
    catch (Exception $e) {
      throw new \Exception(sprintf("%s: %s", __FUNCTION__, $e->getMessage()));
    }
  }

  /**
   * Populates the class_spell table.
   *
   * Requires the class and the spell table to be populated.
   *
   * @throws \Exception
   *  If the inserts fail.
   */
  private function populateClassSpellTable(array $classSpells) {
    $queryBase = <<<QB
INSERT INTO class_spell (class_id, spell_id)
VALUES %s;
QB;
    $queryPartials = [];
    $queryPartial = <<<QP
((SELECT spell.id FROM spell WHERE spell.name = "%s"), (SELECT class.id FROM class WHERE class.name = "%s"))
QP;

    foreach ($classSpells as $classSpell) {
      $queryPartials[] = sprintf(
        $queryPartial,
        addslashes($classSpell->getSpellName()),
        addslashes($classSpell->getClassName())
      );
    }

    $queryString = sprintf($queryBase, implode(", ", $queryPartials));
//foreach ($queryPartials as $tmp) {
    try {
      DBHandler::executeQuery($queryString);
      //DBHandler::executeQuery(sprintf($queryBase, $tmp));
    }
    catch (Exception $e) {
      //var_dump($tmp);
      throw new \Exception(sprintf("%s: %s", __FUNCTION__, $e->getMessage()));
    }
//}
  }

  /**
   * Populates the duration_spell_time_unit table.
   *
   * Requires the spell and time_unit table to be populated.
   *
   * @return \Exception
   *  If the insert fails.
   */
  private function populateDurationSpellTimeUnitTable(array $durationSpellTimeUnits) {
    $queryBase = <<<QB
INSERT INTO duration_spell_time_unit (spell_id, time_unit_id, quantity, note)
VALUES %s;
QB;
    $queryPartials = [];
    $queryPartial = <<<QP
((SELECT spell.id FROM spell WHERE spell.name = "%s"), (SELECT time_unit.id FROM time_unit WHERE time_unit.name = "%s"), %d, "%s")
QP;

    foreach ($durationSpellTimeUnits as $durationSpellTimeUnit) {
      $queryPartials[] = sprintf(
        $queryPartial,
        addslashes($durationSpellTimeUnit->getSpellName()),
        addslashes($durationSpellTimeUnit->getTimeUnitName()),
        $durationSpellTimeUnit->getQuantity(),
        is_null($durationSpellTimeUnit->getNote()) ? "NULL" : addslashes($durationSpellTimeUnit->getNote())
      );
    }

    $queryString = sprintf($queryBase, implode(", ", $queryPartials));

    try {
      DBHandler::executeQuery($queryString);
    }
    catch (Exception $e) {
      throw new \Exception(sprintf("%s: %s", __FUNCTION__, $e->getMessage()));
    }
  }

  /**
   * Populates the spell table.
   *
   * @throws \Exception
   *  If the insert fails.
   */
  private function populateSpellTable(array $spells) {
    $queryBase = <<<QB
INSERT INTO spell (name, level, is_ritual, reach, is_touch, is_self, is_concentration, is_verbal, is_somatic, materials, description)
VALUES %s;
QB;
    $queryPartials = [];

    foreach ($spells as $spell) {
      $spellArr = [
        sprintf("\"%s\"", addslashes($spell->getName())),
        $spell->getLevel(),
        $spell->getIsRitual() ? "TRUE" : "FALSE",
        $spell->getReach(),
        $spell->getIsTouch() ? "TRUE" : "FALSE",
        $spell->getIsSelf() ? "TRUE" : "FALSE",
        $spell->getIsConcentration() ? "TRUE" : "FALSE",
        $spell->getIsVerbal() ? "TRUE" : "FALSE",
        $spell->getIsSomatic() ? "TRUE" : "FALSE",
        is_null($spell->getMaterials()) ? "NULL" : $spell->getMaterials(),
        sprintf('"%s"', addslashes($spell->getDescription())),
      ];
      $queryPartials[] = sprintf("(%s)", implode(", ", $spellArr));
    }

    $queryString = sprintf($queryBase, implode(", \n", $queryPartials));

    try {
      DBHandler::executeQuery($queryString);
    }
    catch (Exception $e) {
      throw new \Exception(sprintf("%s: %s", __FUNCTION__, $e->getMessage()));
    }
  }

  /**
   * Populates the spell_expansion table.
   *
   * Requires the spell and expansion table to be populated.
   *
   * @throws \Exception
   *  If the insert fails.
   */
  private function populateSpellExpansionTable(array $spellExpansions) {
    $queryBase = <<<QB
INSERT INTO spell_expansion (spell_id, expansion_id)
VALUES %s;
QB;
    $queryPartials = [];
    $queryPartial = <<<QP
((SELECT spell.id FROM spell WHERE spell.name = "%s"), (SELECT expansion.id FROM expansion WHERE expansion.name = "%s"))
QP;

    foreach ($spellExpansions as $spellExpansion) {
      $queryPartials[] = sprintf(
        $queryPartial,
        addslashes($spellExpansion->getSpellName()),
        addslashes($spellExpansion->getExpansionName())
      );
    }

    $queryString = sprintf($queryBase, implode(", ", $queryPartials));

    try {
      DBHandler::executeQuery($queryString);
    }
    catch (Exception $e) {
      throw new \Exception(sprintf("%s: %s", __FUNCTION__, $e->getMessage()));
    }
  }

  /**
   * Populates the spell_school table.
   *
   * Requires the spell and school table to be populated.
   *
   * @throws \Exception
   *  If the insert fails.
   */
  private function populateSpellSchoolTable(array $spellSchools) {
    $queryBase = <<<QB
INSERT INTO spell_school (spell_id, school_id)
VALUES %s;
QB;
    $queryPartials = [];
    $queryPartial = <<<QP
((SELECT spell.id FROM spell WHERE spell.name = "%s"), (SELECT school.id FROM school WHERE school.name = "%s"))
QP;

    foreach ($spellSchools as $spellSchool) {
      $queryPartials[] = sprintf(
        $queryPartial,
        addslashes($spellSchool->getSpellName()),
        addslashes($spellSchool->getSchoolName())
      );
    }

    $queryString = sprintf($queryBase, implode(", ", $queryPartials));

    try {
      DBHandler::executeQuery($queryString);
    }
    catch (Exception $e) {
      throw new \Exception(sprintf("%s: %s", __FUNCTION__, $e->getMessage()));
    }
  }
}
