-- Regular Expression



SELECT *
FROM z_regular_expression;











SELECT *
FROM z_regular_expression
WHERE phone REGEXP '[0-9]{3}-[0-9]{3}-[0-9]{4}'
;










SELECT *
FROM z_regular_expression
;







SELECT email, REGEXP_SUBSTR(email, '@.+') AS email_domain
FROM z_regular_expression
;


SELECT email, REGEXP_SUBSTR(email, '@[a-z]+') AS email_domain
FROM z_regular_expression
;


SELECT 
    email, 
    SUBSTR(email, INSTR(email, '@') + 1) AS email_domain
FROM 
    z_regular_expression;











SELECT 
    email, 
    REGEXP_SUBSTR(email, '@(.+)', 1, 1, NULL, 1) AS email_domain
FROM 
    z_regular_expression;

SELECT REGEXP_SUBSTR(email, '@[a-z]+') AS extracted_part
FROM z_regular_expression;



SELECT REGEXP_SUBSTR(email, '@(.*)') AS extracted_part
FROM z_regular_expression;


SELECT REGEXP_SUBSTR(email, '@(.{1,5})') AS extracted_part
FROM z_regular_expression;

SELECT REGEXP_SUBSTR(email, '@(.*)') AS extracted_part
FROM z_regular_expression;

SELECT
	REGEXP_SUBSTR(email, '@[a-z]+') AS extracted_part,
    REGEXP_SUBSTR(email, '@(.*)') AS extracted_part1,
    REGEXP_SUBSTR(email, '@([^.]+)') AS extracted_part2

FROM z_regular_expression;


SELECT REGEXP_SUBSTR(email, '@([^.]+)', 1, 1, NULL, 1) AS company_name
FROM z_regular_expression;

SELECT SUBSTRING_INDEX(SUBSTRING_INDEX(email, '@', -1), '.', 1) AS company_name
FROM z_regular_expression;