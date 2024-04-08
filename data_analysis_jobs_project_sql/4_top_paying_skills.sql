/*
Question 4: What are the top skills baseed on salary?
- Look at the average salary associated with each skill for Data Analyst positions
- Focuses on roles with specified salaries, regardless of location
-Why? It reveals how different skills impact salary levels for Data Analysts and
 helps identify the most financially rewarding skills to aquire or improve.
*/

SELECT
    skills_dim.skills,
    ROUND(AVG(job_postings.salary_year_avg), 0) AS salary_avg     -- ROUND function to round to the nearest whole number
FROM job_postings_fact AS job_postings
INNER JOIN skills_job_dim ON job_postings.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_postings.job_title_short = 'Data Analyst' AND
    salary_year_avg IS NOT NULL AND
    job_postings.job_work_from_home = TRUE
GROUP BY
    skills_dim.skills
ORDER BY
    salary_avg DESC
LIMIT 25;

/*
1. Diverse Skill Demand: The list encompasses a diverse range of skills, from programming languages like Swift 
   and Python libraries like Pandas to database technologies like Couchbase and PostgreSQL. This suggests a 
   broad spectrum of expertise sought after in high-paying roles, catering to various aspects of data management,
   analytics, and software development.

2. Emerging Technologies: Skills related to emerging technologies such as PySpark, Kubernetes, and GCP feature
   prominently, indicating a growing demand for professionals adept at working with cutting-edge tools and 
   platforms. This trend reflects the ongoing digital transformation across industries, with organizations 
   increasingly investing in advanced technology solutions.

3. Hybrid Skill Sets: Many of the listed skills require a combination of technical proficiency and domain 
   knowledge. For instance, proficiency in version control systems like Bitbucket and GitLab is valuable for 
   software development roles, while expertise in MicroStrategy and Watson signifies a need for analytics and 
   business intelligence capabilities. This underscores the importance of hybrid skill sets that bridge 
   technical expertise with industry-specific knowledge, reflecting the multidisciplinary nature of high-paying
   job roles in the data and technology sectors.

[
  {
    "skills": "pyspark",
    "salary_avg": "208172"
  },
  {
    "skills": "bitbucket",
    "salary_avg": "189155"
  },
  {
    "skills": "couchbase",
    "salary_avg": "160515"
  },
  {
    "skills": "watson",
    "salary_avg": "160515"
  },
  {
    "skills": "datarobot",
    "salary_avg": "155486"
  },
  {
    "skills": "gitlab",
    "salary_avg": "154500"
  },
  {
    "skills": "swift",
    "salary_avg": "153750"
  },
  {
    "skills": "jupyter",
    "salary_avg": "152777"
  },
  {
    "skills": "pandas",
    "salary_avg": "151821"
  },
  {
    "skills": "elasticsearch",
    "salary_avg": "145000"
  },
  {
    "skills": "golang",
    "salary_avg": "145000"
  },
  {
    "skills": "numpy",
    "salary_avg": "143513"
  },
  {
    "skills": "databricks",
    "salary_avg": "141907"
  },
  {
    "skills": "linux",
    "salary_avg": "136508"
  },
  {
    "skills": "kubernetes",
    "salary_avg": "132500"
  },
  {
    "skills": "atlassian",
    "salary_avg": "131162"
  },
  {
    "skills": "twilio",
    "salary_avg": "127000"
  },
  {
    "skills": "airflow",
    "salary_avg": "126103"
  },
  {
    "skills": "scikit-learn",
    "salary_avg": "125781"
  },
  {
    "skills": "jenkins",
    "salary_avg": "125436"
  },
  {
    "skills": "notion",
    "salary_avg": "125000"
  },
  {
    "skills": "scala",
    "salary_avg": "124903"
  },
  {
    "skills": "postgresql",
    "salary_avg": "123879"
  },
  {
    "skills": "gcp",
    "salary_avg": "122500"
  },
  {
    "skills": "microstrategy",
    "salary_avg": "121619"
  }
]

*/
