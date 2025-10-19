package repository;


import com.clinique.domain.MedicalNote;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.persistence.TypedQuery;
import repository.Interface.MedicalNoteRepository;

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
    public List<MedicalNote> findByPatientId(Long patientId) {
        String jpql = "SELECT n FROM MedicalNote n WHERE n.patient.id = :patientId";
        TypedQuery<MedicalNote> query = entityManager.createQuery(jpql, MedicalNote.class);
        query.setParameter("patientId", patientId);
        return query.getResultList();
    }

    @Override
    public List<MedicalNote> findByDoctorId(Long doctorId) {
        String jpql = "SELECT n FROM MedicalNote n WHERE n.doctor.id = :doctorId";
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