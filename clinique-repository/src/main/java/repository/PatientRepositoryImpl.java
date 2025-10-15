package repository;

import com.clinique.domain.Patient;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.persistence.EntityManager;
import jakarta.persistence.NoResultException;
import jakarta.persistence.PersistenceContext;
import repository.Interface.PatientRepository;

import java.util.List;
import java.util.Optional;

@ApplicationScoped
public class PatientRepositoryImpl implements PatientRepository {

    @PersistenceContext(unitName = "cliniquePU")
    private EntityManager entityManager;

    @Override
    public Patient save(Patient patient) {
        if (patient.getId() == null) {
            entityManager.merge(patient);
            entityManager.flush();
        } else {
            patient = entityManager.merge(patient);
            entityManager.flush();
        }
        return patient;
    }

    @Override
    public void delete(Patient patient) {
        if (!entityManager.contains(patient)) {
            patient = entityManager.merge(patient);
        }
        entityManager.remove(patient);
        entityManager.flush();
    }

    @Override
    public Optional<Patient> findById(Long id) {
        return Optional.ofNullable(entityManager.find(Patient.class, id));
    }

    @Override
    public List<Patient> findAll() {
        return entityManager.createQuery("SELECT p FROM Patient p", Patient.class)
                .getResultList();
    }

    @Override
    public Optional<Patient> findByUserId(Long userId) {
        try {
            Patient patient = entityManager.createQuery(
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
            Patient patient = entityManager.createQuery(
                            "SELECT p FROM Patient p WHERE p.cin = :cin", Patient.class)
                    .setParameter("cin", cin)
                    .getSingleResult();
            return Optional.of(patient);
        } catch (NoResultException e) {
            return Optional.empty();
        }
    }
}