SELECT EMPLOYEE_ID  , FIRST_NAME , LAST_NAME , SALARY ,
    CHECK_SALARY(100) AS "VALID" FROM EMPLOYEES;


--THIS ABOVE STATEMENT WILL BE THROW AN ERROR BECAUSE OUR FUNCTION RETURN BOOLEAN VALUE
--NOW LET'S CREATE ANOTHER FUNCTION BUT THIS TIME RETURN A VARCHAR2 


SELECT EMPLOYEE_ID  , FIRST_NAME , LAST_NAME , SALARY ,
    CHECK_SALARY_VARCHAR2(103) AS "VALID" FROM EMPLOYEES where employee_id = 103;