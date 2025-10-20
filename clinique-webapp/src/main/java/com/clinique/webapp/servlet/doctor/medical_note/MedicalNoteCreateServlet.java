package com.clinique.webapp.servlet.doctor.medical_note;

import com.clinique.domain.*;
import com.clinique.domain.Enum.AppointmentStatus;
import jakarta.servlet.annotation.WebServlet;
import service.Interface.AppointmentService;
import service.Interface.DoctorService;
import service.Interface.MedicalNoteService;
import jakarta.inject.Inject;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.time.format.DateTimeFormatter;

@WebServlet("/doctor/medical-note/create")
public class MedicalNoteCreateServlet extends HttpServlet {

    @Inject
    private AppointmentService appointmentService;

    @Inject
    private MedicalNoteService medicalNoteService;

    @Inject
    private DoctorService doctorService;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        try {
            String appointmentIdStr = req.getParameter("appointmentId");

            if (appointmentIdStr == null) {
                resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "ID de rendez-vous manquant");
                return;
            }

            Long appointmentId = Long.parseLong(appointmentIdStr);

            User user = (User) req.getSession().getAttribute("user");
            if (user == null) {
                resp.sendRedirect(req.getContextPath() + "/login");
                return;
            }

            Doctor doctor = doctorService.findByUserId(user.getId())
                    .orElseThrow(() -> new IllegalArgumentException("Aucun médecin associé à cet utilisateur."));

            // Charger l'appointment avec toutes les relations nécessaires
            Appointment appointment = appointmentService.getAppointmentWithPatient(appointmentId);

            if (appointment == null) {
                resp.sendError(HttpServletResponse.SC_NOT_FOUND, "Rendez-vous introuvable");
                return;
            }

            // Vérifier que le rendez-vous appartient bien à ce docteur
            if (!appointment.getDoctor().getId().equals(doctor.getId())) {
                resp.sendError(HttpServletResponse.SC_FORBIDDEN, "Accès non autorisé");
                return;
            }

            // Vérifier que le rendez-vous est terminé
            if (!appointment.getStatus().equals(AppointmentStatus.COMPLETED)) {
                resp.sendError(HttpServletResponse.SC_BAD_REQUEST,
                        "La note médicale ne peut être créée que pour un rendez-vous terminé");
                return;
            }

            Patient patient = appointment.getPatient();

            DateTimeFormatter dateFormatter = DateTimeFormatter.ofPattern("dd/MM/yyyy");
            DateTimeFormatter timeFormatter = DateTimeFormatter.ofPattern("HH:mm");

            String formattedDate = appointment.getStartDatetime().format(dateFormatter);
            String formattedTime = appointment.getStartDatetime().format(timeFormatter);

            req.setAttribute("doctor", doctor);
            req.setAttribute("patient", patient);
            req.setAttribute("appointment", appointment);
            req.setAttribute("formattedDate", formattedDate);
            req.setAttribute("formattedTime", formattedTime);

            req.getRequestDispatcher("/WEB-INF/views/doctor/noteMedical/medical_note.jsp")
                    .forward(req, resp);

        } catch (NumberFormatException e) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "ID de rendez-vous invalide");
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "Erreur: " + e.getMessage());
            req.getRequestDispatcher("/WEB-INF/views/error.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        try {
            Long appointmentId = Long.parseLong(req.getParameter("appointmentId"));
            String content = req.getParameter("content");

            if (content == null || content.trim().isEmpty()) {
                req.setAttribute("error", "Le contenu de la note est obligatoire");
                doGet(req, resp);
                return;
            }

            User user = (User) req.getSession().getAttribute("user");
            if (user == null) {
                resp.sendRedirect(req.getContextPath() + "/login");
                return;
            }

            Doctor doctor = doctorService.findByUserId(user.getId())
                    .orElseThrow(() -> new IllegalArgumentException("Aucun médecin associé à cet utilisateur."));

            // Charger l'appointment avec le patient
            Appointment appointment = appointmentService.getAppointmentWithPatient(appointmentId);

            if (appointment == null) {
                resp.sendError(HttpServletResponse.SC_NOT_FOUND, "Rendez-vous introuvable");
                return;
            }

            Patient patient = appointment.getPatient();

            MedicalNote note = new MedicalNote();
            note.setContent(content.trim());
            note.setDoctor(doctor);
            note.setPatient(patient);
            note.setAppointment(appointment);

            medicalNoteService.addNote(note);

            resp.sendRedirect(req.getContextPath() + "/doctor/agenda?success=note_created");

        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "Erreur lors de l'enregistrement: " + e.getMessage());
            doGet(req, resp);
        }
    }
}