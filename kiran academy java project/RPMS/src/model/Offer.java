package model;

import java.sql.Date;
import java.sql.Timestamp;

public class Offer {

    private int offerId;
    private String offerCode;
    private int applicationId;
    private String designation;
    private double offeredPackageLpa;
    private Date offerDate;
    private Date expectedJoiningDate;
    private String offerStatus;
    private String remarks;
    private Timestamp createdAt;

    public int getOfferId() {
        return offerId;
    }

    public void setOfferId(int offerId) {
        this.offerId = offerId;
    }

    public String getOfferCode() {
        return offerCode;
    }

    public void setOfferCode(String offerCode) {
        this.offerCode = offerCode;
    }

    public int getApplicationId() {
        return applicationId;
    }

    public void setApplicationId(int applicationId) {
        this.applicationId = applicationId;
    }

    public String getDesignation() {
        return designation;
    }

    public void setDesignation(String designation) {
        this.designation = designation;
    }

    public double getOfferedPackageLpa() {
        return offeredPackageLpa;
    }

    public void setOfferedPackageLpa(double offeredPackageLpa) {
        this.offeredPackageLpa = offeredPackageLpa;
    }

    public Date getOfferDate() {
        return offerDate;
    }

    public void setOfferDate(Date offerDate) {
        this.offerDate = offerDate;
    }

    public Date getExpectedJoiningDate() {
        return expectedJoiningDate;
    }

    public void setExpectedJoiningDate(Date expectedJoiningDate) {
        this.expectedJoiningDate = expectedJoiningDate;
    }

    public String getOfferStatus() {
        return offerStatus;
    }

    public void setOfferStatus(String offerStatus) {
        this.offerStatus = offerStatus;
    }

    public String getRemarks() {
        return remarks;
    }

    public void setRemarks(String remarks) {
        this.remarks = remarks;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }
}