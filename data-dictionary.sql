--USER_OBJECTS
DESCRIBE user_objects;

--THIS STATEMENT SHOW ALL PROCEDURE AND FUNCTION IN THIS DATABASE TO US

SELECT
    object_name,
    object_type,
    status
FROM
    user_objects
WHERE
    object_type IN (
        'PROCEDURE',
        'FUNCTION'
    );


--USER_SOURCE

DESCRIBE user_source;

--THIS STATEMENT SHOW ALL TRIGGERS , PROCEDURES , FUNCTIONS , PACKAGES IN THIS DATABASE TO US 

SELECT DISTINCT
    name,
    type
FROM
    user_source;

--AND ALSO WE CAN SEE EACH PROCEDURE CODE LINE

SELECT
    text
FROM
    user_source
WHERE
    name = 'RAISE_SALARY'
ORDER BY
    line;



--USER_ERRORS

DESCRIBE user_errors;

SELECT
    *
FROM
    user_errors;

SELECT
    line,
    text,
    attribute,
    message_number
FROM
    user_errors;


--USER_OBJECT_SIZE

DESCRIBE user_object_size;

SELECT
    *
FROM
    user_object_size
WHERE
    type IN (
        'PROCEDURE',
        'FUNCTION'
    );


--USER_DEPENDENCIES

DESCRIBE user_dependencies;

SELECT
    *
FROM
    user_dependencies;

SELECT
    referenced_name,
    referenced_type
FROM
    user_dependencies
WHERE
    name = 'RAISE_SALARY';