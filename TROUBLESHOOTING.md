# Troubleshooting Guide

## Common Issues and Solutions

### 1. Foreign Key Constraint Errors
**Problem**: Error 1452 - Cannot add or update a child row: a foreign key constraint fails

**Solution**: 
- Ensure parent tables are populated before child tables
- Check that referenced values exist in parent tables
- Run the setup script in the correct order: `TC08_setup.sql`

### 2. Table Already Exists Error
**Problem**: Error 1050 - Table already exists

**Solution**:
```sql
DROP DATABASE IF EXISTS TC08_insurance_company;
SOURCE TC08_setup.sql;
```

### 3. Data Type Mismatch
**Problem**: Incorrect data types causing insertion failures

**Solution**: 
- Check that numeric fields don't contain text
- Ensure date fields are in YYYY-MM-DD format
- Verify VARCHAR lengths are sufficient

### 4. Missing Data Dependencies
**Problem**: Some queries return empty results

**Solution**:
- Verify all data insertion scripts ran successfully
- Check foreign key relationships are properly established
- Run the validation script: `SOURCE TC08_validation.sql;`

### 5. Function Creation Errors
**Problem**: Stored function fails to create

**Solution**:
```sql
-- Enable function creation
SET GLOBAL log_bin_trust_function_creators = 1;
-- Then run the function creation code
```

## Verification Steps

1. **Check Database Creation**:
```sql
SHOW DATABASES LIKE 'TC08_insurance_company';
```

2. **Verify Table Count**:
```sql
USE TC08_insurance_company;
SHOW TABLES;
-- Should show 15 tables
```

3. **Check Data Population**:
```sql
SELECT 
    'Customers' as Table_Name, COUNT(*) as Record_Count FROM TC08_customer
UNION ALL
SELECT 'Vehicles', COUNT(*) FROM TC08_vehicle
UNION ALL  
SELECT 'Policies', COUNT(*) FROM TC08_insurance_policy;
```

4. **Test Foreign Keys**:
```sql
SELECT 
    TABLE_NAME,
    CONSTRAINT_NAME,
    REFERENCED_TABLE_NAME
FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE
WHERE REFERENCED_TABLE_SCHEMA = 'TC08_insurance_company';
```

## Performance Tips

1. **Add Indexes** for frequently queried columns:
```sql
CREATE INDEX idx_customer_name ON TC08_customer(cust_fname, cust_lname);
CREATE INDEX idx_claim_status ON TC08_claim(claim_status);
CREATE INDEX idx_policy_dates ON TC08_insurance_policy(start_date, expiry_date);
```

2. **Optimize Queries** by using appropriate WHERE clauses and JOINs

3. **Regular Maintenance**:
```sql
ANALYZE TABLE TC08_customer, TC08_vehicle, TC08_claim;
OPTIMIZE TABLE TC08_customer, TC08_vehicle, TC08_claim;
```

## Contact Information
If you encounter issues not covered here, please check:
- MySQL error logs
- Ensure MySQL version compatibility (5.7+)
- Verify user permissions for database creation and modification