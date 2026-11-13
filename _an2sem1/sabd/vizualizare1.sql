-- =====================================================================
-- Sisteme avansate de baze de date | Întâlnirea 3
-- 01_pregatire.sql : pregătește obiectele necesare laboratorului 3
--   - verifică cerințele preliminare (întâlnirile 1 și 2)
--   - curăță rânduri rămase din exerciții (angajații 400, 401, departamentul 300)
--   - creează tabelul retired_emps_<sufix> (arhiva de angajați)
-- Rulare în SQL Developer: F5 (Run Script). Poate fi rulat de mai multe ori.
-- =====================================================================
SET DEFINE ON
SET VERIFY OFF
SET SERVEROUTPUT ON

-- !!! Același sufix ca în întâlnirile anterioare
DEFINE sufix = pnu

-- 1. Cerințe preliminare: copiile din întâlnirea 1 și coloana vechime din întâlnirea 2
DECLARE
  v_nr NUMBER;
BEGIN
  SELECT COUNT(*) INTO v_nr
  FROM   user_tables
  WHERE  table_name IN ('EMP_'||UPPER('&sufix'), 'DEP_'||UPPER('&sufix'), 'JOBS_'||UPPER('&sufix'));
  IF v_nr < 3 THEN
    RAISE_APPLICATION_ERROR(-20001,
      'Lipsesc copiile de lucru. Rulati 01_init_tabele.sql din Intalnirea 1 (sufix &sufix).');
  END IF;
END;
/

-- 2. Curățarea rândurilor de test (dacă există)
DELETE FROM emp_&sufix WHERE employee_id IN (400, 401);
DELETE FROM dep_&sufix WHERE department_id = 300;
COMMIT;

-- 3. Tabelul retired_emps (structura din exemplul de curs) - recreat la fiecare rulare
BEGIN
  EXECUTE IMMEDIATE 'DROP TABLE retired_emps_&sufix PURGE';
EXCEPTION
  WHEN OTHERS THEN
    IF SQLCODE != -942 THEN RAISE; END IF;
END;
/

CREATE TABLE retired_emps_&sufix (
  empno     NUMBER(6)    PRIMARY KEY,
  ename     VARCHAR2(25) NOT NULL,
  job       VARCHAR2(10),
  mgr       NUMBER(6),
  hiredate  DATE,
  leavedate DATE,
  sal       NUMBER(8,2),
  comm      NUMBER(2,2),
  deptno    NUMBER(4)
);

PROMPT >>> Pregătirea pentru Întâlnirea 3 este încheiată. Rulați 02_verificare.sql.