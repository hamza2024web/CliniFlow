package repository.Interface;

import com.clinique.domain.Department;

import java.util.List;
import java.util.Optional;

public interface DepartmentRepository {
    Department save(Department d);
    List<Department> findAll();
    Optional<Department> findById(Long id);
    Optional<Department> findByCode(String code);
    void delete(Long id);
}
