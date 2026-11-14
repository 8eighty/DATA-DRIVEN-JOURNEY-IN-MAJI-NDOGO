-- Querying the database 
SELECT *
FROM data_dictionary;

-- Selecting employee name column
SELECT *
FROM employee;

SELECT 
	employee_name
FROM employee;

-- Replacing it with a full stop
SELECT 
	REPLACE(employee_name, " ", ".")
FROM employee;

-- Making it lower case
SELECT 
	LOWER(REPLACE(employee_name, " ", "."))
FROM employee;

-- Stitching it all together 
SELECT
	CONCAT(LOWER(REPLACE(employee_name, " ", ".")), "@ndogowater.gov") AS NEW_EMAIL
FROM employee;

-- Updating employee table to include emails: DONE

-- Eliminating leading or trailing spaces 
SELECT
    TRIM(phone_number)
FROM employee;

-- Updating tables to reflect trim: DONE 

-- Counting the number of employees who live in each town
SELECT
	count(assigned_employee_id) AS NUMBER_OF_EMPLOYEES_PER_TOWN,
	town_name
FROM employee
GROUP BY town_name;

-- Sourcing details of employees with the most location visits (name, email address, phone number)
SELECT *
FROM visits;

SELECT
	visits.assigned_employee_id AS EMPLOYEE_ID,
	employee.employee_name AS EMPLOYEE_NAME,
	employee.email AS EMAIL,
	employee.phone_number AS PHONE_NO,
	count(visits.location_id) AS NUMBER_OF_VISITS_PER_EMPLOYEE
FROM visits
JOIN employee
ON employee.assigned_employee_id = visits.assigned_employee_id
GROUP BY visits.assigned_employee_id
ORDER BY visits.assigned_employee_id DESC
LIMIT 3;


-- Records per town in Maji Ndogo
SELECT
	count(location_id) AS RECORDS_PER_TOWN,
    town_name
FROM location
GROUP BY town_name
ORDER BY RECORDS_PER_TOWN  DESC;


-- Records per province in Maji Ndogo
SELECT
	count(location_id) AS RECORDS_PER_TOWN,
	province_name
FROM location
GROUP BY province_name
ORDER BY RECORDS_PER_TOWN  DESC;

-- Aggregating both records per town and per province
SELECT
	province_name,
    town_name,
	count(location_id) AS RECORDS_PER_TOWN
FROM location
GROUP BY province_name, town_name
ORDER BY province_name, RECORDS_PER_TOWN  DESC;

-- Number of records per location type 
SELECT
	count(location_id) AS RECORDS_PER_TOWN,
	location_type
FROM location
GROUP BY location_type;

-- Number of people undergoing this survey
SELECT
	SUM(number_of_people_served) AS TOTAL_NUMBER_OF_PEOPLE_IN_SURVEY
FROM water_source;

-- Number of wells, taps and rivers
SELECT
	type_of_water_source,
	count(type_of_water_source) AS NO_OF_WATER_SOURCES
FROM water_source
GROUP BY type_of_water_source;

-- Average number of people served per water source
SELECT
	type_of_water_source,
	ROUND(avg(number_of_people_served)) AS AVG_NUMBER_OF_PEOPLE_SERVED
FROM water_source
GROUP BY type_of_water_source;

-- Total number of people served per water source in the survey
SELECT
	type_of_water_source,
	SUM(number_of_people_served) AS TOTAL_NUMBER_OF_PEOPLE_SERVED
FROM water_source
GROUP BY type_of_water_source;

-- Percentage of people served per water source 
SELECT
	type_of_water_source,
	CONCAT(ROUND(SUM(number_of_people_served)/27628140 * 100), "%") AS PERCENTAGE_OF_PEOPLE_SERVED
FROM water_source
GROUP BY type_of_water_source
ORDER BY PERCENTAGE_OF_PEOPLE_SERVED ASC;

/* START OF A SOLUTION */

-- Ranking without tap_in_home
SELECT 
	type_of_water_source,
    SUM(number_of_people_served) AS TOTAL_NUMBER_OF_PEOPLE_SERVED,
RANK() OVER (ORDER BY  SUM(number_of_people_served) DESC) AS RANKING_BY_POPULATION_SIZE
FROM water_source
WHERE type_of_water_source != "tap_in_home"
GROUP BY type_of_water_source
ORDER BY TOTAL_NUMBER_OF_PEOPLE_SERVED DESC;

-- Ranking sources together with type_of_water_source
SELECT 
	*,
	RANK() OVER ( PARTITION BY type_of_water_source ORDER BY number_of_people_served DESC) AS PRIORITY_RANK
FROM water_source
WHERE type_of_water_source != "tap_in_home"
ORDER BY type_of_water_source, number_of_people_served DESC;

-- How long did the survey take?
SELECT
	DATEDIFF(MAX(visits.time_of_record), MIN(visits.time_of_record)) AS DURATION_OF_SURVEY
FROM visits;

-- How long do people queue for water on average if they don't have taps in their home?
SELECT
	AVG(time_in_queue)
FROM visits
WHERE time_in_queue != 0;

-- How long do people have to queue each day of the week?
SELECT
	DAYNAME(time_of_record) AS DAY_OF_THE_WEEK,
	ROUND(AVG(time_in_queue), 0) AS AVG_TIME_IN_QUEUE
FROM visits
WHERE time_in_queue != 0
GROUP BY DAY_OF_THE_WEEK;

-- Average queue times per hour of the day
SELECT
	TIME_FORMAT(TIME(time_of_record), "%H:00") AS HOUR_OF_DAY,
    ROUND(AVG(time_in_queue), 0) AS AVG_TIME_IN_QUEUE
FROM visits
WHERE time_in_queue != 0
GROUP BY HOUR_OF_DAY
ORDER BY HOUR_OF_DAY ASC;

-- Creating a pivot table in SQL showing queue times according to days of the week
SELECT 
	TIME_FORMAT(TIME(time_of_record), "%H:00") AS HOUR_OF_DAY,
    -- Sunday
    ROUND (AVG(
		CASE
        WHEN DAYNAME(time_of_record) = "Sunday" THEN time_in_queue
        ELSE NULL
	END
		),0) as Sunday,
	-- Monday
    ROUND (AVG(
		CASE
        WHEN DAYNAME(time_of_record) = "Monday" THEN time_in_queue
        ELSE NULL
	END
		),0) as Monday,
    -- Tuesday
    ROUND (AVG(
		CASE
        WHEN DAYNAME(time_of_record) = "Tuesday" THEN time_in_queue
        ELSE NULL
	END
		),0) as Tuesday,
    -- Wednesday
    ROUND (AVG(
		CASE
        WHEN DAYNAME(time_of_record) = "Wednesday" THEN time_in_queue
        ELSE NULL
	END
		),0) as Wednesday,
    -- Thursday
    ROUND (AVG(
		CASE
        WHEN DAYNAME(time_of_record) = "Thursday" THEN time_in_queue
        ELSE NULL
	END
		),0) as Thursday,
    -- Friday
    ROUND (AVG(
		CASE
        WHEN DAYNAME(time_of_record) = "Friday" THEN time_in_queue
        ELSE NULL
	END
		),0) as Friday,
    -- Saturday
    ROUND (AVG(
		CASE
        WHEN DAYNAME(time_of_record) = "Saturday" THEN time_in_queue
        ELSE NULL
	END
		),0) as Saturday
FROM visits
WHERE time_in_queue != 0
GROUP BY HOUR_OF_DAY
ORDER BY HOUR_OF_DAY;
    










    