SET SERVEROUTPUT ON;

BEGIN
    IF check_salary(100) THEN
        dbms_output.put_line(q'!THIS EMPLOYEES'S SALARY IS GREATER THAN 20000!');
    ELSE
        dbms_output.put_line(q'!THIS EMPLOYEES'S SALARY IS LESS THAN 20000!');
    END IF;
END;