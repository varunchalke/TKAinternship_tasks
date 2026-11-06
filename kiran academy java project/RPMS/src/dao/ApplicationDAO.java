package dao;

import model.Application;
import util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ApplicationDAO {

    // Add application
    public void addApplication(Application application)
            throws SQLException {

        String sql = "INSERT INTO applications "
                + "(application_code, candidate_id, job_id, "
                + "eligibility_status, eligibility_reason, "
                + "application_status, source, assigned_recruiter_id) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, application.getApplicationCode());
            ps.setInt(2, application.getCandidateId());
            ps.setInt(3, application.getJobId());
            ps.setString(4, application.getEligibilityStatus());
            ps.setString(5, application.getEligibilityReason());

            ps.setString(6, application.getApplicationStatus());
            ps.setString(7, application.getSource());

            if (application.getAssignedRecruiterId() == null) {
                ps.setNull(8, Types.INTEGER);
            } else {
                ps.setInt(8, application.getAssignedRecruiterId());
            }

            ps.executeUpdate();
        }
    }

    // Search application by ID
    public Application getApplicationById(int applicationId)
            throws SQLException {

        String sql = "SELECT * FROM applications WHERE application_id = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, applicationId);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapApplication(rs);
                }
            }
        }

        return null;
    }

    // View all applications
    public List<Application> getAllApplications()
            throws SQLException {

        List<Application> applications = new ArrayList<>();

        String sql = "SELECT * FROM applications ORDER BY application_id";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                applications.add(mapApplication(rs));
            }
        }

        return applications;
    }

    // Check duplicate application
    public boolean isDuplicateApplication(int candidateId, int jobId)
            throws SQLException {

        String sql = "SELECT application_id FROM applications "
                + "WHERE candidate_id = ? AND job_id = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, candidateId);
            ps.setInt(2, jobId);

            try (ResultSet rs = ps.executeQuery()) {
                return rs.next();
            }
        }
    }

    // Update application status
    public void updateApplicationStatus(
            int applicationId, String status) throws SQLException {

        String sql = "UPDATE applications "
                + "SET application_status = ? "
                + "WHERE application_id = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, status);
            ps.setInt(2, applicationId);

            ps.executeUpdate();
        }
    }

    // Convert database record into Application object
    private Application mapApplication(ResultSet rs)
            throws SQLException {

        Application application = new Application();

        application.setApplicationId(rs.getInt("application_id"));
        application.setApplicationCode(rs.getString("application_code"));
        application.setCandidateId(rs.getInt("candidate_id"));
        application.setJobId(rs.getInt("job_id"));

        application.setEligibilityStatus(
                rs.getString("eligibility_status"));

        application.setEligibilityReason(
                rs.getString("eligibility_reason"));

        application.setApplicationStatus(
                rs.getString("application_status"));

        application.setSource(rs.getString("source"));

        int recruiterId = rs.getInt("assigned_recruiter_id");

        if (rs.wasNull()) {
            application.setAssignedRecruiterId(null);
        } else {
            application.setAssignedRecruiterId(recruiterId);
        }

        application.setAppliedAt(rs.getTimestamp("applied_at"));

        return application;
    }
}