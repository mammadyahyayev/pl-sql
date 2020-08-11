SET SERVEROUTPUT ON;

DECLARE
    --DECLARE THE CURSOR
    CURSOR employee_cursor IS
    SELECT
        *
    FROM
        employees
    ORDER BY
        salary DESC;

    --DECLARE THE ROWTYPE OF EMPLOYEE

    emp_record employees%rowtype;
BEGIN
    --OPEN THE CURSOR
    IF NOT employee_cursor%isopen THEN
        OPEN employee_cursor;
    END IF;

    --AND WE FETCH ALL DATAS FROM THE CURSOR
    LOOP
        --WE FETCH DATA FROM CURSOR AND INSERT INTO EMP_RECORD
        FETCH employee_cursor INTO emp_record;
    
        --AND WE TEST IF DATA NOT FOUND , WE EXIT LOOP
        EXIT WHEN employee_cursor%notfound; 
        
        --IF DEPARTMENT IS NULL AND PASS THIS EMPLOYEE
        CONTINUE WHEN emp_record.department_id IS NULL;
        
        --DISPLAY THE EMPLOYEES
        dbms_output.put_line('EMPLOYEE : '
                             || employee_cursor%rowcount
                             || '-'
                             || emp_record.first_name
                             || ' '
                             || emp_record.last_name);

    END LOOP;
    
    --CLOSE THE CURSOR

    IF employee_cursor%isopen THEN
        CLOSE employee_cursor;
    END IF;
END;