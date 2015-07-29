-- phpMyAdmin SQL Dump
-- version 4.4.3
-- http://www.phpmyadmin.net
--
-- Client :  localhost
-- Auteur :  sando
-- Généré le :  Lun 27 Juillet 2015 à 10:22
-- Version du serveur :  5.6.24
-- Version de PHP :  5.6.8

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Base de données :  `urnews`

--
-- Contenu de la table `Banque`
--

INSERT INTO `Banque` (`id`, `version`, `code`, `libelle`) VALUES
(1, NULL, 'BQ2015001', 'AFRILAND FIRST BANK'),
(2, NULL, 'BQ2015002', 'COMMERCIAL BANK OF CAMEROON');

--
-- Contenu de la table `Filiale`
--

INSERT INTO `Filiale` (`id`, `version`, `agence`, `code`, `nom`) VALUES
(1, 0, 'Bafoussam', 'CF20150001', 'Silver Rims Ltd'),
(2, 0, 'Mokolo - Yaoundé', 'CF20150002', 'Stanton Hoods Corp'),
(3, 0, 'Mokolo - Yaoundé', 'CF20150003', 'Pacific rims');

--
-- Contenu de la table `TypeCaution`
--

INSERT INTO `TypeCaution` (`id`, `version`, `code`, `nom`, `pourcentage`) VALUES
(1, 0, 'TD20150001', 'Paiement Par Avaliseur ', '24%'),
(2, 0, 'TD20150002', 'Paiement mensuel', '25%'),
(3, 0, 'TD20150003', 'Paiement Cash', '50%');

--
-- Contenu de la table `TypeMateriel`
--

INSERT INTO `TypeMateriel` (`id`, `version`, `code`, `nom`) VALUES
(1, 0, 'TM20150001', 'Matériaux de Jardinage '),
(2, 0, 'TM20150002', 'Objets Décoratifs'),
(3, 0, 'TM20150003', 'Pièces Automobile'),
(4, 1, 'TM20150004', 'Matériaux de construction'),
(5, 0, 'TM201507001', 'MatÃ©riel de Charpenterie '),
(6, 0, 'TM201507001', 'MatÃ©riel de Charpenterie ');

--
-- Contenu de la table `users`
--

INSERT INTO `users` (`username`, `enabled`, `nom`, `password`) VALUES
('admin', 1, 'Kaporal Phoenix', '$2a$10$EblZqNptyYvcLm/VwDCVAuBjzZOI7khzdyGPBr08PpIi0na624b8.'),
('brice', 1, 'GUEMKAM Brice', '$2a$10$7/84X0KVW4ws3x92R1z0/uJ.0X0qmHw4HCTP7gn1EskUXgLdkS.n6'),
('delaroos', 1, 'KANMOGNE DELANO ROOSVELT', '$2a$10$YYW0YMecApPzYqc94nuD0uZ0qWRELzsPV73NaqRZvSstEtfcXf/nO'),
('kamguy', 1, 'KAMSU GUY', '$2a$10$4BDOotc1kMQXtbGvrSAHm.L8RagO0nhvKM9tTUD7Mg5Wn3DtvCJwS'),
('moimeme', 1, 'moimeme', '$2a$10$AwyDu7AwTOOmmfYo3NagO.71rwUKbu/1I.ds7SbrMZ9ZjlJ7SEoyW');

--
-- Contenu de la table `user_roles`
--

INSERT INTO `user_roles` (`user_role_id`, `role`, `user_username`) VALUES
(1, 'ROLE_ADMIN', 'admin'),
(2, 'ROLE_USER', 'brice'),
(7, 'ROLE_COMMERCIAL', 'kamguy'),
(8, 'ROLE_COMMERCIAL', 'delaroos'),
(10, 'ROLE_TRESORIER', 'moimeme');

--
-- Contenu de la table `Materiel`
--

INSERT INTO `Materiel` (`id`, `version`, `code`, `description`, `nom`, `typeMateriel_id`) VALUES
(1, 0, 'MJ20150001', 'pour rattisser', 'Rateau', 1),
(2, 0, 'MJ20150002', 'pour tailler les fleurs', 'Grands Sciseaux', 1),
(3, 0, 'OD2015001', 'Pot de fleurs pour trefles', 'Pots de trèfles', 2),
(4, 0, 'OD2015002', 'Tableaux décoratifs pour salon', 'Van ghogg', 2),
(5, 0, 'PA20150001', 'Roues pour courses automobiles', 'Roues Konîg', 3),
(6, 0, 'PA20150002', 'Peintures particulières pour véhicules de courses', 'Vinyls', 3),
(7, 0, 'MC20150001', 'matériel pour le transport de sables, gravier et ciment', 'Brouette', 4),
(8, 0, 'MC20150002', 'utilisé pour tourner le béton ', 'Pelle', 4);
--

--
-- Contenu de la table `AppelOffre`
--

INSERT INTO `AppelOffre` (`id`, `version`, `dateDepot`, `delaiDeValidite`, `etat`, `intitule`, `maitreDouvrage`, `numero`, `pieceJointe1`, `pieceJointe2`, `pieceJointe3`, `pieceJointe4`, `pieceJointe5`, `pieceJointe6`, `pieceJointe7`, `pieceJointe8`, `filiale_id`) VALUES
(2, 1, '2015-07-27', '12', 'En cours', 'PRO-FORMAT FOKOU', 'SANDO', 'AP20150725', 'Commentaires 17e Dimanche Ordinaire B 2.pdf', '', NULL, NULL, NULL, NULL, NULL, NULL, 2);

--
-- Contenu de la table `Caution`
--

INSERT INTO `Caution` (`id`, `version`, `dateDebut`, `dateFin`, `montant`, `montantMarche`, `numero`, `referenceMarche`, `appelOffre_id`, `banque_id`, `commercial_user_role_id`, `typeCaution_id`) VALUES
(3, 0, '2015-07-25', '2015-08-25', 100000, 1000000, 'CA2015072501', 'RM2015072501', 2, 1, 7, 2),
(4, 0, '2015-07-27', '2015-07-31', 600000, 1000000, 'CA2015072502', 'RM2015072502', 2, 2, 8, 3);

--
-- Contenu de la table `LigneAppel`
--

INSERT INTO `LigneAppel` (`id`, `version`, `prixUnitaire`, `quantite`, `appelOffre_id`, `materiel_id`) VALUES
(4, 0, 1000, 5, 2, 1),
(5, 0, 2500, 3, 2, 2),
(6, 0, 6300, 5, 2, 3);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;