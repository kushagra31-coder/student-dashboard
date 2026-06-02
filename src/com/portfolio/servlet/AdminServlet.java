package com.portfolio.servlet;

import com.portfolio.dao.AttendanceDAO;
import com.portfolio.dao.CertificateDAO;
import com.portfolio.dao.DocumentDAO;
import com.portfolio.dao.LoginLogDAO;
import com.portfolio.dao.ProjectDAO;
import com.portfolio.dao.StudentDAO;
import com.portfolio.model.Attendance;
import com.portfolio.model.Certificate;
import com.portfolio.model.Document;
import com.portfolio.model.LoginLog;
import com.portfolio.model.Project;
import com.portfolio.model.Student;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/admin")
public class AdminServlet extends HttpServlet {

    private final StudentDAO studentDAO = new StudentDAO();
    private final LoginLogDAO loginLogDAO = new LoginLogDAO();
    private final AttendanceDAO attendanceDAO = new AttendanceDAO();
    private final DocumentDAO documentDAO = new DocumentDAO();
    private final ProjectDAO projectDAO = new ProjectDAO();
    private final CertificateDAO certificateDAO = new CertificateDAO();

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
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // Fetch all data for the admin dashboard
        List<Student> students = studentDAO.getAllStudents();
        List<LoginLog> loginLogs = loginLogDAO.getAllLogs();
        List<Attendance> attendanceList = attendanceDAO.getAllAttendance();
        
        // Group data by student for the updated UI
        Map<Integer, List<Project>> studentProjects = new HashMap<>();
        Map<Integer, List<Document>> studentDocuments = new HashMap<>();
        Map<Integer, List<Certificate>> studentCertificates = new HashMap<>();

        for (Student s : students) {
            studentProjects.put(s.getId(), projectDAO.getProjectsByStudentId(s.getId()));
            studentDocuments.put(s.getId(), documentDAO.getDocumentsByStudentId(s.getId()));
            studentCertificates.put(s.getId(), certificateDAO.getCertificatesByStudentId(s.getId()));
        }

        // Set request attributes for the admin JSP
        request.setAttribute("students", students);
        request.setAttribute("loginLogs", loginLogs);
        request.setAttribute("attendanceList", attendanceList);
        
        request.setAttribute("studentProjects", studentProjects);
        request.setAttribute("studentDocuments", studentDocuments);
        request.setAttribute("studentCertificates", studentCertificates);

        request.getRequestDispatcher("/admin.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("studentId") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        String role = (String) session.getAttribute("studentRole");
        if (!"admin".equals(role)) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String action = request.getParameter("action");
        if (action == null) {
            response.sendRedirect(request.getContextPath() + "/admin");
            return;
        }

        try {
            int targetStudentId = Integer.parseInt(request.getParameter("studentId"));

            if ("addProject".equals(action)) {
                String title = request.getParameter("title");
                String description = request.getParameter("description");
                String techStack = request.getParameter("techStack");
                String githubUrl = request.getParameter("githubUrl");
                projectDAO.addProject(targetStudentId, title, description, techStack, githubUrl);
            } 
            else if ("uploadDocument".equals(action)) {
                String title = request.getParameter("title");
                String filePath = request.getParameter("filePath");
                documentDAO.addDocument(targetStudentId, title, filePath);
            }
            else if ("addCertificate".equals(action)) {
                String title = request.getParameter("title");
                String filePath = request.getParameter("filePath");
                certificateDAO.addCertificate(targetStudentId, title, filePath);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        response.sendRedirect(request.getContextPath() + "/admin?success=true");
    }
}
