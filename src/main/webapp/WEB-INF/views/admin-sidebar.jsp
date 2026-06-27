<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="sidebar glass-card">
    <div class="sidebar-brand">
        <span style="background: linear-gradient(135deg, #c9a84c, #00d4ff); -webkit-background-clip: text; -webkit-text-fill-color: transparent; font-size: 1.4rem; font-weight: 700;">Admin Panel</span>
    </div>
    <ul class="sidebar-nav">
        <li><a href="${pageContext.request.contextPath}/admin#students" class="sidebar-link active"><i class="bi bi-people"></i> Students</a></li>
        <li><a href="${pageContext.request.contextPath}/admin#logs" class="sidebar-link"><i class="bi bi-clock-history"></i> Login Logs</a></li>
        <li><a href="${pageContext.request.contextPath}/logout" class="sidebar-link logout"><i class="bi bi-box-arrow-right"></i> Logout</a></li>
    </ul>
</div>
