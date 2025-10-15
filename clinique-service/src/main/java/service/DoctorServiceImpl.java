package service;

import com.clinique.domain.Doctor;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;
import jakarta.persistence.EntityManager;
import jakarta.persistence.NoResultException;
import jakarta.transaction.Transactional;
import service.Interface.DoctorService;

import java.util.List;
import java.util.Optional;

@ApplicationScoped
public class DoctorServiceImpl implements DoctorService {

    @Inject
    private EntityManager em;

    @Override
    @Transactional
    public Doctor save(Doctor doctor) {
        if (doctor.getId() == null) {
            em.persist(doctor);
            return doctor;
        } else {
            return em.merge(doctor);
        }
    }

    @Override
    public Optional<Doctor> findById(Long id) {
        Doctor doctor = em.find(Doctor.class, id);
        return Optional.ofNullable(doctor);
    }

    @Override
    public List<Doctor> findAll() {
        return em.createQuery("SELECT d FROM Doctor d", Doctor.class)
                .getResultList();
    }

    @Override
    @Transactional
    public void delete(Long id) {
        Doctor doctor = em.find(Doctor.class, id);
        if (doctor != null) {
            em.remove(doctor);
        }
    }

    @Override
    public Optional<Doctor> findByUserId(Long userId) {
        try {
            Doctor doctor = em.createQuery(
                            "SELECT d FROM Doctor d WHERE d.user.id = :userId", Doctor.class)
                    .setParameter("userId", userId)
                    .getSingleResult();
            return Optional.of(doctor);
        } catch (NoResultException e) {
            return Optional.empty();
        }
    }

    @Override
    public Optional<Doctor> findByRegistrationNumber(String registrationNumber) {
        try {
            Doctor doctor = em.createQuery(
                            "SELECT d FROM Doctor d WHERE d.registrationNumber = :regNum", Doctor.class)
                    .setParameter("regNum", registrationNumber)
                    .getSingleResult();
            return Optional.of(doctor);
        } catch (NoResultException e) {
            return Optional.empty();
        }
    }
}