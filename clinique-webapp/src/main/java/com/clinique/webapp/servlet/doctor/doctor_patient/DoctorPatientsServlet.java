package com.clinique.webapp.servlet.doctor.doctor_patient;

import com.clinique.domain.Doctor;
import com.clinique.domain.Patient;
import jakarta.servlet.annotation.WebServlet;
import service.Interface.AppointmentService;

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
        Doctor doctor = (Doctor) req.getSession().getAttribute("doctor");
        List<Patient> patients = doctorService.getPatientsByDoctor(doctor.getId());
        req.setAttribute("patients", patients);
        req.getRequestDispatcher("/WEB-INF/views/mesPatients/doctor_patients.jsp").forward(req, resp);
    }
}