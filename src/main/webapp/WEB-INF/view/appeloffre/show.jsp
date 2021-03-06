<%--
    Document   : show
    Created on : Dec 10, 2014, 9:48:58 AM
    Author     : sando
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<tiles:insertDefinition name="layout">
    <tiles:putAttribute name="body">
        <div class="row">
            <div class="col-md-12">
                <h4>
                    <spring:message code="appelOffre.afficher" />
                </h4>
                <hr/>
            </div>
        </div>
        <div class="row">
            <div class="col-xs-offset-1" id="table_show">
                <!--<div class="col-md-6 col-md-offset-3" id="table_show">-->
                <table class="table table-bordered">
                    <tbody>
                        <tr>
                            <th ><spring:message code="appelOffre.numero" /></th>
                            <td>${appelOffre.numero}</td>
                            <th><spring:message code="appelOffre.intitule" /></th>
                            <td>${appelOffre.intitule}</td>
                            <th><spring:message code="appelOffre.filiale" /></th>
                            <td>${appelOffre.filiale.nom}</td>

                        </tr>

                        <tr>
                            <th><spring:message code="appelOffre.maitreDouvrage" /></th>
                            <td>${appelOffre.maitreDouvrage}</td>
                            <th><spring:message code="appelOffre.datedepot" /></th>
                            <td>${appelOffre.getTrueDate(appelOffre.dateDepot)}</td>
                            <th><spring:message code="appelOffre.delai" /></th>
                            <td>${appelOffre.delaiDeValidite}</td>
                        </tr>

                    </tbody>
                </table>

            </div>
        </div>

        <div class="row">
            <div class="col-md-12">
                <fieldset>
                    <legend><spring:message code="appelOffre.listeAttachedFiles" /></legend>
                    <table class="table table-bordered">
                        <tr>
                            <th>
                                <spring:message code="appelOffre.attachedFile" />
                            </th>
                            <td>
                                <a href="<c:url value="/resources/documents/${appelOffre.pieceJointe1}"/>">
                                    <spring:message code="action.download" />
                                </a>
                            </td>
                            <th>
                                <spring:message code="appelOffre.attachedFile" />
                            </th>
                            <td>
                                <a href="<c:url value="/resources/documents/${appelOffre.pieceJointe2}"/>">
                                    <spring:message code="action.download" />
                                </a>
                            </td>
                        </tr>
                        <tr>
                            <th>
                                <spring:message code="appelOffre.attachedFile" />
                            </th>
                            <td>
                                <a href="<c:url value="/resources/documents/${appelOffre.pieceJointe3}"/>">
                                    <spring:message code="action.download" />
                                </a>
                            </td>
                            <th>
                                <spring:message code="appelOffre.attachedFile" />
                            </th>
                            <td>
                                <a href="<c:url value="/resources/documents/${appelOffre.pieceJointe4}"/>">
                                    <spring:message code="action.download" />
                                </a>
                            </td>
                        </tr>
                        <tr>
                            <th>
                                <spring:message code="appelOffre.attachedFile" />
                            </th>
                            <td>
                                <a href="<c:url value="/resources/documents/${appelOffre.pieceJointe5}"/>">
                                    <spring:message code="action.download" />
                                </a>
                            </td>
                            <th>
                                <spring:message code="appelOffre.attachedFile" />
                            </th>
                            <td>
                                <a href="<c:url value="/resources/documents/${appelOffre.pieceJointe6}"/>">
                                    <spring:message code="action.download" />
                                </a>
                            </td>
                        </tr>
                        <tr>
                            <th>
                                <spring:message code="appelOffre.attachedFile" />
                            </th>
                            <td>
                                <a href="<c:url value="/resources/documents/${appelOffre.pieceJointe7}"/>">
                                    <spring:message code="action.download" />
                                </a>
                            </td>
                            <th>
                                <spring:message code="appelOffre.attachedFile" />
                            </th>
                            <td>
                                <a href="<c:url value="/resources/documents/${appelOffre.pieceJointe8}"/>">
                                    <spring:message code="action.download" />
                                </a>
                            </td>
                        </tr>
                    </table>
                </fieldset>
            </div>
        </div>
        <div class="row">
            <div class="col-md-12">
                <fieldset>
                    <legend><spring:message code="appelOffre.listeMateriel" /></legend>
                    <table class="table table-bordered">
                        <thead>
                            <tr class="danger">
                                <th><spring:message code="ligneMateriel.materiel" /></th>
                                <th><spring:message code="ligneMateriel.prixUnitaire" /></th>
                                <th><spring:message code="ligneMateriel.quantite" /></th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="ligneAppel" items="${ligneAppels}">
                                <tr>
                                    <td>${ligneAppel.materiel.nom}</td>
                                    <td>${ligneAppel.prixUnitaire} </td>
                                    <td>${ligneAppel.quantite} </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </fieldset>
            </div>
        </div>
        <div class="row">
            <div class="col-md-12">
                <fieldset>
                    <legend><spring:message code="appelOffre.cautions" /></legend>
                    <table class="table table-bordered">
                        <thead>
                            <tr class="danger">
                                <th><spring:message code="caution.referenceMarche" /></th>
                                <th><spring:message code="caution.montantMarche" /></th>
                                <th><spring:message code="caution.commercial" /></th>
                                <th><spring:message code="caution.numero" /></th>
                                <th><spring:message code="caution.typeCaution" /></th>
                                <th><spring:message code="caution.banque" /></th>
                                <th><spring:message code="caution.montant" /></th>
                                <th><spring:message code="caution.dateDebut" /></th>
                                <th><spring:message code="caution.dateFin" /></th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="caution" items="${cautions}">
                                <c:if test="${caution.dateFin le todayDate}">
                                    <tr class="text-danger" >
                                        <td>${caution.referenceMarche} </td>
                                        <td>${caution.montantMarche} </td>
                                        <td>${caution.commercial.user.nom} </td>
                                        <td>${caution.numero} </td>
                                        <td>${caution.typeCaution.nom}</td>
                                        <td>${caution.banque.libelle} </td>
                                        <td>${caution.montant} </td>
                                        <td>${caution.getTrueDate(caution.dateDebut)} </td>
                                        <td>${caution.getTrueDate(caution.dateFin)} </td>
                                    </tr>
                                </c:if>
                                <c:if test="${caution.dateFin gt todayDate}">
                                    <tr>
                                        <td>${caution.referenceMarche} </td>
                                        <td>${caution.montantMarche} </td>
                                        <td>${caution.commercial.user.nom} </td>
                                        <td>${caution.numero} </td>
                                        <td>${caution.typeCaution.nom}</td>
                                        <td>${caution.banque.libelle} </td>
                                        <td>${caution.montant} </td>
                                        <td>${caution.getTrueDate(caution.dateDebut)} </td>
                                        <td>${caution.getTrueDate(caution.dateFin)} </td>
                                    </tr>
                                </c:if>

                            </c:forEach>
                        </tbody>
                    </table>
                </fieldset>
            </div>
        </div>

        <div class="row">
            <div class="col-md-12 text-center">

                <hr/>

                <spring:url value="/appeloffre/delete" var="appeloffre_delete"/>
                <form:form method="post" commandName="appelOffre" action="${appeloffre_delete}">
                    <form:hidden path="id"/>
                    <spring:url value="/appeloffre/" var="appeloffre_home"/>
                    <a href="${appeloffre_home}" class="btn btn-primary  btn-sm">
                        <span class="glyphicon glyphicon-list"></span>
                        <spring:message code="appelOffre.liste" />
                    </a>
                    <spring:url value="/appeloffre/${appelOffre.id}/edit" var="appeloffre_edit"/>
                    <a href="${appeloffre_edit}" class="btn btn-default  btn-sm">
                        <span class="glyphicon glyphicon-edit"></span>
                        <spring:message code="action.modifier" />
                    </a>
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                    <button type="submit" class="btn btn-default  btn-sm">
                        <span class="glyphicon glyphicon-remove-sign"></span>
                        <spring:message code="action.effacer" />
                    </button>
                    <div class="dropdown" style="display: inline-block !important">
                        <button class="btn btn-default dropdown-toogle" id="dropdown-user" data-toggle="dropdown">
                            <i class="glyphicon glyphicon-print"></i>
                            <spring:message code="print.message" />
                            <i class="caret"></i>
                        </button>
                        <ul class="dropdown-menu" role="menu" aria-labeledby="dropdown-user">
                            <li>
                                <spring:url htmlEscape="true" var="pdf_print" value="/appeloffre/${appelOffre.id}/show.pdf" />
                                <a href="${pdf_print}" download="detail_appelOffre.pdf" >
                                    <spring:message code="print.pdf" />
                                </a>
                            </li>
                            <li>
                                <spring:url htmlEscape="true" var="xls_print" value="/appeloffre/${appelOffre.id}/show.xls" />
                                <a href="${xls_print}">
                                    <spring:message code="print.xls" />
                                </a>
                            </li>
                        </ul>
                    </div>
                </form:form>
            </div>
        </div>




    </tiles:putAttribute>
</tiles:insertDefinition>