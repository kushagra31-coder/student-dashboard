package com.portfolio.model;

import java.util.Date;

public class Document {
    private int id;
    private int studentId;
    private String title;
    private String filePath;
    private Date uploadDate;

    public Document() {}

    public Document(int id, int studentId, String title, String filePath, Date uploadDate) {
        this.id = id;
        this.studentId = studentId;
        this.title = title;
        this.filePath = filePath;
        this.uploadDate = uploadDate;
    }

    // Getters and Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getStudentId() { return studentId; }
    public void setStudentId(int studentId) { this.studentId = studentId; }

    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }

    public String getFilePath() { return filePath; }
    public void setFilePath(String filePath) { this.filePath = filePath; }

    public Date getUploadDate() { return uploadDate; }
    public void setUploadDate(Date uploadDate) { this.uploadDate = uploadDate; }
}
