package com.portfolio.model;

import java.util.Date;

public class Achievement {
    private int id;
    private int studentId;
    private String title;
    private String description;
    private Date dateAchieved;
    private String icon;

    public Achievement() {}

    public Achievement(int id, int studentId, String title, String description, Date dateAchieved, String icon) {
        this.id = id;
        this.studentId = studentId;
        this.title = title;
        this.description = description;
        this.dateAchieved = dateAchieved;
        this.icon = icon;
    }

    // Getters and Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getStudentId() { return studentId; }
    public void setStudentId(int studentId) { this.studentId = studentId; }

    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public Date getDateAchieved() { return dateAchieved; }
    public void setDateAchieved(Date dateAchieved) { this.dateAchieved = dateAchieved; }

    public String getIcon() { return icon; }
    public void setIcon(String icon) { this.icon = icon; }
}
