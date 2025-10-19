package service;

import com.clinique.domain.MedicalNote;
import jakarta.enterprise.context.ApplicationScoped;
import repository.Interface.MedicalNoteRepository;
import service.Interface.MedicalNoteService;
import jakarta.inject.Inject;
import java.util.List;

@ApplicationScoped
public class MedicalNoteServiceImpl implements MedicalNoteService {

    @Inject
    private MedicalNoteRepository medicalNoteRepository;

    @Override
    public MedicalNote addNote(MedicalNote note) {
        return medicalNoteRepository.save(note);
    }

    @Override
    public MedicalNote editNote(MedicalNote note) {
        return medicalNoteRepository.save(note);
    }

    @Override
    public void deleteNote(Long noteId) {
        MedicalNote note = medicalNoteRepository.findById(noteId);
        if (note != null) {
            medicalNoteRepository.delete(note);
        }
    }

    @Override
    public MedicalNote getNoteById(Long id) {
        return medicalNoteRepository.findById(id);
    }

    @Override
    public List<MedicalNote> getNotesByPatient(Long patientId) {
        return medicalNoteRepository.findByPatientId(patientId);
    }

    @Override
    public List<MedicalNote> getNotesByDoctor(Long doctorId) {
        return medicalNoteRepository.findByDoctorId(doctorId);
    }

    @Override
    public List<MedicalNote> getNotesByAppointment(Long appointmentId) {
        return medicalNoteRepository.findByAppointmentId(appointmentId);
    }

    @Override
    public List<MedicalNote> getAllNotes() {
        return medicalNoteRepository.findAll();
    }
}