DECLARE
    CURSOR c IS
        SELECT last_name, salary * 12 AS sal_anual
        FROM employees
        WHERE department_id = 50;
    v_nume employees.last_name%TYPE;
    v_sal  NUMBER;
BEGIN
    OPEN c;
    LOOP
        FETCH c INTO v_nume, v_sal;
        EXIT WHEN c%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(v_nume || ' are salariul anual ' || v_sal);
    END LOOP;
    CLOSE c;
END;
/


DECLARE
    CURSOR c IS
        SELECT last_name, salary * 12 AS sal_anual
        FROM employees
        WHERE department_id = 50;
    v_nume employees.last_name%TYPE;
    v_sal  NUMBER;
BEGIN
    OPEN c;
    FETCH c INTO v_nume, v_sal; -- Primul FETCH înainte de buclă
    WHILE c%FOUND LOOP
        DBMS_OUTPUT.PUT_LINE(v_nume || ' are salariul anual ' || v_sal);
        FETCH c INTO v_nume, v_sal; -- Următorul FETCH la finalul buclei
    END LOOP;
    CLOSE c;
END;
/


DECLARE
    CURSOR c IS
        SELECT last_name, salary * 12 AS sal_anual
        FROM employees
        WHERE department_id = 50;
BEGIN
    open c;
    close c;
    open c;
    close c;
    FOR r IN c LOOP
        DBMS_OUTPUT.PUT_LINE(r.last_name || ' are salariul anual ' || r.sal_anual);
    END LOOP;
END;
/


BEGIN
    FOR r IN (SELECT last_name, salary * 12 AS sal_anual
              FROM employees
              WHERE department_id = 50) LOOP
        DBMS_OUTPUT.PUT_LINE(r.last_name || ' are salariul anual ' || r.sal_anual);
    END LOOP;
END;
/


SET SERVEROUTPUT ON;

DECLARE
    CURSOR c_sal IS
        SELECT last_name, salary
        FROM employees
        WHERE salary < 7000
        ORDER BY salary ASC;
    v_nume employees.last_name%TYPE;
    v_sal  employees.salary%TYPE;
BEGIN
    OPEN c_sal;
    LOOP
        FETCH c_sal INTO v_nume, v_sal;
        EXIT WHEN c_sal%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('-Salariatul ' || v_nume || ' castiga ' || v_sal || '-');
    END LOOP;
    
    DBMS_OUTPUT.PUT_LINE('Total linii obtinute: ' || c_sal%ROWCOUNT);

    CLOSE c_sal;
END;
/




DECLARE
 CURSOR c IS SELECT last_name FROM employees WHERE department_id = 90 ORDER BY 
employee_id;
 v_nume employees.last_name%TYPE;
 PROCEDURE p_stare(p_pas VARCHAR2) IS
 v_f VARCHAR2(4); v_n VARCHAR2(4);
 BEGIN
 IF c%ISOPEN THEN
 v_f := CASE c%FOUND WHEN TRUE THEN 'T' WHEN FALSE THEN 'F' ELSE 'NULL' 
END;
 v_n := CASE c%NOTFOUND WHEN TRUE THEN 'T' WHEN FALSE THEN 'F' ELSE 'NULL' 
END;
 DBMS_OUTPUT.PUT_LINE(RPAD(p_pas, 22) || 'ISOPEN=T FOUND=' || v_f ||
 ' NOTFOUND=' || v_n || ' ROWCOUNT=' || c%ROWCOUNT);
 ELSE
 DBMS_OUTPUT.PUT_LINE(RPAD(p_pas, 22) || 'ISOPEN=F');
 END IF;
 END;
BEGIN
 -- apeluri p_stare('...') și comenzile OPEN, FETCH c INTO v_nume, CLOSE
 NULL;
END;
/

