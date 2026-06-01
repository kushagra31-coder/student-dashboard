package com.portfolio.servlet;

import com.portfolio.dao.AttendanceDAO;
import com.portfolio.dao.DocumentDAO;
import com.portfolio.dao.LoginLogDAO;
import com.portfolio.dao.PlacementDAO;
import com.portfolio.dao.StudentDAO;
import com.portfolio.model.Attendance;
import com.portfolio.model.Document;
import com.portfolio.model.LoginLog;
import com.portfolio.model.Placement;
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

    private final StudentDAO studentDAO = new StudentDAO();
    private final LoginLogDAO loginLogDAO = new LoginLogDAO();
    private final PlacementDAO placementDAO = new PlacementDAO();
    private final AttendanceDAO attendanceDAO = new AttendanceDAO();
    private final DocumentDAO documentDAO = new DocumentDAO();

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
        List<Placement> placements = placementDAO.getAllPlacements();
        List<Attendance> attendanceList = attendanceDAO.getAllAttendance();
        List<Document> allDocuments = documentDAO.getAllDocuments();

        // Set request attributes for the admin JSP
        request.setAttribute("students", students);
        request.setAttribute("loginLogs", loginLogs);
        request.setAttribute("placements", placements);
        request.setAttribute("attendanceList", attendanceList);
        request.setAttribute("allDocuments", allDocuments);

        request.getRequestDispatcher("/admin.jsp").forward(request, response);
    }
}
