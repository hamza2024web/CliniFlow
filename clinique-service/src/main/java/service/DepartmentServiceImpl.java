package service;

import com.clinique.domain.Department;
import service.Interface.DepartmentService;

import java.util.List;

public class DepartmentServiceImpl implements DepartmentService {
    @Override
    public Department createDepartment(String name, String code) {
        return null;
    }

    @Override
    public List<Department> getAllDepartments() {
        return List.of();
    }

    @Override
    public Department updateDepartment(Long id, String name, String code) {
        return null;
    }

    @Override
    public void deleteDepartment(Long id) {

    }

    @Override
    public Department getDepartmentById(Long id) {
        return null;
    }
}
