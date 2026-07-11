package com.portfolio.listener;

import com.portfolio.util.DBMigrator;
import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;

@WebListener
public class DatabaseInitializer implements ServletContextListener {

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        System.out.println("=================================================");
        System.out.println("  APPLICATION STARTING: RUNNING DATABASE INIT  ");
        System.out.println("=================================================");
        try {
            DBMigrator.executeMigration();
        } catch (Exception e) {
            System.err.println("Failed to initialize database on startup:");
            e.printStackTrace();
        }
        System.out.println("=================================================");
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        // Nothing to clean up
    }
}
