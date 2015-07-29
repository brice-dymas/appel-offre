<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<tiles:insertDefinition name="layout">
    <tiles:putAttribute name="body">

        <div class="row">
            <div class="col-md-9">
                <div>
                    <h3>
                        <spring:message code="banque.liste" />
                    </h3>
                    <hr/>
                </div>

                <div class="dropdown pull-right ">
                    <button class="btn btn-default dropdown-toggle" type="button" id="dropdownMenu1" data-toggle="dropdown" aria-expanded="true">
                        <spring:message code="search.taille" />
                        : ${size}&nbsp;
                        <span class="caret"></span>
                    </button>
                    <ul class="dropdown-menu" role="menu" aria-labelledby="dropdownMenu1">
                        <li role="presentation"><a role="menuitem" tabindex="-1" href="?querycode=${banque.code}&querynom=${banque.libelle}&size=5">5</a></li>
                        <li role="presentation"><a role="menuitem" tabindex="-1" href="?querycode=${banque.code}&querynom=${banque.libelle}&size=10">10</a></li>
                        <li role="presentation"><a role="menuitem" tabindex="-1" href="?querycode=${banque.code}&querynom=${banque.libelle}&size=20">20</a></li>
                        <li role="presentation"><a role="menuitem" tabindex="-1" href="?querycode=${banque.code}&querynom=${banque.libelle}&size=30">30</a></li>
                        <li role="presentation"><a role="menuitem" tabindex="-1" href="?querycode=${banque.code}&querynom=${banque.libelle}&size=40">40</a></li>
                        <li role="presentation"><a role="menuitem" tabindex="-1" href="?querycode=${banque.code}&querynom=${banque.libelle}&size=50">50</a></li>
                    </ul>
                </div>
                <table class="table table-condensed table-hover table-bordered">
                    <thead class="bg-danger" >
                        <tr>
                            <th>
                                <spring:message code="banque.code" />
                            </th>
                            <th>
                                <spring:message code="banque.libelle" />
                            </th>
                            <th>
                                <spring:message code="action.titre" />
                            </th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:if test="${banques.size() eq 0}">
                            <tr>
                                <td class="text text-center label-danger" colspan="7">
                                    <spring:message code="empty.data" />
                                </td>
                            </tr>
                        </tbody>
                    </table>
                    <div class="row">
                        <div class="col-lg-12">
                            <hr/>
                            <spring:url value="/banque/new" htmlEscape="true" var="banque_new" />
                            <a href="${banque_new}" class="btn btn-primary btn-sm">
                                <span class="glyphicon glyphicon-new-window"></span>
                                <spring:message code="action.nouveau" />
                            </a>

                            <div class="pull-right">
                                <ul class="pager">

                                    <li><a href="?query=${query}&page=0&size=${size}" class ="btn btn-sm disabled">
                                            <span class="glyphicon glyphicon-fast-backward"></span>
                                        </a></li>
                                    <li><a href="?query=${query}&page=${page-1}&size=${size}"class ="btn btn-sm disabled">
                                            <span class="glyphicon glyphicon-backward"></span>
                                        </a></li>
                                    <li><input type="text" class="pager_detail text-center" readonly value="0/0"/></li>
                                    <li><a href="?query=${query}&page=${page+1}&size=${size}" class ="btn btn-sm disabled">
                                            <span class="glyphicon glyphicon-forward"></span>
                                        </a></li>
                                    <li><a href="?query=${query}&page=${Totalpage-1}&size=${size}" class ="btn btn-sm disabled">
                                            <span class="glyphicon glyphicon-fast-forward"></span>
                                        </a></li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </c:if>
                <c:if test="${banques.size() ne 0}">
                    <c:forEach items="${banques}" var="banque">
                        <tr>
                            <td>
                                ${banque.code}
                            </td>
                            <td>
                                ${banque.libelle}
                            </td>
                            <td class="text-center">
                                <spring:url value="/banque/${banque.id}/edit" htmlEscape="true" var="banque_edit" />
                                <a href="${banque_edit}" class="btn btn-primary btn-sm">
                                    <span class="glyphicon glyphicon-edit"></span>
                                    <spring:message code="action.modifier" />
                                </a>
                                &nbsp;&nbsp;
                                <spring:url value="/banque/${banque.id}/show" htmlEscape="true" var="banque_show" />
                                <a href="${banque_show}" class="btn btn-primary btn-sm">
                                    <span class="glyphicon glyphicon-open"></span>
                                    <spring:message code="action.detail" />
                                </a>
                            </td>
                        </tr>
                    </c:forEach>

                    </tbody>

                    </table>

                    <div class="row">
                        <div class="col-lg-12">
                            <hr/>
                            <spring:url value="/banque/new" htmlEscape="true" var="banque_new" />
                            <a href="${banque_new}" class="btn btn-primary btn-sm">
                                <span class="glyphicon glyphicon-new-window"></span>
                                <spring:message code="action.nouveau" />
                            </a>

                            <div class="pull-right">
                                <ul class="pager">

                                    <li><a href="?querycode=${banque.code}&querynom=${banque.libelle}&page=0&size=${size}" <c:if test="${page eq 0}">class ="btn btn-sm disabled"</c:if>>
                                                <span class="glyphicon glyphicon-fast-backward"></span>
                                            </a></li>
                                        <li><a href="?querycode=${banque.code}&querynom=${banque.libelle}&page=${page-1}&size=${size}" <c:if test="${page eq 0}">class ="btn btn-sm disabled"</c:if>>
                                                <span class="glyphicon glyphicon-backward"></span>
                                            </a></li>
                                        <li><input type="text" class="pager_detail text-center" readonly value="${page+1}/${Totalpage}"/></li>
                                    <li><a href="?querycode=${banque.code}&querynom=${banque.libelle}&page=${page+1}&size=${size}" <c:if test="${page+1 eq Totalpage}">class ="btn btn-sm disabled"</c:if>>
                                                <span class="glyphicon glyphicon-forward"></span>
                                            </a></li>
                                        <li><a href="?querycode=${banque.code}&querynom=${banque.libelle}&page=${Totalpage-1}&size=${size}" <c:if test="${page+1 eq Totalpage}">class ="btn btn-sm disabled"</c:if>>
                                                <span class="glyphicon glyphicon-fast-forward"></span>
                                            </a></li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                </c:if>
            </div>
            <div class="col-md-3">
                <div>
                    <h3>
                        <spring:message code="action.rechercher" />
                    </h3>
                    <hr/>
                </div>
                <spring:url value="/banque/" var="banque"
                            htmlEscape="true" />
                <form:form method="get" commandName="banque" action="${banque}">
                    <div class="input-group">
                        <label>
                            <spring:message code="banque.libelle" />
                        </label>
                        <input type="text" value="${libelle}" class="form-control" name="querynom"/>
                    </div>
                    <hr/>
                    <button class="btn btn-default">
                        <span class="glyphicon glyphicon-search"></span> <spring:message code="search"/></button>
                        <spring:url value="/banque/" htmlEscape="true" var="banque" />
                    <a href="${banque}" class="btn btn-default btn-sm">
                        <span class="glyphicon glyphicon-refresh"></span>
                        <spring:message code="search.delete" />
                    </a>

                </form:form>
            </div>
        </div>

    </tiles:putAttribute>
</tiles:insertDefinition>