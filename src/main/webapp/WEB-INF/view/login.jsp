<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html lang="en-IN">
    <head>
        <meta charset="utf-8">
        <title></title>
        <!-- Bootstrap -->
        <link href="<c:url value="/resources/css/bootstrap.min.css" />" rel="stylesheet">
        <link href="<c:url value="/resources/css/font-awesome.min" />" rel="stylesheet">
        <link href="<c:url value="/resources/css/app.css" />" rel="stylesheet">
        <link href='http://fonts.googleapis.com/css?family=Ropa+Sans' rel='stylesheet'>
        <style>
        </style>
    </head>
    <body>
        <hr>
        <div  align="center"  >
            <img alt="cami.png" height="92" width="400" src="<c:url value="/resources/img/cami.png"/>"/>
        </div>
        <div id="login-form">

            <input type="radio" checked id="login" name="switch" class="hide">
            <input type="radio" id="signup" name="switch" class="hide">

            <div>
                <c:if test="${not empty error}">
                    <div class="text-info label-info">
                        ${error}
                    </div>
                </c:if>
                <c:if test="${not empty msg}">
                    <div class="text label-danger">${msg}</div>
                </c:if>
                <ul class="form-header">
                    <li><label for="login"><i class="fa-align-center"></i> Page de Connexion<label for="login"></li>
                                </ul>
                                </div>

                                <div class="section-out">
                                    <section class="login-section">
                                        <div class="login">
                                            <!--class="form col-md-12 center-block"-->
                                            <form name='loginForm'
                                                  action="<c:url value='/login' />" method='POST' >
                                                <ul class="ul-list">
                                                    <li><input type="text" required class="inputL form-control" placeholder="Votre nom d'utilisateur" id="username" name='username' /><span class="icon"><i class="fa fa-user"></i></span></li>
                                                    <li><input type="password" id="password"  name='password' required class="inputL form-control" placeholder="Votre Mot de passe"/><span class="icon"><i class="fa fa-lock"></i></span></li>
                                                    <li><b><input type="submit"  value="Se Connecter" class="btnL"></b></li>
                                                    <li><b><a href="<c:url value='/'/>" class="btnL text-center" > Annuler</a></b></li>
                                                </ul>
                                                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                                            </form>
                                        </div>

                                    </section>


                                </div>

                                </div>

                                </body>
                                </html>