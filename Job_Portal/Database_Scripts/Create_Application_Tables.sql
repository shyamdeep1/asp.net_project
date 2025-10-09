-- SQL Script to create required tables for Job Application functionality

-- Table to store job applications
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
    ApplicationDate DATETIME NOT NULL,
    Status NVARCHAR(20) DEFAULT 'Pending',
    FOREIGN KEY (JobID) REFERENCES Jobs(JobID),
    FOREIGN KEY (JobSeekerID) REFERENCES Users(UserID)
);

-- Table to store saved jobs
CREATE TABLE SavedJobs (
    SavedJobID INT IDENTITY(1,1) PRIMARY KEY,
    JobSeekerID INT NOT NULL,
    JobID INT NOT NULL,
    SavedDate DATETIME NOT NULL,
    FOREIGN KEY (JobID) REFERENCES Jobs(JobID),
    FOREIGN KEY (JobSeekerID) REFERENCES Users(UserID)
);

-- Create indexes for better performance
CREATE INDEX IX_JobApplications_JobID ON JobApplications(JobID);
CREATE INDEX IX_JobApplications_JobSeekerID ON JobApplications(JobSeekerID);
CREATE INDEX IX_SavedJobs_JobSeekerID ON SavedJobs(JobSeekerID);
CREATE INDEX IX_SavedJobs_JobID ON SavedJobs(JobID);

-- Add unique constraint to prevent duplicate applications
ALTER TABLE JobApplications ADD CONSTRAINT UC_JobApplication UNIQUE (JobID, JobSeekerID);

-- Add unique constraint to prevent duplicate saved jobs
ALTER TABLE SavedJobs ADD CONSTRAINT UC_SavedJob UNIQUE (JobID, JobSeekerID);