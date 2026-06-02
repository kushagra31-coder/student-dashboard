<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<%
    if (session.getAttribute("studentId") == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    } else {
        String role = (String) session.getAttribute("studentRole");
        if ("admin".equals(role)) {
            response.sendRedirect(request.getContextPath() + "/admin");
        } else {
            response.sendRedirect(request.getContextPath() + "/home");
        }
        return;
    }
%>

<%-- Include Header (navbar, meta, CSS) --%>
<%@ include file="/WEB-INF/views/header.jsp" %>

<!-- ============ PAGE WRAPPER ============ -->
<main class="page-wrapper">
    <!-- Fun Animations -->
    <div class="anim-rocket">🚀</div>
    <div class="anim-car">🏎️</div>

    <!-- ============ HERO SECTION ============ -->
    <section class="hero-section">
        <div class="container text-center">
            <h1 class="hero-title fade-in-up">
                Student Portfolio<br>
                <span class="gradient-text">Dashboard</span>
            </h1>
            <p class="hero-subtitle fade-in-up delay-1"
               data-phrases='["Where Ideas Become Reality", "Showcasing Student Excellence", "Code • Create • Innovate"]'>
                Where Ideas Become Reality<span class="typing-cursor"></span>
            </p>
            <div class="d-flex gap-3 justify-content-center flex-wrap fade-in-up delay-2">
                <a href="${pageContext.request.contextPath}/students" class="btn-glow">
                    <i class="bi bi-people-fill"></i> Meet Our Students
                </a>
                <a href="${pageContext.request.contextPath}/projects" class="btn-glow-outline">
                    <i class="bi bi-rocket-takeoff"></i> View Projects
                </a>
            </div>
        </div>
    </section>

    <!-- ============ STATS BAR ============ -->
    <section class="py-4">
        <div class="container">
            <div class="row g-4 justify-content-center">
                <div class="col-6 col-md-3 fade-in-up">
                    <div class="glass-card stat-card">
                        <div class="stat-number">3+</div>
                        <div class="stat-label">Students</div>
                    </div>
                </div>
                <div class="col-6 col-md-3 fade-in-up delay-1">
                    <div class="glass-card stat-card">
                        <div class="stat-number">6+</div>
                        <div class="stat-label">Projects</div>
                    </div>
                </div>
                <div class="col-6 col-md-3 fade-in-up delay-2">
                    <div class="glass-card stat-card">
                        <div class="stat-number">18+</div>
                        <div class="stat-label">Skills</div>
                    </div>
                </div>
                <div class="col-6 col-md-3 fade-in-up delay-3">
                    <div class="glass-card stat-card">
                        <div class="stat-number">5+</div>
                        <div class="stat-label">Certifications</div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- ============ STUDENTS SECTION ============ -->
    <section class="section-spacing" id="students-section">
        <div class="container">
            <div class="text-center mb-5">
                <h2 class="section-title fade-in-up">Our Students</h2>
                <p class="section-subtitle fade-in-up delay-1">Meet the talented minds behind extraordinary projects</p>
            </div>
            <div class="row row-cols-1 row-cols-md-2 row-cols-lg-3 g-4 justify-content-center stagger-children">
                <c:forEach var="student" items="${students}">
                    <%@ include file="/WEB-INF/views/student-card.jsp" %>
                </c:forEach>
            </div>
        </div>
    </section>

    <!-- ============ FEATURED PROJECTS ============ -->
    <section class="section-spacing" id="projects-section">
        <div class="container">
            <div class="text-center mb-5">
                <h2 class="section-title fade-in-up">Featured Projects</h2>
                <p class="section-subtitle fade-in-up delay-1">Innovative solutions built by our community</p>
            </div>
            <div class="row row-cols-1 row-cols-md-2 row-cols-lg-3 g-4 justify-content-center stagger-children">
                <c:forEach var="project" items="${projects}" begin="0" end="2">
                    <%@ include file="/WEB-INF/views/project-card.jsp" %>
                </c:forEach>
            </div>
            <div class="text-center mt-5 fade-in-up">
                <a href="${pageContext.request.contextPath}/projects" class="btn-glow-outline">
                    <i class="bi bi-grid me-1"></i>View All Projects
                </a>
            </div>
        </div>
    </section>

    <!-- ============ SKILLS SECTION ============ -->
    <section class="section-spacing" id="skills-section">
        <div class="container">
            <div class="text-center mb-5">
                <h2 class="section-title fade-in-up">Technical Skills</h2>
                <p class="section-subtitle fade-in-up delay-1">Technologies and tools we excel at</p>
            </div>
            <div class="row justify-content-center">
                <div class="col-lg-10">
                    <div class="glass-card p-4 p-md-5 fade-in-up">
                        <div class="row">
                            <c:forEach var="skill" items="${skills}">
                                <div class="col-md-6">
                                    <div class="skill-item">
                                        <div class="skill-header">
                                            <span class="skill-name"><c:out value="${skill.name}"/></span>
                                            <span class="skill-percentage"><c:out value="${skill.proficiencyPercent}"/>%</span>
                                        </div>
                                        <div class="skill-bar">
                                            <div class="skill-bar-fill" data-width="<c:out value='${skill.proficiencyPercent}'/>"></div>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- ============ CTA SECTION ============ -->
    <section class="section-spacing">
        <div class="container">
            <div class="cta-section glass-card p-5 text-center fade-in-up">
                <h2 class="section-title mb-3">Want to Collaborate?</h2>
                <p class="section-subtitle mb-4" style="margin-bottom: 2rem !important;">
                    We're always looking for exciting opportunities and partnerships.
                </p>
                <a href="${pageContext.request.contextPath}/contact" class="btn-glow">
                    <i class="bi bi-envelope-fill"></i> Get In Touch
                </a>
            </div>
        </div>
    </section>

</main>

<%@ include file="/WEB-INF/views/footer.jsp" %>
