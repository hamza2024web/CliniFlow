<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Choix du créneau horaire</title>
</head>
<body>
<h2>Choisissez un créneau disponible</h2>
<form method="post" action="${pageContext.request.contextPath}/select-slot">
    <input type="hidden" name="doctorId" value="${doctorId}" />
    <input type="hidden" name="specialtyId" value="${specialtyId}" />
    <input type="hidden" name="date" value="${date}" />
    <input type="hidden" name="appointmentType" value="${appointmentType}" />
    <table border="1">
        <tr>
            <th>Début</th>
            <th>Fin</th>
            <th>Disponible</th>
            <th>Sélectionner</th>
        </tr>
        <c:forEach var="slot" items="${slots}">
            <tr>
                <td>${slot.start}</td>
                <td>${slot.end}</td>
                <td>
                    <c:choose>
                        <c:when test="${slot.available}">Oui</c:when>
                        <c:otherwise>Non</c:otherwise>
                    </c:choose>
                </td>
                <td>
                    <c:if test="${slot.available}">
                        <input type="radio" name="slotStart" value="${slot.start}" required />
                    </c:if>
                </td>
            </tr>
        </c:forEach>
    </table>
    <button type="submit">Réserver</button>
</form>
</body>
</html>