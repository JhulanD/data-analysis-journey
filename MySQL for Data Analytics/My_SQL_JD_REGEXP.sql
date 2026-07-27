SELECT *
FROM customers
WHERE city REGEXP 'c*on'
;

SELECT * FROM customers
WHERE address REGEXP 'main|south|lane'
;


SELECT * FROM customers
WHERE last_name REGEXP '[cd]o'
;

SELECT * FROM customers
WHERE first_name REGEXP '^(don|An|Fin)'
;


SELECT * FROM customers
WHERE first_name REGEXP '^[a-z].{6}$'
;