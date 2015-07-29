<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<spring:url value="/materiel/" htmlEscape="true" var="materiel_home" />
<spring:url value="/appeloffre/" htmlEscape="true" var="fonction_home" />
<spring:url value="/" htmlEscape="true" var="home" />

<nav class="row">
    <div style="float: right; padding: 0 15px">
        <div class="dropdown" style="display: inline-block !important">
            <button class="btn btn-default dropdown-toogle" id="dropdown-user" data-toggle="dropdown">
                <i class="glyphicon glyphicon-user"></i>
                <c:if test="${pageContext.request.userPrincipal.name != null}">
                    <spring:message code="menu.bienvenu" />

                    ${pageContext.request.userPrincipal.name}
                </c:if>
                <c:if test="${pageContext.request.userPrincipal.name == null}">
                    Bonjour Visiteur!
                </c:if>

                <i class="caret"></i>
            </button>
            <ul class="dropdown-menu" role="menu" aria-labeledby="dropdown-user">
                <li>
                    <a href="<c:url value="/welcome" />">
                        <span class="glyphicon glyphicon-user ">
                            <spring:message code="menu.profil" />
                        </span>
                    </a>
                </li>
                <li>
                    <a href="<c:url value="/" />">
                        <span class="glyphicon glyphicon-dashboard">
                            <spring:message code="menu.tableauDeBord" />
                        </span>
                    </a>
                </li>
                <li class="divider"></li>
                <li>
                    <a href="<c:url value="/logout" />" >
                        <span class="glyphicon glyphicon-log-out">
                            <spring:message code="menu.deconnecter" />
                        </span>
                    </a>
                </li>
            </ul>
        </div>
        <div class="dropdown" style="display: inline-block !important">
            <button class="btn btn-default dropdown-toogle" id="dropdown-language" data-toggle="dropdown">
                <c:if test="${pageContext.response.locale == 'fr' or pageContext.response.locale == 'fr_FR'}">
                    <img alt="<spring:message code="language.user"/> "  src="<c:url value="/resources/flags/16/France.png"/>"/>
                </c:if>
                <c:if test="${pageContext.response.locale == 'en' or pageContext.response.locale == 'en_US' }">
                    <img alt="<spring:message code="language.user"/> " src="<c:url value="/resources/flags/16/England.png"/>"/>
                </c:if>
                <spring:message code="language.title"/>
                <i class="caret"></i>
            </button>
            <ul class="dropdown-menu" role="menu" aria-labeledby="dropdown-language">
                <c:if test="${pageContext.response.locale == 'fr' or pageContext.response.locale == 'fr_FR'}">
                    <li>
                        <a href="?language=en">

                            <img alt="<spring:message code="language.user"/> " src="<c:url value="/resources/flags/16/England.png"/>"/>
                            <spring:message code="language.user"/>
                        </a>
                    </li>
                </c:if>
                <c:if test="${pageContext.response.locale == 'en' or pageContext.response.locale == 'en_US' }">                          <li>
                    <li>
                        <a href="?language=fr">
                            <img alt="<spring:message code="language.user"/> "  src="<c:url value="/resources/flags/16/France.png"/>"/>
                            <spring:message code="language.user"/>
                        </a>
                    </li>
                </c:if>
        </div>
    </div>
    <div style="overflow: hidden; padding: 0 15px">
        <ol class="breadcrumb">
            <c:forEach items="${breadcrumbs}" var="breadcrumb">
                <li>
                    <c:choose>
                        <c:when test="${empty breadcrumb.value}">
                            <span>
                                <spring:message code="${breadcrumb.key}" />
                            </span>
                        </c:when>
                        <c:otherwise>
                            <a href="${breadcrumb.value}">
                                <spring:message code="${breadcrumb.key}" />
                            </a>
                        </c:otherwise>
                    </c:choose>
                </li>
            </c:forEach>
        </ol>
    </div>
</nav>