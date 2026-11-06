
package dao;

import model.Offer;
import util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class OfferDAO {

    // Add a new offer
    public void addOffer(Offer offer) throws SQLException {

        String sql = "INSERT INTO offers "
                + "(offer_code, application_id, designation, "
                + "offered_package_lpa, offer_date, "
                + "expected_joining_date, offer_status, remarks) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, offer.getOfferCode());
            ps.setInt(2, offer.getApplicationId());
            ps.setString(3, offer.getDesignation());
            ps.setDouble(4, offer.getOfferedPackageLpa());
            ps.setDate(5, offer.getOfferDate());

            if (offer.getExpectedJoiningDate() == null) {
                ps.setNull(6, Types.DATE);
            } else {
                ps.setDate(6, offer.getExpectedJoiningDate());
            }

            ps.setString(7, offer.getOfferStatus());
            ps.setString(8, offer.getRemarks());

            ps.executeUpdate();
        }
    }

    // Find offer by ID
    public Offer getOfferById(int offerId) throws SQLException {

        String sql = "SELECT * FROM offers WHERE offer_id = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, offerId);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapOffer(rs);
                }
            }
        }

        return null;
    }

    // Find offer by application ID
    public Offer getOfferByApplicationId(int applicationId)
            throws SQLException {

        String sql = "SELECT * FROM offers WHERE application_id = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, applicationId);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapOffer(rs);
                }
            }
        }

        return null;
    }

    // View all offers
    public List<Offer> getAllOffers() throws SQLException {

        List<Offer> offers = new ArrayList<>();

        String sql = "SELECT * FROM offers ORDER BY offer_id";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                offers.add(mapOffer(rs));
            }
        }

        return offers;
    }

    // Update offer status
    public void updateOfferStatus(int offerId, String status)
            throws SQLException {

        String sql = "UPDATE offers SET offer_status = ? "
                + "WHERE offer_id = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, status);
            ps.setInt(2, offerId);

            ps.executeUpdate();
        }
    }

    // Convert database record into Offer object
    private Offer mapOffer(ResultSet rs) throws SQLException {

        Offer offer = new Offer();

        offer.setOfferId(rs.getInt("offer_id"));
        offer.setOfferCode(rs.getString("offer_code"));
        offer.setApplicationId(rs.getInt("application_id"));
        offer.setDesignation(rs.getString("designation"));
        offer.setOfferedPackageLpa(
                rs.getDouble("offered_package_lpa"));

        offer.setOfferDate(rs.getDate("offer_date"));
        offer.setExpectedJoiningDate(
                rs.getDate("expected_joining_date"));

        offer.setOfferStatus(rs.getString("offer_status"));
        offer.setRemarks(rs.getString("remarks"));
        offer.setCreatedAt(rs.getTimestamp("created_at"));

        return offer;
    }
}
