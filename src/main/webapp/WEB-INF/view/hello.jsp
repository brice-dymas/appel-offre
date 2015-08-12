<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<tiles:insertDefinition name="layout">
    <tiles:putAttribute name="body">
        <h1>Spring MVC - jQuery File Upload</h1>
        <div style="width:500px;padding:20px">

            <input id="fileupload" type="file" name="files[]" data-url="file/upload.json?${_csrf.parameterName}=${_csrf.token}" multiple>

            <div class="well">Drop files here</div>

            <div class="progress">
                <div class="progress-bar" style="width: 0%;">
                    <span class="sr-only">60% Complete</span>
                </div>
            </div>

            <table id="uploaded-files" class="table">
                <tr>
                    <th>File Name</th>
                    <th>File Size</th>
                    <th>File Type</th>
                    <th>Download</th>
                </tr>
            </table>

        </div>

        <script src="<c:url value="/resources/js/jquery-ui.min.js" />"></script>
        <script src="<c:url value="/resources/js/jquery.iframe-transport.js" />"></script>
        <script src="<c:url value="/resources/js/jquery.fileupload.js" />"></script>
        <script>
            $(function () {
                $('#fileupload').fileupload({
                    dataType: 'json',
                    done: function (e, data) {
                        $("tr:has(td)").remove();
                        $.each(data.result, function (index, file) {


                            $("#uploaded-files").append(
                                    $('<tr/>')
                                    .append($('<td/>').text(file.fileName))
                                    .append($('<td/>').text(file.fileSize))
                                    .append($('<td/>').text(file.fileType))
                                    .append($('<td/>').html("<a href='rest/controller/get/" + index + "'>Click</a>"))
                                    )//end $("#uploaded-files").append()
                        });
                    },
                    progressall: function (e, data) {

                        var progress = parseInt(data.loaded / data.total * 100, 10);
                        console.log(progress);
                        $('.progress .progress-bar').css(
                                'width',
                                progress + '%'
                                );
                    },
                    dropZone: $('#dropzone')
                });
            });
        </script>
    </tiles:putAttribute>
</tiles:insertDefinition>