# Student Portfolio Dashboard

A Java-based Student Portfolio Dashboard built using **Java Servlets, JSP, JDBC, Maven, MySQL, and Apache Tomcat 10.1**. The application enables students to manage their academic profiles, projects, skills, certificates, documents, attendance, and contact messages through a web interface.

---

## Features

* Student Registration & Login
* Dashboard
* Project Management
* Skills Management
* Certificate Management
* Attendance Management
* Document Upload & View
* Contact Form
* Admin Dashboard
* Session Authentication
* MySQL Database Integration

---

## Technology Stack

| Technology     | Version                    |
| -------------- | -------------------------- |
| Java           | JDK 17+ (Tested on JDK 25) |
| Maven          | 3.9+                       |
| Apache Tomcat  | 10.1.x                     |
| MySQL          | 8.x                        |
| JSP & Servlets | Jakarta EE 10              |
| JDBC           | MySQL Connector/J          |

---

## Project Structure

```
portfolio
│
├── src
│   └── main
│       ├── java
│       │   └── com.portfolio
│       │       ├── dao
│       │       ├── filter
│       │       ├── model
│       │       ├── servlet
│       │       └── util
│       │
│       ├── resources
│       │   └── db.properties
│       │
│       └── webapp
│           ├── WEB-INF
│           ├── css
│           ├── images
│           ├── js
│           └── *.jsp
│
├── pom.xml
├── schema.sql
├── attendance_setup.sql
├── seed_extra.sql
└── README.md
```

---

## Prerequisites

Install the following software before running the project:

* Java JDK 17 or later
* Apache Maven 3.9+
* Apache Tomcat 10.1
* MySQL Server 8+

Verify installation:

```bash
java -version
javac -version
mvn -version
```

---

## Clone the Repository

```bash
git clone https://github.com/kushagra31-coder/student-dashboard
cd portfolio
```

---

## Database Setup

Create a database named:

```sql
portfolio_db
```

Execute the SQL files in this order:

```
schema.sql
attendance_setup.sql
seed_extra.sql
```

If additional SQL files are required, execute them as well.

---

## Configure Database

Edit:

```
src/main/resources/db.properties
```

Example:

```properties
db.url=jdbc:mysql://localhost:3306/portfolio_db
db.username=root
db.password=your_password
```

---

## Build the Project

```bash
mvn clean package
```

The generated WAR file will be available at:

```
target/portfolio.war
```

---

## Deploy to Apache Tomcat

Copy:

```
target/portfolio.war
```

into:

```
<TOMCAT_HOME>/webapps/
```

Start Tomcat.

Tomcat will automatically extract the WAR.

Open:

```
http://localhost:8080/portfolio/login
```

---

## Maven Dependencies

The project uses Maven for dependency management.

Dependencies are downloaded automatically during:

```bash
mvn clean package
```

No manual JAR installation is required.

---

## Author

**Kushagra Singh Tomar**
B.Tech Computer Science (CSIT)
GitHub: https://github.com/kushagra31-coder
