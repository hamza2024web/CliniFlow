<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tableau de Bord - Administrateur</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: #f7fafc;
            color: #2d3748;
        }

        .dashboard-container {
            display: flex;
            min-height: 100vh;
        }

        /* Sidebar */
        .sidebar {
            width: 260px;
            background: linear-gradient(180deg, #2d3748 0%, #1a202c 100%);
            color: white;
            padding: 20px;
            position: fixed;
            height: 100vh;
            overflow-y: auto;
        }

        .sidebar-header {
            padding: 20px 0;
            border-bottom: 1px solid rgba(255, 255, 255, 0.1);
            margin-bottom: 30px;
        }

        .sidebar-header h2 {
            font-size: 22px;
            font-weight: 600;
        }

        .sidebar-header .role-badge {
            display: inline-block;
            background: #e53e3e;
            padding: 4px 12px;
            border-radius: 20px;
            font-size: 12px;
            margin-top: 8px;
        }

        .nav-menu {
            list-style: none;
        }

        .nav-item {
            margin-bottom: 8px;
        }

        .nav-link {
            display: flex;
            align-items: center;
            padding: 12px 16px;
            color: rgba(255, 255, 255, 0.8);
            text-decoration: none;
            border-radius: 8px;
            transition: all 0.3s;
        }

        .nav-link:hover,
        .nav-link.active {
            background: rgba(255, 255, 255, 0.1);
            color: white;
        }

        .nav-icon {
            margin-right: 12px;
            font-size: 18px;
        }

        .logout-btn {
            position: absolute;
            bottom: 20px;
            left: 20px;
            right: 20px;
            padding: 12px;
            background: #e53e3e;
            color: white;
            text-align: center;
            text-decoration: none;
            border-radius: 8px;
            transition: background 0.3s;
        }

        .logout-btn:hover {
            background: #c53030;
        }

        /* Main Content */
        .main-content {
            flex: 1;
            margin-left: 260px;
            padding: 30px;
        }

        .top-bar {
            background: white;
            padding: 20px 30px;
            border-radius: 12px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
            margin-bottom: 30px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .welcome-section h1 {
            font-size: 28px;
            color: #2d3748;
            margin-bottom: 5px;
        }

        .welcome-section p {
            color: #718096;
            font-size: 14px;
        }

        .user-info {
            display: flex;
            align-items: center;
            gap: 15px;
        }

        .user-avatar {
            width: 48px;
            height: 48px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-weight: 600;
            font-size: 18px;
        }

        .user-details h3 {
            font-size: 14px;
            font-weight: 600;
            color: #2d3748;
        }

        .user-details p {
            font-size: 12px;
            color: #718096;
        }

        /* Stats Cards */
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }

        .stat-card {
            background: white;
            padding: 24px;
            border-radius: 12px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
            transition: transform 0.3s, box-shadow 0.3s;
        }

        .stat-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 24px rgba(0, 0, 0, 0.1);
        }

        .stat-card .stat-icon {
            width: 50px;
            height: 50px;
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 24px;
            margin-bottom: 16px;
        }

        .stat-card.blue .stat-icon {
            background: #ebf4ff;
            color: #3182ce;
        }

        .stat-card.green .stat-icon {
            background: #f0fff4;
            color: #38a169;
        }

        .stat-card.purple .stat-icon {
            background: #faf5ff;
            color: #805ad5;
        }

        .stat-card.orange .stat-icon {
            background: #fffaf0;
            color: #dd6b20;
        }

        .stat-card h3 {
            font-size: 14px;
            color: #718096;
            margin-bottom: 8px;
            font-weight: 500;
        }

        .stat-card .stat-value {
            font-size: 32px;
            font-weight: 700;
            color: #2d3748;
        }

        /* Actions Section */
        .actions-section {
            background: white;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
        }

        .actions-section h2 {
            font-size: 20px;
            color: #2d3748;
            margin-bottom: 20px;
            font-weight: 600;
        }

        .action-list {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 16px;
        }

        .action-item {
            padding: 16px 20px;
            border: 2px solid #e2e8f0;
            border-radius: 10px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            transition: all 0.3s;
            cursor: pointer;
        }

        .action-item:hover {
            border-color: #667eea;
            background: #f7faff;
        }

        .action-item .action-text {
            font-size: 15px;
            color: #2d3748;
            font-weight: 500;
        }

        .action-item .action-arrow {
            color: #667eea;
            font-size: 18px;
        }

        @media (max-width: 768px) {
            .sidebar {
                width: 100%;
                position: relative;
                height: auto;
            }

            .main-content {
                margin-left: 0;
            }

            .stats-grid {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
<div class="dashboard-container">
    <!-- Sidebar -->
    <aside class="sidebar">
        <div class="sidebar-header">
            <h2>Clinique Digitale</h2>
            <span class="role-badge">ADMINISTRATEUR</span>
        </div>

        <ul class="nav-menu">
            <li class="nav-item">
                <a href="#" class="nav-link active">
                    <span class="nav-icon">📊</span>
                    Tableau de bord
                </a>
            </li>
            <li class="nav-item">
                <a href="<%= request.getContextPath() %>/admin/users" class="nav-link">
                    <span class="nav-icon">👥</span>
                    Gestion des utilisateurs
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

        <a href="${pageContext.request.contextPath}/logout" class="logout-btn">Se déconnecter</a>
    </aside>

    <!-- Main Content -->
    <main class="main-content">
        <div class="top-bar">
            <div class="welcome-section">
                <h1>Bienvenue, ${sessionScope.user.nom}</h1>
                <p>${sessionScope.user.email}</p>
            </div>
            <div class="user-info">
                <div class="user-avatar">${sessionScope.user.nom.substring(0,1)}</div>
                <div class="user-details">
                    <h3>${sessionScope.user.nom}</h3>
                    <p>${sessionScope.user.roles}</p>
                </div>
            </div>
        </div>

        <!-- Stats Cards -->
        <div class="stats-grid">
            <div class="stat-card blue">
                <div class="stat-icon">👥</div>
                <h3>Utilisateurs actifs</h3>
                <div class="stat-value">1,247</div>
            </div>
            <div class="stat-card green">
                <div class="stat-icon">📅</div>
                <h3>Rendez-vous aujourd'hui</h3>
                <div class="stat-value">89</div>
            </div>
            <div class="stat-card purple">
                <div class="stat-icon">👨‍⚕️</div>
                <h3>Docteurs disponibles</h3>
                <div class="stat-value">42</div>
            </div>
            <div class="stat-card orange">
                <div class="stat-icon">🏥</div>
                <h3>Départements</h3>
                <div class="stat-value">12</div>
            </div>
        </div>

        <!-- Actions Section -->
        <div class="actions-section">
            <h2>Actions Administrateur</h2>
            <div class="action-list">
                <div class="action-item">
                    <span class="action-text">Gestion des utilisateurs</span>
                    <span class="action-arrow">→</span>
                </div>
                <div class="action-item">
                    <span class="action-text">Gestion des départements et spécialités</span>
                    <span class="action-arrow">→</span>
                </div>
                <div class="action-item">
                    <span class="action-text">Configuration système</span>
                    <span class="action-arrow">→</span>
                </div>
                <div class="action-item">
                    <span class="action-text">Statistiques globales</span>
                    <span class="action-arrow">→</span>
                </div>
            </div>
        </div>
    </main>
</div>
</body>
</html>
