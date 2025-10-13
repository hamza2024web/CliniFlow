<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.clinique.webapp.dto.UserDTO" %>
<%@ page import="java.util.Objects" %>
<!DOCTYPE html>
<html>
<head>
    <title>Modifier un Utilisateur - Admin</title>
</head>
<body>
<div class="container">
    <a href="<%= request.getContextPath() %>/admin/users" class="back-link">← Retour à la liste</a>

    <h1>✏️ Modifier l'Utilisateur</h1>

    <%
        String error = (String) request.getAttribute("error");
        if (error != null) {
    %>
    <div class="alert alert-error"><%= error %></div>
    <% } %>

    <%
        UserDTO user = (UserDTO) request.getAttribute("user");
        if (user != null) {
    %>
    <div class="info-box">
        <strong>ID:</strong> #<%= user.getId() %> |
        <strong>Créé le:</strong> <%= user.getCreatedAt() != null ? user.getCreatedAt().toString().substring(0, 10) : "N/A" %>
    </div>

    <form method="post" action="<%= request.getContextPath() %>/admin/users/edit">
        <input type="hidden" name="id" value="<%= user.getId() %>">

        <div class="form-group">
            <label for="firstName" class="required">Prénom</label>
            <input type="text" id="firstName" name="firstName" value="<%= user.getFirstName() %>" required>
        </div>

        <div class="form-group">
            <label for="lastName" class="required">Nom</label>
            <input type="text" id="lastName" name="lastName" value="<%= user.getLastName() %>" required>
        </div>

        <div class="form-group">
            <label for="email" class="required">Email</label>
            <input type="email" id="email" name="email" value="<%= user.getEmail() %>" required>
        </div>

        <div class="form-group">
            <label class="required">Rôles</label>
            <div class="checkbox-group">
                <div class="checkbox-item">
                    <input type="checkbox" id="role-admin" name="roles" value="ADMIN"
                        <%= user.getRole().contains("ADMIN") ? "checked" : "" %>>
                    <label for="role-admin">👑 Administrateur</label>
                </div>
                <div class="checkbox-item">
                    <input type="checkbox" id="role-doctor" name="roles" value="DOCTOR"
                        <%=Objects.equals(user.getRole(), "DOCTOR") ? "checked" : "" %>>
                    <label for="role-doctor">👨‍⚕️ Docteur</label>
                </div>
                <div class="checkbox-item">
                    <input type="checkbox" id="role-staff" name="roles" value="STAFF"
                        <%= Objects.equals(user.getRole(),"STAFF") ? "checked" : "" %>>
                    <label for="role-staff">👔 Personnel</label>
                </div>
                <div class="checkbox-item">
                    <input type="checkbox" id="role-patient" name="roles" value="PATIENT"
                        <%= Objects.equals(user.getRole(),"PATIENT") ? "checked" : "" %>>
                    <label for="role-patient">🧑 Patient</label>
                </div>
            </div>
        </div>

        <div class="form-actions">
            <button type="submit" class="btn btn-warning">✓ Enregistrer les modifications</button>
            <a href="<%= request.getContextPath() %>/admin/users" class="btn btn-secondary">Annuler</a>
        </div>
    </form>
    <% } else { %>
    <div class="alert alert-error">Utilisateur introuvable.</div>
    <a href="<%= request.getContextPath() %>/admin/users" class="btn btn-secondary">Retour à la liste</a>
    <% } %>
</div>
</body>
</html>