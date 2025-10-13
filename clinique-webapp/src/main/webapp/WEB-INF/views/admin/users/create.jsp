<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Créer un Utilisateur - Admin</title>
</head>
<body>
<div class="container">
    <a href="<%= request.getContextPath() %>/admin/users" class="back-link">← Retour à la liste</a>

    <h1>➕ Créer un Nouvel Utilisateur</h1>

    <%
        String error = (String) request.getAttribute("error");
        if (error != null) {
    %>
    <div class="alert alert-error"><%= error %></div>
    <% } %>

    <form method="post" action="<%= request.getContextPath() %>/admin/users/create">
        <div class="form-group">
            <label for="firstName" class="required">Prénom</label>
            <input type="text" id="firstName" name="firstName"
                   value="<%= request.getAttribute("firstName") != null ? request.getAttribute("firstName") : "" %>"
                   required>
        </div>

        <div class="form-group">
            <label for="lastName" class="required">Nom</label>
            <input type="text" id="lastName" name="lastName"
                   value="<%= request.getAttribute("lastName") != null ? request.getAttribute("lastName") : "" %>"
                   required>
        </div>

        <div class="form-group">
            <label for="email" class="required">Email</label>
            <input type="email" id="email" name="email"
                   value="<%= request.getAttribute("email") != null ? request.getAttribute("email") : "" %>"
                   required>
            <div class="help-text">L'email servira d'identifiant de connexion</div>
        </div>

        <div class="form-group">
            <label for="password" class="required">Mot de passe</label>
            <input type="password" id="password" name="password" required minlength="6">
            <div class="help-text">Minimum 6 caractères</div>
        </div>

        <div class="form-group">
            <label class="required">Rôle</label>
            <div class="radio-group">
                <div class="radio-item">
                    <input type="radio" id="role-admin" name="role" value="ADMIN" required>
                    <label for="role-admin">👑 Administrateur</label>
                </div>
                <div class="radio-item">
                    <input type="radio" id="role-doctor" name="role" value="DOCTOR">
                    <label for="role-doctor">👨‍⚕️ Docteur</label>
                </div>
                <div class="radio-item">
                    <input type="radio" id="role-staff" name="role" value="STAFF">
                    <label for="role-staff">👔 Personnel</label>
                </div>
                <div class="radio-item">
                    <input type="radio" id="role-patient" name="role" value="PATIENT">
                    <label for="role-patient">🧑 Patient</label>
                </div>
            </div>
            <div class="help-text">Sélectionnez un rôle</div>
        </div>

        <div class="form-actions">
            <button type="submit" class="btn btn-primary">✓ Créer l'utilisateur</button>
            <a href="<%= request.getContextPath() %>/admin/users" class="btn btn-secondary">Annuler</a>
        </div>
    </form>
</div>
</body>
</html>