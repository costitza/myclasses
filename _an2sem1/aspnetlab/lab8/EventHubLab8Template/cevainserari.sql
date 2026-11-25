USE EventHubLab8DB;
GO

-- 1. Adăugăm 3 categorii
INSERT INTO Categories (CategoryName) 
VALUES 
    ('Concert'), 
    ('Workshop'), 
    ('Conferinta');
GO

-- Preluăm ID-urile reale ale categoriilor (pentru a evita erori de Foreign Key)
DECLARE @Cat1 INT = (SELECT Id FROM Categories WHERE CategoryName = 'Concert');
DECLARE @Cat2 INT = (SELECT Id FROM Categories WHERE CategoryName = 'Workshop');
DECLARE @Cat3 INT = (SELECT Id FROM Categories WHERE CategoryName = 'Conferinta');

-- 2. Adăugăm 3 evenimente (cu date din viitor, conform validării din laborator)
INSERT INTO Events (Title, Description, Date, Location, CategoryId) 
VALUES 
    ('Rock Fest 2026', 'Concert rock in aer liber cu trupe locale.', '2026-12-10 19:00:00', 'Arenele Romane', @Cat1),
    ('Workshop ASP.NET Core', 'Sesiune practica de dezvoltare web si validari.', '2026-12-15 16:00:00', 'Facultatea de Matematica si Informatica', @Cat2),
    ('Tech Summit Bucuresti', 'Conferinta anuala despre cloud si inteligenta artificiala.', '2027-01-20 09:30:00', 'Romexpo', @Cat3);
GO

-- Preluăm ID-urile reale ale evenimentelor tocmai inserate
DECLARE @Ev1 INT = (SELECT TOP 1 Id FROM Events WHERE Title = 'Rock Fest 2026');
DECLARE @Ev2 INT = (SELECT TOP 1 Id FROM Events WHERE Title = 'Workshop ASP.NET Core');

-- 3. Adăugăm 3 recenzii asociate evenimentelor
INSERT INTO Reviews (Content, Date, EventId) 
VALUES 
    ('Atmosfera extraordinara si sunet impecabil!', GETDATE(), @Ev1),
    ('Abia astept editia de anul acesta!', GETDATE(), @Ev1),
    ('Foarte bine structurat, exemple clare si utile.', GETDATE(), @Ev2);
GO

-- Verificăm datele inserate
SELECT * FROM Categories;
SELECT * FROM Events;
SELECT * FROM Reviews;
GO
