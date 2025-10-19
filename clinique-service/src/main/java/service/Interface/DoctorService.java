package service.Interface;

import com.clinique.domain.Doctor;
import java.util.List;
import java.util.Optional;

public interface DoctorService {
    Doctor save(Doctor doctor);
    Optional<Doctor> findById(Long id);
    List<Doctor> findAll();
    void delete(Long id);
    Optional<Doctor> findByUserId(Long userId);
    Optional<Doctor> findByRegistrationNumber(String registrationNumber);
    List<Doctor> findBySpecialtyId(Long specialtyId);
}