
-- =====================================================
-- RPMS - RECRUITMENT WORKFLOW SAMPLE DATA
-- Applications are assigned only to OPEN jobs (jobs 001-010).
-- Interview records 006-020 are completed; 021-025 are scheduled.
-- Database: rpms_db
-- =====================================================

USE rpms_db;


-- =====================================================
-- 1. APPLICATIONS (40 RECORDS)
-- =====================================================

INSERT IGNORE INTO applications
(
    application_code,
    candidate_id,
    job_id,
    eligibility_status,
    eligibility_reason,
    application_status,
    source,
    assigned_recruiter_id
)

SELECT
    CONCAT('APP-2026-', LPAD(v.n, 4, '0')),
    c.candidate_id,
    j.job_id,
    'ELIGIBLE',
    'Sample application for demonstration',
    CASE
        WHEN v.n BETWEEN 1 AND 5 THEN 'JOINED'
        WHEN v.n BETWEEN 6 AND 8 THEN 'OFFERED'
        WHEN v.n BETWEEN 9 AND 13 THEN 'SELECTED'
        WHEN v.n BETWEEN 14 AND 20 THEN 'INTERVIEWED'
        WHEN v.n BETWEEN 21 AND 25 THEN 'INTERVIEW_SCHEDULED'
        WHEN v.n BETWEEN 26 AND 30 THEN 'SHORTLISTED'
        ELSE 'APPLIED'
    END,
    'PORTAL',
    u.user_id

FROM
(
    SELECT 1 AS n UNION ALL SELECT 2 UNION ALL SELECT 3
    UNION ALL SELECT 4 UNION ALL SELECT 5
    UNION ALL SELECT 6 UNION ALL SELECT 7
    UNION ALL SELECT 8 UNION ALL SELECT 9
    UNION ALL SELECT 10 UNION ALL SELECT 11
    UNION ALL SELECT 12 UNION ALL SELECT 13
    UNION ALL SELECT 14 UNION ALL SELECT 15
    UNION ALL SELECT 16 UNION ALL SELECT 17
    UNION ALL SELECT 18 UNION ALL SELECT 19
    UNION ALL SELECT 20 UNION ALL SELECT 21
    UNION ALL SELECT 22 UNION ALL SELECT 23
    UNION ALL SELECT 24 UNION ALL SELECT 25
    UNION ALL SELECT 26 UNION ALL SELECT 27
    UNION ALL SELECT 28 UNION ALL SELECT 29
    UNION ALL SELECT 30 UNION ALL SELECT 31
    UNION ALL SELECT 32 UNION ALL SELECT 33
    UNION ALL SELECT 34 UNION ALL SELECT 35
    UNION ALL SELECT 36 UNION ALL SELECT 37
    UNION ALL SELECT 38 UNION ALL SELECT 39
    UNION ALL SELECT 40
) v

JOIN candidates c
    ON c.candidate_code =
       CONCAT('CAN-2026-', LPAD(
           CASE WHEN v.n > 30 THEN v.n - 30 ELSE v.n END,
           4, '0'
       ))

JOIN jobs j
    ON j.job_code =
       CONCAT('JOB-2026-', LPAD(MOD(v.n - 1 + CASE WHEN v.n > 30 THEN 1 ELSE 0 END, 10) + 1, 3, '0'))

LEFT JOIN users u
    ON u.username = 'recruiter1';


-- =====================================================
-- 2. APPLICATION HISTORY
-- =====================================================

INSERT INTO application_history
(
    application_id,
    old_status,
    new_status,
    remarks,
    changed_by
)

SELECT
    a.application_id,
    NULL,
    a.application_status,
    'Initial application status created',
    u.user_id

FROM applications a

LEFT JOIN users u
    ON u.username = 'admin'

WHERE a.application_code LIKE 'APP-2026-%'

AND NOT EXISTS
(
    SELECT 1
    FROM application_history h
    WHERE h.application_id = a.application_id
      AND h.new_status = a.application_status
      AND h.remarks = 'Initial application status created'
);


-- =====================================================
-- 3. INTERVIEW ROUNDS (20 RECORDS)
-- =====================================================

INSERT IGNORE INTO interview_rounds
(
    application_id,
    round_number,
    round_type,
    scheduled_date,
    scheduled_time,
    mode,
    interviewer_name,
    meeting_or_location,
    status
)

SELECT
    a.application_id,
    1,
    CASE
        WHEN v.n <= 5 THEN 'APTITUDE'
        WHEN v.n <= 12 THEN 'TECHNICAL'
        WHEN v.n <= 17 THEN 'MANAGERIAL'
        ELSE 'HR'
    END,
    CASE WHEN v.n <= 20
         THEN DATE_SUB(CURDATE(), INTERVAL (21 - v.n) DAY)
         ELSE DATE_ADD(CURDATE(), INTERVAL (v.n - 20) DAY)
    END,
    '10:00:00',
    CASE
        WHEN MOD(v.n, 2) = 0 THEN 'ONLINE'
        ELSE 'OFFLINE'
    END,
    CONCAT('Interviewer ', v.n),
    CASE
        WHEN MOD(v.n, 2) = 0
        THEN 'Online meeting'
        ELSE 'Placement Office'
    END,
    CASE
        WHEN v.n <= 20 THEN 'COMPLETED'
        ELSE 'SCHEDULED'
    END

FROM
(
    SELECT 6 AS n UNION ALL SELECT 7
    UNION ALL SELECT 8 UNION ALL SELECT 9
    UNION ALL SELECT 10 UNION ALL SELECT 11
    UNION ALL SELECT 12 UNION ALL SELECT 13
    UNION ALL SELECT 14 UNION ALL SELECT 15
    UNION ALL SELECT 16 UNION ALL SELECT 17
    UNION ALL SELECT 18 UNION ALL SELECT 19
    UNION ALL SELECT 20 UNION ALL SELECT 21
    UNION ALL SELECT 22 UNION ALL SELECT 23
    UNION ALL SELECT 24 UNION ALL SELECT 25
) v

JOIN applications a
    ON a.application_code =
       CONCAT('APP-2026-', LPAD(v.n, 4, '0'));


-- =====================================================
-- 4. INTERVIEW FEEDBACK (15 RECORDS)
-- =====================================================

INSERT IGNORE INTO interview_feedback
(
    interview_id,
    technical_rating,
    communication_rating,
    problem_solving_rating,
    overall_rating,
    recommendation,
    remarks,
    submitted_by
)

SELECT
    i.interview_id,
    CASE WHEN MOD(v.n, 5) = 0 THEN 3.0 ELSE 4.0 END,
    4.0,
    CASE WHEN MOD(v.n, 3) = 0 THEN 3.5 ELSE 4.0 END,
    CASE WHEN MOD(v.n, 5) = 0 THEN 3.5 ELSE 4.0 END,
    CASE
        WHEN v.n <= 5 THEN 'SELECTED'
        WHEN v.n <= 10 THEN 'NEXT_ROUND'
        WHEN v.n <= 13 THEN 'ON_HOLD'
        ELSE 'REJECTED'
    END,
    'Sample interview feedback',
    u.user_id

FROM
(
    SELECT 1 AS n UNION ALL SELECT 2
    UNION ALL SELECT 3 UNION ALL SELECT 4
    UNION ALL SELECT 5 UNION ALL SELECT 6
    UNION ALL SELECT 7 UNION ALL SELECT 8
    UNION ALL SELECT 9 UNION ALL SELECT 10
    UNION ALL SELECT 11 UNION ALL SELECT 12
    UNION ALL SELECT 13 UNION ALL SELECT 14
    UNION ALL SELECT 15
) v

JOIN applications a
    ON a.application_code =
       CONCAT('APP-2026-', LPAD(v.n + 5, 4, '0'))

JOIN interview_rounds i
    ON i.application_id = a.application_id
   AND i.round_number = 1

LEFT JOIN users u
    ON u.username = 'placement1';


-- =====================================================
-- 5. OFFERS (8 RECORDS)
-- =====================================================

INSERT IGNORE INTO offers
(
    offer_code,
    application_id,
    designation,
    offered_package_lpa,
    offer_date,
    expected_joining_date,
    offer_status,
    remarks
)

SELECT
    CONCAT('OFFER-2026-', LPAD(v.n, 3, '0')),
    a.application_id,
    j.job_title,
    CASE
        WHEN v.n <= 5 THEN 4.50
        ELSE 5.00
    END,
    CURDATE(),
    CASE WHEN v.n <= 5 THEN CURDATE()
         ELSE DATE_ADD(CURDATE(), INTERVAL 30 DAY) END,
    CASE
        WHEN v.n <= 5 THEN 'ACCEPTED'
        ELSE 'OFFERED'
    END,
    'Sample placement offer'

FROM
(
    SELECT 1 AS n UNION ALL SELECT 2
    UNION ALL SELECT 3 UNION ALL SELECT 4
    UNION ALL SELECT 5 UNION ALL SELECT 6
    UNION ALL SELECT 7 UNION ALL SELECT 8
) v

JOIN applications a
    ON a.application_code =
       CONCAT('APP-2026-', LPAD(v.n, 4, '0'))

JOIN jobs j
    ON j.job_id = a.job_id;


-- =====================================================
-- 6. PLACEMENTS (5 RECORDS)
-- =====================================================

INSERT IGNORE INTO placements
(
    candidate_id,
    company_id,
    job_id,
    offer_id,
    designation,
    final_package_lpa,
    expected_joining_date,
    actual_joining_date,
    joining_status,
    placement_status
)

SELECT
    a.candidate_id,
    j.company_id,
    a.job_id,
    o.offer_id,
    o.designation,
    o.offered_package_lpa,
    o.expected_joining_date,
    CURDATE(),
    'JOINED',
    'ACTIVE'

FROM applications a

JOIN jobs j
    ON j.job_id = a.job_id

JOIN offers o
    ON o.application_id = a.application_id

WHERE a.application_code IN
(
    'APP-2026-0001',
    'APP-2026-0002',
    'APP-2026-0003',
    'APP-2026-0004',
    'APP-2026-0005'
);


-- =====================================================
-- 7. UPDATE CANDIDATE PLACEMENT STATUS
-- =====================================================

UPDATE candidates c

JOIN placements p
    ON p.candidate_id = c.candidate_id

SET c.placement_status = 'PLACED';


-- =====================================================
-- 8. VERIFICATION REPORT
-- =====================================================

SELECT 'Applications' AS table_name,
       COUNT(*) AS total_records
FROM applications

UNION ALL

SELECT 'Application History', COUNT(*)
FROM application_history

UNION ALL

SELECT 'Interview Rounds', COUNT(*)
FROM interview_rounds

UNION ALL

SELECT 'Interview Feedback', COUNT(*)
FROM interview_feedback

UNION ALL

SELECT 'Offers', COUNT(*)
FROM offers

UNION ALL

SELECT 'Placements', COUNT(*)
FROM placements;
