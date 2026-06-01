package com.portfolio.model;

/**
 * Represents a student/portfolio owner with profile information.
 */
public class Student {

    private int id;
    private String name;
    private String branch;
    private String role;
    private String bio;
    private String githubUrl;
    private String linkedinUrl;
    private String resumeUrl;
    private String photoPath;
    private String password;
    private int semester;

    /** No-arg constructor required for JavaBean compliance. */
    public Student() {
    }

    public Student(int id, String name, String branch, String role, String bio,
                   String githubUrl, String linkedinUrl, String resumeUrl, String photoPath,
                   String password, int semester) {
        this.id = id;
        this.name = name;
        this.branch = branch;
        this.role = role;
        this.bio = bio;
        this.githubUrl = githubUrl;
        this.linkedinUrl = linkedinUrl;
        this.resumeUrl = resumeUrl;
        this.photoPath = photoPath;
        this.password = password;
        this.semester = semester;
    }

    // ── Getters & Setters ──────────────────────────────────────────────

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getBranch() {
        return branch;
    }

    public void setBranch(String branch) {
        this.branch = branch;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public String getBio() {
        return bio;
    }

    public void setBio(String bio) {
        this.bio = bio;
    }

    public String getGithubUrl() {
        return githubUrl;
    }

    public void setGithubUrl(String githubUrl) {
        this.githubUrl = githubUrl;
    }

    public String getLinkedinUrl() {
        return linkedinUrl;
    }

    public void setLinkedinUrl(String linkedinUrl) {
        this.linkedinUrl = linkedinUrl;
    }

    public String getResumeUrl() {
        return resumeUrl;
    }

    public void setResumeUrl(String resumeUrl) {
        this.resumeUrl = resumeUrl;
    }

    public String getPhotoPath() {
        return photoPath;
    }

    public void setPhotoPath(String photoPath) {
        this.photoPath = photoPath;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public int getSemester() {
        return semester;
    }

    public void setSemester(int semester) {
        this.semester = semester;
    }

    @Override
    public String toString() {
        return "Student{id=" + id + ", name='" + name + "', branch='" + branch
                + "', role='" + role + "'}";
    }
}
