/*
===============================================
Quality Checks
===============================================
Script Purpose:
  This script performs various quality checks for data accuracy, consistency, and standardization
across the 'silver' schema.
  It includes checks for:
  - Null or duplicate primary keys
  - Unwanted spaces in string fields
  - Data standardization and consistency
  - Invalid date ranges and orders
  - Data consistency between related fields

Usage note:
  - Run these checks after loading data into silver tables
  - Investigate and resolve any discrepancies found during the checks
===============================================
*/


-- Check for NULLs or duplicates in Primary Key
-- Expectation: No results

SELECT 
	prd_id,
    COUNT(*)
FROM bronze.crm_prd_info
GROUP BY prd_id
HAVING COUNT(*) > 1 OR prd_id IS NULL
;

-- Check for unwanted spaces
-- Expectation: no results

SELECT
	prd_nm
FROM bronze.crm_prd_info
WHERE prd_nm != TRIM(prd_nm)
;

-- Check for NULLs or Negative Numbers
-- Expectation: no results

SELECT
	prd_cost
FROM bronze.crm_prd_info
WHERE prd_cost < 0 OR prd_cost IS NULL
;

-- Data standardization & consistency
SELECT DISTINCT prd_line
FROM bronze.crm_prd_info
;

-- Check for invalid date orders
SELECT *
FROM bronze.crm_prd_info
WHERE prd_end_dt < prd_start_dt
;

-- Check for outliers by validating the boundaries of the date range
SELECT 
	NULLIF(sls_order_dt,0) AS sls_order_dt
FROM bronze.crm_sales_details
WHERE
	sls_order_dt <= 0
    OR LENGTH(sls_order_dt) < 8
	OR sls_order_dt > 20500101
    OR sls_order_dt < 19000101
;

-- Check for invalid date orders
SELECT *
FROM bronze.crm_sales_details
WHERE sls_order_dt > sls_ship_dt
	OR sls_order_dt > sls_due_dt
    OR sls_ship_dt > sls_due_dt
;
