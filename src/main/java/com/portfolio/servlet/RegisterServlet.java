package com.portfolio.servlet;

import com.portfolio.dao.StudentDAO;
import com.portfolio.model.Student;
import org.mindrot.jbcrypt.BCrypt;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

    private final StudentDAO studentDAO = new StudentDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/register.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String name        = trim(request.getParameter("name"));
        String email       = trim(request.getParameter("email"));
        String branch      = trim(request.getParameter("branch"));
        String semesterStr = trim(request.getParameter("semester"));
        String phone       = trim(request.getParameter("phone"));
        String password    = request.getParameter("password");
        String confirmPwd  = request.getParameter("confirmPassword");

        // ── Validation ──────────────────────────────────────────────────────
        String error = null;

        if (name.isEmpty() || email.isEmpty() || branch.isEmpty()
                || semesterStr.isEmpty() || password == null || password.isEmpty()) {
            error = "All required fields must be filled in.";
        } else if (password.length() < 6) {
            error = "Password must be at least 6 characters long.";
        } else if (!password.equals(confirmPwd)) {
            error = "Passwords do not match. Please try again.";
        }

        int semester = 1;
        if (error == null) {
            try {
                semester = Integer.parseInt(semesterStr);
                if (semester < 1 || semester > 8) {
                    error = "Semester must be between 1 and 8.";
                }
            } catch (NumberFormatException e) {
                error = "Invalid semester value.";
            }
        }

        if (error != null) {
            // Re-populate form fields so the user doesn't lose their inputs
            request.setAttribute("errorMessage", error);
            request.setAttribute("prevName",     name);
            request.setAttribute("prevEmail",    email);
            request.setAttribute("prevBranch",   branch);
            request.setAttribute("prevSemester", semesterStr);
            request.setAttribute("prevPhone",    phone);
            request.getRequestDispatcher("/register.jsp").forward(request, response);
            return;
        }

        // ── Build and save the student ───────────────────────────────────────
        Student student = new Student();
        student.setName(name);
        student.setEmail(email);
        student.setBranch(branch);
        student.setSemester(semester);
        student.setPhone(phone);
        student.setPassword(BCrypt.hashpw(password, BCrypt.gensalt()));
        student.setRole("student");
        student.setBio("");
        student.setGithubUrl("");
        student.setLinkedinUrl("");
        student.setResumeUrl("");
        student.setPhotoPath("images/default-avatar.png");

        int generatedId = studentDAO.registerStudent(student);

        if (generatedId <= 0) {
            request.setAttribute("errorMessage", "Registration failed. Please try again.");
            request.setAttribute("prevName",     name);
            request.setAttribute("prevEmail",    email);
            request.setAttribute("prevBranch",   branch);
            request.setAttribute("prevSemester", semesterStr);
            request.setAttribute("prevPhone",    phone);
            request.getRequestDispatcher("/register.jsp").forward(request, response);
            return;
        }

        // ── Success ──────────────────────────────────────────────────────────
        request.setAttribute("success",     true);
        request.setAttribute("generatedId", generatedId);
        request.setAttribute("studentName", name);
        request.getRequestDispatcher("/register.jsp").forward(request, response);
    }

    private String trim(String s) {
        return (s == null) ? "" : s.trim();
    }
}
