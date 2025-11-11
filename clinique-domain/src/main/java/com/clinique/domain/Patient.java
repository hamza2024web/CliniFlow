package com.clinique.domain;

import jakarta.persistence.*;
import jakarta.validation.constraints.*;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "patients", schema = "public")
public class Patient {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @NotBlank(message = "Le CIN est obligatoire")
    @Size(max = 20)
    @Column(name = "cin", nullable = false, length = 20, unique = true)
    private String cin;

    @NotBlank(message = "La date de naissance est obligatoire")
    @Column(name = "birth_day", nullable = false)
    private String birthDay;

    @NotBlank(message = "le genre est obligatoire")
    @Pattern(regexp = "^(M|F)$", message = "Le genre doit étre M ou F")
    @Column(name = "gender", nullable = false, length = 1)
    private String gender;

    @NotBlank(message = "L'adresse est obligatoire")
    @Size(max = 200)
    @Column(name = "adresse", length = 200)
    private String adresse;

    @NotBlank(message = "Le numéro de téléphone est obligatoire")
    @Pattern(regexp = "^[0-9]{10}$", message = "Le téléphone doit contenir 10 chiffres")
    @Column(name = "phone_number", nullable = false, length = 15)
    private String phoneNumber;

    @OneToOne(cascade = CascadeType.ALL, orphanRemoval = true)
    @JoinColumn(name = "user_id", referencedColumnName = "id")
    private User user;

    @OneToMany(mappedBy = "patient", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private List<Appointment> appointments = new ArrayList<>();

    @OneToMany(mappedBy = "patient", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private List<MedicalNote> medicalNotes = new ArrayList<>();

    @OneToMany(mappedBy = "patient", cascade = CascadeType.ALL)
    private List<WaitingListEntry> waitingListEntries = new ArrayList<>();


    public Patient() {}

    public Patient(String cin, String birthDay, String gender, String adresse, String phoneNumber, User user) {
        this.cin = cin;
        this.birthDay = birthDay;
        this.gender = gender;
        this.adresse = adresse;
        this.phoneNumber = phoneNumber;
        this.user = user;
    }

    // Getters et Setters pour tous les champs

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public String getCin() { return cin; }
    public void setCin(String cin) { this.cin = cin; }
    public String getBirthDay() { return birthDay; }
    public void setBirthDay(String birthDay) { this.birthDay = birthDay; }
    public String getGender() { return gender; }
    public void setGender(String gender) { this.gender = gender; }
    public String getAdresse() { return adresse; }
    public void setAdresse(String adresse) { this.adresse = adresse; }
    public String getPhoneNumber() { return phoneNumber; }
    public void setPhoneNumber(String phoneNumber) { this.phoneNumber = phoneNumber; }
    public User getUser() { return user; }
    public void setUser(User user) { this.user = user; }
    public List<Appointment> getAppointments() { return appointments; }
    public void setAppointments(List<Appointment> appointments) { this.appointments = appointments; }
    public List<MedicalNote> getMedicalNotes() { return medicalNotes; }
    public void setMedicalNotes(List<MedicalNote> medicalNotes) { this.medicalNotes = medicalNotes; }
    public List<WaitingListEntry> getWaitingListEntries() { return waitingListEntries; }
    public void setWaitingListEntries(List<WaitingListEntry> waitingListEntries) { this.waitingListEntries = waitingListEntries; }

    @Override
    public String toString() {
        return "Patient{id=" + id + ", cin='" + cin + "', gender='" + gender + "'}";
    }
}