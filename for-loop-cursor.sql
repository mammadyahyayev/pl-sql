SET SERVEROUTPUT ON;

BEGIN
   --create for loop cursor
    FOR emp_cursor IN (
        SELECT
            *
        FROM
            employees
    ) LOOP
        dbms_output.put_line('EMPLOYEE: '
                             || emp_cursor.first_name
                             || ' '
                             || emp_cursor.last_name);
    END LOOP;
END;