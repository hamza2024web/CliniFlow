<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mon Dossier Médical</title>
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
            background: linear-gradient(180deg, #4299e1 0%, #3182ce 100%);
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
            background: #63b3ed;
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
            display: flex;
            align-items: center;
            gap: 12px;
            margin-bottom: 8px;
        }

        .page-header p {
            color: #718096;
            font-size: 15px;
        }

        /* Filter Bar */
        .filter-bar {
            background: white;
            padding: 20px 25px;
            border-radius: 12px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
            margin-bottom: 25px;
            display: flex;
            gap: 15px;
            align-items: center;
            flex-wrap: wrap;
        }

        .search-box {
            flex: 1;
            min-width: 250px;
            position: relative;
        }

        .search-box input {
            width: 100%;
            padding: 12px 15px 12px 45px;
            border: 2px solid #e2e8f0;
            border-radius: 10px;
            font-size: 14px;
            transition: all 0.3s;
        }

        .search-box input:focus {
            outline: none;
            border-color: #4299e1;
            box-shadow: 0 0 0 3px rgba(66, 153, 225, 0.1);
        }

        .search-icon {
            position: absolute;
            left: 15px;
            top: 50%;
            transform: translateY(-50%);
            color: #718096;
            font-size: 18px;
        }

        .filter-btn {
            padding: 12px 20px;
            background: white;
            border: 2px solid #e2e8f0;
            border-radius: 10px;
            font-size: 14px;
            font-weight: 600;
            color: #4a5568;
            cursor: pointer;
            transition: all 0.3s;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .filter-btn:hover {
            border-color: #4299e1;
            color: #4299e1;
        }

        /* Timeline */
        .timeline {
            position: relative;
            padding-left: 30px;
        }

        .timeline::before {
            content: '';
            position: absolute;
            left: 0;
            top: 0;
            bottom: 0;
            width: 2px;
            background: linear-gradient(180deg, #4299e1 0%, #e2e8f0 100%);
        }

        .timeline-item {
            position: relative;
            margin-bottom: 30px;
        }

        .timeline-dot {
            position: absolute;
            left: -35px;
            top: 25px;
            width: 12px;
            height: 12px;
            background: #4299e1;
            border: 3px solid white;
            border-radius: 50%;
            box-shadow: 0 0 0 4px rgba(66, 153, 225, 0.2);
        }

        .note-card {
            background: white;
            border-radius: 12px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
            overflow: hidden;
            transition: all 0.3s;
        }

        .note-card:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 24px rgba(0, 0, 0, 0.1);
        }

        .note-header {
            background: linear-gradient(90deg, #ebf8ff 0%, white 100%);
            padding: 20px 25px;
            border-left: 4px solid #4299e1;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .note-info {
            display: flex;
            align-items: center;
            gap: 15px;
        }

        .doctor-avatar {
            width: 50px;
            height: 50px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 20px;
            font-weight: 600;
        }

        .doctor-details h3 {
            font-size: 16px;
            color: #2d3748;
            margin-bottom: 4px;
        }

        .doctor-details p {
            font-size: 13px;
            color: #718096;
        }

        .note-date {
            text-align: right;
        }

        .note-date .date-label {
            font-size: 12px;
            color: #718096;
            text-transform: uppercase;
            font-weight: 600;
            margin-bottom: 4px;
        }

        .note-date .date-value {
            font-size: 14px;
            color: #2d3748;
            font-weight: 600;
        }

        .note-body {
            padding: 25px;
        }

        .note-content {
            color: #4a5568;
            line-height: 1.8;
            font-size: 14px;
            white-space: pre-wrap;
            max-height: 300px;
            overflow-y: auto;
        }

        .note-content::-webkit-scrollbar {
            width: 6px;
        }

        .note-content::-webkit-scrollbar-track {
            background: #f7fafc;
            border-radius: 10px;
        }

        .note-content::-webkit-scrollbar-thumb {
            background: #cbd5e0;
            border-radius: 10px;
        }

        .note-footer {
            padding: 15px 25px;
            background: #f7fafc;
            border-top: 1px solid #e2e8f0;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .note-tags {
            display: flex;
            gap: 8px;
            flex-wrap: wrap;
        }

        .tag {
            padding: 4px 12px;
            background: #e2e8f0;
            color: #4a5568;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 600;
        }

        .btn-actions {
            display: flex;
            gap: 10px;
        }

        .btn-icon {
            width: 35px;
            height: 35px;
            border-radius: 8px;
            border: none;
            background: white;
            color: #718096;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
            transition: all 0.3s;
            font-size: 16px;
        }

        .btn-icon:hover {
            background: #4299e1;
            color: white;
            transform: scale(1.1);
        }

        /* Empty State */
        .empty-state {
            background: white;
            padding: 80px 30px;
            border-radius: 12px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
            text-align: center;
        }

        .empty-state .empty-icon {
            font-size: 100px;
            margin-bottom: 25px;
            opacity: 0.3;
        }

        .empty-state h3 {
            font-size: 24px;
            color: #2d3748;
            margin-bottom: 12px;
        }

        .empty-state p {
            font-size: 16px;
            color: #718096;
            margin-bottom: 30px;
            line-height: 1.6;
        }

        .stats-bar {
            background: white;
            padding: 20px 25px;
            border-radius: 12px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
            margin-bottom: 25px;
            display: flex;
            justify-content: space-around;
            gap: 20px;
        }

        .stat-item {
            text-align: center;
        }

        .stat-value {
            font-size: 28px;
            font-weight: 700;
            color: #4299e1;
            margin-bottom: 5px;
        }

        .stat-label {
            font-size: 13px;
            color: #718096;
            text-transform: uppercase;
            font-weight: 600;
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

            .filter-bar {
                flex-direction: column;
            }

            .search-box {
                width: 100%;
            }

            .note-header {
                flex-direction: column;
                gap: 15px;
                align-items: flex-start;
            }

            .note-date {
                text-align: left;
            }

            .stats-bar {
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
            <span class="role-badge">PATIENT</span>
        </div>

        <ul class="nav-menu">
            <li class="nav-item">
                <a href="${pageContext.request.contextPath}/patient/dashboard" class="nav-link">
                    <span class="nav-icon">📊</span>
                    Tableau de bord
                </a>
            </li>
            <li class="nav-item">
                <a href="${pageContext.request.contextPath}/patient/appointment/book-appointment" class="nav-link">
                    <span class="nav-icon">📅</span>
                    Prendre rendez-vous
                </a>
            </li>
            <li class="nav-item">
                <a href="${pageContext.request.contextPath}/patient/mes_rendez_vous" class="nav-link">
                    <span class="nav-icon">📋</span>
                    Mes rendez-vous
                </a>
            </li>
            <li class="nav-item">
                <a href="${pageContext.request.contextPath}/patient/medical-notes" class="nav-link active">
                    <span class="nav-icon">📖</span>
                    Historique médical
                </a>
            </li>
            <li class="nav-item">
                <a href="#" class="nav-link">
                    <span class="nav-icon">⚙️</span>
                    Mon profil
                </a>
            </li>
        </ul>

        <a href="${pageContext.request.contextPath}/logout" class="logout-btn">Se déconnecter</a>
    </aside>

    <!-- Main Content -->
    <main class="main-content">
        <!-- Page Header -->
        <div class="page-header">
            <h1>
                <span>📖</span>
                Mon Dossier Médical
            </h1>
            <p>Consultez l'historique de vos consultations et notes médicales</p>
        </div>

        <c:if test="${not empty notes}">
            <!-- Stats Bar -->
            <div class="stats-bar">
                <div class="stat-item">
                    <div class="stat-value">${notes.size()}</div>
                    <div class="stat-label">Notes médicales</div>
                </div>
                <div class="stat-item">
                    <div class="stat-value">
                        <c:set var="uniqueDoctors" value="${notes.stream().map(n -> n.doctor.id).distinct().count()}" />
                            ${uniqueDoctors > 0 ? uniqueDoctors : notes.stream().map(n -> n.doctor.id).distinct().count()}
                    </div>
                    <div class="stat-label">Médecins consultés</div>
                </div>
                <div class="stat-item">
                    <div class="stat-value">100%</div>
                    <div class="stat-label">Confidentialité</div>
                </div>
            </div>

            <!-- Filter Bar -->
            <div class="filter-bar">
                <div class="search-box">
                    <span class="search-icon">🔍</span>
                    <input type="text" id="searchInput" placeholder="Rechercher dans vos notes médicales..." onkeyup="filterNotes()">
                </div>
                <button class="filter-btn">
                    <span>📅</span>
                    Filtrer par date
                </button>
                <button class="filter-btn">
                    <span>👨‍⚕️</span>
                    Par médecin
                </button>
            </div>

            <!-- Timeline -->
            <div class="timeline">
                <c:forEach var="note" items="${notes}">
                    <div class="timeline-item note-item">
                        <div class="timeline-dot"></div>
                        <div class="note-card">
                            <div class="note-header">
                                <div class="note-info">
                                    <div class="doctor-avatar">
                                            ${note.doctor.user.firstName.substring(0,1)}
                                    </div>
                                    <div class="doctor-details">
                                        <h3>Dr. ${note.doctor.user.firstName} ${note.doctor.user.lastName}</h3>
                                        <p>Médecin généraliste</p>
                                    </div>
                                </div>
                                <div class="note-date">
                                    <div class="date-label">Date</div>
                                    <div class="date-value">${formattedDates[note.id]}</div>
                                </div>
                            </div>

                            <div class="note-body">
                                <div class="note-content">${note.content}</div>
                            </div>

                            <div class="note-footer">
                                <div class="note-tags">
                                    <span class="tag">Consultation</span>
                                    <span class="tag">Dossier complet</span>
                                </div>
                                <div class="btn-actions">
                                    <button class="btn-icon" title="Imprimer" onclick="printNote(${note.id})">
                                        🖨️
                                    </button>
                                    <button class="btn-icon" title="Télécharger PDF" onclick="downloadNote(${note.id})">
                                        📥
                                    </button>
                                    <button class="btn-icon" title="Partager" onclick="shareNote(${note.id})">
                                        📤
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </c:if>

        <c:if test="${empty notes}">
            <div class="empty-state">
                <div class="empty-icon">📋</div>
                <h3>Aucune note médicale</h3>
                <p>Votre dossier médical est vide pour le moment.<br>
                    Les notes de vos prochaines consultations apparaîtront ici.</p>
            </div>
        </c:if>
    </main>
</div>

<script>
    // Search/Filter functionality
    function filterNotes() {
        const input = document.getElementById('searchInput');
        const filter = input.value.toLowerCase();
        const items = document.getElementsByClassName('note-item');

        for (let i = 0; i < items.length; i++) {
            const content = items[i].textContent || items[i].innerText;
            if (content.toLowerCase().indexOf(filter) > -1) {
                items[i].style.display = '';
            } else {
                items[i].style.display = 'none';
            }
        }
    }

    // Print note
    function printNote(noteId) {
        window.print();
    }

    // Download as PDF (placeholder)
    function downloadNote(noteId) {
        alert('Fonctionnalité de téléchargement PDF en cours de développement.\nNote ID: ' + noteId);
    }

    // Share note (placeholder)
    function shareNote(noteId) {
        alert('Fonctionnalité de partage en cours de développement.\nNote ID: ' + noteId);
    }
</script>
</body>
</html>