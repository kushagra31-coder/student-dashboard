package com.portfolio.util;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Statement;

public class DBMigrator {

    public static void main(String[] args) {
        String schemaPath = "schema.sql";
        System.out.println("Reading schema from: " + schemaPath);

        String content;
        try {
            content = new String(Files.readAllBytes(Paths.get(schemaPath)));
        } catch (IOException e) {
            System.err.println("Failed to read schema.sql: " + e.getMessage());
            return;
        }

        System.out.println("Connecting to database...");
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement()) {

            System.out.println("Connection successful. Executing migration...");

            // Split the script by semicolon + newline
            String[] queries = content.split(";\\r?\\n");
            for (String query : queries) {
                query = query.trim();
                if (query.isEmpty() || query.startsWith("--") || query.startsWith("/*")) {
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
