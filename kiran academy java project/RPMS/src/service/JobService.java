
package service;

import dao.JobDAO;
import model.Job;

import java.sql.SQLException;
import java.util.List;

public class JobService {

    private final JobDAO jobDAO = new JobDAO();

    // Add a new job
    public void addJob(Job job) throws SQLException {

        validateJob(job);

        if (job.getStatus() == null ||
                job.getStatus().isBlank()) {
            job.setStatus("OPEN");
        }

        jobDAO.addJob(job);

        System.out.println("Job added successfully!");
    }

    // Update an existing job
    public void updateJob(Job job) throws SQLException {

        if (job == null) {
            throw new IllegalArgumentException(
                    "Job details cannot be empty."
            );
        }

        if (job.getJobId() <= 0) {
            throw new IllegalArgumentException(
                    "Invalid Job ID."
            );
        }

        Job existingJob = jobDAO.getJobById(job.getJobId());

        if (existingJob == null) {
            throw new IllegalArgumentException(
                    "Job not found."
            );
        }

        validateJob(job);

        jobDAO.updateJob(job);

        System.out.println("Job updated successfully!");
    }

    // Search job by ID
    public Job getJobById(int jobId) throws SQLException {

        if (jobId <= 0) {
            throw new IllegalArgumentException(
                    "Invalid Job ID."
            );
        }

        Job job = jobDAO.getJobById(jobId);

        if (job == null) {
            throw new IllegalArgumentException(
                    "Job not found."
            );
        }

        return job;
    }

    // View all jobs
    public List<Job> getAllJobs() throws SQLException {

        return jobDAO.getAllJobs();
    }

    // View open jobs
    public List<Job> getOpenJobs() throws SQLException {

        return jobDAO.getOpenJobs();
    }

    // Close a job
    public void closeJob(int jobId) throws SQLException {

        if (jobId <= 0) {
            throw new IllegalArgumentException(
                    "Invalid Job ID."
            );
        }

        Job job = jobDAO.getJobById(jobId);

        if (job == null) {
            throw new IllegalArgumentException(
                    "Job not found."
            );
        }

        jobDAO.closeJob(jobId);

        System.out.println("Job closed successfully!");
    }

    // Validate job details
    private void validateJob(Job job) {

        if (job == null) {
            throw new IllegalArgumentException(
                    "Job details cannot be empty."
            );
        }

        if (job.getJobCode() == null ||
                job.getJobCode().isBlank()) {
            throw new IllegalArgumentException(
                    "Job code is required."
            );
        }

        if (job.getJobTitle() == null ||
                job.getJobTitle().isBlank()) {
            throw new IllegalArgumentException(
                    "Job title is required."
            );
        }

        if (job.getCompanyId() <= 0) {
            throw new IllegalArgumentException(
                    "Valid Company ID is required."
            );
        }

        if (job.getOpenings() <= 0) {
            throw new IllegalArgumentException(
                    "Number of openings must be greater than zero."
            );
        }

        if (job.getMaxBacklogs() < 0) {
            throw new IllegalArgumentException(
                    "Maximum backlogs cannot be negative."
            );
        }

        if (job.getMinPercentage() != null &&
                (job.getMinPercentage().doubleValue() < 0 ||
                 job.getMinPercentage().doubleValue() > 100)) {
            throw new IllegalArgumentException(
                    "Minimum percentage must be between 0 and 100."
            );
        }

        if (job.getMinPackageLpa() != null &&
                job.getMaxPackageLpa() != null &&
                job.getMinPackageLpa().compareTo(
                        job.getMaxPackageLpa()) > 0) {
            throw new IllegalArgumentException(
                    "Minimum package cannot exceed maximum package."
            );
        }

        if (job.getApplicationDeadline() == null) {
            throw new IllegalArgumentException(
                    "Application deadline is required."
            );
        }

        if (job.getPostedDate() == null) {
            throw new IllegalArgumentException(
                    "Posted date is required."
            );
        }

        if (job.getStatus() != null &&
                !job.getStatus().isBlank() &&
                !job.getStatus().equals("OPEN") &&
                !job.getStatus().equals("CLOSED")) {
            throw new IllegalArgumentException(
                    "Job status must be OPEN or CLOSED."
            );
        }
    }
}
