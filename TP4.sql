/*
TP4 "SELECT"
Afficher les factures à partir d'un client_id
Afficher le client qui a le plus de factures
Calculer le montant total facturé pour un Client
Afficher le nombre de devis par client
Calculer le CA 

Calculer le montant des factures en attente de paiement
Calculer les factures en retard de paiement
*/


USE DEVIS
GO
DROP TABLE Facture
GO
DROP TABLE Devis
GO
DROP TABLE Projet
GO
DROP TABLE Client
GO

CREATE TABLE [Client] (
  [idClient] int PRIMARY KEY IDENTITY(1, 1),
  [nom] nvarchar(100) NOT NULL
)
GO

CREATE TABLE [Projet] (
  [idProjet] int PRIMARY KEY IDENTITY(1, 1),
  [nom] nvarchar(200) NOT NULL,
  [client_id] int NOT NULL
)
GO

CREATE TABLE [Devis] (
  [idDevis] int PRIMARY KEY IDENTITY(1, 1),
  [version] int NOT NULL,
  [reference] nvarchar(10) NOT NULL,
  [prix] float NOT NULL,
  [projet_id] int NOT NULL
)
GO

CREATE TABLE [Facture] (
  [idFacture] int PRIMARY KEY IDENTITY(1, 1),
  [reference] nvarchar(20) NOT NULL,
  [info] nvarchar(100) NOT NULL,
  [total] float NOT NULL,
  [date_crea] date NOT NULL,
  [data_paiement] date,
  [devis_id] int NOT NULL
)
GO


ALTER TABLE [Projet] ADD FOREIGN KEY ([client_id]) REFERENCES [Client] ([idClient])
GO

ALTER TABLE [Devis] ADD FOREIGN KEY ([projet_id]) REFERENCES [Projet] ([idProjet])
GO

ALTER TABLE [Facture] ADD FOREIGN KEY ([devis_id]) REFERENCES [Devis] ([idDevis])
GO

INSERT INTO Client (nom) VALUES ('Mairie de Rennes'), ('Neo Soft'), ('Sopra'), ('Accenture'), ('Amazon')
GO
INSERT INTO Projet (nom, client_id) VALUES ('Creation de site internet',1), ('Logiciel CRM',2), ('logiciel ERP',2), ('Logiciel de devis',3), ('Site internet ecommerce',4), ('logiciel Gestion de Stock',5)
GO


INSERT INTO Devis (version, reference, prix, projet_id) VALUES (1, 'DEV2100A', 3000, 1)
INSERT INTO Devis (version, reference, prix, projet_id) VALUES (2, 'DEV2100B', 5000, 1)
INSERT INTO Devis (version, reference, prix, projet_id) VALUES (1, 'DEV2100C', 5000, 2)
INSERT INTO Devis (version, reference, prix, projet_id) VALUES (1, 'DEV2100D', 3000, 3)
INSERT INTO Devis (version, reference, prix, projet_id) VALUES (1, 'DEV2100E', 5000, 4)
INSERT INTO Devis (version, reference, prix, projet_id) VALUES (1, 'DEV2100F', 2000, 5)
INSERT INTO Devis (version, reference, prix, projet_id) VALUES (1, 'DEV2100G', 1000, 6)


INSERT INTO Facture (reference, info, total, date_crea, data_paiement, devis_id) VALUES ('FA001', 'Site internet partie 1', 1500, '2023-09-01', '2023-10-01', 1)
INSERT INTO Facture (reference, info, total, date_crea, data_paiement, devis_id) VALUES ('FA002', 'Site internet partie 2', 1500, '2023-09-20', NULL, 2)
INSERT INTO Facture (reference, info, total, date_crea, data_paiement, devis_id) VALUES ('FA003', 'Logiciel CRM', 5000, '23-08-01', NULL, 3)
INSERT INTO Facture (reference, info, total, date_crea, data_paiement, devis_id) VALUES ('FA004', 'Logiciel devis', 3000, '2023-03-03', '2023-03-04', 5)
INSERT INTO Facture (reference, info, total, date_crea, data_paiement, devis_id) VALUES ('FA005', 'Site internet ecommerce', 5000, '2023-03-04', NULL, 6)
INSERT INTO Facture (reference, info, total, date_crea, data_paiement, devis_id) VALUES ('FA006', 'Logiciel ERP', 2000, '2023-04-05', NULL, 4)

SELECT * FROM Client INNER JOIN Projet ON Client.idClient = Projet.client_id INNER JOIN Devis ON Projet.idProjet = Devis.projet_id INNER JOIN Facture ON Devis.idDevis = Facture.devis_id 

/*Afficher les factures à partir d'un client_id*/
SELECT Client.idClient, Facture.reference, Facture.info, Facture.total, Facture.date_crea, Facture.data_paiement, Facture.devis_id FROM Client
INNER JOIN Projet ON Client.idClient = Projet.client_id
INNER JOIN Devis ON Projet.idProjet = Devis.projet_id
INNER JOIN Facture ON Devis.idDevis = Facture.devis_id
WHERE Client.idClient=1

/*Afficher le client qui a le plus de factures*/

SELECT TOP 1 c.idClient, c.nom, COUNT(f.idFacture) AS NumberOfInvoices
FROM Client c
JOIN Projet p ON c.idClient = p.client_id
JOIN Devis d ON p.idProjet = d.projet_id
JOIN Facture f ON d.idDevis = f.devis_id
GROUP BY c.idClient, c.nom
ORDER BY NumberOfInvoices DESC


/*Calculer le montant total facturé pour un Client*/

SELECT c.idClient, c.nom, SUM(f.total) as TotalFacture
FROM Client c
JOIN Projet p ON c.idClient = p.client_id
JOIN Devis d ON p.idProjet = d.projet_id
JOIN Facture f ON d.idDevis = f.devis_id
GROUP BY c.idClient, c.nom


/*Afficher le nombre de devis par client*/

SELECT c.idClient, c.nom, COUNT(d.idDevis) as NombreDeDevis
FROM Client c
JOIN Projet p ON c.idClient = p.client_id
JOIN Devis d ON p.idProjet = d.projet_id
GROUP BY c.idClient, c.nom


/*Calculer le CA */

SELECT SUM(total) as ChiffreDAffaires FROM Facture


/*Calculer le montant des factures en attente de paiement* (30 jours)*/

SELECT SUM(total) AS TotalImpaye
FROM Facture
WHERE data_paiement IS NULL AND DATEDIFF(day, date_crea, GETDATE()) >= 30


/*Calculer les factures en retard de paiement*/


SELECT COUNT(idFacture) AS Nombrefacture
FROM Facture
WHERE data_paiement IS NULL