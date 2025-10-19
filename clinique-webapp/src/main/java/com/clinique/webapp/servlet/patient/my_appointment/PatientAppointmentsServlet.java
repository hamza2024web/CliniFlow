package com.clinique.webapp.servlet.patient.my_appointment;

import com.clinique.domain.Patient;
import com.clinique.domain.Appointment;
import com.clinique.domain.User;
import com.clinique.webapp.dto.AppointmentDTO;
import jakarta.servlet.annotation.WebServlet;
import service.Interface.AppointmentService;
import jakarta.inject.Inject;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import service.Interface.PatientService;

import java.io.IOException;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@WebServlet("/patient/mes_rendez_vous")
public class PatientAppointmentsServlet extends HttpServlet {

    @Inject
    private AppointmentService appointmentService;

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

            List<Appointment> appointments = appointmentService.getAppointmentsByPatient(patient);

            DateTimeFormatter dateFormatter = DateTimeFormatter.ofPattern("dd/MM/yyyy");
            DateTimeFormatter timeFormatter = DateTimeFormatter.ofPattern("HH:mm");

            List<AppointmentDTO> appointmentDTOs = appointments.stream()
                    .map(apt -> new AppointmentDTO(
                            apt,
                            apt.getStartDatetime().format(dateFormatter),
                            apt.getStartDatetime().format(timeFormatter),
                            apt.getEndDatetime().format(timeFormatter)
                    ))
                    .collect(Collectors.toList());

            req.setAttribute("appointments", appointmentDTOs);
            req.getRequestDispatcher("/WEB-INF/views/patient/my_appointment/patient_appointments.jsp")
                    .forward(req, resp);

        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "Erreur: " + e.getMessage());
            req.getRequestDispatcher("/WEB-INF/views/error.jsp").forward(req, resp);
        }
    }
}