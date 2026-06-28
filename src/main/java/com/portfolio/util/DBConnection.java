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
            boolean propsLoaded = false;

            try (InputStream input = DBConnection.class
                    .getClassLoader()
                    .getResourceAsStream("db.properties")) {

                if (input != null) {
                    props.load(input);
                    propsLoaded = true;
                }
            }

            String envUrl = System.getenv("DB_URL");
            String envUser = System.getenv("DB_USERNAME");
            if (envUser == null) {
                envUser = System.getenv("DB_USER");
            }
            String envPass = System.getenv("DB_PASSWORD");
            if (envPass == null) {
                envPass = System.getenv("DB_PASS");
            }

            URL = (envUrl != null) ? envUrl : (propsLoaded ? props.getProperty("db.url") : null);
            USER = (envUser != null) ? envUser : (propsLoaded ? props.getProperty("db.username") : null);
            PASS = (envPass != null) ? envPass : (propsLoaded ? props.getProperty("db.password") : null);

            if (URL == null || USER == null || PASS == null) {
                throw new RuntimeException("Database configuration (URL, username, or password) is missing in both db.properties and environment variables.");
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