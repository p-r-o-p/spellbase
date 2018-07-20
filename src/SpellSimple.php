<?php

/**
 * Class for storing simple spell info.
 */
class SpellSimple {

  private $description;
  private $isConcentration;
  private $isRitual;
  private $isSelf;
  private $isSomatic;
  private $isTouch;
  private $isVerbal;
  private $level;
  private $name;
  private $reach;

  public function __construct(\stdClass $spellInfo) {
    $this->description = sprintf("%s\n\n%s", $spellInfo->description, $spellInfo->higher_levels);
    $concentrationInfo = explode(",", $spellInfo->duration);
    $this->isConcentration = $concentrationInfo[0] === "Concentration" ? TRUE : FALSE;
    $this->isRitual = $spellInfo->ritual;
    $rangeInfo = explode(" ", $spellInfo->range);
    switch ($rangeInfo[0]) {
      case "Self":
        $this->isSelf = TRUE;
        $this->isTouch = FALSE;
        $this->Reach = 0;
        break;
      case "Touch":
        $this->isSelf = FALSE;
        $this->isTouch = TRUE;
        $this->reach = 0;
        break;
      default:
        $this->reach = $rangeInfo[0];

        if ($rangeInfo[1] == "mile" || $rangeInfo[1] == 'miles') {
          $this->reach *= 5280;
        }
        break;
    }

    $this->isSomatic = $spellInfo->components->somatic;
    $this->isVerbal = $spellInfo->components->verbal;
    $this->level = $spellInfo->level;
    $this->name = $spellInfo->name;
  }

  /**
   * Returns the description of the spell.
   *
   * @return string
   *  A string containing the description of the spell.
   */
  public function getDescription() {
    return $this->description;
  }

  /**
   * Returns whether the spell requires concentration or not.
   *
   * @return boolean
   *  Whether the spell requires concentration or not.
   */
  public function getIsConcentration() {
    return $this->isConcentration;
  }

  /**
   * Returns whether the spell is a ritual or not.
   *
   * @return boolean
   *  Whether the spell is a ritual or not.
   */
  public function getIsRitual() {
    return $this->isRitual;
  }

  /**
   * Returns whether the spell is range self or not.
   *
   * @return boolean
   *  Whether the spell is range self or not.
   */
  public function getIsSelf() {
    return $this->isSelf;
  }

  /**
   * Returns whether the spell is somatic or not.
   *
   * @return boolean
   *  Whether the spell is somatic or not.
   */
  public function getIsSomatic() {
    return $this->isSomatic;
  }

  /**
   * Returns whether the spell is range touch or not.
   *
   * @return boolean
   *  Whether the spell is range touch or not.
   */
  public function getIsTouch() {
    return $this->isTouch;
  }

  /**
   * Returns whether the spell is verbal or not.
   *
   * @return boolean
   *  Whether the spell is verbal or not.
   */
  public function getIsVerbal() {
    return $this->isVerbal;
  }

  /**
   * Returns the level of the spell.
   *
   * @return integer
   *  The level of the spell.
   */
  public function getLevel() {
    return $this->level;
  }

  /**
   * Returns the name of the string.
   *
   * @return string
   *  The name of the spell.
   */
  public function getName() {
    return $this->name;
  }

  /**
   * Returns the reach of the spell
   *
   * @return integer
   *  The reach of the spell.
   */
  public function getReach() {
    return $this->reach;
  }
}
