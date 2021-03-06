<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" href="<c:url value='/css/bootstrap.css'/>">
    <link rel="stylesheet" href="<c:url value='/css/showmenukaart.css'/>">
    <link rel="stylesheet" href="<c:url value='/css/font-awesome.min.css'/>">
    <title></title>

</head>
<body style="background-color:transparent">
<div class="container">

    <!-- toon navigation menu -->
    <c:choose>
        <c:when test="${navbar == '1'}">
            <jsp:include page="NavBar.jsp"></jsp:include>
            <style type="text/css">
                body {
                    padding-top: 60px;
                    padding-bottom: 40px;
                }
            </style>
        </c:when>
        <c:otherwise>
        </c:otherwise>
    </c:choose>

    <div class="row">
        <table class="table">
            <col width=10%>
            <col width=80%>
            <col width=10%>
            <tr>
                <td class="success">
                    <a  href="<c:url value='/getmenucard?year=${previousYear}&month=${previousMonth}&navbar=${navbar}'/>"><i
                            class="fa fa-arrow-circle-left fa-2x"></i></a>
                </td>
                <td class="text-center success" style="font-size: large" >
                    <strong>${maandenVanHetJaar[requestScope.month - 1]} ${requestScope.year}</strong></td>
                <td class="success">
                    <a href="<c:url value='/getmenucard?year=${nextYear}&month=${nextMonth}&navbar=${navbar}'/>"><i
                            class="fa fa-arrow-circle-right fa-2x pull-right"></i></a>
                </td>
            </tr>
        </table>
    </div>
    <div class="row" style="margin-top: -15px">
        <table class="table table-bordered text-center">
            <colgroup width=25%></colgroup>
            <colgroup width=25%></colgroup>
            <colgroup width=25%></colgroup>
            <colgroup width=25%></colgroup>
            <c:forEach begin="1" end="${aantalWekeninMaand}" var="weekNr">
                <thead>
                <c:forEach begin="1" end="4" var="dagNr">
                    <c:set var="dagNaam" value="${dagenMenukaart[dagNr+(4*(weekNr-1))-1].dagNaam}"></c:set>
                    <c:set var="dagDatum" value="${dagenMenukaart[dagNr+(4*(weekNr-1))-1].dagDatum}"></c:set>
                    <th class="text-center code${dagenMenukaart[dagNr+(4*(weekNr-1))-1].dagCode}">${dagNaam} ${dagDatum}</th>
                </c:forEach>
                </thead>

                <tbody>
                <tr>
                    <c:forEach begin="1" end="4" var="dagNr">
                        <c:set var="dagMenu" value="${dagenMenukaart[dagNr+(4*(weekNr-1))-1].dagMenu}"></c:set>
                        <td class="text-center code${dagenMenukaart[dagNr+(4*(weekNr-1))-1].dagCode + 2}" style="vertical-align:middle">${dagMenu}</td>
                    </c:forEach>
                </tr>
                </tbody>
            </c:forEach>
        </table>
    </div>
</div>
<!-- einde class container -->
<script src="<c:url value='/js/jquery.min.js'/>"></script>
<script src="<c:url value='/js/bootstrap.min.js'/>"></script>
</body>
</html>