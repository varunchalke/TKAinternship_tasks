package app;

import java.util.Scanner;
import java.sql.Date;
import java.sql.Time;

import dao.ApplicationDAO;
import dao.InterviewDAO;
import model.Interview;
import model.Application;
import util.DBConnection;

public class Main {

    static Scanner sc = new Scanner(System.in);

    static ApplicationDAO applicationDAO = new ApplicationDAO();
    static InterviewDAO interviewDAO = new InterviewDAO();

    public static void main(String[] args) {

        try {
            DBConnection.getConnection().close();
            System.out.println("Database Connected Successfully!");
        } catch (Exception e) {
            System.out.println("Database Connection Failed!");
            System.out.println(e.getMessage());
            return;
        }

        int choice;

        do {
            System.out.println("\n===== RECRUITMENT & PLACEMENT MANAGEMENT SYSTEM =====");
            System.out.println("1. View All Applications");
            System.out.println("2. Update Application Status");
            System.out.println("3. Schedule Interview");
            System.out.println("4. View Interviews");
            System.out.println("5. Exit");
            System.out.print("Enter your choice: ");

            choice = sc.nextInt();
            sc.nextLine();

            try {
                switch (choice) {

                    case 1:
                        viewApplications();
                        break;

                    case 2:
                        updateApplication();
                        break;

                    case 3:
                        scheduleInterview();
                        break;

                    case 4:
                        viewInterviews();
                        break;

                    case 5:
                        System.out.println("Thank you for using RPMS!");
                        break;

                    default:
                        System.out.println("Invalid choice!");
                }
            } catch (Exception e) {
                System.out.println("Error: " + e.getMessage());
            }

        } while (choice != 5);

        sc.close();
    }

    static void viewApplications() throws Exception {

        for (Application a : applicationDAO.getAllApplications()) {
            System.out.println(
                "ID: " + a.getApplicationId()
                + " | Candidate ID: " + a.getCandidateId()
                + " | Job ID: " + a.getJobId()
                + " | Status: " + a.getApplicationStatus()
            );
        }
    }

    static void updateApplication() throws Exception {

        System.out.print("Enter Application ID: ");
        int id = sc.nextInt();
        sc.nextLine();

        System.out.print("Enter New Status: ");
        String status = sc.nextLine().toUpperCase();

        applicationDAO.updateApplicationStatus(id, status);

        System.out.println("Application status updated!");
    }

    static void scheduleInterview() throws Exception {

        Interview i = new Interview();

        System.out.print("Enter Application ID: ");
        i.setApplicationId(sc.nextInt());

        System.out.print("Enter Round Number: ");
        i.setRoundNumber(sc.nextInt());
        sc.nextLine();

        System.out.print("Enter Round Type: ");
        i.setRoundType(sc.nextLine());

        System.out.print("Enter Date (YYYY-MM-DD): ");
        i.setScheduledDate(Date.valueOf(sc.nextLine()));

        System.out.print("Enter Time (HH:MM:SS): ");
        i.setScheduledTime(Time.valueOf(sc.nextLine()));

        System.out.print("Enter Mode: ");
        i.setMode(sc.nextLine());

        System.out.print("Enter Interviewer Name: ");
        i.setInterviewerName(sc.nextLine());

        System.out.print("Enter Meeting Location: ");
        i.setMeetingOrLocation(sc.nextLine());

        i.setStatus("SCHEDULED");

        interviewDAO.addInterview(i);

        System.out.println("Interview scheduled successfully!");
    }

    static void viewInterviews() throws Exception {

        System.out.print("Enter Application ID: ");
        int id = sc.nextInt();

        for (Interview i : interviewDAO.getInterviewsByApplication(id)) {
            System.out.println(
                "Interview ID: " + i.getInterviewId()
                + " | Round: " + i.getRoundNumber()
                + " | Type: " + i.getRoundType()
                + " | Date: " + i.getScheduledDate()
                + " | Status: " + i.getStatus()
            );
        }
    }
}