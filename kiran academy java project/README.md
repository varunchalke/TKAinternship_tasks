# Recruitment & Placement Management System (RPMS)

## 1. Project Overview

The **Recruitment & Placement Management System (RPMS)** is a Java and MySQL-based application developed to manage recruitment and campus placement activities.

The system stores and manages information related to candidates, companies, jobs, applications, interviews, offers, and placements through a relational database.

The application uses Java JDBC to connect to the MySQL database and perform database operations.

## 2. Objectives

- To maintain candidate and recruitment-related information.
- To manage job and application records.
- To track application status during the recruitment process.
- To schedule and view candidate interviews.
- To maintain recruitment and placement data in a structured database.
- To generate reports using SQL queries.

## 3. Technologies Used

| Technology | Purpose |
|---|---|
| Java | Application development |
| MySQL | Database management |
| JDBC | Java-MySQL connectivity |
| MySQL Workbench | Database administration and SQL execution |
| Java IDE | Writing and executing Java programs |

## 4. Project Modules

The database design covers the following areas:

- Candidate Management
- Company Management
- Job Management
- Job Applications
- Interview Management
- Interview Feedback
- Offer Management
- Placement Management
- Recruitment and Placement Reports

**Implemented Java operations:**
- View All Applications
- Update Application Status
- Schedule Interview
- View Interviews

## 5. Project Structure

The following is an example of the project structure. Adjust it according to the actual files in your project.

```text
RPMS/
│
├── src/
│   ├── app/
│   │   └── Main.java
│   │
│   ├── dao/
│   │   ├── ApplicationDAO.java
│   │   └── InterviewDAO.java
│   │
│   ├── model/
│   │   ├── Application.java
│   │   └── Interview.java
│   │
│   └── util/
│       └── DBConnection.java
│
├── SQL/
│   ├── rpms_db.sql
│   ├── rpms_report.sql
│   ├── master_data.sql
│   └── workflow_sample_data.sql
│
└── README.md
```

## 6. Database Setup

Follow these steps to create and configure the database:

1. Open MySQL Workbench.
2. Open and execute the database creation and schema SQL file (`rpms_db`).
3. Execute the master data insertion SQL file.
4. Execute the workflow sample data insertion SQL file.
5. Verify that all required tables and sample records have been created.
6. Open and execute the report SQL file (`rpms_report`) to view the reports.

## 7. Database Connection Configuration

The Java application connects to MySQL using JDBC.

Open `DBConnection.java` and configure the following details according to your MySQL installation:

- MySQL server URL
- Database name
- MySQL username
- MySQL password

Make sure the MySQL Connector/J driver is added to the Java project's build path.


## 8. How to Run the Application

1. Start the MySQL server.
2. Open the RPMS Java project in your IDE.
3. Check the database connection settings in `DBConnection.java`.
4. Ensure that the MySQL JDBC driver is configured.
5. Open `Main.java`.
6. Run the program as a Java application.
7. If the connection is successful, the following message will be displayed:

```text
Database Connected Successfully!
```

## 9. Application Menu

The Java console application provides the following menu:

```text
===== RECRUITMENT & PLACEMENT MANAGEMENT SYSTEM =====

1. View All Applications
2. Update Application Status
3. Schedule Interview
4. View Interviews
5. Exit

Enter your choice:
```

### Menu Description

**Option 1 – View All Applications**

Displays all application records stored in the database.

**Option 2 – Update Application Status**

Allows the user to update the status of an existing application using its Application ID.

**Option 3 – Schedule Interview**

Allows the user to schedule an interview by entering the application ID, round number, interview type, date, time, mode, interviewer name, and meeting location.

**Option 4 – View Interviews**

Displays interview details for a selected Application ID.

**Option 5 – Exit**

Terminates the application.

## 10. SQL Reports

The project includes SQL queries for recruitment and placement analysis, including:

1. Candidate Count by Technology
2. Open Jobs by Company
3. Applications by Status
4. Recruitment Funnel
5. Company-wise Placements
6. Technology-wise Placements
7. Recruiter Performance
8. Pending Interviews
9. Offer-to-Joining Conversion
10. Job Aging Report

These reports can be executed using MySQL Workbench.

## 11. Sample Data

The project includes SQL scripts for inserting master data and workflow sample data.

The sample data covers candidates, skills, companies, jobs, applications, interviews, interview feedback, offers, and placements.

This data is used to test database operations and execute the reporting queries.

## 12. Testing

The following Java operations have been tested:

| Test Case | Expected Result | Status |
| Database Connection | Successful database connection | Passed |
| View Applications | Displays application records | Passed |
| Update Application Status | Updates application status | Passed |
| Schedule Interview | Saves interview details | Passed |
| View Interviews | Displays interview records | Passed |
| Exit Application | Closes the application | Passed |

Database tables, sample data, and SQL report queries were also tested.

## 13. Conclusion

The Recruitment & Placement Management System demonstrates the use of Java, JDBC, and MySQL in developing a database-driven recruitment application.

The project provides a structured database for recruitment and placement information, Java-based application operations for managing applications and interviews, and SQL queries for recruitment and placement reporting.

It demonstrates the practical application of Java programming, object-oriented concepts, database connectivity, SQL queries, and relational database management.

---

**Project Title:** Recruitment & Placement Management System (RPMS)  
**Programming Language:** Java  
**Database:** MySQL  
**Connectivity:** JDBC