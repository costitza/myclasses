-- =====================================================================
-- Sisteme avansate de baze de date | Întâlnirea 2
-- 01_pregatire.sql : pregătește obiectele necesare laboratorului 2
--   - coloana VECHIME în emp_<sufix>
--   - tabelele org_tab_<sufix>, mesaje_<sufix>, bonus_<sufix>
-- Rulare în SQL Developer: F5 (Run Script). Scriptul poate fi rulat de mai multe ori.
-- Cerință: copiile din Întâlnirea 1 (01_init_tabele.sql) există deja.
-- =====================================================================
SET DEFINE ON
SET VERIFY OFF
SET SERVEROUTPUT ON

-- !!! Același sufix ca în Întâlnirea 1
DEFINE sufix = raul

-- 1. Verificarea cerințelor preliminare
BEGIN
  DECLARE
    v_nr NUMBER;
  BEGIN
    SELECT COUNT(*) INTO v_nr
    FROM   user_tables
    WHERE  table_name IN ('EMP_'||UPPER('&sufix'), 'DEP_'||UPPER('&sufix'), 'LOC_'||UPPER('&sufix'));
    IF v_nr < 3 THEN
      RAISE_APPLICATION_ERROR(-20001,
        'Lipsesc copiile de lucru. Rulati mai intai 01_init_tabele.sql din Intalnirea 1 (sufix &sufix).');
    END IF;
  END;
END;
/

-- 2. Coloana VECHIME (ORA-01430 = coloana există deja, se ignoră)
BEGIN
  EXECUTE IMMEDIATE 'ALTER TABLE emp_&sufix ADD (vechime VARCHAR2(200))';
EXCEPTION
  WHEN OTHERS THEN
    IF SQLCODE != -1430 THEN RAISE; END IF;
END;
/

-- 3. Ștergerea tabelelor de lucru anterioare (ORA-00942 = nu există, se ignoră)
BEGIN
  FOR t IN (SELECT column_value AS nume
            FROM   TABLE(sys.odcivarchar2list('ORG_TAB', 'MESAJE', 'BONUS'))) LOOP
    BEGIN
      EXECUTE IMMEDIATE 'DROP TABLE ' || t.nume || '_&sufix PURGE';
    EXCEPTION
      WHEN OTHERS THEN
        IF SQLCODE != -942 THEN RAISE; END IF;
    END;
  END LOOP;
END;
/

-- 4. Crearea tabelelor
CREATE TABLE org_tab_&sufix (
  cod_tab  INTEGER       PRIMARY KEY,
  text_tab VARCHAR2(100)
);

CREATE TABLE mesaje_&sufix (
  rezultate VARCHAR2(100)
);

CREATE TABLE bonus_&sufix (
  id_bonus    NUMBER GENERATED ALWAYS AS IDENTITY,
  employee_id NUMBER(6)    NOT NULL,
  valoare     NUMBER(10,2) NOT NULL,
  CONSTRAINT fk_bonus_emp_&sufix FOREIGN KEY (employee_id) REFERENCES emp_&sufix (employee_id)
);

PROMPT >>> Pregătirea pentru Întâlnirea 2 este încheiată. Rulați 02_verificare.sql.
