package com.clinique.domain;

import jakarta.persistence.*;
import jakarta.validation.constraints.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "medical_notes", schema = "public")
public class MedicalNote {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @NotBlank(message = "Le contenu de la note est obligatoire")
    @Column(name = "content", nullable = false, columnDefinition = "TEXT")
    private String content;

    @Column(name = "created_at", nullable = false)
    private LocalDateTime createdAt = LocalDateTime.now();

    @Column(name = "updated_at")
    private LocalDateTime updatedAt;

    @Column(name = "is_locked", nullable = false)
    private Boolean isLocked = false;

    // Lien direct avec le médecin auteur
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "doctor_id")
    private Doctor doctor;

    // Lien direct avec le patient concerné
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "patient_id")
    private Patient patient;

    // Lien direct avec le rendez-vous concerné
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "appointment_id")
    private Appointment appointment;

    public MedicalNote() {}

    public MedicalNote(String content, Doctor doctor, Patient patient, Appointment appointment) {
        this.content = content;
        this.doctor = doctor;
        this.patient = patient;
        this.appointment = appointment;
        this.createdAt = LocalDateTime.now();
        this.isLocked = false;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public LocalDateTime getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(LocalDateTime updatedAt) {
        this.updatedAt = updatedAt;
    }

    public Boolean getLocked() {
        return isLocked;
    }

    public void setLocked(Boolean locked) {
        isLocked = locked;
    }

    public Doctor getDoctor() {
        return doctor;
    }

    public void setDoctor(Doctor doctor) {
        this.doctor = doctor;
    }

    public Patient getPatient() {
        return patient;
    }

    public void setPatient(Patient patient) {
        this.patient = patient;
    }

    public Appointment getAppointment() {
        return appointment;
    }

    public void setAppointment(Appointment appointment) {
        this.appointment = appointment;
    }

    public void lock() {
        this.isLocked = true;
    }

    public boolean canEdit() {
        return !this.isLocked;
    }

    @PreUpdate
    public void preUpdate() {
        this.updatedAt = LocalDateTime.now();
    }

    @Override
    public String toString() {
        return "MedicalNote{id=" + id + ", doctor=" + doctor + ", patient=" + patient +
                ", appointment=" + appointment + ", isLocked=" + isLocked + "}";
    }
}