# Crime Analytics & BI Dashboard (2020–2025)

## Project Overview
This project delivers an end-to-end **Business Intelligence (BI) solution** for analyzing crime incidents in Los Angeles between 2020 and 2025. Using publicly available data from the **Los Angeles Open Data portal**, the project focuses on transforming large-scale raw data into **actionable insights** through structured data modeling, SQL analytics, and interactive Power BI dashboards.

The project was developed as part of an MSc thesis and aims to demonstrate a complete BI workflow — from data ingestion and cleaning, to star schema design, analytical querying, and dashboard-driven insight generation.

---

## Dataset
The dataset consists of **1M+ crime records** and includes temporal, geographic, and categorical attributes such as crime type, location, reporting time, victim demographics, and weapon involvement.

Due to file size (~250MB per CSV), the datasets are hosted externally:

- **Raw dataset:** [Google Drive – Raw CSV](https://drive.google.com/file/d/1FdaKEWeXAPbeY0ylwHMUazfPmOaEeR-J/view?usp=sharing)
- **Cleaned dataset:** [Google Drive – Cleaned CSV](https://drive.google.com/file/d/1DE-UmFfxFSM_0ekZji1KiVsjLrIYcy_3/view?usp=sharing)

Source: Los Angeles Open Data Portal  
License: Public / Open Data

---

## Tech Stack
- **Database:** SQL Server  
- **Data Modeling:** Star Schema (Fact & Dimension Tables)  
- **Data Processing & ETL:** SQL, Power Query  
- **Analytics:** SQL Server, DAX  
- **Visualization:** Power BI  
- **Documentation:** GitHub, Markdown

---

## Data Modeling & SQL
A **star schema** was designed to support efficient analytical queries and dashboard performance. The SQL layer includes:
- Schema creation scripts
- Data import and transformation logic
- Core analytical queries
- Data validation and quality checks

This structure enables scalable analysis across time, geography, and crime characteristics.

---

## Power BI Dashboard
The Power BI dashboard provides interactive analysis through:
- KPI measures implemented in DAX
- Slicer-based filtering and cross-filtering
- Time-series and geographic analysis
- Identification of crime hotspots and temporal crime patterns

Screenshots and visual documentation are available in the `screenshots/` folder.

---

## Key Insights
- Identification of **crime hotspots** across districts and high-incidence locations
- Analysis of **time-of-day, day-of-week, and seasonal crime patterns**
- Identification of **peak crime occurrence periods and reporting delays**
- Insights into **weapon involvement, crime frequency and victim demographics**

---

## Repository Structure
The repository is organized to reflect a production-style BI workflow, with separate folders for SQL logic, Power BI artifacts, and visual documentation.

---

## How to Use
1. Review the dataset using the provided links  
2. Explore the SQL scripts to understand the data model, transformations, and analytical logic  
3. Open the Power BI file (`crime_in_la.pbix`) to interact with the dashboard

---

This project reflects my approach to building scalable, insight-driven BI solutions.

---

## Author
Stergios Separdanis  
MSc Information Systems (Data Analytics & BI)