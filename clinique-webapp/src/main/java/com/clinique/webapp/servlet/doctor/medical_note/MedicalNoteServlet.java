package com.clinique.webapp.servlet.doctor.medical_note;

import com.clinique.domain.Doctor;
import com.clinique.domain.MedicalNote;
import com.clinique.domain.User;
import jakarta.inject.Inject;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import service.Interface.DoctorService;
import service.Interface.MedicalNoteService;

import java.io.IOException;
import java.util.List;

public class MedicalNoteServlet {
    @Inject
    private MedicalNoteService medicalnote;

    @Inject
    private DoctorService doctorService;

    @Override
    protected void doGet(HttpServletRequest req , HttpServletResponse resp) throws ServletException, IOException {
        User user = (User) req.getSession().getAttribute("user");
        if (user == null){
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }
        Long id = user.getId();
        Doctor doctor = doctorService.findByUserId(id).orElseThrow(() -> new IllegalArgumentException("Aucun médecine associé à cet utilisateur."));

        List<MedicalNote> medical_notes = medicalnote.getNotesByDoctor(doctor.getId());
        req.setAttribute("medical_notes",medical_notes);
        req.getRequestDispatcher("/WEB-INF/views/doctor/noteMedical/medical_note_show.jsp");
    }
}
