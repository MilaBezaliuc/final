<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>

<script type="text/javascript">
    var search = function () {
        var availableTags = [];
        $.ajax({
            url: '/searchUser',
            data: ({username: $('#username').val()}),
            success: function (data) {
                for (var i = 0; i < data.length; i++) {
                    availableTags[i] = data[i];
                }
                $('#username').autocomplete({
                    source: availableTags,
                    minLength: 3,
                    autoFocus: true,
                    select: function () {
                        for (var i = 0; i < data.length; i++) {
                            window.location = "/user/profile/" + data[i];
                        }
                    }
                });
            }
        });
    };
</script>

<style>
    .ui-front {
        z-index: 2000;
    }

</style>

<div class="navbar navbar-fixed-top" style="background-color: #71c3ec;">
    <div class="container-fluid">
        <div class="navbar-header">
            <button style="background-color: whitesmoke" type="button" class="navbar-toggle" data-toggle="collapse"
                    data-target="#myNavbar">
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="/tweet"><img height="23px" src="/resources/pics/logo.png"/> </a>
        </div>
        <div class="collapse navbar-collapse">
            <ul class="nav navbar-nav">
                <li><a href="/tweet" class="status_name"><span class="glyphicon glyphicon-home"></span> <spring:message
                        code='home'/></a>
                </li>
                <li><a href="/user/profile/" class="status_name"><span class="glyphicon glyphicon-user"></span>
                    <spring:message code='my_account'/></a></li>
                <li></li>
                <li><a href="<c:url value="/logout" />" class="status_name"><span
                        class="glyphicon glyphicon-off"></span> <spring:message code='logout'/></a></li>


            </ul>
            <div class="pull-right">
                <ul class="navbar nav navbar-nav">
                    <li><a style="color:whitesmoke;" href="?lang=en">en</a></li>
                    <li><a>|</a></li>
                    <li><a style="color:whitesmoke;" href="?lang=ru">ru</a></li>
                </ul>

                <form class="navbar-form pull-right" role="search">
                    <div class="form-group input-group" style="z-index: 2000">
                        <input size="12" style="padding-left: 10px" type="text" class="form-control ui-widget"
                               placeholder="<spring:message code='search'/>" id="username"
                               onkeyup="search()">
                    <span class="input-group-btn">
                        <span class="btn " style="background-color: white; border-color: #cccccc; border-left: none">
                            <span class="glyphicon glyphicon-search" style="color:steelblue;"></span>
                        </span>
                    </span>
                    </div>
                </form>
            </div>



        </div>
    </div>
</div>



