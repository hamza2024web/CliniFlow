package repository.Interface;

import com.clinique.domain.Patient;

import java.util.List;
import java.util.Optional;

public interface PatientRepository {
    Patient save(Patient patient);
    void delete(Patient patient);
    Optional<Patient> findById(Long id);
    List<Patient> findAll();
    Optional<Patient> findByUserId(Long userId);
    Optional<Patient> findByCin(String cin);
}
