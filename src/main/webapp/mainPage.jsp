<%--
    Document   : mainPage
    Created on : 4 juil. 2015, 11:55:10
    Author     : sando
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>
            <spring:message code="application.name"/>
        </title>

        <!-- Bootstrap -->
        <link href="<c:url value="/resources/css/bootstrap.min.css" />" rel="stylesheet">
        <link href="<c:url value="/resources/css/app.css" />" rel="stylesheet">
        <link href="<c:url value="/resources/css/jquery-ui.css" />" rel="stylesheet">
        <link href="<c:url value="/resources/css/jquery-ui.structure.css" />" rel="stylesheet">
        <link href="<c:url value="/resources/css/jquery-ui.theme.css" />" rel="stylesheet">
        <link href="<c:url value="/resources/css/jquery.jqplot.css" />" rel="stylesheet">

        <script src="<c:url value="/resources/js/jquery.min.js" />"></script>
        <script src="<c:url value="/resources/js/bootstrap.min.js" />"/>"></script>

</head>
<body>
    <%-- Liste des URLs à utiliser ici--%>
    <spring:url value="/appeloffre/" var="appeloffre_liste" htmlEscape="true" />
    <spring:url value="/banque/" var="banque_liste" htmlEscape="true" />
    <spring:url value="/materiel/" var="materiel_liste" htmlEscape="true" />
    <spring:url value="/filiale/" var="filiale_liste" htmlEscape="true" />
    <spring:url value="/caution/" var="caution_liste" htmlEscape="true" />
    <spring:url value="/typecaution/" var="typecaution_liste" htmlEscape="true" />
    <spring:url value="/typemateriel/" var="typemateriel_liste" htmlEscape="true" />
    <spring:url value="/user/" var="user_liste" htmlEscape="true" />
    <%-- Fin de la Liste des URLs à utiliser ici--%>

    <hr/>
    <div  align="center"  >
        <img alt="cami.png" height="92" width="400" src="<c:url value="/resources/img/cami.png"/>"/>
    </div>
    <hr/>
    <div id="myCarousel" class="carousel slide" data-ride="carousel">
        <!-- Carousel indicators -->
        <ol class="carousel-indicators">
            <li  data-target="#myCarousel" data-slide-to="0" class="active"></li>
            <li data-target="#myCarousel" data-slide-to="1"></li>
            <li data-target="#myCarousel" data-slide-to="2"></li>
            <li data-target="#myCarousel" data-slide-to="3"></li>
            <li data-target="#myCarousel" data-slide-to="4"></li>
            <li data-target="#myCarousel" data-slide-to="5"></li>
        </ol>

        <!-- Wrapper for carousel items -->
        <div class="carousel-inner ">
            <div class="item active">
                <div class="carousel-caption">
                    <img alt="Toyota Coaster" src="<c:url value="/resources/img/coaster.jpg"/>" height="242" width="570" />
                </div>
            </div>
            <div class="item">
                <div class="carousel-caption">
                    <img alt="Toyota Hiace" src="<c:url value="/resources/img/hiace.jpg"/>"  height="242" width="570"/>
                </div>
            </div>
            <div class="item">
                <div class="carousel-caption">
                    <img alt="Techniciens" src="<c:url value="/resources/img/technicien.jpg"/>"  height="242" width="570" />
                </div>
            </div>
            <div class="item">
                <div class="carousel-caption">
                    <img alt="Toyota" src="<c:url value="/resources/img/toyota.jpg"/>"  height="242" width="570"/>
                </div>
            </div>
            <div class="item">
                <div class="carousel-caption">
                    <img alt="Toyota Camry" src="<c:url value="/resources/img/camry.jpg"/>"  height="242" width="570"/>
                </div>
            </div>
            <div class="item">
                <div class="carousel-caption">
                    <img alt="Trucks Vehicles" src="<c:url value="/resources/img/camion.jpg"/>" height="242" width="470"/>
                </div>
            </div>
        </div>

        <!--</div>-->
        <!-- Carousel controls -->
        <a class="carousel-control left" href="#myCarousel" data-slide="prev">
            <span class="glyphicon glyphicon-chevron-left"></span>
        </a>
        <a class="carousel-control right" href="#myCarousel" data-slide="next">
            <span class="glyphicon glyphicon-chevron-right"></span>
        </a>
    </div>

    <br/>
    <div class="container">
        <div class="row">
            <div class="col-md-4">
                <h3>
                    <spring:message code="appelOffre.title" />
                </h3>
                <p>
                    <spring:message code="appelOffre.intro" />
                </p>
                <p>
                    <a class="btn btn-primary  btn-sm" href="${appeloffre_liste}" role="button">
                        <span class="glyphicon glyphicon-list">
                            <spring:message code="action.detail" />
                        </span>
                        &raquo;
                    </a>
                </p>

            </div>
            <div class="col-md-4">
                <h3>
                    <b><spring:message code="filiale.title" /></b>
                </h3>
                <p>
                    <i><spring:message code="filiale.intro" /></i>
                </p>
                <p>
                    <a class="btn btn-primary  btn-sm" href="${filiale_liste}" role="button">
                        <span class="glyphicon glyphicon-list">
                            <spring:message code="action.detail" />
                        </span>
                        &raquo;
                    </a>
                </p>
            </div>

            <div class="col-md-4">
                <h3>
                    <spring:message code="materiel.title" />
                </h3>
                <p>
                    <spring:message code="materiel.intro" />
                </p>
                <p>
                    <a class="btn btn-primary  btn-sm" href="${materiel_liste}" role="button">
                        <span class="glyphicon glyphicon-list">
                            <spring:message code="action.detail" />
                        </span>
                        &raquo;
                    </a>
                </p>
            </div>
        </div>
        <div class="row">
            <div class="col-md-4">
                <h3>
                    <spring:message code="typecaution.title" />
                </h3>
                <p>
                    <spring:message code="typeCaution.intro" />
                </p>
                <p>
                    <a class="btn btn-primary  btn-sm" href="${typecaution_liste}" role="button">
                        <span class="glyphicon glyphicon-list">
                            <spring:message code="action.detail" />
                        </span>
                        &raquo;
                    </a>
                </p>
            </div>
            <div class="col-md-4">
                <h3>
                    <spring:message code="typemateriel.title" />
                </h3>
                <p>
                    <spring:message code="typeMateriel.intro" />
                </p>
                <p>
                    <a class="btn btn-primary  btn-sm" href="${typemateriel_liste}" role="button">
                        <span class="glyphicon glyphicon-list">
                            <spring:message code="action.detail" />
                        </span>
                        &raquo;
                    </a>
                </p>
            </div>
            <div class="col-md-4">
                <h3>
                    <spring:message code="caution.title" />
                </h3>
                <p>
                    <spring:message code="caution.intro" />
                </p>
                <p>
                    <a class="btn btn-primary  btn-sm" href="${caution_liste}" role="button">
                        <span class="glyphicon glyphicon-list">
                            <spring:message code="action.detail" />
                        </span>
                        &raquo;
                    </a>
                </p>
            </div>

        </div>
        <div class="row">
            <div class="col-md-4">
                <h3>
                    <spring:message code="banque.title" />
                </h3>
                <p>
                    <spring:message code="banque.intro" />
                </p>
                <p>
                    <a class="btn btn-primary  btn-sm" href="${banque_liste}" role="button">
                        <span class="glyphicon glyphicon-list">
                            <spring:message code="action.detail" />
                        </span>
                        &raquo;
                    </a>
                </p>
            </div>
            <div class="col-md-4">
                <h3>
                    <spring:message code="user.title" />
                </h3>
                <p>
                    <spring:message code="user.intro" />
                </p>
                <p>
                    <a class="btn btn-primary  btn-sm" href="${user_liste}" role="button">
                        <span class="glyphicon glyphicon-list">
                            <spring:message code="action.detail" />
                        </span>
                        &raquo;
                    </a>
                </p>
            </div>

        </div>
    </div>

</body>
</html>
