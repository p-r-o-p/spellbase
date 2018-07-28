<?php

/**
 * Stores the ability for a class to cast a spell.
 */
class ClassSpell {

  private $className;
  private $spellName;

  /**
   * Constructor for ClassSpell.
   */
  public function __construct(string $class, string $spell) {
    $this->className = ucfirst($class);
    $this->spellName = ucwords($spell);
  }

  /**
   * Returns the class able to cast the spell.
   *
   * @return string
   *  The class able to cast the spell.
   */
  public function getClassName() {
    return $this->className;
  }

  /**
   * Returns the spell the class is able to cast.
   *
   * @return string
   *  The spell the class is able to cast.
   */
  public function getSpellName() {
    return $this->spellName;
  }
}
