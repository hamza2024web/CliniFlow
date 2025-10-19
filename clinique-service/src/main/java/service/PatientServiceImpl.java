package service;

import com.clinique.domain.Patient;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;
import jakarta.transaction.Transactional;
import repository.Interface.PatientRepository;
import service.Interface.PatientService;

import java.util.List;
import java.util.Optional;

@ApplicationScoped
@Transactional
public class PatientServiceImpl implements PatientService {

    @Inject
    private PatientRepository patientRepository;

    @Override
    @Transactional
    public Patient save(Patient patient) {
        return patientRepository.save(patient);
    }

    @Override
    public Optional<Patient> findById(Long id) {
        return patientRepository.findById(id);
    }

    @Override
    public List<Patient> findAll() {
        return patientRepository.findAll();
    }

    @Override
    public void delete(Long id) {
        Optional<Patient> patient = patientRepository.findById(id);
        patient.ifPresent(patientRepository::delete);
    }

    @Override
    public Optional<Patient> findByUserId(Long userId) {
        return patientRepository.findByUserId(userId);
    }

    @Override
    public Optional<Patient> findByCin(String cin) {
        return patientRepository.findByCin(cin);
    }
}