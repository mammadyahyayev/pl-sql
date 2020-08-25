CREATE OR REPLACE TRIGGER salary_limit BEFORE
    INSERT OR UPDATE OF salary ON employees
    FOR EACH ROW
    WHEN (new.salary > 50000)
BEGIN
    IF :new.salary > 50000 THEN
        raise_application_error(-20124, 'Salary must be less than 50000');
    END IF;
END;


--CHECK THE TRIGGERS NOW LET'S UPDATE SALARY OF ANY EMPLOYEE

-- 1 STATEMENT

UPDATE employees
SET
    salary = 20000
WHERE
    employee_id = 102;  

-- 2 STATEMENT

UPDATE employees
SET
    salary = 51000
WHERE
    employee_id = 102;  


--1 STATEMENT WILL BE UPDATED BECAUSE WE CREATED  TRIGGER AND WE GAVE CONDITION  IF NEW SALARY IS GREATER THAN 50000 , FIRE AN ERROR
-- BUT NEW SALARY IS 20000 AND THIS SALARY IS LESS 50000 IN STATEMENT 1

-- 2 STATEMENT THROW AN ERROR BECAUSE NEW SALARY IS GREATER THAN 50000 

INSERT INTO employees (
    employee_id,
    first_name,
    last_name,
    email,
    salary,
    hire_date
) VALUES (
    employees_seq.NEXTVAL,
    'SAMIR',
    'SAMIROV',
    'SAMIR@GMAIL.COM',
    60000,
    sysdate
);

SELECT
    *
FROM
    employees;