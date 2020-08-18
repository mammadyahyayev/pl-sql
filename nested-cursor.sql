SET SERVEROUTPUT ON;

DECLARE
    --CREATE CURSOR FOR EMPLOYEES
    TYPE emp_cursor_type IS REF CURSOR;
    emp_cursor    emp_cursor_type;
    emp_name      employees.first_name%TYPE;
    emp_surname   employees.last_name%TYPE;
    emp_salary    employees.salary%TYPE;
    dep_name      departments.department_name%TYPE;
    CURSOR emp_department IS
    SELECT
        department_name,
        CURSOR (
            SELECT
                e.first_name,
                e.last_name,
                e.salary
            FROM
                employees     e
                INNER JOIN departments   d ON d.department_id = e.department_id
            WHERE
                e.department_id = d.department_id
        ) AS employee
    FROM
        departments;

BEGIN
    OPEN emp_department;
    LOOP
        FETCH emp_department INTO
            dep_name,
            emp_cursor;
        EXIT WHEN emp_department%notfound;
        DBMS_OUTPUT.PUT_LINE('');
        dbms_output.put_line('Department: ' || dep_name);
        LOOP
            FETCH emp_cursor INTO
                emp_name,
                emp_surname,
                emp_salary;
            EXIT WHEN emp_cursor%notfound;
            dbms_output.put_line('Employee:'
                                 || emp_name
                                 || ' '
                                 || emp_surname
                                 || ' gains '
                                 || emp_salary
                                 || ' at '
                                 || dep_name
                                 || ' department');

        END LOOP;

    END LOOP;

    CLOSE emp_department;
END;