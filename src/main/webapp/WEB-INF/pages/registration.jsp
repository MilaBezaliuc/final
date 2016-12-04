<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>

    <!-- This file has been downloaded from Bootsnipp.com. Enjoy! -->
    <title>Register</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <style type="text/css">
    <%@include file="../resources/css/login-registration.css"%>
    <%@include file="../resources/css/bootstrap.css"%>
    <%@include file="../resources/css/style.css"%>
    </style>
    <script src="http://code.jquery.com/jquery-1.11.1.min.js"></script>
    <script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.0/js/bootstrap.min.js"></script>
</head>
<body style="background-color: #efefef">
<%--VIDEO--%>
<div class="background-wrap">
    <video id="video-bg-elem" preload="auto" autoplay="true" loop="loop" muted="muted">
        <source src="../resources/videobg/Video%20Background%2011%20Birds%20Animation.mp4">
        Video not supported :(
    </video>
</div>

<div class="container content" >
    <div class="wrapper">

    <spring:message code='username' var="username"/>
        <spring:message code='password' var="password"/>
        <spring:message code='confirm_password' var="confirm_password"/>
        <spring:message code='first_name' var="first_name"/>
        <spring:message code='last_name' var="last_name"/>
        <spring:message code='email' var="email"/>
        <spring:message code='reg_button' var="reg_button"/>
    <form:form method="POST" action="/registration" modelAttribute="user" class="form-signin">
        <h3 class="form-signin-heading"><spring:message code="registration" /></h3>

        <spring:bind path="username">
            <div class="form-group alert-danger ${status.error ? 'has-error' : ''}">
                <form:input type="text" path="username" class="form-control" placeholder='${username}'
                            autofocus="true"/>
                <form:errors path="username"/>
            </div>
        </spring:bind>

        <spring:bind path="password">
            <div class="form-group alert-danger ${status.error ? 'has-error' : ''}">
                <form:input type="password" path="password" class="form-control" placeholder="${password}" autofocus="true"/>
                <form:errors path="password"/>
            </div>
        </spring:bind>

        <spring:bind path="confirmPassword">
            <div class="form-group alert-danger ${status.error ? 'has-error' : ''}">
                <form:input type="password" path="confirmPassword" class="form-control"
                            placeholder="${confirm_password}" autofocus="true"/>
                <form:errors path="confirmPassword"/>
            </div>
        </spring:bind>

        <spring:bind path="first_name">
            <div class="form-group alert-danger ${status.error ? 'has-error' : ''}">
                <form:input type="text" path="first_name" class="form-control" placeholder="${first_name}"
                            autofocus="true"/>
                <form:errors path="first_name"/>
            </div>
        </spring:bind>

        <spring:bind path="last_name">
            <div class="form-group alert-danger ${status.error ? 'has-error' : ''}">
                <form:input type="text" path="last_name" class="form-control" placeholder="${last_name}"
                            autofocus="true"/>
                <form:errors path="last_name"/>
            </div>
        </spring:bind>

        <spring:bind path="email">
            <div class="form-group alert-danger ${status.error ? 'has-error' : ''}">
                <form:input type="email" path="email" class="form-control" placeholder="${email}"
                            autofocus="true"/>
                <form:errors path="email"/>
            </div>
        </spring:bind>
        <button class="btn btn-lg btn-warning btn-block" type="submit">${reg_button}</button>
    </form:form>
    </div>
</div>
<!-- /container -->
</body>
</html>