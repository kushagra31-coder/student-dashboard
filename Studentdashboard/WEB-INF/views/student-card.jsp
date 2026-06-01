<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<%-- Student Card Fragment — Used inside c:forEach var="student" --%>
<div class="col fade-in-up">
    <div class="glass-card student-card">
        <!-- Student Photo -->
        <div class="student-photo-wrapper">
            <c:choose>
                <c:when test="${not empty student.photoPath}">
                    <img src="${pageContext.request.contextPath}/<c:out value='${student.photoPath}'/>"
                         alt="<c:out value='${student.name}'/>"
                         loading="lazy">
                </c:when>
                <c:otherwise>
                    <img src="https://ui-avatars.com/api/?name=<c:out value='${student.name}'/>&background=7c3aed&color=fff&size=200"
                         alt="<c:out value='${student.name}'/>"
                         loading="lazy">
                </c:otherwise>
            </c:choose>
        </div>

        <!-- Student Info -->
        <h5 class="student-name"><c:out value="${student.name}"/></h5>
        <p class="student-role"><c:out value="${student.role}" default="Student"/></p>
        <p class="student-branch"><c:out value="${student.branch}"/></p>
        <p class="student-bio"><c:out value="${student.bio}"/></p>

        <!-- Social Links -->
        <div class="student-socials">
            <c:if test="${not empty student.githubUrl}">
                <a href="<c:out value='${student.githubUrl}'/>" target="_blank" rel="noopener"
                   class="btn-sm-glass" title="GitHub">
                    <i class="bi bi-github"></i>
                </a>
            </c:if>
            <c:if test="${not empty student.linkedinUrl}">
                <a href="<c:out value='${student.linkedinUrl}'/>" target="_blank" rel="noopener"
                   class="btn-sm-glass" title="LinkedIn">
                    <i class="bi bi-linkedin"></i>
                </a>
            </c:if>
            <c:if test="${not empty student.resumeUrl}">
                <a href="<c:out value='${student.resumeUrl}'/>" target="_blank" rel="noopener"
                   class="btn-sm-glass" title="Resume">
                    <i class="bi bi-file-earmark-person"></i>
                </a>
            </c:if>
        </div>
    </div>
</div>
