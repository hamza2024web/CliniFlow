package com.clinique.webapp.servlet.admin.specialty;

import com.clinique.domain.Specialty;
import com.clinique.domain.Department;
import jakarta.inject.Inject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import service.Interface.DepartmentService;
import service.Interface.SpecialtyService;

import java.io.IOException;
import java.util.List;

@WebServlet("/admin/specialties/edit")
public class SpecialtyEditServlet extends HttpServlet {
    @Inject
    private SpecialtyService specialtyService;

    @Inject
    private DepartmentService departmentService;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String idStr = req.getParameter("id");
        if (idStr == null) {
            resp.sendRedirect(req.getContextPath() + "/admin/specialties?error=missing_id");
            return;
        }
        Long id = Long.parseLong(idStr);
        Specialty s = specialtyService.getSpecialtyById(id);
        List<Department> departments = departmentService.getAllDepartments();
        req.setAttribute("departments", departments);
        req.setAttribute("specialty", s);
        req.getRequestDispatcher("/WEB-INF/views/admin/specialties/edit.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String idStr = req.getParameter("id");
        String name = req.getParameter("name");
        String code = req.getParameter("code");
        String departmentId = req.getParameter("departmentId");
        try {
            specialtyService.updateSpecialty(Long.parseLong(idStr), name, code, Long.parseLong(departmentId));
            resp.sendRedirect(req.getContextPath() + "/admin/specialties?success=updated");
        } catch (Exception e) {
            Specialty s = specialtyService.getSpecialtyById(Long.parseLong(idStr));
            List<Department> departments = departmentService.getAllDepartments();
            req.setAttribute("departments", departments);
            req.setAttribute("specialty", s);
            req.setAttribute("error", e.getMessage());
            req.getRequestDispatcher("/WEB-INF/views/admin/specialties/edit.jsp").forward(req, resp);
        }
    }
}