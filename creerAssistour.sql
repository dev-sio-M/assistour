DROP DATABASE IF EXISTS assistance;
CREATE DATABASE assistance;

USE assistance;

CREATE TABLE typeContrat (
    idTypeContrat INTEGER PRIMARY KEY,
    nomTypeContrat VARCHAR(30) NOT NULL
);

CREATE TABLE TechniciensAssistance (
    idTA INTEGER PRIMARY KEY,
    nomTA VARCHAR(30) NOT NULL,
    prenomTA VARCHAR(30) NOT NULL
);

CREATE TABLE Adherent (
    numAdherent INTEGER PRIMARY KEY,
    nomAdherent VARCHAR(30) NOT NULL,
    prenomAdherent VARCHAR(30) NOT NULL,
    adresseAdherent VARCHAR(30) NOT NULL,
    CodePostalAdherent INTEGER NOT NULL,
    villeAdherent VARCHAR(30) NOT NULL,
    telephoneAdherent VARCHAR(15) NOT NULL
);

CREATE TABLE Vehicule (
    immatriculation VARCHAR(30) PRIMARY KEY,
    marque VARCHAR(30) NOT NULL,
    type VARCHAR(30) NOT NULL,
    modele VARCHAR(30) NOT NULL,
    dateMiseEnCirculation DATE NOT NULL
);

CREATE TABLE Souscrire (
    numAdherent INTEGER,
    idTypeContrat INTEGER,
    PRIMARY KEY (numAdherent, idTypeContrat),
    FOREIGN KEY (numAdherent) REFERENCES Adherent(numAdherent),
    FOREIGN KEY (idTypeContrat) REFERENCES typeContrat(idTypeContrat)
);

CREATE TABLE Posseder (
    numAdherent INTEGER,
    immatriculation VARCHAR(30),
    PRIMARY KEY (numAdherent, immatriculation),
    FOREIGN KEY (numAdherent) REFERENCES Adherent(numAdherent),
    FOREIGN KEY (immatriculation) REFERENCES Vehicule(immatriculation)
);

CREATE TABLE Sinistre (
    numSinistre INTEGER PRIMARY KEY AUTO_INCREMENT,
    idTypeContrat INTEGER NOT NULL,
    DateSinistre DATE NOT NULL,
    heureSinistre TIME NOT NULL,
    causeSinistre VARCHAR(100) NOT NULL,
    diagnosticSinistre VARCHAR(255) NOT NULL,
    placeSinistre VARCHAR(100) NOT NULL,
    nbPersonnesPresent INTEGER,
    fraisDepannage INTEGER,
    FOREIGN KEY (idTypeContrat) REFERENCES typeContrat(idTypeContrat)
);

CREATE TABLE Rapatriement (
    numRapatriement INTEGER PRIMARY KEY AUTO_INCREMENT,
    numSinistre INTEGER NOT NULL,
    TypeTransport VARCHAR(30) NOT NULL,
    CoutTransport DECIMAL(10,2) NOT NULL,
    villeDepart VARCHAR(100) NOT NULL,
    villeArrivee VARCHAR(100) NOT NULL,
    FOREIGN KEY (numSinistre) REFERENCES Sinistre(numSinistre)
);

CREATE TABLE SejourHotel (
    numRapatriement INTEGER NOT NULL,
    numSinistre INTEGER NOT NULL,
    numHotel INTEGER NOT NULL,
    nbNuitees INTEGER NOT NULL,
    PRIMARY KEY(numRapatriement, numHotel),
    FOREIGN KEY (numRapatriement) REFERENCES Rapatriement(numRapatriement)
);

CREATE TABLE Hotel (
    numHotel INTEGER PRIMARY KEY,
    nomHotel VARCHAR(30) NOT NULL,
    adresseHotel VARCHAR(30) NOT NULL,
    codePostalHotel INTEGER NOT NULL,
    villeHotel VARCHAR(30) NOT NULL,
    telephoneHotel VARCHAR(15) NOT NULL,
    prixNuit INTEGER(5) NOT NULL
);

INSERT INTO typeContrat VALUES (1, 'Plénitude');
INSERT INTO typeContrat VALUES (2, 'Tous Risques ECO');

INSERT INTO TechniciensAssistance VALUES (1, 'BENTOU', 'Olivia');

INSERT INTO Adherent VALUES (1, 'IVANOVITCH', 'Sacha', '14 boulevard du Temple', 75003, 'Paris', '06-92-88-29-53');
INSERT INTO Adherent VALUES (2, 'BELKACEM', 'Marwan', '2 rue Maspero', 75016, 'Paris', '06-73-93-99-05');

INSERT INTO Vehicule VALUES ('3412 CV 75', 'Citroën', 'voiture', 'C3', '2003-04-15');
INSERT INTO Vehicule VALUES ('BJ 83 AE', 'Renault', 'voiture', 'Kadjar', '2019-10-10');
INSERT INTO Vehicule VALUES ('GN-92-DE', 'Renault', 'voiture', 'Koleos', '2020-01-03');

INSERT INTO Sinistre (idTypeContrat, DateSinistre, heureSinistre, causeSinistre, diagnosticSinistre, placeSinistre, nbPersonnesPresent, fraisDepannage) VALUES (1, '2020-05-20', '13:27', 'Endormissement', 'Déformation modérée des éléments de direction', 'Dinan (22100)', 1 ,210);
INSERT INTO Sinistre (idTypeContrat, DateSinistre, heureSinistre, causeSinistre, diagnosticSinistre, placeSinistre, nbPersonnesPresent, fraisDepannage) VALUES (2, '2020-06-03', '19:30', 'Percuté par un poids lourd', 'Véhicule irrécupérable', 'Saint Vaury (23320)', 2 ,190);

INSERT INTO Rapatriement (numSinistre, TypeTransport, CoutTransport, villeDepart, villeArrivee) VALUES (2, 'Taxi', 22, 'Saint Vaury', 'Guéret');
INSERT INTO Rapatriement (numSinistre, TypeTransport, CoutTransport, villeDepart, villeArrivee) VALUES (2, 'Train', 23.80, 'Guéret', 'Limoges');
INSERT INTO Rapatriement (numSinistre, TypeTransport, CoutTransport, villeDepart, villeArrivee) VALUES (2, 'Train', 68, 'Limoges', 'Paris-Austerlitz');

INSERT INTO SejourHotel (numRapatriement, numSinistre, numHotel, nbNuitees) VALUES (1, 1, 1, 2);
INSERT INTO SejourHotel (numRapatriement, numSinistre, numHotel, nbNuitees) VALUES (1, 1, 2, 1);

INSERT INTO Hotel VALUES (1, 'hôtel du theatre', '2 rue Sainte Claire', 22100, 'Dinan', '02-96-39-06-91', 65);
INSERT INTO Hotel VALUES (2, 'hôtel Ocean', '9 place du 11 novembre 1918', 22100, 'Dinan', '02-96-85-43-61', 79);
