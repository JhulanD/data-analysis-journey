-- Project_02_US Household Income


-- Project_02_US Household Income - Data Cleaning

SELECT * FROM us_income_project.us_household_income_statistics;
SELECT * FROM us_income_project.us_household_income;

ALTER  TABLE us_household_income_statistics
RENAME COLUMN `ï»¿id` TO id;

SELECT id, COUNT(id)
FROM us_household_income
GROUP BY id
HAVING COUNT(id) > 1
;



SELECT *
FROM (
SELECT 	row_id,
		id,
        ROW_NUMBER() OVER(PARTITION BY id ORDER BY id) AS row_num
FROM us_household_income) AS duplicates
WHERE row_num > 1
;




DELETE FROM us_household_income
WHERE row_id IN (
				SELECT row_id
				FROM	(
						SELECT 
                        row_id,
                        id,
						ROW_NUMBER() OVER(PARTITION BY id ORDER BY id) AS row_num
						FROM us_household_income
                        ) AS duplicates
				WHERE row_num > 1)
;





SELECT  DISTINCT State_Name
FROM us_income_project.us_household_income
ORDER BY 1
;


UPDATE us_household_income
SET State_Name = 'Georgia'
WHERE State_Name = 'georia'
;

UPDATE us_household_income
SET State_Name = 'Alabama'
WHERE State_Name = 'alabama'
;

SELECT *
FROM us_household_income
WHERE Place = ''
;

UPDATE us_household_income
SET Place = 'Autaugaville'
WHERE Place = '' AND City = 'Vinemont' AND County = 'Autauga County'
;

SELECT Type, COUNT(Type)
from us_household_income
GROUP BY Type
;

UPDATE us_household_income
SET Type = 'Borough'
WHERE Type = 'Boroughs'
;


SELECT *
FROM us_household_income
;

SELECT  ALand, AWater
FROM us_household_income
WHERE (AWater = 0  OR AWater = '' OR AWater IS NULL)
AND  (ALand = 0  OR ALand= '' OR ALand IS NULL)
;


-- Project_02_US Household Income - Exploratory Data Analysis


SELECT *
FROM us_household_income
;
SELECT *
FROM us_household_income_statistics
;


SELECT State_Name, SUM(ALand), SUM(AWater)
FROM us_household_income
GROUP BY State_Name
ORDER BY 3 DESC
LIMIT 10
;





SELECT *
FROM us_household_income uhi
INNER JOIN us_household_income_statistics uhis
	ON uhi.id = uhis.id
    WHERE Mean <> 0
;


SELECT uhi.State_Name, ROUND(AVG(Mean),1), ROUND(AVG(Median),1)
FROM us_household_income uhi
INNER JOIN us_household_income_statistics uhis
	ON uhi.id = uhis.id
WHERE Mean <> 0
GROUP BY UHI.State_Name
ORDER BY  2 DESC
LIMIT 10
; 


SELECT ui.State_Name, ui.City, ROUND(AVG(Mean)), ROUND(AVG(Median))
FROM us_household_income ui
INNER JOIN us_household_income_statistics uis
ON ui.id = uis.id
-- WHERE Mean <> 0
GROUP BY ui.State_Name, ui.City
ORDER BY 3 DESC
LIMIT 20
;