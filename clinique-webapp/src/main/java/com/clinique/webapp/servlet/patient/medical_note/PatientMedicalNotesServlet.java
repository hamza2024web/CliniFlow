package com.clinique.webapp.servlet.patient.medical_note;

import com.clinique.domain.MedicalNote;
import com.clinique.domain.Patient;
import com.clinique.domain.User;
import jakarta.servlet.annotation.WebServlet;
import jakarta.inject.Inject;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import service.Interface.MedicalNoteService;
import service.Interface.PatientService;

import java.io.IOException;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@WebServlet("/patient/medical-notes")
public class PatientMedicalNotesServlet extends HttpServlet {

    @Inject
    private MedicalNoteService medicalNoteService;

    @Inject
    private PatientService patientService;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        try {
            User user = (User) req.getSession().getAttribute("user");
            if (user == null) {
                resp.sendRedirect(req.getContextPath() + "/login");
                return;
            }

            Patient patient = patientService.findByUserId(user.getId())
                    .orElseThrow(() -> new IllegalArgumentException("Patient introuvable"));

            List<MedicalNote> notes = medicalNoteService.getNotesByPatient(patient);

            DateTimeFormatter dateFormatter = DateTimeFormatter.ofPattern("dd/MM/yyyy 'à' HH:mm");

            Map<Long, String> formattedDates = notes.stream()
                    .collect(Collectors.toMap(
                            MedicalNote::getId,
                            note -> note.getCreatedAt().format(dateFormatter)
                    ));

            req.setAttribute("notes", notes);
            req.setAttribute("formattedDates", formattedDates);

            req.getRequestDispatcher("/WEB-INF/views/patient/medical_note/medical_notes.jsp")
                    .forward(req, resp);

        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "Erreur: " + e.getMessage());
            req.getRequestDispatcher("/WEB-INF/views/error.jsp").forward(req, resp);
        }
    }
}