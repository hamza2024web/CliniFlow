package repository;

import com.clinique.domain.Appointment;
import com.clinique.domain.Doctor;
import com.clinique.domain.Patient;
import jakarta.enterprise.context.ApplicationScoped;
import repository.Interface.AppointmentRepository;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

@ApplicationScoped
public class AppointmentRepositoryImpl implements AppointmentRepository {

    @Override
    public Appointment save(Appointment appointement) {
        return null;
    }

    @Override
    public Optional<Appointment> findById(Long id) {
        return Optional.empty();
    }

    @Override
    public List<Appointment> findByDoctorAndDate(Doctor doctor, LocalDateTime dayStart, LocalDateTime dayEnd) {
        return List.of();
    }

    @Override
    public List<Appointment> findByPatient(Patient patient) {
        return List.of();
    }

    @Override
    public List<Appointment> findByDoctor(Doctor doctor) {
        return List.of();
    }

    @Override
    public boolean existsByDoctorAndTime(Doctor doctor, LocalDateTime start, LocalDateTime end) {
        return false;
    }
}
