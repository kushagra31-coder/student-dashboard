<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>

<%-- Project Card — Text-focused with description + GitHub link --%>
<div class="col fade-in-up">
    <div class="glass-card project-card h-100">
     
        <div class="project-accent-bar"></div>

        <div class="project-body">
          
            <div class="project-header-row">
                <div class="project-icon-wrap">
                    <i class="bi bi-folder-fill"></i>
                </div>
                <div class="project-header-text">
                    <h5 class="project-title"><c:out value="${project.title}"/></h5>
                </div>
            </div>

          
            <p class="project-description"><c:out value="${project.description}"/></p>

           
            <div class="tech-stack">
                <c:forEach var="tech" items="${fn:split(project.techStack, ',')}">
                    <span class="tech-badge"><c:out value="${fn:trim(tech)}"/></span>
                </c:forEach>
            </div>

           
            <div class="project-links mt-auto">
                <c:if test="${not empty project.githubUrl}">
                    <a href="<c:out value='${project.githubUrl}'/>" target="_blank" rel="noopener"
                       class="btn-glow-outline">
                        <i class="bi bi-github me-1"></i>View Source
                    </a>
                </c:if>
                <c:if test="${not empty project.liveDemoUrl && project.liveDemoUrl != '#'}">
                    <a href="<c:out value='${project.liveDemoUrl}'/>" target="_blank" rel="noopener"
                       class="btn-glow-outline">
                        <i class="bi bi-box-arrow-up-right me-1"></i>Live Demo
                    </a>
                </c:if>
            </div>
        </div>
    </div>
</div>
