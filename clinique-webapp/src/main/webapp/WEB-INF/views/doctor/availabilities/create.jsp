<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.clinique.domain.Enum.DayOfWeek" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Ajouter une Disponibilité</title>
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

        /* Tips Section */
        .tips-section {
            background: #ebf8ff;
            padding: 20px;
            border-radius: 8px;
            border-left: 4px solid #3182ce;
            margin-top: 24px;
        }

        .tips-section h4 {
            font-size: 14px;
            color: #2c5282;
            margin-bottom: 12px;
            font-weight: 600;
        }

        .tips-section ul {
            list-style: none;
            font-size: 13px;
            color: #2c5282;
        }

        .tips-section li {
            padding: 6px 0;
            padding-left: 20px;
            position: relative;
        }

        .tips-section li::before {
            content: '💡';
            position: absolute;
            left: 0;
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
            <span style="color: #2d3748;">Ajouter</span>
        </div>

        <div class="page-header">
            <h1>Ajouter une Disponibilité</h1>
            <p>Définissez un nouveau créneau horaire pour vos consultations</p>
        </div>

        <div class="form-container">
            <% String error = (String) request.getAttribute("error");
                if (error != null) { %>
            <div class="alert alert-error">
                <span class="alert-icon">⚠️</span>
                <div><%=error%></div>
            </div>
            <% } %>

            <form method="post" id="availabilityForm">
                <div class="form-grid">
                    <!-- Day Selection -->
                    <div class="form-group">
                        <label for="dayOfWeek">
                            Jour de la semaine <span class="required">*</span>
                        </label>
                        <select name="dayOfWeek" id="dayOfWeek" class="form-control" required>
                            <option value="">Sélectionnez un jour...</option>
                            <option value="MONDAY">Lundi</option>
                            <option value="TUESDAY">Mardi</option>
                            <option value="WEDNESDAY">Mercredi</option>
                            <option value="THURSDAY">Jeudi</option>
                            <option value="FRIDAY">Vendredi</option>
                            <option value="SATURDAY">Samedi</option>
                            <option value="SUNDAY">Dimanche</option>
                        </select>
                        <div class="form-hint">Choisissez le jour où vous souhaitez être disponible</div>
                    </div>

                    <!-- Time Selection -->
                    <div class="time-group">
                        <div class="form-group">
                            <label for="startTime">
                                Heure de début <span class="required">*</span>
                            </label>
                            <input type="time" id="startTime" name="startTime" class="form-control" required>
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
                            <input type="time" id="endTime" name="endTime" class="form-control" required>
                            <div class="quick-times">
                                <button type="button" class="quick-time-btn" onclick="setTime('endTime', '12:00')">12:00</button>
                                <button type="button" class="quick-time-btn" onclick="setTime('endTime', '17:00')">17:00</button>
                                <button type="button" class="quick-time-btn" onclick="setTime('endTime', '18:00')">18:00</button>
                            </div>
                        </div>
                    </div>

                    <!-- Duration Preview -->
                    <div class="duration-preview" id="durationPreview" style="display: none;">
                        <h4>Durée du créneau</h4>
                        <div class="duration-value" id="durationValue">0h00</div>
                    </div>
                </div>

                <!-- Tips Section -->
                <div class="tips-section">
                    <h4>💡 Conseils pour optimiser votre planning</h4>
                    <ul>
                        <li>Prévoyez des créneaux de 15-30 minutes entre les consultations</li>
                        <li>Les créneaux peuvent se chevaucher sur différents jours</li>
                        <li>Vous pourrez désactiver temporairement un créneau sans le supprimer</li>
                        <li>Les patients ne pourront réserver que sur vos créneaux actifs</li>
                    </ul>
                </div>

                <!-- Form Actions -->
                <div class="form-actions">
                    <button type="submit" class="btn btn-primary">
                        <span>✓</span> Créer la disponibilité
                    </button>
                    <a href="<%=request.getContextPath()%>/doctor/availabilities" class="btn btn-secondary">
                        <span>✕</span> Annuler
                    </a>
                </div>
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
            } else {
                durationPreview.style.display = 'none';
            }
        } else {
            durationPreview.style.display = 'none';
        }
    }

    startTimeInput.addEventListener('change', calculateDuration);
    endTimeInput.addEventListener('change', calculateDuration);

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
</script>
</body>
</html>