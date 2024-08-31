/*
Question: What are the top paying skills based on salary?
- Look at the average salary associated with each skill for Data Scientist positions
- Focuses on roles with specified salaries, regardless of location
- Why? It reveals how different skills impact salary levels for Data Scientists and 
helps to identify the most financially rewarding skills to acquire or improve
*/

SELECT 
    skills,
    ROUND(AVG (salary_year_avg),0) AS avg_salary
FROM job_postings_fact

INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Scientist'
    AND salary_year_avg IS NOT NULL
GROUP BY
    skills
ORDER BY
    avg_salary DESC
LIMIT 25

/*
Here are some quick insights into the top 25 paying skills for data scientists, 
sorted into three bullet points:

1. Top-paying Tools and Platforms:
   - Asana and Airtable are leading the list with average salaries exceeding $200,000, 
   highlighting the value of project management and collaboration tools in data science roles.

2. Programming and Development:
   - Skills like Elixir, Lua, Solidity, and Ruby on Rails command high salaries (around $166,000-$170,000), 
   indicating that expertise in specific programming languages, especially those related to blockchain and backend development, is highly valued.

3. Emerging and Specialized Technologies*
   - Technologies like Watson, Hugging Face, and Neo4j are also among the top-paying skills, 
   with average salaries ranging from $160,000 to $190,000. 
   This suggests a growing demand for AI, machine learning frameworks, and graph databases in high-paying data science roles.
*/