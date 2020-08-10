--implicit cursor
SET SERVEROUTPUT ON;

DECLARE
    TYPE emp_record IS RECORD (
        emp_id       employees.employee_id%TYPE,
        first_name   employees.first_name%TYPE,
        last_name    employees.last_name%TYPE
    );
    inactive_emp emp_record;
BEGIN
    SELECT
        employee_id,
        first_name,
        last_name
    INTO inactive_emp
    FROM
        employees
    WHERE
        salary = (
            SELECT
                MIN(salary)
            FROM
                employees
        )
        AND ROWNUM <= 1;
        
    
    --delete employee

    DELETE FROM employees
    WHERE
        employee_id = inactive_emp.emp_id;


    --test the cursor

    IF SQL%found THEN
        dbms_output.put_line('Employee Records Deleted : ' || SQL%rowcount);
    END IF;

    COMMIT;
    dbms_output.put_line('Employee transferred :'
                         || inactive_emp.first_name
                         || ' '
                         || inactive_emp.last_name);

END;



--%FOUND
--Returns TRUE if an INSERT, UPDATE, or DELETE statement affected one or more rows or a SELECT INTO statement returned one or more rows.
--Otherwise, it returns FALSE.


--%ROWCOUNT
--Returns the number of rows affected by an INSERT, UPDATE, or DELETE statement, or returned by a SELECT INTO statement.


--%ISOPEN
--Always returns FALSE, because Oracle closes the SQL cursor automatically after executing its associated SQL statement.


--%NOTFOUND
--The logical opposite of %FOUND. 
--It returns TRUE if an INSERT, UPDATE, or DELETE statement affected no rows, or a SELECT INTO statement returned no rows.
--Otherwise, it returns FALSE.