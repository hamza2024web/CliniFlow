<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.clinique.webapp.dto.UserDTO" %>
<!DOCTYPE html>
<html>
<head>
    <title>Gestion des Utilisateurs - Admin</title>
</head>
<body>
<div class="container">
    <a href="<%= request.getContextPath() %>/admin/dashboard" class="back-link">← Retour au Dashboard</a>

    <div class="header">
        <h1>👥 Gestion des Utilisateurs</h1>
        <a href="<%= request.getContextPath() %>/admin/users/create" class="btn btn-primary">
            ➕ Créer un utilisateur
        </a>
    </div>

    <%
        String success = request.getParameter("success");
        String error = request.getParameter("error");

        if (success != null) {
            String message = "";
            switch(success) {
                case "created": message = "✓ Utilisateur créé avec succès !"; break;
                case "updated": message = "✓ Utilisateur modifié avec succès !"; break;
                case "deleted": message = "✓ Utilisateur supprimé avec succès !"; break;
                case "status_updated": message = "✓ Statut de l'utilisateur modifié !"; break;
                default: message = "✓ Opération réussie !";
            }
    %>
    <div class="alert alert-success"><%= message %></div>
    <%
        }

        if (error != null) {
            String message = "";
            switch(error) {
                case "missing_id": message = "❌ ID manquant."; break;
                case "user_not_found": message = "❌ Utilisateur introuvable."; break;
                case "invalid_id": message = "❌ ID invalide."; break;
                case "cannot_delete_self": message = "❌ Vous ne pouvez pas vous supprimer vous-même."; break;
                case "delete_failed": message = "❌ Échec de la suppression."; break;
                case "server_error": message = "❌ Erreur serveur."; break;
                default: message = "❌ Une erreur est survenue.";
            }
    %>
    <div class="alert alert-error"><%= message %></div>
    <% } %>

    <%
        List<UserDTO> users = (List<UserDTO>) request.getAttribute("users");
        if (users == null || users.isEmpty()) {
    %>
    <div class="no-data">
        <p>Aucun utilisateur trouvé.</p>
    </div>
    <%
    } else {
    %>
    <table>
        <thead>
        <tr>
            <th>ID</th>
            <th>Nom Complet</th>
            <th>Email</th>
            <th>Rôle</th>
            <th>Statut</th>
            <th>Date de Création</th>
            <th>Actions</th>
        </tr>
        </thead>
        <tbody>
        <%
            for (UserDTO user : users) {
                // Récupérer le rôle (déjà sous forme de String dans le DTO)
                String role = user.getRole();
                String roleDisplay = (role != null) ? role : "N/A";

                // Déterminer la classe CSS du badge selon le rôle
                String badgeClass = "badge";
                if (role != null) {
                    switch(role) {
                        case "ADMIN":
                            badgeClass += " badge-admin";
                            break;
                        case "DOCTOR":
                            badgeClass += " badge-doctor";
                            break;
                        case "PATIENT":
                            badgeClass += " badge-patient";
                            break;
                        case "STAFF":
                            badgeClass += " badge-staff";
                            break;
                    }
                }
        %>
        <tr>
            <td>#<%= user.getId() %></td>
            <td><strong><%= user.getFullName() %></strong></td>
            <td><%= user.getEmail() %></td>
            <td>
                <span class="<%= badgeClass %>"><%= roleDisplay %></span>
            </td>
            <td>
                <% if (user.isActive()) { %>
                <span class="status status-active">Actif</span>
                <% } else { %>
                <span class="status status-inactive">Inactif</span>
                <% } %>
            </td>
            <td><%= user.getCreatedAt() != null ? user.getCreatedAt().toString().substring(0, 10) : "N/A" %></td>
            <td>
                <div class="actions">
                    <a href="<%= request.getContextPath() %>/admin/users/edit?id=<%= user.getId() %>"
                       class="btn btn-warning btn-sm" title="Modifier">
                        ✏️ Modifier
                    </a>

                    <form method="post" action="<%= request.getContextPath() %>/admin/users/toggle-status"
                          style="display: inline; margin: 0;">
                        <input type="hidden" name="id" value="<%= user.getId() %>">
                        <button type="submit"
                                class="btn <%= user.isActive() ? "btn-secondary" : "btn-success" %> btn-sm"
                                title="<%= user.isActive() ? "Désactiver" : "Activer" %>">
                            <%= user.isActive() ? "🚫 Désactiver" : "✓ Activer" %>
                        </button>
                    </form>

                    <form method="post" action="<%= request.getContextPath() %>/admin/users/delete"
                          style="display: inline; margin: 0;"
                          onsubmit="return confirm('⚠️ Êtes-vous sûr de vouloir supprimer <%= user.getFullName() %> ?');">
                        <input type="hidden" name="id" value="<%= user.getId() %>">
                        <button type="submit" class="btn btn-danger btn-sm" title="Supprimer">
                            🗑️ Supprimer
                        </button>
                    </form>
                </div>
            </td>
        </tr>
        <% } %>
        </tbody>
    </table>
    <% } %>
</div>
</body>
</html>