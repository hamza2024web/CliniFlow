<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.clinique.domain.Availability" %>
<%@ page import="com.clinique.domain.Enum.DayOfWeek" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Modifier une Disponibilité</title>
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

        .breadcrumb {
            display: flex;
            align-items: center;
            gap: 8px;
            margin-bottom: 20px;
            font-size: 14px;
        }

        .breadcrumb a {
            color: #319795;
            text-decoration: none;
        }

        .breadcrumb a:hover {
            text-decoration: underline;
        }

        .breadcrumb span {
            color: #cbd5e0;
        }

        /* Form Container */
        .form-container {
            background: white;
            padding: 40px;
            border-radius: 12px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
            max-width: 800px;
        }

        .alert {
            padding: 16px 20px;
            border-radius: 8px;
            margin-bottom: 24px;
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .alert-error {
            background: #fff5f5;
            border-left: 4px solid #e53e3e;
            color: #742a2a;
        }

        .alert-icon {
            font-size: 20px;
        }

        .form-grid {
            display: grid;
            gap: 24px;
        }

        .form-group {
            display: flex;
            flex-direction: column;
        }

        .form-group label {
            font-size: 14px;
            font-weight: 600;
            color: #2d3748;
            margin-bottom: 8px;
            display: flex;
            align-items: center;
            gap: 4px;
        }

        .required {
            color: #e53e3e;
        }

        .form-control {
            padding: 12px 16px;
            border: 2px solid #e2e8f0;
            border-radius: 8px;
            font-size: 14px;
            color: #2d3748;
            transition: all 0.3s;
            font-family: inherit;
        }

        .form-control:focus {
            outline: none;
            border-color: #319795;
            box-shadow: 0 0 0 3px rgba(49, 151, 149, 0.1);
        }

        .form-control:hover {
            border-color: #cbd5e0;
        }

        select.form-control {
            cursor: pointer;
            background: white url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='12' height='12' viewBox='0 0 12 12'%3E%3Cpath fill='%23718096' d='M6 9L1 4h10z'/%3E%3C/svg%3E") no-repeat right 12px center;
            appearance: none;
            padding-right: 40px;
        }

        .form-hint {
            font-size: 13px;
            color: #718096;
            margin-top: 6px;
        }

        .time-group {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 16px;
        }

        .quick-times {
            display: flex;
            gap: 8px;
            margin-top: 8px;
            flex-wrap: wrap;
        }

        .quick-time-btn {
            padding: 6px 12px;
            background: #e6fffa;
            color: #319795;
            border: 1px solid #b2f5ea;
            border-radius: 6px;
            font-size: 12px;
            cursor: pointer;
            transition: all 0.3s;
        }

        .quick-time-btn:hover {
            background: #b2f5ea;
        }

        /* Toggle Switch */
        .toggle-group {
            display: flex;
            align-items: center;
            gap: 12px;
            padding: 16px;
            background: #f7fafc;
            border-radius: 8px;
            border: 2px solid #e2e8f0;
        }

        .toggle-switch {
            position: relative;
            width: 52px;
            height: 28px;
        }

        .toggle-switch input {
            opacity: 0;
            width: 0;
            height: 0;
        }

        .toggle-slider {
            position: absolute;
            cursor: pointer;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background-color: #cbd5e0;
            transition: .4s;
            border-radius: 28px;
        }

        .toggle-slider:before {
            position: absolute;
            content: "";
            height: 20px;
            width: 20px;
            left: 4px;
            bottom: 4px;
            background-color: white;
            transition: .4s;
            border-radius: 50%;
        }

        input:checked + .toggle-slider {
            background-color: #319795;
        }

        input:checked + .toggle-slider:before {
            transform: translateX(24px);
        }

        .toggle-label {
            font-size: 14px;
            font-weight: 600;
            color: #2d3748;
        }

        .toggle-description {
            font-size: 13px;
            color: #718096;
            margin-top: 4px;
        }

        /* Duration Preview */
        .duration-preview {
            background: #f7fafc;
            padding: 16px;
            border-radius: 8px;
            border: 2px solid #e2e8f0;
            margin-top: 16px;
        }

        .duration-preview h4 {
            font-size: 14px;
            color: #4a5568;
            margin-bottom: 8px;
        }

        .duration-value {
            font-size: 24px;
            font-weight: 700;
            color: #319795;
        }

        /* Form Actions */
        .form-actions {
            display: flex;
            gap: 12px;
            margin-top: 32px;
            padding-top: 24px;
            border-top: 1px solid #e2e8f0;
        }

        .btn {
            padding: 12px 28px;
            border: none;
            border-radius: 8px;
            font-size: 14px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 8px;
        }

        .btn-primary {
            background: linear-gradient(135deg, #319795 0%, #2c7a7b 100%);
            color: white;
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(49, 151, 149, 0.3);
        }

        .btn-secondary {
            background: white;
            color: #4a5568;
            border: 2px solid #e2e8f0;
        }

        .btn-secondary:hover {
            background: #f7fafc;
            border-color: #cbd5e0;
        }

        .btn-danger {
            background: #fff5f5;
            color: #e53e3e;
            border: 2px solid #feb2b2;
            margin-left: auto;
        }

        .btn-danger:hover {
            background: #fed7d7;
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

            .form-container {
                padding: 24px;
            }

            .time-group {
                grid-template-columns: 1fr;
            }

            .form-actions {
                flex-direction: column;
            }

            .btn {
                width: 100%;
                justify-content: center;
            }

            .btn-danger {
                margin-left: 0;
                order: 3;
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
        <div class="breadcrumb">
            <a href="${pageContext.request.contextPath}/doctor/dashboard">Tableau de bord</a>
            <span>›</span>
            <a href="<%=request.getContextPath()%>/doctor/availabilities">Disponibilités</a>
            <span>›</span>
            <span style="color: #2d3748;">Modifier</span>
        </div>

        <div class="page-header">
            <h1>Modifier une Disponibilité</h1>
            <p>Ajustez votre créneau horaire selon vos besoins</p>
        </div>

        <div class="form-container">
            <% String error = (String) request.getAttribute("error");
                if (error != null) { %>
            <div class="alert alert-error">
                <span class="alert-icon">⚠️</span>
                <div><%=error%></div>
            </div>
            <% } %>

            <% Availability a = (Availability) request.getAttribute("availability"); %>

            <form method="post" id="availabilityForm">
                <input type="hidden" name="id" value="<%=a.getId()%>"/>

                <div class="form-grid">
                    <!-- Day Selection -->
                    <div class="form-group">
                        <label for="dayOfWeek">
                            Jour de la semaine <span class="required">*</span>
                        </label>
                        <select name="dayOfWeek" id="dayOfWeek" class="form-control" required>
                            <%
                                String[] days = {"MONDAY", "TUESDAY", "WEDNESDAY", "THURSDAY", "FRIDAY", "SATURDAY", "SUNDAY"};
                                String[] dayNames = {"Lundi", "Mardi", "Mercredi", "Jeudi", "Vendredi", "Samedi", "Dimanche"};
                                for (int i = 0; i < days.length; i++) {
                            %>
                            <option value="<%=days[i]%>" <%= a.getDayOfWeek().name().equals(days[i]) ? "selected" : "" %>>
                                <%=dayNames[i]%>
                            </option>
                            <% } %>
                        </select>
                        <div class="form-hint">Jour de disponibilité pour ce créneau</div>
                    </div>

                    <!-- Time Selection -->
                    <div class="time-group">
                        <div class="form-group">
                            <label for="startTime">
                                Heure de début <span class="required">*</span>
                            </label>
                            <input type="time" id="startTime" name="startTime"
                                   value="<%=a.getStartTime()%>" class="form-control" required>
                            <div class="quick-times">
                                <button type="button" class="quick-time-btn" onclick="setTime('startTime', '08:00')">08:00</button>
                                <button type="button" class="quick-time-btn" onclick="setTime('startTime', '09:00')">09:00</button>
                                <button type="button" class="quick-time-btn" onclick="setTime('startTime', '14:00')">14:00</button>
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="endTime">
                                Heure de fin <span class="required">*</span>
                            </label>
                            <input type="time" id="endTime" name="endTime"
                                   value="<%=a.getEndTime()%>" class="form-control" required>
                            <div class="quick-times">
                                <button type="button" class="quick-time-btn" onclick="setTime('endTime', '12:00')">12:00</button>
                                <button type="button" class="quick-time-btn" onclick="setTime('endTime', '17:00')">17:00</button>
                                <button type="button" class="quick-time-btn" onclick="setTime('endTime', '18:00')">18:00</button>
                            </div>
                        </div>
                    </div>

                    <!-- Duration Preview -->
                    <div class="duration-preview" id="durationPreview">
                        <h4>Durée du créneau</h4>
                        <div class="duration-value" id="durationValue">0h00</div>
                    </div>

                    <!-- Active Status Toggle -->
                    <div class="toggle-group">
                        <label class="toggle-switch">
                            <input type="checkbox" id="active" name="active" <%= a.isActive() ? "checked" : "" %>>
                            <span class="toggle-slider"></span>
                        </label>
                        <div>
                            <div class="toggle-label">Créneau actif</div>
                            <div class="toggle-description">
                                Les patients peuvent réserver uniquement sur les créneaux actifs
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Form Actions -->
                <div class="form-actions">
                    <button type="submit" class="btn btn-primary">
                        <span>✓</span> Enregistrer les modifications
                    </button>
                    <a href="<%=request.getContextPath()%>/doctor/availabilities" class="btn btn-secondary">
                        <span>✕</span> Annuler
                    </a>
                    <button type="button" class="btn btn-danger" onclick="confirmDelete()">
                        <span>🗑️</span> Supprimer
                    </button>
                </div>
            </form>

            <form id="deleteForm" action="<%=request.getContextPath()%>/doctor/availabilities/delete" method="post" style="display: none;">
                <input type="hidden" name="id" value="<%=a.getId()%>"/>
            </form>
        </div>
    </main>
</div>

<script>
    const startTimeInput = document.getElementById('startTime');
    const endTimeInput = document.getElementById('endTime');
    const durationPreview = document.getElementById('durationPreview');
    const durationValue = document.getElementById('durationValue');

    function setTime(inputId, time) {
        document.getElementById(inputId).value = time;
        calculateDuration();
    }

    function calculateDuration() {
        const startTime = startTimeInput.value;
        const endTime = endTimeInput.value;

        if (startTime && endTime) {
            const [startHour, startMinute] = startTime.split(':').map(Number);
            const [endHour, endMinute] = endTime.split(':').map(Number);

            const startTotalMinutes = startHour * 60 + startMinute;
            const endTotalMinutes = endHour * 60 + endMinute;

            if (endTotalMinutes > startTotalMinutes) {
                const diffMinutes = endTotalMinutes - startTotalMinutes;
                const hours = Math.floor(diffMinutes / 60);
                const minutes = diffMinutes % 60;

                durationValue.textContent = hours + 'h' + (minutes < 10 ? '0' : '') + minutes;
                durationPreview.style.display = 'block';
            }
        }
    }

    startTimeInput.addEventListener('change', calculateDuration);
    endTimeInput.addEventListener('change', calculateDuration);

    // Calculate on page load
    calculateDuration();

    // Form validation
    document.getElementById('availabilityForm').addEventListener('submit', function(e) {
        const startTime = startTimeInput.value;
        const endTime = endTimeInput.value;

        if (startTime && endTime) {
            const [startHour, startMinute] = startTime.split(':').map(Number);
            const [endHour, endMinute] = endTime.split(':').map(Number);

            if ((endHour * 60 + endMinute) <= (startHour * 60 + startMinute)) {
                e.preventDefault();
                alert('L\'heure de fin doit être supérieure à l\'heure de début');
            }
        }
    });

    function confirmDelete() {
        if (confirm('Êtes-vous sûr de vouloir supprimer ce créneau horaire ?\n\nCette action est irréversible et annulera tous les rendez-vous programmés sur ce créneau.')) {
            document.getElementById('deleteForm').submit();
        }
    }
</script>
</body>
</html>