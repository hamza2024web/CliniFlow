package repository;

import com.clinique.domain.Appointment;
import com.clinique.domain.Doctor;
import com.clinique.domain.Patient;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.persistence.TypedQuery;
import repository.Interface.AppointmentRepository;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

@ApplicationScoped
public class AppointmentRepositoryImpl implements AppointmentRepository {

    @PersistenceContext
    private EntityManager entityManager;

    @Override
    public Appointment save(Appointment appointement) {
        if (appointement.getId() == null){
            entityManager.persist(appointement);
            return appointement;
        } else {
            return entityManager.merge(appointement);
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
