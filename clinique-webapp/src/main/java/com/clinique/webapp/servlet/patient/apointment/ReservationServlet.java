package com.clinique.webapp.servlet.patient.apointment;

import com.clinique.domain.*;
import com.clinique.domain.Enum.AppointmentType;
import com.clinique.domain.Enum.Priority;
import service.Interface.AppointmentService;

import jakarta.inject.Inject;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import service.Interface.DoctorService;
import service.Interface.PatientService;

import java.io.IOException;
import java.time.LocalDate;
import java.time.LocalDateTime;

public class ReservationServlet extends HttpServlet {
    @Inject
    private AppointmentService appointmentService;
    @Inject
    private DoctorService doctorService;
    @Inject
    private PatientService patientService;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String doctorIdStr = req.getParameter("doctorId");
        String specialtyId = req.getParameter("specialtyId");
        String dateStr = req.getParameter("date");
        String appointmentTypeStr = req.getParameter("appointmentType");
        String slotStartStr = req.getParameter("slotStart");

        Long doctorId = Long.parseLong(doctorIdStr);
        Doctor doctor = doctorService.findById(doctorId).orElse(null);
        LocalDate date = LocalDate.parse(dateStr);
        LocalDateTime slotStart = LocalDateTime.parse(slotStartStr);
        AppointmentType appointmentType = AppointmentType.valueOf(appointmentTypeStr);

        // Récupérer le patient connecté (à adapter selon ton système d’auth)
        User user = (User) req.getSession().getAttribute("user");
        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        Long id = user.getId();
        Patient patient = patientService.findById(id).orElseThrow(() -> new IllegalArgumentException("Aucun Patient associé a cet utilisateur."));

        // Ici, la priorité peut être fixée, ou choisie dans la JSP précédente
        Priority priority = Priority.MEDIUM;

        // Crée le rendez-vous ou ajoute à la waiting list
        Appointment appointment = appointmentService.createAppointment(patient, doctor, slotStart, appointmentType, priority).orElse(null);

        req.setAttribute("appointment", appointment);
        req.getRequestDispatcher("/WEB-INF/views/confirmation.jsp").forward(req, resp);
    }
}