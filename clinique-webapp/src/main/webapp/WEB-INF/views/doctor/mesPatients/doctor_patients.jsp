<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Mes patients</title>
</head>
<body>
<h2>Liste des patients suivis</h2>
<table>
    <tr>
        <th>Nom</th>
        <th>Prénom</th>
        <th>cin</th>
        <th>Adresse</th>
        <th>Email</th>
        <th>Téléphone</th>
        <th>Date de né</th>
    </tr>
    <c:forEach var="patient" items="${patients}">
        <tr>
            <td>${patient.nom}</td>
            <td>${patient.prenom}</td>
            <td>${patient.email}</td>
            <td>${patient.telephone}</td>
        </tr>
    </c:forEach>
</table>
</body>
</html>