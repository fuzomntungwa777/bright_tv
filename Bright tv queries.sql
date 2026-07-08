-- Databricks notebook source
---Commanding databricks to use the "bright_tv" catalog under the "default" schema
USE bright_tv.default;

-- COMMAND ----------

---Running user profile table
SELECT *
FROM user_profiles;

-- COMMAND ----------

---Running viewership table
SELECT *
FROM viewership;

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
                    WHEN race = 'None' THEN 'unknown' ---Replaces the value "None" with "Unknown"
                    WHEN race = ' ' THEN 'unknown' ---Replace the blanks with "Unknown"
                ELSE race
                END AS Clean_race
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
