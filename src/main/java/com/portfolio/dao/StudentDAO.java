package com.portfolio.dao;

import com.portfolio.model.Student;
import com.portfolio.util.DBConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;


public class StudentDAO {

    
    public List<Student> getAllStudents() {
        List<Student> students = new ArrayList<>();
        String sql = "SELECT id, name, branch, role, bio, github_url, "
                   + "linkedin_url, resume_url, photo_path, password, semester, email, phone FROM students";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                students.add(mapRow(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return students;
    }

    /**
     * Returns only students with role = 'student' (excludes admin accounts).
     */
    public List<Student> getStudentsOnly() {
        List<Student> students = new ArrayList<>();
        String sql = "SELECT id, name, branch, role, bio, github_url, "
                   + "linkedin_url, resume_url, photo_path, password, semester, email, phone "
                   + "FROM students WHERE role = 'student' ORDER BY name";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                students.add(mapRow(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return students;
    }

    /**
     * Delete a student by ID.
     */
    public boolean deleteStudent(int id) {
        String sql = "DELETE FROM students WHERE id = ? AND role = 'student'";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }


    /**
     * Retrieves a single student by primary key.
     *
     * @param id the student id
     * @return the matching {@link Student}, or {@code null} if not found
     */
    public Student getStudentById(int id) {
        String sql = "SELECT id, name, branch, role, bio, github_url, "
                   + "linkedin_url, resume_url, photo_path, password, semester, email, phone FROM students WHERE id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapRow(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    /**
     * Authenticates a student by id and password.
     *
     * @param id the student id
     * @param password the password
     * @return the matching {@link Student}, or {@code null} if invalid
     */
    public Student authenticate(String identifier, String password) {
        if (identifier == null || password == null || identifier.trim().isEmpty()) {
            return null;
        }
        identifier = identifier.trim();
        boolean isNumeric = identifier.matches("\\d+");

        String sql;
        if (isNumeric) {
            sql = "SELECT id, name, branch, role, bio, github_url, "
                + "linkedin_url, resume_url, photo_path, password, semester, email, phone FROM students "
                + "WHERE (id = ? OR email = ?) AND password = ?";
        } else {
            sql = "SELECT id, name, branch, role, bio, github_url, "
                + "linkedin_url, resume_url, photo_path, password, semester, email, phone FROM students "
                + "WHERE email = ? AND password = ?";
        }

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            if (isNumeric) {
                ps.setInt(1, Integer.parseInt(identifier));
                ps.setString(2, identifier);
                ps.setString(3, password);
            } else {
                ps.setString(1, identifier);
                ps.setString(2, password);
            }
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapRow(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // ── Helper ─────────────────────────────────────────────────────────

    private Student mapRow(ResultSet rs) throws SQLException {
        Student s = new Student();
        s.setId(rs.getInt("id"));
        s.setName(rs.getString("name"));
        s.setBranch(rs.getString("branch"));
        s.setRole(rs.getString("role"));
        s.setBio(rs.getString("bio"));
        s.setGithubUrl(rs.getString("github_url"));
        s.setLinkedinUrl(rs.getString("linkedin_url"));
        s.setResumeUrl(rs.getString("resume_url"));
        s.setPhotoPath(rs.getString("photo_path"));
        s.setPassword(rs.getString("password"));
        s.setSemester(rs.getInt("semester"));
        s.setEmail(rs.getString("email"));
        s.setPhone(rs.getString("phone"));
        return s;
    }

    /**
     * Registers a new student and returns the auto-generated primary key ID.
     *
     * @param student the student to register (name, email, branch, semester, phone, password)
     * @return the generated student ID, or -1 if insertion failed
     */
    public int registerStudent(Student student) {
        String sql = "INSERT INTO students (name, email, branch, semester, phone, password, role, "
                   + "bio, github_url, linkedin_url, resume_url, photo_path) "
                   + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (java.sql.Connection conn = DBConnection.getConnection();
             java.sql.PreparedStatement ps = conn.prepareStatement(sql,
                     java.sql.Statement.RETURN_GENERATED_KEYS)) {

            ps.setString(1, student.getName());
            ps.setString(2, student.getEmail());
            ps.setString(3, student.getBranch());
            ps.setInt(4, student.getSemester());
            ps.setString(5, student.getPhone());
            ps.setString(6, student.getPassword());
            ps.setString(7, student.getRole());
            ps.setString(8, student.getBio());
            ps.setString(9, student.getGithubUrl());
            ps.setString(10, student.getLinkedinUrl());
            ps.setString(11, student.getResumeUrl());
            ps.setString(12, student.getPhotoPath());

            int rows = ps.executeUpdate();
            if (rows > 0) {
                try (java.sql.ResultSet keys = ps.getGeneratedKeys()) {
                    if (keys.next()) {
                        return keys.getInt(1);
                    }
                }
            }
        } catch (java.sql.SQLException e) {
            e.printStackTrace();
        }
        return -1;
    }
}
