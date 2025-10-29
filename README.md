# TC08 Insurance Company Database Management System

## Overview
This project implements a comprehensive database management system for an insurance company. The system manages customer information, vehicle details, insurance policies, claims, settlements, and various administrative aspects of an insurance business.

## Database Schema
The database `TC08_insurance_company` contains 15 interconnected tables that handle different aspects of the insurance business:

### Core Tables
- **TC08_customer**: Customer personal information and contact details
- **TC08_vehicle**: Vehicle registration and specifications
- **TC08_insurance_policy**: Policy agreements and terms
- **TC08_application**: Insurance applications and their status
- **TC08_claim**: Insurance claims and their processing status
- **TC08_claim_settlement**: Claim settlement details and payments

### Administrative Tables
- **TC08_insurance_company**: Company information and contact details
- **TC08_staff**: Employee information and qualifications
- **TC08_department**: Department structure and leadership
- **TC08_office**: Office locations and administrative costs
- **TC08_product**: Insurance products and pricing
- **TC08_coverage**: Coverage types and terms

### Supporting Tables
- **TC08_premium_payment**: Premium payment schedules and receipts
- **TC08_incident_report**: Incident reports and damage assessments
- **TC08_quote**: Insurance quotes and validity periods

## Features
- Complete customer lifecycle management
- Vehicle registration and tracking
- Policy creation and management
- Claims processing workflow
- Settlement tracking
- Premium payment processing
- Incident reporting system
- Multi-office and multi-department support

## File Structure
```
TC08_DBMS_PROJECT/
├── README.md                    # Project documentation
├── TC08_table_creation.sql      # Database schema and table creation
├── TC08_data_insertion.sql      # Sample data insertion
└── TC08_query_statements.sql    # Complex queries and functions
```

## Database Setup Instructions

### Prerequisites
- MySQL Server 5.7 or higher
- MySQL Workbench or command line access

### Installation Steps
1. **Create Database**: Run the table creation script first
   ```sql
   source TC08_table_creation.sql
   ```

2. **Insert Sample Data**: Populate tables with test data
   ```sql
   source TC08_data_insertion.sql
   ```

3. **Test Queries**: Execute sample queries to verify setup
   ```sql
   source TC08_query_statements.sql
   ```

## Key Relationships
- Customers can have multiple vehicles and policies
- Each claim is linked to a specific customer and incident
- Claims can result in settlements with coverage details
- Staff members are assigned to specific departments and companies
- Offices are managed by departments within companies

## Sample Queries Included
1. **Customer-Vehicle-Claim Analysis**: Find customers with pending claims
2. **Premium Payment Analysis**: Identify high-value premium payers
3. **Accident Analysis**: Customers with accidents and missing receipts
4. **Vehicle-Premium Correlation**: Compare vehicle values with premiums
5. **Custom Functions**: Mathematical operations on claim data

## Data Integrity Features
- Foreign key constraints ensure referential integrity
- Primary keys prevent duplicate records
- NOT NULL constraints on critical fields
- Proper data types for different information categories

## Business Logic
The system supports typical insurance workflows:
- Customer registration and vehicle enrollment
- Quote generation and policy creation
- Incident reporting and claim filing
- Claim assessment and settlement processing
- Premium collection and receipt management

## Technical Notes
- Uses MySQL-specific syntax and functions
- Includes stored functions for complex calculations
- Implements proper foreign key relationships
- Handles NULL values appropriately in optional fields

## Usage Examples
After setup, you can:
- Query customer information with their vehicles and claims
- Generate reports on claim settlements
- Analyze premium payment patterns
- Track incident types and frequencies
- Monitor policy expiration dates

## Contributing
When modifying the database:
1. Maintain referential integrity
2. Update foreign key constraints as needed
3. Test all queries after schema changes
4. Document any new business rules