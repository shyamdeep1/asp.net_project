-- Complete Database Setup Script for Job Portal
-- Run this script to create the database and all required tables

-- Create the main database tables first

-- Users Table
CREATE TABLE Users (
    UserID INT IDENTITY(1,1) PRIMARY KEY,
    FullName NVARCHAR(100) NOT NULL,
    Email NVARCHAR(100) UNIQUE NOT NULL,
    Password NVARCHAR(255) NOT NULL,
    Role NVARCHAR(50) NOT NULL,
    CreatedDate DATETIME DEFAULT GETDATE()
);

-- Recruiters Table
CREATE TABLE Recruiters (
    RecruiterID INT IDENTITY(1,1) PRIMARY KEY,
    UserID INT NOT NULL,
    CompanyName NVARCHAR(200) NOT NULL,
    CompanyAddress NVARCHAR(500),
    FOREIGN KEY (UserID) REFERENCES Users(UserID)
);

-- Jobs Table
CREATE TABLE Jobs (
    JobID INT IDENTITY(1,1) PRIMARY KEY,
    RecruiterID INT NOT NULL,
    JobTitle NVARCHAR(200) NOT NULL,
    JobDescription NVARCHAR(MAX),
    Location NVARCHAR(200),
    Salary NVARCHAR(100),
    SkillsRequired NVARCHAR(500),
    ExperienceRequired NVARCHAR(200),
    JobType NVARCHAR(50),
    Category NVARCHAR(100),
    Deadline DATETIME,
    PostedDate DATETIME DEFAULT GETDATE(),
    Status NVARCHAR(50) DEFAULT 'Active',
    Company_Logo NVARCHAR(255),
    FOREIGN KEY (RecruiterID) REFERENCES Recruiters(RecruiterID)
);

-- JobApplications Table
CREATE TABLE JobApplications (
    ApplicationID INT IDENTITY(1,1) PRIMARY KEY,
    JobID INT NOT NULL,
    JobSeekerID INT NOT NULL,
    FullName NVARCHAR(100) NOT NULL,
    Email NVARCHAR(100) NOT NULL,
    Phone NVARCHAR(20) NOT NULL,
    Resume NVARCHAR(255),
    Experience NVARCHAR(50),
    CoverLetter NVARCHAR(MAX),
    CurrentSalary NVARCHAR(50),
    ExpectedSalary NVARCHAR(50),
    ApplicationDate DATETIME NOT NULL DEFAULT GETDATE(),
    Status NVARCHAR(20) DEFAULT 'Pending',
    FOREIGN KEY (JobID) REFERENCES Jobs(JobID),
    FOREIGN KEY (JobSeekerID) REFERENCES Users(UserID)
);

-- SavedJobs Table
CREATE TABLE SavedJobs (
    SavedJobID INT IDENTITY(1,1) PRIMARY KEY,
    JobSeekerID INT NOT NULL,
    JobID INT NOT NULL,
    SavedDate DATETIME NOT NULL DEFAULT GETDATE(),
    FOREIGN KEY (JobID) REFERENCES Jobs(JobID),
    FOREIGN KEY (JobSeekerID) REFERENCES Users(UserID)
);

-- Create indexes for better performance
CREATE INDEX IX_Users_Email ON Users(Email);
CREATE INDEX IX_Jobs_RecruiterID ON Jobs(RecruiterID);
CREATE INDEX IX_Jobs_Category ON Jobs(Category);
CREATE INDEX IX_Jobs_Location ON Jobs(Location);
CREATE INDEX IX_JobApplications_JobID ON JobApplications(JobID);
CREATE INDEX IX_JobApplications_JobSeekerID ON JobApplications(JobSeekerID);
CREATE INDEX IX_SavedJobs_JobSeekerID ON SavedJobs(JobSeekerID);
CREATE INDEX IX_SavedJobs_JobID ON SavedJobs(JobID);

-- Add unique constraints
ALTER TABLE JobApplications ADD CONSTRAINT UC_JobApplication UNIQUE (JobID, JobSeekerID);
ALTER TABLE SavedJobs ADD CONSTRAINT UC_SavedJob UNIQUE (JobID, JobSeekerID);

-- Insert sample data for testing

-- Insert sample admin user
INSERT INTO Users (FullName, Email, Password, Role) 
VALUES ('Admin User', 'admin@jobportal.com', 'ef92b778bafe771e89245b89ecbc08a44a4e166c06659911881f383d4473e94f', 'Admin');

-- Insert sample recruiter user
INSERT INTO Users (FullName, Email, Password, Role) 
VALUES ('John Recruiter', 'recruiter@company.com', 'ef92b778bafe771e89245b89ecbc08a44a4e166c06659911881f383d4473e94f', 'Recruiter');

-- Insert sample job seeker user
INSERT INTO Users (FullName, Email, Password, Role) 
VALUES ('Jane JobSeeker', 'jobseeker@email.com', 'ef92b778bafe771e89245b89ecbc08a44a4e166c06659911881f383d4473e94f', 'JobSeeker');

-- Insert sample recruiter company
INSERT INTO Recruiters (UserID, CompanyName, CompanyAddress) 
VALUES (2, 'Tech Solutions Inc', '123 Business Street, Tech City');

-- Insert sample job
INSERT INTO Jobs (RecruiterID, JobTitle, JobDescription, Location, Salary, SkillsRequired, ExperienceRequired, JobType, Category, Deadline)
VALUES (1, 'Software Developer', 'Looking for an experienced software developer...', 'New York', '$70,000 - $90,000', 'C#, ASP.NET, SQL Server', '3+ years', 'Full-Time', 'Software Development', '2024-12-31');

-- Note: Password for all sample users is 'secret123' (hashed with SHA256)