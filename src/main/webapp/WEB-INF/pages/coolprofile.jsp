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
        <%@include file="../resources/css/card.css"%>
        <%@include file="../resources/css/profile.css"%>
        <%@include file="../resources/css/bootstrap.css"%>
        <%@include file="../resources/css/style.css"%>
        .form-control{
            padding: 0px;
        }

    </style>
    <script src="https://cdn.jsdelivr.net/sweetalert2/6.1.1/sweetalert2.min.js"></script>
    <script src="https://cdn.jsdelivr.net/sweetalert2/6.1.1/sweetalert2.js"></script>
    <script src="http://code.jquery.com/jquery-1.11.1.min.js"></script>
    <script src="http://netdna.bootstrapcdn.com/bootstrap/3.1.0/js/bootstrap.min.js"></script>
    <script>
        $(document).ready(function () {
            $(".nav-tabs a").click(function () {
                $(this).tab('show');
            });
        });
    </script>
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
<style>
    .shirina{
        width:33%;
        valign:top;
        padding: 10px;
        background-color: #eeeeee;
    }


</style>

<body style="overflow-y: scroll;background-color: #eeeeee;">
<jsp:include page="fragments/top.jsp"/>


<div class="container text-center abc">
    <div class="row">
        <%--User's left bar--%>
        <div class="col-sm-3 well" style="background-color: #71c3ec;" id="leftPanel">
            <a style="color: whitesmoke" href="/user/profile/settings"><span
                    class="pull-right btn btn-warning btn-xs glyphicon glyphicon-cog"></span></a>

            <div class="row">
                <div class="col-md-12" style="margin: 0 auto;">
                    <div>
                        <img src="${currentUser.avatar}"
                             alt="User's avatar" class="img-circle" height="150" width="150">
                        <br>
                        <br>

                        <p>
                            <small class="status_name">@${currentUser.username.toUpperCase()}</small>
                        </p>
                        <h4 class="status_name">${currentUser.first_name} ${currentUser.last_name}</h4>

                        <p class="status_name">${currentUser.description}</p>

                        <div class="twPc-divStats">
                            <ul class="twPc-Arrange">
                                <li class="twPc-ArrangeSizeFit">
                                    <span class="twPc-StatLabel twPc-block status_name"><spring:message code='tweets'/></span>
                                    <span class="twPc-StatValue status_name">${usersTweets.size()}</span>
                                </li>
                                <li class="twPc-ArrangeSizeFit">
                                    <span class="twPc-StatLabel twPc-block status_name"><spring:message code='following'/></span>
                                    <span class="twPc-StatValue status_name">${ifollow.size()}</span>
                                </li>
                                <li class="twPc-ArrangeSizeFit">
                                    <span class="twPc-StatLabel twPc-block status_name"><spring:message code='followers'/></span>
                                    <span class="twPc-StatValue status_name">${followMe.size()}</span>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <ul class="nav nav-tabs  col-sm-6">
            <li class="active"><a href="#home"><spring:message code='tweets'/></a></li>
            <li><a href="#menu1"><spring:message code='following'/></a></li>
            <li><a href="#menu2"><spring:message code='followers'/></a></li>
        </ul>

        <div class="tab-content">
            <div id="home" class="tab-pane fade in active">


                <!-- MIDDLE PART -->
                <div class="col-sm-6"><br>
                    <div id="test-id">
                        <c:forEach items="${usersTweets}" var="t" varStatus="status">
                            <div class="row">
                                <div class="col-sm-12">
                                    <div class="well reply_wrap" style="text-align:left">
                                        <div class="col-sm-2 reply-image">
                                            <img src="${t.user.avatar}" class="reply-img" height="55" width="55" alt="Avatar">
                                        </div>
                                            <div class="reply_text">
                                                    <input type="hidden"
                                                           name="${_csrf.parameterName}"
                                                           value="${_csrf.token}"/>
                                                    <input type="hidden" id="id" name="id"/>
                                                        <span class="reply_text"
                                                              style="text-align: left; font-weight: bold">${t.user.username}</span>
                                            <span class="reply_footer pull-right">
                                                <small>${t.postDateTime.toLocalDate()}
                                                        ${t.postDateTime.toLocalTime().withNano(0)}
                                                </small>
                                            </span>

                                                    <span style="font-size:larger; padding-bottom: 10px; padding-top: 10px; border: none; overflow: hidden; height: auto; box-shadow: none; resize: none; "
                                                     class="form-control">${t.text}</span>

                                                <c:if test="${t.image!=null}">
                                                    <c:if test="${!t.image.equals('')}">
                                                        <span width="80%" class="pull-right" style="padding-bottom: 10px">
                                                        <img width="100%" src="<c:url value="/images/" />${t.image}"></c:if></span>
                                                </c:if>

                                                 <span onclick="sweetDelTwit(${t.id});"
                                                       class="pull-right btn btn-default btn-xs glyphicon glyphicon-trash"></span>
                                            <a class="btn btn-warning btn-xs glyphicon glyphicon-pencil"
                                               href="${pageContext.request.contextPath}/user/profile/edittweet/${t.id}#myModal">
                                            </a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                        <jsp:include page="modal.jsp"/>
                    </div>
                </div>
            </div>

            <div id="menu1" class="tab-pane fade">
                <%--<h3>Following</h3>--%>
                <div class="col-sm-9"  style="text-align: center;">
                    <div id="refresh">
                        <br>

                        <div>
                            <div class="panel panel-default text-left"
                                 style=" background-color: #eeeeee; border-color: #eeeeee; -webkit-box-shadow: 0 0px 0px rgba(0,0,0,0);">
                                <div>
                                    <table width="100%">
                                        <tr>
                                            <td width="33%" valign="top"                                              style="padding: 10px; background-color: #eeeeee">
                                                <c:forEach items="${ifollow}" var="v" begin="0" step="3">
                                                    <div class="twPc-div">
                                                        <a class="twPc-bg twPc-block"></a>

                                                        <div>
                                                            <div class="twPc-button">
                                                                <!-- Twitter Button | you can get from: https://about.twitter.com/tr/resources/buttons#follow -->
                                                                <span class="pull-right btn btn-danger btn-xs"
                                                                      onclick="sweetUnf('${v.username}')">- <spring:message code='Unfollow'/></span>

                                                                <p></p>

                                                                <br>
                                                                <!-- Twitter Button -->
                                                            </div>

                                                            <a title="${v.username}" href="/user/profile/${v.username}"
                                                               class="twPc-avatarLink">
                                                                <img alt="${v.username}"
                                                                     src="${v.avatar}"
                                                                     class="twPc-avatarImg">
                                                            </a>

                                                            <div class="twPc-divUser"
                                                                 onclick="location.href='/user/profile/${v.username}';"
                                                                 style="cursor:pointer;">
                                                                <div class="twPc-divName">
                                                                    <small style="color: #d58512; font-size: x-small">
                                                                        <a href="/user/profile/${v.username}">@${v.username.toUpperCase()}</a>
                                                                    </small>
                                                                    <br>
                                                                    <a href="/user/profile/${v.username}">${v.first_name} ${v.last_name}</a>
                                                                    <br>
                                                                    <br>

                                                                    <p class="text-primary small"
                                                                       style="text-align: center; ">${v.description}</p>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <br>
                                                </c:forEach>
                                            </td>

                                            <td width="33%" valign="top" style="padding: 10px; background-color: #eeeeee">
                                                <c:forEach items="${ifollow}" var="v" begin="1" step="3">
                                                    <div class="twPc-div" id="${v.username}">
                                                        <a class="twPc-bg twPc-block"></a>

                                                        <div>
                                                            <div class="twPc-button">
                                                                <!-- Twitter Button | you can get from: https://about.twitter.com/tr/resources/buttons#follow -->
                                                                <span class="pull-right btn btn-danger btn-xs"
                                                                      onclick="sweetUnf('${v.username}')">- <spring:message code='Unfollow'/></span>

                                                                <p></p>
                                                                <br>
                                                                <!-- Twitter Button -->
                                                            </div>

                                                            <a title="${v.username}" href="/user/profile/${v.username}"
                                                               class="twPc-avatarLink">
                                                                <img alt="${v.username}"
                                                                     src="${v.avatar}"
                                                                     class="twPc-avatarImg">
                                                            </a>

                                                            <div class="twPc-divUser"
                                                                 onclick="location.href='/user/profile/${v.username}';"
                                                                 style="cursor:pointer;">
                                                                <div class="twPc-divName">
                                                                    <small style="color: #d58512; font-size: x-small">
                                                                        <a href="/user/profile/${v.username}">@${v.username.toUpperCase()}</a>
                                                                    </small>
                                                                    <br>
                                                                    <a href="/user/profile/${v.username}">${v.first_name} ${v.last_name}</a>
                                                                    <br>
                                                                    <br>

                                                                    <p class="text-primary small"
                                                                       style="text-align: center; ">${v.description}</p>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <br>
                                                </c:forEach>
                                            </td>

                                            <td width="33%" valign="top"
                                                style="padding: 10px; background-color: #eeeeee">
                                                <c:forEach items="${ifollow}" var="v" begin="2" step="3">
                                                    <div class="twPc-div">
                                                        <a class="twPc-bg twPc-block"></a>


                                                        <div>
                                                            <div class="twPc-button">
                                                                <!-- Twitter Button | you can get from: https://about.twitter.com/tr/resources/buttons#follow -->

                                                                <span class="pull-right btn btn-danger btn-xs"
                                                                      onclick="sweetUnf('${v.username}');">- <spring:message code='Unfollow'/></span>

                                                                <p></p>
                                                                <br>
                                                                <!-- Twitter Button -->
                                                            </div>

                                                            <a title="${v.username}" href="/user/profile/${v.username}"
                                                               class="twPc-avatarLink">
                                                                <img alt="${v.username}"
                                                                     src="${v.avatar}"
                                                                     class="twPc-avatarImg">
                                                            </a>

                                                            <div class="twPc-divUser"
                                                                 onclick="location.href='/user/profile/${v.username}';"
                                                                 style="cursor:pointer;">
                                                                <div class="twPc-divName">
                                                                    <small style="color: #d58512; font-size: x-small">
                                                                        <a href="/user/profile/${v.username}">@${v.username.toUpperCase()}</a>
                                                                    </small>
                                                                    <br>
                                                                    <a href="/user/profile/${v.username}">${v.first_name} ${v.last_name}</a>
                                                                    <br>
                                                                    <br>

                                                                    <p class="text-primary small"
                                                                       style="text-align: center; ">${v.description}</p>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <br>
                                                </c:forEach>
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div id="menu2" class="tab-pane fade">
                <%--<h3>Followers</h3>--%>
                <div class="col-sm-9" style="text-align: center;">
                    <div>
                        <br>

                        <div>
                            <div class="panel panel-default text-left"
                                 style=" background-color: #eeeeee; border-color: #eeeeee; -webkit-box-shadow: 0 0px 0px rgba(0,0,0,0);">
                                <div>
                                    <table width="100%">
                                        <tr>
                                            <td width="33%" valign="top"
                                                style="padding: 10px; background-color: #eeeeee">
                                                <c:forEach items="${followMe}" var="v" begin="0" step="3">

                                                    <div class="twPc-div"
                                                         onclick="location.href='/user/profile/${v.username}';"
                                                         style="cursor:pointer;">
                                                        <a class="twPc-bg twPc-block"> </a>

                                                        <div>

                                                            <a title="${v.username}" href="/user/profile/${v.username}"
                                                               class="twPc-avatarLink">
                                                                <img alt="${v.username}"
                                                                     src="${v.avatar}"
                                                                     class="twPc-avatarImg">
                                                            </a>

                                                            <div class="twPc-divUser">
                                                                <div class="twPc-divName">
                                                                    <small style="color: #d58512; font-size: x-small">
                                                                        <a href="/user/profile/${v.username}">@${v.username.toUpperCase()}</a>
                                                                    </small>
                                                                    <br>
                                                                    <a href="/user/profile/${v.username}">${v.first_name} ${v.last_name}</a>
                                                                    <br>
                                                                    <br>

                                                                    <p class="text-primary small"
                                                                       style="text-align: center; ">${v.description}</p>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <br>
                                                </c:forEach>
                                            </td>

                                            <td width="33%" valign="top"
                                                style="padding: 10px; background-color: #eeeeee">
                                                <c:forEach items="${followMe}" var="v" begin="1" step="3">

                                                    <div class="twPc-div"
                                                         onclick="location.href='/user/profile/${v.username}';"
                                                         style="cursor:pointer;">
                                                        <a class="twPc-bg twPc-block"> </a>

                                                        <div>

                                                            <a title="${v.username}" href="/user/profile/${v.username}"
                                                               class="twPc-avatarLink">
                                                                <img alt="${v.username}"
                                                                     src="${v.avatar}"
                                                                     class="twPc-avatarImg">
                                                            </a>

                                                            <div class="twPc-divUser">
                                                                <div class="twPc-divName">
                                                                    <small style="color: #d58512; font-size: x-small">
                                                                        <a href="/user/profile/${v.username}">@${v.username.toUpperCase()}</a>
                                                                    </small>
                                                                    <br>
                                                                    <a href="/user/profile/${v.username}">${v.first_name} ${v.last_name}</a>
                                                                    <br>
                                                                    <br>

                                                                    <p class="text-primary small"
                                                                       style="text-align: center; ">${v.description}</p>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <br>
                                                </c:forEach>
                                            </td>

                                            <td width="33%" valign="top"
                                                style="padding: 10px; background-color: #eeeeee">
                                                <c:forEach items="${followMe}" var="v" begin="2" step="3">

                                                    <div class="twPc-div"
                                                         onclick="location.href='/user/profile/${v.username}';"
                                                         style="cursor:pointer;">
                                                        <a class="twPc-bg twPc-block"> </a>

                                                        <div>

                                                            <a title="${v.username}" href="/user/profile/${v.username}"
                                                               class="twPc-avatarLink">
                                                                <img alt="${v.username}"
                                                                     src="${v.avatar}"
                                                                     class="twPc-avatarImg">
                                                            </a>

                                                            <div class="twPc-divUser">
                                                                <div class="twPc-divName">
                                                                    <small style="color: #d58512; font-size: x-small">
                                                                        <a href="/user/profile/${v.username}">@${v.username.toUpperCase()}</a>
                                                                    </small>
                                                                    <br>
                                                                    <a href="/user/profile/${v.username}">${v.first_name} ${v.last_name}</a>
                                                                    <br>
                                                                    <br>

                                                                    <p class="text-primary small"
                                                                       style="text-align: center; ">${v.description}</p>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <br>
                                                </c:forEach>
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>


    <script>
        <%--REMEMBER CURRENT TAB--%>
        $(document).ready(function() {
            if(location.hash) {
                $('a[href=' + location.hash + ']').tab('show');
            }
            $(document.body).on("click", "a[data-toggle]", function(event) {
                location.hash = this.getAttribute("href");
            });
        });
        $(window).on('popstate', function() {
            var anchor = location.hash || $("a[data-toggle=tab]").first().attr("href");
            $('a[href=' + anchor + ']').tab('show');
        });

        function sweetUnf(username) {
//            var username = $(this).data('unflw');
            swal({
                title: 'Are you sure?',
                text: "You won't be able to revert this!",
                type: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: 'Yes, unfollow this user!'

            }).then(function () {
                $.ajax({
                    url: '/unfollow/' + username,
                    data:username,
                    dataType: 'text',
                    type: 'GET',
                    success: function (data) {
                        $('#'+username).hide();
                        $('#refresh').load(document.URL +  ' #refresh');
                    }
                });
            })
        }

        function sweetDelTwit(id) {
            swal({
                title: 'Are you sure?',
                text: "You won't be able to revert this!",
                type: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: 'Yes, delete it!'
            }).then(function () {

                location.href = '/tweet/deleteTweet/' + id;

            })
        }
    </script>
    <script>

    </script>
    <a href="#" class="scrollup">Наверх</a>
</body>
</html>

