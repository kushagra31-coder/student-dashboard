package com.portfolio.dao;

import com.portfolio.model.Attendance;
import com.portfolio.util.DBConnection;
import java.sql.*;
import java.util.*;

/**
 * DAO for attendance management.
 * Subjects: ADA, ADC, DOTNET, DBMS, COA  (RGPV 4th Sem CSIT)
 */
public class AttendanceDAO {

    public static final List<String> SUBJECTS = Arrays.asList(
            "ADA", "ADC M3", "DOTNET", "DBMS", "COA"
    );

    public Map<String, Attendance> getAttendanceByStudentId(int studentId) {
        Map<String, Attendance> map = new LinkedHashMap<>();
        String sql = "SELECT * FROM attendance WHERE student_id = ? ORDER BY subject";
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, studentId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Attendance a = mapRow(rs);
                    map.put(a.getSubject(), a);
                }
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return map;
    }

    /**
     * All attendance rows for ALL students.
     * Returns Map<studentId, Map<subject, Attendance>>
     */
    public Map<Integer, Map<String, Attendance>> getAllAttendanceGrouped() {
        Map<Integer, Map<String, Attendance>> result = new LinkedHashMap<>();
        String sql = "SELECT * FROM attendance ORDER BY student_id, subject";
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Attendance a = mapRow(rs);
                result.computeIfAbsent(a.getStudentId(), k -> new LinkedHashMap<>())
                      .put(a.getSubject(), a);
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return result;
    }

    // ── Write ─────────────────────────────────────────────────────────────

    /** Insert a new attendance row. */
    public boolean insertAttendance(Attendance a) {
        String sql = "INSERT INTO attendance (student_id, subject, total_classes, attended, percentage) "
                   + "VALUES (?, ?, ?, ?, ?) "
                   + "ON DUPLICATE KEY UPDATE total_classes=VALUES(total_classes), "
                   + "attended=VALUES(attended), percentage=VALUES(percentage)";
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, a.getStudentId());
            ps.setString(2, a.getSubject());
            ps.setInt(3, a.getTotalClasses());
            ps.setInt(4, a.getAttended());
            ps.setDouble(5, calcPercent(a.getTotalClasses(), a.getAttended()));
            return ps.executeUpdate() > 0;
        } catch (SQLException e) { e.printStackTrace(); }
        return false;
    }

    /** Update attended count (and recalculates percentage). */
    public boolean updateAttendance(int studentId, String subject, int totalClasses, int attended) {
        String sql = "UPDATE attendance SET total_classes=?, attended=?, percentage=? "
                   + "WHERE student_id=? AND subject=?";
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, totalClasses);
            ps.setInt(2, attended);
            ps.setDouble(3, calcPercent(totalClasses, attended));
            ps.setInt(4, studentId);
            ps.setString(5, subject);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) { e.printStackTrace(); }
        return false;
    }

    /**
     * Seeds random attendance for all students who have no attendance record.
     * Called once by AdminServlet on first load.
     */
    public void seedRandomAttendanceIfMissing(List<Integer> studentIds) {
        Random rand = new Random();
        String checkSql = "SELECT COUNT(*) FROM attendance WHERE student_id=? AND subject=?";
        String insertSql = "INSERT INTO attendance (student_id, subject, total_classes, attended, percentage) "
                         + "VALUES (?, ?, ?, ?, ?)";

        try (Connection c = DBConnection.getConnection();
             PreparedStatement check = c.prepareStatement(checkSql);
             PreparedStatement insert = c.prepareStatement(insertSql)) {

            for (int sid : studentIds) {
                for (String subject : SUBJECTS) {
                    check.setInt(1, sid);
                    check.setString(2, subject);
                    try (ResultSet rs = check.executeQuery()) {
                        if (rs.next() && rs.getInt(1) == 0) {
                            int total    = 35 + rand.nextInt(16);   // 35–50 total classes
                            int attended = (int)(total * (0.55 + rand.nextDouble() * 0.40)); // 55–95%
                            attended = Math.min(attended, total);
                            insert.setInt(1, sid);
                            insert.setString(2, subject);
                            insert.setInt(3, total);
                            insert.setInt(4, attended);
                            insert.setDouble(5, calcPercent(total, attended));
                            insert.executeUpdate();
                        }
                    }
                }
            }
        } catch (SQLException e) { e.printStackTrace(); }
    }

    // ── Helpers ──────────────────────────────────────────────────────────

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

    private double calcPercent(int total, int attended) {
        return total == 0 ? 0.0 : Math.round((attended * 100.0 / total) * 10.0) / 10.0;
    }
}
