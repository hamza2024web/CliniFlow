package com.clinique.webapp.servlet.doctor.availability;

import com.clinique.domain.Availability;
import com.clinique.domain.Doctor;
import jakarta.inject.Inject;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import service.Interface.AvailabilityService;
import service.Interface.DoctorService;

import java.io.IOException;
import java.util.List;

public class AvailabilityListServlet extends HttpServlet {

    @Inject
    private AvailabilityService availabilityService;

    @Inject
    private DoctorService doctorService;

    @Override
    protected void doGet(HttpServletRequest request , HttpServletResponse response) throws ServletException, IOException {
        Doctor doctor = (Doctor) request.getSession().getAttribute("doctor");

        if (doctor == null){
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        List<Availability> availabilities = availabilityService.getAvailabilitiesByDoctor(doctor);
        request.setAttribute("availabilities",availabilities);
        request.getRequestDispatcher("/WEB-INF/views/doctor/availabilities/list.jsp").forward(request,response);
    }
}
