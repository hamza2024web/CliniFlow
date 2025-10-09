package com.clinique.domain;

import com.clinique.domain.Enum.Priority;
import com.clinique.domain.Enum.WaitingListStatus;
import jakarta.persistence.*;
import jakarta.validation.constraints.*;
import java.time.LocalDate;


@Entity
@Table(name = "waiting_list")
public class WaitingListEntry {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @NotNull(message = "La date demandée est obligatoire")
    @Column(name = "requested_date", nullable = false, columnDefinition = "DATE")
    private LocalDate requestedDate;

    @NotNull(message = "La date de création est obligatoire")
    @Column(name = "creation_date", nullable = false, updatable = false, columnDefinition = "DATE")
    private LocalDate creationDate;

    @Enumerated(EnumType.STRING)
    @Column(name = "priority", nullable = false, length = 20)
    private Priority priority = Priority.MEDIUM;

    @Enumerated(EnumType.STRING)
    @Column(name = "status", nullable = false, length = 20)
    private WaitingListStatus status = WaitingListStatus.PENDING;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "patient_id", nullable = false)
    private Patient patient;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "doctor_id")
    private Doctor doctor;

    @PrePersist
    protected void onCreate() {
        creationDate = LocalDate.now();
        if (priority == null) {
            priority = Priority.MEDIUM;
        }
        if (status == null) {
            status = WaitingListStatus.PENDING;
        }
    }

    public WaitingListEntry() {}

    public WaitingListEntry(LocalDate requestedDate, Priority priority, Patient patient, Doctor doctor) {
        this.requestedDate = requestedDate;
        this.priority = priority;
        this.patient = patient;
        this.doctor = doctor;
        this.status = WaitingListStatus.PENDING;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public LocalDate getRequestedDate() {
        return requestedDate;
    }

    public void setRequestedDate(LocalDate requestedDate) {
        this.requestedDate = requestedDate;
    }

    public LocalDate getCreationDate() {
        return creationDate;
    }

    public void setCreationDate(LocalDate creationDate) {
        this.creationDate = creationDate;
    }

    public Priority getPriority() {
        return priority;
    }

    public void setPriority(Priority priority) {
        this.priority = priority;
    }

    public WaitingListStatus getStatus() {
        return status;
    }

    public void setStatus(WaitingListStatus status) {
        this.status = status;
    }

    public Patient getPatient() {
        return patient;
    }

    public void setPatient(Patient patient) {
        this.patient = patient;
    }

    public Doctor getDoctor() {
        return doctor;
    }

    public void setDoctor(Doctor doctor) {
        this.doctor = doctor;
    }

    @Override
    public String toString() {
        return "WaitingListEntry{id=" + id + ", requestedDate=" + requestedDate + ", priority=" + priority + ", status=" + status + "}";
    }
}