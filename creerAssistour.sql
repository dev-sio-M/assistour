drop database if exists assistour ;
create database assistour ;

use assistour ;

CREATE TABLE TypeContrat (
    idTypeContrat INTEGER PRIMARY KEY,
    nomTypeContrat VARCHAR(30) NOT NULL

);

CREATE TABLE TechnicienAssistance (
    idTA INTEGER PRIMARY KEY,
    nomTA VARCHAR(30) NOT NULL,
    prenomTA VARCHAR(30) NOT NULL
);

CREATE TABLE Adherent (
    numAdherent INTEGER PRIMARY KEY,
    nomAdherent VARCHAR(30) NOT NULL,
    prenomAdherent VARCHAR(30) NOT NULL,
    adresseAdherent VARCHAR(30) NOT NULL,
    codePostalAdherent INTEGER NOT NULL,
    villeAdherent VARCHAR(30) NOT NULL,
    telephoneAdherent VARCHAR(15) NOT NULL,
    idTypeContrat INTEGER NOT NULL,
    FOREIGN KEY (idTypeContrat) REFERENCES TypeContrat(idTypeContrat)
);

CREATE TABLE Vehicule (
    immatriculation VARCHAR(30) PRIMARY KEY,
    marque VARCHAR(30) NOT NULL,
    type VARCHAR(30) NOT NULL,
    modele VARCHAR(30) NOT NULL,
    dateMiseEnCirculation DATE NOT NULL,
    numAdherent INTEGER NOT NULL,
    FOREIGN KEY (numAdherent) REFERENCES Adherent(numAdherent)
);

CREATE TABLE Sinistre (
    numSinistre INTEGER PRIMARY KEY AUTO_INCREMENT,
    numContrat INTEGER NOT NULL,
    dateSinistre DATE NOT NULL,
    heureSinistre TIME NOT NULL,
    causeSinistre VARCHAR(100) NOT NULL,
    diagnosticSinistre VARCHAR(255) NOT NULL,
    lieuSinistre VARCHAR(100) NOT NULL,
    nbPersonnesPresentes INTEGER,
    FOREIGN KEY (numContrat) REFERENCES Adherent(numAdherent)
);

CREATE TABLE Rapatriement (
    numRapatriement INTEGER PRIMARY KEY AUTO_INCREMENT,
    numSinistre INTEGER NOT NULL,
    typeTransport VARCHAR(30) NOT NULL,
    coutTransport DECIMAL(10,2) NOT NULL,
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


INSERT INTO TypeContrat VALUES (1, 'Plénitude');
INSERT INTO TypeContrat VALUES (2, 'Tous Risques ECO');



INSERT INTO TechnicienAssistance VALUES (1, 'BENTOU', 'Olivia');

INSERT INTO Adherent VALUES (1, 'IVANOVITCH', 'Sacha', '14 boulevard du Temple', 75003, 'Paris', '06-92-88-29-53',1);
INSERT INTO Adherent VALUES (2, 'BELKACEM', 'Marwan', '2 rue Maspero', 75016, 'Paris', '06-73-93-99-05',2);

INSERT INTO Vehicule VALUES ('3412 CV 75', 'Citroën', 'voiture', 'C3', '2003-04-15', 1);
INSERT INTO Vehicule VALUES ('BJ 83 AE', 'Renault', 'voiture', 'Kadjar', '2019-10-10', 1);
INSERT INTO Vehicule VALUES ('GN-92-DE', 'Renault', 'voiture', 'Koleos', '2020-01-03', 2);
    

INSERT INTO Sinistre VALUES (1, 1, '2020-05-20', '13:27', 'Endormissement', 'Déformation modérée des éléments de direction', 'Dinan (22100)', 1);
INSERT INTO Sinistre VALUES (2, 2, '2020-06-03', '19:30', 'Percuté par un poids lourd', 'Véhicule irrécupérable', 'Saint Vaury (23320)', 2);  
    

INSERT INTO Rapatriement VALUES (1, 2, 'Taxi', 22, 'Saint Vaury', 'Guéret');
INSERT INTO Rapatriement VALUES (2, 2, 'Train', 23.80, 'Guéret', 'Limoges');
INSERT INTO Rapatriement VALUES (3, 2, 'Train', 68, 'Limoges', 'Paris-Austerlitz');

INSERT INTO SejourHotel VALUES (1, 1, 1, 2);
INSERT INTO SejourHotel VALUES (1, 1, 2, 1);

INSERT INTO Hotel VALUES (1, 'hôtel du theatre', '2 rue Sainte Claire', 22100, 'Dinan', '02-96-39-06-91', 65);
INSERT INTO Hotel VALUES (2, 'hôtel Ocean', '9 place du 11 novembre 1918', 22100, 'Dinan', '02-96-85-43-61', 79);
