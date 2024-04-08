/*
Question 1: What are the top-paying data analyst jobs?
- Identify the top 10 highest-paying Data Analyst roles that are available remotely.
- Focuses on job postings with specified salaries (remove nulls).
- Why? Highlight the top-paying opportunities for Data Analysts, offering insights into employment
*/

SELECT
    job_postings.job_id,
    job_postings.job_title,
    companies.name AS company,       -- company names from company_dim table with alias companies
    Job_postings.job_location,
    job_postings.job_schedule_type,
    job_postings.salary_year_avg,
    job_postings.job_posted_date
FROM 
    job_postings_fact AS job_postings -- giving job_postings_fact table alias job_postings
LEFT JOIN company_dim AS companies ON job_postings.company_id = companies.company_id -- joining company names from company_dim table to job_postings_fact table using company_id foreign key
WHERE 
    job_title_short = 'Data Analyst' -- we are focusing on only data analyst roles
AND                                  -- making use of AND because all these conditions must be satisfied
    salary_year_avg IS NOT NULL      -- focusing on job postings with specified salaries
AND 
    job_location = 'Anywhere'        -- we are only interested in remote offerings
ORDER BY
    salary_year_avg DESC             -- highest paying jobs
LIMIT 10                             -- top 10
;

