<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.clinique.domain.Availability" %>
<!DOCTYPE html>
<html>
<head>
    <title>Mes Disponibilités</title>
</head>
<body>
<h1>Mes Disponibilités</h1>

<a href="<%=request.getContextPath()%>/doctor/availabilities/create">Ajouter un créneau</a>
<table border="1" cellpadding="6">
    <tr>
        <th>Jour</th>
        <th>Heure début</th>
        <th>Heure fin</th>
        <th>Statut</th>
        <th>Actions</th>
    </tr>
    <%
        List<Availability> availabilities = (List<Availability>) request.getAttribute("availabilities");
        for (Availability a : availabilities) {
    %>
    <tr>
        <td><%= a.getDayOfWeek() %></td>
        <td><%= a.getStartTime() %></td>
        <td><%= a.getEndTime() %></td>
        <td><%= a.isActive() ? "Actif" : "Inactif" %></td>
        <td>
            <a href="<%=request.getContextPath()%>/doctor/availabilities/edit?id=<%=a.getId()%>">Modifier</a>
            <form action="<%=request.getContextPath()%>/doctor/availabilities/delete" method="post" style="display:inline;">
                <input type="hidden" name="id" value="<%=a.getId()%>"/>
                <button type="submit" onclick="return confirm('Supprimer ce créneau ?');">Supprimer</button>
            </form>
        </td>
    </tr>
    <% } %>
</table>
</body>
</html>