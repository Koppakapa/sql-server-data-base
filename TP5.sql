USE TeamBuilders
GO
DROP TABLE IF EXISTS equipe_has_personne
GO
DROP TABLE IF EXISTS equipe
GO
DROP TABLE IF EXISTS personne
GO

CREATE TABLE [personne] (
  [id] int PRIMARY KEY IDENTITY(1, 1),
  [nom] varchar(255) NOT NULL,
  [prenom] varchar(255) NOT NULL
)
GO

CREATE TABLE [equipe] (
  [id] int PRIMARY KEY IDENTITY(1, 1),
  [nom] varchar(255) NOT NULL,
  [projet] varchar(255) NOT NULL,
  [personne_id] int
)
GO

CREATE TABLE [equipe_has_personne] (
  [personne_id] int,
  [equipe_id] int,
  PRIMARY KEY ([personne_id], [equipe_id])
)
GO

ALTER TABLE [equipe] ADD FOREIGN KEY ([personne_id]) REFERENCES [personne] ([id])
GO

ALTER TABLE [equipe_has_personne] ADD FOREIGN KEY ([equipe_id]) REFERENCES [equipe] ([id])
GO

ALTER TABLE [equipe_has_personne] ADD FOREIGN KEY ([personne_id]) REFERENCES [personne] ([id])
GO


INSERT INTO personne (nom, prenom) VALUES ('Brad', 'Pitt');
INSERT INTO personne (nom, prenom) VALUES ('Bruce', 'Willis');
INSERT INTO personne (nom, prenom) VALUES ('Nicolas', 'Cage');

INSERT INTO personne (nom, prenom) VALUES ('Angelina', 'Jolie');
INSERT INTO personne (nom, prenom) VALUES ('Tom', 'Cruise');
INSERT INTO personne (nom, prenom) VALUES ('Tom', 'Hanks');

INSERT INTO personne (nom, prenom) VALUES ('Bob', 'Dylan');
INSERT INTO personne (nom, prenom) VALUES ('Johnny', 'Cash');
INSERT INTO personne (nom, prenom) VALUES ('Jimmy', 'Hendrix');
GO

INSERT INTO equipe (nom, projet, personne_id) VALUES ('Team A', 'Projet site internet Marie', 1);
INSERT INTO equipe (nom, projet, personne_id) VALUES ('Team B', 'Projet CRM', 2);
INSERT INTO equipe (nom, projet, personne_id) VALUES ('Team C', 'Projet ERP', 3);
GO

INSERT INTO equipe_has_personne(personne_id, equipe_id) VALUES (1, 1);
INSERT INTO equipe_has_personne(personne_id, equipe_id) VALUES (2, 1);
INSERT INTO equipe_has_personne(personne_id, equipe_id) VALUES (3, 1);
INSERT INTO equipe_has_personne(personne_id, equipe_id) VALUES (4, 2);
INSERT INTO equipe_has_personne(personne_id, equipe_id) VALUES (5, 2);
INSERT INTO equipe_has_personne(personne_id, equipe_id) VALUES (6, 2);
INSERT INTO equipe_has_personne(personne_id, equipe_id) VALUES (7, 3);
INSERT INTO equipe_has_personne(personne_id, equipe_id) VALUES (8, 3);
INSERT INTO equipe_has_personne(personne_id, equipe_id) VALUES (9, 3);
GO



SELECT * FROM equipe WHERE id = 3;


SELECT * FROM equipe;
