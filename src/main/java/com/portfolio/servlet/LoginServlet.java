package com.portfolio.servlet;

import com.portfolio.dao.LoginLogDAO;
import com.portfolio.dao.StudentDAO;
import com.portfolio.model.Student;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    private final StudentDAO studentDAO = new StudentDAO();
    private final LoginLogDAO loginLogDAO = new LoginLogDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String idStr = request.getParameter("id");
        String password = request.getParameter("password");

        Student student = studentDAO.authenticate(idStr, password);

        if (student != null) {
            HttpSession session = request.getSession();
            session.setAttribute("studentId", student.getId());
            session.setAttribute("studentName", student.getName());
            session.setAttribute("studentRole", student.getRole());

            // Record the login in the audit log
            loginLogDAO.logLogin(student.getId(), student.getName(),
                    student.getRole(), request.getRemoteAddr());

            // Redirect based on role
            if ("admin".equals(student.getRole())) {
                response.sendRedirect(request.getContextPath() + "/admin");
            } else {
                response.sendRedirect(request.getContextPath() + "/home");
            }
        } else {
            request.setAttribute("errorMessage", "Invalid Student ID or Password.");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
        }
    }
}
