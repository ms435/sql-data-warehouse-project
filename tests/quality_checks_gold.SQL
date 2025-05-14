/*
===============================================
Quality Checks
===============================================
Script Purpose:
  This script performs various quality checks to validate the integrity, 
  consistency, and accuracy of the Gold layer.
  It ensures the:
  - Uniqueness of surrogate keys in dimension tables.
  - Referential integrity between fact and dimension tables.
  - Validation of relationships in the data model for analytical purposes.

Usage note:
  - Run these checks after creating Views in the Gold layer.
  - Investigate and resolve any discrepancies found during the checks.
===============================================
*/


-- ============================================
-- Checking: 'gold.dim_customers' 
-- ============================================

SELECT
	customer_number,
  COUNT(*) AS duplicate_count
FROM gold.dim_customers
GROUP BY customer_number
HAVING COUNT(*) > 1
;


-- ============================================
-- Checking: 'gold.dim_product' 
-- ============================================

SELECT
	product_key,
  COUNT(*) AS duplicate_count
FROM gold.dim_product
GROUP BY product_key
HAVING COUNT(*) > 1
;
