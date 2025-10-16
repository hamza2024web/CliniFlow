package com.clinique.webapp.servlet.doctor;

import com.clinique.domain.Availability;
import com.clinique.domain.Doctor;
import com.clinique.domain.Enum.DayOfWeek;
import jakarta.inject.Inject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import service.Interface.AvailabilityService;

import java.io.IOException;
import java.time.LocalTime;

@WebServlet("/doctor/availabilities/create")
public class AvailabilityCreateServlet extends HttpServlet {

    @Inject
    private AvailabilityService availabilityService;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/views/doctor/availabilities/create.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            Doctor doctor = (Doctor) request.getSession().getAttribute("doctor");
            if (doctor == null) {
                response.sendRedirect(request.getContextPath() + "/login");
                return;
            }

            DayOfWeek dayOfWeek = DayOfWeek.valueOf(request.getParameter("dayOfWeek"));
            LocalTime startTime = LocalTime.parse(request.getParameter("startTime"));
            LocalTime endTime = LocalTime.parse(request.getParameter("endTime"));

            availabilityService.createAvailability(doctor, dayOfWeek, startTime, endTime);

            response.sendRedirect(request.getContextPath() + "/doctor/availabilities?success=created");
        } catch (Exception e) {
            request.setAttribute("error", e.getMessage());
            request.getRequestDispatcher("/WEB-INF/views/doctor/availabilities/create.jsp").forward(request, response);
        }
    }
}