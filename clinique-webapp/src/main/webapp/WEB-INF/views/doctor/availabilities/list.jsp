<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.clinique.domain.Availability" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mes Disponibilités - Docteur</title>
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
            background: linear-gradient(180deg, #319795 0%, #2c7a7b 100%);
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
            background: #38b2ac;
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

        .page-header {
            background: white;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
            margin-bottom: 30px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .page-header h1 {
            font-size: 28px;
            color: #2d3748;
            margin-bottom: 5px;
        }

        .page-header p {
            color: #718096;
            font-size: 14px;
        }

        .btn-primary {
            padding: 12px 24px;
            background: linear-gradient(135deg, #319795 0%, #2c7a7b 100%);
            color: white;
            text-decoration: none;
            border-radius: 8px;
            border: none;
            cursor: pointer;
            font-size: 14px;
            font-weight: 600;
            transition: all 0.3s;
            display: inline-flex;
            align-items: center;
            gap: 8px;
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(49, 151, 149, 0.3);
        }

        /* Calendar View Toggle */
        .view-toggle {
            background: white;
            padding: 20px;
            border-radius: 12px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
            margin-bottom: 20px;
            display: flex;
            gap: 10px;
        }

        .toggle-btn {
            padding: 10px 20px;
            border: 2px solid #e2e8f0;
            background: white;
            border-radius: 8px;
            cursor: pointer;
            font-size: 14px;
            transition: all 0.3s;
        }

        .toggle-btn.active {
            background: #319795;
            color: white;
            border-color: #319795;
        }

        /* Table View */
        .availabilities-table {
            background: white;
            border-radius: 12px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
            overflow: hidden;
        }

        .table-container {
            overflow-x: auto;
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        thead {
            background: #f7fafc;
        }

        th {
            padding: 16px 20px;
            text-align: left;
            font-size: 13px;
            font-weight: 600;
            color: #4a5568;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        td {
            padding: 16px 20px;
            border-top: 1px solid #e2e8f0;
            font-size: 14px;
            color: #2d3748;
        }

        tr:hover {
            background: #f7fafc;
        }

        .day-badge {
            display: inline-block;
            padding: 6px 14px;
            border-radius: 20px;
            font-size: 13px;
            font-weight: 600;
        }

        .day-badge.monday { background: #fff5f5; color: #c53030; }
        .day-badge.tuesday { background: #fffaf0; color: #c05621; }
        .day-badge.wednesday { background: #fefcbf; color: #975a16; }
        .day-badge.thursday { background: #f0fff4; color: #22543d; }
        .day-badge.friday { background: #ebf8ff; color: #2c5282; }
        .day-badge.saturday { background: #faf5ff; color: #553c9a; }
        .day-badge.sunday { background: #fed7d7; color: #742a2a; }

        .time-cell {
            font-family: 'Courier New', monospace;
            font-weight: 600;
            color: #319795;
        }

        .status-badge {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            padding: 6px 12px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 600;
        }

        .status-badge.active {
            background: #c6f6d5;
            color: #22543d;
        }

        .status-badge.inactive {
            background: #fed7d7;
            color: #742a2a;
        }

        .status-badge::before {
            content: '';
            width: 8px;
            height: 8px;
            border-radius: 50%;
            background: currentColor;
        }

        .action-buttons {
            display: flex;
            gap: 8px;
        }

        .btn-icon {
            padding: 8px 12px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-size: 14px;
            transition: all 0.3s;
            text-decoration: none;
            display: inline-block;
        }

        .btn-edit {
            background: #ebf8ff;
            color: #2c5282;
        }

        .btn-edit:hover {
            background: #bee3f8;
        }

        .btn-delete {
            background: #fff5f5;
            color: #c53030;
        }

        .btn-delete:hover {
            background: #fed7d7;
        }

        .empty-state {
            padding: 60px 20px;
            text-align: center;
            color: #718096;
        }

        .empty-state-icon {
            font-size: 64px;
            margin-bottom: 20px;
            opacity: 0.5;
        }

        .empty-state h3 {
            font-size: 20px;
            color: #2d3748;
            margin-bottom: 10px;
        }

        .empty-state p {
            margin-bottom: 20px;
        }

        /* Week Calendar View */
        .calendar-view {
            background: white;
            border-radius: 12px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
            padding: 30px;
            display: none;
        }

        .calendar-view.active {
            display: block;
        }

        .week-grid {
            display: grid;
            grid-template-columns: repeat(7, 1fr);
            gap: 16px;
        }

        .day-column {
            border: 2px solid #e2e8f0;
            border-radius: 12px;
            overflow: hidden;
        }

        .day-header {
            padding: 16px;
            background: #f7fafc;
            font-weight: 600;
            text-align: center;
            border-bottom: 2px solid #e2e8f0;
        }

        .day-slots {
            padding: 12px;
        }

        .time-slot {
            padding: 10px;
            background: #e6fffa;
            border-left: 3px solid #319795;
            border-radius: 6px;
            margin-bottom: 8px;
            font-size: 13px;
        }

        .time-slot .time {
            font-weight: 600;
            color: #2d3748;
        }

        @media (max-width: 1200px) {
            .week-grid {
                grid-template-columns: repeat(3, 1fr);
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
            }

            .page-header {
                flex-direction: column;
                align-items: flex-start;
                gap: 20px;
            }

            .week-grid {
                grid-template-columns: 1fr;
            }

            .action-buttons {
                flex-direction: column;
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
            <span class="role-badge">DOCTEUR</span>
        </div>

        <ul class="nav-menu">
            <li class="nav-item">
                <a href="${pageContext.request.contextPath}/doctor/dashboard" class="nav-link">
                    <span class="nav-icon">📊</span>
                    Tableau de bord
                </a>
            </li>
            <li class="nav-item">
                <a href="#" class="nav-link">
                    <span class="nav-icon">📅</span>
                    Mon agenda
                </a>
            </li>
            <li class="nav-item">
                <a href="${pageContext.request.contextPath}/doctor/availabilities" class="nav-link active">
                    <span class="nav-icon">🕒</span>
                    Mes disponibilités
                </a>
            </li>
            <li class="nav-item">
                <a href="#" class="nav-link">
                    <span class="nav-icon">👥</span>
                    Mes patients
                </a>
            </li>
            <li class="nav-item">
                <a href="#" class="nav-link">
                    <span class="nav-icon">📝</span>
                    Notes médicales
                </a>
            </li>
        </ul>

        <a href="${pageContext.request.contextPath}/logout" class="logout-btn">Se déconnecter</a>
    </aside>

    <!-- Main Content -->
    <main class="main-content">
        <div class="page-header">
            <div>
                <h1>Mes Disponibilités</h1>
                <p>Gérez vos créneaux horaires et votre disponibilité hebdomadaire</p>
            </div>
            <a href="<%=request.getContextPath()%>/doctor/availabilities/create" class="btn-primary">
                <span>➕</span> Ajouter un créneau
            </a>
        </div>

        <!-- View Toggle -->
        <div class="view-toggle">
            <button class="toggle-btn active" onclick="switchView('table')">📋 Vue Liste</button>
            <button class="toggle-btn" onclick="switchView('calendar')">📅 Vue Calendrier</button>
        </div>

        <!-- Table View -->
        <div class="availabilities-table" id="tableView">
            <div class="table-container">
                <%
                    List<Availability> availabilities = (List<Availability>) request.getAttribute("availabilities");
                    if (availabilities != null && !availabilities.isEmpty()) {
                %>
                <table>
                    <thead>
                    <tr>
                        <th>Jour</th>
                        <th>Heure de début</th>
                        <th>Heure de fin</th>
                        <th>Durée</th>
                        <th>Statut</th>
                        <th>Actions</th>
                    </tr>
                    </thead>
                    <tbody>
                    <%
                        for (Availability a : availabilities) {
                            String dayClass = a.getDayOfWeek().name().toLowerCase();
                    %>
                    <tr>
                        <td>
                            <span class="day-badge <%= dayClass %>"><%= a.getDayOfWeek() %></span>
                        </td>
                        <td class="time-cell"><%= a.getStartTime() %></td>
                        <td class="time-cell"><%= a.getEndTime() %></td>
                        <td>
                            <%
                                // Calculate duration (simplified)
                                String[] start = a.getStartTime().toString().split(":");
                                String[] end = a.getEndTime().toString().split(":");
                                int hours = Integer.parseInt(end[0]) - Integer.parseInt(start[0]);
                                int minutes = Integer.parseInt(end[1]) - Integer.parseInt(start[1]);
                                if (minutes < 0) { hours--; minutes += 60; }
                            %>
                            <%= hours %>h<%= minutes > 0 ? String.format("%02d", minutes) : "00" %>
                        </td>
                        <td>
                                <span class="status-badge <%= a.isActive() ? "active" : "inactive" %>">
                                    <%= a.isActive() ? "Actif" : "Inactif" %>
                                </span>
                        </td>
                        <td>
                            <div class="action-buttons">
                                <a href="<%=request.getContextPath()%>/doctor/availabilities/edit?id=<%=a.getId()%>"
                                   class="btn-icon btn-edit" title="Modifier">✏️</a>
                                <form action="<%=request.getContextPath()%>/doctor/availabilities/delete"
                                      method="post" style="display:inline;">
                                    <input type="hidden" name="id" value="<%=a.getId()%>"/>
                                    <button type="submit" class="btn-icon btn-delete" title="Supprimer"
                                            onclick="return confirm('Êtes-vous sûr de vouloir supprimer ce créneau ?');">
                                        🗑️
                                    </button>
                                </form>
                            </div>
                        </td>
                    </tr>
                    <% } %>
                    </tbody>
                </table>
                <% } else { %>
                <div class="empty-state">
                    <div class="empty-state-icon">📅</div>
                    <h3>Aucune disponibilité</h3>
                    <p>Vous n'avez pas encore défini vos créneaux horaires</p>
                    <a href="<%=request.getContextPath()%>/doctor/availabilities/create" class="btn-primary">
                        <span>➕</span> Créer ma première disponibilité
                    </a>
                </div>
                <% } %>
            </div>
        </div>

        <!-- Calendar View -->
        <div class="calendar-view" id="calendarView">
            <div class="week-grid">
                <%
                    String[] daysOfWeek = {"MONDAY", "TUESDAY", "WEDNESDAY", "THURSDAY", "FRIDAY", "SATURDAY", "SUNDAY"};
                    String[] dayNames = {"Lundi", "Mardi", "Mercredi", "Jeudi", "Vendredi", "Samedi", "Dimanche"};

                    for (int i = 0; i < daysOfWeek.length; i++) {
                        String day = daysOfWeek[i];
                        String dayName = dayNames[i];
                %>
                <div class="day-column">
                    <div class="day-header"><%= dayName %></div>
                    <div class="day-slots">
                        <%
                            if (availabilities != null) {
                                boolean hasSlots = false;
                                for (Availability a : availabilities) {
                                    if (a.getDayOfWeek().name().equals(day) && a.isActive()) {
                                        hasSlots = true;
                        %>
                        <div class="time-slot">
                            <div class="time"><%= a.getStartTime() %> - <%= a.getEndTime() %></div>
                        </div>
                        <%
                                }
                            }
                            if (!hasSlots) {
                        %>
                        <div style="padding: 20px; text-align: center; color: #a0aec0; font-size: 12px;">
                            Pas de créneaux
                        </div>
                        <%
                                }
                            }
                        %>
                    </div>
                </div>
                <% } %>
            </div>
        </div>
    </main>
</div>

<script>
    function switchView(view) {
        const tableView = document.getElementById('tableView');
        const calendarView = document.getElementById('calendarView');
        const buttons = document.querySelectorAll('.toggle-btn');

        buttons.forEach(btn => btn.classList.remove('active'));

        if (view === 'table') {
            tableView.style.display = 'block';
            calendarView.style.display = 'none';
            buttons[0].classList.add('active');
        } else {
            tableView.style.display = 'none';
            calendarView.style.display = 'block';
            buttons[1].classList.add('active');
        }
    }
</script>
</body>
</html>