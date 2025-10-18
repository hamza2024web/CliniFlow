<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Sélection de la spécialité</title>
</head>
<body>
<h2>Choisissez une spécialité</h2>
<form method="post" action="${pageContext.request.contextPath}/select-specialty">
    <select name="specialtyId" required>
        <c:forEach var="specialty" items="${specialties}">
            <option value="${specialty.id}">${specialty.nom}</option>
        </c:forEach>
    </select>
    <button type="submit">Suivant</button>
</form>
</body>
</html>