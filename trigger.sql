--CREATE A TRIGGER 
CREATE OR REPLACE TRIGGER security_time_check BEFORE
    DELETE OR UPDATE ON employees
DECLARE
    --DECLARE VARIABLES
    day_of_week   CHAR(3);
    hh_of_day     NUMBER(2);
BEGIN

    --SET VARIABLES
    day_of_week := to_char(sysdate, 'DY');
    hh_of_day := to_char(sysdate, 'HH24');
    
    --CHECK DAY AND HOURS
    IF day_of_week IN (
        'WED'
    ) OR hh_of_day NOT BETWEEN 1 AND 19 THEN
        --RAISE AN APPLICATION ERROR
        raise_application_error(-20600, 'Transaction rejected');
    END IF;

END;


--TRIGGER CREATED NOW LET'S TEST IT WORKS OR NOT 

UPDATE employees
SET
    salary = 12000
WHERE
    employee_id = 100;

--IT WORKS