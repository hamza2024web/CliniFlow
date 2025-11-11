package repository.Interface;

import com.clinique.domain.Availability;
import com.clinique.domain.Doctor;
import com.clinique.domain.Enum.DayOfWeek;

import java.util.List;
import java.util.Optional;

public interface AvailabilityRepository {
    Availability save(Availability availability);
    Optional<Availability> findById(Long id);
    List<Availability> findAll();
    List<Availability> findByDoctor(Doctor doctor);
    Optional<Availability> findByDoctorAndDay(Doctor doctor , DayOfWeek dayOfWeek);
    void delete(Long id);
    List<Availability> findAvailabilityByDoctor(Doctor doctor);
}
