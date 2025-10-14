package com.clinique.webapp.servlet.admin;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/admin/dashboard")
public class AdminDashboard extends HttpServlet {

    private static final java.util.logging.Logger LOGGER =
            java.util.logging.Logger.getLogger(AdminDashboard.class.getName());

    @Override
    public void init() throws ServletException {
        super.init();
        LOGGER.info("AdminDashboard servlet initialized");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        LOGGER.info("=== AdminDashboard doGet called ===");
        LOGGER.info("RequestURI: " + request.getRequestURI());

        HttpSession session = request.getSession(false);
        LOGGER.info("Session exists: " + (session != null));
        if (session != null) {
            Object user = session.getAttribute("user");
            LOGGER.info("User in session: " + (user != null));
            if (user != null) {
                LOGGER.info("User details: " + user.toString());
            }
        }

        request.getRequestDispatcher("/WEB-INF/views/admin/dashboard.jsp").forward(request, response);
        LOGGER.info("=== AdminDashboard doGet END ===");
    }
}
