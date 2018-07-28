<?php

/**
 * Stores time unit used for duration a spell, along with the number of units.
 */
class DurationSpellTimeUnit {

  private $quantity;
  private $spellName;
  private $timeUnitName;
  private $note;

  /**
   * constructor for DurationSpellTimeUnit.
   */
  public function __construct(\stdClass $spellInfo) {
    $this->spellName = $spellInfo->name;
    $durationInfo = explode(" ", $spellInfo->duration);

    if (is_numeric($durationInfo[0])) {
      $this->quantity = $durationInfo[0];
      $unitName = strtolower(trim($durationInfo[1]));

      // Convert duration to minutes.
      switch($unitName) {
        case "hour":
          // Intentional fallthrough.
        case "hours":
          $this->quantity = $this->quantity * 60;
          $this->note = NULL;
          break;
        case "day":
          // Intentional fallthrough.
        case "days":
          $this->quantity = $this->quantity * 24 * 60;
          $this->note = NULL;
          break;
      }
    }
    else {
      $this->quantity = 0;
      $this->note = $spellInfo->duration;
    }
    $this->timeUnitName = "Minute";
  }

  /**
   * Returns the quantity of time units for casting the spell.
   *
   * @return integer
   *  The quantity of time units for casting the spell.
   */
  public function getQuantity() {
    return $this->quantity;
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
   * Returns name of the time unit.
   *
   * @return string
   *  The name of the time unit.
   */
  public function getTimeUnitName() {
    return $this->timeUnitName;
  }

  /**
   * Returns various notes about the duration of the spell.
   *
   * @return string
   *  The various notes about the duration of the spell.
   */
  public function getNote() {
    return $this->note;
  }

}
