-- Data type conversion
SELECT 
    '2023-02-19'::DATE,
    '123'::INTEGER,
    'true'::BOOLEAN,
    '3.14'::REAL  ;

-- Date convertion
SELECT
    job_title_short AS title,
    job_location AS location,
    job_posted_date::DATE AS date
FROM job_postings_fact;

-- Time stamp without Time zone
SELECT
    job_title_short AS title,
    job_location AS location,
    job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'EST' AS date
FROM job_postings_fact
LIMIT 10;

-- Extract
SELECT
    job_title_short AS title,
    job_location AS location,
    job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'EST' AS date_time,
    EXTRACT(MONTH FROM job_posted_date) AS date_month,
    EXTRACT(YEAR FROM job_posted_date) AS date_year
FROM job_postings_fact
LIMIT 10;

-- Exercise
SELECT
    COUNT(job_id) AS job_posted_count,
    EXTRACT(MONTH FROM job_posted_date) AS month
FROM job_postings_fact
WHERE job_title_short = 'Data Analyst'
GROUP BY month
ORDER BY job_posted_count DESC;


-- PRACTICE PROBLEM 1
SELECT 
    job_schedule_type,
    AVG(salary_year_avg) AS yearly_avg,
    AVG(salary_hour_avg) AS hourly_avg
FROM job_postings_fact
WHERE job_posted_date > DATE '2023-06-01'
GROUP BY job_schedule_type;

-- PRACTICE PROBLEM 2
SELECT
    EXTRACT(MONTH FROM job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'America/New_York') AS month,
    COUNT(job_id) AS job_posted_count
FROM job_postings_fact
WHERE EXTRACT(YEAR FROM job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'America/New_York') = 2023
GROUP BY month
ORDER BY month;

-- PRACTICE PROBLEM 3
SELECT DISTINCT
    c.name AS company_name
FROM job_postings_fact j
JOIN company_dim c
    ON j.company_id = c.company_id
WHERE j.job_health_insurance = TRUE
  AND EXTRACT(YEAR FROM j.job_posted_date) = 2023
  AND EXTRACT(QUARTER FROM j.job_posted_date) = 2;


-- Creating Tables from Existing Table (PRACTICE PROBLEM) 
CREATE TABLE january_jobs AS 
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 1;
   
CREATE TABLE february_jobs AS 
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 2;

CREATE TABLE march_jobs AS 
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 3;


SELECT *
FROM march_jobs
LIMIT 20;



