
-- =====================================================
-- RECRUITMENT & PLACEMENT MANAGEMENT SYSTEM
-- DATABASE SCHEMA
-- Creates the 15 RPMS tables. CREATE TABLE IF NOT EXISTS does not modify existing tables.
-- Database: rpms_db
-- =====================================================

CREATE DATABASE IF NOT EXISTS rpms_db
CHARACTER SET utf8mb4
COLLATE utf8mb4_unicode_ci;

USE rpms_db;


-- =====================================================
-- 1. ROLES
-- =====================================================

CREATE TABLE IF NOT EXISTS roles (
    role_id INT AUTO_INCREMENT PRIMARY KEY,
    role_code VARCHAR(30) NOT NULL UNIQUE,
    role_name VARCHAR(80) NOT NULL,
    is_active TINYINT(1) NOT NULL DEFAULT 1,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;


-- =====================================================
-- 2. USERS
-- =====================================================

CREATE TABLE IF NOT EXISTS users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(80) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    full_name VARCHAR(120) NOT NULL,
    email VARCHAR(150) UNIQUE,
    role_id INT NOT NULL,
    status VARCHAR(20) NOT NULL DEFAULT 'ACTIVE',
    last_login_at DATETIME NULL,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_users_role
        FOREIGN KEY (role_id)
        REFERENCES roles(role_id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
) ENGINE=InnoDB;


-- =====================================================
-- 3. CANDIDATES
-- =====================================================

CREATE TABLE IF NOT EXISTS candidates (
    candidate_id INT AUTO_INCREMENT PRIMARY KEY,
    candidate_code VARCHAR(30) NOT NULL UNIQUE,
    full_name VARCHAR(150) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,
    mobile VARCHAR(20) NOT NULL UNIQUE,
    date_of_birth DATE NULL,
    gender VARCHAR(20) NULL,
    qualification VARCHAR(80) NOT NULL,
    college VARCHAR(180) NULL,
    university VARCHAR(180) NULL,
    passing_year SMALLINT NOT NULL,
    percentage DECIMAL(5,2) NULL,
    cgpa DECIMAL(4,2) NULL,
    backlog_count INT NOT NULL DEFAULT 0,
    primary_technology VARCHAR(80) NULL,
    current_location VARCHAR(100) NULL,
    preferred_location VARCHAR(100) NULL,
    profile_status VARCHAR(20) NOT NULL DEFAULT 'ACTIVE',
    placement_status VARCHAR(20) NOT NULL DEFAULT 'NOT_PLACED',
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
        ON UPDATE CURRENT_TIMESTAMP,

    INDEX idx_candidates_technology (primary_technology),
    INDEX idx_candidates_passing_year (passing_year),
    INDEX idx_candidates_placement_status (placement_status)
) ENGINE=InnoDB;


-- =====================================================
-- 4. SKILLS
-- =====================================================

CREATE TABLE IF NOT EXISTS skills (
    skill_id INT AUTO_INCREMENT PRIMARY KEY,
    skill_name VARCHAR(100) NOT NULL UNIQUE,
    category VARCHAR(60) NULL,
    is_active TINYINT(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB;


-- =====================================================
-- 5. CANDIDATE SKILLS
-- =====================================================

CREATE TABLE IF NOT EXISTS candidate_skills (
    candidate_skill_id INT AUTO_INCREMENT PRIMARY KEY,
    candidate_id INT NOT NULL,
    skill_id INT NOT NULL,
    proficiency_level VARCHAR(20) NULL,
    years_experience DECIMAL(4,1) NOT NULL DEFAULT 0.0,
    is_primary TINYINT(1) NOT NULL DEFAULT 0,

    CONSTRAINT uq_candidate_skill
        UNIQUE (candidate_id, skill_id),

    CONSTRAINT fk_candidate_skills_candidate
        FOREIGN KEY (candidate_id)
        REFERENCES candidates(candidate_id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,

    CONSTRAINT fk_candidate_skills_skill
        FOREIGN KEY (skill_id)
        REFERENCES skills(skill_id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,

    INDEX idx_candidate_skills_candidate (candidate_id),
    INDEX idx_candidate_skills_skill (skill_id)
) ENGINE=InnoDB;


-- =====================================================
-- 6. COMPANIES
-- =====================================================

CREATE TABLE IF NOT EXISTS companies (
    company_id INT AUTO_INCREMENT PRIMARY KEY,
    company_code VARCHAR(30) NOT NULL UNIQUE,
    company_name VARCHAR(180) NOT NULL,
    industry VARCHAR(100) NULL,
    website VARCHAR(200) NULL,
    location VARCHAR(120) NULL,
    company_type VARCHAR(30) NULL,
    hr_name VARCHAR(120) NULL,
    hr_email VARCHAR(150) NULL,
    hr_mobile VARCHAR(20) NULL,
    status VARCHAR(20) NOT NULL DEFAULT 'ACTIVE',
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,

    INDEX idx_companies_name (company_name),
    INDEX idx_companies_status (status)
) ENGINE=InnoDB;


-- =====================================================
-- 7. JOBS
-- =====================================================

CREATE TABLE IF NOT EXISTS jobs (
    job_id INT AUTO_INCREMENT PRIMARY KEY,
    job_code VARCHAR(40) NOT NULL UNIQUE,
    company_id INT NOT NULL,
    job_title VARCHAR(150) NOT NULL,
    employment_type VARCHAR(30) NOT NULL DEFAULT 'FULL_TIME',
    location VARCHAR(120) NOT NULL,
    openings INT NOT NULL,
    min_package_lpa DECIMAL(6,2) NULL,
    max_package_lpa DECIMAL(6,2) NULL,
    min_percentage DECIMAL(5,2) NULL,
    min_passing_year SMALLINT NULL,
    max_passing_year SMALLINT NULL,
    max_backlogs INT NOT NULL DEFAULT 0,
    experience_min_years DECIMAL(4,1) NOT NULL DEFAULT 0.0,
    qualification_rule VARCHAR(255) NULL,
    posted_date DATE NOT NULL,
    application_deadline DATE NOT NULL,
    status VARCHAR(20) NOT NULL DEFAULT 'OPEN',
    created_by INT NULL,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_jobs_company
        FOREIGN KEY (company_id)
        REFERENCES companies(company_id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,

    CONSTRAINT fk_jobs_created_by
        FOREIGN KEY (created_by)
        REFERENCES users(user_id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,

    INDEX idx_jobs_company (company_id),
    INDEX idx_jobs_status (status),
    INDEX idx_jobs_deadline (application_deadline),
    INDEX idx_jobs_location (location)
) ENGINE=InnoDB;


-- =====================================================
-- 8. JOB SKILLS
-- =====================================================

CREATE TABLE IF NOT EXISTS job_skills (
    job_skill_id INT AUTO_INCREMENT PRIMARY KEY,
    job_id INT NOT NULL,
    skill_id INT NOT NULL,
    minimum_level VARCHAR(20) NULL,
    mandatory_flag TINYINT(1) NOT NULL DEFAULT 1,

    CONSTRAINT uq_job_skill
        UNIQUE (job_id, skill_id),

    CONSTRAINT fk_job_skills_job
        FOREIGN KEY (job_id)
        REFERENCES jobs(job_id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,

    CONSTRAINT fk_job_skills_skill
        FOREIGN KEY (skill_id)
        REFERENCES skills(skill_id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
) ENGINE=InnoDB;


-- =====================================================
-- 9. APPLICATIONS
-- =====================================================

CREATE TABLE IF NOT EXISTS applications (
    application_id INT AUTO_INCREMENT PRIMARY KEY,
    application_code VARCHAR(40) NOT NULL UNIQUE,
    candidate_id INT NOT NULL,
    job_id INT NOT NULL,
    applied_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    eligibility_status VARCHAR(20) NOT NULL DEFAULT 'PENDING',
    eligibility_reason VARCHAR(500) NULL,
    application_status VARCHAR(30) NOT NULL DEFAULT 'APPLIED',
    source VARCHAR(50) NULL,
    assigned_recruiter_id INT NULL,
    updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
        ON UPDATE CURRENT_TIMESTAMP,

    CONSTRAINT uq_candidate_job
        UNIQUE (candidate_id, job_id),

    CONSTRAINT fk_applications_candidate
        FOREIGN KEY (candidate_id)
        REFERENCES candidates(candidate_id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,

    CONSTRAINT fk_applications_job
        FOREIGN KEY (job_id)
        REFERENCES jobs(job_id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,

    CONSTRAINT fk_applications_recruiter
        FOREIGN KEY (assigned_recruiter_id)
        REFERENCES users(user_id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,

    INDEX idx_applications_status (application_status),
    INDEX idx_applications_recruiter (assigned_recruiter_id)
) ENGINE=InnoDB;


-- =====================================================
-- 10. APPLICATION HISTORY
-- =====================================================

CREATE TABLE IF NOT EXISTS application_history (
    history_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    application_id INT NOT NULL,
    old_status VARCHAR(30) NULL,
    new_status VARCHAR(30) NOT NULL,
    remarks VARCHAR(500) NULL,
    changed_by INT NULL,
    changed_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_history_application
        FOREIGN KEY (application_id)
        REFERENCES applications(application_id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,

    CONSTRAINT fk_history_user
        FOREIGN KEY (changed_by)
        REFERENCES users(user_id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,

    INDEX idx_history_application (application_id),
    INDEX idx_history_changed_at (changed_at)
) ENGINE=InnoDB;


-- =====================================================
-- 11. INTERVIEW ROUNDS
-- =====================================================

CREATE TABLE IF NOT EXISTS interview_rounds (
    interview_id INT AUTO_INCREMENT PRIMARY KEY,
    application_id INT NOT NULL,
    round_number INT NOT NULL,
    round_type VARCHAR(50) NOT NULL,
    scheduled_date DATE NOT NULL,
    scheduled_time TIME NULL,
    mode VARCHAR(20) NOT NULL,
    interviewer_name VARCHAR(120) NULL,
    meeting_or_location VARCHAR(255) NULL,
    status VARCHAR(20) NOT NULL DEFAULT 'SCHEDULED',
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT uq_application_round
        UNIQUE (application_id, round_number),

    CONSTRAINT fk_interviews_application
        FOREIGN KEY (application_id)
        REFERENCES applications(application_id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,

    INDEX idx_interviews_date (scheduled_date),
    INDEX idx_interviews_status (status)
) ENGINE=InnoDB;


-- =====================================================
-- 12. INTERVIEW FEEDBACK
-- =====================================================

CREATE TABLE IF NOT EXISTS interview_feedback (
    feedback_id INT AUTO_INCREMENT PRIMARY KEY,
    interview_id INT NOT NULL UNIQUE,
    technical_rating DECIMAL(3,1) NULL,
    communication_rating DECIMAL(3,1) NULL,
    problem_solving_rating DECIMAL(3,1) NULL,
    overall_rating DECIMAL(3,1) NULL,
    recommendation VARCHAR(30) NOT NULL,
    remarks TEXT NULL,
    submitted_by INT NULL,
    submitted_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_feedback_interview
        FOREIGN KEY (interview_id)
        REFERENCES interview_rounds(interview_id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,

    CONSTRAINT fk_feedback_user
        FOREIGN KEY (submitted_by)
        REFERENCES users(user_id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,

    INDEX idx_feedback_recommendation (recommendation)
) ENGINE=InnoDB;


-- =====================================================
-- 13. OFFERS
-- =====================================================

CREATE TABLE IF NOT EXISTS offers (
    offer_id INT AUTO_INCREMENT PRIMARY KEY,
    offer_code VARCHAR(40) NOT NULL UNIQUE,
    application_id INT NOT NULL UNIQUE,
    designation VARCHAR(120) NOT NULL,
    offered_package_lpa DECIMAL(6,2) NOT NULL,
    offer_date DATE NOT NULL,
    expected_joining_date DATE NULL,
    offer_status VARCHAR(20) NOT NULL DEFAULT 'OFFERED',
    remarks VARCHAR(500) NULL,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_offers_application
        FOREIGN KEY (application_id)
        REFERENCES applications(application_id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,

    INDEX idx_offers_status (offer_status)
) ENGINE=InnoDB;


-- =====================================================
-- 14. PLACEMENTS
-- =====================================================

CREATE TABLE IF NOT EXISTS placements (
    placement_id INT AUTO_INCREMENT PRIMARY KEY,
    candidate_id INT NOT NULL,
    company_id INT NOT NULL,
    job_id INT NOT NULL,
    offer_id INT NOT NULL UNIQUE,
    designation VARCHAR(120) NOT NULL,
    final_package_lpa DECIMAL(6,2) NOT NULL,
    expected_joining_date DATE NULL,
    actual_joining_date DATE NULL,
    joining_status VARCHAR(20) NOT NULL DEFAULT 'PENDING',
    placement_status VARCHAR(20) NOT NULL DEFAULT 'ACTIVE',
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_placements_candidate
        FOREIGN KEY (candidate_id)
        REFERENCES candidates(candidate_id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,

    CONSTRAINT fk_placements_company
        FOREIGN KEY (company_id)
        REFERENCES companies(company_id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,

    CONSTRAINT fk_placements_job
        FOREIGN KEY (job_id)
        REFERENCES jobs(job_id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,

    CONSTRAINT fk_placements_offer
        FOREIGN KEY (offer_id)
        REFERENCES offers(offer_id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,

    INDEX idx_placements_candidate (candidate_id),
    INDEX idx_placements_company (company_id),
    INDEX idx_placements_joining_status (joining_status)
) ENGINE=InnoDB;


-- =====================================================
-- 15. ACTIVITY LOGS
-- =====================================================

CREATE TABLE IF NOT EXISTS activity_logs (
    log_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NULL,
    module_name VARCHAR(60) NOT NULL,
    action_name VARCHAR(80) NOT NULL,
    record_id VARCHAR(60) NULL,
    description VARCHAR(500) NULL,
    logged_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_activity_logs_user
        FOREIGN KEY (user_id)
        REFERENCES users(user_id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,

    INDEX idx_activity_user (user_id),
    INDEX idx_activity_module (module_name),
    INDEX idx_activity_logged_at (logged_at)
) ENGINE=InnoDB;


-- =====================================================
-- DATABASE SCHEMA CREATION COMPLETED
-- =====================================================

SHOW TABLES;
