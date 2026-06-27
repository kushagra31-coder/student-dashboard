<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>

<%-- Include Header --%>
<%@ include file="/WEB-INF/views/header.jsp" %>

<!-- ============ PAGE WRAPPER ============ -->
<main class="page-wrapper">

    <!-- ============ PAGE HEADER ============ -->
    <section class="page-header">
        <div class="container text-center">
            <h1 class="section-title fade-in-up">
                <i class="bi bi-code-square me-2"></i>All Projects
            </h1>
            <p class="section-subtitle fade-in-up delay-1">
                Explore all the innovative projects built by our community
            </p>
        </div>
    </section>

    <!-- ============ PROJECTS GRID ============ -->
    <section class="pb-5">
        <div class="container">
            <c:choose>
                <c:when test="${not empty projects}">
                    <div class="row row-cols-1 row-cols-md-2 row-cols-lg-3 g-4 justify-content-center stagger-children">
                        <c:forEach var="project" items="${projects}">
                            <%@ include file="/WEB-INF/views/project-card.jsp" %>
                        </c:forEach>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="text-center py-5">
                        <div class="glass-card p-5 d-inline-block fade-in-up">
                            <i class="bi bi-folder-x" style="font-size: 3rem; color: var(--text-muted);"></i>
                            <h4 class="mt-3">No Projects Found</h4>
                            <p class="text-muted">Check back later for new projects.</p>
                        </div>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </section>

</main>

<%@ include file="/WEB-INF/views/footer.jsp" %>
