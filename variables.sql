--VARCHAR AND CHAR
DECLARE
    emp_name        employees.first_name%TYPE;
    emp_surname     employees.last_name%TYPE;
    emp_full_name   VARCHAR2(40);
BEGIN
    --SET THE VARIABLES
    emp_name := 'SAMIR';
    emp_surname := 'SAMIROV';
    
    --CONCATENATION
    emp_full_name := emp_name
                     || ' '
                     || emp_surname;

    
    --DISPLAY THE RESULT
    dbms_output.put_line('FULL NAME:' || emp_full_name);
END;


--HANDLING STRING LITERALS

DECLARE
    entered_value   NUMBER(10) := &enter_value;
    message         VARCHAR(30);
BEGIN
    IF entered_value > 100 THEN
        message := q'!THIS VALUE ISN'T VALID.!';
        dbms_output.put_line(message);
    END IF;
END;

-- q'!....!'  if we write a text with special characters (' , ? , <> , etc.) we use this tag , 
-- because this tag doesn't care this characters




--NUMERIC VARIABLES

DECLARE 
    --DECLARE VARIABLES
    emp_salary      EMPLOYEES.SALARY%TYPE;
    EMP_RAISE_PCT   NUMBER(2);  
    
BEGIN
    --SET THE VARIABLES
    emp_salary := &ENTER_SALARY;
    emp_raise_pct := &ENTER_RAISE_PCT;

    --DISPLAY CURRENT SALARY    
    DBMS_OUTPUT.PUT_LINE('CURRENT SALARY:' || EMP_SALARY);
    
    --CALCULATE NEW SALARY 
    EMP_SALARY := EMP_SALARY  + (EMP_SALARY * (EMP_RAISE_PCT / 100));
    
    --DISPLAY NEW SALARY
    DBMS_OUTPUT.PUT_LINE('NEW  SALARY:' || EMP_SALARY);

END;



--DATE VARIABLES
DECLARE
    
    --DECLARE THE VARIABLES
    EMP_HIRE_DATE   EMPLOYEES.HIRE_DATE%TYPE;
    EMP_NEXT_HIRE_DATE  EMP_HIRE_DATE%TYPE;

BEGIN
    --SET THE VARIABLES
    EMP_HIRE_DATE := SYSDATE;
    emp_next_hire_date := emp_hire_date + 100;

    --DISPLAY CURRENT DATE
    DBMS_OUTPUT.PUT_LINE('CURRENT DATE:' || EMP_HIRE_DATE);

    --DISPLAY NEXT DATE
    DBMS_OUTPUT.PUT_LINE('NEXT DATE:' || emp_next_hire_date);

END;







--BOOLEAN VARIABLES
DECLARE
    
    --DECLARE VARIABLES
    EMP_SALARY   EMPLOYEES.SALARY%TYPE;
    HIGH_PAID    BOOLEAN;

BEGIN
    --SET THE VARIABLES
    EMP_SALARY := &ENTER_SALARY;
    HIGH_PAID := (EMP_SALARY > 1000);

    --CHECK HIGH_PAID TRUE OR NOT 
    IF HIGH_PAID THEN
        --DISPLAY GREATER SALARY
        DBMS_OUTPUT.PUT_LINE('SALARY IS GREATER THAN 1000 , SALARY IS:' || EMP_SALARY);

    ELSE
        --DISPLAY LESS SALARY 
        DBMS_OUTPUT.PUT_LINE('SALARY IS LESS THAN 1000 , SALARY IS :' || EMP_SALARY);
        
    END IF;

END;


