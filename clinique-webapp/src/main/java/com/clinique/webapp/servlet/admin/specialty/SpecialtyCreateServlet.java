package com.clinique.webapp.servlet.admin.specialty;

import com.clinique.domain.Department;
import jakarta.inject.Inject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import service.Interface.DepartmentService;
import service.Interface.SpecialtyService;

import java.io.IOException;
import java.util.List;

@WebServlet("/admin/specialties/create")
public class SpecialtyCreateServlet extends HttpServlet {
    @Inject
    private SpecialtyService specialtyService;

    @Inject
    private DepartmentService departmentService;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Pour l'affichage de la liste des départements
        List<Department> departments = departmentService.getAllDepartments();
        req.setAttribute("departments", departments);
        req.getRequestDispatcher("/WEB-INF/views/admin/specialties/create.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String name = req.getParameter("name");
        String code = req.getParameter("code");
        String departmentId = req.getParameter("departmentId");
        try {
            specialtyService.createSpecialty(name, code, Long.parseLong(departmentId));
            resp.sendRedirect(req.getContextPath() + "/admin/specialties?success=created");
        } catch (Exception e) {
            List<Department> departments = departmentService.getAllDepartments();
            req.setAttribute("departments", departments);
            req.setAttribute("error", e.getMessage());
            req.getRequestDispatcher("/WEB-INF/views/admin/specialties/create.jsp").forward(req, resp);
        }
    }
}