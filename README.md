# Introduction
📊 Dive into the data job market! Focusing on Data Scientist roles, this project explores
- Top-paying jobs 💰
- In-demand skills🔥
- Where high demand meets high salary in Data Science 📈

🔎SQL Queries? Check them out here: [project_sql folder](/sql_load/project_sql/)
# Background
Driven by a quest to navigate the Data Scientist job market more effectively, this project was born from a desire to pinpoint top-paid and in-demand skills, streamlining others to find optimal jobs. 

Data is collected from [Luke Barousse's SQL Course](/https://lukebarousse.com/sql). It's packed with insights on job titles, salaries, locations, and essential skills.

### The Questions I tried to answer through my SQL Queries were:
- [What are the top-paying remote data scientist jobs?](/sql_load/project_sql/1_top_paying_jobs.sql)
- [What skills are required for the top-paying remote data scientist jobs?](/sql_load/project_sql/2_top_paying_job_skills.sql)
- [What are the most in-demand skills for Data Scientists?](/sql_load/project_sql/3_top_demanded_skills.sql)
- [What are the top paying skills based on salary?](/sql_load/project_sql/4_top_paying_skills.sql)
- [What are the most optimal skills to learn (aka it's in high demand and a high paying skill)?](/sql_load/project_sql/5_most_optimal_skills.sql)
# Tools I used
For my deep dive into the Data Scientist job market, I harnessed the power of several key tools:
- **SQL:** The backbone of my analysis, allowing me to query the database and unearth critical insights
- **PostgreSQL:** The chosen database management system, ideal for handling the job posting data
- **Visual Studio Code:** My go-to for database management and executing SQL queries
- **Git & Github:** Essential for version control and sharing my SQL scripts and analysis, ensuring collaboration and project tracking
# The Analysis
Each query for this project aimed at investigating specific aspects of the data analyst job market. Here’s how I approached each question:
## 1. Top Paying Data Scientist Jobs
To identify the highest-paying roles, I filtered data scientist positions by average yearly salary and location, focusing on remote jobs. This query highlights the high paying opportunities in the field.

```sql
SELECT 
    job_id,
    job_title,
    job_location,
    job_schedule_type,
    salary_year_avg,
    name AS company_name
FROM 
    job_postings_fact
LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
WHERE
    job_title_short = 'Data Scientist' AND
    job_location = 'Anywhere' AND
    job_work_from_home = True AND
    salary_year_avg IS NOT NULL
ORDER BY
    salary_year_avg DESC
LIMIT 10;
```

Based on the provided data for the top 10 paying data scientist jobs, here are some insights:

| **Job Title**                                  | **Company Name**      | **Location** | **Schedule** | **Avg. Salary ($)** |
|------------------------------------------------|-----------------------|--------------|--------------|---------------------|
| Staff Data Scientist/Quant Researcher          | Selby Jennings        | Anywhere     | Full-time    | 550,000             |
| Staff Data Scientist - Business Analytics      | Selby Jennings        | Anywhere     | Full-time    | 525,000             |
| Data Scientist                                 | Algo Capital Group    | Anywhere     | Full-time    | 375,000             |
| Head of Data Science                           | Demandbase            | Anywhere     | Full-time    | 351,500             |
| Head of Data Science                           | Demandbase            | Anywhere     | Full-time    | 324,000             |
| Director Level - Product Management - Data Science | Teramind           | Anywhere     | Full-time    | 320,000             |
| Director of Data Science & Analytics           | Reddit                | Anywhere     | Full-time    | 313,000             |
| Principal Data Scientist                       | Storm5                | Anywhere     | Full-time    | 300,000             |
| Head of Battery Data Science                   | Lawrence Harvey       | Anywhere     | Full-time    | 300,000             |
| Director of Data Science                       | Storm4                | Anywhere     | Full-time    | 300,000             | 

*This table summarizes the top-paying roles, highlighting the companies, job locations, and average salaries, reflecting the trends discussed above*

### Key Insights:

1. **Top-Paying Roles**:
   - **Staff Data Scientist/Quant Researcher** and **Staff Data Scientist - Business Analytics** have the highest average salaries of $550,000 and $525,000, respectively, highlighting the value placed on specialized staff roles in data science.

2. **Leadership Importance**:
   - Roles like **Head of Data Science** and **Director Level - Product Management - Data Science** also command significant salaries, typically ranging from $300,000 to $351,500. This reflects the high demand and compensation for leadership in data science.

3. **Salary Range**:
   - The salary for top remote data scientist roles spans from $300,000 to $550,000, indicating a wide range for compensation based on role specialization and responsibility.

![Top Paying Jobs](/sql_load/assets/image%20(1).png)
*Bar graph visualizing the salary for the top 5 salaries for data analysts; ChatGPT generated this graph from my SQL query results*


## 2. Skills for Top Paying Jobs
To understand what skills are required for the top-paying jobs, I joined the job postings with the skills data, providing insights into what employers value for high-compensation roles.
```sql
WITH top_paying_jobs AS (

    SELECT 
        job_id,
        job_title,
        salary_year_avg,
        name AS company_name
    FROM 
        job_postings_fact
    LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
    WHERE
        job_title_short = 'Data Scientist' AND
        job_location = 'Anywhere' AND
        job_work_from_home = True AND
        salary_year_avg IS NOT NULL
    ORDER BY
        salary_year_avg DESC
    LIMIT 10
)

SELECT 
    top_paying_jobs.*,
    skills
FROM top_paying_jobs

INNER JOIN skills_job_dim ON top_paying_jobs.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id

ORDER BY 
    salary_year_avg DESC
```

### Skill Distribution Across Different Job Titles:
- **Python** is required in several roles, including *Data Scientist*, *Director of Data Science*, and *Staff Data Scientist/Quant Researcher*.
- **SQL** is common in *Data Scientist* and *Staff Data Scientist* roles.
- **AWS** is listed for roles such as *Director Level - Product Management - Data Science* and *Head of Battery Data Science*.
- **PyTorch** and **TensorFlow** are needed in more specialized roles like *Distinguished Data Scientist*.
- Skills like **Hadoop**, **Tableau**, and **Azure** are less common but appear in specific job titles.


![Top Paying Skills](/sql_load/assets/image.png)
*Bar graph visualizing the count of skills for the top 10 paying jobs for data scientists; ChatGPT generated this graph from my SQL query results*

## 3. In-Demand Skills for Data Scientists
This query helped identify the skills most frequently requested in job postings, directing focus to areas with high demand.
```sql
SELECT 
    skills,
    COUNT(skills_job_dim.job_id) AS demand_count
FROM job_postings_fact

INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Scientist'
GROUP BY
    skills
ORDER BY
    demand_count DESC
LIMIT 5
```
Let's analyze the provided data on the top 5 most in-demand skills for data scientists, focusing on trends related to demand across the industry. I will create a table summarizing this data and highlight some key insights.

### Table of Top 5 Most In-Demand Skills for Data Scientists

| **Skill**  | **Demand Count** |
|------------|------------------|
| Python     | 114,016          |
| SQL        | 79,174           |
| R          | 59,754           |
| SAS        | 29,642           |
| Tableau    | 29,513           |

*Table of the demand for the top 5 skills in data scientist job postings*
### Key Insights:

1. **Python Dominance**:
   - **Python** is by far the most in-demand skill with 114,016 job postings requiring it. This highlights Python's versatility and widespread use in data science for everything from data analysis and machine learning to automation and data visualization.

2. **SQL's Critical Role**:
   - **SQL** ranks second with 79,174 demand counts, underscoring the importance of database management and the ability to query large datasets. This is essential for data scientists who need to extract and manipulate data stored in relational databases.

3. **Statistical Tools**:
   - **R** and **SAS** are highly demanded, with 59,754 and 29,642 counts respectively. These are both specialized tools for statistical analysis, indicating a strong need for data scientists who can perform complex statistical modeling and analysis.

4. **Data Visualization**:
   - **Tableau** has a significant demand with 29,513 counts, reflecting the growing emphasis on data visualization skills. Tableau's user-friendly interface and powerful visualization capabilities make it a preferred tool for communicating data insights effectively.

5. **Balanced Skill Set**:
   - The combination of Python, SQL, R, SAS, and Tableau highlights the need for a balanced skill set in data science. Proficiency in programming (Python, R), data handling (SQL, SAS), and data visualization (Tableau) is crucial for meeting the demands of the industry.

These trends indicate that data scientists who are proficient in these core tools and languages are highly sought after, with Python and SQL being foundational skills that complement more specialized tools like R, SAS, and Tableau.

## 4. Skills Based on Salary
Exploring the average salaries associated with different skills revealed which skills are the highest paying.
```sql
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
```
Let's analyze the provided data on the top 25 paying skills for data scientists, focusing on trends related to average salaries and the nature of these skills. I will create a table summarizing this data and highlight some key insights.

### Table of Top 25 Paying Skills for Data Scientists

| **Rank** | **Skill**         | **Average Salary ($)** |
|----------|-------------------|------------------------|
| 1        | Asana             | 215,477                |
| 2        | Airtable          | 201,143                |
| 3        | RedHat            | 189,500                |
| 4        | Watson            | 187,417                |
| 5        | Elixir            | 170,824                |
| 6        | Lua               | 170,500                |
| 7        | Slack             | 168,219                |
| 8        | Solidity          | 166,980                |
| 9        | Ruby on Rails     | 166,500                |
| 10       | RShiny            | 166,436                |
| 11       | Notion            | 165,636                |
| 12       | Objective-C       | 164,500                |
| 13       | Neo4j             | 163,971                |
| 14       | Dplyr             | 163,111                |
| 15       | Hugging Face      | 160,868                |
| 16       | DynamoDB          | 160,581                |
| 17       | Haskell           | 157,500                |
| 18       | Unity             | 156,881                |
| 19       | Airflow           | 155,878                |
| 20       | CodeCommit        | 154,684                |
| 21       | Unreal            | 153,278                |
| 22       | Theano            | 153,133                |
| 23       | Zoom              | 151,677                |
| 24       | BigQuery          | 149,292                |
| 25       | Atlassian         | 148,715                |

*Table of the average salary for the top 10 paying skills for data scientists*
### Key Insights:

1. **Diverse Skill Set**: 
   - The list encompasses a wide range of tools and technologies, including project management tools (**Asana, Airtable, Notion**), programming languages (**Elixir, Lua, Ruby on Rails**), cloud and database services (**RedHat, DynamoDB, Neo4j**), and machine learning libraries (**Watson, Hugging Face, Theano**).

2. **High Paying Skills**: 
   - **Asana** and **Airtable**, both popular for project management, top the list with average salaries exceeding $200,000. This suggests a trend where data scientists with expertise in project management tools are highly valued.
   - **RedHat** and **Watson** are other high-paying skills, reflecting demand for expertise in enterprise-level software and AI-driven solutions.

3. **Specialized Programming Languages**:
   - **Elixir, Lua, Solidity, Haskell, and Objective-C** are among the top-paying languages, highlighting the demand for specialized programming knowledge.

4. **AI and Machine Learning**:
   - Skills like **Watson, Hugging Face, and Theano** demonstrate the continued importance of AI and machine learning expertise, with these skills commanding salaries in the range of $150,000 to $190,000.

5. **Emerging Tools**:
   - Tools like **Zoom, Slack, and Notion** indicate a growing need for data scientists who are proficient in collaboration and communication platforms, likely due to the rise of remote and hybrid work environments.

These insights suggest that data scientists with a blend of traditional programming expertise and proficiency in modern collaboration, AI, and cloud tools are among the most highly paid in the industry.
## 5. Most Optimal Skills to Learn
Combining insights from demand and salary data, this query aimed to pinpoint skills that are both in high demand and have high salaries, offering a strategic focus for skill development.
```sql
WITH skills_demand AS (

    SELECT 
        skills_dim.skill_id,
        skills_dim.skills,
        COUNT(skills_job_dim.job_id) AS demand_count
    FROM job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE
        job_title_short = 'Data Scientist'
        AND salary_year_avg IS NOT NULL
        AND job_work_from_home = True
    GROUP BY
        skills_dim.skill_id
) , average_salary AS (
    SELECT 
        skills_job_dim.skill_id, 
         ROUND(AVG (salary_year_avg),0) AS avg_salary
FROM job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE
        job_title_short = 'Data Scientist'
        AND salary_year_avg IS NOT NULL
        AND job_work_from_home = True
    GROUP BY
        skills_job_dim.skill_id
)

SELECT 
    skills_demand.skill_id,
    skills_demand.skills,
    demand_count,
    avg_salary
FROM
    skills_demand
INNER JOIN average_salary ON skills_demand.skill_id = average_salary.skill_id
WHERE
    demand_count > 20
ORDER BY 
    avg_salary DESC,
    demand_count DESC
 
LIMIT 25;
```
### Analysis of Top 25 Most Optimal Skills for Data Scientists

Below is a summary table along with some insights into the trends for the top 25 most optimal skills for data scientists, considering both high demand and high average salary.

| **Rank** | **Skill**       | **Demand Count** | **Average Salary ($)** |
|----------|-----------------|------------------|------------------------|
| 1        | Python          | 763              | 143,828                |
| 2        | SQL             | 591              | 142,833                |
| 3        | R               | 394              | 137,885                |
| 4        | Tableau         | 219              | 146,970                |
| 5        | AWS             | 217              | 149,630                |
| 6        | Spark           | 149              | 150,188                |
| 7        | TensorFlow      | 126              | 151,536                |
| 8        | Azure           | 122              | 142,306                |
| 9        | PyTorch         | 115              | 152,603                |
| 10       | Pandas          | 113              | 144,816                |
| 11       | SAS             | 110              | 129,920                |
| 12       | Hadoop          | 82               | 143,322                |
| 13       | Scikit-learn    | 81               | 148,964                |
| 14       | Excel           | 77               | 129,224                |
| 15       | Numpy           | 73               | 149,089                |
| 16       | Snowflake       | 72               | 152,687                |
| 17       | Power BI        | 72               | 131,390                |
| 18       | Java            | 64               | 145,706                |
| 19       | Databricks      | 63               | 139,631                |
| 20       | GCP             | 59               | 155,811                |
| 21       | Git             | 58               | 132,599                |
| 22       | Go              | 57               | 164,691                |
| 23       | Looker          | 57               | 158,715                |
| 24       | Scala           | 56               | 156,702                |

*Table of the most optimal skills for data scientist sorted by demand and salary*
### Key Insights:

1. **Top Demand Skills**:
   - **Python** and **SQL** dominate the list with the highest demand counts (763 and 591, respectively). Both are fundamental skills in data science and analytics, which explains their high demand across the industry.
   - **R** also shows significant demand, reinforcing its continued relevance in data science, especially in statistical analysis.

2. **High Salary Skills**:
   - **Go**, **Looker**, and **Scala** are specialized skills with high average salaries ($164,691, $158,715, and $156,702, respectively). These skills are less in demand compared to Python and SQL but are highly valued, indicating their niche but crucial role in the industry.
   - **AWS** and **GCP** are the leading cloud platforms, with substantial average salaries above $149,000. The strong demand for these skills highlights the importance of cloud expertise in modern data science roles.

3. **Machine Learning and Data Engineering Focus**:
   - **TensorFlow** and **PyTorch** are essential machine learning frameworks, and both command high salaries, emphasizing the growing importance of deep learning in data science.
   - **Spark** and **Hadoop** are crucial for big data processing, with **Spark** showing higher demand (149) and both offering salaries above $143,000.

4. **Data Management and Visualization**:
   - **Tableau** and **Power BI** are popular tools for data visualization, with **Tableau** having higher demand and a stronger average salary. Their demand reflects the industry's focus on data presentation and business intelligence.
   - **Pandas** and **Numpy** are key data manipulation libraries in Python, showing strong demand and high salaries, which highlights the need for robust data handling capabilities in data science roles.

5. **Cloud Computing**:
   - **AWS**, **Azure**, and **GCP** all appear in the top 20, reflecting the critical role of cloud platforms in the data science ecosystem. **AWS** leads with the highest demand count (217) and a competitive salary ($149,630).

6. **Emerging and Niche Skills**:
   - **Go** and **Scala** are emerging languages in data engineering and distributed computing, offering lucrative salaries for those with expertise.
   - **Looker** is gaining traction as a business intelligence tool, with a strong average salary, indicating its growing importance in data-driven decision-making.

### Trends:
- **Combination of High Demand and Salary**: Skills like Python, SQL, and AWS combine high demand with competitive salaries, making them essential for data scientists aiming for roles with broad applicability and solid compensation.
- **Specialized Tools with High Value**: Niche tools like Go, Looker, and Scala, though not as widely demanded, offer high salaries, reflecting their specialized and critical nature in certain sectors.
- **Machine Learning and Cloud Dominance**: Expertise in machine learning frameworks (TensorFlow, PyTorch) and cloud platforms (AWS, GCP) is crucial for securing top-paying data science roles.

This analysis underscores the importance of a balanced skill set that includes both widely-used tools like Python and SQL, as well as specialized knowledge in emerging technologies and frameworks.
# What I learned
Throughout this adventure, I've turbocharged my SQL toolkit with some serious firepower:

- 🧩 **Complex Query Crafting:** Mastered the art of advanced SQL, merging tables like a pro and wielding WITH clauses for ninja-level temp table maneuvers.

- 📊 **Data Aggregation:** Got cozy with GROUP BY and turned aggregate functions like COUNT() and AVG() into my data-summarizing sidekicks.

- 💡 **Analytical Wizardry:** Leveled up my real-world puzzle-solving skills, turning questions into actionable, insightful SQL queries.
# Conclusion
Based on the provided data and the trends in top-paying data science jobs, here are some insights specifically for data scientists:

### **1. Top-Paying Data Scientist Jobs:**
- **High Salary Range**: 
  - The highest-paying data scientist jobs, such as **Staff Data Scientist/Quant Researcher** and **Staff Data Scientist - Business Analytics**, offer salaries up to $550,000, reflecting the significant value placed on these roles. 
  - These roles are typically in companies that prioritize data-driven decision-making, often in finance or tech sectors.

### **2. Skills for Top-Paying Data Scientist Jobs:**
- **Specialized Skills**:
  - High-paying roles often require specialized skills in areas such as **Quantitative Research**, **Business Analytics**, and **Data Science Leadership**. 
  - Expertise in machine learning frameworks like **TensorFlow** and **PyTorch** are likely critical in these roles, given their relevance to the tasks in these positions.

### **3. Most In-Demand Skills for Data Scientists:**
- **Python Dominance**:
  - **Python** is the most demanded skill among data scientists, with a high demand count (763). It’s essential for most roles, ranging from general data science positions to more specialized jobs.
  - **SQL** and **R** are also in high demand, making them core skills for data scientists, similar to their importance in data analyst roles.

### **4. Skills with Higher Salaries:**
- **Niche Expertise Pays Off**:
  - Specialized tools like **Snowflake** and cloud platforms like **AWS** and **GCP** command higher average salaries, ranging from $149,000 to $152,000.
  - Roles requiring these skills are highly valued, particularly in companies focusing on large-scale data infrastructure and advanced analytics.

### **5. Optimal Skills for Job Market Value:**
- **Balancing Demand and Salary**:
  - **Python**, while the most demanded skill, also offers a competitive average salary ($143,828), making it one of the most optimal skills for maximizing market value as a data scientist.
  - Skills like **Spark** and **TensorFlow** are also optimal, offering a balance of high demand and strong salaries, crucial for data scientists aiming to increase their marketability.

### **Summary of Insights**:
- **Python** remains the cornerstone skill for data scientists, much like **SQL** for data analysts. It’s both highly demanded and well-compensated.
- High-paying data scientist roles often require a mix of technical and leadership skills, with specialized tools and platforms playing a key role in driving up salaries.
- Remote work continues to be a significant trend, with many top-paying roles offering the flexibility to work from anywhere, which is an attractive option for top talent.
- Investing in learning and mastering specialized tools (e.g., **TensorFlow**, **Snowflake**, **GCP**) can significantly enhance a data scientist’s earning potential, especially in niche roles. 

This analysis provides a strategic overview for data scientists, emphasizing the importance of balancing in-demand skills with specialized expertise to maximize career growth and salary potential.

### **Closing Thoughts**:
This project enhanced my SQL skills and provided valuable insights into the data analyst job market. The findings from the analysis serve as a guide to prioritizing skill development and job search efforts. Aspiring data scientists can better position themselves in a competitive job market by focusing on high-demand, high-salary skills. This exploration highlights the importance of continuous learning and adaptation to emerging trends in the field of data science.