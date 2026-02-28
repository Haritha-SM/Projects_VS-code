SELECT 
    job_title_short,
    job_location
FROM job_postings_fact;

/* Label new column as follows:
- 'Anywhere' jobs as 'Remote'
- 'New York, 'NY' jobs as 'Local'
-Otherwise 'Onsite'*/

-- CASE EXPRESSION
SELECT
    job_title_short,
    job_location,
    CASE 
        WHEN job_location = 'Anywhere' THEN 'Remote'
        WHEN job_location = 'New York, NY' THEN 'Local'
        ELSE 'Onsite'
    END AS location_category
FROM january_jobs;

-- CASE EXPRESSION e.g.,2
SELECT
    COUNT(job_id) AS number_of_jobs,
    CASE 
        WHEN job_location = 'Anywhere' THEN 'Remote'
        WHEN job_location = 'New York, NY' THEN 'Local'
        ELSE 'Onsite'
    END AS location_category
FROM january_jobs
WHERE job_title_short = 'Data Analyst'
GROUP BY location_category;

-- PRACTICE PROBLEM

SELECT
    job_title_short,
    salary_year_avg,
    CASE
        WHEN salary_year_avg >= 100000 THEN 'High Salary'
        WHEN salary_year_avg BETWEEN 70000 AND 99999 THEN 'Standard Salary'
        ELSE 'Low Salary'
    END AS salary_category
FROM job_postings_fact
WHERE job_title_short = 'Data Analyst' 
    AND salary_year_avg IS NOT NULL
ORDER BY 
    CASE
        WHEN salary_year_avg >= 100000 THEN 1
        WHEN salary_year_avg BETWEEN 70000 AND 99999 THEN 2
        ELSE 3
    END;





