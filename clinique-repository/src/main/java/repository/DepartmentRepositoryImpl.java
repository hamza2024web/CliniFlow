package repository;

import com.clinique.domain.Department;
import repository.Interface.DepartmentRepository;

import java.util.List;
import java.util.Optional;

public class DepartmentRepositoryImpl implements DepartmentRepository {

    @Override
    public Department save(Department d) {
        return null;
    }

    @Override
    public List<Department> findAll() {
        return List.of();
    }

    @Override
    public Optional<Department> findById(Long id) {
        return Optional.empty();
    }

    @Override
    public Optional<Department> findByCode(String code) {
        return Optional.empty();
    }

    @Override
    public void delete(Long id) {

    }
}
