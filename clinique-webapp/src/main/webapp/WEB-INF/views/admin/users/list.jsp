<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.clinique.webapp.dto.UserDTO" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gestion des Utilisateurs - Admin</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: #2d3748;
            min-height: 100vh;
        }

        .dashboard-container {
            display: flex;
            min-height: 100vh;
        }

        /* Sidebar améliorée */
        .sidebar {
            width: 280px;
            background: rgba(45, 55, 72, 0.95);
            backdrop-filter: blur(10px);
            color: white;
            padding: 0;
            position: fixed;
            height: 100vh;
            overflow-y: auto;
            box-shadow: 4px 0 20px rgba(0, 0, 0, 0.2);
        }

        .sidebar-header {
            padding: 30px 20px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border-bottom: 1px solid rgba(255, 255, 255, 0.1);
        }

        .sidebar-header h2 {
            font-size: 24px;
            font-weight: 700;
            margin-bottom: 8px;
        }

        .sidebar-header .role-badge {
            display: inline-block;
            background: rgba(255, 255, 255, 0.2);
            padding: 6px 16px;
            border-radius: 20px;
            font-size: 11px;
            font-weight: 600;
            letter-spacing: 1px;
        }

        .nav-menu {
            list-style: none;
            padding: 20px;
        }

        .nav-item {
            margin-bottom: 6px;
        }

        .nav-link {
            display: flex;
            align-items: center;
            padding: 14px 16px;
            color: rgba(255, 255, 255, 0.7);
            text-decoration: none;
            border-radius: 10px;
            transition: all 0.3s;
            font-size: 15px;
        }

        .nav-link:hover {
            background: rgba(255, 255, 255, 0.1);
            color: white;
            transform: translateX(5px);
        }

        .nav-link.active {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            box-shadow: 0 4px 15px rgba(102, 126, 234, 0.4);
        }

        .nav-icon {
            margin-right: 14px;
            font-size: 20px;
        }

        .logout-btn {
            position: absolute;
            bottom: 20px;
            left: 20px;
            right: 20px;
            padding: 14px;
            background: linear-gradient(135deg, #fc5c7d 0%, #6a82fb 100%);
            color: white;
            text-align: center;
            text-decoration: none;
            border-radius: 10px;
            font-weight: 600;
            transition: all 0.3s;
            box-shadow: 0 4px 15px rgba(252, 92, 125, 0.3);
        }

        .logout-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(252, 92, 125, 0.5);
        }

        /* Main Content */
        .main-content {
            flex: 1;
            margin-left: 280px;
            padding: 40px;
            background: #f7fafc;
        }

        .container {
            max-width: 1600px;
            margin: 0 auto;
        }

        .page-header {
            background: white;
            border-radius: 16px;
            padding: 30px 40px;
            margin-bottom: 30px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 20px;
        }

        .page-header h1 {
            font-size: 36px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            font-weight: 700;
        }

        .header-actions {
            display: flex;
            gap: 12px;
            align-items: center;
        }

        /* Search Bar */
        .search-container {
            background: white;
            border-radius: 16px;
            padding: 25px 30px;
            margin-bottom: 30px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
        }

        .search-box {
            display: flex;
            gap: 12px;
            flex-wrap: wrap;
        }

        .search-input {
            flex: 1;
            min-width: 250px;
            padding: 14px 20px;
            border: 2px solid #e2e8f0;
            border-radius: 10px;
            font-size: 15px;
            transition: all 0.3s;
        }

        .search-input:focus {
            outline: none;
            border-color: #667eea;
            box-shadow: 0 0 0 4px rgba(102, 126, 234, 0.1);
        }

        .search-select {
            padding: 14px 20px;
            border: 2px solid #e2e8f0;
            border-radius: 10px;
            font-size: 15px;
            cursor: pointer;
            transition: all 0.3s;
        }

        .search-select:focus {
            outline: none;
            border-color: #667eea;
        }

        /* Stats Cards */
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }

        .stat-card {
            background: white;
            border-radius: 16px;
            padding: 25px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
            transition: all 0.3s;
            position: relative;
            overflow: hidden;
        }

        .stat-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 4px;
            background: linear-gradient(90deg, #667eea 0%, #764ba2 100%);
        }

        .stat-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 30px rgba(0, 0, 0, 0.12);
        }

        .stat-label {
            font-size: 13px;
            color: #718096;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 1px;
            margin-bottom: 8px;
        }

        .stat-value {
            font-size: 32px;
            font-weight: 700;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }

        /* Alert Messages */
        .alert {
            padding: 18px 24px;
            border-radius: 12px;
            margin-bottom: 25px;
            display: flex;
            align-items: center;
            font-size: 15px;
            animation: slideIn 0.4s ease-out;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
        }

        @keyframes slideIn {
            from {
                opacity: 0;
                transform: translateY(-20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .alert-success {
            background: linear-gradient(135deg, #c6f6d5 0%, #9ae6b4 100%);
            color: #22543d;
            border-left: 5px solid #38a169;
        }

        .alert-error {
            background: linear-gradient(135deg, #fed7d7 0%, #fc8181 100%);
            color: #742a2a;
            border-left: 5px solid #e53e3e;
        }

        /* Buttons */
        .btn {
            padding: 12px 24px;
            border: none;
            border-radius: 10px;
            font-size: 14px;
            font-weight: 600;
            cursor: pointer;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            transition: all 0.3s;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
        }

        .btn-primary {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
        }

        .btn-primary:hover {
            transform: translateY(-3px);
            box-shadow: 0 6px 20px rgba(102, 126, 234, 0.4);
        }

        .btn-warning {
            background: linear-gradient(135deg, #f6ad55 0%, #ed8936 100%);
            color: white;
        }

        .btn-warning:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 15px rgba(237, 137, 54, 0.4);
        }

        .btn-secondary {
            background: linear-gradient(135deg, #a0aec0 0%, #718096 100%);
            color: white;
        }

        .btn-secondary:hover {
            transform: translateY(-2px);
        }

        .btn-success {
            background: linear-gradient(135deg, #48bb78 0%, #38a169 100%);
            color: white;
        }

        .btn-success:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 15px rgba(56, 161, 105, 0.4);
        }

        .btn-danger {
            background: linear-gradient(135deg, #fc8181 0%, #e53e3e 100%);
            color: white;
        }

        .btn-danger:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 15px rgba(229, 62, 62, 0.4);
        }

        .btn-sm {
            padding: 8px 16px;
            font-size: 13px;
        }

        /* Table moderne avec cards */
        .users-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(350px, 1fr));
            gap: 25px;
            margin-bottom: 30px;
        }

        .user-card {
            background: white;
            border-radius: 16px;
            padding: 25px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
            transition: all 0.3s;
            position: relative;
            overflow: hidden;
        }

        .user-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 5px;
            background: linear-gradient(90deg, #667eea 0%, #764ba2 100%);
        }

        .user-card:hover {
            transform: translateY(-8px);
            box-shadow: 0 12px 40px rgba(0, 0, 0, 0.15);
        }

        .user-header {
            display: flex;
            justify-content: space-between;
            align-items: start;
            margin-bottom: 20px;
        }

        .user-avatar {
            width: 60px;
            height: 60px;
            border-radius: 50%;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 24px;
            font-weight: 700;
            box-shadow: 0 4px 15px rgba(102, 126, 234, 0.3);
        }

        .user-id {
            font-size: 12px;
            color: #a0aec0;
            font-weight: 600;
        }

        .user-name {
            font-size: 20px;
            font-weight: 700;
            color: #2d3748;
            margin: 12px 0 6px 0;
        }

        .user-email {
            font-size: 14px;
            color: #718096;
            margin-bottom: 15px;
        }

        .user-meta {
            display: flex;
            gap: 10px;
            margin-bottom: 20px;
            flex-wrap: wrap;
        }

        /* Badges améliorés */
        .badge {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            padding: 6px 12px;
            border-radius: 20px;
            font-size: 11px;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .badge-admin {
            background: linear-gradient(135deg, #fed7d7 0%, #fc8181 100%);
            color: #9b2c2c;
        }

        .badge-doctor {
            background: linear-gradient(135deg, #c6f6d5 0%, #9ae6b4 100%);
            color: #22543d;
        }

        .badge-patient {
            background: linear-gradient(135deg, #bee3f8 0%, #90cdf4 100%);
            color: #2c5282;
        }

        .badge-staff {
            background: linear-gradient(135deg, #e9d8fd 0%, #d6bcfa 100%);
            color: #553c9a;
        }

        .status {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            padding: 6px 12px;
            border-radius: 20px;
            font-size: 11px;
            font-weight: 700;
        }

        .status-active {
            background: linear-gradient(135deg, #c6f6d5 0%, #9ae6b4 100%);
            color: #22543d;
        }

        .status-active::before {
            content: '●';
            font-size: 14px;
        }

        .status-inactive {
            background: linear-gradient(135deg, #fed7d7 0%, #fc8181 100%);
            color: #9b2c2c;
        }

        .status-inactive::before {
            content: '●';
            font-size: 14px;
        }

        .user-date {
            font-size: 12px;
            color: #a0aec0;
            margin-top: 15px;
            padding-top: 15px;
            border-top: 1px solid #e2e8f0;
        }

        .user-actions {
            display: flex;
            gap: 8px;
            margin-top: 20px;
        }

        /* No Data */
        .no-data {
            background: white;
            border-radius: 16px;
            padding: 80px 40px;
            text-align: center;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
        }

        .no-data-icon {
            font-size: 64px;
            margin-bottom: 20px;
        }

        .no-data p {
            color: #718096;
            font-size: 18px;
            margin-bottom: 20px;
        }

        /* Responsive */
        @media (max-width: 1024px) {
            .users-grid {
                grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            }
        }

        @media (max-width: 768px) {
            .sidebar {
                width: 100%;
                position: relative;
                height: auto;
            }

            .main-content {
                margin-left: 0;
                padding: 20px;
            }

            .page-header {
                padding: 20px;
            }

            .page-header h1 {
                font-size: 24px;
            }

            .users-grid {
                grid-template-columns: 1fr;
            }

            .stats-grid {
                grid-template-columns: repeat(2, 1fr);
            }

            .user-actions {
                flex-direction: column;
            }

            .user-actions .btn {
                width: 100%;
                justify-content: center;
            }
        }
    </style>
</head>
<body>
<div class="dashboard-container">
    <!-- Sidebar -->
    <aside class="sidebar">
        <div class="sidebar-header">
            <h2>🏥 Clinique Digitale</h2>
            <span class="role-badge">ADMINISTRATEUR</span>
        </div>

        <ul class="nav-menu">
            <li class="nav-item">
                <a href="<%= request.getContextPath() %>/admin/dashboard" class="nav-link">
                    <span class="nav-icon">📊</span>
                    Tableau de bord
                </a>
            </li>
            <li class="nav-item">
                <a href="<%= request.getContextPath() %>/admin/users" class="nav-link active">
                    <span class="nav-icon">👥</span>
                    Utilisateurs
                </a>
            </li>
            <li class="nav-item">
                <a href="<%= request.getContextPath() %>/admin/departments" class="nav-link">
                    <span class="nav-icon">🏥</span>
                    Départements
                </a>
            </li>
            <li class="nav-item">
                <a href="<%= request.getContextPath() %>/admin/specialties" class="nav-link">
                    <span class="nav-icon">🎓</span>
                    Spécialités
                </a>
            </li>
        </ul>

        <a href="<%= request.getContextPath() %>/logout" class="logout-btn">🚪 Se déconnecter</a>
    </aside>

    <!-- Main Content -->
    <main class="main-content">
        <div class="container">
            <!-- Page Header -->
            <div class="page-header">
                <div>
                    <h1>👥 Gestion des Utilisateurs</h1>
                </div>
                <div class="header-actions">
                    <a href="<%= request.getContextPath() %>/admin/users/create" class="btn btn-primary">
                        ➕ Créer un utilisateur
                    </a>
                </div>
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
                <div class="no-data-icon">👥</div>
                <p>Aucun utilisateur trouvé.</p>
                <a href="<%= request.getContextPath() %>/admin/users/create" class="btn btn-primary">
                    ➕ Créer le premier utilisateur
                </a>
            </div>
            <%
            } else {
                // Calculer les statistiques
                int totalUsers = users.size();
                int activeUsers = 0;
                int doctors = 0;
                int patients = 0;
                int admins = 0;
                int staff = 0;

                for (UserDTO user : users) {
                    if (user.isActive()) activeUsers++;
                    String role = user.getRole();
                    if (role != null) {
                        switch(role) {
                            case "DOCTOR": doctors++; break;
                            case "PATIENT": patients++; break;
                            case "ADMIN": admins++; break;
                            case "STAFF": staff++; break;
                        }
                    }
                }
            %>

            <!-- Stats Cards -->
            <div class="stats-grid">
                <div class="stat-card">
                    <div class="stat-label">Total</div>
                    <div class="stat-value"><%= totalUsers %></div>
                </div>
                <div class="stat-card">
                    <div class="stat-label">Actifs</div>
                    <div class="stat-value"><%= activeUsers %></div>
                </div>
                <div class="stat-card">
                    <div class="stat-label">Docteurs</div>
                    <div class="stat-value"><%= doctors %></div>
                </div>
                <div class="stat-card">
                    <div class="stat-label">Patients</div>
                    <div class="stat-value"><%= patients %></div>
                </div>
            </div>

            <!-- Users Grid -->
            <div class="users-grid">
                <%
                    for (UserDTO user : users) {
                        String role = user.getRole();
                        String roleDisplay = (role != null) ? role : "N/A";

                        String badgeClass = "badge";
                        String roleIcon = "👤";
                        if (role != null) {
                            switch(role) {
                                case "ADMIN":
                                    badgeClass += " badge-admin";
                                    roleIcon = "👑";
                                    break;
                                case "DOCTOR":
                                    badgeClass += " badge-doctor";
                                    roleIcon = "👨‍⚕️";
                                    break;
                                case "PATIENT":
                                    badgeClass += " badge-patient";
                                    roleIcon = "🧑";
                                    break;
                                case "STAFF":
                                    badgeClass += " badge-staff";
                                    roleIcon = "👔";
                                    break;
                            }
                        }

                        // Initiales pour l'avatar
                        String initials = "";
                        if (user.getFirstName() != null && !user.getFirstName().isEmpty()) {
                            initials += user.getFirstName().charAt(0);
                        }
                        if (user.getLastName() != null && !user.getLastName().isEmpty()) {
                            initials += user.getLastName().charAt(0);
                        }
                %>
                <div class="user-card">
                    <div class="user-header">
                        <div class="user-avatar"><%= initials.toUpperCase() %></div>
                        <div class="user-id">#<%= user.getId() %></div>
                    </div>

                    <div class="user-name"><%= user.getFullName() %></div>
                    <div class="user-email">📧 <%= user.getEmail() %></div>

                    <div class="user-meta">
                        <span class="<%= badgeClass %>"><%= roleIcon %> <%= roleDisplay %></span>
                        <% if (user.isActive()) { %>
                        <span class="status status-active">Actif</span>
                        <% } else { %>
                        <span class="status status-inactive">Inactif</span>
                        <% } %>
                    </div>

                    <div class="user-date">
                        📅 Créé le <%= user.getCreatedAt() != null ? user.getCreatedAt().toString().substring(0, 10) : "N/A" %>
                    </div>

                    <div class="user-actions">
                        <a href="<%= request.getContextPath() %>/admin/users/edit?id=<%= user.getId() %>"
                           class="btn btn-warning btn-sm" title="Modifier">
                            ✏️ Modifier
                        </a>

                        <form method="post" action="<%= request.getContextPath() %>/admin/users/toggle-status"
                              style="display: inline; margin: 0; flex: 1;">
                            <input type="hidden" name="id" value="<%= user.getId() %>">
                            <button type="submit"
                                    class="btn <%= user.isActive() ? "btn-secondary" : "btn-success" %> btn-sm"
                                    style="width: 100%;"
                                    title="<%= user.isActive() ? "Désactiver" : "Activer" %>">
                                <%= user.isActive() ? "🚫" : "✓" %>
                            </button>
                        </form>

                        <form method="post" action="<%= request.getContextPath() %>/admin/users/delete"
                              style="display: inline; margin: 0;"
                              onsubmit="return confirm('⚠️ Êtes-vous sûr de vouloir supprimer <%= user.getFullName() %> ?');">
                            <input type="hidden" name="id" value="<%= user.getId() %>">
                            <button type="submit" class="btn btn-danger btn-sm" title="Supprimer">
                                🗑️
                            </button>
                        </form>
                    </div>
                </div>
                <% } %>
            </div>
            <% } %>
        </div>
    </main>
</div>
</body>
</html>