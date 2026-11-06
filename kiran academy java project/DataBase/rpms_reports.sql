-- =====================================================
-- RPMS REPORT QUERIES
-- Database: rpms_db
-- Run after schema and sample data scripts.
-- =====================================================
USE rpms_db;

-- 1. Candidates grouped by primary technology
SELECT primary_technology, COUNT(*) AS total_candidates
FROM candidates
GROUP BY primary_technology
ORDER BY total_candidates DESC;

-- 2. Open jobs grouped by company
SELECT c.company_name, COUNT(j.job_id) AS open_jobs
FROM companies c
LEFT JOIN jobs j ON j.company_id = c.company_id AND j.status = 'OPEN'
GROUP BY c.company_id, c.company_name
ORDER BY open_jobs DESC, c.company_name;

-- 3. Applications grouped by current status
SELECT application_status, COUNT(*) AS total_applications
FROM applications
GROUP BY application_status
ORDER BY total_applications DESC;

-- 4. Recruitment funnel (rejected applications are not counted as progressing)
SELECT COUNT(*) AS total_applications,
       COALESCE(SUM(application_status IN ('SHORTLISTED','INTERVIEW_SCHEDULED','INTERVIEWED','SELECTED','OFFERED','JOINED')),0) AS shortlisted_or_later,
       COALESCE(SUM(application_status IN ('INTERVIEW_SCHEDULED','INTERVIEWED','SELECTED','OFFERED','JOINED')),0) AS interview_stage_or_later,
       COALESCE(SUM(application_status IN ('SELECTED','OFFERED','JOINED')),0) AS selected_or_later,
       COALESCE(SUM(application_status IN ('OFFERED','JOINED')),0) AS offered_or_later,
       COALESCE(SUM(application_status = 'JOINED'),0) AS joined
FROM applications;

-- 5. Company-wise joined placements
SELECT c.company_name, COUNT(p.placement_id) AS total_placements
FROM companies c
LEFT JOIN placements p ON p.company_id = c.company_id AND p.joining_status = 'JOINED'
GROUP BY c.company_id, c.company_name
ORDER BY total_placements DESC, c.company_name;

-- 6. Technology-wise joined placements
SELECT ca.primary_technology, COUNT(p.placement_id) AS total_placements
FROM placements p
JOIN candidates ca ON ca.candidate_id = p.candidate_id
WHERE p.joining_status = 'JOINED'
GROUP BY ca.primary_technology
ORDER BY total_placements DESC;

-- 7. Recruiter workload and joined candidates
SELECT u.full_name AS recruiter_name,
       COUNT(a.application_id) AS assigned_applications,
       COALESCE(SUM(a.application_status = 'JOINED'),0) AS joined_candidates
FROM users u
JOIN roles r ON r.role_id = u.role_id AND r.role_code = 'RECRUITER'
LEFT JOIN applications a ON a.assigned_recruiter_id = u.user_id
GROUP BY u.user_id, u.full_name
ORDER BY joined_candidates DESC, assigned_applications DESC;

-- 8. Pending/scheduled interviews (actual interview_rounds column names)
SELECT ir.interview_id, a.application_code, ca.full_name AS candidate_name,
       j.job_title, ir.round_number, ir.scheduled_date, ir.scheduled_time,
       ir.mode, ir.interviewer_name
FROM interview_rounds ir
JOIN applications a ON a.application_id = ir.application_id
JOIN candidates ca ON ca.candidate_id = a.candidate_id
JOIN jobs j ON j.job_id = a.job_id
WHERE ir.status = 'SCHEDULED'
ORDER BY ir.scheduled_date, ir.scheduled_time;

-- 9. Offer-to-joining conversion
SELECT COUNT(*) AS total_offers,
       COALESCE(SUM(o.offer_status = 'ACCEPTED'),0) AS accepted_offers,
       (SELECT COUNT(*) FROM placements p WHERE p.joining_status = 'JOINED') AS joined_placements
FROM offers o;

-- 10. Open-job age
SELECT job_code, job_title, DATEDIFF(CURDATE(), posted_date) AS days_since_posted, status
FROM jobs
WHERE status = 'OPEN'
ORDER BY days_since_posted DESC, job_code;
