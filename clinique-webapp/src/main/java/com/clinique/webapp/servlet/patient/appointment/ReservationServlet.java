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
import java.time.LocalDate;
import java.time.LocalDateTime;

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

        // LOGS DE DEBUG
        System.out.println("=== DEBUG START ===");
        System.out.println("appointmentService: " + appointmentService);
        System.out.println("doctorService: " + doctorService);
        System.out.println("patientService: " + patientService);

        try {
            User user = (User) req.getSession().getAttribute("user");
            System.out.println("User from session: " + user);

            if (user == null) {
                resp.sendRedirect(req.getContextPath() + "/login");
                return;
            }

            String doctorIdStr = req.getParameter("doctorId");
            System.out.println("doctorId parameter: " + doctorIdStr);

            Long doctorId = Long.parseLong(doctorIdStr);
            System.out.println("Searching for doctor with ID: " + doctorId);

            Doctor doctor = doctorService.findById(doctorId).orElse(null);
            System.out.println("Doctor found: " + doctor);

            if (doctor == null) {
                throw new IllegalArgumentException("Docteur introuvable");
            }

            LocalDate date = LocalDate.parse(req.getParameter("date"));
            LocalDateTime slotStart = LocalDateTime.parse(req.getParameter("slotStart"));
            AppointmentType appointmentType = AppointmentType.valueOf(req.getParameter("appointmentType"));

            System.out.println("Searching for patient with ID: " + user.getId());
            Patient patient = patientService.findByUserId(user.getId())
                    .orElseThrow(() -> new IllegalArgumentException("Patient introuvable"));

            System.out.println("Patient found: " + patient);

            Priority priority = Priority.MEDIUM;

            System.out.println("Creating appointment...");
            Appointment appointment = appointmentService.createAppointment(
                    patient, doctor, slotStart, appointmentType, priority
            ).orElseThrow(() -> new RuntimeException("Échec création RDV"));

            System.out.println("Appointment created: " + appointment);
            System.out.println("=== DEBUG END ===");

            req.setAttribute("appointment", appointment);
            req.getRequestDispatcher("/WEB-INF/views/patient/appointment/confirmation.jsp")
                    .forward(req, resp);

        } catch (Exception e) {
            System.err.println("=== ERROR ===");
            e.printStackTrace();
            resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                    "Erreur: " + e.getMessage());
        }
    }
}