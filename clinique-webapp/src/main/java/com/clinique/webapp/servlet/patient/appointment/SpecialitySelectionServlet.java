package com.clinique.webapp.servlet.patient.appointment;


import com.clinique.domain.Specialty;

import jakarta.inject.Inject;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import repository.Interface.SpecialityRepository;

import java.io.IOException;
import java.util.List;

@WebServlet("/patient/appointment/book-appointment")
public class SpecialitySelectionServlet extends HttpServlet {
    @Inject
    private SpecialityRepository specialtyRepository;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<Specialty> specialties = specialtyRepository.findAll();
        req.setAttribute("specialties", specialties);
        req.getRequestDispatcher("/WEB-INF/views/patient/appointment/select_specialty.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String specialtyId = req.getParameter("specialtyId");
        resp.sendRedirect(req.getContextPath() + "/patient/appointment/select-doctor?specialtyId=" + specialtyId);
    }
}