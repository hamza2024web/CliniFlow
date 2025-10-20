<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mes Notes Médicales - Docteur</title>
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
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .page-header p {
            color: #718096;
            font-size: 14px;
            margin-top: 8px;
        }

        .stats-bar {
            background: white;
            padding: 20px 25px;
            border-radius: 12px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
            margin-bottom: 25px;
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
        }

        .stat-item {
            text-align: center;
            padding: 15px;
            background: linear-gradient(135deg, #f0fdfa 0%, #ccfbf1 100%);
            border-radius: 10px;
            border: 2px solid #5eead4;
        }

        .stat-value {
            font-size: 32px;
            font-weight: 700;
            color: #0f766e;
            margin-bottom: 5px;
        }

        .stat-label {
            font-size: 13px;
            color: #14b8a6;
            text-transform: uppercase;
            font-weight: 600;
        }

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
            border-color: #319795;
            box-shadow: 0 0 0 3px rgba(49, 151, 149, 0.1);
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

        .filter-btn:hover,
        .filter-btn.active {
            border-color: #319795;
            background: #f0fdfa;
            color: #319795;
        }

        .notes-grid {
            display: grid;
            gap: 20px;
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
            background: linear-gradient(90deg, #f0fdfa 0%, white 100%);
            padding: 20px 25px;
            border-left: 4px solid #319795;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .patient-info {
            display: flex;
            align-items: center;
            gap: 15px;
        }

        .patient-avatar {
            width: 50px;
            height: 50px;
            background: linear-gradient(135deg, #319795 0%, #2c7a7b 100%);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 20px;
            font-weight: 600;
        }

        .patient-details h3 {
            font-size: 16px;
            color: #2d3748;
            margin-bottom: 4px;
            font-weight: 600;
        }

        .patient-details p {
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
            max-height: 200px;
            overflow-y: auto;
            margin-bottom: 15px;
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

        .read-more {
            color: #319795;
            font-weight: 600;
            cursor: pointer;
            font-size: 14px;
            text-decoration: none;
            display: inline-block;
        }

        .read-more:hover {
            text-decoration: underline;
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
            background: #e6fffa;
            color: #0f766e;
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
            background: #319795;
            color: white;
            transform: scale(1.1);
        }

        .btn-edit {
            padding: 8px 16px;
            background: #319795;
            color: white;
            border: none;
            border-radius: 8px;
            font-size: 13px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s;
            display: inline-flex;
            align-items: center;
            gap: 6px;
            text-decoration: none;
        }

        .btn-edit:hover {
            background: #2c7a7b;
            transform: translateY(-2px);
        }

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
                gap: 20px;
                align-items: flex-start;
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
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
<div class="dashboard-container">
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
                <a href="${pageContext.request.contextPath}/doctor/agenda" class="nav-link">
                    <span class="nav-icon">📅</span>
                    Mon agenda
                </a>
            </li>
            <li class="nav-item">
                <a href="${pageContext.request.contextPath}/doctor/availabilities" class="nav-link">
                    <span class="nav-icon">🕒</span>
                    Mes disponibilités
                </a>
            </li>
            <li class="nav-item">
                <a href="${pageContext.request.contextPath}/doctor/mes_patients" class="nav-link">
                    <span class="nav-icon">👥</span>
                    Mes patients
                </a>
            </li>
            <li class="nav-item">
                <a href="${pageContext.request.contextPath}/doctor/medical-notes" class="nav-link active">
                    <span class="nav-icon">📝</span>
                    Notes médicales
                </a>
            </li>
        </ul>

        <a href="${pageContext.request.contextPath}/logout" class="logout-btn">Se déconnecter</a>
    </aside>

    <main class="main-content">
        <div class="page-header">
            <div>
                <h1>
                    <span>📝</span>
                    Mes Notes Médicales
                </h1>
                <p>Gérez et consultez toutes vos notes médicales</p>
            </div>
        </div>

        <c:choose>
            <c:when test="${not empty medical_notes}">
                <!-- Stats Bar -->
                <div class="stats-bar">
                    <div class="stat-item">
                        <div class="stat-value">${fn:length(medical_notes)}</div>
                        <div class="stat-label">Notes totales</div>
                    </div>
                    <div class="stat-item">
                        <div class="stat-value">
                            <jsp:useBean id="patientSet" class="java.util.HashSet" scope="page"/>
                            <c:forEach var="note" items="${medical_notes}">
                                <c:set target="${patientSet}" property="${note.patient.id}" value="true"/>
                            </c:forEach>
                                ${patientSet.size()}
                        </div>
                        <div class="stat-label">Patients suivis</div>
                    </div>
                    <div class="stat-item">
                        <div class="stat-value">100%</div>
                        <div class="stat-label">Conformité</div>
                    </div>
                </div>

                <!-- Filter Bar -->
                <div class="filter-bar">
                    <div class="search-box">
                        <span class="search-icon">🔍</span>
                        <input type="text" id="searchInput"
                               placeholder="Rechercher par nom de patient ou contenu..."
                               onkeyup="filterNotes()">
                    </div>
                    <button class="filter-btn" onclick="sortByDate()">
                        <span>📅</span>
                        Trier par date
                    </button>
                    <button class="filter-btn" onclick="sortByPatient()">
                        <span>👤</span>
                        Trier par patient
                    </button>
                </div>

                <!-- Notes Grid -->
                <div class="notes-grid" id="notesGrid">
                    <c:forEach var="note" items="${medical_notes}">
                        <div class="note-card note-item"
                             data-patient="${note.patient.user.firstName} ${note.patient.user.lastName}"
                             data-date="${note.createdAt}">
                            <div class="note-header">
                                <div class="patient-info">
                                    <div class="patient-avatar">
                                            ${not empty note.patient.user.firstName ? note.patient.user.firstName.substring(0,1).toUpperCase() : 'P'}
                                    </div>
                                    <div class="patient-details">
                                        <h3>${note.patient.user.firstName} ${note.patient.user.lastName}</h3>
                                        <p>
                                            <c:if test="${not empty note.patient.cin}">
                                                CIN: ${note.patient.cin}
                                            </c:if>
                                            <c:if test="${not empty note.patient.phoneNumber}">
                                                | Tel: ${note.patient.phoneNumber}
                                            </c:if>
                                        </p>
                                    </div>
                                </div>
                                <div class="note-date">
                                    <div class="date-label">Créée le</div>
                                    <div class="date-value">
                                        <fmt:formatDate value="${note.createdAt}" pattern="dd/MM/yyyy"/>
                                    </div>
                                </div>
                            </div>

                            <div class="note-body">
                                <div class="note-content">
                                        ${fn:substring(note.content, 0, 300)}
                                        ${fn:length(note.content) > 300 ? '...' : ''}
                                </div>
                                <a href="${pageContext.request.contextPath}/doctor/medical-note/view?id=${note.id}"
                                   class="read-more">
                                    Voir les détails complets →
                                </a>
                            </div>

                            <div class="note-footer">
                                <div class="note-tags">
                                    <span class="tag">
                                        <c:choose>
                                            <c:when test="${not empty note.appointment.appointmentType}">
                                                ${note.appointment.appointmentType}
                                            </c:when>
                                            <c:otherwise>Consultation</c:otherwise>
                                        </c:choose>
                                    </span>
                                    <span class="tag">Note complète</span>
                                </div>
                                <div class="btn-actions">
                                    <a href="${pageContext.request.contextPath}/doctor/medical-note/edit?id=${note.id}"
                                       class="btn-edit">
                                        <span>✏️</span>
                                        Modifier
                                    </a>
                                    <button class="btn-icon" title="Imprimer"
                                            onclick="printNote(${note.id})">
                                        🖨️
                                    </button>
                                    <button class="btn-icon" title="Télécharger PDF"
                                            onclick="downloadNote(${note.id})">
                                        📥
                                    </button>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:when>
            <c:otherwise>
                <div class="empty-state">
                    <div class="empty-icon">📝</div>
                    <h3>Aucune note médicale</h3>
                    <p>Vous n'avez pas encore créé de notes médicales.<br>
                        Commencez par compléter les rendez-vous dans votre agenda.</p>
                    <a href="${pageContext.request.contextPath}/doctor/agenda"
                       class="btn-edit" style="display: inline-flex;">
                        <span>📅</span>
                        Voir mon agenda
                    </a>
                </div>
            </c:otherwise>
        </c:choose>
    </main>
</div>

<script>
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

    function sortByDate() {
        const grid = document.getElementById('notesGrid');
        const items = Array.from(document.getElementsByClassName('note-item'));

        items.sort((a, b) => {
            const dateA = new Date(a.getAttribute('data-date'));
            const dateB = new Date(b.getAttribute('data-date'));
            return dateB - dateA;
        });

        items.forEach(item => grid.appendChild(item));
    }

    function sortByPatient() {
        const grid = document.getElementById('notesGrid');
        const items = Array.from(document.getElementsByClassName('note-item'));

        items.sort((a, b) => {
            const patientA = a.getAttribute('data-patient').toLowerCase();
            const patientB = b.getAttribute('data-patient').toLowerCase();
            return patientA.localeCompare(patientB);
        });

        items.forEach(item => grid.appendChild(item));
    }

    function printNote(noteId) {
        window.open('${pageContext.request.contextPath}/doctor/medical-note/print?id=' + noteId, '_blank');
    }

    function downloadNote(noteId) {
        window.location.href = '${pageContext.request.contextPath}/doctor/medical-note/download?id=' + noteId;
    }
</script>
</body>
</html>