package com.portfolio.dao;

import com.portfolio.model.LoginLog;
import com.portfolio.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 * Data-access object for the {@code login_logs} table.
 */
public class LoginLogDAO {

    /**
     * Inserts a new login audit record.
     *
     * @param userId    the ID of the user who logged in
     * @param userName  the display name of the user
     * @param role      the role of the user (e.g. "student", "admin")
     * @param ipAddress the remote IP address of the client
     */
    public void logLogin(int userId, String userName, String role, String ipAddress) {
        String sql = "INSERT INTO login_logs (user_id, user_name, role, ip_address) VALUES (?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, userId);
            ps.setString(2, userName);
            ps.setString(3, role);
            ps.setString(4, ipAddress);
            ps.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    /**
     * Retrieves all login log entries, most recent first.
     *
     * @return list of all login logs (never {@code null})
     */
    public List<LoginLog> getAllLogs() {
        List<LoginLog> logs = new ArrayList<>();
        String sql = "SELECT id, user_id, user_name, role, login_time, ip_address FROM login_logs ORDER BY login_time DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                LoginLog log = new LoginLog();
                log.setId(rs.getInt("id"));
                log.setUserId(rs.getInt("user_id"));
                log.setUserName(rs.getString("user_name"));
                log.setRole(rs.getString("role"));
                log.setLoginTime(rs.getTimestamp("login_time"));
                log.setIpAddress(rs.getString("ip_address"));
                logs.add(log);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return logs;
    }
}
