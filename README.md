# Data-Driven Journey in Maji Ndogo | SQL Data Analysis & Cleaning

## Project Overview

This project represents my SQL-driven analytical journey into **Maji Ndogo Water Services**, where I explored water service datasets, investigated water quality concerns, and performed data cleaning to improve the accuracy and reliability of records.

Using SQL, I analyzed multiple relational tables to understand water source types, visit records, water quality scores, and pollution data. I also identified inconsistencies in water pollution records and implemented data cleaning techniques to correct misleading classifications.

This project demonstrates my ability to transform raw data into structured, reliable information using SQL — a fundamental skill in data analytics and data-driven decision-making.

## Project Objectives

The key objectives of this project were to:

- Explore and understand the structure of the Maji Ndogo Water Services database.
- Retrieve and analyze records from multiple tables.
- Identify different types of water sources.
- Investigate long queue times at water collection points.
- Analyze water quality scores and visit frequency.
- Detect inconsistencies in well pollution records.
- Perform data cleaning and standardization.
- Validate data corrections using SQL queries.
- Apply relational database concepts to real-world analytical problems.

## Tools & Technologies

| Tool / Technology | Application |
|---|---|
| SQL | Data querying, analysis, and manipulation |
| MySQL | Relational database management |
| MySQL Workbench | SQL query execution and database exploration |
| GitHub | Project documentation and portfolio presentation |

## Database Tables Explored

The project involved exploring the following tables within the `md_water_services` database:

| Table | Description |
|---|---|
| `location` | Contains location-related records |
| `visits` | Stores water source visit records and queue information |
| `water_source` | Contains information about different water source types |
| `water_quality` | Stores water quality assessment records |
| `well_pollution` | Contains well pollution test results and descriptions |

These tables provided the foundation for querying, joining, and analyzing water service data.

## Key SQL Tasks & Analysis

### 1. Database Exploration

I began by exploring the database structure and inspecting the contents of the available tables.

Key SQL techniques:
- `SHOW TABLES`
- `SELECT *`
- `SELECT DISTINCT`

This helped me understand the database schema and identify relevant datasets for further analysis.

### 2. Water Source Analysis

I explored the different types of water sources available within the dataset and retrieved records using specific source IDs.

SQL techniques applied:
- `SELECT DISTINCT`
- `WHERE`
- `IN`
- `OR`

I also compared the use of the `IN` operator against multiple `OR` conditions to demonstrate a more concise and efficient approach to filtering records.

### 3. Investigation of Long Queue Times

I identified water service visits where the queue time exceeded 500 minutes (more than 8 hours).

This analysis focused on investigating potentially excessive waiting times at water collection points.

```sql
SELECT *
FROM visits
WHERE time_in_queue > 500;
```

### 4. Water Quality Analysis

I combined data from the `water_source`, `visits`, and `water_quality` tables to investigate records matching specific water quality criteria.

The analysis focused on:
- Water sources classified as `tap_in_home`.
- A subjective water quality score of 10.
- A visit count greater than or equal to 2.

SQL techniques applied:
- `INNER JOIN`
- `ON`
- `WHERE`
- Multiple filtering conditions

This demonstrated my ability to work with relational datasets and extract meaningful records through multi-table joins.

### 5. Well Pollution Investigation

One of the major analytical tasks involved identifying inconsistencies in the `well_pollution` table.

I investigated records where:
- The pollution result was classified as `Clean`.
- Biological contamination was greater than `0.01`.
- The description contained a contradictory clean classification.

This was an important data quality investigation because inconsistent labels can affect the reliability of subsequent analysis.

### 6. Data Cleaning & Standardization

I performed data cleaning operations to correct inconsistencies in the well pollution records.

The cleaning process involved:

- Correcting misleading descriptions related to *E. coli* contamination.
- Correcting misleading descriptions related to *Giardia Lamblia* contamination.
- Updating records classified as `Clean` despite biological contamination levels greater than `0.01`.
- Standardizing pollution result classifications.

Example SQL:

```sql
UPDATE well_pollution
SET results = 'Contaminated: Biological'
WHERE biological > 0.01
AND results = 'Clean';
```

This ensured that records meeting the specified contamination condition were no longer incorrectly classified as clean.

### 7. Data Validation & Quality Assurance

To maintain data integrity, I created a temporary copy of the `well_pollution` table before applying the cleaning operations.

I then:
- Applied cleaning updates to the copied table.
- Checked for remaining inconsistencies.
- Validated the cleaning logic using conditional queries.
- Dropped the temporary copy after the exercise.

This demonstrated an awareness of the importance of testing data transformations before applying them to production data.

## Key Skills Demonstrated

This project showcases my practical experience with:

- SQL data exploration
- Data cleaning and transformation
- Relational database querying
- Multi-table joins
- Conditional filtering
- Data quality assessment
- Data validation
- Database manipulation using `UPDATE`
- Temporary table creation using `CREATE TABLE AS SELECT`
- SQL logical operators
- Analytical problem-solving

## Project Value

The project demonstrates how SQL can be used to support data quality improvement and operational analysis within a water services context.

By investigating queue times, examining water quality records, and correcting pollution data inconsistencies, I applied analytical techniques to a real-world-inspired dataset where data reliability is important for decision-making.

The project also strengthened my understanding of how structured data can be explored, validated, and transformed into more trustworthy information.

## Repository Structure

```text
DATA-DRIVEN-JOURNEY-IN-MAJI-NDOGO/
│
├── DATA DRIVEN JOURNEY IN MAJI NDOGO.sql
│
└── README.md
```

## How to Run This Project

To reproduce the analysis:

1. Clone or download this repository.
2. Open MySQL Workbench.
3. Connect to your MySQL server.
4. Ensure the `md_water_services` database and required tables are available.
5. Open the SQL script.
6. Execute the queries sequentially.

**Note:** This project uses an existing database schema. The SQL script does not create the original database or populate it with source data.

Some queries modify records using `UPDATE`. If you are executing the script against an original database, ensure that you have a backup or use a test environment first.

## About Inimfon Inyang

I am an aspiring Data Analyst passionate about using data to uncover insights, solve problems, and support informed decision-making.

Through projects like this, I continue to develop my technical skills in SQL, data exploration, data cleaning, and analytical thinking.

I am eager to contribute my skills to organizations that value data-driven strategies and continuous improvement.

## Let's Connect: @ikinyang8@gmail.com

I welcome opportunities to collaborate, learn, and contribute to data analytics projects.

If you find this project interesting, feel free to explore the SQL script and connect with me.

⭐ If you find this project valuable, consider giving the repository a star!

---

**Project Focus:** SQL Data Analysis | Data Cleaning | Water Quality Analysis | Data Integrity  
**Database:** Maji Ndogo Water Services  
**Author:** Data Analyst Portfolio Project
