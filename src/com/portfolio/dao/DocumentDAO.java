package com.portfolio.dao;

import com.portfolio.model.Document;
import com.portfolio.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class DocumentDAO {

    public List<Document> getDocumentsByStudentId(int studentId) {
        List<Document> documents = new ArrayList<>();
        String sql = "SELECT id, student_id, title, file_path, upload_date FROM documents WHERE student_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, studentId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    documents.add(mapRow(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return documents;
    }

    public int getDocumentCount(int studentId) {
        String sql = "SELECT COUNT(*) FROM documents WHERE student_id = ?";
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

    /**
     * Retrieves all document records across all students (for admin use).
     *
     * @return list of all documents (never {@code null})
     */
    public List<Document> getAllDocuments() {
        List<Document> documents = new ArrayList<>();
        String sql = "SELECT id, student_id, title, file_path, upload_date FROM documents";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                documents.add(mapRow(rs));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return documents;
    }

    // ── Helper ─────────────────────────────────────────────────────────

    private Document mapRow(ResultSet rs) throws SQLException {
        Document d = new Document();
        d.setId(rs.getInt("id"));
        d.setStudentId(rs.getInt("student_id"));
        d.setTitle(rs.getString("title"));
        d.setFilePath(rs.getString("file_path"));
        d.setUploadDate(rs.getDate("upload_date"));
        return d;
    }
}
