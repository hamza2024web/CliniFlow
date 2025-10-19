<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Mes rendez-vous</title>
</head>
<body>
<h2>Mes rendez-vous</h2>
<table>
    <tr>
        <th>Médecin</th>
        <th>Date</th>
        <th>Heure</th>
        <th>Type</th>
        <th>Statut</th>
        <th>Action</th>
    </tr>
    <c:forEach var="appointment" items="${appointments}">
        <tr>
            <td>Dr. ${appointment.doctor.nom} ${appointment.doctor.prenom}</td>
            <td>${appointment.date}</td>
            <td>${appointment.startTime}</td>
            <td>${appointment.type}</td>
            <td>${appointment.status}</td>
            <td>
                <c:if test="${appointment.status eq 'A_VENIR'}">
                    <form method="post" action="${pageContext.request.contextPath}/patient/annuler-rdv">
                        <input type="hidden" name="appointmentId" value="${appointment.id}" />
                        <button type="submit">Annuler</button>
                    </form>
                </c:if>
            </td>
        </tr>
    </c:forEach>
</table>
</body>
</html>