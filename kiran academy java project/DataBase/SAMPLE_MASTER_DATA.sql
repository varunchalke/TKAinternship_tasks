
-- =====================================================
-- RPMS - SAMPLE MASTER DATA
-- Database: rpms_db
-- =====================================================

USE rpms_db;


SELECT COUNT(*) AS total_tables
FROM information_schema.tables
WHERE table_schema = 'rpms_db'
AND table_type = 'BASE TABLE';

-- =====================================================
-- 1. ROLES (3 RECORDS)
-- =====================================================

INSERT IGNORE INTO roles (role_code, role_name)
VALUES
('ADMIN', 'Administrator'),
('RECRUITER', 'Recruiter'),
('PLACEMENT_OFFICER', 'Placement Officer');


-- =====================================================
-- 2. USERS (5 RECORDS)
-- Demo password hashes use PBKDF2.
-- All demo accounts are INACTIVE until configured.
-- =====================================================

INSERT IGNORE INTO users
(username, password_hash, full_name, email, role_id, status)
SELECT
'admin',
'PBKDF2WithHmacSHA256$210000$mhp2_gIQPjhyT4Y83TVMsg$-o1Nos048dSGklv0HyYf060iXJUAke3uN4cvLDf7bfg',
'System Administrator',
'admin@rpms.example',
role_id,
'INACTIVE'
FROM roles WHERE role_code = 'ADMIN';

INSERT IGNORE INTO users
(username, password_hash, full_name, email, role_id, status)
SELECT
'recruiter1',
'PBKDF2WithHmacSHA256$210000$oRUZMaRP5FLikFU9YYGzDA$whkb6GMlMaOfobhXahW_PvHVeJHM9wMw1VO-8cH5eI4',
'Recruiter One',
'recruiter1@rpms.example',
role_id,
'INACTIVE'
FROM roles WHERE role_code = 'RECRUITER';

INSERT IGNORE INTO users
(username, password_hash, full_name, email, role_id, status)
SELECT
'recruiter2',
'PBKDF2WithHmacSHA256$210000$R5Jt83Wr8OFHolx5jI9qqg$16IOS3t1O5ozdrRVWu7h1d1vBvayy-08fSXQmyu8rW4',
'Recruiter Two',
'recruiter2@rpms.example',
role_id,
'INACTIVE'
FROM roles WHERE role_code = 'RECRUITER';

INSERT IGNORE INTO users
(username, password_hash, full_name, email, role_id, status)
SELECT
'placement1',
'PBKDF2WithHmacSHA256$210000$I9OCh83eGhBUcaMKEF6yew$Vr69OHzdajdA5jCmGSb8EHygZNDvNAUgOricy5qF45U',
'Placement Officer One',
'placement1@rpms.example',
role_id,
'INACTIVE'
FROM roles WHERE role_code = 'PLACEMENT_OFFICER';

INSERT IGNORE INTO users
(username, password_hash, full_name, email, role_id, status)
SELECT
'placement2',
'PBKDF2WithHmacSHA256$210000$c82cTyQ2NMQU_w75jGSrIQ$Mb84zqmz_S3HA5-2w5iJnEO4gZvBCqcaKPtZugyOeNw',
'Placement Officer Two',
'placement2@rpms.example',
role_id,
'INACTIVE'
FROM roles WHERE role_code = 'PLACEMENT_OFFICER';


-- =====================================================
-- 3. SKILLS (10 RECORDS)
-- =====================================================

INSERT IGNORE INTO skills (skill_name, category)
VALUES
('Java', 'Programming'),
('Python', 'Programming'),
('SQL', 'Database'),
('MySQL', 'Database'),
('HTML', 'Web Development'),
('CSS', 'Web Development'),
('JavaScript', 'Programming'),
('React', 'Web Development'),
('Spring Boot', 'Framework'),
('Manual Testing', 'Testing');


-- =====================================================
-- 4. CANDIDATES (30 RECORDS)
-- All candidate emails and demo contact labels are synthetic; no real phone numbers or websites are used.
-- =====================================================

INSERT IGNORE INTO candidates
(candidate_code, full_name, email, mobile,
 qualification, college, university, passing_year,
 percentage, cgpa, backlog_count, primary_technology,
 current_location, preferred_location,
 profile_status, placement_status)
VALUES

('CAN-2026-0001','Aarav Deshmukh','candidate01@rpms.example','DEMO-CAN-0001',
'BE','ABC College','Mumbai University',2025,78.50,8.10,0,'Java','Pune','Pune','ACTIVE','NOT_PLACED'),

('CAN-2026-0002','Ananya Kulkarni','candidate02@rpms.example','DEMO-CAN-0002',
'BE','XYZ College','Pune University',2025,82.00,8.50,0,'Java','Mumbai','Pune','ACTIVE','NOT_PLACED'),

('CAN-2026-0003','Rohan Patil','candidate03@rpms.example','DEMO-CAN-0003',
'BTech','Modern College','SPPU',2026,75.00,7.80,0,'Python','Pune','Mumbai','ACTIVE','NOT_PLACED'),

('CAN-2026-0004','Priya Shah','candidate04@rpms.example','DEMO-CAN-0004',
'MCA','City College','Mumbai University',2025,85.00,8.90,0,'SQL','Mumbai','Mumbai','ACTIVE','NOT_PLACED'),

('CAN-2026-0005','Kunal Joshi','candidate05@rpms.example','DEMO-CAN-0005',
'BE','Engineering College','SPPU',2025,72.50,7.50,1,'JavaScript','Nashik','Pune','ACTIVE','NOT_PLACED'),

('CAN-2026-0006','Sneha Patil','candidate06@rpms.example','DEMO-CAN-0006',
'BTech','Tech College','SPPU',2026,88.00,9.10,0,'React','Pune','Mumbai','ACTIVE','NOT_PLACED'),

('CAN-2026-0007','Rahul Patil','candidate07@rpms.example','DEMO-CAN-0007',
'BE','Engineering College','SPPU',2025,80.00,8.30,0,'Java','Ratnagiri','Pune','ACTIVE','NOT_PLACED'),

('CAN-2026-0008','Neha Sharma','candidate08@rpms.example','DEMO-CAN-0008',
'MCA','ABC Institute','Mumbai University',2025,76.00,7.90,0,'Python','Mumbai','Mumbai','ACTIVE','NOT_PLACED'),

('CAN-2026-0009','Aditya More','candidate09@rpms.example','DEMO-CAN-0009',
'BE','Modern College','SPPU',2026,69.50,7.10,1,'MySQL','Pune','Pune','ACTIVE','NOT_PLACED'),

('CAN-2026-0010','Pooja Pawar','candidate10@rpms.example','DEMO-CAN-0010',
'BSc','Science College','Mumbai University',2025,84.00,8.70,0,'Manual Testing','Mumbai','Pune','ACTIVE','NOT_PLACED'),

('CAN-2026-0011','Siddharth Jadhav','candidate11@rpms.example','DEMO-CAN-0011',
'BE','ABC College','SPPU',2025,79.00,8.00,0,'Java','Kolhapur','Pune','ACTIVE','NOT_PLACED'),

('CAN-2026-0012','Isha Desai','candidate12@rpms.example','DEMO-CAN-0012',
'BTech','Tech College','SPPU',2026,91.00,9.40,0,'JavaScript','Pune','Mumbai','ACTIVE','NOT_PLACED'),

('CAN-2026-0013','Omkar Sawant','candidate13@rpms.example','DEMO-CAN-0013',
'MCA','City College','Mumbai University',2025,73.00,7.60,0,'Python','Mumbai','Pune','ACTIVE','NOT_PLACED'),

('CAN-2026-0014','Tanvi Kulkarni','candidate14@rpms.example','DEMO-CAN-0014',
'BE','Engineering College','SPPU',2025,86.00,8.80,0,'Java','Pune','Pune','ACTIVE','NOT_PLACED'),

('CAN-2026-0015','Akash Shinde','candidate15@rpms.example','DEMO-CAN-0015',
'BTech','Modern College','SPPU',2026,67.00,6.90,1,'SQL','Satara','Pune','ACTIVE','NOT_PLACED'),

('CAN-2026-0016','Riya Mehta','candidate16@rpms.example','DEMO-CAN-0016',
'BE','ABC College','Mumbai University',2025,89.00,9.00,0,'React','Mumbai','Mumbai','ACTIVE','NOT_PLACED'),

('CAN-2026-0017','Manish Gupta','candidate17@rpms.example','DEMO-CAN-0017',
'MCA','City College','Mumbai University',2026,77.00,8.00,0,'Java','Pune','Pune','ACTIVE','NOT_PLACED'),

('CAN-2026-0018','Kavya Nair','candidate18@rpms.example','DEMO-CAN-0018',
'BSc','Science College','Mumbai University',2025,81.00,8.40,0,'Manual Testing','Mumbai','Mumbai','ACTIVE','NOT_PLACED'),

('CAN-2026-0019','Nikhil Pawar','candidate19@rpms.example','DEMO-CAN-0019',
'BE','Tech College','SPPU',2025,74.00,7.70,0,'Python','Pune','Pune','ACTIVE','NOT_PLACED'),

('CAN-2026-0020','Meera Joshi','candidate20@rpms.example','DEMO-CAN-0020',
'BTech','Engineering College','SPPU',2026,90.00,9.20,0,'Java','Mumbai','Pune','ACTIVE','NOT_PLACED'),

('CAN-2026-0021','Sahil More','candidate21@rpms.example','DEMO-CAN-0021',
'BE','ABC College','SPPU',2025,70.00,7.20,0,'MySQL','Nashik','Pune','ACTIVE','NOT_PLACED'),

('CAN-2026-0022','Aditi Shah','candidate22@rpms.example','DEMO-CAN-0022',
'MCA','City College','Mumbai University',2026,87.00,8.90,0,'JavaScript','Mumbai','Mumbai','ACTIVE','NOT_PLACED'),

('CAN-2026-0023','Varun Desai','candidate23@rpms.example','DEMO-CAN-0023',
'BE','Modern College','SPPU',2025,83.00,8.60,0,'Java','Pune','Pune','ACTIVE','NOT_PLACED'),

('CAN-2026-0024','Sakshi Patil','candidate24@rpms.example','DEMO-CAN-0024',
'BTech','Tech College','SPPU',2026,68.00,7.00,2,'SQL','Ratnagiri','Pune','ACTIVE','NOT_PLACED'),

('CAN-2026-0025','Dev Malhotra','candidate25@rpms.example','DEMO-CAN-0025',
'MCA','ABC Institute','Mumbai University',2025,92.00,9.50,0,'React','Mumbai','Mumbai','ACTIVE','NOT_PLACED'),

('CAN-2026-0026','Simran Kaur','candidate26@rpms.example','DEMO-CAN-0026',
'BE','Engineering College','SPPU',2025,75.50,7.80,0,'Python','Pune','Pune','ACTIVE','NOT_PLACED'),

('CAN-2026-0027','Yash Chavan','candidate27@rpms.example','DEMO-CAN-0027',
'BTech','Modern College','SPPU',2026,80.00,8.20,0,'Java','Kolhapur','Mumbai','ACTIVE','NOT_PLACED'),

('CAN-2026-0028','Nikita Rao','candidate28@rpms.example','DEMO-CAN-0028',
'BSc','Science College','Mumbai University',2025,71.00,7.40,1,'Manual Testing','Mumbai','Pune','ACTIVE','NOT_PLACED'),

('CAN-2026-0029','Arjun Bhosale','candidate29@rpms.example','DEMO-CAN-0029',
'BE','Tech College','SPPU',2026,85.00,8.80,0,'MySQL','Pune','Pune','ACTIVE','NOT_PLACED'),

('CAN-2026-0030','Diya Fernandes','candidate30@rpms.example','DEMO-CAN-0030',
'MCA','City College','Mumbai University',2025,88.00,9.10,0,'JavaScript','Mumbai','Mumbai','ACTIVE','NOT_PLACED');


-- =====================================================
-- 5. CANDIDATE SKILLS
-- Maps each candidate's primary technology to skills.
-- =====================================================

INSERT IGNORE INTO candidate_skills
(candidate_id, skill_id, proficiency_level, years_experience, is_primary)
SELECT
c.candidate_id,
s.skill_id,
'INTERMEDIATE',
0.0,
1
FROM candidates c
JOIN skills s
ON s.skill_name = c.primary_technology;


-- =====================================================
-- 6. COMPANIES (8 RECORDS)
-- =====================================================

INSERT IGNORE INTO companies
(company_code, company_name, industry, website, location,
 company_type, hr_name, hr_email, hr_mobile, status)
VALUES

('COM-001','Infosys','IT Services',NULL,
'Pune','MNC','HR Contact 1','hr1@infosys.example','DEMO-HR-0001','ACTIVE'),

('COM-002','Wipro','IT Services',NULL,
'Mumbai','MNC','HR Contact 2','hr2@wipro.example','DEMO-HR-0002','ACTIVE'),

('COM-003','Persistent Systems','Software Development',NULL,
'Pune','MID_SIZE','HR Contact 3','hr3@persistent.example','DEMO-HR-0003','ACTIVE'),

('COM-004','Tata Consultancy Services','IT Services',NULL,
'Mumbai','MNC','HR Contact 4','hr4@tcs.example','DEMO-HR-0004','ACTIVE'),

('COM-005','Accenture','Consulting',NULL,
'Pune','MNC','HR Contact 5','hr5@accenture.example','DEMO-HR-0005','ACTIVE'),

('COM-006','Capgemini','IT Services',NULL,
'Mumbai','MNC','HR Contact 6','hr6@capgemini.example','DEMO-HR-0006','ACTIVE'),

('COM-007','Cognizant','IT Services',NULL,
'Pune','MNC','HR Contact 7','hr7@cognizant.example','DEMO-HR-0007','ACTIVE'),

('COM-008','Tech Mahindra','IT Services',NULL,
'Mumbai','MNC','HR Contact 8','hr8@techmahindra.example','DEMO-HR-0008','ACTIVE');


-- =====================================================
-- 7. JOBS (12 RECORDS)
-- Job dates are calculated from the current date.
-- =====================================================

INSERT IGNORE INTO jobs
(job_code, company_id, job_title, employment_type, location,
 openings, min_package_lpa, max_package_lpa,
 min_percentage, min_passing_year, max_passing_year,
 max_backlogs, experience_min_years, qualification_rule,
 posted_date, application_deadline, status, created_by)

SELECT
v.job_code,
co.company_id,
v.job_title,
v.employment_type,
v.location,
v.openings,
v.min_package_lpa,
v.max_package_lpa,
v.min_percentage,
v.min_passing_year,
v.max_passing_year,
v.max_backlogs,
v.experience_min_years,
v.qualification_rule,
DATE_SUB(CURDATE(), INTERVAL 5 DAY),
DATE_ADD(CURDATE(), INTERVAL 30 DAY),
v.job_status,
u.user_id

FROM
(
    SELECT
    'JOB-2026-001' AS job_code, 'COM-001' AS company_code,
    'Associate Java Developer' AS job_title,
    'FULL_TIME' AS employment_type, 'Pune' AS location,
    5 AS openings, 3.50 AS min_package_lpa, 5.00 AS max_package_lpa,
    60.00 AS min_percentage, 2024 AS min_passing_year,
    2026 AS max_passing_year, 0 AS max_backlogs,
    0.0 AS experience_min_years,
    'BE/BTech/MCA with Java knowledge' AS qualification_rule,
    'OPEN' AS job_status

    UNION ALL SELECT
    'JOB-2026-002','COM-002','Graduate Engineer Trainee',
    'FULL_TIME','Mumbai',8,3.00,4.50,60.00,2024,2026,0,0.0,
    'BE/BTech graduates','OPEN'

    UNION ALL SELECT
    'JOB-2026-003','COM-003','Python Developer',
    'FULL_TIME','Pune',3,4.00,6.00,65.00,2024,2026,0,0.0,
    'BE/BTech/MCA with Python knowledge','OPEN'

    UNION ALL SELECT
    'JOB-2026-004','COM-004','Software Testing Trainee',
    'FULL_TIME','Mumbai',6,3.20,4.80,60.00,2024,2026,1,0.0,
    'Any graduate with testing knowledge','OPEN'

    UNION ALL SELECT
    'JOB-2026-005','COM-005','Frontend Developer',
    'FULL_TIME','Pune',4,4.00,6.50,65.00,2024,2026,0,0.0,
    'BE/BTech with HTML CSS JavaScript','OPEN'

    UNION ALL SELECT
    'JOB-2026-006','COM-006','Data Analyst',
    'FULL_TIME','Mumbai',3,4.50,7.00,65.00,2024,2026,0,0.0,
    'BE/BTech/MCA with SQL knowledge','OPEN'

    UNION ALL SELECT
    'JOB-2026-007','COM-007','Full Stack Developer',
    'FULL_TIME','Pune',4,5.00,8.00,65.00,2024,2026,0,0.0,
    'BE/BTech with frontend and backend skills','OPEN'

    UNION ALL SELECT
    'JOB-2026-008','COM-008','Application Support Engineer',
    'FULL_TIME','Mumbai',5,3.50,5.00,60.00,2024,2026,1,0.0,
    'BE/BTech with database knowledge','OPEN'

    UNION ALL SELECT
    'JOB-2026-009','COM-001','Java Backend Developer',
    'FULL_TIME','Pune',3,5.00,7.00,70.00,2024,2026,0,0.0,
    'BE/BTech/MCA with Java and SQL','OPEN'

    UNION ALL SELECT
    'JOB-2026-010','COM-003','Junior SQL Developer',
    'FULL_TIME','Pune',2,3.50,5.50,60.00,2024,2026,0,0.0,
    'Graduate with database knowledge','OPEN'

    UNION ALL SELECT
    'JOB-2026-011','COM-005','Software Engineer Trainee',
    'FULL_TIME','Mumbai',5,4.00,6.00,65.00,2024,2026,0,0.0,
    'BE/BTech/MCA graduates','DRAFT'

    UNION ALL SELECT
    'JOB-2026-012','COM-007','Quality Assurance Engineer',
    'FULL_TIME','Pune',2,3.50,5.00,60.00,2024,2026,0,0.0,
    'Graduate with testing knowledge','CLOSED'
) v

JOIN companies co
ON co.company_code = v.company_code

LEFT JOIN users u
ON u.username = 'admin';


-- =====================================================
-- 8. JOB SKILLS
-- Two skill requirements for each job.
-- =====================================================

INSERT IGNORE INTO job_skills
(job_id, skill_id, minimum_level, mandatory_flag)

SELECT
j.job_id,
s.skill_id,
v.minimum_level,
v.mandatory_flag

FROM
(
    SELECT 'JOB-2026-001' AS job_code,'Java' AS skill_name,'INTERMEDIATE' AS minimum_level,1 AS mandatory_flag
    UNION ALL SELECT 'JOB-2026-001','SQL','BASIC',1
    UNION ALL SELECT 'JOB-2026-002','Java','BASIC',1
    UNION ALL SELECT 'JOB-2026-002','SQL','BASIC',0
    UNION ALL SELECT 'JOB-2026-003','Python','INTERMEDIATE',1
    UNION ALL SELECT 'JOB-2026-003','SQL','BASIC',1
    UNION ALL SELECT 'JOB-2026-004','Manual Testing','BASIC',1
    UNION ALL SELECT 'JOB-2026-004','SQL','BASIC',0
    UNION ALL SELECT 'JOB-2026-005','JavaScript','INTERMEDIATE',1
    UNION ALL SELECT 'JOB-2026-005','CSS','BASIC',1
    UNION ALL SELECT 'JOB-2026-006','SQL','INTERMEDIATE',1
    UNION ALL SELECT 'JOB-2026-006','Python','BASIC',0
    UNION ALL SELECT 'JOB-2026-007','React','INTERMEDIATE',1
    UNION ALL SELECT 'JOB-2026-007','JavaScript','INTERMEDIATE',1
    UNION ALL SELECT 'JOB-2026-008','MySQL','BASIC',1
    UNION ALL SELECT 'JOB-2026-008','SQL','BASIC',1
    UNION ALL SELECT 'JOB-2026-009','Java','ADVANCED',1
    UNION ALL SELECT 'JOB-2026-009','SQL','INTERMEDIATE',1
    UNION ALL SELECT 'JOB-2026-010','SQL','INTERMEDIATE',1
    UNION ALL SELECT 'JOB-2026-010','MySQL','INTERMEDIATE',1
    UNION ALL SELECT 'JOB-2026-011','Java','BASIC',1
    UNION ALL SELECT 'JOB-2026-011','Python','BASIC',0
    UNION ALL SELECT 'JOB-2026-012','Manual Testing','INTERMEDIATE',1
    UNION ALL SELECT 'JOB-2026-012','SQL','BASIC',0
) v

JOIN jobs j
ON j.job_code = v.job_code

JOIN skills s
ON s.skill_name = v.skill_name;


-- =====================================================
-- 9. VERIFICATION
-- =====================================================

SELECT 'Roles' AS table_name, COUNT(*) AS total_records FROM roles
UNION ALL
SELECT 'Users', COUNT(*) FROM users
UNION ALL
SELECT 'Candidates', COUNT(*) FROM candidates
UNION ALL
SELECT 'Skills', COUNT(*) FROM skills
UNION ALL
SELECT 'Candidate Skills', COUNT(*) FROM candidate_skills
UNION ALL
SELECT 'Companies', COUNT(*) FROM companies
UNION ALL
SELECT 'Jobs', COUNT(*) FROM jobs
UNION ALL
SELECT 'Job Skills', COUNT(*) FROM job_skills;
