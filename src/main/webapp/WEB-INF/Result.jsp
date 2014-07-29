<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Resultaat</title>
    <link rel="stylesheet" href="<c:url value='/css/bootstrap.css' />" type="text/css"/>
</head>
<body>
<div class="container">
    <div class="panel panel-default" style="margin-top: 50px">
        <div class="text-center panel-body">
            <p><%=request.getAttribute("Message1")%></p>
            <p><%=request.getAttribute("Message2")%></p>
            <p>We nemen zo snel mogelijk contact met u op.</p>
        </div>
    </div>
</div>
</body>
</html>
