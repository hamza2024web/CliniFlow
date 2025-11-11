package com.clinique.webapp.servlet.doctor.availability;

import com.clinique.domain.Availability;
import com.clinique.domain.Doctor;
import jakarta.inject.Inject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import service.Interface.AvailabilityService;

import java.io.IOException;

@WebServlet("/doctor/availabilities/delete")
public class AvailabilityDeleteServlet extends HttpServlet {

    @Inject
    private AvailabilityService availabilityService;

    @Override
    protected void doPost(HttpServletRequest request , HttpServletResponse response ) throws ServletException, IOException {
        String idStr = request.getParameter("id");
        try {
            Long id = Long.parseLong(idStr);

            //ici, on va ajouter la logique de vérifier qu'il n'y pas un rendez-vous associez .

            availabilityService.deleteAvailability(id);

            response.sendRedirect(request.getContextPath() + "/doctor/availabilities?success=deleted");
        } catch (Exception e){
            response.sendRedirect(request.getContextPath() + "/doctor/availabilities?error= " + java.net.URLEncoder.encode(e.getMessage(), "UTF-8"));
        }
    }
}
