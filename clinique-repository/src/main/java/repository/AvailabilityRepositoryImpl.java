package repository;

import com.clinique.domain.Availability;
import com.clinique.domain.Doctor;
import com.clinique.domain.Enum.DayOfWeek;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import repository.Interface.AvailabilityRepository;

import java.util.List;
import java.util.Optional;

@ApplicationScoped
public class AvailabilityRepositoryImpl implements AvailabilityRepository {

    @PersistenceContext
    private EntityManager em;

    public Availability save(Availability availability) {
        if (availability.getId() == null) {
            em.persist(availability);
            return availability;
        } else {
            return em.merge(availability);
        }
    }

    public Optional<Availability> findById(Long id) {
        return Optional.ofNullable(em.find(Availability.class, id));
    }

    public List<Availability> findAll() {
        return em.createQuery("SELECT a FROM Availability a", Availability.class).getResultList();
    }

    public List<Availability> findByDoctor(Doctor doctor) {
        return em.createQuery("SELECT a FROM Availability a WHERE a.doctor = :doctor", Availability.class)
                .setParameter("doctor", doctor)
                .getResultList();
    }

    public Optional<Availability> findByDoctorAndDay(Doctor doctor, DayOfWeek dayOfWeek) {
        List<Availability> list = em.createQuery(
                        "SELECT a FROM Availability a WHERE a.doctor = :doctor AND a.dayOfWeek = :dayOfWeek", Availability.class)
                .setParameter("doctor", doctor)
                .setParameter("dayOfWeek", dayOfWeek)
                .getResultList();
        return list.isEmpty() ? Optional.empty() : Optional.of(list.get(0));
    }

    public void delete(Long id) {
        Availability a = em.find(Availability.class, id);
        if (a != null) {
            em.remove(a);
        }
    }

    public List<Availability> findActiveByDoctor(Doctor doctor) {
        return em.createQuery("SELECT a FROM Availability a WHERE a.doctor = :doctor AND a.active = true", Availability.class)
                .setParameter("doctor", doctor)
                .getResultList();
    }
}
