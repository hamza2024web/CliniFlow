package com.clinique.webapp.servlet.admin.specialty;

import jakarta.inject.Inject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import service.Interface.SpecialtyService;

import java.io.IOException;

@WebServlet("/admin/specialties/delete")
public class SpecialtyDeleteServlet extends HttpServlet {
    @Inject
    private SpecialtyService specialtyService;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String idStr = req.getParameter("id");
        try {
            specialtyService.deleteSpecialty(Long.parseLong(idStr));
            resp.sendRedirect(req.getContextPath() + "/admin/specialties?success=deleted");
        } catch (Exception e) {
            resp.sendRedirect(req.getContextPath() + "/admin/specialties?error=delete_failed");
        }
    }
}