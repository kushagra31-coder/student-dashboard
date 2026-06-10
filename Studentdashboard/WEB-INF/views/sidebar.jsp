<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="sidebar glass-card">
    <div class="sidebar-brand">
        <span class="gradient-text">SpaceDash</span>
    </div>
    <ul class="sidebar-nav">
        <li><a href="${pageContext.request.contextPath}/home" class="sidebar-link active"><i class="bi bi-house-door"></i> Home</a></li>
        <li><a href="${pageContext.request.contextPath}/documents" class="sidebar-link"><i class="bi bi-file-earmark-text"></i> Documents</a></li>
        <li><a href="${pageContext.request.contextPath}/home#projects" class="sidebar-link"><i class="bi bi-rocket"></i> Projects</a></li>
        <li><a href="${pageContext.request.contextPath}/contact" class="sidebar-link"><i class="bi bi-envelope"></i> Contact</a></li>
        <li><a href="${pageContext.request.contextPath}/logout" class="sidebar-link logout"><i class="bi bi-box-arrow-right"></i> Logout</a></li>
    </ul>
</div>
