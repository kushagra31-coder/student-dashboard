package com.portfolio.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {

    private static final String URL  = "jdbc:mysql://localhost:3306/portfolio_db";
    private static final String USER = "root";
    private static final String PASS = "akaza";

    // Load the MySQL JDBC driver once when the class is first referenced.
    static {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new RuntimeException("MySQL JDBC Driver not found. "
                    + "Ensure mysql-connector-j JAR is on the classpath.", e);
        }
    }

    /**
     * Returns a new JDBC {@link Connection} to the portfolio_db database.
     *
     * @return an open database connection
     * @throws SQLException if a database access error occurs
     */
    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(URL, USER, PASS);
    }
    
    private DBConnection() {
    }
}
