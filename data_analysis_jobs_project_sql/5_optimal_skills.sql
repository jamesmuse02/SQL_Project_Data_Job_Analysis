/*
Question: What are the most optimal skills to learn(high-demand and high-paying)?
- Identify skills in high demand and associated with high average salaries for Data Analyst roles
- Cpncentrates on remote positions with specific salaries
- Why? Targets skills that offer job security and financial benefits, offering strategic insights 
  for career development in data analysis
*/

WITH skills_demand AS (                              -- create CTE skills_demand for query 3(demand)
    SELECT
        skills_dim.skill_id,
        skills_dim.skills,
        COUNT(*) AS skill_count
    FROM job_postings_fact AS job_postings
    INNER JOIN skills_job_dim ON job_postings.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE
        job_title_short = 'Data Analyst'  AND 
        salary_year_avg IS NOT NULL AND 
        job_work_from_home = TRUE 
    GROUP BY
        skills_dim.skill_id
), 
average_salary AS (                                 -- create CTE average_salary for query 4(salary)
    SELECT
        skills_dim.skill_id,
        skills_dim.skills,
        ROUND(AVG(job_postings.salary_year_avg), 0) AS salary_avg
    FROM job_postings_fact AS job_postings
    INNER JOIN skills_job_dim ON job_postings.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE
        job_postings.job_title_short = 'Data Analyst' AND
        salary_year_avg IS NOT NULL AND 
        job_postings.job_work_from_home = TRUE
    GROUP BY
        skills_dim.skill_id
)
SELECT
    skills_demand.skill_id,
    skills_demand.skills,
    skills_demand.skill_count,
    average_salary.salary_avg
FROM
    skills_demand
INNER JOIN average_salary ON skills_demand.skill_id = average_salary.skill_id   -- Inner join average_salary on skills_demand
WHERE
    skills_demand.skill_count > 10          -- to filter out skills with high salaries but very low demand
ORDER BY
    average_salary.salary_avg DESC,
    skills_demand.skill_count DESC
LIMIT 25;