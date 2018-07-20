<?php

/**
 * A class for storing simple material info-
 */
class MaterialSimple {

  private $name;

  /**
   * The class constructor.
   *
   * @param string materialRaw
   *  A raw material string.
   */
  public function __construct(string $materialRaw) {
    $material = ucfirst(trim(str_replace("and", "", $materialRaw)));
    $this->name = $material;
  }

  /**
   * Returns the name of the material.
   *
   * @return string
   *  The name of the material.
   */
  public function getName() {
    return $this->name;
  }

}
