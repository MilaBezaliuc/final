<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<div class="col-sm-3 well abc" style="background-color: #71c3ec" id="leftPanel">
    <div class="row">
        <div class="col-md-12" style="margin: 0 auto;">
            <div>
                <br>
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
                            <span class="twPc-StatValue status_name">${myTweets.size()}</span>
                        </li>
                        <li class="twPc-ArrangeSizeFit">
                            <span class="twPc-StatLabel twPc-block status_name"><spring:message code='following'/></span>
                            <span class="twPc-StatValue status_name">${IFollow.size()}</span>
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
    <br>

    <div class="alert alert-info fade in">
        <a href="#" class="close glyphicon glyphicon-remove" data-dismiss="alert" aria-label="close"></a>
        <br>

        <div>
            <p><strong><spring:message code='hi'/> ${currentUser.username}!</strong></p>
            <spring:message code='these_are_people_you_follow'/>.<br><br>

            <c:forEach items="${IFollow}" var="f" end="4">
                <p><a href="/user/profile/${f.username}" style="text-decoration: none"><strong>${f.username}</strong></a></p>
            </c:forEach>
        </div>
    </div>
</div>
