declare
    v_nume dep_raul.department_name%TYPE := &p_nume;
    v_cod dep_raul.department_id%TYPE := &g_max_dep + 10;
    
begin 
    insert into dep_raul (department_id, department_name, location_id)
    values (v_cod, v_nume, NULL);
    
    DBMS_OUTPUT.PUT_LINE(SQL%ROWCOUNT);
    
    
end;
/

SET SERVEROUTPUT ON;

DECLARE
    v_dept_id   dep_pnu.department_id%TYPE := &p_dept_id;
    v_loc_id    dep_pnu.location_id%TYPE   := &p_loc_id;
    v_dept_name dep_pnu.department_name%TYPE;
BEGIN
    UPDATE dep_pnu
    SET location_id = v_loc_id
    WHERE department_id = v_dept_id
    RETURNING department_name INTO v_dept_name;

    IF SQL%NOTFOUND THEN
        DBMS_OUTPUT.PUT_LINE('Departamentul cu codul ' || v_dept_id || ' nu exista.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Cod: ' || v_dept_id || 
                             ' | Nume: ' || v_dept_name || 
                             ' | Locatie noua: ' || v_loc_id);
    END IF;
END;
/


SET SERVEROUTPUT ON;    

DECLARE
    v_dept_id dep_pnu.department_id%TYPE := &p_dept_id;
BEGIN
    DELETE FROM dep_pnu
    WHERE department_id = v_dept_id;

    DBMS_OUTPUT.PUT_LINE('Numar de linii sterse: ' || SQL%ROWCOUNT);

    ROLLBACK;
    DBMS_OUTPUT.PUT_LINE('S-a efectuat ROLLBACK.');
END;
/



SET SERVEROUTPUT ON;

DECLARE
    v_dept_id  emp_pnu.department_id%TYPE := &p_dept_id;
    v_avg_sal  emp_pnu.salary%TYPE;
    v_count    PLS_INTEGER := 0;
BEGIN
    -- 1. Calculam media salariilor in variabila
    SELECT AVG(salary)
    INTO v_avg_sal
    FROM emp_pnu
    WHERE department_id = v_dept_id;

    -- Daca departamentul nu are angajati, AVG returneaza NULL
    IF v_avg_sal IS NULL THEN
        DBMS_OUTPUT.PUT_LINE('Departamentul ' || v_dept_id || ' nu are angajati.');
    ELSE
        -- 2. Stergem bonusurile anterioare ale angajatilor din acest departament
        DELETE FROM bonus_pnu
        WHERE employee_id IN (
            SELECT employee_id 
            FROM emp_pnu 
            WHERE department_id = v_dept_id
        );

        -- 3. Inseram noile bonusuri printr-un singur INSERT ... SELECT cu CASE
        INSERT INTO bonus_pnu (employee_id, bonus)
        SELECT employee_id,
               CASE 
                   WHEN salary >= v_avg_sal THEN salary * 0.10
                   ELSE salary * 0.05
               END
        FROM emp_pnu
        WHERE department_id = v_dept_id;

        v_count := SQL%ROWCOUNT;
        DBMS_OUTPUT.PUT_LINE('Salariul mediu: ' || ROUND(v_avg_sal, 2));
        DBMS_OUTPUT.PUT_LINE('Numar de bonusuri acordate: ' || v_count);
    END IF;
END;
/



