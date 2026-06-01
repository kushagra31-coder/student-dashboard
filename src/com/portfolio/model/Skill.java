package com.portfolio.model;

/**
 * Represents a technical skill with category and proficiency level.
 */
public class Skill {

    private int id;
    private String category;
    private String name;
    private int proficiencyPercent;

    /** No-arg constructor required for JavaBean compliance. */
    public Skill() {
    }

    public Skill(int id, String category, String name, int proficiencyPercent) {
        this.id = id;
        this.category = category;
        this.name = name;
        this.proficiencyPercent = proficiencyPercent;
    }

    // ── Getters & Setters ──────────────────────────────────────────────

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getProficiencyPercent() {
        return proficiencyPercent;
    }

    public void setProficiencyPercent(int proficiencyPercent) {
        this.proficiencyPercent = proficiencyPercent;
    }

    @Override
    public String toString() {
        return "Skill{id=" + id + ", category='" + category + "', name='" + name
                + "', proficiency=" + proficiencyPercent + "%}";
    }
}
