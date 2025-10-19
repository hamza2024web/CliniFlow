<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Mes notes médicales</title>
</head>
<body>
<h2>Mon dossier médical</h2>
<c:if test="${not empty notes}">
    <table>
        <tr>
            <th>Date</th>
            <th>Médecin</th>
            <th>Note médicale</th>
        </tr>
        <c:forEach var="note" items="${notes}">
            <tr>
                <td>
                        ${note.createdAt}
                </td>
                <td>
                    Dr. ${note.doctor.user.lastName} ${note.doctor.user.firstName}
                </td>
                <td>
                        ${note.content}
                </td>
            </tr>
        </c:forEach>
    </table>
</c:if>
<c:if test="${empty notes}">
    <p>Aucune note médicale pour l’instant.</p>
</c:if>
</body>
</html>