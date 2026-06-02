package com.portfolio.servlet;

import com.portfolio.dao.AttendanceDAO;
import com.portfolio.dao.DocumentDAO;
import com.portfolio.dao.LoginLogDAO;
import com.portfolio.dao.ProjectDAO;
import com.portfolio.dao.StudentDAO;
import com.portfolio.model.Attendance;
import com.portfolio.model.Document;
import com.portfolio.model.LoginLog;
import com.portfolio.model.Student;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet("/admin")
public class AdminServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private final StudentDAO studentDAO = new StudentDAO();
    private final LoginLogDAO loginLogDAO = new LoginLogDAO();
    private final AttendanceDAO attendanceDAO = new AttendanceDAO();
    private final DocumentDAO documentDAO = new DocumentDAO();
    private final ProjectDAO projectDAO = new ProjectDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        // Verify the user is logged in and has admin role
        if (session == null || session.getAttribute("studentId") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String role = (String) session.getAttribute("studentRole");
        if (!"admin".equals(role)) {
            response.sendRedirect(request.getContextPath() + "/home");
            return;
        }

        // Retrieve flash messages
        String msg = (String) session.getAttribute("msg");
        String msgError = (String) session.getAttribute("msgError");
        if (msg != null) {
            request.setAttribute("msg", msg);
            session.removeAttribute("msg");
        }
        if (msgError != null) {
            request.setAttribute("msgError", msgError);
            session.removeAttribute("msgError");
        }

        // Fetch all data for the admin dashboard
        List<Student> students = studentDAO.getAllStudents();
        List<LoginLog> loginLogs = loginLogDAO.getAllLogs();
        List<Attendance> attendanceList = attendanceDAO.getAllAttendance();
        List<Document> allDocuments = documentDAO.getAllDocuments();

        // Set request attributes for the admin JSP
        request.setAttribute("students", students);
        request.setAttribute("loginLogs", loginLogs);
        request.setAttribute("attendanceList", attendanceList);
        request.setAttribute("allDocuments", allDocuments);

        request.getRequestDispatcher("/admin.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        // Verify the user is logged in and has admin role
        if (session == null || session.getAttribute("studentId") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String role = (String) session.getAttribute("studentRole");
        if (!"admin".equals(role)) {
            response.sendRedirect(request.getContextPath() + "/home");
            return;
        }

        String action = request.getParameter("action");
        if ("addProject".equals(action)) {
            try {
                int studentId = Integer.parseInt(request.getParameter("studentId"));
                String title = request.getParameter("title");
                String description = request.getParameter("description");
                String techStack = request.getParameter("techStack");
                String githubUrl = request.getParameter("githubUrl");

                boolean success = projectDAO.addProject(studentId, title, description, techStack, githubUrl);
                if (success) {
                    session.setAttribute("msg", "Project added successfully!");
                } else {
                    session.setAttribute("msgError", "Failed to add project.");
                }
            } catch (Exception e) {
                e.printStackTrace();
                session.setAttribute("msgError", "Invalid project inputs.");
            }
        } else if ("uploadDocument".equals(action)) {
            try {
                int studentId = Integer.parseInt(request.getParameter("studentId"));
                String title = request.getParameter("title");
                String filePath = request.getParameter("filePath");

                boolean success = documentDAO.addDocument(studentId, title, filePath);
                if (success) {
                    session.setAttribute("msg", "Document uploaded successfully!");
                } else {
                    session.setAttribute("msgError", "Failed to upload document.");
                }
            } catch (Exception e) {
                e.printStackTrace();
                session.setAttribute("msgError", "Invalid document inputs.");
            }
        }

        response.sendRedirect(request.getContextPath() + "/admin");
    }
}
