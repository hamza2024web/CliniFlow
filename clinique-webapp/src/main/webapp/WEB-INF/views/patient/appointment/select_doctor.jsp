<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Sélection du médecin</title>
</head>
<body>
<h2>Choisissez un médecin pour la spécialité : ${specialty.nom}</h2>
<form method="post" action="${pageContext.request.contextPath}/select-doctor">
    <input type="hidden" name="specialtyId" value="${specialtyId}" />
    <select name="doctorId" required>
        <c:forEach var="doctor" items="${doctors}">
            <option value="${doctor.id}">
                Dr. ${doctor.nom} ${doctor.prenom}
            </option>
        </c:forEach>
    </select>
    <button type="submit">Suivant</button>
</form>
</body>
</html>
