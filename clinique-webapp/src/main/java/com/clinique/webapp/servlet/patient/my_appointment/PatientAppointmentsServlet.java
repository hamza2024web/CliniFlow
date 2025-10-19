package com.clinique.webapp.servlet.patient.my_appointment;

import com.clinique.domain.Patient;
import com.clinique.domain.Appointment;
import com.clinique.domain.User;
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

            Map<Long, String> formattedDates = appointments.stream().collect(Collectors.toMap(
                            Appointment::getId,
                            apt -> apt.getStartDatetime().format(dateFormatter)
                    ));

            Map<Long, String> formattedStartTimes = appointments.stream().collect(Collectors.toMap(
                            Appointment::getId,
                            apt -> apt.getStartDatetime().format(timeFormatter)
                    ));

            Map<Long, String> formattedEndTimes = appointments.stream().collect(Collectors.toMap(
                            Appointment::getId,
                            apt -> apt.getEndDatetime().format(timeFormatter)
                    ));

            req.setAttribute("appointments", appointments);
            req.setAttribute("formattedDates", formattedDates);
            req.setAttribute("formattedStartTimes", formattedStartTimes);
            req.setAttribute("formattedEndTimes", formattedEndTimes);

            req.getRequestDispatcher("/WEB-INF/views/patient/my_appointment/patient_appointments.jsp").forward(req, resp);
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "Erreur: " + e.getMessage());
            req.getRequestDispatcher("/WEB-INF/views/error.jsp").forward(req, resp);
        }
    }
}