package com.portfolio.dao;

import com.portfolio.model.Skill;
import com.portfolio.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 * Data-access object for the {@code skills} table.
 */
public class SkillDAO {

    /**
     * Retrieves every skill record from the database.
     *
     * @return list of all skills (never {@code null})
     */
    public List<Skill> getAllSkills() {
        List<Skill> skills = new ArrayList<>();
        String sql = "SELECT id, category, name, proficiency_percent FROM skills";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                skills.add(mapRow(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return skills;
    }

    /**
     * Retrieves all skills belonging to a given category.
     *
     * @param category the skill category (e.g. "Frontend", "Backend")
     * @return list of matching skills (never {@code null})
     */
    public List<Skill> getSkillsByCategory(String category) {
        List<Skill> skills = new ArrayList<>();
        String sql = "SELECT id, category, name, proficiency_percent FROM skills WHERE category = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, category);
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

    // ── Helper ─────────────────────────────────────────────────────────

    private Skill mapRow(ResultSet rs) throws SQLException {
        Skill s = new Skill();
        s.setId(rs.getInt("id"));
        s.setCategory(rs.getString("category"));
        s.setName(rs.getString("name"));
        s.setProficiencyPercent(rs.getInt("proficiency_percent"));
        return s;
    }
}
