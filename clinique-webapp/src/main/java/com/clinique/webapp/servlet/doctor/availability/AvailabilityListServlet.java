package com.clinique.webapp.servlet.doctor.availability;

import com.clinique.domain.Availability;
import com.clinique.domain.Doctor;
import com.clinique.domain.User;
import jakarta.inject.Inject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import service.Interface.AvailabilityService;
import service.Interface.DoctorService;

import java.io.IOException;
import java.util.List;

@WebServlet("/doctor/availabilities")
public class AvailabilityListServlet extends HttpServlet {

    @Inject
    private AvailabilityService availabilityService;

    @Inject
    private DoctorService doctorService;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("user");
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        try {
            Long id = user.getId();
            Doctor doctor = doctorService.findByUserId(id)
                    .orElseThrow(() -> new IllegalArgumentException("Aucun médecin associé à cet utilisateur."));

            List<Availability> availabilities = availabilityService.getAvailabilitiesByDoctor(doctor);
            request.setAttribute("availabilities", availabilities);
            request.getRequestDispatcher("/WEB-INF/views/doctor/availabilities/list.jsp").forward(request, response);

        } catch (IllegalArgumentException e) {
            request.setAttribute("error", e.getMessage());
            request.getRequestDispatcher("/WEB-INF/views/doctor/availabilities/list.jsp").forward(request, response);
        } catch (Exception e) {
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Erreur serveur : " + e.getMessage());
        }
    }
}
