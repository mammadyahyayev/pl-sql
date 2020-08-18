DECLARE
    text_record   VARCHAR2(2000);
    text_file     utl_file.file_type;
    
    --CREATE CURSOR FOR EMPLOYEES
    CURSOR employee_list IS
    SELECT
        e.first_name,
        e.last_name,
        e.salary,
        d.department_name
    FROM
        employees     e
        INNER JOIN departments   d ON d.department_id = e.department_id
    ORDER BY
        d.department_name;
    
    --DECLARE A NEW TYPE
    TYPE employee_record_type IS RECORD (
        emp_name      employees.first_name%TYPE,
        emp_surname   employees.last_name%TYPE,
        emp_salary    employees.salary%TYPE,
        dep_name      departments.department_name%TYPE
    );
    emp_record    employee_record_type;
BEGIN
    OPEN employee_list;
    text_file := utl_file.fopen(upper('TEXTDIRECTORY'), 'employees.csv', 'w', 32767);
    
    
    --retrieve the employees from cursor

    LOOP
        FETCH employee_list INTO emp_record;
        EXIT WHEN employee_list%notfound;
        
        --PASS DATA TO TEXT_RECORD
        text_record := emp_record.emp_name
                       || ','
                       || emp_record.emp_surname
                       || ','
                       || emp_record.emp_salary
                       || ','
                       || emp_record.dep_name;
    
    
        --POST TEXT_RECORD TO THE OPEN FILE

        utl_file.put(text_file, text_record);
        utl_file.new_line(text_file);
    END LOOP;

    CLOSE employee_list;
    utl_file.fclose(text_file);
EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line(sqlcode);
        dbms_output.put_line(sqlerrm);
END;