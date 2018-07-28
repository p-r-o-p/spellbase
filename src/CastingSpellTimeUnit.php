<?php

/**
 * Stores time unit used for casting a spell, along with the number of units.
 */
class CastingSpellTimeUnit {

  private $quantity;
  private $spellName;
  private $timeUnitName;

  /**
   * constructor for CastingSpellTimeUnit.
   */
  public function __construct(\stdClass $spellInfo) {
    $this->spellName = $spellInfo->name;
    $castingInfo = explode(" ", $spellInfo->casting_time);
    $unitName = strtolower(trim($castingInfo[1]));
    $unitName = str_replace(",", "", $unitName);
    $this->quantity = $castingInfo[0];

    // Convert duration to minutes.
    switch($unitName) {
      case "bonus":
        $this->timeUnitName = "Bonus action";
        break;
      case "hour":
        // Intentional fallthrough.
      case "hours":
        $this->quantity = $this->quantity * 60;
        $this->timeUnitName = "Minute";
        break;
      case "day":
        // Intentional fallthrough.
      case "days":
        $this->quantity = $this->quantity * 24 * 60;
        $this->timeUnitName = "Minute";
        break;
      case "minutes":
        $this->timeUnitName = "Minute";
        break;
      default:
        $this->timeUnitName = ucfirst($unitName);
        break;
    }
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

}
