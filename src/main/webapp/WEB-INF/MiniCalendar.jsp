<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" href="<c:url value='/css/styles.css'/>">
    <link rel="stylesheet" href="<c:url value='/css/minicalendar.css'/>">
    <link rel="stylesheet" href="<c:url value='/css/font-awesome.min.css'/>">
    <title></title>
</head>
<body>
<div class="container">
    <div class="row">
        <table class="text-center table-bordered">
            <colgroup width=36></colgroup>
            <colgroup width=36></colgroup>
            <colgroup width=36></colgroup>
            <colgroup width=36></colgroup>
            <colgroup width=36></colgroup>
            <colgroup width=36></colgroup>
            <colgroup width=36></colgroup>
            <%--<!-- start navigatie over de maanden -->--%>
            <thead>
            <tr>
                <th class="text-center">
                    <c:choose>
                        <c:when test="${sessionScope.month == '1'}">
                            <c:set var="prevMonth" value="${12}" scope="session"/>
                            <c:set var="prevYear" value="${sessionScope.year-1}" scope="session"/>
                        </c:when>
                        <c:otherwise>
                            <c:set var="prevMonth" value="${sessionScope.month - 1}" scope="session"/>
                            <c:set var="prevYear" value="${sessionScope.year + 0}" scope="session"/>
                        </c:otherwise>
                    </c:choose>
                    <a href="<c:url value='/minicalendar?action=previous'/>"><i
                            class="fa fa-arrow-circle-left fa-lg"></i></a>
                </th>
                <th class="text-center" colspan="5">
                    <strong>${maandenVanHetJaar[sessionScope.month - 1]} ${sessionScope.year}</strong></th>
                <th class="text-center">
                    <c:choose>
                        <c:when test="${sessionScope.month == '12'}">
                            <c:set var="nextMonth" value="${1}" scope="session"/>
                            <c:set var="nextYear" value="${sessionScope.year+1}" scope="session"/>
                        </c:when>
                        <c:otherwise>
                            <c:set var="nextMonth" value="${sessionScope.month + 1}" scope="session"/>
                            <c:set var="nextYear" value="${sessionScope.year + 0}" scope="session"/>
                        </c:otherwise>
                    </c:choose>
                    <a href="<c:url value='/minicalendar?action=next'/>"><i
                            class="fa fa-arrow-circle-right fa-lg"></i></a>
                </th>
            </tr>
            </thead>
            <tbody>
            <!-- einde navigatie over de maanden -->
            <!-- start weekdagen -->
            <tr>
                <th class="text-center" style ="background: #62c462;">Ma</th>
                <th class="text-center" style ="background: #62c462;">Di</th>
                <th class="text-center" style ="background: #62c462;">Wo</th>
                <th class="text-center" style ="background: #62c462;">Do</th>
                <th class="text-center" style ="background: #62c462;">Vr</th>
                <th class="text-center" style ="background: #ee5f5b;">Za</th>
                <th class="text-center" style ="background: #ee5f5b;">Zo</th>
            </tr>
            <!-- einde weekdagen  -->
            <!-- start feitelijke kalender -->

            <c:forEach begin="1" end="${aantalWekeninMaand}" var="weekNr">
                <tr>
                    <c:forEach begin="1" end="7" var="dagNr">
                        <td
                                <c:set var="dagnummer"
                                       value="${dagenVanMaandMiniKalender[dagNr+(7*(weekNr-1))-1].dagNummer}">
                                </c:set>
                                <c:set var="dagcode"
                                       value="${dagenVanMaandMiniKalender[dagNr+(7*(weekNr-1))-1].dagCode}">
                                </c:set>
                                <c:set var="dagbeschrijving"
                                       value="${dagenVanMaandMiniKalender[dagNr+(7*(weekNr-1))-1].dagBeschrijving}">
                                </c:set>
                                <c:choose>
                                    <c:when test="${dagcode == '1'}">
                                        class="code1"
                                    </c:when>
                                    <c:when test="${dagcode == '2'}">
                                        class="code2"
                                    </c:when>
                                    <c:when test="${dagcode == '3'}">
                                        class="code3"
                                    </c:when>
                                    <c:when test="${dagcode == '4'}">
                                        class="code4"
                                    </c:when>
                                    <c:when test="${dagcode == '5'}">
                                        class="code5"
                                    </c:when>
                                </c:choose>
                                >
                            <c:choose>
                                <c:when test="${dagcode == '3' || dagcode == '5'}">
                                    <a href="<c:url value='/preparewrapurl?year=${year}&month=${month}&day=${dagnummer}'/>"
                                       base target="_parent" data-toggle="tooltip"
                                       title="<c:out value='${dagbeschrijving}'/>">
                                            ${dagnummer}
                                    </a>
                                </c:when>
                                <c:otherwise>
                                    ${dagnummer}
                                </c:otherwise>
                            </c:choose>
                        </td>
                    </c:forEach>
                </tr>
            </c:forEach>

            <%-- einde feitelijke kalenderdagen--%>
            </tbody>
        </table>
        <p>&nbsp;</p>
        <p style="font-size: larger" class="text-center"><a href="http://new.vb-dekleineprins.be/node/88" target="_parent">
            <i class="fa fa-calendar"></i> Belangrijke data</a></p>
    </div>
</div>
<!-- einde class container -->
<script src="<c:url value='/js/jquery.min.js'/>"></script>
<script src="<c:url value='/js/bootstrap.min.js'/>"></script>
</body>
</html>