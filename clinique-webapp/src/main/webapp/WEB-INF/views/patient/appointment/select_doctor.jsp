<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sélection du médecin</title>
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

        .specialty-badge {
            display: inline-block;
            background: rgba(255, 255, 255, 0.2);
            padding: 8px 20px;
            border-radius: 20px;
            font-size: 14px;
            margin-top: 15px;
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

        .form-label {
            display: block;
            font-size: 14px;
            font-weight: 600;
            color: #2d3748;
            margin-bottom: 20px;
        }

        .doctor-list {
            display: flex;
            flex-direction: column;
            gap: 15px;
            margin-bottom: 30px;
        }

        .doctor-card {
            position: relative;
        }

        .doctor-card input[type="radio"] {
            position: absolute;
            opacity: 0;
            width: 0;
            height: 0;
        }

        .doctor-label {
            display: flex;
            align-items: center;
            padding: 20px;
            border: 2px solid #e2e8f0;
            border-radius: 12px;
            cursor: pointer;
            transition: all 0.3s;
        }

        .doctor-card input[type="radio"]:checked + .doctor-label {
            border-color: #4299e1;
            background: #ebf8ff;
        }

        .doctor-label:hover {
            border-color: #4299e1;
            transform: translateX(5px);
            box-shadow: 0 4px 12px rgba(66, 153, 225, 0.2);
        }

        .doctor-avatar {
            width: 60px;
            height: 60px;
            background: linear-gradient(135deg, #4299e1 0%, #3182ce 100%);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 24px;
            font-weight: 600;
            margin-right: 20px;
            flex-shrink: 0;
        }

        .doctor-info h3 {
            font-size: 18px;
            color: #2d3748;
            margin-bottom: 5px;
        }

        .doctor-info p {
            font-size: 14px;
            color: #718096;
        }

        .no-doctors {
            text-align: center;
            padding: 40px 20px;
        }

        .no-doctors-icon {
            font-size: 64px;
            margin-bottom: 15px;
        }

        .no-doctors-text {
            font-size: 18px;
            color: #718096;
        }

        .btn-container {
            display: flex;
            gap: 15px;
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
            text-decoration: none;
            text-align: center;
            display: inline-block;
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
            .doctor-avatar {
                width: 50px;
                height: 50px;
                font-size: 20px;
            }
        }
    </style>
</head>
<body>
<div class="container">
    <div class="header">
        <h1>👨‍⚕️ Choisir un médecin</h1>
        <p>Étape 2 sur 4 : Sélectionnez votre praticien</p>
        <c:if test="${not empty specialty}">
            <span class="specialty-badge">🏥 ${specialty.name}</span>
        </c:if>
        <div class="progress-bar">
            <div class="progress-step active"></div>
            <div class="progress-step active"></div>
            <div class="progress-step"></div>
            <div class="progress-step"></div>
        </div>
    </div>

    <div class="content">
        <form method="post" action="${pageContext.request.contextPath}/patient/appointment/select-doctor">
            <input type="hidden" name="specialtyId" value="${specialtyId}" />

            <c:choose>
                <c:when test="${not empty doctors}">
                    <label class="form-label">Sélectionnez un médecin disponible</label>
                    <div class="doctor-list">
                        <c:forEach var="doctor" items="${doctors}">
                            <div class="doctor-card">
                                <input type="radio" name="doctorId" id="doctor_${doctor.id}" value="${doctor.id}" required>
                                <label for="doctor_${doctor.id}" class="doctor-label">
                                    <div class="doctor-avatar">
                                            ${doctor.nom.substring(0,1).toUpperCase()}
                                    </div>
                                    <div class="doctor-info">
                                        <h3>Dr. ${doctor.last_name} ${doctor.first_name}</h3>
                                        <p>${specialty.name}</p>
                                    </div>
                                </label>
                            </div>
                        </c:forEach>
                    </div>

                    <div class="btn-container">
                        <a href="${pageContext.request.contextPath}/patient/appointment/book-appointment" class="btn btn-secondary">← Retour</a>
                        <button type="submit" class="btn btn-primary">Suivant →</button>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="no-doctors">
                        <div class="no-doctors-icon">👨‍⚕️</div>
                        <p class="no-doctors-text">Aucun médecin disponible pour cette spécialité</p>
                    </div>
                    <div class="btn-container">
                        <a href="${pageContext.request.contextPath}/patient/appointment/book-appointment" class="btn btn-primary">← Retour aux spécialités</a>
                    </div>
                </c:otherwise>
            </c:choose>
        </form>
    </div>
</div>
</body>
</html>