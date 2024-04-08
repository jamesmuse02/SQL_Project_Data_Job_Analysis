/*
Question 3: What are the most in-demand skills for data analysts?
- Join job postings to inner join table similar to query 2
- Identify the top 5 in-demand skills for data analysts
- Focus on all job postings
- Why? Retrieves the top 5 skills with the highest demand in the job market, providing insight into the most
  valuable skills for job seekers
*/

SELECT
    skills_dim.skills,                         -- name of skills from skills_dim table
    COUNT(*) AS skill_count                    -- number of times each skill appeared on job postings
FROM job_postings_fact AS job_postings
INNER JOIN skills_job_dim ON job_postings.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst'  AND 
    job_work_from_home = TRUE -- only interested in remote data analyst roles
GROUP BY
    skills_dim.skills                          -- grouped by skill name
ORDER BY
    skill_count DESC
LIMIT 5                                        -- top 5
;


/*
Results from this stills shows SQL toping the charts for most in demand data analyst skills. But this time,
we see Excel coming in 2nd as opposed to python in the case of query 2.Python follows 3rd, then tableau, then 
Power Bi. So when considering all remote job postings for data analyst roles, Excel trumps over python in most 
in-demand skills in 2023.

[
  {
    "skills": "sql",
    "skill_count": "7291"
  },
  {
    "skills": "excel",
    "skill_count": "4611"
  },
  {
    "skills": "python",
    "skill_count": "4330"
  },
  {
    "skills": "tableau",
    "skill_count": "3745"
  },
  {
    "skills": "power bi",
    "skill_count": "2609"
  }
]

*/