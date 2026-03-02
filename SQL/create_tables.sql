CREATE DATABASE JobApplicationSystem;

-- 1. Users Table
CREATE TABLE Users (
    userID VARCHAR(10) PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50),
    user_role VARCHAR(50),
    user_password VARCHAR(100) NOT NULL,
    created_at timestamp default current_timestamp,
    user_phone VARCHAR(20) Unique,
    user_email VARCHAR(100) Unique NOT NULL
);

-- 2. Company Table
CREATE TABLE Company (
    company_id VARCHAR(10) PRIMARY KEY,
    company_description TEXT NOT NULL,
    company_website VARCHAR(100) NOT NULL,
    company_location VARCHAR(100) NOT NULL,
    industry VARCHAR(50) NOT NULL,
    company_name VARCHAR(100) NOT NULL
);

-- 3. Admin Table
CREATE TABLE Admin (
    admin_id VARCHAR(10) PRIMARY KEY,
    admin_role VARCHAR(50),
    admin_permissions TEXT,
    userID VARCHAR(10),
    CONSTRAINT fk_admin_user FOREIGN KEY (userID) REFERENCES Users(userID) ON DELETE CASCADE
);

-- 4. Feedback Table
CREATE TABLE Feedback (
    feedback_id VARCHAR(10) PRIMARY KEY,
    feedback_message TEXT,
    feedback_ratings INT NOT NULL,
    submitted_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    userID VARCHAR(10),
    CONSTRAINT fk_feedback_user FOREIGN KEY (userID) REFERENCES Users(userID) ON DELETE CASCADE
);

-- 5. RecruiterProfile Table
CREATE TABLE RecruiterProfile (
    recruiter_id VARCHAR(10) PRIMARY KEY,
    recruiter_phone VARCHAR(20) Unique,
    recruitment_position VARCHAR(50) NOT NULL,
    recruiter_email VARCHAR(100)Unique NOT NULL,
    userID VARCHAR(10),
    company_id VARCHAR(10),
    CONSTRAINT fk_recruiter_user FOREIGN KEY (userID) REFERENCES Users(userID) ON DELETE CASCADE,
    CONSTRAINT fk_recruiter_company FOREIGN KEY (company_id) REFERENCES Company(company_id) ON DELETE CASCADE
);

-- 6. Candidate Table
CREATE TABLE Candidate (
    candidate_id VARCHAR(10) PRIMARY KEY,
    candidate_skill TEXT,
    portfolio_link VARCHAR(255),
    resume_link VARCHAR(255) NOT NULL,
    candidate_education TEXT,
    candidate_experience TEXT NOT NULL,
    userID VARCHAR(10),
    CONSTRAINT fk_candidate_user FOREIGN KEY (userID) REFERENCES Users(userID) ON DELETE CASCADE
);

-- 7. Application Table
CREATE TABLE Application (
    application_id VARCHAR(10) PRIMARY KEY,
    application_date timestamp DEFAULT current_timestamp,
    application_status VARCHAR(50) NOT NULL, -- ACCEPTED/REJECTED
    candidate_id VARCHAR(10),
    CONSTRAINT fk_application_candidate FOREIGN KEY (candidate_id) REFERENCES Candidate(candidate_id) ON DELETE CASCADE
);

-- 8. Requirement Table
CREATE TABLE JOB_Requirement (
    requirement_id VARCHAR(10) PRIMARY KEY,
    Required_qualification TEXT NOT NULL,    -- EG. BSCS is required for this job
    Required_experience TEXT NOT NULL,
    Required_skills TEXT NOT NULL
);

-- 9. Category Table
CREATE TABLE Category (
    category_id VARCHAR(10) PRIMARY KEY,
    category_description TEXT, -- EG. IN TECHNOLOGY CATEGORY, JOBS CAN BE OFFERED IN SOFTWARE DEVELEOPEMNT GRAPHIC DESIGNING ETC.
    category_name VARCHAR(100) NOT NULL
);

-- 10. Job Table
CREATE TABLE Job (
    job_id VARCHAR(10) PRIMARY KEY,
    posted_date DATE NOT NULL,
    job_description TEXT NOT NULL,
    salary_range VARCHAR(50) NOT NULL,
    job_location VARCHAR(100) NOT NULL,    
    job_status VARCHAR(50) NOT NULL,   -- OPEN/CLOSE
    job_title VARCHAR(100) NOT NULL,
    job_deadline DATE NOT NULL,
    job_type VARCHAR(50) NOT NULL,   -- EG.ONSITE/REMOTE
    company_id VARCHAR(10),
    requirement_id VARCHAR(10),
    CONSTRAINT fk_job_company FOREIGN KEY (company_id) REFERENCES Company(company_id) ON DELETE CASCADE,
    CONSTRAINT fk_job_requirement FOREIGN KEY (requirement_id) REFERENCES JOB_Requirement(requirement_id) ON DELETE CASCADE
);

-- 11. job_and_jobCategory
CREATE TABLE job_and_jobCategory (
    job_id VARCHAR(10),
    category_id VARCHAR(10),
    CONSTRAINT fk_jajc_category FOREIGN KEY (category_id) REFERENCES Category(category_id) ON DELETE CASCADE,
    CONSTRAINT fk_jajc_job FOREIGN KEY (job_id) REFERENCES Job(job_id) ON DELETE CASCADE
);

-- 12. job_and_Application
CREATE TABLE job_and_Application (
    application_id VARCHAR(10),
    job_id VARCHAR(10),
    CONSTRAINT fk_jaa_job FOREIGN KEY (job_id) REFERENCES Job(job_id) ON DELETE CASCADE,
    CONSTRAINT fk_jaa_application FOREIGN KEY (application_id) REFERENCES Application(application_id) ON DELETE CASCADE
);

-- 13. Application_and_candidate
CREATE TABLE Application_and_candidate (
    application_id VARCHAR(10),
    candidate_id VARCHAR(10),
    CONSTRAINT fk_aac_application FOREIGN KEY (application_id) REFERENCES Application(application_id) ON DELETE CASCADE,
    CONSTRAINT fk_aac_candidate FOREIGN KEY (candidate_id) REFERENCES Candidate(candidate_id) ON DELETE CASCADE
);

-- 14. Saved_JOB Table
CREATE TABLE Saved_JOB (
    saved_id VARCHAR(10) PRIMARY KEY,
    saved_date TIMESTAMP default current_timestamp,
    candidate_id VARCHAR(10),
    job_id VARCHAR(10),
    CONSTRAINT fk_saved_candidate FOREIGN KEY (candidate_id) REFERENCES Candidate(candidate_id) ON DELETE CASCADE,
    CONSTRAINT fk_saved_job FOREIGN KEY (job_id) REFERENCES Job(job_id) ON DELETE CASCADE
);

-- 15. Interview Table
CREATE TABLE Interview (
    interview_id VARCHAR(10) PRIMARY KEY,
    interview_date DATE,
    interview_mode VARCHAR(50),   -- ONSITE/ONLINE
    interview_status VARCHAR(50),   -- UPCOMING/COMPLETED
    interview_feedback TEXT, -- RECRUTER'S FEEDBACK THAT HOW THE INTERVIEWEE WAS
    application_id VARCHAR(10),
    candidate_id VARCHAR(10),
    recruiter_id VARCHAR(10),
    CONSTRAINT fk_interview_application FOREIGN KEY (application_id) REFERENCES Application(application_id) ON DELETE CASCADE,
    CONSTRAINT fk_interview_candidate FOREIGN KEY (candidate_id) REFERENCES Candidate(candidate_id) ON DELETE CASCADE,
    CONSTRAINT fk_interview_recruiter FOREIGN KEY (recruiter_id) REFERENCES RecruiterProfile(recruiter_id) ON DELETE CASCADE
);



