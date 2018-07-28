<?php

/**
 * Stores which expansion the spell originates from.
 */
class SpellExpansion {

  private $spellName;
  private $expansionName;

  /**
   * The constructor for SpellExpansion.
   */
  public function __construct(string $spellName, string $expansionName = "Player's Handbook") {
    $this->spellName = $spellName;
    $this->expansionName = $expansionName;
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
   * Returns the name of the expansion.
   *
   * @return string
   *  The name of the expansion.
   */
  public function getExpansionName() {
    return $this->expansionName;
  }
}
