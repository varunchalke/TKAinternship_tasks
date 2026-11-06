
package service;

import dao.CandidateDAO;
import model.Candidate;

import java.sql.SQLException;
import java.math.BigDecimal;
import java.util.List;

public class CandidateService {

    private CandidateDAO candidateDAO;

    public CandidateService() {
        candidateDAO = new CandidateDAO();
    }

    // Add a new candidate
    public void addCandidate(Candidate candidate) throws SQLException {

        validateCandidate(candidate);

        candidateDAO.addCandidate(candidate);
    }

    // Update candidate details
    public void updateCandidate(Candidate candidate)
            throws SQLException {

        if (candidate.getCandidateId() <= 0) {
            throw new IllegalArgumentException(
                    "Invalid Candidate ID."
            );
        }

        Candidate existingCandidate =
                candidateDAO.getCandidateById(
                        candidate.getCandidateId()
                );

        if (existingCandidate == null) {
            throw new IllegalArgumentException(
                    "Candidate not found."
            );
        }

        validateCandidate(candidate);

        candidateDAO.updateCandidate(candidate);
    }

    // Search candidate by ID
    public Candidate getCandidateById(int candidateId)
            throws SQLException {

        if (candidateId <= 0) {
            throw new IllegalArgumentException(
                    "Candidate ID must be greater than zero."
            );
        }

        return candidateDAO.getCandidateById(candidateId);
    }

    // View all candidates
    public List<Candidate> getAllCandidates()
            throws SQLException {

        return candidateDAO.getAllCandidates();
    }

    // Deactivate candidate
    public void deactivateCandidate(int candidateId)
            throws SQLException {

        if (candidateId <= 0) {
            throw new IllegalArgumentException(
                    "Invalid Candidate ID."
            );
        }

        Candidate candidate =
                candidateDAO.getCandidateById(candidateId);

        if (candidate == null) {
            throw new IllegalArgumentException(
                    "Candidate not found."
            );
        }

        candidateDAO.deactivateCandidate(candidateId);
    }

    // Validate candidate details
    private void validateCandidate(Candidate candidate) {

        if (candidate == null) {
            throw new IllegalArgumentException(
                    "Candidate details cannot be empty."
            );
        }

        if (candidate.getFullName() == null ||
                candidate.getFullName().trim().isEmpty()) {
            throw new IllegalArgumentException(
                    "Candidate name is required."
            );
        }

        if (candidate.getEmail() == null ||
                candidate.getEmail().trim().isEmpty()) {
            throw new IllegalArgumentException(
                    "Candidate email is required."
            );
        }

        if (candidate.getMobile() == null ||
                candidate.getMobile().trim().isEmpty()) {
            throw new IllegalArgumentException(
                    "Candidate mobile number is required."
            );
        }

        BigDecimal percentage = candidate.getPercentage();

        if (percentage == null ||
                percentage.compareTo(BigDecimal.ZERO) < 0 ||
                percentage.compareTo(new BigDecimal("100")) > 0) {
            throw new IllegalArgumentException(
                    "Percentage must be between 0 and 100."
            );
        }

        if (candidate.getBacklogCount() < 0) {
            throw new IllegalArgumentException(
                    "Backlog count cannot be negative."
            );
        }
    }
}
