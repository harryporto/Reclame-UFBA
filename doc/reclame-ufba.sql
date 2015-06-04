SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

CREATE SCHEMA IF NOT EXISTS `reclame_ufba` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
USE `reclame_ufba` ;

-- -----------------------------------------------------
-- Table `reclame_ufba`.`usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `reclame_ufba`.`usuario` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(90) NOT NULL,
  `email` VARCHAR(255) NOT NULL,
  `matricula` VARCHAR(11) NOT NULL,
  `papel` INT NOT NULL,
  `senha` VARCHAR(40) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `matricula_UNIQUE` (`matricula` ASC),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `reclame_ufba`.`categoria`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `reclame_ufba`.`categoria` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(90) NOT NULL,
  `descricao` TEXT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `nome_UNIQUE` (`nome` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `reclame_ufba`.`reclamacao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `reclame_ufba`.`reclamacao` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `titulo` VARCHAR(90) NOT NULL,
  `mensagem` TEXT NOT NULL,
  `insatisfacao` INT NOT NULL,
  `data` DATETIME NOT NULL,
  `usuario_id` INT UNSIGNED NOT NULL,
  `categoria_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_reclamação_usuario_idx` (`usuario_id` ASC),
  INDEX `fk_reclamação_categoria1_idx` (`categoria_id` ASC),
  CONSTRAINT `fk_reclamação_usuario`
    FOREIGN KEY (`usuario_id`)
    REFERENCES `reclame_ufba`.`usuario` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_reclamação_categoria1`
    FOREIGN KEY (`categoria_id`)
    REFERENCES `reclame_ufba`.`categoria` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `reclame_ufba`.`comentario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `reclame_ufba`.`comentario` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `titulo` VARCHAR(90) NOT NULL,
  `mensagem` TEXT NOT NULL,
  `data` DATETIME NOT NULL,
  `tipo` INT NOT NULL,
  `usuario_id` INT UNSIGNED NOT NULL,
  `reclamacao_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_resposta_reclamacao_usuario1_idx` (`usuario_id` ASC),
  INDEX `fk_comentario_reclamacao1_idx` (`reclamacao_id` ASC),
  CONSTRAINT `fk_resposta_reclamacao_usuario1`
    FOREIGN KEY (`usuario_id`)
    REFERENCES `reclame_ufba`.`usuario` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_comentario_reclamacao1`
    FOREIGN KEY (`reclamacao_id`)
    REFERENCES `reclame_ufba`.`reclamacao` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `reclame_ufba`.`satisfacao_categoria`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `reclame_ufba`.`satisfacao_categoria` (
  `usuario_id` INT UNSIGNED NOT NULL,
  `categoria_id` INT UNSIGNED NOT NULL,
  `satisfacao` INT NOT NULL,
  PRIMARY KEY (`usuario_id`, `categoria_id`),
  INDEX `fk_usuario_has_categoria_categoria1_idx` (`categoria_id` ASC),
  INDEX `fk_usuario_has_categoria_usuario1_idx` (`usuario_id` ASC),
  CONSTRAINT `fk_usuario_has_categoria_usuario1`
    FOREIGN KEY (`usuario_id`)
    REFERENCES `reclame_ufba`.`usuario` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_usuario_has_categoria_categoria1`
    FOREIGN KEY (`categoria_id`)
    REFERENCES `reclame_ufba`.`categoria` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `reclame_ufba`.`voto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `reclame_ufba`.`voto` (
  `usuario_id` INT UNSIGNED NOT NULL,
  `reclamacao_id` INT UNSIGNED NOT NULL,
  `voto` TINYINT(1) NOT NULL,
  PRIMARY KEY (`usuario_id`, `reclamacao_id`),
  INDEX `fk_usuario_has_reclamacao_reclamacao1_idx` (`reclamacao_id` ASC),
  INDEX `fk_usuario_has_reclamacao_usuario1_idx` (`usuario_id` ASC),
  CONSTRAINT `fk_usuario_has_reclamacao_usuario1`
    FOREIGN KEY (`usuario_id`)
    REFERENCES `reclame_ufba`.`usuario` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_usuario_has_reclamacao_reclamacao1`
    FOREIGN KEY (`reclamacao_id`)
    REFERENCES `reclame_ufba`.`reclamacao` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
