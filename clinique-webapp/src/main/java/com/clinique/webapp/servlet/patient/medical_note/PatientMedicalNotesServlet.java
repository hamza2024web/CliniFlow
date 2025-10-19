package com.clinique.webapp.servlet.patient.medical_note;

import com.clinique.domain.Patient;
import com.clinique.domain.MedicalNote;
import com.clinique.domain.User;
import jakarta.servlet.annotation.WebServlet;
import service.Interface.MedicalNoteService;

import jakarta.inject.Inject;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import service.Interface.PatientService;

import java.io.IOException;
import java.util.List;

@WebServlet("/patient/medical_note")
public class PatientMedicalNotesServlet extends HttpServlet {
    @Inject
    private MedicalNoteService medicalNoteService;
    @Inject
    private PatientService patientService;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        User user = (User) req.getSession().getAttribute("user");
        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        Patient patient = patientService.findByUserId(user.getId())
                .orElseThrow(() -> new IllegalArgumentException("Patient introuvable"));
        List<MedicalNote> notes = medicalNoteService.getNotesByPatient(patient.getId());
        req.setAttribute("notes", notes);
        req.getRequestDispatcher("/WEB-INF/views/patient/medical_note/patient_medical_notes.jsp").forward(req, resp);
    }
}
