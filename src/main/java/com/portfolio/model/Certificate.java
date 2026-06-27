package com.portfolio.model;

import java.sql.Timestamp;

public class Certificate {
    private int id;
    private int studentId;
    private String title;
    private String filePath;
    private Timestamp issueDate;

    public Certificate() {
    }

    public Certificate(int id, int studentId, String title, String filePath, Timestamp issueDate) {
        this.id = id;
        this.studentId = studentId;
        this.title = title;
        this.filePath = filePath;
        this.issueDate = issueDate;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getStudentId() {
        return studentId;
    }

    public void setStudentId(int studentId) {
        this.studentId = studentId;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getFilePath() {
        return filePath;
    }

    public void setFilePath(String filePath) {
        this.filePath = filePath;
    }

    public Timestamp getIssueDate() {
        return issueDate;
    }

    public void setIssueDate(Timestamp issueDate) {
        this.issueDate = issueDate;
    }

    @Override
    public String toString() {
        return "Certificate{id=" + id + ", title='" + title + "'}";
    }
}
