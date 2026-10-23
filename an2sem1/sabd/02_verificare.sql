-- =====================================================================
-- Sisteme avansate de baze de date | Întâlnirea 2
-- 02_verificare.sql : verifică obiectele create de 01_pregatire.sql
-- Rulare în SQL Developer: F5. Toate liniile trebuie să aibă starea OK.
-- =====================================================================
SET DEFINE ON
SET VERIFY OFF

-- !!! Același sufix ca în 01_pregatire.sql
DEFINE sufix = raul

SELECT 'Tabel ORG_TAB' AS verificare,
       CASE WHEN COUNT(*) = 1 THEN 'OK' ELSE 'LIPSA' END AS stare
FROM   user_tables WHERE table_name = 'ORG_TAB_' || UPPER('&sufix')
UNION ALL
SELECT 'Tabel MESAJE',
       CASE WHEN COUNT(*) = 1 THEN 'OK' ELSE 'LIPSA' END
FROM   user_tables WHERE table_name = 'MESAJE_' || UPPER('&sufix')
UNION ALL
SELECT 'Tabel BONUS (cu IDENTITY)',
       CASE WHEN COUNT(*) = 1 THEN 'OK' ELSE 'LIPSA' END
FROM   user_tab_identity_cols WHERE table_name = 'BONUS_' || UPPER('&sufix')
UNION ALL
SELECT 'Coloana EMP.VECHIME VARCHAR2(200)',
       CASE WHEN COUNT(*) = 1 THEN 'OK' ELSE 'LIPSA' END
FROM   user_tab_columns
WHERE  table_name = 'EMP_' || UPPER('&sufix') AND column_name = 'VECHIME'
AND    data_type = 'VARCHAR2' AND char_length = 200
UNION ALL
SELECT 'Angajați în EMP (așteptat 107)',
       CASE WHEN COUNT(*) = 107 THEN 'OK' ELSE 'DIFERA: ' || COUNT(*) END
FROM   emp_&sufix
UNION ALL
SELECT 'Departamente în DEP (așteptat 27 înainte de exerciții)',
       CASE WHEN COUNT(*) = 27 THEN 'OK' ELSE 'DIFERA: ' || COUNT(*) END
FROM   dep_&sufix;
-- Dacă ultimele două linii arată DIFERA după ce ați lucrat, este normal; pentru
-- resetare rulați din nou 01_init_tabele.sql (Întâlnirea 1) și apoi 01_pregatire.sql.
