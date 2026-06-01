package com.portfolio.model;

/**
 * Represents attendance data for a student in a particular subject.
 */
public class Attendance {

    private int id;
    private int studentId;
    private String subject;
    private int totalClasses;
    private int attended;
    private double percentage;

    /** No-arg constructor required for JavaBean compliance. */
    public Attendance() {
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

    public String getSubject() {
        return subject;
    }

    public void setSubject(String subject) {
        this.subject = subject;
    }

    public int getTotalClasses() {
        return totalClasses;
    }

    public void setTotalClasses(int totalClasses) {
        this.totalClasses = totalClasses;
    }

    public int getAttended() {
        return attended;
    }

    public void setAttended(int attended) {
        this.attended = attended;
    }

    public double getPercentage() {
        return percentage;
    }

    public void setPercentage(double percentage) {
        this.percentage = percentage;
    }

    @Override
    public String toString() {
        return "Attendance{id=" + id + ", studentId=" + studentId + ", subject='" + subject
                + "', percentage=" + percentage + "}";
    }
}
