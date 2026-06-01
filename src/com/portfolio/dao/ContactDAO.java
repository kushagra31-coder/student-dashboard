package com.portfolio.dao;

import com.portfolio.model.ContactMessage;
import com.portfolio.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

/**
 * Data-access object for the {@code contact_messages} table.
 */
public class ContactDAO {

    /**
     * Persists a new contact-form submission to the database.
     * <p>
     * The {@code created_at} column is left to the database default
     * ({@code CURRENT_TIMESTAMP}) so callers do not need to set it.
     *
     * @param msg the message to save (id and createdAt are ignored)
     * @return {@code true} if exactly one row was inserted
     */
    public boolean saveMessage(ContactMessage msg) {
        String sql = "INSERT INTO contact_messages (name, email, subject, message) "
                   + "VALUES (?, ?, ?, ?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, msg.getName());
            ps.setString(2, msg.getEmail());
            ps.setString(3, msg.getSubject());
            ps.setString(4, msg.getMessage());

            int rowsInserted = ps.executeUpdate();
            return rowsInserted > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}
