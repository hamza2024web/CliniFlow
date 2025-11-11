package service.Interface;

import com.clinique.domain.Department;

import java.util.List;

public interface DepartmentService {
    Department createDepartment(String name, String code);
    List<Department> getAllDepartments();
    Department updateDepartment(Long id, String name, String code);
    void deleteDepartment(Long id);
    Department getDepartmentById(Long id);
}
