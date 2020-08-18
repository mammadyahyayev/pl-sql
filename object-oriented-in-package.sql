CREATE OR REPLACE PACKAGE package_oop AS
    PROCEDURE insert_employee (
        input_name            IN   VARCHAR2,
        input_surname         IN   VARCHAR2,
        input_email           IN   VARCHAR2,
        input_salary          IN   NUMBER,
        input_department_id   IN   NUMBER
    );

    PROCEDURE insert_employee (
        input_name             IN   VARCHAR2,
        input_surname          IN   VARCHAR2,
        input_email            IN   VARCHAR2,
        input_salary           IN   NUMBER,
        input_commission_pct   IN   NUMBER
    );

END package_oop;

--THIS 2 PROCEDURE SAME NAME AND THEESE SOME PARAMETERS ARE SAME , BUT 1 PARAMETERS DIFFERENT IN EACH PROCEDURE
-- AND THIS IS CALLED POLYMORPHISM SAME NAME BUT DIFFERENT PARAMETERS
-- AND ALSO THIS IS CALLED OVERLOADING 
