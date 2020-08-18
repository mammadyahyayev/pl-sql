SET SERVEROUTPUT ON;

BEGIN
    dbms_output.put_line('Salary cap is :' || package_test.what_is_salary_cap());
END;

--The initialization block will execute once per session, the first time the package is used in that session.

