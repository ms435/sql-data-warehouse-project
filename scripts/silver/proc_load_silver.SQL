/*
===============================================
DDL Script: Clean & Load Data into Silver Tables
===============================================
Script Purpose:
  This script cleans and loads tables into the silver schema, truncating existing data before updating.
  Run this script to update the data from 'bronze' tables into the 'silver' tables
===============================================
*/

DELIMITER $$
CREATE PROCEDURE silver.load_silver()
BEGIN

TRUNCATE TABLE silver.crm_cust_info;
INSERT INTO silver.crm_cust_info (
	cst_id,
	cst_key,
	cst_firstname,
	cst_lastname,
	cst_marital_status,
	cst_gndr,
	cst_create_date
)
SELECT
	CAST(cst_id AS UNSIGNED) AS cst_id,
	cst_key,
	TRIM(cst_firstname) AS cst_firstname,
	TRIM(cst_lastname) AS cst_lastname,
	CASE 
		WHEN UPPER(TRIM(cst_marital_status)) = 'S' THEN 'Single'
		WHEN UPPER(TRIM(cst_marital_status)) = 'M' THEN 'Married'
		ELSE 'N/A'
	END AS cst_marital_status,
	CASE 
		WHEN UPPER(TRIM(cst_gndr)) = 'F' THEN 'Female'
		WHEN UPPER(TRIM(cst_gndr)) = 'M' THEN 'Male'
		ELSE 'N/A'
	END AS cst_gndr,
	cst_create_date
FROM (
	SELECT
		*,
		ROW_NUMBER() OVER (PARTITION BY cst_id ORDER BY cst_create_date DESC) AS flag_last
	FROM bronze.crm_cust_info
	WHERE cst_id IS NOT NULL
	  AND cst_id REGEXP '^[0-9]+'
) AS t
WHERE flag_last = 1;


TRUNCATE TABLE silver.crm_prd_info;
INSERT INTO silver.crm_prd_info(
	prd_id,
    cat_id,
	prd_key,
	prd_nm,
	prd_cost,
	prd_line,
	prd_start_dt,
	prd_end_dt)

SELECT
	prd_id,
    REPLACE(SUBSTRING(prd_key,1,5),'-','_') AS cat_id,
    SUBSTRING(prd_key, 7, CHAR_LENGTH(prd_key)) AS prd_key,
    prd_nm,
    IFNULL (prd_cost,0) AS prd_cost,
    CASE UPPER(TRIM(prd_line))
		WHEN 'M' THEN 'Mountain'
		WHEN 'R' THEN 'Road'
        WHEN 'S' THEN 'Other Sales'
        WHEN 'T' THEN 'Touring'
		ELSE 'N/A'
	END AS prd_line,
    CAST(prd_start_dt AS DATE) AS prd_start_dt,
    CAST(DATE_SUB(
		LEAD(prd_start_dt) OVER(PARTITION BY prd_key ORDER BY prd_start_dt), 
        INTERVAL 1 DAY) AS DATE)
	AS prd_end_dt
FROM bronze.crm_prd_info
;


TRUNCATE TABLE silver.crm_sales_details;
INSERT INTO silver.crm_sales_details
(
sls_ord_num,
sls_prd_key,
sls_cust_id,
sls_order_dt,
sls_ship_dt,
sls_due_dt,
sls_sales,
sls_quantity, 
sls_price
)
SELECT
	sls_ord_num,
    sls_prd_key,
    sls_cust_id,
    CASE
		WHEN sls_order_dt = 0 OR LENGTH(sls_order_dt) != 8 THEN NULL
        ELSE STR_TO_DATE(CAST(sls_order_dt AS CHAR), '%Y%m%d')
	END AS sls_order_dt,
    CASE
		WHEN sls_ship_dt = 0 OR LENGTH(sls_ship_dt) != 8 THEN NULL
        ELSE STR_TO_DATE(CAST(sls_ship_dt AS CHAR), '%Y%m%d')
	END AS sls_ship_dt,
    CASE
		WHEN sls_due_dt = 0 OR LENGTH(sls_due_dt) != 8 THEN NULL
        ELSE STR_TO_DATE(CAST(sls_due_dt AS CHAR), '%Y%m%d')
	END AS sls_due_dt,
    CASE
		WHEN sls_sales IS NULL
			OR sls_sales <= 0
			OR sls_sales != sls_quantity * ABS(sls_price)
		THEN sls_sales = sls_quantity * ABS(sls_price)
		ELSE sls_sales
	END AS sls_sales,
    sls_quantity,
	CASE
		WHEN sls_price IS NULL
			OR sls_price <= 0
		THEN sls_sales / NULLIF(sls_quantity,0)
		ELSE sls_price
	END AS sls_price
FROM bronze.crm_sales_details
; 

TRUNCATE TABLE silver.erp_cust_az12;
INSERT INTO silver.erp_cust_az12
(
cid,
bdate,
gen
)
SELECT 
	CASE
		WHEN cid LIKE 'NAS%' THEN SUBSTRING(cid, 4, LENGTH(cid))
        ELSE cid
	END AS cid,
    CASE
		WHEN bdate > CURRENT_DATE THEN NULL
        ELSE bdate
	END AS bdate,
      CASE
		WHEN UPPER(TRIM(gen)) IN ('F', 'FEMALE') THEN 'Female'
        WHEN UPPER(TRIM(gen)) IN ('M', 'MALE') THEN 'Male'
		ELSE 'N/A'
    END AS gen
FROM bronze.erp_cust_az12
;


TRUNCATE TABLE silver.erp_loc_a101;
INSERT INTO silver.erp_loc_a101
(cid,
cntry
)
SELECT 
	REPLACE(cid, '-', '') AS cid,
    CASE
		WHEN TRIM(cntry) = 'DE' THEN 'Germany'
        WHEN TRIM(cntry) IN ('US', 'USA') THEN 'United States'
        WHEN TRIM(cntry) = '' OR cntry IS NULL THEN 'n/a'
		ELSE cntry
	END AS cntry
FROM bronze.erp_loc_a101
;


TRUNCATE TABLE silver.erp_px_cat_g1v2;
INSERT INTO silver.erp_px_cat_g1v2
(
id,
cat,
subcat,
maintenance
)
SELECT
	id,
    cat,
    subcat,
    maintenance
FROM bronze.erp_px_cat_g1v2
;

END $$
DELIMITER ;

