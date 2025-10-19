package com.clinique.webapp.servlet.patient.appointment;

import com.clinique.domain.Doctor;
import com.clinique.domain.Enum.AppointmentType;
import jakarta.servlet.annotation.WebServlet;
import repository.Interface.DoctorRepository;
import service.Interface.AppointmentService;

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
    private DoctorRepository doctorRepository;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String doctorIdStr = req.getParameter("doctorId");
        String specialtyId = req.getParameter("specialtyId");
        String dateStr = req.getParameter("date");
        String appointmentTypeStr = req.getParameter("appointmentType");

        Long doctorId = Long.parseLong(doctorIdStr);
        Doctor doctor = doctorRepository.findById(doctorId).orElse(null);
        LocalDate date = LocalDate.parse(dateStr);
        AppointmentType appointmentType = AppointmentType.valueOf(appointmentTypeStr);

        List<TimeSlot> slots = appointmentService.getAvailableSlots(doctor, date, appointmentType);

        req.setAttribute("slots", slots);
        req.setAttribute("doctorId", doctorIdStr);
        req.setAttribute("specialtyId", specialtyId);
        req.setAttribute("date", dateStr);
        req.setAttribute("appointmentType", appointmentTypeStr);

        req.getRequestDispatcher("/WEB-INF/views/patient/appointment/select_slot.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String doctorId = req.getParameter("doctorId");
        String specialtyId = req.getParameter("specialtyId");
        String date = req.getParameter("date");
        String appointmentType = req.getParameter("appointmentType");
        String slotStart = req.getParameter("slotStart"); // format : 2025-10-20T09:30

        // Transmettre à la servlet de réservation
        resp.sendRedirect(req.getContextPath() +
                "/patient/appointment/confirm-reservation?doctorId=" + doctorId +
                "&specialtyId=" + specialtyId +
                "&date=" + date +
                "&appointmentType=" + appointmentType +
                "&slotStart=" + slotStart);
    }
}