SET SERVEROUTPUT ON;

DECLARE
    department_id     employees.department_id%TYPE := &DEPARTMENT_ID;
    employee_cv       employee_data.employee_cv_type;
    employee_output   VARCHAR2(100);
BEGIN
    --OPEN THE CURSOR
    employee_data.open_employee_data(employee_cv, department_id);
    LOOP
        --FETCH THE EMPLOYEE
        employee_data.fetch_employee_data(employee_cv, employee_output);
        
        EXIT WHEN employee_cv%notfound;
        
        dbms_output.put_line(employee_output);
        
    END LOOP;

END;