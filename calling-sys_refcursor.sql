SET SERVEROUTPUT ON;

DECLARE
    employee_cv         SYS_REFCURSOR;
    inp_department_id   employees.department_id%TYPE := &input_dep_id;
    employee_output     VARCHAR2(100);
BEGIN
    employee_data.open_employee_data(employee_cv, inp_department_id);
    
    LOOP
    
        EMPLOYEE_DATA.FETCH_EMPLOYEE_DATA(EMPLOYEE_CV,employee_output);
        
        EXIT WHEN EMPLOYEE_CV%NOTFOUND;
        
        DBMS_OUTPUT.PUT_LINE(EMPLOYEE_OUTPUT);
    END LOOP;
    
END;