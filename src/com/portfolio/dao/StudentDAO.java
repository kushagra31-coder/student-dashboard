package com.portfolio.dao;

import com.portfolio.model.Student;
import com.portfolio.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 * Data-access object for the {@code students} table.
 */
public class StudentDAO {

    /**
     * Retrieves every student record from the database.
     *
     * @return list of all students (never {@code null})
     */
    public List<Student> getAllStudents() {
        List<Student> students = new ArrayList<>();
        String sql = "SELECT id, name, branch, role, bio, github_url, "
                   + "linkedin_url, resume_url, photo_path, password, semester FROM students";

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
     * Retrieves a single student by primary key.
     *
     * @param id the student id
     * @return the matching {@link Student}, or {@code null} if not found
     */
    public Student getStudentById(int id) {
        String sql = "SELECT id, name, branch, role, bio, github_url, "
                   + "linkedin_url, resume_url, photo_path, password, semester FROM students WHERE id = ?";

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
    public Student authenticate(int id, String password) {
        String sql = "SELECT id, name, branch, role, bio, github_url, "
                   + "linkedin_url, resume_url, photo_path, password, semester FROM students WHERE id = ? AND password = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);
            ps.setString(2, password);
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
        return s;
    }
}
