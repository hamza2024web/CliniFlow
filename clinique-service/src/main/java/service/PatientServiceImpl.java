package service;

import com.clinique.domain.Patient;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;
import jakarta.persistence.EntityManager;
import jakarta.persistence.NoResultException;
import jakarta.transaction.Transactional;
import service.Interface.PatientService;

import java.util.List;
import java.util.Optional;

@ApplicationScoped
public class PatientServiceImpl implements PatientService {

    @Inject
    private EntityManager em;

    @Override
    @Transactional
    public Patient save(Patient patient) {
        if (patient.getId() == null) {
            em.persist(patient);
            return patient;
        } else {
            return em.merge(patient);
        }
    }

    @Override
    public Optional<Patient> findById(Long id) {
        Patient patient = em.find(Patient.class, id);
        return Optional.ofNullable(patient);
    }

    @Override
    public List<Patient> findAll() {
        return em.createQuery("SELECT p FROM Patient p", Patient.class)
                .getResultList();
    }

    @Override
    @Transactional
    public void delete(Long id) {
        Patient patient = em.find(Patient.class, id);
        if (patient != null) {
            em.remove(patient);
        }
    }

    @Override
    public Optional<Patient> findByUserId(Long userId) {
        try {
            Patient patient = em.createQuery(
                            "SELECT p FROM Patient p WHERE p.user.id = :userId", Patient.class)
                    .setParameter("userId", userId)
                    .getSingleResult();
            return Optional.of(patient);
        } catch (NoResultException e) {
            return Optional.empty();
        }
    }

    @Override
    public Optional<Patient> findByCin(String cin) {
        try {
            Patient patient = em.createQuery(
                            "SELECT p FROM Patient p WHERE p.cin = :cin", Patient.class)
                    .setParameter("cin", cin)
                    .getSingleResult();
            return Optional.of(patient);
        } catch (NoResultException e) {
            return Optional.empty();
        }
    }
}