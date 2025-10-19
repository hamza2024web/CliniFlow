package repository.Interface;

import com.clinique.domain.Appointment;
import com.clinique.domain.Doctor;
import com.clinique.domain.Patient;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

public interface AppointmentRepository {
    Appointment save(Appointment appointement);
    Optional<Appointment> findById(Long id);
    List<Appointment> findByDoctorAndDate(Doctor doctor, LocalDateTime dayStart, LocalDateTime dayEnd);
    List<Appointment> findByPatient(Patient patient);
    List<Appointment> findByDoctor(Doctor doctor);
    boolean existsByDoctorAndTime(Doctor doctor, LocalDateTime start , LocalDateTime end);
    void delete(Appointment appointment);
    List<Appointment> findByDoctorAndType(Doctor doctor , String type);
    Optional<Appointment> findByIdWithRelations(Long id);
}
