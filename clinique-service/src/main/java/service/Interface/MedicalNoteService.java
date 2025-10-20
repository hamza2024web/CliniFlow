package service.Interface;

import com.clinique.domain.MedicalNote;
import com.clinique.domain.Patient;

import java.util.List;

public interface MedicalNoteService {
    MedicalNote addNote(MedicalNote note);
    MedicalNote editNote(MedicalNote note);
    void deleteNote(Long noteId);
    MedicalNote getNoteById(Long id);
    List<MedicalNote> getNotesByPatient(Patient patient);
    List<MedicalNote> getNotesByDoctor(Long doctorId);
    List<MedicalNote> getNotesByAppointment(Long appointmentId);
    List<MedicalNote> getAllNotes();
}
