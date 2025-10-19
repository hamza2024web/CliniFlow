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
import java.util.List;

@WebServlet("/patient/mes_rendez_vous")
public class PatientAppointmentsServlet extends HttpServlet {
    @Inject
    private AppointmentService appointmentService;

    @Inject
    private PatientService patientService;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        User user = (User) req.getSession().getAttribute("user");
        if (user == null){
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }
        Patient patient = patientService.findByUserId(user.getId()).orElseThrow(() -> new IllegalArgumentException("Patient introuvable"));
        List<Appointment> appointments = appointmentService.getAppointmentsByPatient(patient);
        req.setAttribute("appointments", appointments);
        req.getRequestDispatcher("/WEB-INF/views/patient/my_appointment/patient_appointments.jsp").forward(req, resp);
    }
}