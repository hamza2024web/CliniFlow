package repository;

import com.clinique.domain.Appointment;
import com.clinique.domain.Doctor;
import com.clinique.domain.Patient;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.persistence.EntityManager;
import jakarta.persistence.NoResultException;
import jakarta.persistence.PersistenceContext;
import jakarta.persistence.TypedQuery;
import jakarta.transaction.Transactional;
import repository.Interface.AppointmentRepository;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

@ApplicationScoped
public class AppointmentRepositoryImpl implements AppointmentRepository {

    @PersistenceContext
    private EntityManager entityManager;

    @Override
    public Appointment save(Appointment appointment) {
        if (appointment.getId() == null) {
            entityManager.persist(appointment);
            entityManager.flush();
            return findByIdWithRelations(appointment.getId()).orElse(appointment);
        } else {
            return entityManager.merge(appointment);
        }
    }

    @Override
    @Transactional
    public Appointment update(Appointment appointment) {
        if (appointment.getId() == null){
            entityManager.persist(appointment);
            return appointment;
        } else {
            return entityManager.merge(appointment);
        }
    }

    public Optional<Appointment> findByIdWithRelations(Long id) {
        try {
            Appointment appointment = entityManager.createQuery(
                            "SELECT a FROM Appointment a " +
                                    "JOIN FETCH a.patient " +
                                    "JOIN FETCH a.patient.user " +
                                    "JOIN FETCH a.doctor " +
                                    "JOIN FETCH a.doctor.user " +
                                    "WHERE a.id = :id",
                            Appointment.class
                    )
                    .setParameter("id", id)
                    .getSingleResult();
            return Optional.of(appointment);
        } catch (NoResultException e) {
            return Optional.empty();
        }
    }

    @Override
    public List<Appointment> findByDoctorId(Long doctorId) {
        return entityManager.createQuery(
                        "SELECT a FROM Appointment a " +
                                "JOIN FETCH a.patient " +
                                "WHERE a.doctor.id = :doctorId " +
                                "ORDER BY a.startDatetime",
                        Appointment.class
                )
                .setParameter("doctorId", doctorId)
                .getResultList();
    }

    @Override
    public List<Appointment> findByPatientWithDetails(Patient patient) {
        return entityManager.createQuery(
                        "SELECT a FROM Appointment a " +
                                "JOIN FETCH a.patient " +
                                "JOIN FETCH a.patient.user " +
                                "JOIN FETCH a.doctor " +
                                "JOIN FETCH a.doctor.user " +
                                "WHERE a.patient = :patient " +
                                "ORDER BY a.startDatetime DESC",
                        Appointment.class
                )
                .setParameter("patient", patient)
                .getResultList();
    }

    @Override
    public Appointment findByIdWithPatient(Long appointmentId) {
        try {
            return entityManager.createQuery(
                            "SELECT a FROM Appointment a " +
                                    "JOIN FETCH a.patient " +
                                    "JOIN FETCH a.patient.user " +
                                    "JOIN FETCH a.doctor " +
                                    "JOIN FETCH a.doctor.user " +
                                    "WHERE a.id = :appointmentId",
                            Appointment.class
                    )
                    .setParameter("appointmentId", appointmentId)
                    .getSingleResult();
        } catch (NoResultException e) {
            return null;
        }
    }

    @Override
    public Optional<Appointment> findById(Long id) {
        Appointment appointment = entityManager.find(Appointment.class, id);
        return Optional.ofNullable(appointment);
    }

    @Override
    public List<Appointment> findByDoctorAndDate(Doctor doctor, LocalDateTime dayStart, LocalDateTime dayEnd) {
        String jpql = "SELECT a FROM Appointment a WHERE a.doctor = :doctor " +
                "AND a.startDatetime >= :dayStart AND a.startDatetime < :dayEnd";
        TypedQuery<Appointment> query = entityManager.createQuery(jpql, Appointment.class);
        query.setParameter("doctor", doctor);
        query.setParameter("dayStart",dayStart);
        query.setParameter("dayEnd",dayEnd);
        return query.getResultList();
    }

    @Override
    public List<Appointment> findByPatient(Patient patient) {
        String jpql = "SELECT a FROM Appointment a WHERE a.patient = :patient";
        TypedQuery<Appointment> query = entityManager.createQuery(jpql,Appointment.class);
        query.setParameter("patient",patient);
        return query.getResultList();
    }

    @Override
    public List<Appointment> findByDoctor(Doctor doctor) {
        String jpql = "SELECT a FROM Appointment a WHERE a.doctor = :doctor";
        TypedQuery<Appointment> query = entityManager.createQuery(jpql, Appointment.class);
        query.setParameter("doctor", doctor);
        return query.getResultList();
    }

    @Override
    public boolean existsByDoctorAndTime(Doctor doctor, LocalDateTime start, LocalDateTime end) {
        String jpql = "SELECT COUNT(a) FROM Appointment a WHERE a.doctor = :doctor " +
                "AND ((a.startDatetime < :end AND a.endDatetime > :start))";
        Long count = entityManager.createQuery(jpql,Long.class)
                .setParameter("doctor",doctor)
                .setParameter("start",start)
                .setParameter("end",end)
                .getSingleResult();
        return count > 0;
    }

    @Override
    public void delete(Appointment appointment) {
        Appointment toDelete = entityManager.merge(appointment);
        entityManager.remove(toDelete);
    }

    @Override
    public List<Appointment> findByDoctorAndType(Doctor doctor, String type) {
        String jpql =  "SELECT a FROM Appointment a WHERE a.doctor = :doctor AND a.appointmentType = :type";
        TypedQuery<Appointment> query = entityManager.createQuery(jpql,Appointment.class);
        query.setParameter("doctor",doctor);
        query.setParameter("type",type);
        return query.getResultList();
    }


}
