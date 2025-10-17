package com.clinique.webapp.servlet.doctor;

import com.clinique.domain.Availability;
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

@WebServlet("/doctor/availabilities/edit")
public class AvailabilityEditServlet extends HttpServlet {

    @Inject
    private AvailabilityService availabilityService;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idStr = request.getParameter("id");
        if (idStr == null) {
            response.sendRedirect(request.getContextPath() + "/doctor/availabilities?error=missing_id");
            return;
        }
        Long id = Long.parseLong(idStr);
        Availability availability = availabilityService.getAvailabilityById(id);


        request.setAttribute("availability", availability);
        request.getRequestDispatcher("/WEB-INF/views/doctor/availabilities/edit.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idStr = request.getParameter("id");
        try {
            Long id = Long.parseLong(idStr);
            DayOfWeek dayOfWeek = DayOfWeek.valueOf(request.getParameter("dayOfWeek"));
            LocalTime startTime = LocalTime.parse(request.getParameter("startTime"));
            LocalTime endTime = LocalTime.parse(request.getParameter("endTime"));
            boolean active = "on".equals(request.getParameter("active"));

            availabilityService.updateAvailability(id, dayOfWeek, startTime, endTime, active);

            response.sendRedirect(request.getContextPath() + "/doctor/availabilities?success=updated");
        } catch (Exception e) {
            Availability oldAvailability = availabilityService.getAvailabilityById(Long.parseLong(idStr));
            request.setAttribute("error", e.getMessage());
            request.setAttribute("availability", oldAvailability);
            request.getRequestDispatcher("/WEB-INF/views/doctor/availabilities/edit.jsp").forward(request, response);
        }
    }
}