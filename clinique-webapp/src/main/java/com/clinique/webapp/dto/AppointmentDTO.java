package com.clinique.webapp.dto;

import com.clinique.domain.Appointment;
import com.clinique.domain.Enum.AppointmentStatus;
import com.clinique.domain.Enum.AppointmentType;
import com.clinique.domain.Specialty;

public class AppointmentDTO {
    private Long id;
    private String doctorFirstName;
    private String doctorLastName;
    private String formattedDate;
    private String formattedStartTime;
    private String formattedEndTime;
    private AppointmentType type;
    private AppointmentStatus status;
    private String specialty;

    // Constructor
    public AppointmentDTO(Appointment appointment, String date, String startTime, String endTime) {
        this.id = appointment.getId();
        this.doctorFirstName = appointment.getDoctor().getUser().getFirstName();
        this.doctorLastName = appointment.getDoctor().getUser().getLastName();
        this.formattedDate = date;
        this.formattedStartTime = startTime;
        this.formattedEndTime = endTime;
        this.type = appointment.getAppointmentType();
        this.status = appointment.getStatus();
        this.specialty = appointment.getDoctor().getSpecialty().getName();
    }

    // Getters
    public Long getId() { return id; }
    public String getDoctorFirstName() { return doctorFirstName; }
    public String getDoctorLastName() { return doctorLastName; }
    public String getFormattedDate() { return formattedDate; }
    public String getFormattedStartTime() { return formattedStartTime; }
    public String getFormattedEndTime() { return formattedEndTime; }
    public AppointmentType getType() { return type; }
    public AppointmentStatus getStatus() { return status; }
    public String getSpecialty() { return specialty; }

    public String getDoctorInitial() {
        return doctorFirstName != null && !doctorFirstName.isEmpty()
                ? doctorFirstName.substring(0, 1).toUpperCase()
                : "?";
    }

    public String getTypeLabel() {
        if (type == null) return "";
        switch (type) {
            case CONSULTATION: return "Consultation";
            case SPECIALIZED: return "Spécialisée";
            case URGENCY: return "Urgence";
            default: return type.toString();
        }
    }
}