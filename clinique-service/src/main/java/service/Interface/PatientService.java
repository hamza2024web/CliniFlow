package service.Interface;

import com.clinique.domain.Patient;
import java.util.List;
import java.util.Optional;

public interface PatientService {
    Patient save(Patient patient);
    Optional<Patient> findById(Long id);
    List<Patient> findAll();
    void delete(Long id);
    Optional<Patient> findByUserId(Long userId);
    Optional<Patient> findByCin(String cin);
}