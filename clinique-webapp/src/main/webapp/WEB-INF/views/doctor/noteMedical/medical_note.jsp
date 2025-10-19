<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Ajouter une Note Médicale</title>
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
            padding: 40px 20px;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .container {
            max-width: 900px;
            width: 100%;
        }

        .form-card {
            background: white;
            border-radius: 20px;
            box-shadow: 0 20px 60px rgba(0, 0, 0, 0.3);
            overflow: hidden;
        }

        .form-header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            padding: 40px 30px;
            text-align: center;
            color: white;
        }

        .form-header .icon {
            font-size: 60px;
            margin-bottom: 15px;
            display: block;
        }

        .form-header h1 {
            font-size: 28px;
            margin-bottom: 8px;
        }

        .form-header p {
            font-size: 15px;
            opacity: 0.9;
        }

        .form-body {
            padding: 40px;
        }

        .info-section {
            background: #f7fafc;
            border-radius: 12px;
            padding: 25px;
            margin-bottom: 30px;
            border-left: 4px solid #667eea;
        }

        .info-section h3 {
            color: #2d3748;
            font-size: 16px;
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .info-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
        }

        .info-item {
            display: flex;
            align-items: flex-start;
            gap: 12px;
        }

        .info-icon {
            width: 40px;
            height: 40px;
            background: white;
            border-radius: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 20px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
        }

        .info-content {
            flex: 1;
        }

        .info-label {
            font-size: 12px;
            color: #718096;
            text-transform: uppercase;
            font-weight: 600;
            margin-bottom: 4px;
            letter-spacing: 0.5px;
        }

        .info-value {
            font-size: 15px;
            color: #2d3748;
            font-weight: 600;
        }

        .form-group {
            margin-bottom: 25px;
        }

        .form-group label {
            display: block;
            font-size: 14px;
            font-weight: 600;
            color: #2d3748;
            margin-bottom: 10px;
        }

        .form-group label .required {
            color: #e53e3e;
            margin-left: 4px;
        }

        .form-group textarea {
            width: 100%;
            padding: 15px;
            border: 2px solid #e2e8f0;
            border-radius: 10px;
            font-size: 15px;
            font-family: inherit;
            resize: vertical;
            transition: all 0.3s;
            min-height: 200px;
        }

        .form-group textarea:focus {
            outline: none;
            border-color: #667eea;
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
        }

        .char-counter {
            text-align: right;
            font-size: 12px;
            color: #718096;
            margin-top: 5px;
        }

        .quick-insert {
            margin-bottom: 25px;
        }

        .quick-insert h4 {
            font-size: 14px;
            color: #2d3748;
            margin-bottom: 12px;
            font-weight: 600;
        }

        .quick-buttons {
            display: flex;
            flex-wrap: wrap;
            gap: 8px;
        }

        .quick-btn {
            padding: 8px 16px;
            background: #f7fafc;
            border: 2px solid #e2e8f0;
            border-radius: 8px;
            font-size: 13px;
            color: #4a5568;
            cursor: pointer;
            transition: all 0.3s;
            display: inline-flex;
            align-items: center;
            gap: 6px;
        }

        .quick-btn:hover {
            background: #667eea;
            border-color: #667eea;
            color: white;
            transform: translateY(-2px);
        }

        .form-actions {
            display: flex;
            gap: 15px;
            margin-top: 30px;
            padding-top: 30px;
            border-top: 2px solid #e2e8f0;
        }

        .btn {
            flex: 1;
            padding: 16px;
            border: none;
            border-radius: 10px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
        }

        .btn-primary {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            box-shadow: 0 4px 15px rgba(102, 126, 234, 0.4);
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(102, 126, 234, 0.5);
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

        .tips-box {
            background: #fffbeb;
            border-left: 4px solid #f59e0b;
            padding: 20px;
            border-radius: 10px;
            margin-top: 25px;
        }

        .tips-box h4 {
            color: #92400e;
            font-size: 14px;
            margin-bottom: 10px;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .tips-box ul {
            margin-left: 20px;
            color: #78350f;
            font-size: 13px;
            line-height: 1.8;
        }

        @media (max-width: 768px) {
            body {
                padding: 20px 10px;
            }

            .form-body {
                padding: 25px 20px;
            }

            .info-grid {
                grid-template-columns: 1fr;
            }

            .form-actions {
                flex-direction: column;
            }

            .quick-buttons {
                flex-direction: column;
            }

            .quick-btn {
                width: 100%;
                justify-content: center;
            }
        }

        .template-modal {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.5);
            z-index: 1000;
            align-items: center;
            justify-content: center;
        }

        .template-modal.active {
            display: flex;
        }

        .template-content {
            background: white;
            padding: 30px;
            border-radius: 15px;
            max-width: 500px;
            width: 90%;
            max-height: 80vh;
            overflow-y: auto;
        }

        .template-item {
            padding: 15px;
            border: 2px solid #e2e8f0;
            border-radius: 10px;
            margin-bottom: 10px;
            cursor: pointer;
            transition: all 0.3s;
        }

        .template-item:hover {
            border-color: #667eea;
            background: #f7fafc;
        }
    </style>
</head>
<body>
<div class="container">
    <div class="form-card">
        <!-- Header -->
        <div class="form-header">
            <span class="icon">📝</span>
            <h1>Ajouter une Note Médicale</h1>
            <p>Enregistrez les observations et recommandations de la consultation</p>
        </div>

        <!-- Form Body -->
        <div class="form-body">
            <!-- Patient & Appointment Info -->
            <div class="info-section">
                <h3>
                    <span>ℹ️</span>
                    Informations de la Consultation
                </h3>
                <div class="info-grid">
                    <div class="info-item">
                        <div class="info-icon">👤</div>
                        <div class="info-content">
                            <div class="info-label">Patient</div>
                            <div class="info-value">${patient.user.firstName} ${patient.user.lastName}</div>
                        </div>
                    </div>

                    <div class="info-item">
                        <div class="info-icon">👨‍⚕️</div>
                        <div class="info-content">
                            <div class="info-label">Médecin</div>
                            <div class="info-value">Dr. ${doctor.user.firstName} ${doctor.user.lastName}</div>
                        </div>
                    </div>

                    <div class="info-item">
                        <div class="info-icon">📅</div>
                        <div class="info-content">
                            <div class="info-label">Date du rendez-vous</div>
                            <div class="info-value">${formattedDate}</div>
                        </div>
                    </div>

                    <div class="info-item">
                        <div class="info-icon">⏰</div>
                        <div class="info-content">
                            <div class="info-label">Heure</div>
                            <div class="info-value">${formattedTime}</div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Form -->
            <form method="post" action="${pageContext.request.contextPath}/doctor/medical-note/create/${appointment.id}" id="noteForm">
                <input type="hidden" name="appointmentId" value="${appointment.id}" />

                <!-- Quick Insert Templates -->
                <div class="quick-insert">
                    <h4>📋 Modèles rapides</h4>
                    <div class="quick-buttons">
                        <button type="button" class="quick-btn" onclick="insertTemplate('diagnostic')">
                            <span>🔍</span> Diagnostic
                        </button>
                        <button type="button" class="quick-btn" onclick="insertTemplate('prescription')">
                            <span>💊</span> Prescription
                        </button>
                        <button type="button" class="quick-btn" onclick="insertTemplate('recommendation')">
                            <span>✅</span> Recommandations
                        </button>
                        <button type="button" class="quick-btn" onclick="insertTemplate('followup')">
                            <span>📆</span> Suivi
                        </button>
                    </div>
                </div>

                <!-- Note Content -->
                <div class="form-group">
                    <label for="content">
                        Note médicale
                        <span class="required">*</span>
                    </label>
                    <textarea
                            name="content"
                            id="content"
                            required
                            placeholder="Décrivez ici les observations, le diagnostic, le traitement prescrit et les recommandations..."
                            maxlength="5000"
                            oninput="updateCharCounter()"></textarea>
                    <div class="char-counter">
                        <span id="charCount">0</span> / 5000 caractères
                    </div>
                </div>

                <!-- Tips Box -->
                <div class="tips-box">
                    <h4>
                        <span>💡</span>
                        Conseils pour une note complète
                    </h4>
                    <ul>
                        <li>Notez les symptômes rapportés par le patient</li>
                        <li>Indiquez les examens effectués et leurs résultats</li>
                        <li>Précisez le diagnostic établi</li>
                        <li>Détaillez le traitement prescrit (médicaments, posologie)</li>
                        <li>Mentionnez les recommandations et le suivi nécessaire</li>
                    </ul>
                </div>

                <!-- Actions -->
                <div class="form-actions">
                    <button type="button" class="btn btn-secondary" onclick="history.back()">
                        <span>←</span>
                        Annuler
                    </button>
                    <button type="submit" class="btn btn-primary">
                        <span>💾</span>
                        Enregistrer la note
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>

<script>
    // Character counter
    function updateCharCounter() {
        const textarea = document.getElementById('content');
        const counter = document.getElementById('charCount');
        counter.textContent = textarea.value.length;
    }

    // Quick insert templates
    function insertTemplate(type) {
        const textarea = document.getElementById('content');
        let template = '';

        switch(type) {
            case 'diagnostic':
                template = '\n\n=== DIAGNOSTIC ===\nMotif de consultation: \nSymptômes: \nExamen clinique: \nDiagnostic: \n';
                break;
            case 'prescription':
                template = '\n\n=== PRESCRIPTION ===\n1. Médicament: \n   Posologie: \n   Durée: \n\n2. Médicament: \n   Posologie: \n   Durée: \n';
                break;
            case 'recommendation':
                template = '\n\n=== RECOMMANDATIONS ===\n- Repos: \n- Régime alimentaire: \n- Activité physique: \n- Précautions: \n';
                break;
            case 'followup':
                template = '\n\n=== SUIVI ===\nProchain rendez-vous: \nExamens à prévoir: \nÉvolution attendue: \n';
                break;
        }

        textarea.value += template;
        textarea.focus();
        updateCharCounter();
    }

    // Form validation
    document.getElementById('noteForm').addEventListener('submit', function(e) {
        const content = document.getElementById('content').value.trim();

        if (content.length < 20) {
            e.preventDefault();
            alert('La note médicale doit contenir au moins 20 caractères pour être complète.');
            return false;
        }

        if (!confirm('Êtes-vous sûr de vouloir enregistrer cette note médicale ?')) {
            e.preventDefault();
            return false;
        }
    });

    // Auto-save draft (localStorage)
    const textarea = document.getElementById('content');
    const appointmentId = '${appointment.id}';

    // Load draft on page load
    window.addEventListener('load', function() {
        const draft = localStorage.getItem('medicalNoteDraft_' + appointmentId);
        if (draft && textarea.value === '') {
            if (confirm('Une note brouillon a été trouvée. Voulez-vous la restaurer ?')) {
                textarea.value = draft;
                updateCharCounter();
            }
        }
    });

    // Save draft every 30 seconds
    setInterval(function() {
        if (textarea.value.trim()) {
            localStorage.setItem('medicalNoteDraft_' + appointmentId, textarea.value);
        }
    }, 30000);

    // Clear draft on successful submit
    document.getElementById('noteForm').addEventListener('submit', function() {
        localStorage.removeItem('medicalNoteDraft_' + appointmentId);
    });
</script>
</body>
</html>