use assistour ;

/*Liste des hôtels qui ont hébergé M. IVANOVITCH (sinistre du 20/05/2020)*/
SELECT nomHotel
FROM Hotel
WHERE numHotel IN (
    SELECT numHotel
    FROM Heberger
    JOIN Rapatriement ON Heberger.numRapatriement = Rapatriement.numRapatriement
    JOIN Dossier ON Rapatriement.numRapatriement = Dossier.numSinistre
    JOIN Adherent ON Dossier.numSinistre = Adherent.numAdherent
    WHERE Adherent.nomAdherent = 'IVANOVITCH'
    AND Dossier.DateDuSinistre = '2020-05-20'
);

/*Liste des hôtels qui ont hébergé M. IVANOVITCH (sinistre du 20/05/2020)*/
SELECT COUNT(*) AS TotalNuitees
FROM Heberger
WHERE numRapatriement IN (
    SELECT numRapatriement
    FROM Rapatriement
    JOIN Dossier ON Rapatriement.numRapatriement = Dossier.numSinistre
    JOIN Adherent ON Dossier.numSinistre = Adherent.numAdherent
    WHERE Adherent.nomAdherent = 'IVANOVITCH'
    AND Dossier.DateDuSinistre = '2020-05-20'
);

/*Liste ordonnée des trajets du rapatriement du couple BELKACEM (sinistre du 03/06/2020)*/
SELECT * 
FROM Rapatriement
WHERE numRapatriement IN (
    SELECT numRapatriement
    FROM Dossier
    WHERE DateDuSinistre = '2020-06-03'
);

/*Montant total dépensé pour le rapatriement du couple BELKACEM (sinistre du 03/06/2020)*/
SELECT SUM(CoutRapatriement) AS MontantTotalDepense
FROM Rapatriement
WHERE numRapatriement IN (
    SELECT numRapatriement
    FROM Dossier
    WHERE DateDuSinistre = '2020-06-03'
);



