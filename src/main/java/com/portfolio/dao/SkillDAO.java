package com.portfolio.dao;

import com.portfolio.model.Skill;
import com.portfolio.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class SkillDAO {

    public List<Skill> getSkillsByStudentId(int studentId) {
        List<Skill> skills = new ArrayList<>();
        String sql = "SELECT id, student_id, category, name, proficiency_percent FROM skills WHERE student_id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, studentId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    skills.add(mapRow(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return skills;
    }

    public boolean addSkill(Skill skill) {
        String sql = "INSERT INTO skills (student_id, category, name, proficiency_percent) VALUES (?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, skill.getStudentId());
            stmt.setString(2, skill.getCategory());
            stmt.setString(3, skill.getName());
            stmt.setInt(4, skill.getProficiencyPercent());
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    private Skill mapRow(ResultSet rs) throws SQLException {
        Skill s = new Skill();
        s.setId(rs.getInt("id"));
        s.setStudentId(rs.getInt("student_id"));
        s.setCategory(rs.getString("category"));
        s.setName(rs.getString("name"));
        s.setProficiencyPercent(rs.getInt("proficiency_percent"));
        return s;
    }
}
