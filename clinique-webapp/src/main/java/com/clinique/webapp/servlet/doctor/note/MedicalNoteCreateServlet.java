package com.clinique.webapp.servlet.doctor.note;


import com.clinique.domain.*;
import jakarta.servlet.annotation.WebServlet;
import service.Interface.AppointmentService;
import service.Interface.DoctorService;
import service.Interface.MedicalNoteService;

import jakarta.inject.Inject;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/doctor/medical-note/create")
public class MedicalNoteCreateServlet extends HttpServlet {
    @Inject
    private AppointmentService appointmentService;
    @Inject
    private MedicalNoteService medicalNoteService;
    @Inject
    private DoctorService doctorService;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String appointmentIdStr = req.getPathInfo().substring(1);
        Long appointmentId = Long.parseLong(appointmentIdStr);

        Appointment appointment = appointmentService.getAppointmentById(appointmentId);

        User user = (User) req.getSession().getAttribute("user");

        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        Long id = user.getId();
        Doctor doctor = doctorService.findByUserId(id).orElseThrow(() -> new IllegalArgumentException("Aucun médecine associé à cet utilisateur."));

        Patient patient = appointment.getPatient();

        req.setAttribute("doctor", doctor);
        req.setAttribute("patient", patient);
        req.setAttribute("appointment", appointment);

        req.getRequestDispatcher("/WEB-INF/views/doctor/noteMedical/medical_note.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Long appointmentId = Long.parseLong(req.getParameter("appointmentId"));
        String content = req.getParameter("content");

        Appointment appointment = appointmentService.getAppointmentById(appointmentId);

        User user = (User) req.getSession().getAttribute("user");

        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        Long id = user.getId();
        Doctor doctor = doctorService.findByUserId(id).orElseThrow(() -> new IllegalArgumentException("Aucun médecine associé à cet utilisateur."));

        Patient patient = appointment.getPatient();

        MedicalNote note = new MedicalNote();
        note.setContent(content);
        note.setDoctor(doctor);
        note.setPatient(patient);
        note.setAppointment(appointment);

        medicalNoteService.addNote(note);

        resp.sendRedirect(req.getContextPath() + "/doctor/agenda");
    }
}