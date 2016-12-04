<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<div class="col-sm-3 well abc" style="background-color: #D8ECF6;">
    <%--<div class="thumbnail">--%>
    <h3 class="status_text"><spring:message code='who_to_follow'/></h3>
    <hr class="colorgraph">

    <div class="minibox" align="left" style="text-align: left; background-color: #D8ECF6;">
        <table width="100%">
            <c:forEach items="${followingOffers}" var="o">
                <tr>
                    <td width="20%" style="padding: 10px">
                        <div>
                            <img src="${o.avatar}" class="img-circle photo" style="margin: 0px auto" width="50px"
                                 alt="Avatar"></div>
                    </td>
                    <td width="80%">
                        <a href="/user/profile/${o.username}" class="text-muted small"
                           style="text-decoration: none">${o.first_name} ${o.last_name} @${o.username.toLowerCase()}</a><br>
                        <span onclick="follow('${o.username}')" class="pull-left btn btn-warning btn-sm" >+ <spring:message code='follow'/></span>
                    </td>
                </tr>
            </c:forEach>
        </table>
    </div>
    <br>
    <a href="/user" class="text-muted pull-left" style="text-decoration: none"><spring:message code='show_more_people'/></a>
</div>

<script>
    function follow(username) {
        $.ajax({
            url: '/addfollower/' + username,
            dataType: 'text',
            type: 'GET',
            success: function () {
                location.reload();
            }
        });
    }
</script>