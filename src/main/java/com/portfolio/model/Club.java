package com.portfolio.model;

public class Club {
    private int id;
    private int studentId;
    private String name;
    private String role;
    private String description;

    public Club() {}

    public Club(int id, int studentId, String name, String role, String description) {
        this.id = id;
        this.studentId = studentId;
        this.name = name;
        this.role = role;
        this.description = description;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public int getStudentId() { return studentId; }
    public void setStudentId(int studentId) { this.studentId = studentId; }
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    public String getRole() { return role; }
    public void setRole(String role) { this.role = role; }
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
}
