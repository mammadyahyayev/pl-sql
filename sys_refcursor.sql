CREATE OR REPLACE PACKAGE employee_data AS
    PROCEDURE open_employee_data (
        employee_cv         IN OUT  SYS_REFCURSOR,
        inp_department_id   IN      employees.department_id%TYPE
    );

    PROCEDURE fetch_employee_data (
        employee_cv       IN    SYS_REFCURSOR,
        employee_output   OUT   VARCHAR2
    );

END employee_data;
/

CREATE OR REPLACE PACKAGE BODY employee_data AS

    PROCEDURE open_employee_data (
        employee_cv     IN OUT  SYS_REFCURSOR,
        inp_department_id   IN      employees.department_id%TYPE
    ) IS
    BEGIN
        OPEN employee_cv FOR SELECT
                                 *
                             FROM
                                 employees
                             WHERE
                                 department_id = inp_department_id;

    END open_employee_data;
    
    PROCEDURE fetch_employee_data (
        employee_cv       IN    SYS_REFCURSOR,
        employee_output   OUT   VARCHAR2
    )
    IS
        EMPLOYEE_ROW    EMPLOYEES%ROWTYPE;
    BEGIN
        
        FETCH EMPLOYEE_CV INTO EMPLOYEE_ROW;
    
        EMPLOYEE_OUTPUT := EMPLOYEE_ROW.FIRST_NAME || ' '|| EMPLOYEE_ROW.LAST_NAME;
        
    END FETCH_EMPLOYEE_DATA;
    
    
END EMPLOYEE_DATA;    