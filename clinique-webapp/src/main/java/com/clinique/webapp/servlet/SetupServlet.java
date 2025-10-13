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
                    "Admin Clinique",
                    "said",
                    "admin@clinique.com",
                    "admin123",
                    Role.valueOf("ADMIN")
            );
            System.out.println("✓ ADMIN créé avec succès !");
            System.out.println("  Email: admin@clinique.com");
            System.out.println("  Mot de passe: admin123");
        } else {
            System.out.println("⚠ L'utilisateur admin@clinique.com existe déjà.");
        }

        // Création de l'utilisateur DOCTOR
        if (!userService.emailExists("doctor@clinique.com")) {
            System.out.println("Création de l'utilisateur DOCTOR...");
            userService.createUser(
                    "Dr. Hamza Akroupi",
                    "hamza",
                    "doctor@clinique.com",
                    "doctor123",
                    Role.valueOf("DOCTOR")
            );
            System.out.println("✓ DOCTOR créé avec succès !");
            System.out.println("  Email: doctor@clinique.com");
            System.out.println("  Mot de passe: doctor123");
        } else {
            System.out.println("⚠ L'utilisateur doctor@clinique.com existe déjà.");
        }

        if (!userService.emailExists("patient@clinique.com")) {
            System.out.println("Création de l'utilisateur PATIENT...");
            userService.createUser(
                    "Patient Test",
                    "anwar",
                    "patient@clinique.com",
                    "patient123",
                    Role.valueOf("PATIENT")
            );
            System.out.println("✓ PATIENT créé avec succès !");
            System.out.println("  Email: patient@clinique.com");
            System.out.println("  Mot de passe: patient123");
        } else {
            System.out.println("⚠ L'utilisateur patient@clinique.com existe déjà.");
        }

        if (!userService.emailExists("staff@clinique.com")) {
            System.out.println("Création de l'utilisateur STAFF...");
            userService.createUser(
                    "Staff Réception",
                    "zakaria",
                    "staff@clinique.com",
                    "staff123",
                    Role.valueOf("STAFF")
            );
            System.out.println("✓ STAFF créé avec succès !");
            System.out.println("  Email: staff@clinique.com");
            System.out.println("  Mot de passe: staff123");
        } else {
            System.out.println("⚠ L'utilisateur staff@clinique.com existe déjà.");
        }

        System.out.println("========================================");
        System.out.println("--- INITIALISATION TERMINÉE ---");
        System.out.println("========================================");
    }
}