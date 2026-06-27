package com.portfolio.servlet;

import com.portfolio.dao.AttendanceDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

/**
 * Handles admin attendance updates.
 * POST /attendance  — update a single student+subject attendance row.
 */
@WebServlet("/attendance")
public class AttendanceServlet extends HttpServlet {

    private final AttendanceDAO attendanceDAO = new AttendanceDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        // Only admin may update attendance
        if (session == null || !"admin".equals(session.getAttribute("studentRole"))) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        try {
            int    studentId    = Integer.parseInt(request.getParameter("studentId").trim());
            String subject      = request.getParameter("subject").trim();
            int    totalClasses = Integer.parseInt(request.getParameter("totalClasses").trim());
            int    attended     = Integer.parseInt(request.getParameter("attended").trim());

            if (attended > totalClasses) attended = totalClasses;
            if (attended < 0)           attended = 0;
            if (totalClasses < 1)       totalClasses = 1;

            attendanceDAO.updateAttendance(studentId, subject, totalClasses, attended);
        } catch (NumberFormatException e) {
            // invalid input — silently ignore
        }

        // Redirect back to admin attendance tab
        response.sendRedirect(request.getContextPath() + "/admin?tab=attendance&success=true");
    }
}
