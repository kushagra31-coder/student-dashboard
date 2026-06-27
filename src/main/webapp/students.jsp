<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<%-- Include Header --%>
<%@ include file="/WEB-INF/views/header.jsp" %>
<main class="page-wrapper">

    <section class="page-header">
        <div class="container text-center">
            <h1 class="section-title fade-in-up">
                <i class="bi bi-people-fill me-2"></i>Our Students
            </h1>
            <p class="section-subtitle fade-in-up delay-1">
                Meet the talented minds behind our extraordinary projects
            </p>
        </div>
    </section>

    <section class="pb-5">
        <div class="container">
            <c:choose>
                <c:when test="${not empty students}">
                    <div class="row row-cols-1 row-cols-md-2 row-cols-lg-3 g-4 justify-content-center stagger-children">
                        <c:forEach var="student" items="${students}">
                            <%@ include file="/WEB-INF/views/student-card.jsp" %>
                        </c:forEach>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="text-center py-5">
                        <div class="glass-card p-5 d-inline-block fade-in-up">
                            <i class="bi bi-person-x" style="font-size: 3rem; color: var(--text-muted);"></i>
                            <h4 class="mt-3">No Students Found</h4>
                            <p class="text-muted">Check back later for new student profiles.</p>
                        </div>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </section>

</main>

<%@ include file="/WEB-INF/views/footer.jsp" %>
