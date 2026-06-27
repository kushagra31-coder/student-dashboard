package com.portfolio.dao;

import com.portfolio.model.Club;
import com.portfolio.util.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ClubDAO {

    public List<Club> getClubsByStudentId(int studentId) {
        List<Club> clubs = new ArrayList<>();
        String sql = "SELECT * FROM clubs WHERE student_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, studentId);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                clubs.add(new Club(
                    rs.getInt("id"),
                    rs.getInt("student_id"),
                    rs.getString("name"),
                    rs.getString("role"),
                    rs.getString("description")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return clubs;
    }

    public boolean addClub(Club club) {
        String sql = "INSERT INTO clubs (student_id, name, role, description) VALUES (?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, club.getStudentId());
            stmt.setString(2, club.getName());
            stmt.setString(3, club.getRole());
            stmt.setString(4, club.getDescription());
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}
