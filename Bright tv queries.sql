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

SELECT DISTINCT
            CASE
                WHEN Race = 'other' THEN 'Unknown'
                WHEN Race = 'None' THEN 'Unknown'
            ELSE Race
            END AS clean_race;
