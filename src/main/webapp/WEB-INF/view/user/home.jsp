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

<tiles:insertDefinition name="layout">
    <tiles:putAttribute name="body">
        
        <div class="row">
            <div class="col-lg-4 col-lg-offset-4">
                <div id="chartdiv" style="height:400px;width:300px; "></div>
            </div>
        </div>
        
        
        <!--[if lt IE 9]><script language="javascript" type="text/javascript" src="<c:url value="/resources/js/excanvas.js" />"></script><![endif]-->
        <script src="<c:url value="/resources/js/jquery.jqplot.min.js" />"></script>
        
        <script>
            $(function (){
               $.jqplot('chartdiv',  [[[1, 2],[3,5.12],[5,13.1],[7,33.6],[9,85.9],[11,219.9]]]); 
               $.jqplot('chartdiv2',  [[[1, 2],[3,5.12],[5,13.1],[7,33.6],[9,85.9],[11,219.9]]]); 
            });
        </script>
    </tiles:putAttribute>
</tiles:insertDefinition>