package com.clinique.webapp.servlet.doctor.doctor_patient;

import com.clinique.domain.Doctor;
import com.clinique.domain.Patient;
import com.clinique.domain.User;
import jakarta.servlet.annotation.WebServlet;

import jakarta.inject.Inject;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import service.Interface.DoctorService;

import java.io.IOException;
import java.util.List;

@WebServlet("/doctor/mes_patients")
public class DoctorPatientsServlet extends HttpServlet {
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
        List<Patient> patients = doctorService.getPatientsByDoctor(doctor.getId());
        req.setAttribute("patients", patients);
        req.getRequestDispatcher("/WEB-INF/views/doctor/mesPatients/doctor_patients.jsp").forward(req, resp);
    }
}