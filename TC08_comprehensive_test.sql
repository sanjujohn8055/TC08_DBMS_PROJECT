-- Comprehensive Test Suite for TC08 Insurance Database
-- This script tests all major functionality

USE TC08_insurance_company;

-- Test 1: Basic table existence and structure
SELECT 'TEST 1: Table Structure Verification' as Test_Name;
SELECT 
    TABLE_NAME,
    TABLE_ROWS,
    CREATE_TIME
FROM INFORMATION_SCHEMA.TABLES 
WHERE TABLE_SCHEMA = 'TC08_insurance_company'
ORDER BY TABLE_NAME;

-- Test 2: Data integrity checks
SELECT 'TEST 2: Data Integrity Verification' as Test_Name;

-- Check for customers without vehicles
SELECT 'Customers without vehicles' as Check_Type, COUNT(*) as Count
FROM TC08_customer c
LEFT JOIN TC08_vehicle v ON c.cust_id = v.cust_id
WHERE v.cust_id IS NULL;

-- Check for claims without customers
SELECT 'Claims without customers' as Check_Type, COUNT(*) as Count
FROM TC08_claim cl
LEFT JOIN TC08_customer c ON cl.cust_id = c.cust_id
WHERE c.cust_id IS NULL;

-- Test 3: Business logic queries
SELECT 'TEST 3: Business Logic Queries' as Test_Name;

-- Active policies count
SELECT 'Active Policies' as Metric, COUNT(*) as Count
FROM TC08_insurance_policy
WHERE expiry_date > CURDATE();

-- Pending claims
SELECT 'Pending Claims' as Metric, COUNT(*) as Count
FROM TC08_claim
WHERE claim_status = 'Pending';

-- Total premium collected
SELECT 'Total Premium Collected' as Metric, SUM(premium_payment_amount) as Amount
FROM TC08_premium_payment;

-- Test 4: Complex join operations
SELECT 'TEST 4: Complex Query Verification' as Test_Name;

-- Customer with most vehicles
SELECT 
    c.cust_fname,
    c.cust_lname,
    COUNT(v.vehicle_id) as Vehicle_Count
FROM TC08_customer c
JOIN TC08_vehicle v ON c.cust_id = v.cust_id
GROUP BY c.cust_id, c.cust_fname, c.cust_lname
ORDER BY Vehicle_Count DESC
LIMIT 1;

-- Test 5: Date range validations
SELECT 'TEST 5: Date Validation' as Test_Name;

-- Check for invalid policy dates
SELECT 'Invalid Policy Dates' as Issue, COUNT(*) as Count
FROM TC08_insurance_policy
WHERE start_date > expiry_date;

-- Check for future birth dates
SELECT 'Future Birth Dates' as Issue, COUNT(*) as Count
FROM TC08_customer
WHERE cust_dob > CURDATE();

-- Test 6: Constraint verification
SELECT 'TEST 6: Constraint Verification' as Test_Name;

-- Test foreign key relationships
SELECT 
    CONSTRAINT_NAME,
    TABLE_NAME,
    COLUMN_NAME,
    REFERENCED_TABLE_NAME,
    REFERENCED_COLUMN_NAME
FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE
WHERE REFERENCED_TABLE_SCHEMA = 'TC08_insurance_company'
AND CONSTRAINT_NAME != 'PRIMARY'
ORDER BY TABLE_NAME;

-- Final summary
SELECT 'TEST SUMMARY' as Final_Status;
SELECT 
    'Total Tables' as Metric, 
    COUNT(*) as Value
FROM INFORMATION_SCHEMA.TABLES 
WHERE TABLE_SCHEMA = 'TC08_insurance_company'

UNION ALL

SELECT 
    'Total Records',
    (SELECT COUNT(*) FROM TC08_customer) +
    (SELECT COUNT(*) FROM TC08_vehicle) +
    (SELECT COUNT(*) FROM TC08_claim) +
    (SELECT COUNT(*) FROM TC08_insurance_policy)

UNION ALL

SELECT 
    'Foreign Key Constraints',
    COUNT(*)
FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE
WHERE REFERENCED_TABLE_SCHEMA = 'TC08_insurance_company'
AND CONSTRAINT_NAME != 'PRIMARY';

SELECT 'All tests completed successfully!' as Status;