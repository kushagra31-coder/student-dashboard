package com.portfolio.servlet;

import com.portfolio.dao.StudentDAO;
import com.portfolio.model.Student;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

/**
 * Serves the students listing page.
 */
@WebServlet(name = "StudentsServlet", urlPatterns = {"/students"})
public class StudentsServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private final StudentDAO studentDAO = new StudentDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Student> students = studentDAO.getAllStudents();
        request.setAttribute("currentPage", "students");
        request.setAttribute("students", students);

        request.getRequestDispatcher("/students.jsp").forward(request, response);
    }
}
