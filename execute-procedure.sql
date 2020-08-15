SET SERVEROUTPUT ON;

DECLARE 

    --DECLARE VARIABLES
    output_message VARCHAR2(80);
BEGIN

    --EXECUTE PROCEDURE
    raise_salary(result_message => output_message, emp_id => 100, increase_salary_pct => 5);

    --DISPLAY RESULT
    dbms_output.put_line(output_message);
END;