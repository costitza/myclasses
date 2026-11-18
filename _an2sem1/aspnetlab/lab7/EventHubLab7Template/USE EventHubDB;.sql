USE EventHubDB;
GO

-- 1. Verifică dacă există categorii; dacă nu, adaugă una
IF NOT EXISTS (SELECT 1 FROM Categories)
BEGIN
    INSERT INTO Categories (CategoryName) VALUES ('Concert'), ('Workshop'), ('Hackathon');
END
GO

-- 2. Ia primul CategoryId valid existent în tabel
DECLARE @CatId INT = (SELECT TOP 1 Id FROM Categories);

-- 3. Inserează evenimentul folosind @CatId garantat valid
INSERT INTO Events (Title, Description, Date, Location, CategoryId)
VALUES ('Rock Fest 2026', 'Concert rock in aer liber', '2026-12-15 19:00:00', 'Arenele Romane', @CatId);

-- 4. Ia exact Id-ul evenimentului tocmai inserat (SCOPE_IDENTITY)
DECLARE @EvId INT = SCOPE_IDENTITY();

-- 5. Inserează recenzia folosind @EvId garantat valid
INSERT INTO Reviews (Content, Date, EventId)
VALUES ('Organizare impecabila si sunet excelent!', GETDATE(), @EvId);
GO

-- Verifică ce s-a inserat
SELECT * FROM Categories;
SELECT * FROM Events;
SELECT * FROM Reviews;
GO