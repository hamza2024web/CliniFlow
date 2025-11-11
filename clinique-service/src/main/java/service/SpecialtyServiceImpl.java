package service;

import com.clinique.domain.Department;
import com.clinique.domain.Specialty;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;
import jakarta.inject.Named;
import jakarta.transaction.Transactional;
import repository.Interface.DepartmentRepository;
import repository.Interface.SpecialityRepository;
import service.Interface.SpecialtyService;

import java.util.List;

@ApplicationScoped
@Named
public class SpecialtyServiceImpl implements SpecialtyService {

    @Inject
    private SpecialityRepository specialtyRepository;

    @Inject
    private DepartmentRepository departmentRepository;

    @Override
    @Transactional
    public Specialty createSpecialty(String name, String code, Long departmentId) {
        if (name == null || name.trim().isEmpty())
            throw new IllegalArgumentException("Le nom de la spécialité est obligatoire.");
        if (code == null || code.trim().isEmpty())
            throw new IllegalArgumentException("Le code de la spécialité est obligatoire.");
        if (departmentId == null)
            throw new IllegalArgumentException("Le département est obligatoire.");

        if (specialtyRepository.findByCode(code).isPresent())
            throw new IllegalArgumentException("Le code de spécialité existe déjà.");

        Department dept = departmentRepository.findById(departmentId)
                .orElseThrow(() -> new IllegalArgumentException("Département introuvable."));

        Specialty s = new Specialty();
        s.setName(name.trim());
        s.setCode(code.trim().toUpperCase());
        s.setDepartment(dept);

        return specialtyRepository.save(s);
    }

    @Override
    public List<Specialty> getAllSpecialties() {
        return specialtyRepository.findAll();
    }

    @Override
    @Transactional
    public Specialty updateSpecialty(Long id, String name, String code, Long departmentId) {
        Specialty s = specialtyRepository.findById(id)
                .orElseThrow(() -> new IllegalArgumentException("Spécialité introuvable."));

        if (name != null && !name.trim().isEmpty()) s.setName(name.trim());
        if (code != null && !code.trim().isEmpty()) s.setCode(code.trim().toUpperCase());

        if (departmentId != null) {
            Department dept = departmentRepository.findById(departmentId)
                    .orElseThrow(() -> new IllegalArgumentException("Département introuvable."));
            s.setDepartment(dept);
        }

        specialtyRepository.findByCode(code).filter(sp -> !sp.getId().equals(id))
                .ifPresent(sp -> { throw new IllegalArgumentException("Code déjà utilisé."); });

        return specialtyRepository.save(s);
    }

    @Override
    @Transactional
    public void deleteSpecialty(Long id) {
        specialtyRepository.delete(id);
    }

    @Override
    public Specialty getSpecialtyById(Long id) {
        return specialtyRepository.findById(id)
                .orElseThrow(() -> new IllegalArgumentException("Spécialité introuvable."));
    }

    @Override
    public List<Specialty> getSpecialtiesByDepartment(Long departmentId) {
        Department dept = departmentRepository.findById(departmentId)
                .orElseThrow(() -> new IllegalArgumentException("Département introuvable."));
        return specialtyRepository.findByDepartment(dept);
    }
}
