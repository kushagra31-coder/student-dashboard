<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="sidebar glass-card">
    <div class="sidebar-brand">
        <span class="gradient-text">SpaceDash</span>
    </div>
    <ul class="sidebar-nav">
        <li><a href="${pageContext.request.contextPath}/home" class="sidebar-link active"><i class="bi bi-house-door"></i> Home</a></li>
        <li><a href="${pageContext.request.contextPath}/documents" class="sidebar-link"><i class="bi bi-file-earmark-text"></i> Documents</a></li>
        <li><a href="${pageContext.request.contextPath}/projects" class="sidebar-link"><i class="bi bi-kanban"></i> Projects</a></li>
        <li><a href="${pageContext.request.contextPath}/logout" class="sidebar-link logout"><i class="bi bi-box-arrow-right"></i> Logout</a></li>
    </ul>
</div>

<!-- Theme Toggle -->
<button id="theme-toggle" class="btn btn-outline-light position-fixed top-0 end-0 m-3" style="z-index: 1050; border-radius: 50%; width: 45px; height: 45px; background: rgba(255,255,255,0.1); backdrop-filter: blur(10px);"><i class="bi bi-moon-fill"></i></button>
