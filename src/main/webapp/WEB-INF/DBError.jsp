<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" href="<c:url value='/css/bootstrap.css'/>">
    <title>Error in Database</title>
</head>
<body>
<div class="container">

    <!-- navigatie menu tonen -->
    <jsp:include page="NavBar.jsp"></jsp:include>
    <style type="text/css">
        body {
            padding-top: 60px;
            padding-bottom: 40px;
        }
    </style>

    <div class="row-fluid" style="padding-top: 60px">
        <div class="well">
            <p>Oops, er is het volgende probleem opgedoken met de databank verbinding:</p>

            <p class="alert-danger">${DBError}</p>
        </div>
    </div>
    <script src="<c:url value='/js/jquery.min.js'/>"></script>
    <script src="<c:url value='/js/bootstrap.min.js'/>"></script>
</div>
</body>
</html>