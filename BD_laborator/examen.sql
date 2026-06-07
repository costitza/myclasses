
SELECT
    id_angajat,
    nume,
    (
        SELECT
            COUNT(id_contract)
        FROM CONTRACTE c
        WHERE c.ID_ANGAJAT = a.id_angajat
    ) as nr_contracte,
    (
        SELECT
            COUNT(id_declaratie)
        FROM DECLARATII_FISCALE df
        WHERE df.id_angajat = a.id_angajat
    ) as nr_declaratii
FROM ANGAJATI a;



CREATE TABLE DETALII(
    id_contract NUMBER,
    id_serviciu NUMBER,

    CONSTRAINT pk_detalii PRIMARY KEY(id_contract, id_serviciu),

    CONSTRAINT fk_id_contract FOREIGN KEY(id_contract) REFERENCES CONTRACTE(id_contract),
    CONSTRAINT fk_id_serviciu FOREIGN KEY(id_serviciu) REFERENCES SERVICII(id_serviciu)
);



-- 2
SELECT
    a.NUME || ' ' || a.PRENUME as nume_complet,
    COUNT(c.ID_CONTRACT) as total_contracte
FROM ANGAJATI a
JOIN CONTRACTE c on a.id_angajat = c.id_angajat
GROUP BY a.NUME, a.PRENUME
HAVING COUNT(c.ID_CONTRACT) > 2;



-- 3
SELECT
    c.nume_companie
FROM CLIENTI c
WHERE NOT EXISTS (
    SELECT 1
    FROM CONTRACTE ct
    WHERE ct.ID_CLIENT = c.ID_CLIENT
);



-- 4
SELECT
    d.DENUMIRE_DEPT,
    SUM(c.valoare_totala) as valoare
FROM DEPARTAMENTE d
JOIN ANGAJATI a ON d.ID_DEPARTAMENT = a.ID_DEPARTAMENT
JOIN CONTRACTE c ON a.id_angajat = c.id_angajat
GROUP BY d.DENUMIRE_DEPT;


-- create
CREATE TABLE VECTOR(
    id_vector NUMBER PRIMARY KEY,
    id_client NUMBER UNIQUE,

    CONSTRAINT fk_id_client FOREIGN KEY(id_client) REFERENCES CLIENTI(id_client)
);



-- 5
SELECT
    a.NUME,
    a.SALARIU,
    a.ID_DEPARTAMENT
FROM ANGAJATI a
WHERE a.SALARIU > (
    SELECT AVG(aux.SALARIU)
    FROM ANGAJATI aux
    WHERE aux.ID_DEPARTAMENT = a.ID_DEPARTAMENT
);


-- 6
SELECT
    a.NUME,
    COUNT(c.ID_CONTRACT) as numar_contracte,
    SUM(CASE WHEN c.STATUS_CONTRACT = 'Activ' THEN 1 ELSE 0 END) as contracte_active
FROM ANGAJATI a
JOIN CONTRACTE c ON a.id_angajat = c.id_angajat
GROUP BY a.NUME;


-- 7
SELECT
    d.ID_DEPARTAMENT,
    d.DENUMIRE_DEPT,
    SUM(c.VALOARE_TOTALA) as suma_maxima
FROM DEPARTAMENTE d
JOIN ANGAJATI a ON a.ID_DEPARTAMENT = d.ID_DEPARTAMENT
JOIN CONTRACTE c ON a.ID_ANGAJAT = c.ID_ANGAJAT
GROUP BY d.ID_DEPARTAMENT, d.DENUMIRE_DEPT
ORDER BY suma_maxima DESC
FETCH FIRST 1 ROWS WITH TIES;

