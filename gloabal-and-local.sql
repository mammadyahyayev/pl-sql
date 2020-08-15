SET SERVEROUTPUT ON;

<< main_block >> DECLARE
    emp_record          employees%rowtype;
    unknown_error EXCEPTION;
    exception_occured   BOOLEAN := false;
BEGIN
    << select_emp >> BEGIN
        SELECT
            *
        INTO emp_record
        FROM
            employees
        WHERE
            upper(first_name) = upper('&ENTER_FIRST_NAME');

    EXCEPTION
        WHEN no_data_found THEN
            dbms_output.put_line('No Employee with this first name...');
            exception_occured := true;
        WHEN too_many_rows THEN
            dbms_output.put_line('Multiple Employee with this first name...');
            exception_occured := true;
        WHEN OTHERS THEN
            RAISE unknown_error;
    END select_emp;

    IF NOT exception_occured THEN
        dbms_output.put_line('Employee:'
                             || emp_record.first_name
                             || '  '
                             || emp_record.last_name);

    END IF;

EXCEPTION
    WHEN unknown_error THEN
        dbms_output.put_line('UNKNOWN EXCEPTION IN INNER BLOCK');
        dbms_output.put_line('ERROR CODE :' || sqlcode);
        dbms_output.put_line('ERROR MESSAGE :' || sqlerrm);
    WHEN OTHERS THEN
        dbms_output.put_line('UNKNOWN EXCEPTION');
        dbms_output.put_line('ERROR CODE :' || sqlcode);
        dbms_output.put_line('ERROR MESSAGE :' || sqlerrm);
END main_block;