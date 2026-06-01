package com.portfolio.dao;

import com.portfolio.model.Achievement;
import com.portfolio.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class AchievementDAO {

    public List<Achievement> getAchievementsByStudentId(int studentId) {
        List<Achievement> achievements = new ArrayList<>();
        String sql = "SELECT id, student_id, title, description, date_achieved, icon FROM achievements WHERE student_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, studentId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Achievement a = new Achievement();
                    a.setId(rs.getInt("id"));
                    a.setStudentId(rs.getInt("student_id"));
                    a.setTitle(rs.getString("title"));
                    a.setDescription(rs.getString("description"));
                    a.setDateAchieved(rs.getDate("date_achieved"));
                    a.setIcon(rs.getString("icon"));
                    achievements.add(a);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return achievements;
    }

    public int getAchievementCount(int studentId) {
        String sql = "SELECT COUNT(*) FROM achievements WHERE student_id = ?";
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
}
