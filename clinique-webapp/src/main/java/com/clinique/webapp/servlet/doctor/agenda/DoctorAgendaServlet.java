package com.clinique.webapp.servlet.doctor.agenda;

import com.clinique.domain.Doctor;
import com.clinique.domain.Appointment;
import jakarta.servlet.annotation.WebServlet;
import service.Interface.AppointmentService;
import repository.Interface.DoctorRepository;

import jakarta.inject.Inject;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/doctor/agenda")
public class DoctorAgendaServlet extends HttpServlet {
    @Inject
    private AppointmentService appointmentService;
    @Inject
    private DoctorRepository doctorRepository;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Doctor doctor = (Doctor) req.getSession().getAttribute("doctor");
        List<Appointment> appointments = appointmentService.getAppointmentsByDoctor(doctor.getId());
        req.setAttribute("appointments", appointments);
        req.getRequestDispatcher("/WEB-INF/views/agenda/doctor_agenda.jsp").forward(req, resp);
    }
}