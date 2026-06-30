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
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

import java.io.File;
import java.io.IOException;

@WebServlet("/student-action")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2, // 2MB
    maxFileSize = 1024 * 1024 * 10,      // 10MB
    maxRequestSize = 1024 * 1024 * 50    // 50MB
)
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
                Part imagePart = request.getPart("imagePathFile");
                String imagePath = "images/default-project.jpg";
                if (imagePart != null && imagePart.getSize() > 0) {
                    String fileName = getSubmittedFileName(imagePart);
                    String uploadPath = getServletContext().getRealPath("") + File.separator + "images";
                    File uploadDir = new File(uploadPath);
                    if (!uploadDir.exists()) uploadDir.mkdir();
                    imagePart.write(uploadPath + File.separator + fileName);
                    imagePath = "images/" + fileName;
                }
                projectDAO.addProject(
                    studentId, 
                    request.getParameter("title"), 
                    request.getParameter("description"), 
                    request.getParameter("techStack"), 
                    request.getParameter("githubUrl"),
                    imagePath
                );
            } else if ("addSkill".equals(action)) {
                Skill s = new Skill();
                s.setStudentId(studentId);
                s.setCategory(request.getParameter("category"));
                s.setName(request.getParameter("name"));
                String prof = request.getParameter("proficiency");
                int pct = 0;
                if (prof != null && !prof.trim().isEmpty()) {
                    pct = Integer.parseInt(prof.trim());
                }
                s.setProficiencyPercent(pct);
                skillDAO.addSkill(s);
            } else if ("addClub".equals(action)) {
                Club c = new Club();
                c.setStudentId(studentId);
                c.setName(request.getParameter("name"));
                c.setRole(request.getParameter("role"));
                c.setDescription(request.getParameter("description"));
                clubDAO.addClub(c);
            } else if ("addCertificate".equals(action)) {
                Part filePart = request.getPart("file");
                String title = request.getParameter("title");
                String filePath = "certificates/uploaded.pdf"; // Fallback
                if (filePart != null && filePart.getSize() > 0) {
                    String fileName = getSubmittedFileName(filePart);
                    // Ensure the upload directory exists
                    String uploadPath = getServletContext().getRealPath("") + File.separator + "certificates";
                    File uploadDir = new File(uploadPath);
                    if (!uploadDir.exists()) uploadDir.mkdir();
                    
                    // Write file to disk
                    filePart.write(uploadPath + File.separator + fileName);
                    filePath = "certificates/" + fileName;
                }
                certificateDAO.addCertificate(studentId, title, filePath);
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/home?error=true");
            return;
        }

        response.sendRedirect(request.getContextPath() + "/home?success=true");
    }

    private String getSubmittedFileName(Part part) {
        for (String cd : part.getHeader("content-disposition").split(";")) {
            if (cd.trim().startsWith("filename")) {
                return cd.substring(cd.indexOf('=') + 1).trim().replace("\"", "");
            }
        }
        return "uploaded_file";
    }
}