-- SUBQUERY
SELECT *
FROM (-- SubQuery starts here
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 1
     ) AS january_jobs;
     -- SubQuery ends here

-- Subquery Example
SELECT company_id,
    name AS company_name
FROM company_dim
WHERE company_id IN (
    SELECT 
        company_id
    FROM job_postings_fact
    WHERE job_no_degree_mention = TRUE
    ORDER BY company_id
);


-- COMMON TABLE EXPRESSION (CTEs)
WITH january_jobs AS ( -- CTE definition starts here
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 1
    ) -- CTE definition ends here
SELECT *
FROM january_jobs;

/* CTE EXAMPLE
Find the companies that have the most job openings
- Get the total number of postings per company id (job_postings_fact)
- Return the total number of job postingd with company name (comoany_dim) */
WITH company_job_count AS (
    SELECT company_id,
        COUNT(*) AS total_jobs
    FROM job_postings_fact
    GROUP BY company_id
)
SELECT company_dim.name AS company_name,
    company_job_count.total_jobs
FROM company_dim
LEFT JOIN company_job_count 
ON company_job_count.company_id = company_dim.company_id
ORDER BY total_jobs DESC;



-- PRACTICE PROBLEM 1
SELECT sd.skills AS skill_name,
    skill_counts.skill_count
FROM (
    SELECT skill_id,
        COUNT(*) AS skill_count
    FROM skills_job_dim
    GROUP BY skill_id
    ORDER BY skill_count DESC
    LIMIT 5
    ) AS skill_counts
LEFT JOIN skills_dim AS sd
    ON skill_counts.skill_id = sd.skill_id
ORDER BY skill_counts.skill_count DESC;


-- PRACTICE PROBLEM 2 using SubQuery
SELECT cd.name AS company_name,
job_postings.job_count,
    CASE
        WHEN job_postings.job_count > 50 THEN 'Large'
        WHEN job_postings.job_count BETWEEN 10 AND 50 THEN 'Medium'
        ELSE 'Small'
    END AS company_category
FROM (
    SELECT company_id,
    COUNT(*) AS job_count
    FROM job_postings_fact
    GROUP BY company_id
    ) AS job_postings
LEFT JOIN company_dim AS cd
    ON job_postings.company_id = cd.company_id
ORDER BY 
    CASE
        WHEN job_postings.job_count > 50 THEN 1
        WHEN job_postings.job_count BETWEEN 10 AND 50 THEN 2
        ELSE 3
    END;

--PRACTICE PROBLE 2 using CTEs
WITH company_job_counts AS (
    SELECT company_id,
    COUNT(*) AS job_count
    FROM job_postings_fact
    GROUP BY company_id
)
SELECT cd.name AS company_name,
    CASE
        WHEN company_job_counts.job_count > 50 THEN 'Large'
        WHEN company_job_counts.job_count BETWEEN 10 AND 50 THEN 'Medium'
        ELSE 'Small'
    END AS company_category
FROM  company_job_counts
LEFT JOIN company_dim AS cd
    ON company_job_counts.company_id = cd.company_id
ORDER BY 
    CASE
        WHEN company_job_counts.job_count > 50 THEN 1
        WHEN company_job_counts.job_count BETWEEN 10 AND 50 THEN 2
        ELSE 3
    END;



/* PRACTICE PROBLEM CTEs..
Find the 
    count of the number of remote job postings per skill
- Display the top 5 skills by their 
    demand in remote jobs 
- Only for Data Analyst role
- Include skill ID, name, 
    and count of postings requiring the skill. */
WITH remote_job_skills AS (
    SELECT skill_id,
        COUNT(*) AS skill_count
    FROM skills_job_dim AS skills_to_job
    INNER JOIN job_postings_fact AS job_postings 
        ON job_postings.job_id = skills_to_job.job_id
    WHERE 
        job_postings.job_work_from_home = TRUE AND
        job_postings.job_title_short = 'Data Analyst'
    GROUP BY skill_id
)
SELECT skills.skill_id,
    skills AS skill_name,
    skill_count
FROM remote_job_skills
INNER JOIN skills_dim AS skills
    ON skills.skill_id = remote_job_skills.skill_id
ORDER BY skill_count DESC
LIMIT 5;




