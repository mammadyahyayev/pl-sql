--SQL FUNCTIONS IN PL/SQL
DECLARE 

    --DECLARE THE TYPE
    TYPE emp_record IS RECORD (
        emp_id          employees.employee_id%TYPE,
        name            employees.first_name%TYPE,
        surname         employees.last_name%TYPE,
        bonus_payment   NUMBER(6)
    );   
                
     --DECLARE VARIABLES
    best_emp emp_record;
BEGIN

    --FILL THE TYPE
    SELECT
        employee_id,
        first_name,
        last_name,
        5000
    INTO best_emp
    FROM
        employees
    WHERE
        salary = (
            SELECT
                MAX(salary)
            FROM
                employees
        )
        AND ROWNUM <= 1;

    --DISPLAY THE MESSAGE

    dbms_output.put_line('BEST EMPLOYEE : ' || upper(best_emp.name));
    dbms_output.put_line('BEST EMPLOYEE BONUS: '
                         || round(best_emp.bonus_payment * 1.15, -2));

END;



--DML STATEMENTS : SELECT INTO ,INSERT , UPDATE , DELETE

DECLARE
    
    --DECLARE RECORD OBJECT
    TYPE EMP_record IS RECORD (
        id        employees.employee_id%TYPE,
        name      employees.first_name%TYPE,
        surname   employees.last_name%TYPE,
        BONUS_PAYMENT   NUMBER(5)
    );
    
    --DECLARE VARIABLE
    INACTIVE_EMPLOYEE  EMP_RECORD; 
    
BEGIN
    
    --RETRIEVE FIRST EMPLOYEE
     SELECT employee_id,
        first_name,
        last_name,
        5000
    INTO INACTIVE_EMPLOYEE
    FROM EMPLOYEES
    WHERE SALARY = (SELECT MIN(SALARY) FROM EMPLOYEES)
    AND ROWNUM <= 1;

    
    --UPDATE EMPLOYEES
    UPDATE EMPLOYEES SET SALARY = NULL
    WHERE EMPLOYEE_ID = INACTIVE_EMPLOYEE.ID;


    --DELETE EMPLOYEE
    DELETE FROM EMPLOYEES
    WHERE EMPLOYEE_ID = INACTIVE_EMPLOYEE.ID;

    --SAVE CHANGES
    COMMIT;

    --DISPLAY INACTIVE EMPLOYEE
    DBMS_OUTPUT.PUT_LINE('IN ACTIVE EMPLOYEE: ' || INACTIVE_EMPLOYEE.NAME || ' ' || INACTIVE_EMPLOYEE.SURNAME);
END;


