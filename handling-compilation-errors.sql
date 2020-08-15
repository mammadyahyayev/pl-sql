--we create procedure or function , oracle will create them for us and stored them.
--now let's say we created a procedure or a function but we have compile errors , oracle will create them again.
-- but this time oracle says , hey you have an error in this procedure or this function and we can come back later fix it.

--if we want to see how many errors have and we execute following statement
SHOW ERRORS PROCEDURE raise_salary;

SHOW ERRORS FUNCTION check_salary;

SELECT
    *
FROM
    user_errors;