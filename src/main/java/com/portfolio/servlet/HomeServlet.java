package com.portfolio.servlet;

import com.portfolio.dao.AchievementDAO;
import com.portfolio.dao.AttendanceDAO;
import com.portfolio.dao.ClubDAO;
import com.portfolio.dao.DocumentDAO;
import com.portfolio.dao.ProjectDAO;
import com.portfolio.dao.SkillDAO;
import com.portfolio.dao.StudentDAO;
import com.portfolio.dao.CertificateDAO;
import com.portfolio.model.Achievement;
import com.portfolio.model.Attendance;
import com.portfolio.model.Project;
import com.portfolio.model.Student;
import com.portfolio.model.Certificate;
import com.portfolio.model.Club;
import com.portfolio.model.Skill;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;
import java.util.Map;

@WebServlet(name = "HomeServlet", urlPatterns = {"/home", ""})
public class HomeServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private final StudentDAO     studentDAO     = new StudentDAO();
    private final ProjectDAO     projectDAO     = new ProjectDAO();
    private final AchievementDAO achievementDAO = new AchievementDAO();
    private final DocumentDAO    documentDAO    = new DocumentDAO();
    private final CertificateDAO certificateDAO = new CertificateDAO();
    private final SkillDAO       skillDAO       = new SkillDAO();
    private final ClubDAO        clubDAO        = new ClubDAO();
    private final AttendanceDAO  attendanceDAO  = new AttendanceDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("studentId") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        int studentId = (Integer) session.getAttribute("studentId");

        Student           student      = studentDAO.getStudentById(studentId);
        List<Project>     projects     = projectDAO.getProjectsByStudentId(studentId);
        List<Achievement> achievements = achievementDAO.getAchievementsByStudentId(studentId);
        List<Certificate> certificates = certificateDAO.getCertificatesByStudentId(studentId);
        List<Skill>       skills       = skillDAO.getSkillsByStudentId(studentId);
        List<Club>        clubs        = clubDAO.getClubsByStudentId(studentId);
        Map<String, Attendance> attendance = attendanceDAO.getAttendanceByStudentId(studentId);

        request.setAttribute("currentPage",       "home");
        request.setAttribute("student",           student);
        request.setAttribute("projects",          projects);
        request.setAttribute("achievements",      achievements);
        request.setAttribute("certificates",      certificates);
        request.setAttribute("skills",            skills);
        request.setAttribute("clubs",             clubs);
        request.setAttribute("attendance",        attendance);
        request.setAttribute("projectsCount",     projects.size());
        request.setAttribute("documentsCount",    documentDAO.getDocumentCount(studentId));
        request.setAttribute("certificatesCount", certificates.size());
        request.setAttribute("skillsCount",       skills.size());

        request.getRequestDispatcher("/home.jsp").forward(request, response);
    }
}
