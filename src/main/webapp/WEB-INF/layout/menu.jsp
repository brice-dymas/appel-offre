<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<div class="panel-group" id="accordion" role="tablist" aria-multiselectable="true">

    <!--    Partenaires-->
    <div class="panel panel-info">
        <div class="panel-heading" role="tab" id="administration">
            <h4 class="panel-title">
                <a data-toggle="collapse" data-parent="#accordion" href="#collapseAdministration" aria-expanded="true" aria-controls="collapseAdministration">
                    <spring:message code="menu.administration" />
                </a>
            </h4>
        </div>
        <div id="collapseAdministration" class="panel-collapse collapse in" role="tabpanel" aria-labelledby="administration">
            <div class="panel-body">
                <ul class="list-unstyled">
                    <li>
                        <a href="<spring:url value="/materiel/" />">
                            <spring:message code="menu.materiel" />
                        </a>
                    </li>
                    <li>
                        <a href="<spring:url value="/filiale/"/>">
                            <spring:message code="menu.filiale" />
                        </a>
                    </li>
                    <li>
                        <a href="<spring:url value="/typecaution/" />">
                            <spring:message code="menu.typeCaution" />
                        </a>
                    </li>
                    <li>
                        <a href="<spring:url value="/typemateriel/" />">
                            <spring:message code="menu.typeMateriel" />
                        </a>
                    </li>
                    <li>
                        <a href="<spring:url value="/banque/" />">
                            <spring:message code="banque.liste" />
                        </a>
                    </li>
                </ul>
            </div>
        </div>
    </div>
    <!-- Approvisionnements -->
    <div class="panel panel-info">
        <div class="panel-heading" role="tab" id="appeloffre">
            <h4 class="panel-title">
                <a class="collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseAppelOffre" aria-expanded="false" aria-controls="collapseAppelOffre">
                    <spring:message code="menu.appelOffre" />
                </a>
            </h4>
        </div>
        <div id="collapseAppelOffre" class="panel-collapse collapse" role="tabpanel" aria-labelledby="appeloffre">
            <div class="panel-body">
                <ul class="list-styled">
                    <li>
                        <a href="<spring:url value="/caution/"/>" >
                            <spring:message code="caution.liste" />
                        </a>
                    </li>
                    <li>
                        <a href="<spring:url value="/appeloffre/"/>" >
                            <spring:message code="menu.appelOffre.liste" />
                        </a>
                    </li>

                    <sec:authorize access="hasRole('ROLE_ADMIN')" >
                        <li>
                            <a href="<spring:url value="/user/"/>" >
                                <spring:message code="user.title" />
                            </a>
                        </li>
                    </sec:authorize>

                </ul>

            </div>
        </div>
    </div>
    <!-- Vente  -->
    <div class="panel panel-info">
        <div class="panel-heading" role="tab" id="rapport">
            <h4 class="panel-title">
                <a class="collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseRapport" aria-expanded="false" aria-controls="collapseRapport">
                    <spring:message code="menu.rapport" />
                </a>
            </h4>
        </div>
        <div id="collapseRapport" class="panel-collapse collapse" role="tabpanel" aria-labelledby="rapport">
            <div class="panel-body">
                <spring:message code="menu.rapport" />
            </div>
        </div>
    </div>

</div>