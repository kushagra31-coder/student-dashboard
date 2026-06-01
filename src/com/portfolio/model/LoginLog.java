package com.portfolio.model;

import java.sql.Timestamp;

/**
 * Represents a login audit log entry.
 */
public class LoginLog {

    private int id;
    private int userId;
    private String userName;
    private String role;
    private Timestamp loginTime;
    private String ipAddress;

    /** No-arg constructor required for JavaBean compliance. */
    public LoginLog() {
    }

    // ── Getters & Setters ──────────────────────────────────────────────

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public Timestamp getLoginTime() {
        return loginTime;
    }

    public void setLoginTime(Timestamp loginTime) {
        this.loginTime = loginTime;
    }

    public String getIpAddress() {
        return ipAddress;
    }

    public void setIpAddress(String ipAddress) {
        this.ipAddress = ipAddress;
    }

    @Override
    public String toString() {
        return "LoginLog{id=" + id + ", userId=" + userId + ", userName='" + userName
                + "', role='" + role + "', loginTime=" + loginTime + "}";
    }
}
