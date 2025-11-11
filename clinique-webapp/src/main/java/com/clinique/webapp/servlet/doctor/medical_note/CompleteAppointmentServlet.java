package com.clinique.webapp.servlet.doctor.medical_note;

import com.clinique.domain.User;
import jakarta.inject.Inject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import service.Interface.AppointmentService;

import java.io.IOException;

@WebServlet("/doctor/appointment/complete")
public class CompleteAppointmentServlet extends HttpServlet {
    @Inject
    private AppointmentService appointmentService;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        User user = (User) req.getSession().getAttribute("user");
        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        String appointmentIdStr = req.getParameter("appointmentId");
        if (appointmentIdStr != null) {
            try {
                Long appointmentId = Long.parseLong(appointmentIdStr);
                appointmentService.markAsCompleted(appointmentId);
            } catch (NumberFormatException e) {
                resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "ID de rendez-vous invalide");
                return;
            }
        }

        resp.sendRedirect(req.getContextPath() + "/doctor/agenda");
    }
}
