<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="sidebar glass-card">
    <div class="sidebar-brand">
        <span style="background: linear-gradient(135deg, #c9a84c, #00d4ff); -webkit-background-clip: text; -webkit-text-fill-color: transparent; font-size: 1.4rem; font-weight: 700;">Admin Panel</span>
    </div>
    <ul class="sidebar-nav">
        <li><a href="${pageContext.request.contextPath}/admin" class="sidebar-link active"><i class="bi bi-speedometer2"></i> Dashboard</a></li>
        <li><a href="${pageContext.request.contextPath}/admin#students" class="sidebar-link"><i class="bi bi-people"></i> Students</a></li>
        <li><a href="${pageContext.request.contextPath}/admin#logs" class="sidebar-link"><i class="bi bi-clock-history"></i> Login Logs</a></li>
        <li><a href="${pageContext.request.contextPath}/admin#placements" class="sidebar-link"><i class="bi bi-briefcase"></i> Placements</a></li>
        <li><a href="${pageContext.request.contextPath}/admin#attendance" class="sidebar-link"><i class="bi bi-calendar-check"></i> Attendance</a></li>
        <li><a href="${pageContext.request.contextPath}/admin#documents" class="sidebar-link"><i class="bi bi-file-earmark-text"></i> Documents</a></li>
        <li><a href="${pageContext.request.contextPath}/logout" class="sidebar-link logout"><i class="bi bi-box-arrow-right"></i> Logout</a></li>
    </ul>
</div>

<!-- Theme Toggle -->
<button id="theme-toggle" class="btn btn-outline-light position-fixed top-0 end-0 m-3" style="z-index: 1050; border-radius: 50%; width: 45px; height: 45px; background: rgba(255,255,255,0.1); backdrop-filter: blur(10px);"><i class="bi bi-moon-fill"></i></button>
