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
<%@taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<tiles:insertDefinition name="layout">
    <tiles:putAttribute name="body">
        <div class="row">
            <div class="col-md-12">
                <h4>
                    <spring:message code="user.afficher" />
                </h4>
                <hr/>
            </div>
        </div>

        <div class="row">
            <div class="col-md-4 col-md-offset-4" id="table_show">
                <table class="table table-bordered table-condensed">
                    <tbody>
                        <tr>
                            <th>
                                <spring:message code="user.nom" />
                            </th>
                            <td>${user.user.nom}</td>
                        </tr>
                        <tr>
                            <th>
                                <spring:message code="user.role" />
                            </th>
                            <td>${user.getFunction(user.role)}</td>
                        </tr>
                        <tr>
                            <th>
                                <spring:message code="user.username" />
                            </th>
                            <td>${user.user.username}</td>
                        </tr>
                    </tbody>
                </table>

            </div>
        </div>


        <div class="row">
            <div class="col-md-4 col-md-offset-4">

                <hr/>

                <spring:url value="/user/delete" var="user_delete"/>
                <form:form method="post" commandName="user" action="${user_delete}">

                    <spring:url value="/user/" var="user_home"/>
                    <a href="${user_home}" class="btn btn-primary  btn-sm">
                        <span class="glyphicon glyphicon-list"></span>
                        <spring:message code="user.liste" />
                    </a>
                    <sec:authorize access="hasRole('ROLE_ADMIN')" >
                        <form:hidden path="id"/>
                        <spring:url value="/user/${user.id}/edit" var="user_edit"/>
                        <a href="${user_edit}" class="btn btn-default  btn-sm">
                            <span class="glyphicon glyphicon-edit"></span>
                            <spring:message code="action.modifier" />
                        </a>
                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                        <button type="submit" class="btn btn-default  btn-sm">
                            <span class="glyphicon glyphicon-remove-sign"></span>
                            <spring:message code="action.effacer" />
                        </button>
                    </sec:authorize>
                </form:form>
            </div>
        </div>


    </tiles:putAttribute>
</tiles:insertDefinition>