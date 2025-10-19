package com.clinique.webapp.servlet.patient.appointment;

import com.clinique.domain.*;
import com.clinique.domain.Enum.AppointmentType;
import com.clinique.domain.Enum.Priority;
import jakarta.servlet.annotation.WebServlet;
import service.Interface.AppointmentService;
import jakarta.inject.Inject;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import service.Interface.DoctorService;
import service.Interface.PatientService;

import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

@WebServlet("/patient/appointment/confirm-reservation")
public class ReservationServlet extends HttpServlet {

    @Inject
    private AppointmentService appointmentService;

    @Inject
    private DoctorService doctorService;

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

            // Récupération des paramètres
            Long doctorId = Long.parseLong(req.getParameter("doctorId"));
            LocalDateTime slotStart = LocalDateTime.parse(req.getParameter("slotStart"));
            AppointmentType appointmentType = AppointmentType.valueOf(req.getParameter("appointmentType"));

            // Récupération du docteur
            Doctor doctor = doctorService.findById(doctorId)
                    .orElseThrow(() -> new IllegalArgumentException("Docteur introuvable"));

            // Récupération du patient
            Patient patient = patientService.findByUserId(user.getId())
                    .orElseThrow(() -> new IllegalArgumentException("Patient introuvable"));

            // Création du rendez-vous
            Priority priority = Priority.MEDIUM;
            Appointment appointment = appointmentService.createAppointment(
                    patient, doctor, slotStart, appointmentType, priority
            ).orElseThrow(() -> new RuntimeException("Échec création RDV"));

            DateTimeFormatter dateFormatter = DateTimeFormatter.ofPattern("dd/MM/yyyy");
            DateTimeFormatter timeFormatter = DateTimeFormatter.ofPattern("HH:mm");

            String formattedDate = appointment.getStartDatetime().format(dateFormatter);
            String formattedStartTime = appointment.getStartDatetime().format(timeFormatter);
            String formattedEndTime = appointment.getEndDatetime().format(timeFormatter);

            // Formater le nom du type de consultation
            String consultationType = getConsultationTypeLabel(appointment.getAppointmentType());

            req.setAttribute("appointment", appointment);
            req.setAttribute("formattedDate", formattedDate);
            req.setAttribute("formattedStartTime", formattedStartTime);
            req.setAttribute("formattedEndTime", formattedEndTime);
            req.setAttribute("consultationType", consultationType);

            req.getRequestDispatcher("/WEB-INF/views/patient/appointment/confirmation.jsp")
                    .forward(req, resp);

        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "Erreur: " + e.getMessage());
            req.getRequestDispatcher("/WEB-INF/views/error.jsp").forward(req, resp);
        }
    }

    private String getConsultationTypeLabel(AppointmentType type) {
        if (type == null) return "";
        switch (type) {
            case CONSULTATION:
                return "Consultation standard";
            case SPECIALIZED:
                return "Consultation spécialisée";
            case URGENCY:
                return "Urgence";
            default:
                return type.toString();
        }
    }
}