SELECT *
FROM products
WHERE product_id IN
	(SELECT product_id
    FROM ordered_items
    WHERE quantity>75
    )
;


SELECT *
FROM products p
WHERE EXISTS
	(SELECT product_id
    FROM ordered_items
    WHERE product_id = p.product_id
    )
;



SELECT 	product_id,
		quantity,
        (SELECT SUM(quantity) FROM ordered_items) AS sum_quantity,
        (quantity/(SELECT SUM(quantity) FROM ordered_items) * 100) AS percent_quantity
FROM ordered_items
;




SELECT product_id, quantity, avg_quantity
FROM	(SELECT product_id, quantity,
		(SELECT AVG(quantity) FROM ordered_items) AS avg_quantity
		FROM ordered_items) AS avg_quant
;



SELECT
	c.customer_id,
    first_name,
    order_total,
	MAX(order_total) OVER(PARTITION BY c.first_name) AS max_order_total
FROM customers c
JOIN customer_orders co
	ON c.customer_id=co.customer_id
;


SELECT *
FROM
	(
SELECT
	c.customer_id,
    first_name,
    order_total,
	ROW_NUMBER() OVER(PARTITION BY c.customer_id ORDER BY order_total ASC) AS row_num
FROM customers c
JOIN customer_orders co
	ON c.customer_id=co.customer_id
    ) AS row_total_num
WHERE row_num <= 3
;

SELECT *,
RANK() OVER(PARTITION BY department ORDER BY salary DESC) rank_,
DENSE_RANK() OVER(PARTITION BY department ORDER BY salary DESC) dense_rank_
FROM employees
;


SELECT *,
LAG(salary) OVER(PARTITION BY department ORDER BY employee_id) as lag_sql,
LEAD(salary) OVER(PARTITION BY department ORDER BY employee_id) as lag_sql
FROM employees
;

-- Regular Expression
SELECT *
FROM customers
WHERE first_name REGEXP 'K';

SELECT first_name, REGEXP_REPLACE(first_name,'a', 'x')
FROM customers
;

SELECT first_name, REGEXP_LIKE(first_name,'a')
FROM customers
;


SELECT first_name, REGEXP_INSTR(first_name,'a')
FROM customers
;


SELECT first_name, REGEXP_SUBSTR(first_name,'gg')
FROM customers
;


SELECT *
FROM customers
WHERE city REGEXP '^d'
;


SELECT *
FROM customers
WHERE city REGEXP 'n$'
;




SELECT *
FROM customers
WHERE city REGEXP 'l.?s'
;







SELECT *
FROM customers
WHERE city REGEXP 'chi|ton'
;

SELECT *
FROM customers
WHERE city REGEXP 'Chicago'
;


CREATE TABLE email_comparison (
    original_email VARCHAR(255),
    company_name VARCHAR(255)
);

INSERT INTO email_comparison (original_email)
VALUES 
('john.doe@gmail.com'),
('jane.smith@yahoo.com'),
('info@apple.com');

SELECT 
    original_email,
    SUBSTRING_INDEX(SUBSTRING_INDEX(original_email, '@', -1), '.', 1) AS company_name
FROM email_comparison;