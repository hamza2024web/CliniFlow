package com.clinique.webapp.servlet.patient.appointment;

import com.clinique.domain.Doctor;
import jakarta.servlet.annotation.WebServlet;
import repository.Interface.SpecialityRepository;
import com.clinique.domain.Specialty;

import jakarta.inject.Inject;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import service.Interface.DoctorService;

import java.io.IOException;
import java.util.List;

@WebServlet("/patient/appointment/select-doctor")
public class DoctorSelectionServlet extends HttpServlet {
    @Inject
    private DoctorService doctorService;
    @Inject
    private SpecialityRepository specialtyRepository;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String specialtyIdStr = req.getParameter("specialtyId");
        Long specialtyId = Long.parseLong(specialtyIdStr);

        Specialty specialty = specialtyRepository.findById(specialtyId).orElse(null);

        List<Doctor> doctors = doctorService.findBySpecialtyId(specialtyId);
        req.setAttribute("doctors", doctors);
        req.setAttribute("specialtyId", specialtyIdStr);
        req.setAttribute("specialty", specialty);
        req.getRequestDispatcher("/WEB-INF/views/patient/appointment/select_doctor.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String doctorId = req.getParameter("doctorId");
        String specialtyId = req.getParameter("specialtyId");
        resp.sendRedirect(req.getContextPath() + "/patient/appointment/select-date-type?doctorId=" + doctorId + "&specialtyId=" + specialtyId);
    }
}