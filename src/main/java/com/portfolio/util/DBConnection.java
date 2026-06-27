package com.portfolio.util;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;

public class DBConnection {

    private static final String URL;
    private static final String USER;
    private static final String PASS;

    static {
        try {
            Properties props = new Properties();

            try (InputStream input = DBConnection.class
                    .getClassLoader()
                    .getResourceAsStream("db.properties")) {

                if (input == null) {
                    throw new RuntimeException("db.properties not found");
                }

                props.load(input);

                URL = props.getProperty("db.url");
                USER = props.getProperty("db.username");
                PASS = props.getProperty("db.password");
            }

            Class.forName("com.mysql.cj.jdbc.Driver");

        } catch (IOException | ClassNotFoundException e) {
            throw new RuntimeException("Failed to load database configuration.", e);
        }
    }

    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(URL, USER, PASS);
    }

    private DBConnection() {
    }
}