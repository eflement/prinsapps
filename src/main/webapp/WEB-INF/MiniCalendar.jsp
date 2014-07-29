<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" href="<c:url value='/css/bootstrap.css'/>">
    <link rel="stylesheet" href="<c:url value='/css/font-awesome.css'/>">
    <link rel="stylesheet" href="<c:url value='/css/minicalendar.css'/>">
    <title></title>
    <!-- HTML5 shim, for IE6-8 support of HTML5 elements -->
    <!--[if lt IE 9]>
    <script src="<c:url value='/js/respond.min.js'/>"></script>
    <![endif]-->

</head>
<body style="background-color:transparent">
<div class="container">
    <%--<h4 class="text-center">${maandenVanHetJaar[requestScope.month - 1]} ${year}</h4>--%>
    <div class="row">
        <table style="font-size: 14px" width=170>
            <col width=10>
            <col width=150>
            <col width=10>
            <tr>
                <td>
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
                            class="icon-circle-arrow-left"></i></a>
                </td>
                <td class="text-center" style="color: #493433">
                    <strong>${maandenVanHetJaar[sessionScope.month - 1]} ${sessionScope.year}</strong></td>
                <td>
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
                            class="icon-circle-arrow-right"></i></a>
                </td>
            </tr>
        </table>
    </div>
    <div class="row">
        <table class=" table-bordered text-center" width=170>
            <colgroup width=24></colgroup>
            <colgroup width=24></colgroup>
            <colgroup width=24></colgroup>
            <colgroup width=24></colgroup>
            <colgroup width=24></colgroup>
            <colgroup width=24></colgroup>
            <thead>
            <tr>
                <th class="text-center" style="font-size: 10px">Ma</th>
                <th class="text-center" style="font-size: 10px">Di</th>
                <th class="text-center" style="font-size: 10px">Wo</th>
                <th class="text-center" style="font-size: 10px">Do</th>
                <th class="text-center" style="font-size: 10px">Vr</th>
                <th class="text-center" style="font-size: 10px; background: #d3d3d3">Za</th>
                <th class="text-center" style="font-size: 10px;background: #d3d3d3">Zo</th>
            </tr>
            </thead>
            <tbody>
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
            </tbody>
        </table>
    </div>
</div>
<!-- einde class container -->
<script src="<c:url value='/js/jquery.js'/>"></script>
<script src="<c:url value='/js/bootstrap.js'/>"></script>
</body>
</html>