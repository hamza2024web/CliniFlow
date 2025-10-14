<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.clinique.domain.Department" %>
<!DOCTYPE html>
<html>
<head><title>Modifier Département</title></head>
<body>
<h1>Modifier Département</h1>
<% String error = (String)request.getAttribute("error"); if(error!=null){ %>
<div style="color:red;"><%=error%></div>
<% } %>
<% Department d = (Department)request.getAttribute("department"); %>
<form method="post">
    <input type="hidden" name="id" value="<%=d.getId()%>"/>
    <label>Nom: <input type="text" name="name" value="<%=d.getName()%>" required/></label><br/>
    <label>Code: <input type="text" name="code" value="<%=d.getCode()%>" required/></label><br/>
    <button type="submit">Enregistrer</button>
</form>
<a href="<%=request.getContextPath()%>/admin/departments">Annuler</a>
</body>
</html>