package com.portfolio.servlet;

import com.portfolio.dao.AttendanceDAO;
import com.portfolio.dao.ClubDAO;
import com.portfolio.dao.DocumentDAO;
import com.portfolio.dao.LoginLogDAO;
import com.portfolio.dao.ProjectDAO;
import com.portfolio.dao.SkillDAO;
import com.portfolio.dao.StudentDAO;
import com.portfolio.model.Attendance;
import com.portfolio.model.Certificate;
import com.portfolio.model.Club;
import com.portfolio.model.Document;
import com.portfolio.model.LoginLog;
import com.portfolio.model.Project;
import com.portfolio.model.Skill;
import com.portfolio.model.Student;
import com.portfolio.dao.CertificateDAO;

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
import java.util.stream.Collectors;

@WebServlet("/admin")
public class AdminServlet extends HttpServlet {

    private final StudentDAO     studentDAO     = new StudentDAO();
    private final LoginLogDAO    loginLogDAO    = new LoginLogDAO();
    private final DocumentDAO    documentDAO    = new DocumentDAO();
    private final ProjectDAO     projectDAO     = new ProjectDAO();
    private final SkillDAO       skillDAO       = new SkillDAO();
    private final ClubDAO        clubDAO        = new ClubDAO();
    private final CertificateDAO certificateDAO = new CertificateDAO();
    private final AttendanceDAO  attendanceDAO  = new AttendanceDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("studentId") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        if (!"admin".equals(session.getAttribute("studentRole"))) {
            response.sendRedirect(request.getContextPath() + "/home");
            return;
        }

        // ── Students only (no admins in student list) ──────────────────
        List<Student> students = studentDAO.getStudentsOnly();
        List<Integer> studentIds = students.stream()
                                           .map(Student::getId)
                                           .collect(Collectors.toList());

        // ── Seed random attendance if any student has none ─────────────
        attendanceDAO.seedRandomAttendanceIfMissing(studentIds);

        // ── Per-student data maps ──────────────────────────────────────
        Map<Integer, List<Project>>     studentProjects     = new HashMap<>();
        Map<Integer, List<Document>>    studentDocuments    = new HashMap<>();
        Map<Integer, List<Skill>>       studentSkills       = new HashMap<>();
        Map<Integer, List<Club>>        studentClubs        = new HashMap<>();
        Map<Integer, List<Certificate>> studentCertificates = new HashMap<>();

        for (Student s : students) {
            int sid = s.getId();
            studentProjects.put(sid,     projectDAO.getProjectsByStudentId(sid));
            studentDocuments.put(sid,    documentDAO.getDocumentsByStudentId(sid));
            studentSkills.put(sid,       skillDAO.getSkillsByStudentId(sid));
            studentClubs.put(sid,        clubDAO.getClubsByStudentId(sid));
            studentCertificates.put(sid, certificateDAO.getCertificatesByStudentId(sid));
        }

        // ── Attendance (all students, all subjects) ────────────────────
        Map<Integer, Map<String, Attendance>> allAttendance =
                attendanceDAO.getAllAttendanceGrouped();

        List<LoginLog> loginLogs = loginLogDAO.getAllLogs();

        // ── Set attributes ────────────────────────────────────────────
        request.setAttribute("students",            students);
        request.setAttribute("loginLogs",           loginLogs);
        request.setAttribute("studentProjects",     studentProjects);
        request.setAttribute("studentDocuments",    studentDocuments);
        request.setAttribute("studentSkills",       studentSkills);
        request.setAttribute("studentClubs",        studentClubs);
        request.setAttribute("studentCertificates", studentCertificates);
        request.setAttribute("allAttendance",       allAttendance);
        request.setAttribute("subjects",            AttendanceDAO.SUBJECTS);
        request.setAttribute("activeTab",           request.getParameter("tab") != null
                                                    ? request.getParameter("tab") : "students");

        request.getRequestDispatcher("/admin.jsp").forward(request, response);
    }
}
