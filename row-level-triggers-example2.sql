--NOW WE CREATE A TABLE FOR TRACKING WHO UPDATE OR INSERT SALARY ABOVE 40000 ON EMPLOYEE TABLE 
CREATE TABLE emp_salary_track (
    entry_date   DATE,
    entry_user   VARCHAR2(40),
    entry_text   VARCHAR2(2000),
    old_salary   VARCHAR2(2000),
    new_salary   VARCHAR2(2000)
);


--LET'S CREATE A TRIGGER

CREATE OR REPLACE TRIGGER salary_track AFTER
    INSERT OR UPDATE OF salary ON employees
    FOR EACH ROW
    WHEN ( new.salary > 40000 )
BEGIN
    INSERT INTO emp_salary_track (
        entry_date,
        entry_user,
        entry_text,
        old_salary,
        new_salary
    ) VALUES (
        sysdate,
        user,
        'THIS SALARY TOO HIGH FOR ' || :new.employee_id,
        :old.salary,
        :new.salary
    );

END;

UPDATE employees
SET
    salary = 42000
WHERE
    employee_id = 101;

SELECT
    *
FROM
    employees;

SELECT
    *
FROM
    emp_salary_track;