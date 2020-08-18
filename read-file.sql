DECLARE
    text_record   VARCHAR2(2000);
    text_file     utl_file.file_type;
BEGIN
    text_file := utl_file.fopen(upper('TEXTDIRECTORY'), 'employees.csv', 'r', 32767);

    IF NOT utl_file.is_open(text_file) THEN
        dbms_output.put_line('Unable to open file');
    ELSE
        LOOP
            utl_file.get_line(text_file, text_record);
            dbms_output.put_line(text_record);
        END LOOP;
    END IF;

    utl_file.fclose(text_file);
EXCEPTION
    WHEN no_data_found THEN
        dbms_output.put_line('File read completely');
        utl_file.fclose(text_file);
    WHEN OTHERS THEN
        dbms_output.put_line(sqlcode);
        dbms_output.put_line(sqlerrm);
        utl_file.fclose_all;
END;