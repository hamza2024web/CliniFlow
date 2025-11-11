<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Choisir un créneau</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
        }

        .container {
            background: white;
            border-radius: 20px;
            box-shadow: 0 20px 60px rgba(0, 0, 0, 0.3);
            max-width: 700px;
            width: 100%;
            overflow: hidden;
        }

        .header {
            background: linear-gradient(135deg, #4299e1 0%, #3182ce 100%);
            padding: 40px 30px;
            text-align: center;
            color: white;
        }

        .header h1 {
            font-size: 28px;
            margin-bottom: 10px;
        }

        .header p {
            font-size: 14px;
            opacity: 0.9;
        }

        .appointment-info {
            background: rgba(255, 255, 255, 0.2);
            padding: 15px;
            border-radius: 10px;
            margin-top: 15px;
            font-size: 14px;
        }

        .progress-bar {
            display: flex;
            justify-content: center;
            gap: 10px;
            margin-top: 20px;
        }

        .progress-step {
            width: 12px;
            height: 12px;
            border-radius: 50%;
            background: rgba(255, 255, 255, 0.3);
        }

        .progress-step.active {
            background: white;
        }

        .content {
            padding: 40px 30px;
        }

        .form-group {
            margin-bottom: 30px;
        }

        .form-label {
            display: block;
            font-size: 14px;
            font-weight: 600;
            color: #2d3748;
            margin-bottom: 12px;
        }

        .slots-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(120px, 1fr));
            gap: 12px;
        }

        .slot-card {
            position: relative;
        }

        .slot-card input[type="radio"] {
            position: absolute;
            opacity: 0;
            width: 0;
            height: 0;
        }

        .slot-label {
            display: flex;
            flex-direction: column;
            align-items: center;
            padding: 15px 10px;
            border: 2px solid #e2e8f0;
            border-radius: 10px;
            cursor: pointer;
            transition: all 0.3s;
            text-align: center;
        }

        .slot-card input[type="radio"]:checked + .slot-label {
            border-color: #4299e1;
            background: #ebf8ff;
        }

        .slot-label:hover {
            border-color: #4299e1;
            transform: translateY(-3px);
            box-shadow: 0 4px 12px rgba(66, 153, 225, 0.2);
        }

        .slot-label.disabled {
            cursor: not-allowed;
            opacity: 0.5;
            background: #f7fafc;
        }

        .slot-label.disabled:hover {
            transform: none;
            box-shadow: none;
            border-color: #e2e8f0;
        }

        .slot-time {
            font-size: 16px;
            font-weight: 600;
            color: #2d3748;
            margin-bottom: 5px;
        }

        .slot-duration {
            font-size: 12px;
            color: #718096;
        }

        .slot-status {
            display: inline-block;
            padding: 2px 8px;
            border-radius: 10px;
            font-size: 10px;
            font-weight: 600;
            margin-top: 5px;
        }

        .slot-status.available {
            background: #c6f6d5;
            color: #22543d;
        }

        .slot-status.unavailable {
            background: #fed7d7;
            color: #742a2a;
        }

        .no-slots {
            text-align: center;
            padding: 40px 20px;
        }

        .no-slots-icon {
            font-size: 64px;
            margin-bottom: 15px;
        }

        .no-slots-text {
            font-size: 18px;
            color: #718096;
        }

        .btn-container {
            display: flex;
            gap: 15px;
            margin-top: 30px;
        }

        .btn {
            flex: 1;
            padding: 15px;
            border: none;
            border-radius: 10px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s;
        }

        .btn-primary {
            background: linear-gradient(135deg, #4299e1 0%, #3182ce 100%);
            color: white;
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(66, 153, 225, 0.4);
        }

        .btn-secondary {
            background: #f7fafc;
            color: #2d3748;
            border: 2px solid #e2e8f0;
        }

        .btn-secondary:hover {
            background: #edf2f7;
        }

        @media (max-width: 600px) {
            .slots-grid {
                grid-template-columns: repeat(auto-fill, minmax(100px, 1fr));
            }
        }
    </style>
</head>
<body>
<div class="container">
    <div class="header">
        <h1>⏰ Créneaux disponibles</h1>
        <p>Étape 4 sur 4 : Choisissez votre horaire</p>
        <div class="appointment-info">
            📅 ${date} | 🏥 ${appointmentType}
        </div>
        <div class="progress-bar">
            <div class="progress-step active"></div>
            <div class="progress-step active"></div>
            <div class="progress-step active"></div>
            <div class="progress-step active"></div>
        </div>
    </div>

    <div class="content">
        <form method="post" action="${pageContext.request.contextPath}/patient/appointment/select-slot">
            <input type="hidden" name="doctorId" value="${doctorId}" />
            <input type="hidden" name="specialtyId" value="${specialtyId}" />
            <input type="hidden" name="date" value="${date}" />
            <input type="hidden" name="appointmentType" value="${appointmentType}" />

            <div class="form-group">
                <label class="form-label">Sélectionnez un créneau horaire</label>

                <c:choose>
                    <c:when test="${not empty slots}">
                        <div class="slots-grid">
                            <c:forEach var="slot" items="${slots}">
                                <div class="slot-card">
                                    <c:choose>
                                        <c:when test="${slot.available}">
                                            <input type="radio" name="slotStart" id="slot_${slot.start}" value="${slot.start}" required>
                                            <label for="slot_${slot.start}" class="slot-label">
                                                <span class="slot-time">${slot.start}</span>
                                                <span class="slot-duration">→ ${slot.end}</span>
                                                <span class="slot-status available">✓ Disponible</span>
                                            </label>
                                        </c:when>
                                        <c:otherwise>
                                            <label class="slot-label disabled">
                                                <span class="slot-time">${slot.start}</span>
                                                <span class="slot-duration">→ ${slot.end}</span>
                                                <span class="slot-status unavailable">✗ Occupé</span>
                                            </label>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </c:forEach>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="no-slots">
                            <div class="no-slots-icon">📭</div>
                            <p class="no-slots-text">Aucun créneau disponible pour cette date</p>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>

            <div class="btn-container">
                <button type="button" onclick="history.back()" class="btn btn-secondary">← Retour</button>
                <c:if test="${not empty slots}">
                    <button type="submit" class="btn btn-primary">Confirmer le rendez-vous ✓</button>
                </c:if>
            </div>
        </form>
    </div>
</div>
</body>
</html>