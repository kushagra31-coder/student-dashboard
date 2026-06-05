# Student Portfolio Dashboard 🎓

A dynamic, multi-user portfolio and dashboard system built for students to showcase their projects, achievements, and academic records. Features a stunning, interactive space-themed interface with glassmorphism design.

## ✨ Features

*   **Multi-Role Authentication:** Secure login system supporting multiple students and a dedicated Admin role.
*   **Epic Space Theme:** 60fps dynamic HTML5 Canvas background featuring:
    *   Orbiting Solar System
    *   Swirling Black Hole
    *   Drifting Nebula Clouds
    *   Twinkling and Shooting Stars
*   **Theme Toggle:** Instant switching between the immersive Dark Space theme and a clean Light mode.
*   **Student Dashboard:** Personalized views for each student to manage and showcase:
    *   Projects (with tech stack tags and live links)
    *   Achievements
    *   Academic Documents
*   **Admin Panel:** Comprehensive administrative controls including:
    *   Student Management
    *   Login Activity Logs
    *   Placement Tracking
    *   Attendance Monitoring (with visual progress bars)
    *   Global Document Access
*   **Responsive Design:** Fully responsive layout ensuring a seamless experience across desktop, tablet, and mobile devices.
*   **Password Visibility Toggle:** Convenient toggle to show/hide passwords during login.

## 🛠️ Tech Stack

*   **Frontend:** HTML5, CSS3 (Custom Properties, Flexbox, CSS Grid), JavaScript (Vanilla ES6+), Bootstrap 5.3, Bootstrap Icons.
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
2.  Execute the provided `schema.sql` script to create the necessary tables and seed initial data.
3.  Update the database credentials (username and password) in `src/com/portfolio/util/DBConnection.java` to match your local setup.

### Deployment

1.  Compile all Java files in the `src` directory and output the `.class` files to `Studentdashboard/WEB-INF/classes`.
    *   Ensure `servlet-api.jar`, `jsp-api.jar`, and `mysql-connector-j-9.7.0.jar` are in your classpath during compilation.
2.  Deploy the entire `Studentdashboard` directory to the `webapps` folder of your Tomcat installation.
3.  Start the Tomcat server.

### Accessing the Application

*   Navigate to `http://localhost:8080/Studentdashboard/login` in your web browser.

**Default Credentials:**

*   **Admin:** `4` / `admin@123`
*   **Student (Kushagra):** `1` / `kushagra@123`
*   **Student (Bhagyesh):** `2` / `bhagyesh@123`
*   **Student (Harshit):** `3` / `harshit@123`

## 👨‍💻 Contributors

*   **Kushagra Singh Tomar** - [GitHub](https://github.com/kushagra31-coder) | [LinkedIn](https://www.linkedin.com/in/kushagra-singh-tomar-94ba55277/)
*   **Bhagyesh Jain** - [GitHub](https://github.com/bhagyesh-jain) | [LinkedIn](https://www.linkedin.com/in/bhagyesh-jain-a1a86a3a2/)
*   **Harshit Singhi** - [GitHub](https://github.com/HarshDuck)

---

