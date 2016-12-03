<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <title>User Profile</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="http://netdna.bootstrapcdn.com/bootstrap/3.1.0/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/sweetalert2/6.1.1/sweetalert2.css">
    <style type="text/css">
        <%@include file="../resources/css/profile.css"%>
        <%@include file="../resources/css/bootstrap.css"%>
        <%@include file="../resources/css/style.css"%>
        <%@include file="../resources/css/card.css"%>
    </style>
    <style>
        body {
            background-color: #eeeeee;
        }
    </style>
    <script src="https://cdn.jsdelivr.net/sweetalert2/6.1.1/sweetalert2.min.js"></script>
    <script src="https://cdn.jsdelivr.net/sweetalert2/6.1.1/sweetalert2.js"></script>
    <script src="http://code.jquery.com/jquery-1.11.1.min.js"></script>
    <script src="http://netdna.bootstrapcdn.com/bootstrap/3.1.0/js/bootstrap.min.js"></script>

    <script type="text/javascript">
        $(document).ready(function(){

            $(window).scroll(function(){
                if ($(this).scrollTop() > 100) {
                    $('.scrollup').fadeIn();
                } else {
                    $('.scrollup').fadeOut();
                }
            });

            $('.scrollup').click(function(){
                $("html, body").animate({ scrollTop: 0 }, 600);
                return false;
            });

        });
    </script>

</head>
<body style="overflow-y: scroll;">
<jsp:include page="fragments/top.jsp"/>

<div class="container text-center">
    <div class="row">
        <%--Left panel--%>
        <div class="col-sm-3 well abc" style="background-color: #71c3ec;" id="leftPanel">
            <div class="row">
                <div class="col-md-12" style="margin: 0 auto;">
                    <div>
                        <img src="${user.avatar}"
                             alt="User's avatar" class="img-circle" height="150" width="150">
                        <br>
                        <br>

                        <p>
                            <small class="status_name">@${user.username.toUpperCase()}</small>
                        </p>
                        <h4 class="status_name">${user.first_name} ${user.last_name}</h4>

                        <p class="status_name">${user.description}</p>

                        <div class="twPc-divStats">
                            <ul class="twPc-Arrange">
                                <li class="twPc-ArrangeSizeFit">
                                    <span class="twPc-StatLabel twPc-block status_name">Tweets</span>
                                    <span class="twPc-StatValue status_name">${usersTweets.size()}</span>
                                </li>
                                <li class="twPc-ArrangeSizeFit">
                                    <span class="twPc-StatLabel twPc-block status_name">Following</span>
                                    <span class="twPc-StatValue status_name">${ifollow_counter}</span>
                                </li>
                                <li class="twPc-ArrangeSizeFit">
                                    <span class="twPc-StatLabel twPc-block status_name">Followers</span>
                                    <span class="twPc-StatValue status_name">${followMe_counter}</span>
                                </li>
                            </ul>
                            <br>
                            <c:if test="${isFollowed==0}">
                                <input type="hidden" id="flw" value="${user.username}">
                                <span class="pull-right btn btn-warning btn-sm" onclick="follow()">+
                                    Follow</span>
                            </c:if>

                            <c:if test="${isFollowed!=0}">
                                <input type="hidden" id="unflw" value="${user.username}">
                                <span class="pull-right btn btn-danger btn-sm"
                                      onclick="sweetUnf()">-
                                    Unfollow</span>
                            </c:if>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- MIDDLE PART -->
        <div class="col-sm-6 abc">
            <div id="test-id">
                <c:forEach items="${usersTweets}" var="t" varStatus="status">
                    <div class="row">
                        <div class="col-sm-12">
                            <div class="well reply_wrap" style="text-align:left">
                                <div class="col-sm-2 reply-image">
                                    <img src="${t.user.avatar}" class="reply-img" height="55" width="55" alt="Avatar">
                                </div>
                                <div class="reply_text">
                                    <input type="hidden" id="id" name="id">
                            <span style="text-align: left; font-weight: bold">
                                <a href="/user/profile/${t.user.username}"> ${t.user.username} </a>
                            </span>
                                    <span class="reply_footer pull-right"><small>${t.postDateTime.toLocalDate()} ${t.postDateTime.toLocalTime().withNano(0)}</small></span>
                                    <br>
                                    <span>
                                    <p style="font-size: larger; padding-bottom: 10px; padding-top: 10px;">${t.text}</p>
                                    </span>

                                    <c:if test="${t.image!=null}">
                                        <c:if test="${!t.image.equals('')}">
                                            <span width="80%" class="pull-right">
                                            <img width="100%" src="<c:url value="/images/" />${t.image}"></c:if></span>
                                    </c:if>

                                </div>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>
    </div>
</div>

<script>
    function follow() {
        var username = $(document.getElementById("flw")).val();
        swal({
            title: 'Do you want to follow this user?',
            type: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#3085d6',
            cancelButtonColor: '#d33',
            confirmButtonText: 'Yes, follow this user!'

        }).then(function () {
            $.ajax({
                url: '/addfollower/' + username,
                dataType: 'text',
                type: 'GET'
            });
            location.reload();
        })
    }

    function sweetUnf() {
        var id = $(document.getElementById("unflw")).val();
        swal({
            title: 'Are you sure?',
            type: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#3085d6',
            cancelButtonColor: '#d33',
            confirmButtonText: 'Yes, unfollow this user!'

        }).then(function () {
            $.ajax({
                url: '/unfollow/' + id,
                data: id,
                dataType: 'text',
                type: 'GET'
            });
            location.reload().fadeIn('fast');
        })
    }
</script>
</body>
</html>

