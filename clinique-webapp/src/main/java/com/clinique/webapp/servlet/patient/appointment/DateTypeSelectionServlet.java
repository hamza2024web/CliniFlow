package com.clinique.webapp.servlet.patient.appointment;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/patient/appointment/select-date-type")
public class DateTypeSelectionServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Récupérer doctorId et specialtyId transmis
        String doctorId = req.getParameter("doctorId");
        String specialtyId = req.getParameter("specialtyId");

        req.setAttribute("doctorId", doctorId);
        req.setAttribute("specialtyId", specialtyId);

        req.getRequestDispatcher("/WEB-INF/views/patient/appointment/select_date_type.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String doctorId = req.getParameter("doctorId");
        String specialtyId = req.getParameter("specialtyId");
        String date = req.getParameter("date");
        String appointmentType = req.getParameter("appointmentType");

        resp.sendRedirect(req.getContextPath() +
                "/patient/appointment/select-slot?doctorId=" + doctorId +
                "&specialtyId=" + specialtyId +
                "&date=" + date +
                "&appointmentType=" + appointmentType);
    }
}