
package model;

import java.sql.Timestamp;

public class Company {

    private int companyId;
    private String companyCode;
    private String companyName;
    private String industry;
    private String website;
    private String location;
    private String companyType;
    private String hrName;
    private String hrEmail;
    private String hrMobile;
    private String status;
    private Timestamp createdAt;

    // Default constructor
    public Company() {
    }

    // Getters and Setters

    public int getCompanyId() {
        return companyId;
    }

    public void setCompanyId(int companyId) {
        this.companyId = companyId;
    }

    public String getCompanyCode() {
        return companyCode;
    }

    public void setCompanyCode(String companyCode) {
        this.companyCode = companyCode;
    }

    public String getCompanyName() {
        return companyName;
    }

    public void setCompanyName(String companyName) {
        this.companyName = companyName;
    }

    public String getIndustry() {
        return industry;
    }

    public void setIndustry(String industry) {
        this.industry = industry;
    }

    public String getWebsite() {
        return website;
    }

    public void setWebsite(String website) {
        this.website = website;
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public String getCompanyType() {
        return companyType;
    }

    public void setCompanyType(String companyType) {
        this.companyType = companyType;
    }

    public String getHrName() {
        return hrName;
    }

    public void setHrName(String hrName) {
        this.hrName = hrName;
    }

    public String getHrEmail() {
        return hrEmail;
    }

    public void setHrEmail(String hrEmail) {
        this.hrEmail = hrEmail;
    }

    public String getHrMobile() {
        return hrMobile;
    }

    public void setHrMobile(String hrMobile) {
        this.hrMobile = hrMobile;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    // Display company details
    @Override
    public String toString() {
        return "Company ID: " + companyId +
                "\nCompany Code: " + companyCode +
                "\nCompany Name: " + companyName +
                "\nIndustry: " + industry +
                "\nWebsite: " + website +
                "\nLocation: " + location +
                "\nCompany Type: " + companyType +
                "\nHR Name: " + hrName +
                "\nHR Email: " + hrEmail +
                "\nHR Mobile: " + hrMobile +
                "\nStatus: " + status;
    }
}
