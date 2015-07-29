<%--
    Document   : show
    Created on : 29 janv. 2015, 22:07:40
    Author     : fabrice
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
                    <spring:message code="materiel.afficher" /> : ${materiel.nom}
                </h4>
                <hr/>
            </div>
        </div>
        <div class="row">
            <div class="col-md-4 col-md-offset-4" id="table_show">
                <table class="table table-condensed">
                    <tbody>
                        <tr>
                            <th>
                                <spring:message code="materiel.typeMateriel" />
                            </th>
                            <td>${materiel.typeMateriel.nom}</td>
                        </tr>
                        <tr>
                            <th>
                                <spring:message code="materiel.code" />
                            </th>
                            <td>${materiel.code}</td>
                        </tr>
                        <tr>
                            <th>
                                <spring:message code="materiel.nom" />
                            </th>
                            <td>${materiel.nom}</td>
                        </tr>
                        <tr>
                            <th>
                                <spring:message code="materiel.description" />
                            </th>
                            <td>${materiel.description}</td>
                        </tr>
                    </tbody>
                </table>

            </div>
        </div>

        <div class="row">
            <div class="col-md-4 col-md-offset-4">

                <hr/>

                <spring:url value="/materiel/delete" var="materiel_delete"/>
                <form:form method="post" commandName="materiel" action="${materiel_delete}">
                    <form:hidden path="id"/>
                    <spring:url value="/materiel/" var="materiel_home"/>
                    <a href="${materiel_home}" class="btn btn-primary  btn-sm">
                        <span class="glyphicon glyphicon-list"></span>
                        <spring:message code="materiel.liste" />
                    </a>
                    <spring:url value="/materiel/${materiel.id}/edit" var="materiel_edit"/>
                    <a href="${materiel_edit}" class="btn btn-default  btn-sm">
                        <span class="glyphicon glyphicon-edit"></span>
                        <spring:message code="action.modifier" />
                    </a>
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                    <button type="submit" class="btn btn-default  btn-sm">
                        <span class="glyphicon glyphicon-remove-sign"></span>
                        <spring:message code="action.effacer" />
                    </button>
                </form:form>
            </div>
        </div>

    </tiles:putAttribute>
</tiles:insertDefinition>