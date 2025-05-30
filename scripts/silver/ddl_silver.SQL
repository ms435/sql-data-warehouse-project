/*
===============================================
DDL Script: Create Silver Tables
===============================================
Script Purpose:
  This script creates tables for the silver schema, dropping existing tables before updating.
  Run this script to update the data in the 'silver' tables
===============================================
*/

DROP TABLE IF EXISTS silver.crm_cust_info;

CREATE TABLE silver.crm_cust_info
(
	cst_id INT,
    cat_id NVARCHAR(50),
	cst_key NVARCHAR(50),
	cst_firstname NVARCHAR(50),
	cst_lastname NVARCHAR(50),
	cst_material_status NVARCHAR(50),
	cst_gndr NVARCHAR(50),
	cst_create_date DATE,
    dwh_create_date DATETIME DEFAULT CURRENT_TIMESTAMP
)
;

DROP TABLE IF EXISTS silver.crm_prd_info;

CREATE TABLE silver.crm_prd_info
(
	prd_id INT,
	prd_key NVARCHAR(50),
	prd_nm NVARCHAR(50),
	prd_cost INT,
	prd_line NVARCHAR(50),
	prd_start_dt DATETIME,
	prd_end_dt DATETIME
)
;

DROP TABLE IF EXISTS silver.crm_sales_details;

CREATE TABLE silver.crm_sales_details
(
	sls_ord_num NVARCHAR(50),
	sls_prd_key NVARCHAR(50),
	sls_cust_id INT,
	sls_order_dt INT,
    sls_ship_dt INT,
    sls_due_dt INT,
    sls_sales INT,
    sls_quantity INT,
    sls_price INT
)
;

DROP TABLE IF EXISTS silver.erp_loc_a101;

CREATE TABLE silver.erp_loc_a101
(
	cid NVARCHAR(50),
	cntry NVARCHAR(50)
)
;

DROP TABLE IF EXISTS silver.erp_cust_az12;

CREATE TABLE silver.erp_cust_az12
(
	cid NVARCHAR(50),
    bdate DATE,
	gen NVARCHAR(50)
)
;

DROP TABLE IF EXISTS silver.erp_cat_g1v2;

CREATE TABLE silver.erp_px_cat_g1v2 (
    id NVARCHAR(50),
    cat NVARCHAR(50),
    subcat NVARCHAR(50),
    maintenance NVARCHAR(50)
)
;
