-- Databricks notebook source
---Commanding databricks to use the "bright_tv" catalog under the "default" schema
USE bright_tv.default;

-- COMMAND ----------

---Running user profile table
SELECT *
FROM user_profiles
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
    `Social Media Handle`,
    CASE
        WHEN (`Social Media Handle` IS NOT NULL) AND TRIM(`Social Media Handle` <> ' ') AND (`Social Media Handle` <> 'None') THEN 1
        ELSE 0
    END AS sm_flag
FROM user_profiles;

-- COMMAND ----------

---Create a email flag
SELECT
    Email,
    CASE
        WHEN (`Email` IS NOT NULL) AND TRIM(`Email` <> ' ') AND (`Email` <> 'None') THEN 1
        ELSE 0
    END AS email_flag
FROM user_profiles;

-- COMMAND ----------

---Create a temporary table from user profiles
CREATE OR REPLACE TEMPORARY TABLE user_profile AS (
SELECT userID,

    CASE 
        WHEN gender = 'None' THEN 'Unknown' ---Replaces the value "None" with "Unknown"
        WHEN gender = ' ' THEN 'Unknown' ---Replace the blanks with "Unknown"
        ELSE gender
    END AS Clean_gender,

    CASE 
        WHEN race = 'None' THEN 'unknown' --Replaces the value "None" with "Unknown"
        WHEN race = ' ' THEN 'unknown' --Replace the blanks with "Unknown"
        WHEN race = 'other' THEN 'unknown' --Replace the other category with "Unknown"
        ELSE race
    END AS Clean_race,
    
    CASE 
        WHEN province = 'None' THEN 'Uncategorized' ---Replaces the value "None" with "Unknown"
        WHEN province = ' ' THEN 'Uncategorized' ---Replace the blanks with "Unknown"
        ELSE province
    END AS Clean_province

    CASE 
        WHEN age BETWEEN 0 AND 3 THEN 'Infant and toddlers' 
        WHEN age BETWEEN 4 AND 12 THEN 'Children'
        WHEN age BETWEEN 13 AND 19 THEN 'Adolescents / Teenagers'
        WHEN age BETWEEN 20 AND 39 THEN 'Young Adults'
        WHEN age BETWEEN 40 AND 64 THEN 'Middle-Aged Adults'
        ELSE 'Seniors / Older Adulthood'
    END AS age_groups,
            
    CASE
        WHEN (`Social Media Handle` IS NOT NULL) AND TRIM(`Social Media Handle` <> ' ') AND (`Social Media Handle` <> 'None') THEN 1
        ELSE 0
    END AS sm_flag

     CASE
        WHEN (`Email` IS NOT NULL) AND TRIM(`Email` <> ' ') AND (`Email` <> 'None') THEN 1
        ELSE 0
    END AS email_flag
);

-- COMMAND ----------

---Running viewership table
SELECT *
FROM viewership
LIMIT 10;

-- COMMAND ----------

---Determine number of subscribers
SELECT COUNT(DISTINCT UserID0) AS number_of_subs
FROM viewership;

-- COMMAND ----------

---Convert timestamp to date (YYYY-MM-DD)
SELECT TO_DATE(RecordDate2) AS watch_date
FROM viewership;

-- COMMAND ----------

---Determine the year of views
SELECT YEAR(RecordDate2) AS watch_year
FROM viewership;

-- COMMAND ----------

---Determine the day of views
SELECT DAYNAME(RecordDate2) AS watch_day
FROM viewership;

-- COMMAND ----------

---Determine the month of views
SELECT MONTHNAME(RecordDate2) AS watch_month
FROM viewership;

-- COMMAND ----------

---Change duration from timestamp to 
SELECT DATE_FORMAT(`Duration 2`,'HH:mm:ss') as duration_time
FROM viewership;

-- COMMAND ----------

---Combine User IDs into one
SELECT COALESCE(UserID0, UserID4) AS UserID
FROM viewership;

-- COMMAND ----------

---List of channels
SELECT DISTINCT Channel2
FROM viewership;

-- COMMAND ----------

---Creating day classification column
SELECT 
    CASE
        WHEN DAYNAME(RecordDate2) IN ('Sat','Sun') THEN 'Weekend'
    ELSE 'Weekday'
    END AS Day_Classification
FROM viewership;

-- COMMAND ----------

---Creating temporary table
---CREATE OR REPLACE TEMPORARY TABLE Viewerships AS (
    SELECT 
        COALESCE(UserID0, UserID4) AS UserID,
        COUNT(DISTINCT UserID0) AS number_of_subs, 
        TO_DATE(RecordDate2) AS watch_date, 
        DAYNAME(TO_DATE(RecordDate2)) AS watch_day, 
        MONTHNAME(TO_DATE(RecordDate2)) AS watch_month, 
        YEAR(TO_DATE(RecordDate2)) AS watch_year, 
        DATE_FORMAT(`Duration 2`,'HH:mm:ss') as duration_time,
        CASE 
            WHEN DAYNAME(RecordDate2) IN ('Sat', 'Sun') THEN '02. Weekend' 
            ELSE '01. Weekday' 
        END AS day_classification
    FROM viewership 
    WHERE UserID0 IS NOT NULL 
    GROUP BY ALL 
    ORDER BY watch_date DESC
---);

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
