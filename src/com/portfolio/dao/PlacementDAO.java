package com.portfolio.dao;

import com.portfolio.model.Placement;
import com.portfolio.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 * Data-access object for the {@code placements} table.
 */
public class PlacementDAO {

    /**
     * Retrieves all placement records for a specific student.
     *
     * @param studentId the student's ID
     * @return list of placements for the student (never {@code null})
     */
    public List<Placement> getPlacementsByStudentId(int studentId) {
        List<Placement> placements = new ArrayList<>();
        String sql = "SELECT id, student_id, company, role, package_lpa, status, date_placed "
                   + "FROM placements WHERE student_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, studentId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    placements.add(mapRow(rs));
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return placements;
    }

    /**
     * Retrieves all placement records across all students.
     *
     * @return list of all placements (never {@code null})
     */
    public List<Placement> getAllPlacements() {
        List<Placement> placements = new ArrayList<>();
        String sql = "SELECT id, student_id, company, role, package_lpa, status, date_placed FROM placements";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                placements.add(mapRow(rs));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return placements;
    }

    // ── Helper ─────────────────────────────────────────────────────────

    private Placement mapRow(ResultSet rs) throws SQLException {
        Placement p = new Placement();
        p.setId(rs.getInt("id"));
        p.setStudentId(rs.getInt("student_id"));
        p.setCompany(rs.getString("company"));
        p.setRole(rs.getString("role"));
        p.setPackageLpa(rs.getDouble("package_lpa"));
        p.setStatus(rs.getString("status"));
        p.setDatePlaced(rs.getDate("date_placed"));
        return p;
    }
}
