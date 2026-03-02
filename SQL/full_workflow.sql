CREATE DATABASE JobApplicationSystem;
use JobApplicationSystem;
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
    recruitment_position VARCHAR(50) NOT NULL,
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
    application_status VARCHAR(50) NOT NULL -- ACCEPTED/REJECTED
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

INSERT INTO Users (userID, first_name, last_name, user_role, user_password, user_phone, user_email) VALUES
('U011', 'Alice', 'Johnson', 'Candidate', 'passAlice123', '555-1011', 'alice.johnson@example.com'),
('U012', 'Bob', 'Smith', 'Candidate', 'passBob123', '555-1012', 'bob.smith@example.com'),
('U013', 'Carol', 'Williams', 'Candidate', 'passCarol123', '555-1013', 'carol.williams@example.com'),
('U014', 'David', 'Brown', 'Candidate', 'passDavid123', '555-1014', 'david.brown@example.com'),
('U015', 'Eva', 'Davis', 'Candidate', 'passEva123', '555-1015', 'eva.davis@example.com'),

('U016', 'Frank', 'Miller', 'Admin', 'passFrank123', '555-1016', 'frank.miller@example.com'),
('U017', 'Grace', 'Wilson', 'Admin', 'passGrace123', '555-1017', 'grace.wilson@example.com'),
('U018', 'Hank', 'Moore', 'Admin', 'passHank123', '555-1018', 'hank.moore@example.com'),
('U019', 'Ivy', 'Taylor', 'Admin', 'passIvy123', '555-1019', 'ivy.taylor@example.com'),
('U020', 'Jack', 'Anderson', 'Admin', 'passJack123', '555-1020', 'jack.anderson@example.com'),

('U021', 'Karen', 'Thomas', 'Recruiter', 'passKaren123', '555-1021', 'karen.thomas@example.com'),
('U022', 'Leo', 'Jackson', 'Recruiter', 'passLeo123', '555-1022', 'leo.jackson@example.com'),
('U023', 'Mona', 'White', 'Recruiter', 'passMona123', '555-1023', 'mona.white@example.com'),
('U024', 'Nick', 'Harris', 'Recruiter', 'passNick123', '555-1024', 'nick.harris@example.com'),
('U025', 'Olivia', 'Martin', 'Recruiter', 'passOlivia123', '555-1025', 'olivia.martin@example.com');

INSERT INTO Company (company_id, company_description, company_website, company_location, industry, company_name) VALUES
('CMP001', 'Leading tech solutions provider.', 'https://www.techvision.com', 'Lahore, Pakistan', 'Technology', 'TechVision'),
('CMP002', 'Creative design and branding agency.', 'https://www.designcube.com', 'Karachi, Pakistan', 'Design', 'DesignCube'),
('CMP003', 'Software development and outsourcing company.', 'https://www.codewave.com', 'Islamabad, Pakistan', 'IT Services', 'CodeWave'),
('CMP004', 'Digital marketing and SEO experts.', 'https://www.markitup.com', 'Lahore, Pakistan', 'Marketing', 'MarkItUp'),
('CMP005', 'Human resource consultancy services.', 'https://www.hrplus.com', 'Rawalpindi, Pakistan', 'Consulting', 'HRPlus'),
('CMP006', 'Global e-commerce and logistics.', 'https://www.tradebay.com', 'Karachi, Pakistan', 'E-Commerce', 'TradeBay'),
('CMP007', 'Blockchain and fintech innovations.', 'https://www.cryptonova.com', 'Islamabad, Pakistan', 'Fintech', 'CryptoNova'),
('CMP008', 'Engineering services and manufacturing.', 'https://www.enggenix.com', 'Faisalabad, Pakistan', 'Engineering', 'Enggenix'),
('CMP009', 'AI research and development lab.', 'https://www.neuralcore.com', 'Lahore, Pakistan', 'Artificial Intelligence', 'NeuralCore'),
('CMP010', 'Online education and tutoring services.', 'https://www.learnnest.com', 'Peshawar, Pakistan', 'Education', 'LearnNest');

INSERT INTO Admin (admin_id, admin_role, admin_permissions, userID) VALUES
('A001', 'Super Admin', 'ALL', 'U016'),
('A002', 'Moderator', 'READ, WRITE', 'U017'),
('A003', 'Support', 'READ', 'U018'),
('A004', 'HR Manager', 'READ, WRITE, DELETE', 'U019'),
('A005', 'Content Admin', 'READ, WRITE', 'U020');

INSERT INTO Candidate (candidate_id, candidate_skill, portfolio_link, resume_link, candidate_education, candidate_experience, userID) VALUES
('C001', 'Java, Python, SQL', 'http://portfolio.alice.com', 'http://resume.alice.com', 'BS Computer Science', '2 years internship at TechCorp', 'U011'),
('C002', 'C++, JavaScript, HTML/CSS', 'http://portfolio.bob.com', 'http://resume.bob.com', 'BS Software Engineering', '1 year freelance web developer', 'U012'),
('C003', 'Data Analysis, R, Python', 'http://portfolio.carol.com', 'http://resume.carol.com', 'MS Data Science', 'Research assistant for 3 years', 'U013'),
('C004', 'Graphic Design, Adobe Suite', 'http://portfolio.david.com', 'http://resume.david.com', 'BA Visual Arts', '2 years at Creative Studio', 'U014'),
('C005', 'Networking, Cybersecurity', 'http://portfolio.eva.com', 'http://resume.eva.com', 'BS Information Technology', '1 year helpdesk support', 'U015');


INSERT INTO RecruiterProfile (recruiter_id,  recruitment_position, userID, company_id) VALUES
('R001',  'Talent Acquisition Specialist',  'U021', 'CMP001'),
('R002',  'HR Generalist',  'U022', 'CMP002'),
('R003',  'Technical Recruiter',  'U023', 'CMP003'),
('R004',  'Campus Hiring Lead', 'U024', 'CMP004'),
('R005',  'Recruitment Manager',  'U025', 'CMP005');

INSERT INTO Application (application_id, application_status) VALUES
('APP001', 'Accepted' ),
('APP002', 'Rejected'),
('APP003', 'Accepted'),
('APP004', 'Rejected'),
('APP005', 'Accepted');

INSERT INTO Application_and_candidate (application_id, candidate_id) VALUES
('APP001', 'C001'),
('APP002', 'C002'),
('APP003', 'C003'),
('APP004', 'C004'),
('APP005', 'C005');
INSERT INTO JOB_Requirement (requirement_id, Required_qualification, Required_experience, Required_skills) VALUES
('REQ001', 'BS Computer Science', '2 years', 'Java, SQL, Communication'),
('REQ002', 'BS Software Engineering', '1 year', 'C++, JavaScript, HTML/CSS'),
('REQ003', 'MS Data Science', '3 years', 'Python, R, Data Analysis'),
('REQ004', 'BA Visual Arts', '2 years', 'Adobe Suite, Creativity'),
('REQ005', 'BS Information Technology', '1 year', 'Networking, Cybersecurity');

INSERT INTO Job (job_id, posted_date, job_description, salary_range, job_location, job_status, job_title, job_deadline, job_type, company_id, requirement_id) VALUES
('J001', '2025-05-01', 'Software Developer needed to develop enterprise applications.', '60000-80000', 'Lahore, Pakistan', 'OPEN', 'Android Developer', '2025-06-01', 'ONSITE', 'CMP001', 'REQ001'),
('J002', '2025-04-20', 'Frontend developer required with expertise in JavaScript and React.', '50000-70000', 'Karachi, Pakistan', 'OPEN', 'Frontend Developer', '2025-05-25', 'REMOTE', 'CMP002', 'REQ002'),
('J003', '2025-04-15', 'Data Scientist position for AI-driven analytics.', '90000-120000', 'Islamabad, Pakistan', 'OPEN', 'Data Scientist', '2025-06-10', 'ONSITE', 'CMP003', 'REQ003'),
('J004', '2025-05-10', 'Creative Graphic Designer for marketing campaigns.', '40000-60000', 'Lahore, Pakistan', 'OPEN', 'Graphic Designer', '2025-07-01', 'REMOTE', 'CMP004', 'REQ004'),
('J005', '2025-05-05', 'Network Security Specialist for enterprise security.', '70000-90000', 'Rawalpindi, Pakistan', 'OPEN', 'Network Security Specialist', '2025-06-20', 'ONSITE', 'CMP005', 'REQ005');

INSERT INTO job_and_Application (application_id, job_id) VALUES
('APP001', 'J001'),
('APP002', 'J002'),
('APP003', 'J003'),
('APP004', 'J004'),
('APP005', 'J005');

INSERT INTO Category (Category_id, category_description,category_name) VALUES
('CAT001', 'Jobs related to software development', 'Software Development'),
('CAT002', 'Jobs related to frontend and backend web development', 'Web Development'),
('CAT003', 'Jobs related to data analysis, machine learning, and AI', 'Data Science'),
('CAT004', 'Jobs related to IT infrastructure and networking', 'IT & Networking'),
('CAT005', 'Jobs related to graphic design, UI, and UX', 'Design');

INSERT INTO job_and_jobCategory (job_id, category_id) VALUES
('J001', 'CAT001'),  -- Android Developer -> Software Development
('J001', 'CAT004'),  -- Also linked to IT & Networking (optional)
('J002', 'CAT002'),  -- Frontend Developer -> Web Development
('J003', 'CAT003'),  -- Data Scientist -> Data Science
('J004', 'CAT005'),  -- Graphic Designer -> Design
('J005', 'CAT004');  -- Network Security Specialist -> IT & Networking

INSERT INTO saved_job (saved_id,  saved_date,candidate_id, job_id) VALUES
('SJ001', '2025-05-20','C001', 'J001'),
('SJ002','2025-05-21', 'C001', 'J003'),
('SJ003', '2025-05-22','C002', 'J002' ),
('SJ004', '2025-05-23', 'C002', 'J004'),
('SJ005', '2025-05-24','C003', 'J005'),
('SJ006', '2025-05-25', 'C004', 'J001'),
('SJ007', '2025-05-26','C005', 'J003'),
('SJ008', '2025-05-27','C005', 'J004');
INSERT INTO Interview (interview_id, interview_date, interview_mode, interview_status, interview_feedback, application_id, candidate_id, recruiter_id) VALUES
('INT001', '2025-05-15', 'ONLINE', 'COMPLETED', 'Strong technical skills, good communication.', 'APP001', 'C001', 'R001'),
('INT002', '2025-05-18', 'ONSITE', 'UPCOMING', NULL, 'APP002', 'C002', 'R002'),
('INT003', '2025-05-20', 'ONLINE', 'UPCOMING', NULL, 'APP003', 'C003', 'R003'),
('INT004', '2025-05-22', 'ONSITE', 'COMPLETED', 'Creative and passionate, great portfolio.', 'APP004', 'C004', 'R004'),
('INT005', '2025-05-25', 'ONLINE', 'UPCOMING', NULL, 'APP005', 'C005', 'R005');


INSERT INTO Feedback (feedback_id, feedback_message, feedback_ratings, userID) VALUES
('FDB011', 'Job application process was seamless.', 5, 'U011'),
('FDB012', 'Dashboard needs better design.', 3, 'U014'),
('FDB013', 'App crashed once, but otherwise fine.', 4, 'U017'),
('FDB014', 'Helped me land my first job!', 5, 'U013'),
('FDB015', 'More recruiter tools would be helpful.', 4, 'U023'),
('FDB016', 'Admin panel is intuitive and fast.', 5, 'U016'),
('FDB017', 'Need alerts for new job postings.', 3, 'U012'),
('FDB018', 'Recruiter profile setup was simple.', 5, 'U021'),
('FDB019', 'Satisfied with candidate filtering options.', 4, 'U025'),
('FDB020', 'Suggestion: dark mode option.', 4, 'U020');




-- 1. All active candidates whose email starts with 'a' or phone number contains '101'
SELECT
    userID,first_name,last_name,user_email,user_phone FROM   Users 
    WHERE
    user_role = 'Candidate' AND (user_email LIKE 'a%' OR user_phone LIKE '%101%');

-- ----------------------------------------------------------------------------------------

-- 2. 'Android Developer' jobs in Lahore with a deadline in June 2025
SELECT
    job_id,job_title,job_location,job_deadline, salary_range FROM    Job
WHERE
    job_title = 'Android Developer'
    AND job_location = 'Lahore, Pakistan'
    AND job_deadline >= '2025-06-01'
    AND job_deadline <= '2025-06-30'
    AND job_status = 'OPEN';
-- ----------------------------------------------------------------------------------------    

-- 3. Companies in Karachi or Islamabad with a website containing 'com'
SELECT
    company_id, company_name, company_location, company_website FROM    Company
WHERE
    (company_location = 'Karachi, Pakistan' OR company_location = 'Islamabad, Pakistan')
    AND company_website LIKE '%com%';

-- -----------------------------------------------------------------------

-- 4. Admin users with 'READ' permissions who are not 'Super Admin'
SELECT
    admin_id, admin_role,admin_permissions FROM    Admin
WHERE
    admin_permissions LIKE '%READ%' AND NOT admin_role = 'Super Admin';

-- --------------------------------------------------------------------------

-- 5. Candidates with 'Java' or 'Python' skills and at least 2 years of experience
SELECT
    candidate_id,
    candidate_skill,
    candidate_experience
FROM
    Candidate
WHERE
    (candidate_skill LIKE '%Java%' OR candidate_skill LIKE '%Python%')
    AND candidate_experience LIKE '%2 years%';

-- --------------------------------------------------------------------------

-- 6. List 'Rejected' applications submitted before May 1, 2025
SELECT
    application_id,
    application_date
FROM
    Application
WHERE
    application_status = 'Rejected' AND application_date < '2025-05-01';

---

-- 7. Job requirements for 'BS Computer Science' with 'SQL' skills
SELECT
    requirement_id,
    Required_qualification,
    Required_skills
FROM
    JOB_Requirement
WHERE
    Required_qualification = 'BS Computer Science' AND Required_skills LIKE '%SQL%';

-- ---------------------------------------------------------------------------

-- 8. Job categories with a description indicating 'software development'
SELECT
    category_id,
    category_name,
    category_description
FROM
    Category
WHERE
    category_description LIKE '%software development%';

-- -------------------------------------------------------------------------------

-- 9. Interviews scheduled for 'ONLINE' mode in May 2025
SELECT
    interview_id,
    interview_date,
    interview_status
FROM
    Interview
WHERE
    interview_mode = 'ONLINE'
    AND interview_date >= '2025-05-01'
    AND interview_date <= '2025-05-31';

-- -------------------------------------------------------------------------------------

-- 10. Saved jobs by candidate 'C001' or 'C005' that were saved after May 23, 2025
SELECT
    saved_id,
    saved_date,
    candidate_id
FROM
    Saved_JOB
WHERE
    (candidate_id = 'C001' OR candidate_id = 'C005')
    AND saved_date > '2025-05-23';
-- ---------------------------------------------------------------------------------
-- 11. Updating a User's Phone Number
UPDATE Users SET user_phone = '555-9876' WHERE userID = 'U011';

-- -----------------------------------------------------------------------------

-- 12. Deleting a Specific Saved Job
DELETE FROM Saved_JOB
WHERE saved_id = 'SJ008';

-- -------------------------------------------------------------------

-- 13. Adding a New Column to Company
ALTER TABLE Company ADD COLUMN company_phone VARCHAR(20);

-- -------------------------------------------------------------------

-- 14. Updating Job Status and Deadline for a Specific Job
UPDATE Job SET job_status = 'CLOSED', job_deadline = '2025-05-31' WHERE  job_id = 'J002';


-- -------------------------------------------------------------------------------------

-- 15. Finding Candidates with 'BS' in Education and 'years' in Experience, excluding 'C003'
SELECT
    candidate_id,
    candidate_education,
    candidate_experience
FROM
    Candidate
WHERE
    candidate_education LIKE '%BS%'
    AND candidate_experience LIKE '%years%'
    AND NOT candidate_id = 'C003';

-- ----------------------------------------------------------------------------------------------

-- 16. Getting Job Requirements for 'Software Engineering' or 'Information Technology' Qualifications
SELECT
    requirement_id,
    Required_qualification,
    Required_experience,
    Required_skills
FROM
    JOB_Requirement
WHERE
    Required_qualification LIKE '%Software Engineering%'
    OR Required_qualification LIKE '%Information Technology%';

-- -----------------------------------------------------------------------------------------------

-- 17. Retrieving Users (Admins or Recruiters) whose Last Name Starts with 'W' or 'T'
SELECT
    userID,
    first_name,
    last_name,
    user_role
FROM
    Users
WHERE
    (user_role = 'Admin' OR user_role = 'Recruiter')
    AND (last_name LIKE 'W%' OR last_name LIKE 'T%');

-- ------------------------------------------------------------------------------------

-- 18. Finding Applications Accepted 
SELECT
    application_id,
    
    application_status
    
FROM
    Application
WHERE
    application_status = 'Accepted'    ;

-- ------------------------------------------------------------------------------------------------------

-- 19. Listing Interviews that are 'UPCOMING' OR have 'COMPLETED' status with 'good' in feedback
SELECT
    interview_id,
    interview_date,
    interview_status,
    interview_feedback
FROM
    Interview
WHERE
    interview_status = 'UPCOMING'
    OR (interview_status = 'COMPLETED' AND interview_feedback LIKE '%good%');
-- ---------------------------------------------------------------------------------------

-- 20. Rename column recruitment_position to position in RecruiterProfile
ALTER TABLE RecruiterProfile CHANGE COLUMN recruitment_position position VARCHAR(50) ;

-- -------------------------------------------------------------------------------------

-- 21. Drop portfolio_link column from Candidate
ALTER TABLE Candidate DROP COLUMN portfolio_link;

-- -------------------------------------------------------------------------------------

-- 22. Add check constraint for feedback_ratings between 1 and 5 in Feedback
ALTER TABLE Feedback ADD CONSTRAINT chk_feedback_ratings CHECK (feedback_ratings BETWEEN 1 AND 5);

-- -------------------------------------------------------------------------------------

-- 23. Drop CHECK constraint on feedback_ratings in Feedback
Alter table feedback drop constraint chk_feedback_ratings;

-- -------------------------------------------------------------------------------------

-- 24. Add unique constraint on job_title in Job
ALTER TABLE Job ADD CONSTRAINT unique_job_title UNIQUE(job_title);

-- -------------------------------------------------------------------------------------

-- 25. Drop unique constraint on job_title in Job
   ALTER TABLE Job DROP INDEX unique_job_title;
   
-- -------------------------------------------------------------------------------------
   
-- 26. Set default value for job_status in Job to 'OPEN'
ALTER TABLE Job MODIFY COLUMN job_status VARCHAR(50) DEFAULT 'OPEN';

-- -------------------------------------------------------------------------------------


-- 27. Remove the default value set on the 'job_status' column in the 'Job' table
ALTER TABLE Job ALTER COLUMN job_status DROP DEFAULT;

-- -------------------------------------------------------------------------------------

-- 28. Drop the foreign key constraint named 'fk_feedback_user' from the 'Feedback' table
ALTER TABLE Feedback DROP FOREIGN KEY fk_feedback_user;

-- -------------------------------------------------------------------------------------

-- 29. Completely remove the 'Feedback' table and all its data from the database
DROP TABLE Feedback;

-- -------------------------------------------------------------------------------------

-- 30. List all jobs with their company names
SELECT
    j.job_title,
    c.company_name,
    j.job_location
FROM
    Job AS j
INNER JOIN
    Company AS c ON j.company_id = c.company_id;

-- -------------------------------------------------------------------------------------


-- 31.Listing all companies and any jobs they have posted (including companies with no jobs)
SELECT
    c.company_name,
    j.job_title,
    j.job_status
FROM
    Company AS c
LEFT JOIN
    Job AS j ON c.company_id = j.company_id;

-- -------------------------------------------------------------------------------------


-- 32. Listing all applications and the jobs they are for (including applications not linked to jobs, if any)
SELECT
    a.application_id,
    j.job_title,
    a.application_status
FROM
    Job AS j
RIGHT JOIN
    job_and_Application AS jaa ON j.job_id = jaa.job_id
RIGHT JOIN
    Application AS a ON jaa.application_id = a.application_id;

-- -------------------------------------------------------------------------------------


-- 33.  Listing all users and recruiters, showing if they have a recruiter profile.
SELECT
    u.first_name,
    u.last_name,
    rp.recruiter_id
FROM
    Users AS u
LEFT JOIN
    RecruiterProfile AS rp ON u.userID = rp.userID
UNION
SELECT
    u.first_name,
    u.last_name,
    rp.recruiter_id
FROM
    Users AS u
RIGHT JOIN
    RecruiterProfile AS rp ON u.userID = rp.userID
WHERE u.userID IS NULL;

-- -------------------------------------------------------------------------------------


-- 34.Listing all jobs and their requirements
SELECT
    j.job_title,
    jr.Required_qualification,
    jr.Required_skills
FROM
    Job AS j
NATURAL JOIN
    JOB_Requirement AS jr;

-- -------------------------------------------------------------------------------------

-- 35.  Counting total applications for each job
SELECT
    j.job_title,
    COUNT(jaa.application_id) AS total_applications
FROM
    Job AS j
LEFT JOIN
    job_and_Application AS jaa ON j.job_id = jaa.job_id
GROUP BY
    j.job_title;

-- -------------------------------------------------------------------------------------



-- 36.  Calculating the average feedback rating
SELECT
    AVG(feedback_ratings) AS average_rating
FROM
    Feedback;

-- -------------------------------------------------------------------------------------

-- 37. Finding candidates who have applied for 'Android Developer' or 'Data Scientist' jobs
SELECT
    u.first_name,
    u.last_name,
    u.user_email
FROM
    Users AS u
INNER JOIN
    Candidate AS c ON u.userID = c.userID
INNER JOIN
    Application_and_candidate AS aac ON c.candidate_id = aac.candidate_id
INNER JOIN
    job_and_Application AS jaa ON aac.application_id = jaa.application_id
INNER JOIN
    Job AS j ON jaa.job_id = j.job_id
WHERE
    j.job_title IN ('Android Developer', 'Data Scientist');

-- -------------------------------------------------------------------------------------


-- 38. Listing jobs posted between '2025-05-01' and '2025-05-15'
SELECT
    job_title,
    posted_date,
    c.company_name
FROM
    Job AS j
INNER JOIN
    Company AS c ON j.company_id = c.company_id
WHERE
    j.posted_date BETWEEN '2025-05-01' AND '2025-05-15';

-- -------------------------------------------------------------------------------------


-- 39.Listing all interviews with no feedback yet (interview_feedback is NULL)
SELECT
    i.interview_id,
    i.interview_date,
    u.first_name AS candidate_first_name,
    u.last_name AS candidate_last_name
FROM
    Interview AS i
INNER JOIN
    Candidate AS cand ON i.candidate_id = cand.candidate_id
INNER JOIN
    Users AS u ON cand.userID = u.userID
WHERE
    i.interview_feedback IS NULL;

-- -------------------------------------------------------------------------------------


-- 40.  Listing all candidates who have provided a resume link (resume_link is NOT NULL)
SELECT
    c.candidate_id,
    u.first_name,
    u.last_name,
    c.resume_link
FROM
    Candidate AS c
INNER JOIN
    Users AS u ON c.userID = u.userID
WHERE
    c.resume_link IS NOT NULL;

-- -------------------------------------------------------------------------------------


-- 41.Departments with 'OPEN' jobs
SELECT
    c.company_name,
    COUNT(j.job_id) AS number_of_open_jobs
FROM
    Company AS c
INNER JOIN
    Job AS j ON c.company_id = j.company_id
WHERE
    j.job_status = 'OPEN'
GROUP BY
    c.company_name;

-- -------------------------------------------------------------------------------------

-- 42. Finding all candidates who have saved at least one job
SELECT
    u.first_name,
    u.last_name,
    COUNT(sj.saved_id) AS jobs_saved
FROM
    Users AS u
INNER JOIN
    Candidate AS c ON u.userID = c.userID
INNER JOIN
    Saved_JOB AS sj ON c.candidate_id = sj.candidate_id
GROUP BY
    u.first_name, u.last_name
HAVING
    COUNT(sj.saved_id) > 0;

-- -------------------------------------------------------------------------------------


-- 43. Listing all recruiters along with the company they work for and their user contact info
SELECT
    u.first_name AS recruiter_first_name,
    u.last_name AS recruiter_last_name,
    rp.position,
    comp.company_name,
    u.user_email,
    u.user_phone
FROM
    RecruiterProfile AS rp
INNER JOIN
    Users AS u ON rp.userID = u.userID
INNER JOIN
    Company AS comp ON rp.company_id = comp.company_id;
desc RecruiterProfile;
-- -------------------------------------------------------------------------------------


-- 44. Finding all applications that were 'Rejected' for 'REMOTE' jobs
SELECT
    a.application_id,
    a.application_date,
    j.job_title,
    j.job_type
FROM
    Application AS a
INNER JOIN
    job_and_Application AS jaa ON a.application_id = jaa.application_id
INNER JOIN
    Job AS j ON jaa.job_id = j.job_id
WHERE
    a.application_status = 'Rejected'
    AND j.job_type = 'REMOTE';

-- -------------------------------------------------------------------------------------


-- 45. Listing companies in 'Lahore, Pakistan' that posted jobs requiring 'Java' skills
SELECT DISTINCT
    c.company_name,
    c.company_location
FROM
    Company AS c
INNER JOIN
    Job AS j ON c.company_id = j.company_id
INNER JOIN
    JOB_Requirement AS jr ON j.requirement_id = jr.requirement_id
WHERE
    c.company_location = 'Lahore, Pakistan'
    AND jr.Required_skills LIKE '%Java%';

-- -------------------------------------------------------------------------------------


-- 46. Counting how many  jobs belong to unique categories 
SELECT

    c.category_name,
    COUNT(DISTINCT jjc.job_id) AS number_of_jobs
FROM
    category AS c
LEFT JOIN
    job_and_jobCategory AS jjc ON c.category_id = jjc.category_id
GROUP BY
    c.category_name;

-- -------------------------------------------------------------------------------------

-- 47. Find the user (candidate) who submitted feedback with a rating of 5
SELECT
    u.first_name,
    u.last_name,
    f.feedback_message
FROM
    Users AS u
    
INNER JOIN
    Feedback AS f ON u.userID = f.userID
inner join candidate as c on c.userId=u.userID
WHERE
    f.feedback_ratings = 5;
-- -------------------------------------------------------------------------------------


-- 48. Listing all job titles with their associated required qualifications and experience
SELECT
    j.job_title,
    jr.Required_qualification,
    jr.Required_experience
FROM
    Job AS j
INNER JOIN
    JOB_Requirement AS jr ON j.requirement_id = jr.requirement_id;

-- -------------------------------------------------------------------------------------

-- 49. Counting the number of 'Candidate' users whose email starts with 'a'
SELECT
    COUNT(userID) AS num_candidates_email_a
FROM
    Users
WHERE
    user_role = 'Candidate' AND user_email LIKE 'a%';

-- -------------------------------------------------------------------------------------


-- 50. Counting the number of jobs posted each day that are 'OPEN' and have atleast 1 job posted on that day
SELECT
    posted_date,
    COUNT(job_id) AS jobs_posted_count
FROM
    Job
WHERE
    job_status = 'OPEN'
GROUP BY
    posted_date
HAVING
    COUNT(job_id) > 0;

-- -------------------------------------------------------------------------------------


-- 51. Finding the total number of 'Accepted' job applications
SELECT
    COUNT(application_id) AS total_accepted_applications
FROM
    Application
WHERE
    application_status = 'Accepted';

-- -------------------------------------------------------------------------------------


-- 52. Getting the count of jobs with a deadline in June 2025
SELECT
    COUNT(job_id) AS jobs_in_june_2025
FROM
    Job
WHERE
    job_deadline BETWEEN '2025-06-01' AND '2025-06-30';

-- -------------------------------------------------------------------------------------


-- 53. Listing job categories that have descriptions mentioning 'development'
SELECT
    category_name,
    category_description
FROM
    Category
WHERE
    category_description LIKE '%development%';

-- -------------------------------------------------------------------------------------

-- 54. Finding candidates who have 'JavaScript' skills and have at least 1 year of experience
SELECT
    candidate_id,
    candidate_skill,
    candidate_experience
FROM
    Candidate
WHERE
	candidate_skill LIKE '%JavaScript%' AND candidate_experience LIKE '%1 year%';

-- -------------------------------------------------------------------------------------


-- 57. Count the number of users whose role is either 'Admin' or 'Recruiter'
SELECT
    COUNT(userID)AS num_admin_or_recruiter_users
FROM
    Users
WHERE
    user_role IN ('Admin', 'Recruiter');

-- -------------------------------------------------------------------------------------

-- 58. Listing job IDs and titles for jobs that are 'OPEN' and have a job_description that is NOT NULL
SELECT
    job_id,
    job_title
FROM
    Job
WHERE
    job_status = 'OPEN' AND job_description IS NOT NULL;

-- -------------------------------------------------------------------------------------

-- 59. Listing job IDs and titles for jobs that are 'CLOSE' and have a job_description that is NULL
SELECT
    job_id,
    job_title
FROM
    Job
WHERE
    job_status = 'CLOSE' AND job_description IS NULL;
    
-- -------------------------------------------------------------------------------------


-- SET OPERATOR QUERIES

-- 60. List all user IDs who are either Candidates or Recruiters (UNION)
SELECT userID FROM Users WHERE user_role = 'Candidate'
UNION
SELECT userID FROM Users WHERE user_role = 'Recruiter';

-- -------------------------------------------------------------------------------------


-- 61. Combine job titles and category names (UNION ALL)
SELECT job_title AS name FROM Job
UNION ALL
SELECT category_name FROM Category;

-- -------------------------------------------------------------------------------------

-- 62. Show candidate_ids who applied and also who got interviewed (UNION)
SELECT candidate_id FROM application_and_candidate
UNION
SELECT candidate_id FROM Interview;

-- -------------------------------------------------------------------------------------

-- 63. Candidates who applied but not interviewed (LEFT JOIN with IS NULL = EXCEPT)
SELECT DISTINCT a.candidate_id
FROM application_and_candidate a
LEFT JOIN Interview i ON a.candidate_id = i.candidate_id
WHERE i.interview_status='upcoming';

-- -------------------------------------------------------------------------------------



-- 64. Candidates with 'Java' skills AND those interviewed (INTERSECT via JOIN)
SELECT DISTINCT c.candidate_id
FROM Candidate c
JOIN Interview i ON c.candidate_id = i.candidate_id
WHERE c.candidate_skill LIKE '%Java%';

-- -------------------------------------------------------------------------------------

-- SUBQUERY QUERIES

-- 65. Users who have given feedback (using IN)
SELECT userID, first_name FROM Users
WHERE userID IN (SELECT userID FROM Feedback);

-- -------------------------------------------------------------------------------------

-- 66. Jobs where the requirement includes 'Python' (Subquery in WHERE)
SELECT job_id, job_title
FROM Job
WHERE requirement_id IN (
  SELECT requirement_id FROM JOB_Requirement WHERE Required_skills LIKE '%Python%'
);

-- -------------------------------------------------------------------------------------

-- 67. Candidates who saved more than one job
SELECT candidate_id FROM Saved_JOB
GROUP BY candidate_id
HAVING COUNT(*) > 1;

-- -------------------------------------------------------------------------------------

-- 68. Jobs saved by candidate 'C001' with salary greater than upper range greater than 90000
SELECT job_id, salary_range
FROM Job
WHERE job_id IN (
    SELECT job_id FROM Saved_JOB WHERE candidate_id = 'C001'
)
AND salary_range LIKE '%90000%' OR salary_range LIKE '%100000%' OR salary_range LIKE '%120000%';

-- -------------------------------------------------------------------------------------

-- 69. Candidates with higher experience more than 1 year 
SELECT candidate_id, candidate_skill, candidate_experience
FROM Candidate
WHERE candidate_id IN (
    SELECT candidate_id
    FROM Candidate
    WHERE candidate_experience LIKE '%years%'
      AND candidate_experience NOT LIKE '%1 year%'
);
-- -------------------------------------------------------------------------------------

-- 70. Companies with more than 1 job (Subquery in HAVING)
SELECT company_id
FROM Job
GROUP BY company_id
HAVING COUNT(job_id) > 1;

-- -------------------------------------------------------------------------------------

-- 71. Candidates who applied to jobs posted by 'CMP001'
SELECT DISTINCT c.candidate_id
FROM Candidate c
WHERE c.candidate_id IN (
  SELECT a.candidate_id
  FROM application_and_candidate a
  JOIN job_and_Application ja ON a.application_id = ja.application_id
  JOIN Job j ON ja.job_id = j.job_id
  WHERE j.company_id = 'CMP001'
);

-- -------------------------------------------------------------------------------------

-- 72. Feedback messages from users who are Recruiters
SELECT feedback_message
FROM Feedback
WHERE userID IN (
  SELECT userID FROM Users WHERE user_role = 'Recruiter'
);

-- -------------------------------------------------------------------------------------

-- 73. Recruiters with more than one interview scheduled
SELECT recruiter_id FROM Interview
GROUP BY recruiter_id
HAVING COUNT(*) >1;

-- -------------------------------------------------------------------------------------

-- 74. Candidates who never saved any job
SELECT candidate_id FROM Candidate
WHERE candidate_id NOT IN (
  SELECT DISTINCT candidate_id FROM Saved_JOB
);

-- -------------------------------------------------------------------------------------

--  VIEW CandidateApplicationView
--  
-- 75. View: Full Candidate Profile
CREATE VIEW CandidateProfileView AS
SELECT u.first_name, u.last_name, u.user_email, c.*
FROM Users u
JOIN Candidate c ON u.userID = c.userID;

-- Get all candidates who have experience containing "internship"
SELECT * 
FROM CandidateProfileView
WHERE candidate_experience LIKE '%internship%';

-- -------------------------------------------------------------------------------------

-- 76. View: Open Jobs with Company Name
CREATE VIEW OpenJobsWithCompany AS
SELECT j.job_id, j.job_title, j.salary_range, j.job_location, c.company_name
FROM Job j
JOIN Company c ON j.company_id = c.company_id
WHERE j.job_status = 'OPEN';


-- List all open jobs offered by companies in Lahore
SELECT * 
FROM OpenJobsWithCompany
WHERE job_location LIKE '%Lahore%';

-- -------------------------------------------------------------------------------------

-- 77. View: Recruiters and Their Companies
CREATE VIEW RecruiterCompanyDetails AS
SELECT r.recruiter_id, u.first_name, u.last_name, cmp.company_name
FROM RecruiterProfile r
JOIN Users u ON r.userID = u.userID
JOIN Company cmp ON r.company_id = cmp.company_id;

-- .Show recruiters working at companies with "Tech" in their name
SELECT * 
FROM RecruiterCompanyDetails
WHERE company_name LIKE '%Tech%';

-- -------------------------------------------------------------------------------------


-- 78. View: Job Applications with Status
CREATE VIEW ApplicationSummary AS
SELECT a.application_id, a.application_status, u.first_name, u.last_name
FROM Application a
JOIN Candidate c ON a.candidate_id = c.candidate_id
JOIN Users u ON c.userID = u.userID;

-- . Count how many applications each candidate submitted
SELECT first_name, last_name, COUNT(application_id) AS total_applications
FROM ApplicationSummary
GROUP BY first_name, last_name;

-- -------------------------------------------------------------------------------------

-- 79. View: Feedback Ratings Above Average
CREATE VIEW PositiveFeedback AS
SELECT f.*, u.first_name
FROM Feedback f
JOIN Users u ON f.userID = u.userID
WHERE f.feedback_ratings > (
  SELECT AVG(feedback_ratings) FROM Feedback
);

-- Get all positive feedback messages that mention "help"
SELECT feedback_id, feedback_message, feedback_ratings, first_name
FROM PositiveFeedback
WHERE feedback_message LIKE '%help%';

-- -------------------------------------------------------------------------------------



-- 3.PROCEDURES


-- 80. Get Jobs by Company
DELIMITER //
CREATE PROCEDURE GetJobsByCompany(IN companyId VARCHAR(10))
BEGIN
  SELECT * FROM Job WHERE company_id = companyId;
END;
//
DELIMITER ;
-- -------------------------------------------------------------------------------------

-- 81. Insert Feedback
DELIMITER //
CREATE PROCEDURE AddFeedback(
  IN fid VARCHAR(10), IN message TEXT, IN rating INT, IN uid VARCHAR(10)
)
BEGIN
  INSERT INTO Feedback (feedback_id, feedback_message, feedback_ratings, userID)
  VALUES (fid, message, rating, uid);
END;
//
DELIMITER ;
-- -------------------------------------------------------------------------------------

-- 82. Get Candidate Interviews
DELIMITER //
CREATE PROCEDURE GetCandidateInterviews(IN cid VARCHAR(10))
BEGIN
  SELECT * FROM Interview WHERE candidate_id = cid;
END;
//
DELIMITER ;
-- -------------------------------------------------------------------------------------

-- 83. Close Job By ID
DELIMITER //
CREATE PROCEDURE CloseJobById(IN jobId VARCHAR(10))
BEGIN
  UPDATE Job SET job_status = 'CLOSED' WHERE job_id = jobId;
END;
//
DELIMITER ;
-- -------------------------------------------------------------------------------------

-- 84. Count Applications Per Job
DELIMITER //
CREATE PROCEDURE CountApplicationsPerJob()
BEGIN
  SELECT j.job_id, j.job_title, COUNT(ja.application_id) AS total_applications
  FROM Job j
  JOIN job_and_Application ja ON j.job_id = ja.job_id
  GROUP BY j.job_id;
END;
//
DELIMITER ;
-- -------------------------------------------------------------------------------------

-- Call 1: Get jobs for a company
CALL GetJobsByCompany('CMP001');
-- -------------------------------------------------------------------------------------

-- Call 2: Add feedback
CALL AddFeedback('FDB021', 'Great system overall.', 5, 'U011');
-- -------------------------------------------------------------------------------------

-- Call 3: Get interviews for candidate C001
CALL GetCandidateInterviews('C001');
-- -------------------------------------------------------------------------------------

-- Call 4: Close job J002
CALL CloseJobById('J002');
-- -------------------------------------------------------------------------------------

-- Call 5: Count applications for each job
CALL CountApplicationsPerJob();
-- -------------------------------------------------------------------------------------
