-- ex 1
SELECT 
    p.oras, 
    COUNT(DISTINCT r.id_client) AS numar_clienti
FROM PROPRIETATI p
JOIN REZERVARI r ON p.id_proprietate = r.id_proprietate
WHERE LOWER(r.status) = 'confirmata'
GROUP BY p.oras;



-- ex 2
SELECT c.id_client, c.nume
FROM CLIENTI c
WHERE c.id_client IN (
    SELECT id_client
    FROM REVIEWS
    WHERE rating >= 2
    GROUP BY id_client
    HAVING COUNT(id_review) >= 3
)
AND c.id_client IN (
    SELECT r.id_client
    FROM REZERVARI r
    JOIN PLATI p ON r.id_rezervare = p.id_rezervare
    GROUP BY r.id_client
    HAVING COUNT(p.id_plata) > 0 
       AND COUNT(CASE WHEN LOWER(p.metoda) != 'cash' THEN 1 END) = 0
);



-- ex 3
WITH N_Proprietati AS (
    SELECT COUNT(DISTINCT id_proprietate) AS valoare_n
    FROM REZERVARI
    WHERE EXTRACT(YEAR FROM data_check_in) = 2025
),
CheltuieliClienti AS (
    SELECT 
        c.id_client, 
        c.nume,
        SUM((r.data_check_out - r.data_check_in) * p.pret_per_noapte) AS total_cheltuieli
    FROM CLIENTI c
    JOIN REZERVARI r ON c.id_client = r.id_client
    JOIN PROPRIETATI p ON r.id_proprietate = p.id_proprietate
    GROUP BY c.id_client, c.nume
),
ClasamentClienti AS (
    SELECT 
        id_client, 
        nume, 
        total_cheltuieli,
        ROW_NUMBER() OVER (ORDER BY total_cheltuieli DESC) AS rnk
    FROM CheltuieliClienti
)
SELECT id_client, nume
FROM ClasamentClienti
WHERE rnk <= (SELECT valoare_n FROM N_Proprietati);