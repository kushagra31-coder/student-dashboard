package com.portfolio.servlet;

import com.portfolio.dao.AttendanceDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/attendance")
public class AttendanceServlet extends HttpServlet {

    private final AttendanceDAO attendanceDAO = new AttendanceDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || !"admin".equals(session.getAttribute("studentRole"))) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String[] sidSubs = request.getParameterValues("sid_sub");
        if (sidSubs != null) {
            for (String sidSub : sidSubs) {
                try {
                    String[] parts = sidSub.split("__");
                    if (parts.length == 2) {
                        int studentId = Integer.parseInt(parts[0]);
                        String subject = parts[1];

                        String attendedStr = request.getParameter("attended_" + studentId + "_" + subject);
                        String totalStr = request.getParameter("total_" + studentId + "_" + subject);

                        if (attendedStr != null && totalStr != null) {
                            int totalClasses = Integer.parseInt(totalStr.trim());
                            int attended = Integer.parseInt(attendedStr.trim());

                            if (attended > totalClasses) attended = totalClasses;
                            if (attended < 0) attended = 0;
                            if (totalClasses < 1) totalClasses = 1;

                            attendanceDAO.updateAttendance(studentId, subject, totalClasses, attended);
                        }
                    }
                } catch (NumberFormatException e) {
                }
            }
        }
        response.sendRedirect(request.getContextPath() + "/admin?tab=attendance&success=true");
    }
}
