package com.portfolio.model;

import java.sql.Date;

/**
 * Represents a student placement record.
 */
public class Placement {

    private int id;
    private int studentId;
    private String company;
    private String role;
    private double packageLpa;
    private String status;
    private Date datePlaced;

    /** No-arg constructor required for JavaBean compliance. */
    public Placement() {
    }

    // ── Getters & Setters ──────────────────────────────────────────────

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

    public String getCompany() {
        return company;
    }

    public void setCompany(String company) {
        this.company = company;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public double getPackageLpa() {
        return packageLpa;
    }

    public void setPackageLpa(double packageLpa) {
        this.packageLpa = packageLpa;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Date getDatePlaced() {
        return datePlaced;
    }

    public void setDatePlaced(Date datePlaced) {
        this.datePlaced = datePlaced;
    }

    @Override
    public String toString() {
        return "Placement{id=" + id + ", studentId=" + studentId + ", company='" + company
                + "', role='" + role + "', packageLpa=" + packageLpa + "}";
    }
}
