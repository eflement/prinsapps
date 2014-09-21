<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.fckeditor.net" prefix="FCK" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" href="<c:url value='/css/styles.css'/>">
    <link rel="stylesheet" href="<c:url value='/css/showmenukaart.css'/>">
    <link rel="stylesheet" href="<c:url value='/css/font-awesome.min.css'/>">
    <title></title>

</head>
<body style="background-color:transparent">
<div class="container">

    <!-- navigatie menu tonen -->
    <jsp:include page="NavBar.jsp"></jsp:include>
    <style type="text/css">
        body {
            padding-top: 60px;
            padding-bottom: 40px;
        }
    </style>

    <div class="row">
        <table class="table" style="font-size: 14px">
            <col width=10%>
            <col width=80%>
            <col width=10%>
            <tr>
                <td>
                    <a style="font-size:13px"
                       href="<c:url value='/getmenucard?year=${previousYear}&month=${previousMonth}&action=${action}'/>"><i
                            class="icon-circle-arrow-left icon-large"></i></a>
                </td>
                <td class="text-center" style="color: #493433">
                    <strong>${maandenVanHetJaar[requestScope.month - 1]} ${requestScope.year}</strong></td>
                <td>
                    <a style="font-size:13px"
                       href="<c:url value='/getmenucard?year=${nextYear}&month=${nextMonth}&action=${action}'/>"><i
                            class="icon-circle-arrow-right icon-large pull-right"></i></a>
                </td>
            </tr>
        </table>
    </div>
    <div class="row">
        <form action="<c:url value='/updatemenucard'/>" method="post">
            <table class="table table-bordered text-center" style="margin-top: -15px">
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
                            <c:set var="dagDatum" value="${dagenMenukaart[dagNr+(4*(weekNr-1))-1].dagDatum}"></c:set>
                            <c:set var="dagMenu" value="${dagenMenukaart[dagNr+(4*(weekNr-1))-1].dagMenu}"></c:set>
                            <c:set var="dag" value="${fn:substring(dagDatum, 0, 2)}" />
                            <c:set var="maand" value="${fn:substring(dagDatum, 3, 5)}" />
                            <c:set var="jaar" value="${fn:substring(dagDatum, 6, 10)}" />
                            <td class="text-center code${dagenMenukaart[dagNr+(4*(weekNr-1))-1].dagCode + 2}">
                                <FCK:editor>
                                    <jsp:attribute name="instanceName">i${dag}${maand}${jaar}</jsp:attribute>
                                    <jsp:attribute name="height">90</jsp:attribute>
                                    <jsp:attribute name="value">${dagMenu}</jsp:attribute>
                                </FCK:editor>
                            </td>
                        </c:forEach>
                    </tr>
                    </tbody>
                </c:forEach>
                <!-- aantal weken -->
            </table>
            <input type="hidden" name="year" value="${year}">
            <input type="hidden" name="month" value="${month}">
            <button type="submit" class="btn btn-info">Pas aan</button>
        </form>
    </div>
</div>
<!-- einde class container -->
<script src="<c:url value='/js/jquery.min.js'/>"></script>
<script src="<c:url value='/js/bootstrap.min.js'/>"></script>

</body>
</html>