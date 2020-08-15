--NOW LET'S CREATE PACKAGE BODY , BUT I ADD 4 PROGRAM UNIT'S TO PACKAGE BODY
--I HAVE 3 PROGRAM UNITS IN THE PACKAGE HEADER AND THOOSE PROGRAM UNITS MUST BE MATCH IN THE PACKAGE BODY'S PROGRAM UNITS
--CHECK_SALARY_VARCHAR2 FUNCTIONS NOT IN THE PACKAGE HEADER BUT THIS FUNCTION INCLUDES PACKAGE BODY AND THIS FUNCTION IS PRIVATE FUNCTION
--AND PRIVATE FUNCTION MUST BE THE FIRST
CREATE OR REPLACE PACKAGE BODY package_test AS

--CHECK SALARY IS VALID OR NOT

    FUNCTION check_salary_varchar2 (
        id IN NUMBER
    ) RETURN VARCHAR2 IS
        emp_salary employees.salary%TYPE;
    BEGIN
    --RETRIEVE EMPLOYEE'S SALARY
        SELECT
            salary
        INTO emp_salary
        FROM
            employees
        WHERE
            employee_id = id;

        IF emp_salary > 13000 THEN
            return('This salary is valid');
        ELSE
            return('This salary is not valid');
        END IF;

    END check_salary_varchar2;


--CREATE PROCEDURE FOR ADD EMPLOYEE TO TABLE

    PROCEDURE insert_employee (
        input_name      IN   VARCHAR2,
        input_surname   IN   VARCHAR2,
        input_email     IN   VARCHAR2,
        input_salary    IN   NUMBER
    ) AS
        max_salary CONSTANT NUMBER := 100000;
        insert_error EXCEPTION;
        salary_is_max EXCEPTION;
    BEGIN
        IF input_salary > max_salary THEN
            RAISE salary_is_max;
        END IF;
        INSERT INTO employees (
            employee_id,
            first_name,
            last_name,
            email,
            hire_date,
            salary
        ) VALUES (
            employees_seq.NEXTVAL,
            input_name,
            input_surname,
            input_email,
            sysdate,
            input_salary
        );

        IF SQL%rowcount <> 1 THEN
            RAISE insert_error;
        END IF;
        COMMIT;
    EXCEPTION
        WHEN insert_error THEN
            dbms_output.put_line('INSERT ERROR');
        WHEN salary_is_max THEN
            dbms_output.put_line('SALARY CAN NOT BE MORE THAN 100_000');
        WHEN OTHERS THEN
            dbms_output.put_line('UNKNOWN ERROR');
            dbms_output.put_line('ERROR CODE: ' || sqlcode);
            dbms_output.put_line('ERROR MESSAGE : ' || sqlerrm);
    END insert_employee;

--RAISE SALARY FOR EMPLOYEES WHO HAS NO MANAGER 

    PROCEDURE raise_salary (
        result_message        OUT   VARCHAR2,
        emp_id                IN    NUMBER,
        increase_salary_pct   IN    NUMBER
    ) AS
    --DECLARE VARIABLES

        max_salary         CONSTANT NUMBER(6) := 100000;
        emp_salary         employees.salary%TYPE;
        emp_manager        employees.manager_id%TYPE;
        emp_department     employees.department_id%TYPE;
        increased_salary   emp_salary%TYPE; 

    --DECLARE EXCEPTIONS
        salary_is_max EXCEPTION;
        no_department EXCEPTION;
        have_manager EXCEPTION;
        update_error EXCEPTION;
    BEGIN

    --RETRIEVE EMPLOYEE BY DEPARTMENT ID
        SELECT
            salary,
            department_id,
            manager_id
        INTO
            emp_salary,
            emp_department,
            emp_manager
        FROM
            employees
        WHERE
            employee_id = emp_id;

    --RAISE EXCEPTIONS

        IF emp_department IS NULL THEN
            RAISE no_department;
        END IF;
        IF emp_manager IS NOT NULL THEN
            RAISE have_manager;
        END IF;



    --RAISE SALARY AND UPDATE
        IF ( emp_salary IS NOT NULL ) AND ( emp_salary > 0 ) THEN
            increased_salary := emp_salary + ( emp_salary * increase_salary_pct );
            IF increased_salary > max_salary THEN
                RAISE salary_is_max;
            END IF;
            UPDATE employees
            SET
                salary = increased_salary
            WHERE
                employee_id = emp_id;

            IF SQL%rowcount <> 1 THEN
                RAISE update_error;
            END IF;
            COMMIT;
            result_message := 'EMPLOYEES SALARY IS INCREASED';
        ELSE
            result_message := q'!This Employee's salary is null or 0!';
        END IF;

    --CATCH EXCEPTIONS

    EXCEPTION
        WHEN no_department THEN
            result_message := q'!This Employee hasn't any department!';
        WHEN have_manager THEN
            result_message := 'This Employee has manager';
        WHEN salary_is_max THEN
            result_message := q'!This Employee's salary is maximum!';
        WHEN update_error THEN
            result_message := 'DATABASE ERROR : UPDATE FAIL';
        WHEN no_data_found THEN
            result_message := 'NO DATA FOUND FOR THIS EMPLOYEE ID';
        WHEN OTHERS THEN
            result_message := 'UNKNOWN ERROR';
    END;

--CHECK SALARY IS VALID OR NOT AND RETURN BOOLEAN VALUE

    FUNCTION check_salary (
        id IN NUMBER
    ) RETURN BOOLEAN IS
        emp_salary employees.salary%TYPE;
    BEGIN
    --RETRIEVE EMPLOYEE'S SALARY
        SELECT
            salary
        INTO emp_salary
        FROM
            employees
        WHERE
            employee_id = id;

        IF emp_salary > 20000 THEN
            RETURN true;
        ELSE
            RETURN false;
        END IF;
    END check_salary;

END package_test;