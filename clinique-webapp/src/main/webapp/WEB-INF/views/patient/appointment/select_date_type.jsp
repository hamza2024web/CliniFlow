<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Choix de la date et du type</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: #f7fafc;
            min-height: 100vh;
            padding: 40px 20px;
        }

        .container {
            max-width: 700px;
            margin: 0 auto;
        }

        .page-header {
            background: white;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
            margin-bottom: 30px;
        }

        .page-header h2 {
            font-size: 28px;
            color: #2d3748;
            margin-bottom: 10px;
        }

        .page-header p {
            font-size: 14px;
            color: #718096;
        }

        .form-container {
            background: white;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
        }

        .form-group {
            margin-bottom: 25px;
        }

        .form-label {
            display: block;
            font-size: 14px;
            font-weight: 600;
            color: #2d3748;
            margin-bottom: 12px;
        }

        .form-control {
            width: 100%;
            padding: 15px;
            border: 2px solid #e2e8f0;
            border-radius: 10px;
            font-size: 16px;
            font-family: inherit;
            transition: all 0.3s;
        }

        .form-control:focus {
            outline: none;
            border-color: #4299e1;
            box-shadow: 0 0 0 3px rgba(66, 153, 225, 0.1);
        }

        .type-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(180px, 1fr));
            gap: 15px;
        }

        .type-card {
            position: relative;
        }

        .type-card input[type="radio"] {
            position: absolute;
            opacity: 0;
            width: 0;
            height: 0;
        }

        .type-label {
            display: flex;
            flex-direction: column;
            align-items: center;
            padding: 25px 20px;
            border: 2px solid #e2e8f0;
            border-radius: 12px;
            cursor: pointer;
            transition: all 0.3s;
            text-align: center;
            height: 100%;
        }

        .type-card input[type="radio"]:checked + .type-label {
            border-color: #4299e1;
            background: #ebf8ff;
        }

        .type-label:hover {
            border-color: #4299e1;
            transform: translateY(-3px);
            box-shadow: 0 4px 12px rgba(66, 153, 225, 0.2);
        }

        .type-icon {
            font-size: 40px;
            margin-bottom: 12px;
        }

        .type-name {
            font-size: 16px;
            font-weight: 600;
            color: #2d3748;
            margin-bottom: 5px;
        }

        .type-description {
            font-size: 13px;
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
            .page-header {
                padding: 20px;
            }

            .form-container {
                padding: 20px;
            }

            .type-grid {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
<div class="container">
    <div class="page-header">
        <h2>📅 Date et type de rendez-vous</h2>
        <p>Choisissez la date et le type de consultation</p>
    </div>

    <div class="form-container">
        <form method="post" action="${pageContext.request.contextPath}/patient/appointment/select-date-type">
            <input type="hidden" name="doctorId" value="${doctorId}" />
            <input type="hidden" name="specialtyId" value="${specialtyId}" />

            <div class="form-group">
                <label for="date" class="form-label">📆 Sélectionnez une date</label>
                <input type="date" id="date" name="date" class="form-control" required />
            </div>

            <div class="form-group">
                <label class="form-label">🏥 Type de rendez-vous</label>
                <div class="type-grid">
                    <div class="type-card">
                        <input type="radio" name="appointmentType" id="type_consultation" value="CONSULTATION" required checked>
                        <label for="type_consultation" class="type-label">
                            <span class="type-icon">💬</span>
                            <span class="type-name">Consultation</span>
                            <span class="type-description">Rendez-vous standard</span>
                        </label>
                    </div>
                    <div class="type-card">
                        <input type="radio" name="appointmentType" id="type_specialized" value="SPECIALIZED">
                        <label for="type_specialized" class="type-label">
                            <span class="type-icon">🔬</span>
                            <span class="type-name">Spécialisé</span>
                            <span class="type-description">Examen approfondi</span>
                        </label>
                    </div>
                    <div class="type-card">
                        <input type="radio" name="appointmentType" id="type_emergency" value="URGENCY">
                        <label for="type_emergency" class="type-label">
                            <span class="type-icon">🚨</span>
                            <span class="type-name">Urgence</span>
                            <span class="type-description">Besoin immédiat</span>
                        </label>
                    </div>
                </div>
            </div>

            <div class="btn-container">
                <button type="button" onclick="history.back()" class="btn btn-secondary">← Retour</button>
                <button type="submit" class="btn btn-primary">Voir les créneaux →</button>
            </div>
        </form>
    </div>
</div>

<script>
    // Définir la date minimale à aujourd'hui
    const dateInput = document.getElementById('date');
    const today = new Date().toISOString().split('T')[0];
    dateInput.min = today;
    dateInput.value = today;
</script>
</body>
</html>