# SHOWING TABLES IN MD WATER SERVICES 
SHOW TABLES;

# SHOWING LOCATION TABLE 
SELECT *
FROM location;

# SHOWING VISITS TABLE
SELECT *
FROM visits;

# SHOWING WATER SOURCES TABLE
SELECT *
FROM water_source;

# SELECTING UNIQUE TYPE OF WATER SOURCE
SELECT DISTINCT type_of_water_source
FROM water_source;

# SHOWING VISITS WHERE TIME IN QUEUE IS GREATER THAN 500 MIN (8 HOURS +)
SELECT *
FROM visits
WHERE time_in_queue > 500;

# SELECTING TYPE OF WATER SOURCE WITH SPECIFIC SOURCE IDS  (COOL WAY)
SELECT 
    water_source.*
FROM water_source
WHERE source_id IN ( "AkKi00881224", "AkLu01628224", "SoRu37635224" , "SoRu36096224", "AkRu05234224", "HaRu19601224", "HaZa21742224", "SoRu38776224");

# SELECTING TYPE OF WATER SOURCE WITH SPECIFIC SOURCE IDS  (NOT SO COOL WAY)
SELECT 
    water_source.*
FROM water_source
WHERE source_id = "AkKi00881224"
OR source_id = "AkLu01628224"
OR source_id = "SoRu37635224"
OR source_id = "SoRu36096224"
OR source_id = "AkRu05234224"
OR source_id = "HaRu19601224"
OR source_id = "HaZa21742224"
OR source_id = "SoRu38776224";

# FINDING TABLE FOR QUALITY OF WATER SOURCE
SELECT *
FROM water_quality;

# FINDING TABLE WITH QUALITY OF WATER SOURCE IS 10, TYPE OF WATER SOURCE IS HOME TAP AND VISIT COUNT IS 2
SELECT
	water_source.type_of_water_source,
    water_quality.subjective_quality_score,
    visits.visit_count
FROM water_source
JOIN visits
ON water_source.source_id = visits.source_id
JOIN water_quality
ON visits.record_id = water_quality.record_id
WHERE subjective_quality_score = 10 AND
visits.visit_count >= 2 AND
type_of_water_source = "tap_in_home";

# FINDING WELL POLLUTION TABLE
SELECT *
FROM well_pollution
LIMIT 5;

# RETURNING ROWS WHERE RESULT IS CLEAN AND BIOLOGICAL CONTAMINATION IS >0.01
SELECT *
FROM well_pollution
WHERE results = "Clean"
AND biological > 0.01;

# SELECTING ROWS WHERE RESULT IS CLEAN, BIOLOGICAL CONTAMINATION IS >0.01 AND DESCRIPTION WAS MISTAKENLY RETURNED AS CLEAN
SELECT *
FROM well_pollution
WHERE results = "Clean"
AND biological > 0.01
AND description LIKE "Clean_%";

SELECT*
FROM well_pollution;

# CHANGING SAFETY UPDATE MODE 

# UPDATING WELL POLLUTION TABLE
UPDATE well_pollution
SET description = "Bacteria: E.coli"
WHERE description = "Clean Bacteria: E.coli";


UPDATE well_pollution
SET description = "Bacteria: Giardia Lamblia"
WHERE description = "Clean Giardia Lamblia";

UPDATE well_pollution
SET results = "Contaminated: Biological"
WHERE biological > 0.01 AND
results = "Clean";

# CREATING COPY OF WELL POLLUTION TABLE
CREATE TABLE
	md_water_services.well_pollution_copy
AS (
	SELECT *
    FROM
		md_water_services.well_pollution
        );

# UPDATING WELL POLLUTION COPY TABLE
UPDATE well_pollution_copy
SET description = "Bacteria: E.coli"
WHERE description = "Clean Bacteria: E.coli";

UPDATE well_pollution_copy
SET description = "Bacteria: Giardia Lamblia"
WHERE description = "Clean Giardia Lamblia";


UPDATE well_pollution_copy
SET results = "Contaminated: Biological"
WHERE biological > 0.01 AND
results = "Clean";

# CHECKING FOR ERRORS IN WELL POLLUTION TABLE COPY
SELECT *
FROM well_pollution_copy
WHERE results = "Clean"
AND biological > 0.01
AND description LIKE "Clean_%";

# DROPPING WELL POLLUTION COPY TABLE
UPDATE well_pollution_copy
SET description = "Bacteria: E.coli"
WHERE description = "Clean Bacteria: E.coli";

UPDATE well_pollution_copy
SET description = "Bacteria: Giardia Lamblia"
WHERE description = "Clean Giardia Lamblia";

UPDATE well_pollution_copy
SET results = "Contaminated: Biological"
WHERE biological > 0.01 AND
results = "Clean";

DROP TABLE
	md_water_services.well_pollution_copy;
    

	
