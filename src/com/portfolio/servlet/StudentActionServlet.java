package com.portfolio.servlet;

import com.portfolio.dao.ClubDAO;
import com.portfolio.dao.DocumentDAO;
import com.portfolio.dao.ProjectDAO;
import com.portfolio.dao.SkillDAO;
import com.portfolio.dao.CertificateDAO;
import com.portfolio.model.Club;
import com.portfolio.model.Document;
import com.portfolio.model.Project;
import com.portfolio.model.Skill;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/student-action")
public class StudentActionServlet extends HttpServlet {

    private final ProjectDAO projectDAO = new ProjectDAO();
    private final DocumentDAO documentDAO = new DocumentDAO();
    private final SkillDAO skillDAO = new SkillDAO();
    private final ClubDAO clubDAO = new ClubDAO();
    private final CertificateDAO certificateDAO = new CertificateDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("studentId") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        int studentId = (Integer) session.getAttribute("studentId");
        String action = request.getParameter("action");

        try {
            if ("addProject".equals(action)) {
                projectDAO.addProject(
                    studentId, 
                    request.getParameter("title"), 
                    request.getParameter("description"), 
                    request.getParameter("techStack"), 
                    request.getParameter("githubUrl")
                );
            } else if ("addDocument".equals(action)) {
                documentDAO.addDocument(
                    studentId, 
                    request.getParameter("title"), 
                    request.getParameter("filePath") != null ? request.getParameter("filePath") : "documents/uploaded.pdf"
                );
            } else if ("addSkill".equals(action)) {
                Skill s = new Skill();
                s.setStudentId(studentId);
                s.setCategory(request.getParameter("category"));
                s.setName(request.getParameter("name"));
                s.setProficiencyPercent(Integer.parseInt(request.getParameter("proficiency")));
                skillDAO.addSkill(s);
            } else if ("addClub".equals(action)) {
                Club c = new Club();
                c.setStudentId(studentId);
                c.setName(request.getParameter("name"));
                c.setRole(request.getParameter("role"));
                c.setDescription(request.getParameter("description"));
                clubDAO.addClub(c);
            } else if ("addCertificate".equals(action)) {
                certificateDAO.addCertificate(
                    studentId,
                    request.getParameter("title"),
                    request.getParameter("filePath") != null ? request.getParameter("filePath") : "certificates/uploaded.pdf"
                );
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        response.sendRedirect(request.getContextPath() + "/home?success=true");
    }
}
