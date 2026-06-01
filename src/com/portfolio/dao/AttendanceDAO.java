package com.portfolio.dao;

import com.portfolio.model.Attendance;
import com.portfolio.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 * Data-access object for the {@code attendance} table.
 */
public class AttendanceDAO {

    /**
     * Retrieves all attendance records for a specific student.
     *
     * @param studentId the student's ID
     * @return list of attendance records for the student (never {@code null})
     */
    public List<Attendance> getAttendanceByStudentId(int studentId) {
        List<Attendance> records = new ArrayList<>();
        String sql = "SELECT id, student_id, subject, total_classes, attended, percentage "
                   + "FROM attendance WHERE student_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, studentId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    records.add(mapRow(rs));
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return records;
    }

    /**
     * Retrieves all attendance records across all students.
     *
     * @return list of all attendance records (never {@code null})
     */
    public List<Attendance> getAllAttendance() {
        List<Attendance> records = new ArrayList<>();
        String sql = "SELECT id, student_id, subject, total_classes, attended, percentage FROM attendance";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                records.add(mapRow(rs));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return records;
    }

    // ── Helper ─────────────────────────────────────────────────────────

    private Attendance mapRow(ResultSet rs) throws SQLException {
        Attendance a = new Attendance();
        a.setId(rs.getInt("id"));
        a.setStudentId(rs.getInt("student_id"));
        a.setSubject(rs.getString("subject"));
        a.setTotalClasses(rs.getInt("total_classes"));
        a.setAttended(rs.getInt("attended"));
        a.setPercentage(rs.getDouble("percentage"));
        return a;
    }
}
