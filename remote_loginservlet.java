?package Backend;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class loginservlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/JSP/login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        if (email == null || password == null) {
            request.setAttribute("error", "Please enter both email and password.");
            request.getRequestDispatcher("/JSP/login.jsp").forward(request, response);
            return;
        }

        email = email.trim().toLowerCase();
        String role = null;
        String name = null;

        if ("admin@dashboard.com".equals(email) && "admin123".equals(password)) {
            role = "admin";
            name = "Campus Administrator";
        } else if ("faculty@dashboard.com".equals(email) && "faculty123".equals(password)) {
            role = "faculty";
            name = "Faculty Manager";
        } else if ("placement@dashboard.com".equals(email) && "placement123".equals(password)) {
            role = "placement";
            name = "Placement Coordinator";
        }

        if (role == null) {
            try (Connection conn = DBconnection.getConnection();
                    PreparedStatement stmt = conn.prepareStatement(
                            "SELECT student_id, name, email, phone, branch, semester FROM students WHERE email = ?")) {
                stmt.setString(1, email);
                ResultSet rs = stmt.executeQuery();
                if (rs.next() && "student123".equals(password)) {
                    role = "student";
                    name = rs.getString("name");
                    HttpSession session = request.getSession(true);
                    session.setAttribute("userRole", role);
                    session.setAttribute("studentId", rs.getInt("student_id"));
                    session.setAttribute("name", name);
                    session.setAttribute("email", rs.getString("email"));
                    session.setAttribute("phone", rs.getString("phone"));
                    session.setAttribute("branch", rs.getString("branch"));
                    session.setAttribute("semester", rs.getInt("semester"));
                    session.setAttribute("profileComplete", Boolean.TRUE);
                    response.sendRedirect(request.getContextPath() + "/JSP/studentdashboard.jsp");
                    return;
                }
            } catch (Exception e) {
                request.setAttribute("error", "Unable to reach the database: " + e.getMessage());
                request.getRequestDispatcher("/JSP/login.jsp").forward(request, response);
                return;
            }
        } else {
            HttpSession session = request.getSession(true);
            session.setAttribute("userRole", role);
            session.setAttribute("name", name);
            session.setAttribute("email", email);
            response.sendRedirect(request.getContextPath() + "/JSP/" + (role.equals("admin") ? "admindasboard.jsp"
                    : role.equals("faculty") ? "facultydashboard.jsp" : "placmentdashboard.jsp"));
            return;
        }

        request.setAttribute("error", "Invalid credentials. Student password is student123.");
        request.getRequestDispatcher("/JSP/login.jsp").forward(request, response);
    }
}

