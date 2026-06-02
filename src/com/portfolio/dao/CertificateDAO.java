package com.portfolio.dao;

import com.portfolio.model.Certificate;
import com.portfolio.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class CertificateDAO {

    public List<Certificate> getCertificatesByStudentId(int studentId) {
        List<Certificate> certificates = new ArrayList<>();
        String sql = "SELECT id, student_id, title, file_path, issue_date FROM certificates WHERE student_id = ? ORDER BY issue_date DESC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, studentId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    certificates.add(mapRow(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return certificates;
    }

    public void addCertificate(int studentId, String title, String filePath) {
        String sql = "INSERT INTO certificates (student_id, title, file_path) VALUES (?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, studentId);
            ps.setString(2, title);
            ps.setString(3, filePath);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    private Certificate mapRow(ResultSet rs) throws SQLException {
        Certificate c = new Certificate();
        c.setId(rs.getInt("id"));
        c.setStudentId(rs.getInt("student_id"));
        c.setTitle(rs.getString("title"));
        c.setFilePath(rs.getString("file_path"));
        c.setIssueDate(rs.getTimestamp("issue_date"));
        return c;
    }
}
