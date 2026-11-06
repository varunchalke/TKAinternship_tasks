
package dao;

import model.Job;
import util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class JobDAO {

    // Add a new job
    public void addJob(Job job) throws SQLException {

        String sql = "INSERT INTO jobs "
                + "(job_code, company_id, job_title, employment_type, "
                + "location, openings, min_package_lpa, max_package_lpa, "
                + "min_percentage, min_passing_year, max_passing_year, "
                + "max_backlogs, experience_min_years, qualification_rule, "
                + "posted_date, application_deadline, status, created_by) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, job.getJobCode());
            ps.setInt(2, job.getCompanyId());
            ps.setString(3, job.getJobTitle());
            ps.setString(4, job.getEmploymentType());
            ps.setString(5, job.getLocation());
            ps.setInt(6, job.getOpenings());

            ps.setBigDecimal(7, job.getMinPackageLpa());
            ps.setBigDecimal(8, job.getMaxPackageLpa());
            ps.setBigDecimal(9, job.getMinPercentage());

            ps.setInt(10, job.getMinPassingYear());
            ps.setInt(11, job.getMaxPassingYear());
            ps.setInt(12, job.getMaxBacklogs());

            if (job.getExperienceMinYears() == null) {
                ps.setBigDecimal(13, java.math.BigDecimal.ZERO);
            } else {
                ps.setBigDecimal(13, job.getExperienceMinYears());
            }

            ps.setString(14, job.getQualificationRule());
            ps.setDate(15, job.getPostedDate());
            ps.setDate(16, job.getApplicationDeadline());

            String status = job.getStatus();

            if (status == null || status.isBlank()) {
                status = "OPEN";
            }

            ps.setString(17, status);

            if (job.getCreatedBy() == null) {
                ps.setNull(18, java.sql.Types.INTEGER);
            } else {
                ps.setInt(18, job.getCreatedBy());
            }

            ps.executeUpdate();
        }
    }

    // Update job details
    public void updateJob(Job job) throws SQLException {

        String sql = "UPDATE jobs SET company_id = ?, job_title = ?, "
                + "employment_type = ?, location = ?, openings = ?, "
                + "min_package_lpa = ?, max_package_lpa = ?, "
                + "min_percentage = ?, min_passing_year = ?, "
                + "max_passing_year = ?, max_backlogs = ?, "
                + "experience_min_years = ?, qualification_rule = ?, "
                + "application_deadline = ?, status = ? "
                + "WHERE job_id = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, job.getCompanyId());
            ps.setString(2, job.getJobTitle());
            ps.setString(3, job.getEmploymentType());
            ps.setString(4, job.getLocation());
            ps.setInt(5, job.getOpenings());

            ps.setBigDecimal(6, job.getMinPackageLpa());
            ps.setBigDecimal(7, job.getMaxPackageLpa());
            ps.setBigDecimal(8, job.getMinPercentage());

            ps.setInt(9, job.getMinPassingYear());
            ps.setInt(10, job.getMaxPassingYear());
            ps.setInt(11, job.getMaxBacklogs());

            if (job.getExperienceMinYears() == null) {
                ps.setBigDecimal(12, java.math.BigDecimal.ZERO);
            } else {
                ps.setBigDecimal(12, job.getExperienceMinYears());
            }

            ps.setString(13, job.getQualificationRule());
            ps.setDate(14, job.getApplicationDeadline());
            ps.setString(15, job.getStatus());
            ps.setInt(16, job.getJobId());

            ps.executeUpdate();
        }
    }

    // Search job by ID
    public Job getJobById(int jobId) throws SQLException {

        String sql = "SELECT * FROM jobs WHERE job_id = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, jobId);

            try (ResultSet rs = ps.executeQuery()) {

                if (rs.next()) {
                    return mapJob(rs);
                }
            }
        }

        return null;
    }

    // View all jobs
    public List<Job> getAllJobs() throws SQLException {

        List<Job> jobs = new ArrayList<>();

        String sql = "SELECT * FROM jobs ORDER BY job_id";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                jobs.add(mapJob(rs));
            }
        }

        return jobs;
    }

    // View open jobs
    public List<Job> getOpenJobs() throws SQLException {

        List<Job> jobs = new ArrayList<>();

        String sql = "SELECT * FROM jobs "
                + "WHERE status = 'OPEN' "
                + "AND application_deadline >= CURDATE() "
                + "ORDER BY application_deadline";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                jobs.add(mapJob(rs));
            }
        }

        return jobs;
    }

    // Close a job
    public void closeJob(int jobId) throws SQLException {

        String sql = "UPDATE jobs SET status = 'CLOSED' "
                + "WHERE job_id = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, jobId);
            ps.executeUpdate();
        }
    }

    // Convert database record into Job object
    private Job mapJob(ResultSet rs) throws SQLException {

        Job job = new Job();

        job.setJobId(rs.getInt("job_id"));
        job.setJobCode(rs.getString("job_code"));
        job.setCompanyId(rs.getInt("company_id"));
        job.setJobTitle(rs.getString("job_title"));
        job.setEmploymentType(rs.getString("employment_type"));
        job.setLocation(rs.getString("location"));
        job.setOpenings(rs.getInt("openings"));

        job.setMinPackageLpa(rs.getBigDecimal("min_package_lpa"));
        job.setMaxPackageLpa(rs.getBigDecimal("max_package_lpa"));
        job.setMinPercentage(rs.getBigDecimal("min_percentage"));

        job.setMinPassingYear(rs.getInt("min_passing_year"));
        job.setMaxPassingYear(rs.getInt("max_passing_year"));
        job.setMaxBacklogs(rs.getInt("max_backlogs"));

        job.setExperienceMinYears(
                rs.getBigDecimal("experience_min_years")
        );

        job.setQualificationRule(rs.getString("qualification_rule"));
        job.setPostedDate(rs.getDate("posted_date"));
        job.setApplicationDeadline(rs.getDate("application_deadline"));
        job.setStatus(rs.getString("status"));

        int createdBy = rs.getInt("created_by");

        if (rs.wasNull()) {
            job.setCreatedBy(null);
        } else {
            job.setCreatedBy(createdBy);
        }

        job.setCreatedAt(rs.getTimestamp("created_at"));

        return job;
    }
}
