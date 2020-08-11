SET SERVEROUTPUT ON;

DECLARE 
    
    --DECLARE EXCEPTIONS
    too_little_money EXCEPTION;
    too_much_money EXCEPTION;
    
    --DECLARE SALARY CONSTANTS
    max_salary   CONSTANT NUMBER(5) := 25000;
    min_salary   CONSTANT NUMBER(5) := 2700;
    
    --DECLARE VARIABLE
    emp_id       employees.employee_id%TYPE;
    old_salary   employees.salary%TYPE;
    new_salary   employees.salary%TYPE;
BEGIN
    SELECT
        employee_id,
        salary
    INTO
        emp_id,
        old_salary
    FROM
        employees
    WHERE
        employee_id = &entered_emp_id;

    IF old_salary < min_salary THEN
        RAISE too_little_money;
    END IF;
    new_salary := old_salary * 1.5;
    IF new_salary > max_salary THEN
        RAISE too_much_money;
    END IF;
    UPDATE employees
    SET
        salary = new_salary
    WHERE
        employee_id = emp_id;

    COMMIT;
    dbms_output.put_line('Salary is increased...');
EXCEPTION
    WHEN too_little_money THEN
        dbms_output.put_line(q'!This employee's salary is low from min salary!');
    WHEN too_much_money THEN
        dbms_output.put_line(q'!This employee's salary is high from max salary!');
END;