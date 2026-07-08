# 🎓 AITR Student Portfolio Dashboard

[![Java](https://img.shields.io/badge/Java-17+-orange.svg)](https://www.java.com/)
[![Jakarta EE](https://img.shields.io/badge/Jakarta_EE-10-blue.svg)](https://jakarta.ee/)
[![Tomcat](https://img.shields.io/badge/Apache_Tomcat-10.1-yellow.svg)](https://tomcat.apache.org/)
[![MySQL](https://img.shields.io/badge/MySQL-8.0+-blue.svg)](https://www.mysql.com/)

A modern, Neobrutalist-styled Student Portfolio Dashboard built using **Java Servlets, JSP, JDBC, Maven, MySQL, and Apache Tomcat 10.1**. It allows students to seamlessly track their achievements, manage projects, view verified documents, and handle attendance, while providing an Admin Console for institutional oversight.

---

## 🚀 Live Demo
> *https://portfolio-akaza.azurewebsites.net/login*

---

## 🏗️ Technical Flow (Architecture)

This application strictly follows the **MVC (Model-View-Controller)** design pattern:

1. **View (JSP/HTML/CSS):** 
   - The user interacts with the UI (e.g., login.jsp, home.jsp).
   - The frontend is built with a custom **Neobrutalist Design System** (Bangers typography, dashed borders, clip-path CSS buttons).
2. **Controller (Java Servlets):** 
   - Requests are routed through Servlets (e.g., LoginServlet, StudentActionServlet).
   - Servlets handle routing, HTTP Session validation, input sanitation (Email Regex matching), and file uploads (multipart/form-data).
3. **Model (Java Beans & DAO):** 
   - Data Access Objects (e.g., StudentDAO, ProjectDAO) execute secure PreparedStatement SQL queries.
   - Beans (e.g., Student.java, Project.java) transfer data between the DB and the frontend.
4. **Database (MySQL):** 
   - The system is connected to a highly available MySQL Database (compatible with both local instances and cloud DBs like Aiven Cloud).

---

## ✨ Features

### 🧑‍🎓 Student Portal
- **Secure Authentication:** Multi-layered email validation (HTML Pattern + JS Regex + Backend Java Validation).
- **Dashboard:** Stats tracking (total projects, achievements, documents).
- **Projects Showcase:** Upload project screenshots, tech stacks, and GitHub links.
- **Verified Documents:** Upload and store transcripts and certificates.
- **Attendance Module:** Track real-time academic attendance.

### 🛡️ Admin Console
- **System Overview:** View all registered users globally.
- **User Management:** Delete spam accounts or invalid students.
- **Audit Logging:** Track all system logins (IP address, Timestamp, Role).

---

## 🛠️ Standard Operating Procedure (SOP) / Local Setup

Follow these steps to run the project locally on your machine.

### 1. Prerequisites
- **Java JDK 17+** (Tested on JDK 25)
- **Apache Maven 3.9+**
- **Apache Tomcat 10.1+**
- **MySQL Server 8+**

### 2. Clone the Repository
\\\ash
git clone https://github.com/kushagra31-coder/student-dashboard
cd portfolio
\\\

### 3. Database Setup (MySQL)
Create the database:
\\\sql
CREATE DATABASE portfolio_db;
USE portfolio_db;
\\\
Execute the schema files (found in the root or src/main/resources/):
\\\ash
mysql -u root -p portfolio_db < schema.sql
\\\

### 4. Configure Environment
Edit the database credentials file located at: src/main/resources/db.properties
\\\properties
db.url=jdbc:mysql://localhost:3306/portfolio_db?sslMode=REQUIRED&allowPublicKeyRetrieval=true
db.username=root
db.password=your_secure_password
\\\
*(Note: If using Aiven Cloud, paste your Aiven host URL here instead).*

### 5. Build and Deploy
Compile the project using Maven:
\\\ash
mvn clean package
\\\
Copy the generated WAR file to your Tomcat Server:
\\\ash
cp target/ROOT.war "C:\Program Files\Apache Software Foundation\Tomcat 10.1\webapps\"
\\\
Start Tomcat and open your browser to:
**http://localhost:8080**

---

## 📂 Project Structure
\\\	ext
portfolio/
├── src/
│   ├── main/
│   │   ├── java/com/portfolio/
│   │   │   ├── dao/          # Database queries
│   │   │   ├── filter/       # Authentication filters
│   │   │   ├── model/        # Java beans
│   │   │   ├── servlet/      # Business logic & routing
│   │   │   └── util/         # DB Connection managers
│   │   ├── resources/        
│   │   │   ├── db.properties # Database configuration
│   │   │   └── schema.sql    # Database tables
│   │   └── webapp/           
│   │       ├── css/style.css # Neobrutalist design system
│   │       ├── WEB-INF/      # Protected views (header, sidebar)
│   │       └── *.jsp         # Public views (login, admin, home)
├── pom.xml                   # Maven dependencies
└── README.md
\\\

---

## 👨‍💻 Author
**Kushagra Singh Tomar**  
B.Tech Computer Science (CSIT)  
GitHub: [@kushagra31-coder](https://github.com/kushagra31-coder)
