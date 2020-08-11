SET SERVEROUTPUT ON;

DECLARE
    --DECLARE THE CURSOR
    CURSOR emp_cursor IS
    SELECT
        *
    FROM
        employees
    FOR UPDATE OF salary;


    --DECLARE THE EMPLOYEE RECORD

    emp_record         employees%rowtype;
    
    --DECLARE MAX SALARY 
    max_salary         CONSTANT NUMBER(6) := 100000;
   
    --DECLARE INCREASED EMPLOYEE SALARY
    increased_salary   employees.salary%TYPE;
    
    --DECLARE CURRENT YEAR AND EMPLOYEE HIRE YEAR
    works_year         NUMBER(5);
    hire_year          NUMBER(6);
    current_year       NUMBER(6);
    
    --DECLARE INCREASE
    rise               NUMBER;
    
    --DECLARE BOOLEAN VALUE
    long_time_works    BOOLEAN := false;
    
    --DECLARE EXCEPTION
    year_past EXCEPTION;
BEGIN

    --RETRIEVE CURRENT YEAR
    SELECT
        to_char(sysdate, 'YYYY')
    INTO current_year
    FROM
        dual;
     
     --RAISE EXCEPTION IF CURRENT YEAR EQUALS 2021

    IF ( current_year = 2021 ) THEN
        RAISE year_past;
    END IF;
    
    --OPEN THE CURSOR
    IF NOT ( emp_cursor%isopen ) THEN
        OPEN emp_cursor;
    END IF;
    LOOP
    
    --RETRIEVE THE DATA AND INSERT TO EMP_RECORD
        FETCH emp_cursor INTO emp_record;
    
    --WHEN DATA NOT FOUND EXIT THE LOOP
        EXIT WHEN emp_cursor%notfound; 

    --RETRIEVE EMPLOYEE'S HIRE YEAR
        SELECT
            EXTRACT(YEAR FROM hire_date)
        INTO hire_year
        FROM
            employees
        WHERE
            employee_id = emp_record.employee_id;

    --CALCULATE HOW MANY YEARS IN OUR COMPANY

        works_year := current_year - hire_year;

    --TEST BOOLEAN VALUES IF GREATER THAN SET TO TRUE
        long_time_works := ( works_year > 10 );
    
    --SET THE RISE 
        CASE
            WHEN long_time_works THEN
                rise := 2;
            WHEN NOT long_time_works THEN
                rise := 1.5;
            ELSE
                NULL;
        END CASE;

        increased_salary := ( rise * emp_record.salary ) + emp_record.salary;
        CONTINUE WHEN increased_salary > max_salary;
    
    --UPDATE CURRENT EMPLOYEE'S SALARY
        UPDATE employees
        SET
            salary = increased_salary
        WHERE
            CURRENT OF emp_cursor;
    
    
    
    --DISPLAY THE RESULT

        dbms_output.put_line('EMPLOYEE : '
                             || emp_cursor%rowcount
                             || '-'
                             || emp_record.first_name
                             || ' '
                             || emp_record.last_name
                             || ' salary increased by '
                             || rise);

    END LOOP;

    COMMIT;

    --CLOSE THE CURSOR
    IF emp_cursor%isopen THEN
        CLOSE emp_cursor;
    END IF;

    --TEST FOR YEAR PAST EXCEPTION
EXCEPTION
    WHEN year_past THEN
        dbms_output.put_line(q'!Year is 2021 and you can not rise your employees' money!');

    --TEST FOR GENERIC ERROR
    WHEN OTHERS THEN
        dbms_output.put_line('UNKNOWN EXCEPTION');
        dbms_output.put_line('ERROR CODE :' || sqlcode);
        dbms_output.put_line('ERROR MESSAGE :' || sqlerrm);
END;