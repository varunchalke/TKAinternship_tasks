
package dao;

import model.Candidate;
import util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class CandidateDAO {

    // 1. Add Candidate
    public boolean addCandidate(Candidate candidate) throws SQLException {

        String sql = "INSERT INTO candidates (" +
                "candidate_code, full_name, email, mobile, date_of_birth, " +
                "gender, qualification, college, university, passing_year, " +
                "percentage, cgpa, backlog_count, primary_technology, " +
                "current_location, preferred_location, profile_status, " +
                "placement_status) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, candidate.getCandidateCode());
            ps.setString(2, candidate.getFullName());
            ps.setString(3, candidate.getEmail());
            ps.setString(4, candidate.getMobile());

            if (candidate.getDateOfBirth() != null) {
                ps.setDate(5, java.sql.Date.valueOf(candidate.getDateOfBirth()));
            } else {
                ps.setNull(5, java.sql.Types.DATE);
            }

            ps.setString(6, candidate.getGender());
            ps.setString(7, candidate.getQualification());
            ps.setString(8, candidate.getCollege());
            ps.setString(9, candidate.getUniversity());
            ps.setInt(10, candidate.getPassingYear());
            ps.setBigDecimal(11, candidate.getPercentage());
            ps.setBigDecimal(12, candidate.getCgpa());
            ps.setInt(13, candidate.getBacklogCount());
            ps.setString(14, candidate.getPrimaryTechnology());
            ps.setString(15, candidate.getCurrentLocation());
            ps.setString(16, candidate.getPreferredLocation());
            ps.setString(17, "ACTIVE");
            ps.setString(18, "NOT_PLACED");

            return ps.executeUpdate() > 0;
        }
    }

    // 2. Update Candidate
    public boolean updateCandidate(Candidate candidate) throws SQLException {

        String sql = "UPDATE candidates SET " +
                "full_name=?, email=?, mobile=?, date_of_birth=?, gender=?, " +
                "qualification=?, college=?, university=?, passing_year=?, " +
                "percentage=?, cgpa=?, backlog_count=?, primary_technology=?, " +
                "current_location=?, preferred_location=?, updated_at=CURRENT_TIMESTAMP " +
                "WHERE candidate_id=?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, candidate.getFullName());
            ps.setString(2, candidate.getEmail());
            ps.setString(3, candidate.getMobile());

            if (candidate.getDateOfBirth() != null) {
                ps.setDate(4, java.sql.Date.valueOf(candidate.getDateOfBirth()));
            } else {
                ps.setNull(4, java.sql.Types.DATE);
            }

            ps.setString(5, candidate.getGender());
            ps.setString(6, candidate.getQualification());
            ps.setString(7, candidate.getCollege());
            ps.setString(8, candidate.getUniversity());
            ps.setInt(9, candidate.getPassingYear());
            ps.setBigDecimal(10, candidate.getPercentage());
            ps.setBigDecimal(11, candidate.getCgpa());
            ps.setInt(12, candidate.getBacklogCount());
            ps.setString(13, candidate.getPrimaryTechnology());
            ps.setString(14, candidate.getCurrentLocation());
            ps.setString(15, candidate.getPreferredLocation());
            ps.setInt(16, candidate.getCandidateId());

            return ps.executeUpdate() > 0;
        }
    }

    // 3. Search Candidate by ID
    public Candidate getCandidateById(int candidateId) throws SQLException {

        String sql = "SELECT * FROM candidates WHERE candidate_id=?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, candidateId);

            try (ResultSet rs = ps.executeQuery()) {

                if (rs.next()) {
                    return mapCandidate(rs);
                }
            }
        }

        return null;
    }

    // 4. View All Candidates
    public List<Candidate> getAllCandidates() throws SQLException {

        List<Candidate> candidates = new ArrayList<>();

        String sql = "SELECT * FROM candidates ORDER BY candidate_id";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                candidates.add(mapCandidate(rs));
            }
        }

        return candidates;
    }

    // 5. Deactivate Candidate
    public boolean deactivateCandidate(int candidateId) throws SQLException {

        String sql = "UPDATE candidates SET " +
                "profile_status='INACTIVE', updated_at=CURRENT_TIMESTAMP " +
                "WHERE candidate_id=?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, candidateId);

            return ps.executeUpdate() > 0;
        }
    }

    // Convert ResultSet into Candidate object
    private Candidate mapCandidate(ResultSet rs) throws SQLException {

        Candidate candidate = new Candidate();

        candidate.setCandidateId(rs.getInt("candidate_id"));
        candidate.setCandidateCode(rs.getString("candidate_code"));
        candidate.setFullName(rs.getString("full_name"));
        candidate.setEmail(rs.getString("email"));
        candidate.setMobile(rs.getString("mobile"));

        java.sql.Date dob = rs.getDate("date_of_birth");

        if (dob != null) {
            candidate.setDateOfBirth(dob.toLocalDate());
        }

        candidate.setGender(rs.getString("gender"));
        candidate.setQualification(rs.getString("qualification"));
        candidate.setCollege(rs.getString("college"));
        candidate.setUniversity(rs.getString("university"));
        candidate.setPassingYear(rs.getInt("passing_year"));
        candidate.setPercentage(rs.getBigDecimal("percentage"));
        candidate.setCgpa(rs.getBigDecimal("cgpa"));
        candidate.setBacklogCount(rs.getInt("backlog_count"));
        candidate.setPrimaryTechnology(rs.getString("primary_technology"));
        candidate.setCurrentLocation(rs.getString("current_location"));
        candidate.setPreferredLocation(rs.getString("preferred_location"));
        candidate.setProfileStatus(rs.getString("profile_status"));
        candidate.setPlacementStatus(rs.getString("placement_status"));
        candidate.setCreatedAt(rs.getTimestamp("created_at"));
        candidate.setUpdatedAt(rs.getTimestamp("updated_at"));

        return candidate;
    }
}
