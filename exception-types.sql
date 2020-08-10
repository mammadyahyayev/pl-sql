--EXCEPTION 
DECLARE
    message              VARCHAR2(40);
    x_salary             NUMBER;
    entered_teacher_id   NUMBER := &entered_value;
    divide_salary        NUMBER;
    zero_divide          EXCEPTION;
    
    PRAGMA EXCEPTION_INIT(zero_divide , -1476);
BEGIN
    SELECT
        salary
    INTO x_salary
    FROM
        teacher_test_x
    WHERE
        id = entered_teacher_id;

    divide_salary := x_salary / 0;
    message := ' DIVIDE_SALARY : ' || divide_salary;
    dbms_output.put_line(message);
EXCEPTION
    WHEN zero_divide THEN
        dbms_output.put_line('YOU CAN NOT DIVIDE BY ZERO');
    WHEN OTHERS THEN
        dbms_output.put_line('UNKNOWN EXCEPTION');
END;




-----------------
DECLARE
    not_null_constraint EXCEPTION;
    PRAGMA exception_init ( not_null_constraint, -1407 );
BEGIN
    UPDATE teacher_test_x
    SET
        name = NULL;

    dbms_output.put_line('NAME WAS CHANGED SUCCESSFULLY ');
EXCEPTION
    WHEN not_null_constraint THEN
        dbms_output.put_line('YOU CAN NOT SET NULL VALUE TO THE NAME');
    WHEN OTHERS THEN
        dbms_output.put_line('UNKNOWN ERROR');
END;




--SQLCODE AND SQLERRM

DECLARE 
BEGIN

UPDATE TEACHER_TEST_X
SET NAME = NULL;

    dbms_output.put_line('NAME WAS CHANGED SUCCESSFULLY ');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('ERROR CODE : ' || SQLCODE);
        DBMS_OUTPUT.PUT_LINE('ERROR MESSAGE : ' || SQLERRM);
END;




