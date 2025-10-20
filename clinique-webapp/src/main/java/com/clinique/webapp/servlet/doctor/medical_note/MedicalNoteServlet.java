package com.clinique.webapp.servlet.doctor.medical_note;

import com.clinique.domain.Doctor;
import com.clinique.domain.MedicalNote;
import com.clinique.domain.User;
import jakarta.inject.Inject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import service.Interface.DoctorService;
import service.Interface.MedicalNoteService;

import java.io.IOException;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

@WebServlet("/doctor/medical-notes")
public class MedicalNoteServlet extends HttpServlet {

    @Inject
    private MedicalNoteService medicalNoteService;

    @Inject
    private DoctorService doctorService;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        User user = (User) req.getSession().getAttribute("user");
        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        try {
            Long userId = user.getId();
            Doctor doctor = doctorService.findByUserId(userId)
                    .orElseThrow(() -> new IllegalArgumentException(
                            "Aucun médecin associé à cet utilisateur."));

            List<MedicalNote> medicalNotes = medicalNoteService.getNotesByDoctor(doctor.getId());

            // Compter les patients uniques
            Set<Long> uniquePatientIds = medicalNotes.stream()
                    .map(note -> note.getPatient().getId())
                    .collect(Collectors.toSet());

            int uniquePatientCount = uniquePatientIds.size();

            req.setAttribute("medical_notes", medicalNotes);
            req.setAttribute("uniquePatientCount", uniquePatientCount);

            req.getRequestDispatcher("/WEB-INF/views/doctor/noteMedical/medical_note_show.jsp")
                    .forward(req, resp);

        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "Erreur lors du chargement des notes: " + e.getMessage());
            req.getRequestDispatcher("/WEB-INF/views/error.jsp").forward(req, resp);
        }
    }
}