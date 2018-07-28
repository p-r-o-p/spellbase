<?php

/**
 * Stores which school a spell belongs to.
 */
class SpellSchool {

  private $spellName;
  private $schoolName;


  /**
   * Constructor for SpellSchool
   */
  public function __construct(\stdClass $spellInfo) {
    $this->spellName = $spellInfo->name;
    $this->schoolName = ucfirst(trim($spellInfo->school));
  }


  /**
   * Returns the name of the spell.
   *
   * @return string
   *  The name of the spell.
   */
  public function getSpellName() {
    return $this->spellName;
  }


  /**
   * Returns the school of the spell.
   *
   * @return string
   *  The school of the spell.
   */
  public function getSchoolName() {
    return $this->schoolName;
  }
}
