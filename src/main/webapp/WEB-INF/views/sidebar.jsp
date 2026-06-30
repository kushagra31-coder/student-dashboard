<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<nav class="nb-sidebar">
  <!-- Brand -->
  <div class="nb-sidebar-brand">
    AITR DASH
  </div>

  <!-- Nav -->
  <ul class="list-unstyled">
    <li>
      <a href="${pageContext.request.contextPath}/home"
         class="nb-sidebar-link ${pageContext.request.servletPath == '/home' ? 'active' : ''}">
        <i class="bi bi-house-fill me-2"></i> Dashboard
      </a>
    </li>
    <li>
      <a href="${pageContext.request.contextPath}/documents"
         class="nb-sidebar-link ${pageContext.request.servletPath == '/documents' ? 'active' : ''}">
        <i class="bi bi-file-earmark-text-fill me-2"></i> Documents
      </a>
    </li>
    <li>
      <a href="${pageContext.request.contextPath}/home#projects" class="nb-sidebar-link">
        <i class="bi bi-rocket-fill me-2"></i> Projects
      </a>
    </li>
    <li>
      <a href="${pageContext.request.contextPath}/home#achievements" class="nb-sidebar-link">
        <i class="bi bi-trophy-fill me-2"></i> Achievements
      </a>
    </li>
    <li class="my-4" style="border-top: 4px dashed var(--border-default);"></li>
    <li>
      <a href="${pageContext.request.contextPath}/logout" class="nb-sidebar-link mt-auto">
        <i class="bi bi-box-arrow-right me-2"></i> Logout
      </a>
    </li>
  </ul>
</nav>