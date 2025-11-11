package repository.Interface;

import com.clinique.domain.Department;
import com.clinique.domain.Specialty;

import java.util.List;
import java.util.Optional;

public interface SpecialityRepository {
    Specialty save(Specialty speciality);
    List<Specialty> findAll();
    Optional<Specialty> findById(Long id);
    Optional<Specialty> findByCode(String code);
    List<Specialty> findByDepartment(Department department);
    void delete(Long id);
}
