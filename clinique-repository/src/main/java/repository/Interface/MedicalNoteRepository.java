package repository.Interface;

import com.clinique.domain.MedicalNote;
import com.clinique.domain.Patient;

import java.util.List;

public interface MedicalNoteRepository {
    MedicalNote save(MedicalNote note);
    void delete(MedicalNote note);
    MedicalNote findById(Long id);
    List<MedicalNote> findByPatientId(Patient patient);
    List<MedicalNote> findByDoctorId(Long doctorId);
    List<MedicalNote> findByAppointmentId(Long appointmentId);
    List<MedicalNote> findAll();
}
