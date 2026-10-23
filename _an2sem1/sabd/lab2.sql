SELECT COUNT(UNIQUE(manager_id))
FROM employees;


SELECT AVG(NVL(commission_pct, 0))
FROM employees;


SELECT e.employee_id, e.last_name
FROM employees e
JOIN works_on w ON e.employee_id = w.employee_id
JOIN projects p ON w.project_id = p.project_id
WHERE p.delivery_date > p.deadline
GROUP BY e.employee_id, e.last_name
HAVING COUNT(p.project_id) >= 2;


SELECT e.employee_id, p.project_id
FROM employees e
LEFT JOIN works_on w ON e.employee_id = w.employee_id
LEFT JOIN projects p ON w.project_id = p.project_id;


SET SERVEROUTPUT ON;

BEGIN
    DBMS_OUTPUT.PUT_LINE('salut');
END;
/


DECLARE
    v_cod employees.employee_id%TYPE := &p_cod;
    v_name employees.last_name%TYPE;
    v_salary employees.salary%TYPE;
BEGIN 
    SELECT last_name, salary INTO v_name, v_salary
    FROM employees
    WHERE employee_id = v_cod;
    
    DBMS_OUTPUT.PUT_LINE('angajatul ' || v_cod || ' are numele ' || v_name || 'si salariul ' || v_salary);
END;
/


DECLAR
    v_last_name employees.last_name%TYPE := '&p_name';
    v_salary employees.salary%TYPE;
BEGIN
    SELECT salary INTO v_salary
    FROM employees
    WHERE last_name = v_last_name;
END;
/