package com.portfolio.util;

import java.sql.Connection;
import java.sql.Statement;

public class ClearDB {
    public static void main(String[] args) {
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement()) {
            
            // Delete all records from dependent tables first if foreign keys exist
            // (Assuming cascade delete might not be on for everything, but let's try just deleting students)
            // It's safer to delete all tables' data to start fresh for a security wipe
            
            stmt.executeUpdate("DELETE FROM login_logs");
            stmt.executeUpdate("DELETE FROM achievements");
            stmt.executeUpdate("DELETE FROM documents");
            stmt.executeUpdate("DELETE FROM projects");
            stmt.executeUpdate("DELETE FROM skills");
            stmt.executeUpdate("DELETE FROM certificates");
            stmt.executeUpdate("DELETE FROM clubs");
            stmt.executeUpdate("DELETE FROM attendance");
            stmt.executeUpdate("DELETE FROM students");
            
            System.out.println("All old plaintext password users and their data have been securely wiped.");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}