-- TC08 Database Validation Script
-- This script validates the database setup and checks for common issues

USE TC08_insurance_company;

-- Check if all tables exist
SHOW TABLES;

-- Validate table structures
DESCRIBE TC08_customer;
DESCRIBE TC08_vehicle;
DESCRIBE TC08_insurance_policy;

-- Check foreign key constraints
SELECT 
    TABLE_NAME,
    COLUMN_NAME,
    CONSTRAINT_NAME,
    REFERENCED_TABLE_NAME,
    REFERENCED_COLUMN_NAME
FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE
WHERE REFERENCED_TABLE_SCHEMA = 'TC08_insurance_company'
ORDER BY TABLE_NAME;

-- Verify data integrity
SELECT 'Customer Count' as Check_Type, COUNT(*) as Count FROM TC08_customer
UNION ALL
SELECT 'Vehicle Count', COUNT(*) FROM TC08_vehicle
UNION ALL
SELECT 'Policy Count', COUNT(*) FROM TC08_insurance_policy
UNION ALL
SELECT 'Claim Count', COUNT(*) FROM TC08_claim
UNION ALL
SELECT 'Settlement Count', COUNT(*) FROM TC08_claim_settlement;

-- Check for orphaned records
SELECT 'Orphaned Vehicles' as Issue, COUNT(*) as Count
FROM TC08_vehicle v
LEFT JOIN TC08_customer c ON v.cust_id = c.cust_id
WHERE c.cust_id IS NULL

UNION ALL

SELECT 'Orphaned Claims', COUNT(*)
FROM TC08_claim cl
LEFT JOIN TC08_customer c ON cl.cust_id = c.cust_id
WHERE c.cust_id IS NULL;

-- Test sample queries
SELECT 'Sample Query Test - Customers with Pending Claims' as Test;
SELECT COUNT(*) as Pending_Claims_Count
FROM TC08_customer c
INNER JOIN TC08_claim cl ON c.cust_id = cl.cust_id
WHERE cl.claim_status = 'Pending';

-- Validate date ranges
SELECT 'Date Validation' as Test;
SELECT 
    MIN(start_date) as Earliest_Policy,
    MAX(expiry_date) as Latest_Expiry
FROM TC08_insurance_policy;

SHOW WARNINGS;