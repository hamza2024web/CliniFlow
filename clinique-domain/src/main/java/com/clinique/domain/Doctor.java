package com.clinique.domain;

import jakarta.persistence.*;
import jakarta.validation.constraints.*;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "doctors",schema="public")
public class Doctor {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @NotBlank(message = "Le numéro d'enregistrement est obligatoire")
    @Size(max = 50)
    @Column(name = "registration_number", nullable = false, length = 50, unique = true)
    private String registrationNumber; // Numéro d'ordre du médecin

    @NotBlank(message = "Le titre est obligatoire")
    @Size(max = 100)
    @Column(name = "title", length = 100)
    private String title; // Ex: "Dr.", "Pr.", "Docteur"

    @ManyToOne(fetch = FetchType.EAGER) // EAGER = charge immédiatement la spécialité
    @JoinColumn(name = "specialty_id", nullable = false)
    private Specialty specialty;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "department_id", nullable = false)
    private Department department;

    @OneToOne(cascade = CascadeType.ALL, orphanRemoval = true)
    @JoinColumn(name = "user_id", referencedColumnName = "id")
    private User user;

    @OneToMany(mappedBy = "doctor", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private List<Appointment> appointments = new ArrayList<>();

    @OneToMany(mappedBy = "doctor", cascade = CascadeType.ALL)
    private List<Availability> availabilities = new ArrayList<>();

    // Constructeurs
    public Doctor() {}

    public Doctor(String registrationNumber, String title, Specialty specialty, Department department, User user) {
        this.registrationNumber = registrationNumber;
        this.title = title;
        this.specialty = specialty;
        this.department = department;
        this.user = user;
    }

    // Getters et Setters
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getRegistrationNumber() {
        return registrationNumber;
    }

    public void setRegistrationNumber(String registrationNumber) {
        this.registrationNumber = registrationNumber;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public Specialty getSpecialty() {
        return specialty;
    }

    public void setSpecialty(Specialty specialty) {
        this.specialty = specialty;
    }

    public Department getDepartment() {
        return department;
    }

    public void setDepartment(Department department) {
        this.department = department;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public List<Appointment> getAppointments() {
        return appointments;
    }

    public void setAppointments(List<Appointment> appointments) {
        this.appointments = appointments;
    }

    public List<Availability> getAvailabilities() {
        return availabilities;
    }

    public void setAvailabilities(List<Availability> availabilities) {
        this.availabilities = availabilities;
    }

    @Override
    public String toString() {
        return "Doctor{id=" + id + ", registrationNumber='" + registrationNumber + "', title='" + title + "'}";
    }
}