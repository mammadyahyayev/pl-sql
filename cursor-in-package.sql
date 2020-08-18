CREATE OR REPLACE PACKAGE employee_data AS

    --DEFINE GLOBAL VARIABLE
    TYPE employee_cv_type IS REF CURSOR RETURN employees%rowtype;

    --DECLARE PROCEDURE TO OPEN EMPLOYEE DATA
    PROCEDURE open_employee_data (
        employee_cv         IN OUT  employee_cv_type,
        inp_department_id   IN      employees.department_id%TYPE
    );

    --DECLARE PROCEDURE TO FETCH DATA FROM CURSOR

    PROCEDURE fetch_employee_data (
        employee_cv       IN    employee_cv_type,
        employee_output   OUT   VARCHAR2
    );

END employee_data;
/

CREATE OR REPLACE PACKAGE BODY employee_data AS

    PROCEDURE open_employee_data (
        employee_cv         IN OUT  employee_cv_type,
        inp_department_id   IN      employees.department_id%TYPE
    ) IS
    BEGIN
    
        --OPEN THE CURSOR
        OPEN employee_cv FOR 
        SELECT * FROM employees
        WHERE department_id = inp_department_id;

    END open_employee_data;

    PROCEDURE fetch_employee_data (
        employee_cv       IN    employee_cv_type,
        employee_output   OUT   VARCHAR2
    ) IS
        employee_row employees%rowtype;
    BEGIN
        FETCH employee_cv INTO employee_row;
        employee_output := employee_row.first_name
                           || ' '
                           || employee_row.last_name;
    END fetch_employee_data;

END employee_data;