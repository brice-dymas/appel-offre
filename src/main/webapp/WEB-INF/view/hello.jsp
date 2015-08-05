<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<tiles:insertDefinition name="layout">
    <tiles:putAttribute name="body">
        <hr/>
        <div class="row">
            <h1>
                <spring:message code="user.profil" />
            </h1>
        </div>
        <hr/>
        <br/>
        <div class="row">
            <div class="col-md-5 col-md-offset-4" id="table_show">
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
            <div class="row">
                <div class="col-md-4 col-md-offset-4">
                    <hr/>
                    <sec:authorize access="hasRole('ROLE_ADMIN')" >
                        <spring:url value="/user/" var="user_home"/>
                        <a href="${user_home}" class="btn btn-primary  btn-sm">
                            <span class="glyphicon glyphicon-list"></span>
                            <spring:message code="user.liste" />
                        </a>
                    </sec:authorize>


                    <c:if test="${user.id == userConnected.id}">
                        <sec:authorize access="hasAnyRole('ROLE_COMMERCIAL','ROLE_TRESORIER','ROLE_ADMIN') and isAuthenticated()">
                            <spring:url value="/user/${user.id}/edit" var="user_edit"/>
                            <a href="${user_edit}" class="btn btn-default  btn-danger">
                                <span class="glyphicon glyphicon-edit"></span>
                                <spring:message code="action.modifier" />
                            </a>
                        </sec:authorize>
                    </c:if>
                </div>
            </div>

        </div>
    </tiles:putAttribute>
</tiles:insertDefinition>