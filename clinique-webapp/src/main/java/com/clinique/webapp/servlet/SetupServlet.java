package com.clinique.webapp.servlet;

import com.clinique.domain.Enum.Role;
import jakarta.inject.Inject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import service.Interface.UserService;

@WebServlet(urlPatterns = "/setup", loadOnStartup = 1)
public class SetupServlet extends HttpServlet {

    @Inject
    private UserService userService;

    @Override
    public void init() throws ServletException {
        System.out.println("========================================");
        System.out.println("--- INITIALISATION DES UTILISATEURS DE TEST ---");
        System.out.println("========================================");

        if (!userService.emailExists("admin@clinique.com")) {
            System.out.println("Création de l'utilisateur ADMIN...");
            userService.createUser(
                    "hamza",
                    "akroubi",
                    "hamzaAkroubi@clinique.com",
                    "hamza@2006",
                    Role.valueOf("ADMIN")
            );
            System.out.println("✓ ADMIN créé avec succès !");
            System.out.println("  Email: hamzaAkroubi@clinique.com");
            System.out.println("  Mot de passe: admin123");
        } else {
            System.out.println("⚠ L'utilisateur admin@clinique.com existe déjà.");
        }

        System.out.println("========================================");
        System.out.println("--- INITIALISATION TERMINÉE ---");
        System.out.println("========================================");
    }
}