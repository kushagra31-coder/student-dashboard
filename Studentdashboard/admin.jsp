<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Audiowide&family=JetBrains+Mono:wght@400;500;700&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
    <link rel="stylesheet" href="css/style.css">
    <style>
        /* ── Attendance table ─────────────────────────────── */
        .att-table th, .att-table td { vertical-align: middle; font-size: 0.82rem; }
        .att-badge {
            display: inline-block;
            padding: 3px 10px;
            border-radius: 20px;
            font-weight: 700;
            font-size: 0.78rem;
        }
        .att-high   { background: rgba(22,163,74,0.18);  color: #4ade80; border: 1px solid #4ade80; }
        .att-mid    { background: rgba(217,119,6,0.18);  color: #fbbf24; border: 1px solid #fbbf24; }
        .att-low    { background: rgba(220,53,69,0.18);  color: #f87171; border: 1px solid #f87171; }

        /* Inline edit inputs inside attendance table */
        .att-input {
            width: 58px;
            background: var(--surface-2, #1a1a2e);
            border: 1px solid var(--border, #2a2a3e);
            color: var(--text, #e8e8f0);
            border-radius: 4px;
            padding: 3px 6px;
            font-size: 0.8rem;
            text-align: center;
        }

        /* Tab nav */
        .admin-tabs .nav-link { font-family: 'JetBrains Mono', monospace; font-size: 0.82rem; }
        .admin-tabs .nav-link.active { background: var(--primary, #db2777) !important; color: #fff !important; border-color: var(--primary, #db2777) !important; }

        /* Delete btn */
        .btn-delete { padding: 3px 10px; font-size: 0.76rem; }
    </style>
</head>
<body class="dashboard-body">

    <jsp:include page="/WEB-INF/views/admin-sidebar.jsp"/>

    <div class="dashboard-main">
        <div class="container-fluid py-4 px-4">

            <%-- Success banner --%>
            <c:if test="${param.success == 'true'}">
                <div class="alert alert-success alert-dismissible fade show mb-3"
                     style="background:rgba(22,163,74,0.15);color:#4ade80;border:1px solid #4ade80;">
                    Action completed successfully!
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            </c:if>

            <%-- Header card --%>
            <div class="retro-window mb-4 text-center" style="padding:28px;">
                <h1 style="font-family:'Audiowide',cursive;font-size:1.8rem;" class="text-gradient">Acropolis Institute</h1>
                <h5 class="text-secondary mb-2">AITR — Centralized Administration</h5>
                <p class="text-muted" style="font-size:0.85rem;font-style:italic;">
                    "Empowering the next generation of innovators and leaders."
                </p>
            </div>

            <%-- Tab nav --%>
            <ul class="nav nav-tabs admin-tabs mb-4" id="adminTabs">
                <li class="nav-item">
                    <a class="nav-link ${activeTab == 'students' ? 'active' : ''}"
                       href="#tab-students" data-bs-toggle="tab">
                        <i class="bi bi-people-fill me-1"></i> Students
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link ${activeTab == 'attendance' ? 'active' : ''}"
                       href="#tab-attendance" data-bs-toggle="tab">
                        <i class="bi bi-calendar-check me-1"></i> Attendance
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link ${activeTab == 'logs' ? 'active' : ''}"
                       href="#tab-logs" data-bs-toggle="tab">
                        <i class="bi bi-journal-text me-1"></i> Login Logs
                    </a>
                </li>
            </ul>

            <div class="tab-content">

                <%-- ════════════════════════════════════════════════
                     TAB 1 — STUDENTS
                ════════════════════════════════════════════════ --%>
                <div class="tab-pane fade ${activeTab == 'students' ? 'show active' : ''}" id="tab-students">
                    <div class="retro-window">
                        <div class="retro-window-header">
                            <span class="retro-window-title"><i class="bi bi-people-fill me-2"></i>Student Records</span>
                        </div>
                        <div class="retro-window-body p-3">
                            <div class="accordion" id="studentAccordion">
                                <c:forEach var="student" items="${students}">
                                    <div class="accordion-item mb-3"
                                         style="background:var(--surface-2,#1a1a2e);border:1px solid var(--border,#2a2a3e);border-radius:6px;">
                                        <h2 class="accordion-header">
                                            <button class="accordion-button collapsed"
                                                    type="button"
                                                    data-bs-toggle="collapse"
                                                    data-bs-target="#col${student.id}"
                                                    style="background:transparent;color:var(--text,#e8e8f0);border:none;">
                                                <strong class="text-gradient me-2">${student.name}</strong>
                                                <span class="text-muted" style="font-size:0.82rem;">
                                                    ${student.branch} &nbsp;·&nbsp; Sem ${student.semester}
                                                    &nbsp;·&nbsp; ID: <code>${student.id}</code>
                                                </span>
                                            </button>
                                        </h2>
                                        <div id="col${student.id}" class="accordion-collapse collapse">
                                            <div class="accordion-body">
                                                <div class="row g-3 mb-3">
                                                    <div class="col-md-6">
                                                        <small class="text-muted d-block"><i class="bi bi-envelope me-1"></i>${student.email}</small>
                                                        <small class="text-muted d-block"><i class="bi bi-phone me-1"></i>${empty student.phone ? '—' : student.phone}</small>
                                                    </div>
                                                    <div class="col-md-6 text-md-end">
                                                        <%-- Delete student --%>
                                                        <form action="${pageContext.request.contextPath}/student-action"
                                                              method="post"
                                                              onsubmit="return confirm('Delete ${student.name}? This cannot be undone.');">
                                                            <input type="hidden" name="action" value="delete">
                                                            <input type="hidden" name="studentId" value="${student.id}">
                                                            <button type="submit" class="btn btn-danger btn-delete">
                                                                <i class="bi bi-trash me-1"></i>Delete Student
                                                            </button>
                                                        </form>
                                                    </div>
                                                </div>

                                                <div class="row g-3">
                                                    <div class="col-md-6">
                                                        <h6 style="color:#06b6d4;font-size:0.8rem;text-transform:uppercase;letter-spacing:1px;">
                                                            <i class="bi bi-people me-1"></i>Clubs
                                                        </h6>
                                                        <c:forEach var="cl" items="${studentClubs[student.id]}">
                                                            <span class="badge me-1 mb-1"
                                                                  style="background:rgba(6,182,212,0.15);color:#06b6d4;border:1px solid rgba(6,182,212,0.3);">
                                                                ${cl.name} (${cl.role})
                                                            </span>
                                                        </c:forEach>
                                                        <c:if test="${empty studentClubs[student.id]}">
                                                            <small class="text-muted">None</small>
                                                        </c:if>
                                                    </div>
                                                    <div class="col-md-6">
                                                        <h6 style="color:#3b82f6;font-size:0.8rem;text-transform:uppercase;letter-spacing:1px;">
                                                            <i class="bi bi-code-slash me-1"></i>Skills
                                                        </h6>
                                                        <c:forEach var="sk" items="${studentSkills[student.id]}">
                                                            <span class="badge me-1 mb-1"
                                                                  style="background:rgba(59,130,246,0.15);color:#3b82f6;border:1px solid rgba(59,130,246,0.3);">
                                                                ${sk.name} ${sk.proficiencyPercent}%
                                                            </span>
                                                        </c:forEach>
                                                        <c:if test="${empty studentSkills[student.id]}">
                                                            <small class="text-muted">None</small>
                                                        </c:if>
                                                    </div>
                                                    <div class="col-md-4">
                                                        <h6 style="color:#4ade80;font-size:0.8rem;text-transform:uppercase;letter-spacing:1px;">
                                                            <i class="bi bi-rocket me-1"></i>Projects
                                                        </h6>
                                                        <c:forEach var="p" items="${studentProjects[student.id]}">
                                                            <div style="font-size:0.82rem;">— ${p.title}</div>
                                                        </c:forEach>
                                                        <c:if test="${empty studentProjects[student.id]}">
                                                            <small class="text-muted">None</small>
                                                        </c:if>
                                                    </div>
                                                    <div class="col-md-4">
                                                        <h6 style="color:#fbbf24;font-size:0.8rem;text-transform:uppercase;letter-spacing:1px;">
                                                            <i class="bi bi-file-earmark-text me-1"></i>Documents
                                                        </h6>
                                                        <c:forEach var="d" items="${studentDocuments[student.id]}">
                                                            <div style="font-size:0.82rem;">— ${d.title}</div>
                                                        </c:forEach>
                                                        <c:if test="${empty studentDocuments[student.id]}">
                                                            <small class="text-muted">None</small>
                                                        </c:if>
                                                    </div>
                                                    <div class="col-md-4">
                                                        <h6 style="color:#a78bfa;font-size:0.8rem;text-transform:uppercase;letter-spacing:1px;">
                                                            <i class="bi bi-award me-1"></i>Certificates
                                                        </h6>
                                                        <c:forEach var="cert" items="${studentCertificates[student.id]}">
                                                            <div style="font-size:0.82rem;">— ${cert.title}</div>
                                                        </c:forEach>
                                                        <c:if test="${empty studentCertificates[student.id]}">
                                                            <small class="text-muted">None</small>
                                                        </c:if>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                        </div>
                    </div>
                </div>

                <%-- ════════════════════════════════════════════════
                     TAB 2 — ATTENDANCE
                ════════════════════════════════════════════════ --%>
                <div class="tab-pane fade ${activeTab == 'attendance' ? 'show active' : ''}" id="tab-attendance">
                    <div class="retro-window">
                        <div class="retro-window-header">
                            <span class="retro-window-title">
                                <i class="bi bi-calendar-check me-2"></i>
                                Attendance Sheet — RGPV 4th Sem CSIT
                            </span>
                            <small class="text-muted" style="font-size:0.75rem;">
                                Click a row to edit · Changes save instantly
                            </small>
                        </div>
                        <div class="retro-window-body p-3" style="overflow-x:auto;">
                            <table class="table att-table table-bordered table-hover mb-0">
                                <thead>
                                    <tr style="background:var(--surface-2,#1a1a2e);">
                                        <th style="min-width:130px;">Student</th>
                                        <th>ID</th>
                                        <c:forEach var="sub" items="${subjects}">
                                            <th class="text-center" style="min-width:150px;">${sub}</th>
                                        </c:forEach>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="student" items="${students}">
                                        <tr>
                                            <td><strong>${student.name}</strong></td>
                                            <td><code style="font-size:0.78rem;">${student.id}</code></td>
                                            <c:forEach var="sub" items="${subjects}">
                                                <td class="text-center">
                                                    <c:set var="att" value="${allAttendance[student.id][sub]}"/>
                                                    <c:choose>
                                                        <c:when test="${att != null}">
                                                            <%-- Inline edit form --%>
                                                            <form action="${pageContext.request.contextPath}/attendance"
                                                                  method="post"
                                                                  class="d-inline-flex flex-column align-items-center gap-1"
                                                                  style="min-width:120px;">
                                                                <input type="hidden" name="studentId" value="${student.id}">
                                                                <input type="hidden" name="subject"   value="${sub}">
                                                                <div class="d-flex align-items-center gap-1" style="font-size:0.76rem;color:var(--text-muted,#7070a0);">
                                                                    <span>Att</span>
                                                                    <input type="number" name="attended"
                                                                           class="att-input"
                                                                           value="${att.attended}"
                                                                           min="0" max="${att.totalClasses}">
                                                                    <span>/</span>
                                                                    <input type="number" name="totalClasses"
                                                                           class="att-input"
                                                                           value="${att.totalClasses}"
                                                                           min="1">
                                                                </div>
                                                                <%-- Badge showing % --%>
                                                                <c:set var="pct" value="${att.percentage}"/>
                                                                <span class="att-badge ${pct >= 75 ? 'att-high' : (pct >= 60 ? 'att-mid' : 'att-low')}">
                                                                    ${pct}%
                                                                </span>
                                                                <button type="submit"
                                                                        class="btn btn-sm"
                                                                        style="font-size:0.7rem;padding:2px 8px;background:rgba(219,39,119,0.15);color:#db2777;border:1px solid rgba(219,39,119,0.3);">
                                                                    Save
                                                                </button>
                                                            </form>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <small class="text-muted">—</small>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>
                                            </c:forEach>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>

                    <%-- Legend --%>
                    <div class="d-flex gap-3 mt-2 flex-wrap" style="font-size:0.78rem;">
                        <span class="att-badge att-high">≥75% — Safe</span>
                        <span class="att-badge att-mid">60–74% — Warning</span>
                        <span class="att-badge att-low">&lt;60% — Detained</span>
                    </div>
                </div>

                <%-- ════════════════════════════════════════════════
                     TAB 3 — LOGIN LOGS
                ════════════════════════════════════════════════ --%>
                <div class="tab-pane fade ${activeTab == 'logs' ? 'show active' : ''}" id="tab-logs">
                    <div class="retro-window">
                        <div class="retro-window-header">
                            <span class="retro-window-title"><i class="bi bi-journal-text me-2"></i>System Login Logs</span>
                        </div>
                        <div class="retro-window-body p-3" style="max-height:450px;overflow-y:auto;">
                            <table class="table table-hover table-bordered mb-0" style="font-size:0.83rem;">
                                <thead style="background:var(--surface-2,#1a1a2e);">
                                    <tr>
                                        <th>Time</th>
                                        <th>User</th>
                                        <th>Role</th>
                                        <th>IP</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="log" items="${loginLogs}">
                                        <tr>
                                            <td><code style="font-size:0.75rem;">${log.loginTime}</code></td>
                                            <td>${log.userName}</td>
                                            <td>
                                                <span class="badge ${log.role == 'admin' ? 'bg-danger' : 'bg-primary'}">
                                                    ${log.role}
                                                </span>
                                            </td>
                                            <td><small>${log.ipAddress}</small></td>
                                        </tr>
                                    </c:forEach>
                                    <c:if test="${empty loginLogs}">
                                        <tr><td colspan="4" class="text-center text-muted">No logs yet</td></tr>
                                    </c:if>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>

            </div><%-- end tab-content --%>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Auto-activate the correct tab from URL param
        const activeTab = "${activeTab}";
        if (activeTab && activeTab !== 'students') {
            const el = document.querySelector('[href="#tab-' + activeTab + '"]');
            if (el) el.click();
        }

        // Live % badge update when inputs change
        document.querySelectorAll('.att-table tr').forEach(row => {
            const forms = row.querySelectorAll('form');
            forms.forEach(form => {
                const attIn   = form.querySelector('[name="attended"]');
                const totIn   = form.querySelector('[name="totalClasses"]');
                const badge   = form.querySelector('.att-badge');
                if (!attIn || !totIn || !badge) return;

                function refreshBadge() {
                    let att = parseInt(attIn.value) || 0;
                    let tot = parseInt(totIn.value) || 1;
                    if (att > tot) { attIn.value = tot; att = tot; }
                    const pct = Math.round(att * 1000 / tot) / 10;
                    badge.textContent = pct + '%';
                    badge.className = 'att-badge ' +
                        (pct >= 75 ? 'att-high' : pct >= 60 ? 'att-mid' : 'att-low');
                }
                attIn.addEventListener('input', refreshBadge);
                totIn.addEventListener('input', refreshBadge);
            });
        });
    </script>
</body>
</html>
