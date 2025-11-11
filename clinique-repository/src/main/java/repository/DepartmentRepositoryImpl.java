package repository;

import com.clinique.domain.Department;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import repository.Interface.DepartmentRepository;

import java.util.List;
import java.util.Optional;

@ApplicationScoped
public class DepartmentRepositoryImpl implements DepartmentRepository {

    @PersistenceContext
    private EntityManager em;

    @Override
    public Department save(Department department) {
        if (department.getId() == null) {
            em.persist(department);
            return department;
        } else {
            return em.merge(department);
        }
    }

    @Override
    public List<Department> findAll() {
        return em.createQuery("SELECT d FROM Department d", Department.class).getResultList();
    }

    @Override
    public Optional<Department> findById(Long id) {
        return Optional.ofNullable(em.find(Department.class, id));
    }

    @Override
    public Optional<Department> findByCode(String code) {
        List<Department> result = em.createQuery("SELECT d FROM Department d WHERE d.code = :code", Department.class)
                .setParameter("code", code)
                .getResultList();
        return result.isEmpty() ? Optional.empty() : Optional.of(result.get(0));
    }

    @Override
    public void delete(Long id) {
        Department d = em.find(Department.class, id);
        if (d != null) {
            em.remove(d);
        }
    }
}
