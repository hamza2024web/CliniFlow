package service;

import com.clinique.domain.Department;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;
import jakarta.transaction.Transactional;
import repository.Interface.DepartmentRepository;
import service.Interface.DepartmentService;

import java.util.List;

@ApplicationScoped
@Transactional
public class DepartmentServiceImpl implements DepartmentService {

    @Inject
    private DepartmentRepository departmentRepository;

    @Override
    public Department createDepartment(String name, String code) {
        if (name == null || name.trim().isEmpty())
            throw new IllegalArgumentException("Le nom du département est obligatoire.");
        if (code == null || code.trim().isEmpty())
            throw new IllegalArgumentException("Le code du département est obligatoire.");

        if (departmentRepository.findByCode(code).isPresent())
            throw new IllegalArgumentException("Le code de département existe déjà.");

        Department d = new Department();
        d.setName(name.trim());
        d.setCode(code.trim().toUpperCase());

        return departmentRepository.save(d);
    }

    @Override
    public List<Department> getAllDepartments() {
        return departmentRepository.findAll();
    }

    @Override
    public Department updateDepartment(Long id, String name, String code) {
        Department d = departmentRepository.findById(id).orElseThrow(() -> new IllegalArgumentException("Département introuvable"));

        if (name != null && !name.trim().isEmpty()) d.setName(name.trim());
        if (code != null && !code.trim().isEmpty()) d.setCode(code.trim().toUpperCase());

        departmentRepository.findByCode(code).filter(dep -> !dep.getId().equals(id)).ifPresent(dep -> { throw new IllegalArgumentException("Code déjà utilisé."); });

        return departmentRepository.save(d);
    }

    @Override
    @Transactional
    public void deleteDepartment(Long id) {
        departmentRepository.delete(id);
    }

    @Override
    public Department getDepartmentById(Long id) {
        return departmentRepository.findById(id).orElseThrow(() -> new IllegalArgumentException("Département introuvable"));
    }
}
