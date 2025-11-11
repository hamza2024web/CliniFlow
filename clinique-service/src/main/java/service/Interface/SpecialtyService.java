package service.Interface;

import com.clinique.domain.Specialty;

import java.util.List;

public interface SpecialtyService {
    Specialty createSpecialty(String name, String code, Long departmentId);
    List<Specialty> getAllSpecialties();
    Specialty updateSpecialty(Long id, String name, String code, Long departmentId);
    void deleteSpecialty(Long id);
    Specialty getSpecialtyById(Long id);
    List<Specialty> getSpecialtiesByDepartment(Long departmentId);
}
