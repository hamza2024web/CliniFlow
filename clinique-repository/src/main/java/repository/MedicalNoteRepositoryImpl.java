package repository;


import com.clinique.domain.MedicalNote;
import com.clinique.domain.Patient;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.persistence.TypedQuery;
import repository.Interface.MedicalNoteRepository;

import java.util.Collections;
import java.util.List;

@ApplicationScoped
public class MedicalNoteRepositoryImpl implements MedicalNoteRepository {

    @PersistenceContext
    private EntityManager entityManager;

    @Override
    public MedicalNote save(MedicalNote note) {
        if (note.getId() == null) {
            entityManager.persist(note);
            return note;
        } else {
            return entityManager.merge(note);
        }
    }

    @Override
    public void delete(MedicalNote note) {
        entityManager.remove(entityManager.contains(note) ? note : entityManager.merge(note));
    }

    @Override
    public MedicalNote findById(Long id) {
        return entityManager.find(MedicalNote.class, id);
    }

    @Override
    public List<MedicalNote> findByPatientId(Patient patient) {
        List<Long> ids = entityManager.createQuery(
                        "SELECT n.id FROM MedicalNote n " +
                                "WHERE n.patient = :patient " +
                                "ORDER BY n.createdAt DESC",
                        Long.class
                )
                .setParameter("patient", patient)
                .getResultList();

        if (ids.isEmpty()) {
            return Collections.emptyList();
        }

        return entityManager.createQuery(
                        "SELECT n FROM MedicalNote n " +
                                "JOIN FETCH n.appointment " +
                                "JOIN FETCH n.patient p " +
                                "JOIN FETCH p.user " +
                                "JOIN FETCH n.doctor d " +
                                "JOIN FETCH d.user " +
                                "WHERE n.id IN :ids " +
                                "ORDER BY n.createdAt DESC",
                        MedicalNote.class
                )
                .setParameter("ids", ids)
                .getResultList();
    }

    @Override
    public List<MedicalNote> findByDoctorId(Long doctorId) {
        String jpql = "SELECT n FROM MedicalNote n " +
                "JOIN FETCH n.doctor d " +
                "JOIN FETCH d.user " +
                "WHERE d.id = :doctorId";
        TypedQuery<MedicalNote> query = entityManager.createQuery(jpql, MedicalNote.class);
        query.setParameter("doctorId", doctorId);
        return query.getResultList();
    }

    @Override
    public List<MedicalNote> findByAppointmentId(Long appointmentId) {
        String jpql = "SELECT n FROM MedicalNote n WHERE n.appointment.id = :appointmentId";
        TypedQuery<MedicalNote> query = entityManager.createQuery(jpql, MedicalNote.class);
        query.setParameter("appointmentId", appointmentId);
        return query.getResultList();
    }

    @Override
    public List<MedicalNote> findAll() {
        String jpql = "SELECT n FROM MedicalNote n";
        TypedQuery<MedicalNote> query = entityManager.createQuery(jpql, MedicalNote.class);
        return query.getResultList();
    }
}