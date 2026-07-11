package com.portfolio.util;

import java.nio.file.Files;
import java.nio.file.Paths;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class DBMigrator {

    public static void main(String[] args) {
        executeMigration();
    }

    public static void executeMigration() {
        System.out.println("Beginning database migration...");

        // Check if database is already migrated to avoid wiping data
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement("SELECT 1 FROM students LIMIT 1")) {
            try (ResultSet rs = ps.executeQuery()) {
                System.out.println("Database tables already exist. Skipping schema initialization to preserve data.");
                return;
            }
        } catch (SQLException e) {
            System.out.println("Students table not found. Proceeding with database schema initialization/migration...");
        }

        String content = null;

        // Try reading from classpath first (packaged inside the WAR)
        try (java.io.InputStream is = DBMigrator.class.getClassLoader().getResourceAsStream("schema.sql")) {
            if (is != null) {
                System.out.println("Reading schema from classpath (schema.sql)");
                content = new String(is.readAllBytes(), java.nio.charset.StandardCharsets.UTF_8);
            }
        } catch (java.io.IOException e) {
            System.err.println("Failed to read schema.sql from classpath: " + e.getMessage());
        }

        // Fallback to reading from local file system
        if (content == null) {
            String schemaPath = "schema.sql";
            System.out.println("Reading schema from file system fallback: " + schemaPath);
            try {
                content = new String(Files.readAllBytes(Paths.get(schemaPath)), java.nio.charset.StandardCharsets.UTF_8);
            } catch (java.io.IOException e) {
                System.err.println("Failed to read schema.sql from file system: " + e.getMessage());
                return;
            }
        }

        System.out.println("Connecting to database...");
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement()) {

            System.out.println("Connection successful. Executing migration...");

            // Clean comment lines first to prevent them from causing the parser to skip actual SQL queries
            StringBuilder sb = new StringBuilder();
            String[] lines = content.split("\\r?\\n");
            for (String line : lines) {
                String trimmed = line.trim();
                if (trimmed.startsWith("--") || trimmed.startsWith("/*") || trimmed.startsWith("#")) {
                    continue;
                }
                sb.append(line).append("\n");
            }
            content = sb.toString();

            // Split the script by semicolon + newline
            String[] queries = content.split(";\\r?\\n");
            for (String query : queries) {
                query = query.trim();
                if (query.isEmpty()) {
                    continue;
                }
                try {
                    System.out.println("Executing query: " + (query.length() > 80 ? query.substring(0, 80) + "..." : query));
                    stmt.execute(query);
                } catch (SQLException e) {
                    System.err.println("Warning: Query failed: " + query);
                    System.err.println("Error details: " + e.getMessage());
                }
            }

            System.out.println("Database migration completed successfully!");

        } catch (SQLException e) {
            System.err.println("Database error occurred during migration: " + e.getMessage());
        }
    }
}
