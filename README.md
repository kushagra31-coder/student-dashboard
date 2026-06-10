# Student Portfolio Dashboard 🎓

A dynamic, multi-user portfolio and dashboard system built for students to showcase their projects, achievements, and academic records. Features a vibrant, playful, and brutalist **Expressive Design System**.

## ✨ Features

*   **Multi-Role Authentication:** Secure login system supporting multiple students and a dedicated Admin role.
*   **Expressive Design System:** A stunning, highly-structured aesthetic featuring:
    *   Vibrant primary colors and bold typography (`IBM Plex Mono`).
    *   Playful brutalist UI elements with solid borders and sharp drop-shadows.
    *   Clean, accessible layouts prioritizing readability.
*   **Theme Toggle:** Instant switching between the vibrant Light mode and a sleek Dark mode interface.
*   **Student Dashboard:** Personalized views for each student to manage and showcase:
    *   **Projects:** Add new telemetry projects with tech stack tags and live source links.
    *   **Certifications:** Upload and manage earned certificates (e.g., AWS, Google UX).
    *   **Skills:** Display coding languages and technical proficiencies.
    *   **Clubs & Communities:** Showcase active club memberships and roles (e.g., IEEE, GDC).
    *   **Documents:** Upload and access official academic documents.
*   **Admin Panel:** Comprehensive administrative controls including:
    *   Student Management & detailed profile viewing.
    *   Login Activity Logs.
    *   Placement Tracking and Attendance Monitoring.
    *   Global Document Access.
*   **Responsive & Interactive:** Fully responsive layout with custom modals for quick data entry directly from the dashboard.
*   **Password Visibility Toggle:** Convenient toggle to show/hide passwords during login.

## 🛠️ Tech Stack

*   **Frontend:** HTML5, CSS3 (Expressive Design System), JavaScript (Vanilla ES6+), Bootstrap 5.3, Bootstrap Icons.
*   **Backend:** Java Servlets (Jakarta EE 10), JSP (JavaServer Pages), JSTL.
*   **Database:** MySQL 8.0.
*   **Server:** Apache Tomcat 10.1.

## 🚀 Getting Started

### Prerequisites

*   Java Development Kit (JDK) 21 or higher (JDK 25 recommended).
*   Apache Tomcat 10.1.
*   MySQL Server 8.0.

### Database Setup

1.  Create a MySQL database named `portfolio_db`.
2.  Execute the provided `patch_db.sql` and `patch_certificates.sql` scripts to create the necessary tables and seed initial data.
3.  Update the database credentials (username and password) in `src/com/portfolio/util/DBConnection.java` to match your local setup.

### Deployment

1.  Compile all Java files in the `src` directory and output the `.class` files to `Studentdashboard/WEB-INF/classes`.
    *   You can use the provided `compile.ps1` PowerShell script.
    *   Ensure `servlet-api.jar`, `jsp-api.jar`, and `mysql-connector-j-9.7.0.jar` are in your classpath during compilation.
2.  Deploy the entire `Studentdashboard` directory to the `webapps` folder of your Tomcat installation.
3.  Start the Tomcat server.

### Accessing the Application

*   Navigate to `http://localhost:8080/Studentdashboard/login` in your web browser.

**Default Credentials:**

*   **Admin:** `4` / `admin123`
*   **Student (Kushagra):** `1` / `password123`
*   **Student (Bhagyesh):** `2` / `password123`
*   **Student (Harshit):** `3` / `password123`

## 👨‍💻 Contributors

*   **Kushagra Singh Tomar** - [GitHub](https://github.com/kushagra31-coder) | [LinkedIn](https://www.linkedin.com/in/kushagra-singh-tomar-94ba55277/)
*   **Bhagyesh Jain** - [GitHub](https://github.com/bhagyesh-jain) | [LinkedIn](https://www.linkedin.com/in/bhagyesh-jain-a1a86a3a2/)
*   **Harshit Singhi** - [GitHub](https://github.com/HarshDuck)
