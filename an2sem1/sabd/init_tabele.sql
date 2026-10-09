-- =====================================================================
-- Sisteme avansate de baze de date | Întâlnirea 1
-- 01_init_tabele.sql : creează copiile de lucru <tabel>_<sufix> din schema HR
-- Rulare în SQL Developer: deschideți fișierul și apăsați F5 (Run Script).
-- Scriptul este idempotent: șterge copiile existente și le recreează,
-- deci poate fi folosit și pentru RESETAREA tabelelor la starea inițială.
-- Cerință: tabelele HR originale (hr_create.sql) există în aceeași schemă.
-- =====================================================================
SET DEFINE ON
SET VERIFY OFF
SET FEEDBACK ON
 
-- !!! Înlocuiți 'pnu' cu sufixul vostru personal (litere/cifre, fără spații)
DEFINE sufix = raul
 
-- ---------- 1. Ștergerea copiilor existente (ignoră ORA-00942) ----------
BEGIN
  FOR t IN (SELECT column_value AS nume FROM TABLE(sys.odcivarchar2list(
              'WORKS_ON','PROJECTS','JOB_HISTORY','EMP','DEP','JOBS','LOC',
              'COUNTRIES','REGIONS','JOB_GRADES','BONUS'))) LOOP
    BEGIN
      EXECUTE IMMEDIATE 'DROP TABLE ' || t.nume || '_&sufix CASCADE CONSTRAINTS PURGE';
    EXCEPTION WHEN OTHERS THEN
      IF SQLCODE != -942 THEN RAISE; END IF;
    END;
  END LOOP;
  BEGIN
    EXECUTE IMMEDIATE 'DROP VIEW viz_emp_dep_&sufix';
  EXCEPTION WHEN OTHERS THEN
    IF SQLCODE != -942 THEN RAISE; END IF;
  END;
END;
/
 
-- ---------- 2. Crearea copiilor (CTAS: date + NOT NULL, fără PK/FK/CHECK) ----------
CREATE TABLE regions_&sufix     AS SELECT * FROM regions;
CREATE TABLE countries_&sufix   AS SELECT * FROM countries;
CREATE TABLE loc_&sufix         AS SELECT * FROM locations;
CREATE TABLE dep_&sufix         AS SELECT * FROM departments;
CREATE TABLE jobs_&sufix        AS SELECT * FROM jobs;
CREATE TABLE emp_&sufix         AS SELECT * FROM employees;
CREATE TABLE job_history_&sufix AS SELECT * FROM job_history;
CREATE TABLE job_grades_&sufix  AS SELECT * FROM job_grades;
CREATE TABLE projects_&sufix    AS SELECT * FROM projects;
CREATE TABLE works_on_&sufix    AS SELECT * FROM works_on;
 
-- ---------- 3. Constrângeri de cheie primară și unicitate ----------
ALTER TABLE regions_&sufix   ADD CONSTRAINT pk_regions_&sufix   PRIMARY KEY (region_id);
ALTER TABLE countries_&sufix ADD CONSTRAINT pk_countries_&sufix PRIMARY KEY (country_id);
ALTER TABLE loc_&sufix       ADD CONSTRAINT pk_loc_&sufix       PRIMARY KEY (location_id);
ALTER TABLE dep_&sufix       ADD CONSTRAINT pk_dep_&sufix       PRIMARY KEY (department_id);
ALTER TABLE jobs_&sufix      ADD CONSTRAINT pk_jobs_&sufix      PRIMARY KEY (job_id);
ALTER TABLE emp_&sufix       ADD CONSTRAINT pk_emp_&sufix       PRIMARY KEY (employee_id);
ALTER TABLE emp_&sufix       ADD CONSTRAINT uk_emp_email_&sufix UNIQUE (email);
ALTER TABLE job_history_&sufix ADD CONSTRAINT pk_jhist_&sufix   PRIMARY KEY (employee_id, start_date);
ALTER TABLE projects_&sufix  ADD CONSTRAINT pk_projects_&sufix  PRIMARY KEY (project_id);
ALTER TABLE works_on_&sufix  ADD CONSTRAINT pk_works_on_&sufix  PRIMARY KEY (project_id, employee_id);
 
-- ---------- 4. Chei externe ----------
ALTER TABLE countries_&sufix ADD CONSTRAINT fk_ctry_reg_&sufix
  FOREIGN KEY (region_id) REFERENCES regions_&sufix (region_id);
ALTER TABLE loc_&sufix ADD CONSTRAINT fk_loc_ctry_&sufix
  FOREIGN KEY (country_id) REFERENCES countries_&sufix (country_id);
ALTER TABLE dep_&sufix ADD CONSTRAINT fk_dep_loc_&sufix
  FOREIGN KEY (location_id) REFERENCES loc_&sufix (location_id);
ALTER TABLE emp_&sufix ADD CONSTRAINT fk_emp_dep_&sufix
  FOREIGN KEY (department_id) REFERENCES dep_&sufix (department_id);
ALTER TABLE emp_&sufix ADD CONSTRAINT fk_emp_job_&sufix
  FOREIGN KEY (job_id) REFERENCES jobs_&sufix (job_id);
ALTER TABLE emp_&sufix ADD CONSTRAINT fk_emp_mgr_&sufix
  FOREIGN KEY (manager_id) REFERENCES emp_&sufix (employee_id);
ALTER TABLE dep_&sufix ADD CONSTRAINT fk_dep_mgr_&sufix
  FOREIGN KEY (manager_id) REFERENCES emp_&sufix (employee_id);
ALTER TABLE job_history_&sufix ADD CONSTRAINT fk_jhist_emp_&sufix
  FOREIGN KEY (employee_id) REFERENCES emp_&sufix (employee_id);
ALTER TABLE job_history_&sufix ADD CONSTRAINT fk_jhist_job_&sufix
  FOREIGN KEY (job_id) REFERENCES jobs_&sufix (job_id);
ALTER TABLE job_history_&sufix ADD CONSTRAINT fk_jhist_dep_&sufix
  FOREIGN KEY (department_id) REFERENCES dep_&sufix (department_id);
ALTER TABLE projects_&sufix ADD CONSTRAINT fk_proj_mgr_&sufix
  FOREIGN KEY (project_manager) REFERENCES emp_&sufix (employee_id);
ALTER TABLE works_on_&sufix ADD CONSTRAINT fk_works_proj_&sufix
  FOREIGN KEY (project_id) REFERENCES projects_&sufix (project_id);
ALTER TABLE works_on_&sufix ADD CONSTRAINT fk_works_emp_&sufix
  FOREIGN KEY (employee_id) REFERENCES emp_&sufix (employee_id);
 
-- ---------- 5. Constrângeri CHECK ----------
ALTER TABLE emp_&sufix ADD CONSTRAINT ck_emp_sal_&sufix CHECK (salary > 0);
ALTER TABLE job_history_&sufix ADD CONSTRAINT ck_jhist_dates_&sufix CHECK (end_date > start_date);
 
COMMIT;
 
PROMPT >>> Copiile de lucru cu sufixul &sufix au fost create. Rulați 02_verificare.sql.