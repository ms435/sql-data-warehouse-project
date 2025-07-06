# 📊 Data Warehouse & Analytics Project

A sample project showcasing how to build a modern data warehouse and perform business analytics using SQL Server, based on the **Medallion Architecture** (Bronze → Silver → Gold) to transform raw data into actionable business insights.

---

## 🏗️ Data Architecture

- **Bronze**: Import raw data (CSV from ERP/CRM systems) into SQL Server.
- **Silver**: Clean, standardize, and transform the data.
- **Gold**: Build a star schema data model for reporting and analytics.

---

## 📖 Project Overview

1. **Data Architecture**  
   Design the data warehouse using the Bronze – Silver – Gold approach.

2. **ETL Pipelines**  
   Build Extract – Transform – Load processes from raw CSV to analytics-ready tables.

3. **Data Modeling**  
   Create fact and dimension tables optimized for business queries.

4. **Analytics & Reporting**  
   Use SQL to generate reports and derive business insights.

## 🛠️ Tools & Resources

- Sample CSV datasets
- **SQL Server Express** – for database storage  
- **SQL Server Management Studio (SSMS)** – for database development  
- **Git + GitHub** – version control & collaboration  
- **Draw.io** – for architecture & data modeling diagrams  
- **Notion** – for planning and documentation

---

## 🚀 Setup Instructions

### 1. Environment Setup

- Install **SQL Server Express**  
- Install **SSMS (SQL Server Management Studio)**  
- Clone the repository:  
  ```bash
  git clone https://github.com/DataWithBaraa/sql-data-warehouse-project.git
  cd sql-data-warehouse-project
  ```

### 2. Prepare the Data

- Place the CSV files into the `datasets/` folder  
- Update file paths in the SQL scripts if necessary

### 3. Run the ETL Process

- Bronze Layer: run scripts in `scripts/bronze/`  
- Silver Layer: run scripts in `scripts/silver/`  
- Gold Layer: use scripts in `scripts/gold/` to build the star schema

### 4. Test & Analyze

- Use the scripts in `tests/` to validate data quality  
- Run SQL queries in `scripts/gold/` or connect dashboards for analysis

---

## 📂 Project Structure

```
/
├── datasets/          # Source CSV files (ERP + CRM)
├── docs/              # Documentation and architecture diagrams
│   ├── *.drawio       # Diagrams: ETL flow, architecture, data models
│   └── naming-conventions.md
├── scripts/
│   ├── bronze/        # Scripts for raw data ingestion
│   ├── silver/        # Scripts for cleaning and transformation
│   └── gold/          # Scripts to create star schema
├── tests/             # SQL scripts for data quality testing
├── requirements.txt   # Dependencies (if any)
├── LICENSE            # MIT License
└── README.md          # This guide
```


---

## 🛡️ License

Distributed under the **MIT License**. Free to use and adapt — just keep the author credits.
