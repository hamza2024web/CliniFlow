package repository;

import com.clinique.domain.Appointment;
import com.clinique.domain.Doctor;
import com.clinique.domain.Patient;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.persistence.EntityManager;
import jakarta.persistence.NoResultException;
import jakarta.persistence.PersistenceContext;
import jakarta.persistence.TypedQuery;
import repository.Interface.DoctorRepository;

import java.util.List;
import java.util.Optional;

@ApplicationScoped
public class DoctorRepositoryImpl implements DoctorRepository {

    @PersistenceContext(unitName = "cliniquePU")
    private EntityManager entityManager;

    @Override
    public Doctor save(Doctor doctor) {
        if (doctor.getId() == null) {
            entityManager.merge(doctor);
            entityManager.flush();
        } else {
            doctor = entityManager.merge(doctor);
            entityManager.flush();
        }
        return doctor;
    }

    @Override
    public void delete(Doctor doctor) {
        if (!entityManager.contains(doctor)) {
            doctor = entityManager.merge(doctor);
        }
        entityManager.remove(doctor);
        entityManager.flush();
    }

    @Override
    public Optional<Doctor> findById(Long id) {
        return Optional.ofNullable(entityManager.find(Doctor.class, id));
    }

    @Override
    public List<Doctor> findAll() {
        return entityManager.createQuery("SELECT d FROM Doctor d", Doctor.class)
                .getResultList();
    }

    @Override
    public Optional<Doctor> findByUserId(Long userId) {
        try {
            Doctor doctor = entityManager.createQuery(
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
            Doctor doctor = entityManager.createQuery(
                            "SELECT d FROM Doctor d WHERE d.registrationNumber = :regNum", Doctor.class)
                    .setParameter("regNum", registrationNumber)
                    .getSingleResult();
            return Optional.of(doctor);
        } catch (NoResultException e) {
            return Optional.empty();
        }
    }

    @Override
    public List<Doctor> findBySpecialityId(Long specialtyId) {
        String jpql = "SELECT d FROM Doctor d WHERE d.specialty.id = :specialtyId";
        TypedQuery<Doctor> query = entityManager.createQuery(jpql, Doctor.class);
        query.setParameter("specialtyId", specialtyId);
        return query.getResultList();
    }

    @Override
    public List<Patient> findDistinctPatientsByDoctorId(Long doctorId) {
        String jpql = """
        SELECT DISTINCT p
        FROM Appointment a
        INNER JOIN a.patient p
        JOIN FETCH p.user
        WHERE a.doctor.id = :doctorId
    """;

        TypedQuery<Patient> query = entityManager.createQuery(jpql, Patient.class);
        query.setParameter("doctorId", doctorId);
        return query.getResultList();
    }

}