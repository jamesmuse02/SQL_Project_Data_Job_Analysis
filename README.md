# Introduction
Explore the dynamic world of data careers! Delving into the realm of data analysis, this endeavor investigates lucrative job opportunities, coveted skills, and the exciting convergence of high demand and impressive salaries within the field of data analytics.

SQL queries? Check them out here: [data_analysis_jobs_project_sql folder](/data_analysis_jobs_project_sql/)

# Background
Motivated by a quest for efficiency in navigating the data analyst job landscape, this project emerged with a goal to identify high-paying and sought-after skills, simplifying the search process to uncover the most rewarding career opportunities.

Data is from the [SQL Course by Luke Barousse](https://lukebarousse.com/sql). It is loaded with insights on job titles, salaries, locations, and essential skills.

### Questions I intended to answer through my SQL queries:

1. What are the top-paying data analyst jobs?
2. What skills are required for these top-paying jobs?
3. What skills are most in demand for data analysts?
4. Which skills are associated with higher salaries?
5. What are the most optimal skills to learn?

# Tools I Used
In my deep dive into the data analyst job market, I made use of various key tools to gather insights effectively. These include:
- **SQL:** This served as the backbone of my analysis, enabling me to query the database and uncover valuable insights crucial for my project.
- **PostgreSQL:** This is the database management system I chose to use for this project. It is ideal for handling this type of data.
- **Visual Studio Code:** My preferred code editor for managing databases and executing SQL queries efficiently.
- **Git & GitHub:** Crucial for version control and facilitating collaboration, enabling me to share SQL scripts and analyses while ensuring efficient project tracking.

# The Analysis
Every query conducted for this project had the objective of exploring particular facets of the data analyst job market. Here's my approach to addressing each question:

### 1. Top Paying Data Analyst Jobs
In order to pinpoint the top-paying roles, I filtered data analyst offerings based on their average annual salaries and location, with a specific emphasis on remote positions. This query highlights the lucrative opportunities available in this field.

```sql
SELECT
    job_postings.job_id,
    job_postings.job_title,
    companies.name AS company,   
    Job_postings.job_location,
    job_postings.job_schedule_type,
    job_postings.salary_year_avg,
    job_postings.job_posted_date
FROM 
    job_postings_fact AS job_postings
LEFT JOIN company_dim AS companies ON job_postings.company_id = companies.company_id
WHERE 
    job_title_short = 'Data Analyst' 
AND              
    salary_year_avg IS NOT NULL 
AND 
    job_location = 'Anywhere'   
ORDER BY
    salary_year_avg DESC             
LIMIT 10                         
;
```
Here is a breakdown of the top analyst jobs in 2023:
- **Wide Salary Spectrum:** The highest-paying data analyst positions range from $184,000 to $650,000, illustrating considerable earning potential within this domain.
- **Job Title Diversity:** A wide array of job titles, spanning from Data Analyst to Director of Analytics, showcases the diverse range of roles and specializations within the field of data analytics.
- **Varied Employers:** Entities such as SmartAsset, Meta, and AT&T are among those providing generous compensation packages, indicating widespread interest across diverse sectors.

### 2. Skills for Top Paying Jobs
To get the skills associated with top paying the top paying jobs from the prior query, I joined the query from the last question with the skills_dim table. This provides each job with its associated skills.

```sql
WITH top_paying_jobs AS (   
    SELECT
        job_postings.job_id,
        job_postings.job_title,
        companies.name AS company,       
        job_postings.salary_year_avg
    FROM 
        job_postings_fact AS job_postings 
    LEFT JOIN company_dim AS companies ON job_postings.company_id = companies.company_id 

    WHERE 
        job_title_short = 'Data Analyst'       
    AND                                 
        salary_year_avg IS NOT NULL      
    AND 
        job_location = 'Anywhere'        
    ORDER BY
        salary_year_avg DESC            
    LIMIT 10                            
)

SELECT 
    top_paying_jobs.*,
    skills_dim. skills                      
FROM top_paying_jobs
INNER JOIN skills_job_dim ON top_paying_jobs.job_id = skills_job_dim.job_id 
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id 
ORDER BY
    salary_year_avg DESC
;
```

Insights into the top skills associated with the highest-paying data analyst jobs for 2023:

- **Versatile Skill Set:** The list includes a wide array of skills, from foundational ones like SQL, Python, and R, to advanced platforms such as Azure, Databricks, and AWS. This diversity underscores the multifaceted nature of high-paying data analyst positions and the need for proficiency across various tools and technologies.

- **Core Technical Proficiency:** Fundamental skills like SQL, Python, and R are prevalent across multiple high-paying positions, emphasizing the importance of strong foundational knowledge in database querying and programming for data analysis tasks.

- **Visualization and Analytics Tools:** Tools such as Tableau, Power BI, and Excel feature prominently among the top skills, underscoring the significance of data visualization and analytics in extracting insights from complex datasets and communicating findings effectively.

### 3. In-Demand Skills for Data Analysts
This query aided in pinpointing the skills commonly sought after in job listings, guiding attention towards areas exhibiting significant demand.

```sql
SELECT
    skills_dim.skills,         
    COUNT(*) AS skill_count                   
FROM job_postings_fact AS job_postings
INNER JOIN skills_job_dim ON job_postings.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst'  AND 
    job_work_from_home = TRUE 
GROUP BY
    skills_dim.skills  
ORDER BY
    skill_count DESC
LIMIT 5     
;
```
Insights into the most in-demand skills for data analysts in 2023:

- **SQL Dominance:** SQL emerges as the top skill with 7291 mentions, indicating its indispensability for data analysis tasks, especially in querying and manipulating databases.

- **Excel Proficiency:** Excel follows closely behind SQL with 4611 mentions, underscoring its enduring relevance in data analysis for tasks such as data cleaning, visualization, and basic analysis.

- **Python and Visualization Tools:** Python and visualization tools like Tableau and Power BI also feature prominently, with 4330, 3745, and 2609 mentions respectively, reflecting the increasing importance of programming skills and data visualization expertise in the data analyst role.

### 4. Skills Based on Salary
Analyzing the average salaries linked to various skills unveiled which skills command the highest compensation.

```sql
SELECT
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
    skills_dim.skills
ORDER BY
    salary_avg DESC
LIMIT 25;
```
Here's a breakdown of the results for top paying skills for Data Analysts:

- **Diverse Skill Demand:** The list encompasses a diverse range of skills, from programming languages like Swift and Python libraries like Pandas to database technologies like Couchbase and PostgreSQL. This suggests a broad spectrum of expertise sought after in high-paying roles, catering to various aspects of data management, analytics, and software development.

- **Emerging Technologies:** Skills related to emerging technologies such as PySpark, Kubernetes, and GCP feature prominently, indicating a growing demand for professionals adept at working with cutting-edge tools and platforms. This trend reflects the ongoing digital transformation across industries, with organizations increasingly investing in advanced technology solutions.

- **Hybrid Skill Sets:** Many of the listed skills require a combination of technical proficiency and domain knowledge. For instance, proficiency in version control systems like Bitbucket and GitLab is valuable for software development roles, while expertise in MicroStrategy and Watson signifies a need for analytics and business intelligence capabilities. This underscores the importance of hybrid skill sets that bridge technical expertise with industry-specific knowledge, reflecting the multidisciplinary nature of high-paying job roles in the data and technology sectors.

### 5. Most Optimal Skills to Learn
By merging insights from both demand and salary data, this query sought to identify skills that are not only highly sought after but also offer lucrative compensation, providing a strategic direction for skill enhancement.

```sql
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
```
Here's an overview of the most advantageous skills for Data Analysts in 2023:

- **Cloud Technologies:** Skills in specialized platforms such as Snowflake, Azure, AWS, and BigQuery exhibit significant demand alongside relatively high average salaries. This trend underscores the increasing significance of cloud-based solutions and big data technologies in the realm of data analysis.

- **Business Intelligence and Visualization Tools:** Proficiency in tools like Tableau and Looker, with 230 and 49 mentions respectively, and average salaries around $99,288 and $103,795, highlights the critical role of data visualization and business intelligence in extracting actionable insights from data.

- **Database Proficiency:** Demand for expertise in traditional and NoSQL databases (such as Oracle, SQL Server, and NoSQL) with average salaries ranging from $97,786 to $104,534 reflects the enduring need for skills in data storage, retrieval, and management.

# What I Learned
Throught the course of this project, I have improved and put my SQL and data analysis skills to work:

- **Analytical Expertise:** Elevated my real-world puzzle-solving abilities, translating queries into actionable and enlightening SQL commands.
- **Advanced Query Construction:** Perfected the craft of intricate SQL manipulation, seamlessly combining tables and employing WITH clauses for adept temporary table management.
- **Aggregate Data Handling:** Familiarized myself with GROUP BY and transformed aggregate functions such as AVG() and COUNT() into invaluable tools for summarizing data effectively.

# Conclusion
### Insight
These insights came up from this project:

1. **Top-Paying Data Analyst Jobs:** The highest-paying data analyst positions range from $184,000 to $650,000, illustrating considerable earning potential within this domain.
2. **Skills for Top-Paying Jobs:**  Fundamental skills like SQL, Python, and R are prevalent across multiple high-paying positions.
3. **Most In-Demand Skills:** 
The analysis underscores SQL's prominence, Excel's enduring relevance, and the growing importance of Python and visualization tools like Tableau and Power BI in data analysis for data analysts in 2023.
4. **Skills with Higher Salaries:** The analysis of top-paying skills for Data Analysts highlights the necessity for hybrid skill sets that blend technical proficiency with domain knowledge to address the diverse demands of high-paying roles in data and technology sectors.
5. **Optimal Skills for Job Market Value:** SQL stands out as a sought-after skill with high earning potential, making it a valuable asset for data analysts looking to enhance their marketability and maximize their earning potential.

### Closing Thoughts
The findings of this analysis underscore the significance of SQL as a critical skill for aspiring data analysts. Through this project, I refined my SQL proficiency, delving into real-world datasets, conducting analysis, and deriving actionable insights. I owe a considerable debt of gratitude to Luke Barousse, whose insightful course significantly elevated my SQL capabilities, propelling them to new heights.
