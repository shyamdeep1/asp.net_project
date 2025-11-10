-- Quick Add Columns Script (Copy and paste into SQL Server)
-- This is a simplified version - just copy and run all lines

USE [Portal_Database]
GO

-- Add all missing columns at once
ALTER TABLE Users ADD CreatedAt DATETIME DEFAULT GETDATE()
GO

ALTER TABLE Recruiters ADD Phone NVARCHAR(20) NULL
GO

ALTER TABLE Recruiters ADD Website NVARCHAR(200) NULL
GO

ALTER TABLE Recruiters ADD Description NVARCHAR(MAX) NULL
GO

ALTER TABLE Recruiters ADD CompanySize NVARCHAR(50) NULL
GO

ALTER TABLE Recruiters ADD Industry NVARCHAR(100) NULL
GO

-- Update existing Users records
UPDATE Users SET CreatedAt = GETDATE() WHERE CreatedAt IS NULL
GO

-- Verify columns were added
SELECT 'Users Table Columns:' AS Info
SELECT COLUMN_NAME, DATA_TYPE FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'Users'
GO

SELECT 'Recruiters Table Columns:' AS Info
SELECT COLUMN_NAME, DATA_TYPE FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'Recruiters'
GO

PRINT 'All columns added successfully!'
