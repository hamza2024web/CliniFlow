package repository.Interface;

import com.clinique.domain.Doctor;

import java.util.List;
import java.util.Optional;

public interface DoctorRepository {
    Doctor save(Doctor doctor);
    void delete(Doctor doctor);
    Optional<Doctor> findById(Long id);
    List<Doctor> findAll();
    Optional<Doctor> findByUserId(Long userId);
    Optional<Doctor> findByRegistrationNumber(String registrationNumber);
}
