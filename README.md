# 🏗️ SQL-Based Data Warehouse Project

## 📌 Project Overview

This repository demonstrates a simplified **Data Warehouse pipeline** built using pure SQL (MySQL), simulating the classic architecture of transforming raw transactional data into structured, analysis-ready layers.

The goal is to show how to manually implement **Staging → ODS → Data Mart → Reporting** layers using SQL, following best practices of modularity, readability, and scalability in a warehouse context.

---

## 🛠️ Technologies Used

- **MySQL Workbench**
- **SQL (DDL + DML)**
- Common Table Expressions (CTEs)
- Window Functions
- Layered Data Architecture

---

## 🗂️ Project Structure

```
📁 sql-data-warehouse-project/
├── 01_create_staging_tables.sql        # Create staging tables for raw data
├── 02_create_ods_tables.sql            # Create ODS tables (cleansed + integrated)
├── 03_create_data_marts.sql            # Create star schema fact and dimension tables
├── 04_create_reporting_views.sql       # Create reporting views with business logic
```

---

## 🔄 Pipeline Architecture

This project follows a **4-layer SQL data pipeline**:

1. **Staging Layer**
   - Raw transactional data is loaded with minimal transformations
   - Data is typically ingested from external CSV/flat files (simulated)

2. **ODS Layer (Operational Data Store)**
   - Performs data cleansing, type conversion, and basic standardization
   - Acts as an intermediate, atomic layer before modeling

3. **Data Mart Layer**
   - Star schema is constructed using fact and dimension tables
   - Supports typical OLAP-style queries

4. **Reporting Layer**
   - Analytical views are created to serve downstream business intelligence tools or analysts

---

## 📊 Sample Use Cases

- Simulating a sales reporting environment
- Testing CTE-based SQL logic in layered architecture
- Practicing table design and dimensional modeling (star schema)
- Understanding ETL logic using only SQL

---

## 📌 How to Use

1. Run each SQL file in order from `01_` to `04_`
2. Each file is modular and contains comments for clarity
3. Sample data should be inserted into staging tables before running transformations
4. Reporting views will return aggregated business metrics for analysis

---

## 💡 Future Improvements

- Add stored procedures to simulate ETL orchestration  
- Integrate scheduling (e.g., using MySQL Events or external orchestrators)  
- Add mock data generation scripts  
- Visualize output using a BI tool (e.g., Tableau, Power BI, Metabase)

---

## 🧑 About This Project

This project is designed as a **learning exercise** in implementing a full SQL-based data warehouse flow — without requiring external tools like Airflow or dbt. It's ideal for practicing structured thinking in a data architecture context and for showcasing **SQL warehousing capability** in interviews or portfolios.

---

📂 Explore the files, fork the repo, or contribute ideas for improvement!
