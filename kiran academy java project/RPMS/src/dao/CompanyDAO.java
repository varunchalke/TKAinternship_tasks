
package dao;

import model.Company;
import util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class CompanyDAO {

    // Add a new company
   public void addCompany(Company company) throws SQLException {

        String sql = "INSERT INTO companies "
                + "(company_code, company_name, industry, website, "
                + "location, company_type, hr_name, hr_email, hr_mobile, status) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, company.getCompanyCode());
            ps.setString(2, company.getCompanyName());
            ps.setString(3, company.getIndustry());
            ps.setString(4, company.getWebsite());
            ps.setString(5, company.getLocation());
            ps.setString(6, company.getCompanyType());
            ps.setString(7, company.getHrName());
            ps.setString(8, company.getHrEmail());
            ps.setString(9, company.getHrMobile());

            String status = company.getStatus();

            if (status == null || status.trim().isEmpty()) {
                status = "ACTIVE";
            }

            ps.setString(10, status);

            ps.executeUpdate();
        }
    }

    // Update company details
    public void updateCompany(Company company) throws SQLException {

        String sql = "UPDATE companies SET company_name = ?, "
                + "industry = ?, website = ?, location = ?, "
                + "company_type = ?, hr_name = ?, hr_email = ?, "
                + "hr_mobile = ?, status = ? WHERE company_id = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, company.getCompanyName());
            ps.setString(2, company.getIndustry());
            ps.setString(3, company.getWebsite());
            ps.setString(4, company.getLocation());
            ps.setString(5, company.getCompanyType());
            ps.setString(6, company.getHrName());
            ps.setString(7, company.getHrEmail());
            ps.setString(8, company.getHrMobile());
            ps.setString(9, company.getStatus());
            ps.setInt(10, company.getCompanyId());

            ps.executeUpdate();
        }
    }

    // Search company by ID
    public Company getCompanyById(int companyId) throws SQLException {

        String sql = "SELECT * FROM companies WHERE company_id = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, companyId);

            try (ResultSet rs = ps.executeQuery()) {

                if (rs.next()) {
                    return mapCompany(rs);
                }
            }
        }

        return null;
    }

    // View all companies
    public List<Company> getAllCompanies() throws SQLException {

        List<Company> companies = new ArrayList<>();

        String sql = "SELECT * FROM companies ORDER BY company_id";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                companies.add(mapCompany(rs));
            }
        }

        return companies;
    }

    // Deactivate company
    public void deactivateCompany(int companyId) throws SQLException {

        String sql = "UPDATE companies SET status = 'INACTIVE' "
                + "WHERE company_id = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, companyId);
            ps.executeUpdate();
        }
    }

    // Convert database record into Company object
    private Company mapCompany(ResultSet rs) throws SQLException {

        Company company = new Company();

        company.setCompanyId(rs.getInt("company_id"));
        company.setCompanyCode(rs.getString("company_code"));
        company.setCompanyName(rs.getString("company_name"));
        company.setIndustry(rs.getString("industry"));
        company.setWebsite(rs.getString("website"));
        company.setLocation(rs.getString("location"));
        company.setCompanyType(rs.getString("company_type"));
        company.setHrName(rs.getString("hr_name"));
        company.setHrEmail(rs.getString("hr_email"));
        company.setHrMobile(rs.getString("hr_mobile"));
        company.setStatus(rs.getString("status"));
        company.setCreatedAt(rs.getTimestamp("created_at"));

        return company;
    }
}

