/* UNION
 - Get jobs & companies from Jan */
SELECT job_title_short,
    company_id,
    job_location
FROM january_jobs

UNION
-- Get jobs & companies from Feb
SELECT job_title_short,
    company_id,
    job_location
FROM february_jobs

UNION
-- Get jobs & companies from Mar
SELECT job_title_short,
    company_id,
    job_location
FROM march_jobs;

/* UNION ALL 
- Get jobs & companies from Jan */
SELECT job_title_short,
    company_id,
    job_location
FROM january_jobs

UNION ALL
-- Get jobs & companies from Feb
SELECT job_title_short,
    company_id,
    job_location
FROM february_jobs

UNION ALL
-- Get jobs & companies from Mar
SELECT job_title_short,
    company_id,
    job_location
FROM march_jobs;


/* - Get the corresponding skill and skill type 
    for each job posting in q1
 - Include those without any skills, too
 - Why? Look at the skills and the type for each job 
    in the first quarter that has a salary >70000. */
SELECT quarter1_jobs.job_id,
    quarter1_jobs.job_title_short,
    quarter1_jobs.job_location,
    quarter1_jobs.job_via,
    quarter1_jobs.job_posted_date::DATE,
    quarter1_jobs.salary_year_avg,
    sd.skills,
    sd.type AS skill_type
FROM (
    SELECT *
    FROM january_jobs
    UNION ALL
    SELECT *
    FROM february_jobs
    UNION ALL
    SELECT *
    FROM march_jobs
) AS quarter1_jobs
LEFT JOIN skills_job_dim AS skill_to_job
    ON quarter1_jobs.job_id = skill_to_job.job_id
LEFT JOIN skills_dim AS sd
    ON skill_to_job.skill_id = sd.skill_id
WHERE quarter1_jobs.salary_year_avg > 70000;


/* 
- Find the job postings from the first quarter
     that have a salary greater than $70K
- Combine job posting tables 
    from the first quarter of 2023(Jan-Mar)
- Gets job postings with an 
    average yearly salary > $70,000
*/
SELECT 
    job_title_short,
    job_location,
    job_via,
    job_posted_date::DATE,
    salary_year_avg
FROM (
    SELECT *
    FROM january_jobs
    UNION ALL
    SELECT *
    FROM february_jobs
    UNION ALL
    SELECT *
    FROM march_jobs
) AS quarter1_job_postings
WHERE salary_year_avg > 70000 AND
    job_title_short = 'Data Analyst'
ORDER BY salary_year_avg DESC;
