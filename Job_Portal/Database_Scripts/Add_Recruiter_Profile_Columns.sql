-- SQL Script to Add Missing Columns to Recruiters and Users Tables
-- Run this script in your SQL Server Management Studio or through your database connection

USE [Portal_Database]
GO

-- Add CreatedAt column to Users table if it doesn't exist
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS 
               WHERE TABLE_NAME = 'Users' AND COLUMN_NAME = 'CreatedAt')
BEGIN
    ALTER TABLE Users
    ADD CreatedAt DATETIME DEFAULT GETDATE()
    
    -- Update existing records with current date
    UPDATE Users SET CreatedAt = GETDATE() WHERE CreatedAt IS NULL
    
    PRINT 'CreatedAt column added to Users table'
END
ELSE
BEGIN
    PRINT 'CreatedAt column already exists in Users table'
END
GO

-- Add Phone column to Recruiters table if it doesn't exist
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS 
               WHERE TABLE_NAME = 'Recruiters' AND COLUMN_NAME = 'Phone')
BEGIN
    ALTER TABLE Recruiters
    ADD Phone NVARCHAR(20) NULL
    
    PRINT 'Phone column added to Recruiters table'
END
ELSE
BEGIN
    PRINT 'Phone column already exists in Recruiters table'
END
GO

-- Add Website column to Recruiters table if it doesn't exist
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS 
               WHERE TABLE_NAME = 'Recruiters' AND COLUMN_NAME = 'Website')
BEGIN
    ALTER TABLE Recruiters
    ADD Website NVARCHAR(200) NULL
    
    PRINT 'Website column added to Recruiters table'
END
ELSE
BEGIN
    PRINT 'Website column already exists in Recruiters table'
END
GO

-- Add Description column to Recruiters table if it doesn't exist
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS 
               WHERE TABLE_NAME = 'Recruiters' AND COLUMN_NAME = 'Description')
BEGIN
    ALTER TABLE Recruiters
    ADD Description NVARCHAR(MAX) NULL
    
    PRINT 'Description column added to Recruiters table'
END
ELSE
BEGIN
    PRINT 'Description column already exists in Recruiters table'
END
GO

-- Add CompanySize column to Recruiters table if it doesn't exist
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS 
               WHERE TABLE_NAME = 'Recruiters' AND COLUMN_NAME = 'CompanySize')
BEGIN
    ALTER TABLE Recruiters
    ADD CompanySize NVARCHAR(50) NULL
    
    PRINT 'CompanySize column added to Recruiters table'
END
ELSE
BEGIN
    PRINT 'CompanySize column already exists in Recruiters table'
END
GO

-- Add Industry column to Recruiters table if it doesn't exist
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS 
               WHERE TABLE_NAME = 'Recruiters' AND COLUMN_NAME = 'Industry')
BEGIN
    ALTER TABLE Recruiters
    ADD Industry NVARCHAR(100) NULL
    
    PRINT 'Industry column added to Recruiters table'
END
ELSE
BEGIN
    PRINT 'Industry column already exists in Recruiters table'
END
GO

-- Verify the changes
SELECT 
    'Users' AS TableName,
    COLUMN_NAME,
    DATA_TYPE,
    IS_NULLABLE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'Users' AND COLUMN_NAME = 'CreatedAt'

UNION ALL

SELECT 
    'Recruiters' AS TableName,
    COLUMN_NAME,
    DATA_TYPE,
    IS_NULLABLE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'Recruiters' 
    AND COLUMN_NAME IN ('Phone', 'Website', 'Description', 'CompanySize', 'Industry')
ORDER BY TableName, COLUMN_NAME
GO

PRINT '============================================'
PRINT 'Database Update Complete!'
PRINT '============================================'
PRINT 'The following columns have been added:'
PRINT '1. Users.CreatedAt - DateTime'
PRINT '2. Recruiters.Phone - NVARCHAR(20)'
PRINT '3. Recruiters.Website - NVARCHAR(200)'
PRINT '4. Recruiters.Description - NVARCHAR(MAX)'
PRINT '5. Recruiters.CompanySize - NVARCHAR(50)'
PRINT '6. Recruiters.Industry - NVARCHAR(100)'
PRINT '============================================'
