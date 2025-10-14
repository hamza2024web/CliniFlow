<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.clinique.domain.Department" %>
<!DOCTYPE html>
<html>
<head>
    <title>Départements</title>
</head>
<body>
<h1>Départements</h1>
<a href="<%=request.getContextPath()%>/admin/departments/create">Créer un département</a>
<table border="1" cellpadding="6">
    <tr><th>ID</th><th>Nom</th><th>Code</th><th>Actions</th></tr>
    <%
        List<Department> departments = (List<Department>) request.getAttribute("departments");
        for (Department d : departments) {
    %>
    <tr>
        <td><%= d.getId() %></td>
        <td><%= d.getName() %></td>
        <td><%= d.getCode() %></td>
        <td>
            <a href="<%=request.getContextPath()%>/admin/departments/edit?id=<%= d.getId() %>">Modifier</a>
            <form action="<%=request.getContextPath()%>/admin/departments/delete" method="post" style="display:inline;">
                <input type="hidden" name="id" value="<%=d.getId()%>"/>
                <button type="submit" onclick="return confirm('Supprimer ce département ?');">Supprimer</button>
            </form>
        </td>
    </tr>
    <% } %>
</table>
</body>
</html>