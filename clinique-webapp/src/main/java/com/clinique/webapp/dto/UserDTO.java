package com.clinique.webapp.dto;

import com.clinique.domain.Enum.Role;

import java.time.LocalDateTime;
import java.util.Set;

public class UserDTO {
    private Long id;
    private String firstName;
    private String lastName;
    private String email;
    private boolean active;
    private String role;
    private LocalDateTime createdAt;

    // Constructeurs
    public UserDTO() {}

    // Getters et Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public String getFirstName() { return firstName; }
    public void setFirstName(String firstName) { this.firstName = firstName; }

    public String getLastName() { return lastName; }
    public void setLastName(String lastName) { this.lastName = lastName; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public boolean isActive() { return active; }
    public void setActive(boolean active) { this.active = active; }

    public String getRole() { return role; }
    public void setRole(String role) { this.role = role; }

    public LocalDateTime getCreatedAt() { return createdAt; }
    public void setCreatedAt(LocalDateTime createdAt) { this.createdAt = createdAt; }


    public String getFullName() {
        return firstName + " " + lastName;
    }

}