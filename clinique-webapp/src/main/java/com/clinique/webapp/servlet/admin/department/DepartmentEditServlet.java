package com.clinique.webapp.servlet.admin.department;

import com.clinique.domain.Department;
import jakarta.inject.Inject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import service.Interface.DepartmentService;

import java.io.IOException;

@WebServlet("/admin/departments/edit")
public class DepartmentEditServlet extends HttpServlet {
    @Inject
    private DepartmentService departmentService;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String idStr = req.getParameter("id");
        if (idStr == null) {
            resp.sendRedirect(req.getContextPath() + "/admin/departments?error=missing_id");
            return;
        }
        Long id = Long.parseLong(idStr);
        Department dep = departmentService.getDepartmentById(id);
        if (dep == null) {
            resp.sendRedirect(req.getContextPath() + "/admin/departments?error=not_found");
            return;
        }
        req.setAttribute("department", dep);
        req.getRequestDispatcher("/WEB-INF/views/admin/departments/edit.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String idStr = req.getParameter("id");
        String name = req.getParameter("name");
        String code = req.getParameter("code");
        try {
            Long id = Long.parseLong(idStr);
            departmentService.updateDepartment(id, name, code);
            resp.sendRedirect(req.getContextPath() + "/admin/departments?success=updated");
        } catch (Exception e) {
            req.setAttribute("error", e.getMessage());
            req.getRequestDispatcher("/WEB-INF/views/admin/departments/edit.jsp").forward(req, resp);
        }
    }
}