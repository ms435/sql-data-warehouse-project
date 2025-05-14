/*
===============================================
DDL Script: Create Gold Views
===============================================
Script Purpose:
  This script creates Views for the Gold layer of the data warehouse.
  The Gold layer represents the final dimension and fact tables (Star Schema)

  Each view performs transformation and combines data from the Silver layer to
  produce a clean, enriched, and business-ready dataset.

Usage:
  - These views can be queried directly for analytics and reporting.
===============================================
*/

-- ============================================
-- Create dimension: gold.dim_customers
-- ============================================

CREATE VIEW gold.dim_customers AS
SELECT
	ci.cst_id as customer_id,
    ci.cst_key as customer_number,
    ci.cst_firstname as first_name,
    ci.cst_lastname as last_name,
	la.cntry as country,
    ci.cst_marital_status as marital_status,
       CASE WHEN ci.cst_gndr != 'n/a' THEN ci.cst_gndr
		 ELSE COALESCE(ca.gen, 'n/a')
	END AS gender,
    ca.bdate as birthdate,
	ci.cst_create_date as create_date
FROM silver.crm_cust_info AS ci
LEFT JOIN silver.erp_cust_az12 AS ca
ON		  ci.cst_key = ca.cid
LEFT JOIN silver.erp_loc_a101 la
ON		  ci.cst_key = la.cid
;

-- ============================================
-- Create dimension: gold.dim_product
-- ============================================

CREATE VIEW gold.dim_product AS
SELECT
	ROW_NUMBER() OVER (ORDER BY pn.prd_start_dt, pn.prd_key) AS product_key,
	pn.prd_id as product_id,
    pn.prd_key as product_number,
    pn.prd_nm as product_name,
    pn.cat_id as category_id,
    pc.cat as category,
    pc.subcat as sub_category,
    pc.maintenance as maintenance,
    pn.prd_cost as product_cost,
    pn.prd_line as product_line,
    pn.prd_start_dt as start_date
FROM silver.crm_prd_info as pn
LEFT JOIN silver.erp_px_cat_g1v2 AS pc
ON pn.cat_id = pc.id
WHERE prd_end_dt IS NULL
;

-- ============================================
-- Create fact: gold.fact_sales
-- ============================================

CREATE VIEW gold.fact_sales AS
SELECT
	sls_ord_num  as order_number,
    pr.product_key,
    cu.customer_number,
    sls_order_dt as order_date,
    sls_ship_dt as shipping_date,
    sls_due_dt as due_date,
    sls_sales as sales_amount,
    sls_quantity as quantity,
    sls_price as price
FROM silver.crm_sales_details AS sd
LEFT JOIN gold.dim_product AS pr
ON sd.sls_prd_key = pr.product_number
LEFT JOIN gold.dim_customers AS cu
ON sd.sls_cust_id = cu.customer_id
;
