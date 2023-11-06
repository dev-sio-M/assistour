DROP DATABASE IF EXISTS assistour;
CREATE DATABASE assistour;

USE assistour;

CREATE TABLE TypeContrat (
    idTypeContrat INTEGER NOT NULL,
    nomTypeContrat VARCHAR(30) NOT NULL,
    PRIMARY KEY(idtypeContrat)
);

CREATE TABLE TechnicienAssistance (
    idTA INTEGER NOT NULL,
    nomTa VARCHAR(30) NOT NULL,
    prenomTA VARCHAR(30) NOT NULL,
    PRIMARY KEY(idTA)
);

CREATE TABLE Adherent (
    numAdherent INTEGER NOT NULL,
    nomAdherent VARCHAR(30) NOT NULL,
    prenomAdherent VARCHAR(30) NOT NULL,
    adresseAdherent VARCHAR(30) NOT NULL,
    CodePostalAdherent INTEGER(10)NOT NULL,
    villeAdherent VARCHAR(30) NOT NULL,
    telephoneAdherent VARCHAR(15) NOT NULL,
	PRIMARY KEY(numAdherent)
);

CREATE TABLE Vehicule (
    immatriculation VARCHAR(30) ,
    marque VARCHAR(30) NOT NULL,
    type VARCHAR(30) NOT NULL,
    modele VARCHAR(30) NOT NULL,
    dateMiseEnCirculation DATE NOT NULL,
    PRIMARY KEY(immatriculation)
);

CREATE TABLE Dossier (
    numSinistre INTEGER NOT NULL,
    DateDuSinistre DATE NOT NULL,
    heureDuSinistre TIME NOT NULL,
    causeDuSinistre VARCHAR(100) NOT NULL,
    diagnosticDuSinistre VARCHAR(250) NOT NULL,
    lieuDuSinistre VARCHAR(100) NOT NULL,
    vehiculeConcerne VARCHAR(50) NOT NULL,
    nbPersPresentesDansVehicule INTEGER(100) NOT NULL,
    fraisDepanage INTEGER(255) NOT NULL,
    PRIMARY KEY(numSinistre)
);

CREATE TABLE Rapatriement (
    numRapatriement INTEGER NOT NULL,
    TypeTransport VARCHAR(30) NOT NULL,
    CoutRapatriement DECIMAL(10,2) NOT NULL,
    villeDepart VARCHAR(100) NOT NULL,
    villeArrivee VARCHAR(100) NOT NULL,
    PRIMARY KEY(numRapatriement)
);

CREATE TABLE Hotel (
    numHotel INTEGER NOT NULL,
    nomHotel VARCHAR(30) NOT NULL,
    adresseHotel VARCHAR(50) NOT NULL,
    telephoneHotel VARCHAR(15) NOT NULL,
    prixNuit INTEGER(200) NOT NULL,
    PRIMARY KEY(numHotel)
);

CREATE TABLE Garage (
    numGarage INTEGER NOT NULL,
    nomGarage VARCHAR(30) NOT NULL,
    adresseGarage VARCHAR(50) NOT NULL,
    telephoneGarage VARCHAR(15) NOT NULL,
    marqueGarage VARCHAR(50),
    avanceFondsAcepptee INTEGER(255) NOT NULL,
    PRIMARY KEY(numGarage)
);

CREATE TABLE Discuter (
    idTA INTEGER NOT NULL,
    numAdherent INTEGER NOT NULL,
    PRIMARY KEY(idTA, numAdherent),
    FOREIGN KEY(idTA) REFERENCES TechnicienAssistance(idTA),
    FOREIGN KEY(numAdherent) REFERENCES Adherent(numAdherent)
);

CREATE TABLE Heberger (
    numRapatriement INTEGER NOT NULL,
    numHotel INTEGER NOT NULL,
    PRIMARY KEY(numRapatriement, numHotel),
    FOREIGN KEY(numRapatriement) REFERENCES Rapatriement(numRapatriement),
    FOREIGN KEY(numHotel) REFERENCES Hotel(numHotel)
);

CREATE TABLE Depanner (
    numRapatriement INTEGER NOT NULL,
    numGarage INTEGER NOT NULL,
    PRIMARY KEY(numRapatriement, numGarage),
    FOREIGN KEY(numRapatriement) REFERENCES Rapatriement(numRapatriement),
    FOREIGN KEY(numGarage) REFERENCES Garage(numGarage)
);

CREATE TABLE Posseder (
    numAdherent INTEGER NOT NULL,
    immatriculation VARCHAR(30) NOT NULL,
    PRIMARY KEY(numAdherent, immatriculation),
    FOREIGN KEY(numAdherent) REFERENCES Adherent(numAdherent),
    FOREIGN KEY(immatriculation) REFERENCES Vehicule(immatriculation)
);

CREATE TABLE Reparer (
    numGarage INTEGER NOT NULL,
    immatriculation VARCHAR(30) NOT NULL,
    PRIMARY KEY(numGarage, immatriculation),
    FOREIGN KEY(numGarage) REFERENCES Garage(numGarage),
    FOREIGN KEY(immatriculation) REFERENCES Vehicule(immatriculation)
);

CREATE TABLE Souscrire (
    numAdherent INTEGER NOT NULL,
    idTypeContrat INTEGER NOT NULL,
    PRIMARY KEY(numAdherent, idTypeContrat),
    FOREIGN KEY(numAdherent) REFERENCES Adherent(numAdherent),
    FOREIGN KEY(idTypeContrat) REFERENCES TypeContrat(idTypeContrat)
);

CREATE TABLE Detenir (
    numDossier INTEGER NOT NULL,
    numAdherent INTEGER NOT NULL,
    PRIMARY KEY(numDossier, numAdherent),
    FOREIGN KEY(numDossier) REFERENCES Dossier(numSinistre),
    FOREIGN KEY(numAdherent) REFERENCES Adherent(numAdherent)
);

CREATE TABLE Utiliser (
    numSinistre INTEGER NOT NULL,
    numRapatriement INTEGER NOT NULL,
    PRIMARY KEY(numSinistre, numRapatriement),
    FOREIGN KEY(numSinistre) REFERENCES Dossier(numSinistre),
    FOREIGN KEY(numRapatriement) REFERENCES Rapatriement(numRapatriement)
);

INSERT INTO TypeContrat VALUES (1, 'Plénitude');
INSERT INTO TypeContrat VALUES (2, 'Tous Risques ECO');

INSERT INTO TechnicienAssistance VALUES (1, 'BENTOU', 'Olivia');

INSERT INTO Adherent VALUES (1, 'IVANOVITCH', 'Sacha', '14 boulevard du Temple', 75003, 'Paris', '06-92-88-29-53');
INSERT INTO Adherent VALUES (2, 'BELKACEM', 'Marwan', '2 rue Maspero', 75016, 'Paris', '06-73-93-99-05');

INSERT INTO Vehicule VALUES ('3412 CV 75', 'Citroën', 'voiture', 'C3', '2003-04-15');
INSERT INTO Vehicule VALUES ('BJ 83 AE', 'Renault', 'voiture', 'Kadjar', '2019-10-10');
INSERT INTO Vehicule VALUES ('GN-92-DE', 'Renault', 'voiture', 'Koleos', '2020-01-03');

INSERT INTO Dossier VALUES (1, '2020-05-20', '13:27', 'Endormissement', 'Déformation modérée des éléments de direction', 'Dinan (22100)', '3412 CV 75', 1, 210);
INSERT INTO Dossier VALUES (2, '2020-06-03', '19:30', 'Percuté par un poids lourd', 'Véhicule irrécupérable', 'Saint Vaury (23320)', 'GN-92-DE', 2, 190);

INSERT INTO Rapatriement VALUES (1, 'Taxi', 22, 'Saint Vaury', 'Guéret');
INSERT INTO Rapatriement VALUES (2, 'Train', 23.80, 'Guéret', 'Limoges');
INSERT INTO Rapatriement VALUES (3, 'Train', 68, 'Limoges', 'Paris-Austerlitz');

INSERT INTO Hotel VALUES (1, 'hôtel du theatre', '2 rue Sainte Claire', '02-96-39-06-91', 65);
INSERT INTO Hotel VALUES (2, 'hôtel Ocean', '9 place du 11 novembre 1918', '02-96-85-43-61', 79);


INSERT INTO Garage VALUES (1, 'Garage De La Sansonnais', 'rue du Général De Gaulle', '02-96-85-40-98', NULL, 0);
INSERT INTO Garage VALUES (2, 'garage Citroen de Guéret', '22 rue Marechal Leclerc', '05-55-52-48-52', 'Citroen', 0);

INSERT INTO Discuter VALUES (1, 1);
INSERT INTO Discuter VALUES (1, 2);

INSERT INTO Heberger VALUES (1, 1);
INSERT INTO Heberger VALUES (1, 2);

INSERT INTO Depanner VALUES (1, 1);
INSERT INTO Depanner VALUES (2, 2);
INSERT INTO Depanner VALUES (3, 1);

INSERT INTO Posseder VALUES (1, '3412 CV 75');
INSERT INTO Posseder VALUES (2, 'BJ 83 AE');
INSERT INTO Posseder VALUES (2, 'GN-92-DE');

INSERT INTO Reparer VALUES (1, '3412 CV 75');
INSERT INTO Reparer VALUES (2, '3412 CV 75');
INSERT INTO Reparer VALUES (1, 'BJ 83 AE');
INSERT INTO Reparer VALUES (2, 'GN-92-DE');

INSERT INTO Souscrire VALUES (1, 1);
INSERT INTO Souscrire VALUES (2, 2);

INSERT INTO Detenir VALUES (1, 1);
INSERT INTO Detenir VALUES (2, 1);
INSERT INTO Detenir VALUES (2, 2);

INSERT INTO Utiliser VALUES (1, 1);
INSERT INTO Utiliser VALUES (2, 2);

