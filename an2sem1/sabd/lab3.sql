SET SERVEROUTPUT ON;

DECLARE
    v_dept NUMBER := 50;
    v_media_sal employees.salary%TYPE;
BEGIN
    SELECT AVG(salary)
    INTO v_media_sal
    FROM employees
    WHERE department_id = v_dept;

    DBMS_OUTPUT.PUT_LINE('Media salariilor din departamentul ' || v_dept || ' este: ' || ROUND(v_media_sal, 2));
END;
/


begin 
    DBMS_OUTPUT.PUT_LINE('Invat PL/SQL');
end;
/

declare 
    v_oras locations.city%TYPE;
begin

    select l.city into v_oras
    from locations l
    join departments d on d.location_id = l.location_id
    where d.department_id = 30;
    
    DBMS_OUTPUT.PUT_LINE(v_oras);
end;
/

declare
    v_dept employees.department_id%TYPE := &p_cod;
    v_cnt NUMBER;
begin

    select count(*) into v_cnt
    from employees
    where department_id = v_dept;
    
    if v_cnt > 30 then
        DBMS_OUTPUT.PUT_LINE('imens');
    elsif v_cnt >= 10 then
        DBMS_OUTPUT.PUT_LINE('mediu');
    else
        DBMS_OUTPUT.PUT_LINE('mic');
    end if;
        
end;
/

declare
    x number := &p_x;
    y number := &p_y;
    
    f number;

begin
    if y != 0 then
        f := x / y + y;
    else
        f := x ** 2;
    end if;
    
    DBMS_OUTPUT.PUT_LINE(f);

end;
/


declare
    v_cod employees.department_id%TYPE := &p_cod;
    v_com number := &p_com;

begin
    update emp_raul 
    set commission_pct = v_com / 100
    where department_id = v_cod;
    

    DBMS_OUTPUT.PUT_LINE(SQL%ROWCOUNT);
    ROLLBACK;
end;
/

