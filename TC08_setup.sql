-- TC08 Insurance Company Database Setup Script
-- Run this script to set up the complete database system

-- Step 1: Create database and tables
SOURCE TC08_table_creation.sql;

-- Step 2: Insert sample data
SOURCE TC08_data_insertion.sql;

-- Step 3: Validate setup
SOURCE TC08_validation.sql;

-- Step 4: Test sample queries
SOURCE TC08_query_statements.sql;

-- Final confirmation
SELECT 'Database setup completed successfully!' as Status;
SELECT 'Total tables created:' as Info, COUNT(*) as Count 
FROM information_schema.tables 
WHERE table_schema = 'TC08_insurance_company';