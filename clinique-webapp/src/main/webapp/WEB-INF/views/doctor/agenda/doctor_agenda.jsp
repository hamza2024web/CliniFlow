<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Mon agenda</title>
</head>
<body>
<h2>Agenda des rendez-vous</h2>
<table>
    <tr>
        <th>Patient</th>
        <th>Date</th>
        <th>Heure</th>
        <th>Type</th>
        <th>Statut</th>
    </tr>
    <c:forEach var="appointment" items="${appointments}">
        <tr>
            <td>${appointment.patient.nom} ${appointment.patient.prenom}</td>
            <td>${appointment.date}</td>
            <td>${appointment.startDatetime}</td>
            <td>${appointment.type}</td>
            <td>${appointment.status}</td>
        </tr>
    </c:forEach>
</table>
</body>
</html>