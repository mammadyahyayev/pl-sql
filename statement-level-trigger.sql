--CREATE A TRIGGER 
CREATE OR REPLACE TRIGGER security_time_check_on_salary BEFORE
    DELETE OR UPDATE OF salary ON employees
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
    salary = 12000;

--IT WORKS


--CREATE A TRIGGER 

CREATE OR REPLACE TRIGGER STATEMENT_CHECK_ON_DOCTOR BEFORE
    INSERT OR DELETE OR UPDATE OF SALARY ON doctor
DECLARE BEGIN
    
    IF inserting THEN
        raise_application_error(-20600, 'INSERTING rejected');
    END IF;
    
     IF UPDATING ('SALARY') THEN
        raise_application_error(-20601, 'UPDATING rejected');
    END IF;
    
     IF DELETING THEN
        raise_application_error(-20602, 'DELETING rejected');
    END IF;
  
END;

--INSERTING REJECTED
INSERT INTO DOCTOR(ID , NAME , SURNAME , SALARY)
VALUES(10 ,'SAMIR','SAMIROV',1500);

--UPDATING REJECTED
UPDATE DOCTOR SET SALARY = 14000;


--DELETING REJECTED
DELETE FROM DOCTOR WHERE ID = 1;