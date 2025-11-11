package com.clinique.webapp.servlet.admin.specialty;

import com.clinique.domain.Specialty;
import jakarta.inject.Inject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import service.Interface.SpecialtyService;

import java.io.IOException;
import java.util.List;

@WebServlet("/admin/specialties")
public class SpecialtyListServlet extends HttpServlet {

    @Inject
    private SpecialtyService specialtyService;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<Specialty> specialties = specialtyService.getAllSpecialties();
        req.setAttribute("specialties", specialties);
        req.getRequestDispatcher("/WEB-INF/views/admin/specialties/list.jsp").forward(req, resp);
    }
}
