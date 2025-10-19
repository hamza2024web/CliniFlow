package com.clinique.webapp.servlet.patient.appointment;

import com.clinique.domain.Doctor;
import com.clinique.domain.Enum.AppointmentType;
import jakarta.servlet.annotation.WebServlet;
import service.Interface.AppointmentService;
import service.Interface.DoctorService;
import jakarta.inject.Inject;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import service.TimeSlot;

import java.io.IOException;
import java.time.LocalDate;
import java.util.List;

@WebServlet("/patient/appointment/select-slot")
public class SlotSelectionServlet extends HttpServlet {

    @Inject
    private AppointmentService appointmentService;

    @Inject
    private DoctorService doctorService;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        try {
            // Récupération des paramètres
            String doctorIdStr = req.getParameter("doctorId");
            String specialtyId = req.getParameter("specialtyId");
            String dateStr = req.getParameter("date");
            String appointmentTypeStr = req.getParameter("appointmentType");

            // Validation
            if (doctorIdStr == null || dateStr == null || appointmentTypeStr == null) {
                req.setAttribute("error", "Paramètres manquants");
                req.getRequestDispatcher("/WEB-INF/views/error.jsp").forward(req, resp);
                return;
            }

            // Parsing
            Long doctorId = Long.parseLong(doctorIdStr);
            LocalDate date = LocalDate.parse(dateStr);
            AppointmentType appointmentType = AppointmentType.valueOf(appointmentTypeStr);

            Doctor doctor = doctorService.findById(doctorId)
                    .orElseThrow(() -> new IllegalArgumentException("Docteur introuvable avec l'ID: " + doctorId));

            // Récupération des créneaux disponibles
            List<TimeSlot> slots = appointmentService.getAvailableSlots(doctor, date, appointmentType);

            // Passage des données à la JSP
            req.setAttribute("slots", slots);
            req.setAttribute("doctor", doctor);
            req.setAttribute("doctorId", doctorIdStr);
            req.setAttribute("specialtyId", specialtyId);
            req.setAttribute("date", dateStr);
            req.setAttribute("appointmentType", appointmentTypeStr);

            req.getRequestDispatcher("/WEB-INF/views/patient/appointment/select_slot.jsp")
                    .forward(req, resp);

        } catch (NumberFormatException e) {
            req.setAttribute("error", "ID de docteur invalide");
            req.getRequestDispatcher("/WEB-INF/views/error.jsp").forward(req, resp);

        } catch (IllegalArgumentException e) {
            req.setAttribute("error", e.getMessage());
            req.getRequestDispatcher("/WEB-INF/views/error.jsp").forward(req, resp);

        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "Erreur lors de la récupération des créneaux: " + e.getMessage());
            req.getRequestDispatcher("/WEB-INF/views/error.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        try {
            // Récupération des paramètres
            String doctorId = req.getParameter("doctorId");
            String specialtyId = req.getParameter("specialtyId");
            String date = req.getParameter("date");
            String appointmentType = req.getParameter("appointmentType");
            String slotStart = req.getParameter("slotStart");

            // Validation
            if (doctorId == null || date == null || appointmentType == null || slotStart == null) {
                req.setAttribute("error", "Paramètres manquants pour la réservation");
                req.getRequestDispatcher("/WEB-INF/views/error.jsp").forward(req, resp);
                return;
            }

            // Redirection vers la confirmation
            resp.sendRedirect(req.getContextPath() +
                    "/patient/appointment/confirm-reservation?doctorId=" + doctorId +
                    "&specialtyId=" + specialtyId +
                    "&date=" + date +
                    "&appointmentType=" + appointmentType +
                    "&slotStart=" + slotStart);

        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "Erreur lors de la réservation: " + e.getMessage());
            req.getRequestDispatcher("/WEB-INF/views/error.jsp").forward(req, resp);
        }
    }
}