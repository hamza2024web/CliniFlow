package service.Interface;

import com.clinique.domain.Appointment;
import com.clinique.domain.Doctor;
import com.clinique.domain.Enum.AppointmentType;
import com.clinique.domain.Enum.Priority;
import com.clinique.domain.Patient;
import service.TimeSlot;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

public interface AppointmentService {
    List<TimeSlot> getAvailableSlots(Doctor doctor, LocalDate date, AppointmentType type);
    Optional<Appointment> createAppointment(Patient patient, Doctor doctor, LocalDateTime start, AppointmentType type, Priority priority);
    boolean isSlotAvailable(Doctor doctor, LocalDateTime start, LocalDateTime end);
    List<Appointment> getAppointmentsByPatient(Patient patient);
    List<Appointment> getAppointmentsByDoctorAndDate(Doctor doctor, LocalDate date);
    List<Doctor> getDoctorsBySpeciality(Long specialityId);
    List<Appointment> getAppointmentsByDoctor(Long doctor);
    void markAsCompleted(Long appointmentId);
    Appointment getAppointmentById(Long appointmentId);
}
