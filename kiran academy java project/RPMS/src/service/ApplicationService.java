
package service;

import dao.ApplicationDAO;
import dao.CandidateDAO;
import dao.JobDAO;
import exception.CandidateNotEligibleException;
import exception.CandidateNotFoundException;
import exception.DuplicateApplicationException;
import exception.JobNotFoundException;
import model.Application;
import model.Candidate;
import model.Job;
import util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Arrays;
import java.util.List;

public class ApplicationService {

    private final ApplicationDAO applicationDAO = new ApplicationDAO();
    private final CandidateDAO candidateDAO = new CandidateDAO();
    private final JobDAO jobDAO = new JobDAO();

    private static final List<String> VALID_STATUSES = Arrays.asList(
            "APPLIED",
            "ELIGIBILITY_VERIFIED",
            "SHORTLISTED",
            "INTERVIEW_SCHEDULED",
            "INTERVIEWED",
            "SELECTED",
            "REJECTED",
            "OFFERED",
            "JOINED",
            "WITHDRAWN"
    );

    // Check whether a candidate is eligible for a job
    public String checkEligibility(int candidateId, int jobId)
            throws SQLException, CandidateNotFoundException,
            JobNotFoundException {

        Candidate candidate = candidateDAO.getCandidateById(candidateId);
        Job job = jobDAO.getJobById(jobId);

        if (candidate == null) {
            throw new CandidateNotFoundException(
                    "Candidate not found: " + candidateId);
        }

        if (job == null) {
            throw new JobNotFoundException(
                    "Job not found: " + jobId);
        }

        if (!"ACTIVE".equalsIgnoreCase(candidate.getProfileStatus())) {
            return "Candidate profile is not active.";
        }

        if (!"OPEN".equalsIgnoreCase(job.getStatus())) {
            return "This job is not open.";
        }

        if (job.getApplicationDeadline() != null
                && job.getApplicationDeadline().toLocalDate()
                .isBefore(java.time.LocalDate.now())) {
            return "Application deadline has passed.";
        }

        if (job.getMinPercentage() != null) {
            if (candidate.getPercentage() == null
                    || candidate.getPercentage().compareTo(
                    job.getMinPercentage()) < 0) {
                return "Candidate does not meet minimum percentage.";
            }
        }

        if (job.getMinPassingYear() > 0
                && candidate.getPassingYear() < job.getMinPassingYear()) {
            return "Candidate passing year is below the required year.";
        }

        if (job.getMaxPassingYear() > 0
                && candidate.getPassingYear() > job.getMaxPassingYear()) {
            return "Candidate passing year is above the allowed year.";
        }

        if (candidate.getBacklogCount() > job.getMaxBacklogs()) {
            return "Candidate has more backlogs than allowed.";
        }

        return "ELIGIBLE";
    }

    // Apply for a job after checking eligibility
    public void applyForJob(int candidateId, int jobId)
            throws SQLException, CandidateNotFoundException,
            JobNotFoundException, CandidateNotEligibleException,
            DuplicateApplicationException {

        if (applicationDAO.isDuplicateApplication(candidateId, jobId)) {
            throw new DuplicateApplicationException(
                    "Candidate has already applied for this job.");
        }

        String eligibility = checkEligibility(candidateId, jobId);

        if (!"ELIGIBLE".equals(eligibility)) {
            throw new CandidateNotEligibleException(eligibility);
        }

        Application application = new Application();

        application.setApplicationCode(
                "APP-" + System.currentTimeMillis());

        application.setCandidateId(candidateId);
        application.setJobId(jobId);
        application.setEligibilityStatus("ELIGIBLE");
        application.setEligibilityReason("Candidate meets job requirements.");
        application.setApplicationStatus("APPLIED");
        application.setSource("DIRECT");

        applicationDAO.addApplication(application);
    }

    // Update application status and save its history
    public void updateApplicationStatus(
            int applicationId,
            String newStatus,
            String remarks,
            Integer changedBy) throws SQLException {

        if (newStatus == null
                || !VALID_STATUSES.contains(newStatus.toUpperCase())) {
            throw new IllegalArgumentException(
                    "Invalid application status.");
        }

        newStatus = newStatus.toUpperCase();

        String selectSql =
                "SELECT application_status FROM applications "
                + "WHERE application_id = ?";

        String updateSql =
                "UPDATE applications SET application_status = ? "
                + "WHERE application_id = ?";

        String historySql =
                "INSERT INTO application_history "
                + "(application_id, old_status, new_status, remarks, changed_by) "
                + "VALUES (?, ?, ?, ?, ?)";

        try (Connection con = DBConnection.getConnection()) {

            con.setAutoCommit(false);

            try {
                String oldStatus;

                try (PreparedStatement ps = con.prepareStatement(selectSql)) {
                    ps.setInt(1, applicationId);

                    try (ResultSet rs = ps.executeQuery()) {
                        if (!rs.next()) {
                            throw new SQLException(
                                    "Application not found: " + applicationId);
                        }

                        oldStatus = rs.getString("application_status");
                    }
                }

                try (PreparedStatement ps = con.prepareStatement(updateSql)) {
                    ps.setString(1, newStatus);
                    ps.setInt(2, applicationId);
                    ps.executeUpdate();
                }

                try (PreparedStatement ps = con.prepareStatement(historySql)) {
                    ps.setInt(1, applicationId);
                    ps.setString(2, oldStatus);
                    ps.setString(3, newStatus);
                    ps.setString(4, remarks);

                    if (changedBy == null) {
                        ps.setNull(5, java.sql.Types.INTEGER);
                    } else {
                        ps.setInt(5, changedBy);
                    }

                    ps.executeUpdate();
                }

                con.commit();

            } catch (SQLException | RuntimeException e) {
                con.rollback();
                throw e;
            } finally {
                con.setAutoCommit(true);
            }
        }
    }

    // View all applications
    public List<Application> getAllApplications()
            throws SQLException {
        return applicationDAO.getAllApplications();
    }

    // Find application by ID
    public Application getApplicationById(int applicationId)
            throws SQLException {
        return applicationDAO.getApplicationById(applicationId);
    }
}

