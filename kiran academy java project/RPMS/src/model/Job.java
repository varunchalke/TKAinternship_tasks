
package model;

import java.math.BigDecimal;
import java.sql.Date;
import java.sql.Timestamp;

public class Job {

    private int jobId;
    private String jobCode;
    private int companyId;

    private String jobTitle;
    private String employmentType;
    private String location;
    private int openings;

    private BigDecimal minPackageLpa;
    private BigDecimal maxPackageLpa;
    private BigDecimal minPercentage;

    private int minPassingYear;
    private int maxPassingYear;
    private int maxBacklogs;

    private BigDecimal experienceMinYears;
    private String qualificationRule;

    private Date postedDate;
    private Date applicationDeadline;

    private String status;
    private Integer createdBy;
    private Timestamp createdAt;

    // Default constructor
    public Job() {
    }

    public int getJobId() {
        return jobId;
    }

    public void setJobId(int jobId) {
        this.jobId = jobId;
    }

    public String getJobCode() {
        return jobCode;
    }

    public void setJobCode(String jobCode) {
        this.jobCode = jobCode;
    }

    public int getCompanyId() {
        return companyId;
    }

    public void setCompanyId(int companyId) {
        this.companyId = companyId;
    }

    public String getJobTitle() {
        return jobTitle;
    }

    public void setJobTitle(String jobTitle) {
        this.jobTitle = jobTitle;
    }

    public String getEmploymentType() {
        return employmentType;
    }

    public void setEmploymentType(String employmentType) {
        this.employmentType = employmentType;
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public int getOpenings() {
        return openings;
    }

    public void setOpenings(int openings) {
        this.openings = openings;
    }

    public BigDecimal getMinPackageLpa() {
        return minPackageLpa;
    }

    public void setMinPackageLpa(BigDecimal minPackageLpa) {
        this.minPackageLpa = minPackageLpa;
    }

    public BigDecimal getMaxPackageLpa() {
        return maxPackageLpa;
    }

    public void setMaxPackageLpa(BigDecimal maxPackageLpa) {
        this.maxPackageLpa = maxPackageLpa;
    }

    public BigDecimal getMinPercentage() {
        return minPercentage;
    }

    public void setMinPercentage(BigDecimal minPercentage) {
        this.minPercentage = minPercentage;
    }

    public int getMinPassingYear() {
        return minPassingYear;
    }

    public void setMinPassingYear(int minPassingYear) {
        this.minPassingYear = minPassingYear;
    }

    public int getMaxPassingYear() {
        return maxPassingYear;
    }

    public void setMaxPassingYear(int maxPassingYear) {
        this.maxPassingYear = maxPassingYear;
    }

    public int getMaxBacklogs() {
        return maxBacklogs;
    }

    public void setMaxBacklogs(int maxBacklogs) {
        this.maxBacklogs = maxBacklogs;
    }

    public BigDecimal getExperienceMinYears() {
        return experienceMinYears;
    }

    public void setExperienceMinYears(BigDecimal experienceMinYears) {
        this.experienceMinYears = experienceMinYears;
    }

    public String getQualificationRule() {
        return qualificationRule;
    }

    public void setQualificationRule(String qualificationRule) {
        this.qualificationRule = qualificationRule;
    }

    public Date getPostedDate() {
        return postedDate;
    }

    public void setPostedDate(Date postedDate) {
        this.postedDate = postedDate;
    }

    public Date getApplicationDeadline() {
        return applicationDeadline;
    }

    public void setApplicationDeadline(Date applicationDeadline) {
        this.applicationDeadline = applicationDeadline;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Integer getCreatedBy() {
        return createdBy;
    }

    public void setCreatedBy(Integer createdBy) {
        this.createdBy = createdBy;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    @Override
    public String toString() {
        return "Job{" +
                "jobId=" + jobId +
                ", jobCode='" + jobCode + '\'' +
                ", jobTitle='" + jobTitle + '\'' +
                ", employmentType='" + employmentType + '\'' +
                ", location='" + location + '\'' +
                ", openings=" + openings +
                ", minPackageLpa=" + minPackageLpa +
                ", maxPackageLpa=" + maxPackageLpa +
                ", minPercentage=" + minPercentage +
                ", minPassingYear=" + minPassingYear +
                ", maxPassingYear=" + maxPassingYear +
                ", maxBacklogs=" + maxBacklogs +
                ", status='" + status + '\'' +
                '}';
    }
}
