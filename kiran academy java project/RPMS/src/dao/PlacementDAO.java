
package dao;

import util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.HashMap;

public class PlacementDAO {

    // Create a placement from an accepted offer
    public void createPlacement(int offerId) throws SQLException {

        String sql =
                "INSERT INTO placements "
                + "(candidate_id, company_id, job_id, offer_id, "
                + "designation, final_package_lpa, expected_joining_date, "
                + "joining_status, placement_status) "
                + "SELECT a.candidate_id, j.company_id, j.job_id, "
                + "o.offer_id, o.designation, o.offered_package_lpa, "
                + "o.expected_joining_date, 'PENDING', 'ACTIVE' "
                + "FROM offers o "
                + "JOIN applications a ON o.application_id = a.application_id "
                + "JOIN jobs j ON a.job_id = j.job_id "
                + "WHERE o.offer_id = ? AND o.offer_status = 'ACCEPTED'";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, offerId);

            int rows = ps.executeUpdate();

            if (rows == 0) {
                throw new SQLException(
                        "Placement not created. Check whether the offer exists "
                        + "and has ACCEPTED status.");
            }
        }
    }

    // Mark candidate as joined
    public void markCandidateJoined(int placementId) throws SQLException {

        String updatePlacement =
                "UPDATE placements SET joining_status = 'JOINED', "
                + "actual_joining_date = CURRENT_DATE "
                + "WHERE placement_id = ?";

        String updateCandidate =
                "UPDATE candidates c "
                + "JOIN placements p ON c.candidate_id = p.candidate_id "
                + "SET c.placement_status = 'PLACED' "
                + "WHERE p.placement_id = ?";

        try (Connection con = DBConnection.getConnection()) {

            con.setAutoCommit(false);

            try {
                int rows;

                try (PreparedStatement ps =
                             con.prepareStatement(updatePlacement)) {
                    ps.setInt(1, placementId);
                    rows = ps.executeUpdate();
                }

                if (rows == 0) {
                    throw new SQLException(
                            "Placement not found: " + placementId);
                }

                try (PreparedStatement ps =
                             con.prepareStatement(updateCandidate)) {
                    ps.setInt(1, placementId);
                    ps.executeUpdate();
                }

                con.commit();

            } catch (SQLException e) {
                con.rollback();
                throw e;
            } finally {
                con.setAutoCommit(true);
            }
        }
    }

    // Update joining status
    public void updateJoiningStatus(
            int placementId, String status) throws SQLException {

        if (status == null ||
                !(status.equals("PENDING")
                || status.equals("JOINED")
                || status.equals("NOT_JOINED"))) {
            throw new IllegalArgumentException(
                    "Invalid joining status.");
        }

        if ("JOINED".equals(status)) {
            markCandidateJoined(placementId);
            return;
        }

        String sql =
                "UPDATE placements SET joining_status = ?, "
                + "actual_joining_date = NULL "
                + "WHERE placement_id = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, status);
            ps.setInt(2, placementId);

            int rows = ps.executeUpdate();

            if (rows == 0) {
                throw new SQLException(
                        "Placement not found: " + placementId);
            }
        }
    }

    // View all placement records
    public List<Map<String, Object>> getAllPlacements()
            throws SQLException {

        List<Map<String, Object>> placements = new ArrayList<>();

        String sql =
                "SELECT p.placement_id, p.candidate_id, c.full_name, "
                + "p.company_id, co.company_name, p.job_id, "
                + "j.job_title, p.offer_id, p.designation, "
                + "p.final_package_lpa, p.expected_joining_date, "
                + "p.actual_joining_date, p.joining_status, "
                + "p.placement_status "
                + "FROM placements p "
                + "JOIN candidates c ON p.candidate_id = c.candidate_id "
                + "JOIN companies co ON p.company_id = co.company_id "
                + "JOIN jobs j ON p.job_id = j.job_id "
                + "ORDER BY p.placement_id";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {

                Map<String, Object> row = new HashMap<>();

                row.put("placementId", rs.getInt("placement_id"));
                row.put("candidateId", rs.getInt("candidate_id"));
                row.put("candidateName", rs.getString("full_name"));
                row.put("companyId", rs.getInt("company_id"));
                row.put("companyName", rs.getString("company_name"));
                row.put("jobId", rs.getInt("job_id"));
                row.put("jobTitle", rs.getString("job_title"));
                row.put("offerId", rs.getInt("offer_id"));
                row.put("designation", rs.getString("designation"));
                row.put("packageLpa", rs.getBigDecimal("final_package_lpa"));
                row.put("expectedJoiningDate",
                        rs.getDate("expected_joining_date"));
                row.put("actualJoiningDate",
                        rs.getDate("actual_joining_date"));
                row.put("joiningStatus",
                        rs.getString("joining_status"));
                row.put("placementStatus",
                        rs.getString("placement_status"));

                placements.add(row);
            }
        }

        return placements;
    }
}
