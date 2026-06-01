package com.portfolio.dao;

import com.portfolio.model.Project;
import com.portfolio.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 * Data-access object for the {@code projects} table.
 */
public class ProjectDAO {

    /**
     * Retrieves every project record from the database.
     *
     * @return list of all projects (never {@code null})
     */
    public List<Project> getAllProjects() {
        List<Project> projects = new ArrayList<>();
        String sql = "SELECT id, title, description, tech_stack, github_url, "
                   + "live_demo_url, image_path, student_id FROM projects";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                projects.add(mapRow(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return projects;
    }

    /**
     * Retrieves all projects belonging to a specific student.
     *
     * @param studentId the owning student's id
     * @return list of matching projects (never {@code null})
     */
    public List<Project> getProjectsByStudentId(int studentId) {
        List<Project> projects = new ArrayList<>();
        String sql = "SELECT id, title, description, tech_stack, github_url, "
                   + "live_demo_url, image_path, student_id FROM projects WHERE student_id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, studentId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    projects.add(mapRow(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return projects;
    }

    public int getProjectCount(int studentId) {
        String sql = "SELECT COUNT(*) FROM projects WHERE student_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, studentId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    // ── Helper ─────────────────────────────────────────────────────────

    private Project mapRow(ResultSet rs) throws SQLException {
        Project p = new Project();
        p.setId(rs.getInt("id"));
        p.setTitle(rs.getString("title"));
        p.setDescription(rs.getString("description"));
        p.setTechStack(rs.getString("tech_stack"));
        p.setGithubUrl(rs.getString("github_url"));
        p.setLiveDemoUrl(rs.getString("live_demo_url"));
        p.setImagePath(rs.getString("image_path"));
        p.setStudentId(rs.getInt("student_id"));
        return p;
    }
}
