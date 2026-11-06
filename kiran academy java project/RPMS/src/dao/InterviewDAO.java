package dao;

import model.Interview;
import util.DBConnection;
import java.sql.*;
import java.util.*;

public class InterviewDAO {

    public void addInterview(Interview i) throws SQLException {
        String sql = "INSERT INTO interview_rounds "
                + "(application_id, round_number, round_type, scheduled_date, "
                + "scheduled_time, mode, interviewer_name, meeting_or_location, status) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, i.getApplicationId());
            ps.setInt(2, i.getRoundNumber());
            ps.setString(3, i.getRoundType());
            ps.setDate(4, i.getScheduledDate());
            ps.setTime(5, i.getScheduledTime());
            ps.setString(6, i.getMode());
            ps.setString(7, i.getInterviewerName());
            ps.setString(8, i.getMeetingOrLocation());
            ps.setString(9, i.getStatus());

            ps.executeUpdate();
        }
    }

    public List<Interview> getInterviewsByApplication(int applicationId)
            throws SQLException {

        List<Interview> list = new ArrayList<>();
        String sql = "SELECT * FROM interview_rounds WHERE application_id = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, applicationId);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Interview i = new Interview();

                    i.setInterviewId(rs.getInt("interview_id"));
                    i.setApplicationId(rs.getInt("application_id"));
                    i.setRoundNumber(rs.getInt("round_number"));
                    i.setRoundType(rs.getString("round_type"));
                    i.setScheduledDate(rs.getDate("scheduled_date"));
                    i.setScheduledTime(rs.getTime("scheduled_time"));
                    i.setMode(rs.getString("mode"));
                    i.setInterviewerName(rs.getString("interviewer_name"));
                    i.setMeetingOrLocation(rs.getString("meeting_or_location"));
                    i.setStatus(rs.getString("status"));
                    i.setCreatedAt(rs.getTimestamp("created_at"));

                    list.add(i);
                }
            }
        }

        return list;
    }

    public void updateInterviewStatus(int interviewId, String status)
            throws SQLException {

        String sql = "UPDATE interview_rounds SET status = ? WHERE interview_id = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, status);
            ps.setInt(2, interviewId);
            ps.executeUpdate();
        }
    }
}