<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<%--MODAL CSS--%>
<div id="myModal" class="mmodalDialog">
    <div>
        <div class="media-body">
            <a href="${pageContext.request.contextPath}/user/profile/" title="<spring:message code='close'/>"
               class="cclose"
               style="text-decoration: none">x</a>

            <form action="/user/profile/edittweet/${id}" method="post">
                <input type="hidden"
                       name="${_csrf.parameterName}"
                       value="${_csrf.token}"/>
                <input type="hidden" id="id" name="id"/>
                                                        <span class="reply_text"
                                                              style="text-align: left; font-weight: bold">${t.user.username}</span>
                <section id="editable" contenteditable="true">
                                                    <textarea id="tweet" maxlength=140; rows="3"
                                                              style="font-size:large; border-color: steelblue; overflow: hidden; height: auto;
                                                              box-shadow: none; resize: none; padding: 10px"
                                                              name="text" class="form-control"
                                                              required>${thisTweet.text}</textarea>
                </section>
                <p></p>
                <input type="hidden" id="tweet-id" value="${thisTweet.id}">
                <c:if test="${thisTweet.image!=null}">
                    <c:if test="${!thisTweet.image.equals('')}">
                    <span width="80%" class="pull-right" style="padding-bottom: 10px">
                    <img width="100%" src="<c:url value="/images/" />${thisTweet.image}">
                    </span>
                    </c:if>
                </c:if>
                <p></p>

                <div>
                    <button type="submit" value="Save"
                            class="btn btn-warning btn-sm pull-right"><spring:message code='save_changes'/>
                    </button>
                </div>
                <br>
            </form>
        </div>
    </div>
</div>
