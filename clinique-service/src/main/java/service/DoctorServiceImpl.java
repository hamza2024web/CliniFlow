package service;

import com.clinique.domain.Doctor;
import com.clinique.domain.Patient;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;
import jakarta.inject.Named;
import jakarta.transaction.Transactional;
import repository.Interface.DoctorRepository;
import service.Interface.DoctorService;

import java.util.List;
import java.util.Optional;

@ApplicationScoped
@Named
@Transactional
public class DoctorServiceImpl implements DoctorService {

    @Inject
    private DoctorRepository doctorRepository;

    @Override
    public Doctor save(Doctor doctor) {
        return doctorRepository.save(doctor);
    }

    @Override
    public Optional<Doctor> findById(Long id) {
        return doctorRepository.findById(id);
    }

    @Override
    public List<Doctor> findAll() {
        return doctorRepository.findAll();
    }

    @Override
    public void delete(Long id) {
        Optional<Doctor> doctor = doctorRepository.findById(id);
        doctor.ifPresent(doctorRepository::delete);
    }

    @Override
    public Optional<Doctor> findByUserId(Long userId) {
        return doctorRepository.findByUserId(userId);
    }

    @Override
    public Optional<Doctor> findByRegistrationNumber(String registrationNumber) {
        return doctorRepository.findByRegistrationNumber(registrationNumber);
    }

    @Override
    public List<Doctor> findBySpecialtyId(Long specialtyId) {
        return doctorRepository.findBySpecialityId(specialtyId);
    }

    @Override
    public List<Patient> getPatientsByDoctor(Long doctorId) {
        return doctorRepository.findDistinctPatientsByDoctorId(doctorId);
    }
}