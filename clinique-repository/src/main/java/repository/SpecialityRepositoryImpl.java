package repository;

import com.clinique.domain.Department;
import com.clinique.domain.Specialty;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import repository.Interface.SpecialityRepository;

import java.util.List;
import java.util.Optional;

public class SpecialityRepositoryImpl implements SpecialityRepository {

    @PersistenceContext
    private EntityManager em;

    @Override
    public Specialty save(Specialty specialty) {
        if (specialty.getId() == null) {
            em.persist(specialty);
            return specialty;
        } else {
            return em.merge(specialty);
        }
    }

    @Override
    public List<Specialty> findAll() {
        return em.createQuery("SELECT s FROM Specialty s", Specialty.class).getResultList();
    }

    @Override
    public Optional<Specialty> findById(Long id) {
        return Optional.ofNullable(em.find(Specialty.class, id));
    }

    @Override
    public Optional<Specialty> findByCode(String code) {
        List<Specialty> result = em.createQuery("SELECT s FROM Specialty s WHERE s.code = :code", Specialty.class)
                .setParameter("code", code)
                .getResultList();
        return result.isEmpty() ? Optional.empty() : Optional.of(result.get(0));
    }

    @Override
    public List<Specialty> findByDepartment(Department department) {
        return em.createQuery("SELECT s FROM Specialty s WHERE s.department = :department", Specialty.class)
                .setParameter("department", department)
                .getResultList();
    }

    @Override
    public void delete(Long id) {
        Specialty s = em.find(Specialty.class, id);
        if (s != null) {
            em.remove(s);
        }
    }
}
