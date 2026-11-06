
package service;

import dao.CompanyDAO;
import model.Company;

import java.sql.SQLException;
import java.util.List;

public class CompanyService {

    private final CompanyDAO companyDAO = new CompanyDAO();

    // Add a new company
    public void addCompany(Company company) throws SQLException {

        validateCompany(company);

        if (company.getStatus() == null ||
                company.getStatus().isBlank()) {
            company.setStatus("ACTIVE");
        }

        companyDAO.addCompany(company);

        System.out.println("Company added successfully!");
    }

    // Update an existing company
    public void updateCompany(Company company) throws SQLException {

        if (company == null) {
            throw new IllegalArgumentException(
                    "Company details cannot be empty."
            );
        }

        if (company.getCompanyId() <= 0) {
            throw new IllegalArgumentException(
                    "Invalid Company ID."
            );
        }

        Company existingCompany =
                companyDAO.getCompanyById(company.getCompanyId());

        if (existingCompany == null) {
            throw new IllegalArgumentException(
                    "Company not found."
            );
        }

        validateCompany(company);

        companyDAO.updateCompany(company);

        System.out.println("Company updated successfully!");
    }

    // Search company by ID
    public Company getCompanyById(int companyId) throws SQLException {

        if (companyId <= 0) {
            throw new IllegalArgumentException(
                    "Invalid Company ID."
            );
        }

        Company company = companyDAO.getCompanyById(companyId);

        if (company == null) {
            throw new IllegalArgumentException(
                    "Company not found."
            );
        }

        return company;
    }

    // View all companies
    public List<Company> getAllCompanies() throws SQLException {

        return companyDAO.getAllCompanies();
    }

    // Deactivate a company
    public void deactivateCompany(int companyId) throws SQLException {

        if (companyId <= 0) {
            throw new IllegalArgumentException(
                    "Invalid Company ID."
            );
        }

        Company company = companyDAO.getCompanyById(companyId);

        if (company == null) {
            throw new IllegalArgumentException(
                    "Company not found."
            );
        }

        companyDAO.deactivateCompany(companyId);

        System.out.println("Company deactivated successfully!");
    }

    // Validate company details
    private void validateCompany(Company company) {

        if (company == null) {
            throw new IllegalArgumentException(
                    "Company details cannot be empty."
            );
        }

        if (company.getCompanyCode() == null ||
                company.getCompanyCode().isBlank()) {
            throw new IllegalArgumentException(
                    "Company code is required."
            );
        }

        if (company.getCompanyName() == null ||
                company.getCompanyName().isBlank()) {
            throw new IllegalArgumentException(
                    "Company name is required."
            );
        }

        if (company.getStatus() != null &&
                !company.getStatus().isBlank() &&
                !company.getStatus().equals("ACTIVE") &&
                !company.getStatus().equals("INACTIVE")) {

            throw new IllegalArgumentException(
                    "Status must be ACTIVE or INACTIVE."
            );
        }
    }
}
