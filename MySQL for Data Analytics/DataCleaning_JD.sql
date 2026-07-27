-- Removing duplicates!


SELECT * FROM bakery.customer_sweepstakes;

-- ALTER TABLE bakery.customer_sweepstakes RENAME COLUMN `ï»¿sweepstake_id` TO `sweepstake_id`;

-- getting duplicate rows - process1
SELECT customer_id, COUNT(customer_id)
FROM bakery.customer_sweepstakes
GROUP BY customer_id
HAVING COUNT(customer_id) > 1
;

-- getting duplicate rows - process2
SELECT *
FROM
(SELECT customer_id,
ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY customer_id) AS row_num
FROM bakery.customer_sweepstakes)AS row_tables
WHERE row_num > 1
;

-- Deleting DUPLICATE ROWS

DELETE FROM customer_sweepstakes
WHERE sweepstake_id IN
(
	SELECT sweepstake_id
	FROM
		(SELECT
			sweepstake_id,
			ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY customer_id) AS row_num
		FROM customer_sweepstakes) AS row_duplicate
		WHERE row_num > 1
)
;

















-- Standardize Data

SELECT
		phone,
        REGEXP_REPLACE(phone, '[-,(,),/]', '')  AS phone_clean
FROM customer_sweepstakes
;

UPDATE customer_sweepstakes
SET phone = REGEXP_REPLACE(phone, '[-,(,),/]', '')
;



SELECT	phone, CONCAT(SUBSTRING(phone, 1,3),'-', SUBSTRING(phone, 4,3),'-', SUBSTRING(phone, 7,4))
FROM customer_sweepstakes
WHERE phone <> 0
;

UPDATE customer_sweepstakes
SET phone = CONCAT(SUBSTRING(phone, 1,3),'-', SUBSTRING(phone, 4,3),'-', SUBSTRING(phone, 7,4))
WHERE phone <> 0
;

SELECT	*
FROM customer_sweepstakes
;

SELECT	birth_date,
STR_TO_DATE(birth_date, '%m/%d/%Y') AS date_format
FROM customer_sweepstakes
;

SELECT 
    birth_date, 
    STR_TO_DATE(birth_date, '%d-%m-%Y') AS formatted_birth_date
FROM 
    customer_sweepstakes;
    
SELECT 
    birth_date, 
    STR_TO_DATE(birth_date, '%d/%m/%Y') AS formatted_birth_date
FROM 
    customer_sweepstakes;
    
SELECT 
    birth_date, 
    STR_TO_DATE(birth_date, '%d/%m/%Y') AS formatted_birth_date
FROM 
    customer_sweepstakes;

SELECT	birth_date,
STR_TO_DATE(birth_date, '%m/%d/%Y') AS date_format,
STR_TO_DATE(birth_date, '%Y/%d/%m') AS date_format2
FROM customer_sweepstakes
;




SELECT	birth_date,
	IF (STR_TO_DATE(birth_date, '%m/%d/%Y') IS NOT NULL, STR_TO_DATE(birth_date, '%m/%d/%Y'), STR_TO_DATE(birth_date, '%Y/%d/%m')),
STR_TO_DATE(birth_date, '%m/%d/%Y') AS date_format,
STR_TO_DATE(birth_date, '%Y/%d/%m') AS date_format2
FROM customer_sweepstakes
;


UPDATE customer_sweepstakes
SET birth_date = IF (STR_TO_DATE(birth_date, '%m/%d/%Y') IS NOT NULL, STR_TO_DATE(birth_date, '%m/%d/%Y'), STR_TO_DATE(birth_date, '%Y/%d/%m'))
;

SELECT	birth_date
FROM customer_sweepstakes
;

-- Real One update
UPDATE customer_sweepstakes
SET birth_date =
CASE
WHEN STR_TO_DATE(birth_date, '%m/%d/%Y') IS NOT NULL THEN STR_TO_DATE(birth_date, '%m/%d/%Y')
WHEN STR_TO_DATE(birth_date, '%m/%d/%Y') IS NULL THEN STR_TO_DATE(birth_date, '%Y/%d/%m')
END
;

SELECT	birth_date, CONCAT(SUBSTRING(birth_date, 9, 2),'/', SUBSTRING(birth_date, 6, 2),'/', SUBSTRING(birth_date, 1, 4))
FROM customer_sweepstakes
;

UPDATE customer_sweepstakes
SET birth_date = CONCAT(SUBSTRING(birth_date, 9, 2),'/', SUBSTRING(birth_date, 6, 2),'/', SUBSTRING(birth_date, 1, 4))
WHERE sweepstake_id IN(9,11)
;

SELECT *
FROM customer_sweepstakes
;


UPDATE customer_sweepstakes
SET birth_date = STR_TO_DATE(birth_date, '%m/%d/%Y')
;
















-- Data cleaning on the "Over 18" Yes/No column!!

SELECT `Are you over 18?`
FROM customer_sweepstakes
;

SELECT `Are you over 18?`,
	CASE
		WHEN `Are you over 18?` = 'Yes' THEN 'Y'
        WHEN `Are you over 18?` = 'No' THEN 'N'
        ELSE `Are you over 18?`
	END AS age_check
FROM customer_sweepstakes
;


UPDATE customer_sweepstakes
SET `Are you over 18?` =  
						CASE
						WHEN `Are you over 18?` = 'Yes' THEN 'Y'
						WHEN `Are you over 18?` = 'No' THEN 'N'
						ELSE `Are you over 18?`
						END
;


SELECT *
FROM customer_sweepstakes
;



















SELECT *
FROM customer_sweepstakes
;

SELECT address,
SUBSTRING_INDEX(address,',', 1) AS street,
SUBSTRING_INDEX(address,',', -1) AS state
FROM customer_sweepstakes
;



SELECT address,
SUBSTRING_INDEX(address,',', 1) AS street,
SUBSTRING_INDEX(SUBSTRING_INDEX(address,',', 2),',', -1) city,
SUBSTRING_INDEX(address,',', -1) state
FROM customer_sweepstakes
;




SELECT *
FROM customer_sweepstakes
;



ALTER TABLE customer_sweepstakes
ADD COLUMN street VARCHAR(50) AFTER address,
ADD COLUMN city VARCHAR(50) AFTER street,
ADD COLUMN state VARCHAR(50) AFTER city
;



SELECT address,
SUBSTRING_INDEX(address,',', 1) AS street,
SUBSTRING_INDEX(SUBSTRING_INDEX(address,',', 2),',', -1) city,
SUBSTRING_INDEX(address,',', -1) state
FROM customer_sweepstakes
;

UPDATE customer_sweepstakes
SET street = SUBSTRING_INDEX(address,',', 1),
	city = SUBSTRING_INDEX(SUBSTRING_INDEX(address,',', 2),',', -1),
	state = SUBSTRING_INDEX(address,',', -1)
;







SELECT *
FROM customer_sweepstakes
;


SELECT state, UPPER(STATE)
FROM customer_sweepstakes
;

SELECT state, UPPER(STATE)
FROM customer_sweepstakes
;

UPDATE customer_sweepstakes
SET state = UPPER(state)
;




SELECT city, TRIM(city)
FROM customer_sweepstakes
;

UPDATE customer_sweepstakes
SET city = TRIM(city)
;

UPDATE customer_sweepstakes
SET state = TRIM(state)
;


SELECT *
FROM customer_sweepstakes
;







SELECT COUNT(sweepstake_id), count(phone)
FROM customer_sweepstakes
;



SELECT *
FROM customer_sweepstakes
;

UPDATE customer_sweepstakes
SET phone = NULL
WHERE phone = ''
;

UPDATE customer_sweepstakes
SET income = NULL
WHERE income = ''
;

SELECT income, AVG(income)
FROM customer_sweepstakes
WHERE income IS NOT NULL
GROUP BY income
;

SELECT birth_date, `Are you over 18?`
FROM customer_sweepstakes
WHERE (YEAR(NOW()) - 18) < YEAR(birth_date)
;

UPDATE customer_sweepstakes
SET `Are you over 18?` = 'N'
WHERE (YEAR(NOW()) - 18) < YEAR(birth_date)
;

UPDATE customer_sweepstakes
SET `Are you over 18?` = 'Y'
WHERE (YEAR(NOW()) - 18) > YEAR(birth_date)
;

SELECT *
FROM customer_sweepstakes
;











SELECT *
FROM customer_sweepstakes
;












-- Deleting Unused Columns



ALTER TABLE customer_sweepstakes
DROP COLUMN address
;

ALTER TABLE customer_sweepstakes
DROP COLUMN favorite_color
;


SELECT *
FROM customer_sweepstakes
;



