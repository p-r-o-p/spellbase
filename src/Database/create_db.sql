-- Make certain the database is not polluted with old data.
DROP DATABASE IF EXISTS dnd_db;

CREATE DATABASE dnd_db;

USE dnd_db;

CREATE TABLE spell (
  id INTEGER(32) UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(60) NOT NULL,
  level INTEGER(32) UNSIGNED NOT NULL,
  is_ritual BOOLEAN NOT NULL,
  reach INTEGER(32) UNSIGNED NOT NULL,
  is_touch BOOLEAN NOT NULL,
  is_self BOOLEAN NOT NULL,
  is_concentration BOOLEAN NOT NULL,
  is_verbal BOOLEAN NOT NULL,
  is_somatic BOOlEAN NOT NULL,
  description TEXT NOT NULL,
  PRIMARY KEY (id)
);
CREATE INDEX spell_name_index ON spell(name) USING BTREE;

CREATE TABLE school (
  id INTEGER(32) UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(30) NOT NULL,
  description TEXT NOT NULL,
  PRIMARY KEY (id)
);
CREATE INDEX school_name_index ON school(name) USING BTREE;

CREATE TABLE time_unit (
  id INTEGER(32) UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(60) NOT NULL,
  PRIMARY KEY (id)
);
CREATE INDEX time_unit_name_index ON time_unit(name) USING BTREE;

CREATE TABLE material (
  id INTEGER(32) UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(60) NOT NULL,
  PRIMARY KEY (id)
);
CREATE INDEX material_name_index ON material(name) USING BTREE;

CREATE TABLE class (
  id INTEGER(32) UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(30),
  PRIMARY KEY (id)
);
CREATE INDEX class_name_index ON class(name) USING BTREE;

CREATE TABLE expansion (
  id INTEGER(32) UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(60) NOT NULL,
  PRIMARY KEY (id)
);
CREATE INDEX expansion_name_index ON expansion(name) USING BTREE;

CREATE TABLE class_spell (
  id INTEGER(32) UNSIGNED NOT NULL AUTO_INCREMENT,
  class_id INTEGER(32) UNSIGNED NOT NULL,
  spell_id INTEGER(32) UNSIGNED NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (class_id) REFERENCES class(id),
  FOREIGN KEY (spell_id) REFERENCES spell(id)
);

CREATE TABLE casting_spell_time_unit (
  id INTEGER(32) UNSIGNED NOT NULL AUTO_INCREMENT,
  spell_id INTEGER(32) UNSIGNED NOT NULL,
  time_unit_id INTEGER(32) UNSIGNED,
  quantity INTEGER(32) UNSIGNED,
  PRIMARY KEY (id),
  FOREIGN KEY (spell_id) REFERENCES spell(id),
  FOREIGN KEY (time_unit_id) REFERENCES time_unit(id)
);

CREATE TABLE duration_spell_time_unit (
  id INTEGER(32) UNSIGNED NOT NULL AUTO_INCREMENT,
  spell_id INTEGER(32) UNSIGNED NOT NULL,
  time_unit_id INTEGER(32) UNSIGNED,
  quantity INTEGER(32) UNSIGNED,
  note TEXT,
  PRIMARY KEY (id),
  FOREIGN KEY (spell_id) REFERENCES spell(id),
  FOREIGN KEY (time_unit_id) REFERENCES time_unit(id)
);

CREATE TABLE spell_school (
  id INTEGER(32) UNSIGNED NOT NULL AUTO_INCREMENT,
  spell_id INTEGER(32) UNSIGNED NOT NULL,
  school_id INTEGER(32) UNSIGNED NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (spell_id) REFERENCES spell(id),
  FOREIGN KEY (school_id) REFERENCES school(id)
);

CREATE TABLE spell_material (
  id INTEGER(32) UNSIGNED NOT NULL AUTO_INCREMENT,
  spell_id INTEGER(32) UNSIGNED NOT NULL,
  material_id INTEGER(32) UNSIGNED NOT NULL,
  is_consumed BOOLEAN NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (spell_id) REFERENCES spell(id),
  FOREIGN KEY (material_id) REFERENCES material(id)
);

CREATE TABLE spell_expansion (
  id INTEGER(32) UNSIGNED NOT NULL AUTO_INCREMENT,
  spell_id INTEGER(32) UNSIGNED NOT NULL,
  expansion_id INTEGER(32) UNSIGNED NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (spell_id) REFERENCES spell(id),
  FOREIGN KEY (expansion_id) REFERENCES expansion(id)
);
