package com.clinique.webapp.servlet.doctor.agenda;

import com.clinique.domain.Doctor;
import com.clinique.domain.Appointment;
import com.clinique.domain.User;
import jakarta.servlet.annotation.WebServlet;
import service.Interface.AppointmentService;

import jakarta.inject.Inject;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import service.Interface.DoctorService;

import java.io.IOException;
import java.util.List;

@WebServlet("/doctor/agenda")
public class DoctorAgendaServlet extends HttpServlet {
    @Inject
    private AppointmentService appointmentService;
    @Inject
    private DoctorService doctorService;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        User user = (User) req.getSession().getAttribute("user");
        if (user == null){
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }
        Long id = user.getId();
        Doctor doctor = doctorService.findByUserId(id).orElseThrow(() -> new IllegalArgumentException("Aucun médecine associé à cet utilisateur."));
        List<Appointment> appointments = appointmentService.getAppointmentsByDoctor(doctor.getId());
        req.setAttribute("appointments", appointments);
        req.getRequestDispatcher("/WEB-INF/views/doctor/agenda/doctor_agenda.jsp").forward(req, resp);
    }
}