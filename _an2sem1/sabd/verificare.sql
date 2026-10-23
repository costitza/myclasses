SELECT SYS_CONTEXT('USERENV','CON_NAME')     AS container,
       SYS_CONTEXT('USERENV','SESSION_USER') AS utilizator
FROM   dual;
 
SELECT banner_full FROM v$version;
 
 
 
 
-------------------------------------------------------------------
 
-- =====================================================================
-- Sisteme avansate de baze de date | Întâlnirea 1
-- 02_verificare.sql : compară copiile <tabel>_<sufix> cu tabelele HR originale
-- Rulare în SQL Developer: F5 (Run Script). Toate liniile trebuie să aibă OK.
-- =====================================================================
SET DEFINE ON
SET VERIFY OFF
 
-- !!! Același sufix ca în 01_init_tabele.sql
DEFINE sufix = raul
 
-- 1. Numărul de linii: original vs. copie
SELECT 'REGIONS'      AS tabel, (SELECT COUNT(*) FROM regions)      AS linii_original, (SELECT COUNT(*) FROM regions_&sufix)      AS linii_copie,
       CASE WHEN (SELECT COUNT(*) FROM regions)      = (SELECT COUNT(*) FROM regions_&sufix)      THEN 'OK' ELSE 'EROARE' END AS stare FROM dual
UNION ALL
SELECT 'COUNTRIES',   (SELECT COUNT(*) FROM countries),   (SELECT COUNT(*) FROM countries_&sufix),
       CASE WHEN (SELECT COUNT(*) FROM countries)   = (SELECT COUNT(*) FROM countries_&sufix)   THEN 'OK' ELSE 'EROARE' END FROM dual
UNION ALL
SELECT 'LOCATIONS',   (SELECT COUNT(*) FROM locations),   (SELECT COUNT(*) FROM loc_&sufix),
       CASE WHEN (SELECT COUNT(*) FROM locations)   = (SELECT COUNT(*) FROM loc_&sufix)         THEN 'OK' ELSE 'EROARE' END FROM dual
UNION ALL
SELECT 'DEPARTMENTS', (SELECT COUNT(*) FROM departments), (SELECT COUNT(*) FROM dep_&sufix),
       CASE WHEN (SELECT COUNT(*) FROM departments) = (SELECT COUNT(*) FROM dep_&sufix)         THEN 'OK' ELSE 'EROARE' END FROM dual
UNION ALL
SELECT 'JOBS',        (SELECT COUNT(*) FROM jobs),        (SELECT COUNT(*) FROM jobs_&sufix),
       CASE WHEN (SELECT COUNT(*) FROM jobs)        = (SELECT COUNT(*) FROM jobs_&sufix)        THEN 'OK' ELSE 'EROARE' END FROM dual
UNION ALL
SELECT 'EMPLOYEES',   (SELECT COUNT(*) FROM employees),   (SELECT COUNT(*) FROM emp_&sufix),
       CASE WHEN (SELECT COUNT(*) FROM employees)   = (SELECT COUNT(*) FROM emp_&sufix)         THEN 'OK' ELSE 'EROARE' END FROM dual
UNION ALL
SELECT 'JOB_HISTORY', (SELECT COUNT(*) FROM job_history), (SELECT COUNT(*) FROM job_history_&sufix),
       CASE WHEN (SELECT COUNT(*) FROM job_history) = (SELECT COUNT(*) FROM job_history_&sufix) THEN 'OK' ELSE 'EROARE' END FROM dual
UNION ALL
SELECT 'JOB_GRADES',  (SELECT COUNT(*) FROM job_grades),  (SELECT COUNT(*) FROM job_grades_&sufix),
       CASE WHEN (SELECT COUNT(*) FROM job_grades)  = (SELECT COUNT(*) FROM job_grades_&sufix)  THEN 'OK' ELSE 'EROARE' END FROM dual
UNION ALL
SELECT 'PROJECTS',    (SELECT COUNT(*) FROM projects),    (SELECT COUNT(*) FROM projects_&sufix),
       CASE WHEN (SELECT COUNT(*) FROM projects)    = (SELECT COUNT(*) FROM projects_&sufix)    THEN 'OK' ELSE 'EROARE' END FROM dual
UNION ALL
SELECT 'WORKS_ON',    (SELECT COUNT(*) FROM works_on),    (SELECT COUNT(*) FROM works_on_&sufix),
       CASE WHEN (SELECT COUNT(*) FROM works_on)    = (SELECT COUNT(*) FROM works_on_&sufix)    THEN 'OK' ELSE 'EROARE' END FROM dual;
 
-- 2. Constrângeri pe tipuri (așteptat: P=9, R=13, U=1; C = NOT NULL moștenite + 2 CHECK explicite)
SELECT constraint_type AS tip,
       COUNT(*)        AS nr_constrangeri,
       CASE constraint_type WHEN 'P' THEN 'cheie primară'
                            WHEN 'R' THEN 'cheie externă'
                            WHEN 'U' THEN 'unicitate'
                            WHEN 'C' THEN 'CHECK / NOT NULL' END AS semnificatie
FROM   user_constraints
WHERE  table_name IN ('REGIONS_'||UPPER('&sufix'),'COUNTRIES_'||UPPER('&sufix'),'LOC_'||UPPER('&sufix'),
                      'DEP_'||UPPER('&sufix'),'JOBS_'||UPPER('&sufix'),'EMP_'||UPPER('&sufix'),
                      'JOB_HISTORY_'||UPPER('&sufix'),'PROJECTS_'||UPPER('&sufix'),'WORKS_ON_'||UPPER('&sufix'))
GROUP  BY constraint_type
ORDER  BY constraint_type;
 
-- 3. Cheile externe trebuie să fie activate (ENABLED) și validate
SELECT table_name, constraint_name, status, validated
FROM   user_constraints
WHERE  constraint_type = 'R'
AND    (status <> 'ENABLED' OR validated <> 'VALIDATED')
AND    table_name LIKE '%\_'||UPPER('&sufix') ESCAPE '\';
-- (rezultat așteptat: nicio linie)
 