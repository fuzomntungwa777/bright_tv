-- Databricks notebook source
---Commanding databricks to use the "bright_tv" catalog under the "default" schema
USE bright_tv.default;

-- COMMAND ----------

---Running user profile table
SELECT *
FROM user_profiles
LIMIT 10;

-- COMMAND ----------

---Running viewership table
SELECT *
FROM viewership
LIMIT 10;

-- COMMAND ----------

---Checking for duplicates in user profiles
SELECT userID,
    COUNT (*) AS duplicate_id
FROM user_profiles
GROUP BY userID
HAVING count(*)>1;

-- COMMAND ----------

---Checking size of data
SELECT COUNT(*),
    COUNT (DISTINCT userID) AS num_subs
FROM user_profiles;

-- COMMAND ----------

---Checking if userID has nulls
SELECT count(*)
FROM user_profiles
WHERE userID IS NULL;

-- COMMAND ----------

---Checking genders of viewers
SELECT DISTINCT gender
FROM user_profiles;

-- COMMAND ----------

---Cleaning up gender column
SELECT DISTINCT 
                CASE 
                    WHEN gender = 'None' THEN 'Unknown' ---Replaces the value "None" with "Unknown"
                    WHEN gender = ' ' THEN 'Unknown' ---Replace the blanks with "Unknown"
                ELSE gender
                END AS Clean_gender
FROM user_profiles;

-- COMMAND ----------

---Checking race of viewers

SELECT DISTINCT Race
FROM user_profiles;

-- COMMAND ----------

---Cleaning race column
SELECT DISTINCT 
                CASE 
                    WHEN race = 'None' THEN 'unknown' --Replaces the value "None" with "Unknown"
                    WHEN race = ' ' THEN 'unknown' --Replace the blanks with "Unknown"
                    WHEN race = 'other' THEN 'unknown' --Replace the other category with "Unknown"
                ELSE race
                END AS Clean_race
FROM user_profiles;

-- COMMAND ----------

---Checking province of viewers

SELECT DISTINCT province
FROM user_profiles;

-- COMMAND ----------

---Cleaning province column
SELECT DISTINCT 
                CASE 
                    WHEN province = 'None' THEN 'Uncategorized' ---Replaces the value "None" with "Unknown"
                    WHEN province = ' ' THEN 'Uncategorized' ---Replace the blanks with "Unknown"
                ELSE province
                END AS Clean_province
FROM user_profiles;

-- COMMAND ----------

---Checking age column
SELECT MIN(Age) AS min_age,
    MAX(Age) AS max_age
FROM user_profiles;

-- COMMAND ----------

---Categorize the age into age groups

SELECT userID,
    CASE 
        WHEN age BETWEEN 0 AND 3 THEN 'Infant and toddlers' 
        WHEN age BETWEEN 4 AND 12 THEN 'Children'
        WHEN age BETWEEN 13 AND 19 THEN 'Adolescents / Teenagers'
        WHEN age BETWEEN 20 AND 39 THEN 'Young Adults'
        WHEN age BETWEEN 40 AND 64 THEN 'Middle-Aged Adults'
        ELSE 'Seniors / Older Adulthood'
    END AS age_groups
FROM user_profiles;

-- COMMAND ----------

---Create a social media flag
SELECT
    CASE
        WHEN (`Social Media Handle` IS NOT NULL) OR (`Social Media Handle` = ' ') OR (`Social Media Handle` NOT IN ('None')) THEN 1
        ELSE 0
    END AS sm_flag
FROM user_profiles;

-- COMMAND ----------

---Create a email flag
SELECT
    CASE
        WHEN (`Email` IS NOT NULL) OR (`Email` = ' ') OR (`Email` NOT IN ('None')) THEN 1
        ELSE 0
    END AS email_flag
FROM user_profiles;

-- COMMAND ----------

---Creating temporary table
CREATE OR REPLACE TEMPORARY TABLE Subs AS (
    SELECT 
        COUNT(DISTINCT UserID0) AS number_of_subs, 
        TO_DATE(RecordDate2) AS watch_date, 
        DAYNAME(TO_DATE(RecordDate2)) AS Day_name, 
        MONTHNAME(TO_DATE(RecordDate2)) AS Month_name, 
        YEAR(TO_DATE(RecordDate2)) AS event_year, 
        CASE 
            WHEN DAYNAME(TO_DATE(RecordDate2)) IN ('Sat', 'Sun') THEN '02. Weekend' 
            ELSE '01. Weekday' 
        END AS day_classification 
    FROM viewership 
    WHERE UserID0 IS NOT NULL 
    GROUP BY ALL 
    ORDER BY watch_date DESC
);

-- COMMAND ----------

---Checking temporary table
SELECT *
FROM subs;

-- COMMAND ----------

SELECT
    SUM(number_of_subs) AS subs,
    day_classification
FROM Subs
GROUP BY day_classification;
