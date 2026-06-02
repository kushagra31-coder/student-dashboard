<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard</title>
    <!-- Google Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Audiowide&family=Rajdhani:wght@500;600;700&family=JetBrains+Mono:wght@400;500&display=swap" rel="stylesheet">
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <link rel="stylesheet" href="css/style.css">
    <style>
        .badge-placed { background: rgba(57, 255, 20, 0.12); color: var(--accent-green); border: 1.5px solid var(--accent-green); font-family: 'JetBrains Mono', monospace; font-size: 0.8rem; }
        .badge-interviewing { background: rgba(0, 242, 254, 0.12); color: var(--accent-blue); border: 1.5px solid var(--accent-blue); font-family: 'JetBrains Mono', monospace; font-size: 0.8rem; }
        .badge-offered { background: rgba(255, 158, 0, 0.12); color: var(--accent-orange); border: 1.5px solid var(--accent-orange); font-family: 'JetBrains Mono', monospace; font-size: 0.8rem; }
        .stat-overview { display: grid; grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); gap: 1.5rem; margin-bottom: 2.5rem; }
        .stat-overview .retro-window-body { padding: 1.5rem; text-align: center; }
        .stat-overview .stat-icon { font-size: 2.2rem; margin-bottom: 0.5rem; text-shadow: 0 0 10px rgba(0,242,254,0.3); }
        .stat-overview .stat-val { font-size: 2.5rem; font-weight: bold; font-family: 'JetBrains Mono', monospace; }
        .stat-overview .stat-lbl { color: var(--text-muted); font-size: 0.85rem; font-family: 'Audiowide', sans-serif; text-transform: uppercase; letter-spacing: 1px; }
        .attendance-bar { height: 10px; border-radius: 2px; background: rgba(0, 0, 0, 0.4); border: 1px solid var(--glass-border); overflow: hidden; }
        .attendance-bar-fill { height: 100%; border-radius: 1px; transition: width 0.6s ease; }
        .attendance-good { background: linear-gradient(90deg, var(--accent-green), var(--accent-blue)); }
        .attendance-warn { background: linear-gradient(90deg, var(--accent-orange), var(--accent-pink)); }
    </style>
</head>
<body class="dashboard-body">
    <!-- CRT Monitor Scanlines -->
    <div class="crt-overlay"></div>

    <!-- Synthwave Grid Canvas -->
    <canvas id="particle-canvas"></canvas>
    <jsp:include page="/WEB-INF/views/admin-sidebar.jsp" />

    <div class="dashboard-main">
        <div class="container-fluid py-4 px-4">

            <!-- Header -->
            <div class="mb-4 reveal">
                <h1 class="text-gradient" style="font-size: 2.2rem; display: inline-block;">Admin Dashboard</h1>
                <p class="text-secondary" style="font-size: 1.15rem;">Manage students, track attendance, and monitor telemetry logs</p>
            </div>

            <!-- Stats Overview -->
            <div class="stat-overview reveal">
                <div class="retro-window">
                    <div class="retro-window-header">
                        <span class="retro-window-title">Metric: STU</span>
                        <div class="retro-window-dots"><span class="retro-window-dot close"></span></div>
                    </div>
                    <div class="retro-window-body">
                        <div class="stat-icon" style="color: var(--accent-blue);"><i class="bi bi-people-fill"></i></div>
                        <div class="stat-val text-gradient">${fn:length(students)}</div>
                        <div class="stat-lbl">Students</div>
                    </div>
                </div>
                <div class="retro-window">
                    <div class="retro-window-header">
                        <span class="retro-window-title">Metric: LOG</span>
                        <div class="retro-window-dots"><span class="retro-window-dot minimize"></span></div>
                    </div>
                    <div class="retro-window-body">
                        <div class="stat-icon" style="color: var(--accent-pink);"><i class="bi bi-clock-history"></i></div>
                        <div class="stat-val text-gradient">${fn:length(loginLogs)}</div>
                        <div class="stat-lbl">Login Events</div>
                    </div>
                </div>
                <div class="retro-window">
                    <div class="retro-window-header">
                        <span class="retro-window-title">Metric: PLC</span>
                        <div class="retro-window-dots"><span class="retro-window-dot maximize"></span></div>
                    </div>
                    <div class="retro-window-body">
                        <div class="stat-icon" style="color: var(--accent-green);"><i class="bi bi-briefcase-fill"></i></div>
                        <div class="stat-val text-gradient">${fn:length(placements)}</div>
                        <div class="stat-lbl">Placements</div>
                    </div>
                </div>
                <div class="retro-window">
                    <div class="retro-window-header">
                        <span class="retro-window-title">Metric: DOC</span>
                        <div class="retro-window-dots"><span class="retro-window-dot close"></span></div>
                    </div>
                    <div class="retro-window-body">
                        <div class="stat-icon" style="color: var(--accent-orange);"><i class="bi bi-file-earmark-text-fill"></i></div>
                        <div class="stat-val text-gradient">${fn:length(allDocuments)}</div>
                        <div class="stat-lbl">Documents</div>
                    </div>
                </div>
            </div>

            <!-- Students Section -->
            <div id="students" class="mb-5 reveal">
                <div class="retro-window">
                    <div class="retro-window-header">
                        <span class="retro-window-title"><i class="bi bi-people me-2"></i>Student Records</span>
                        <div class="retro-window-dots">
                            <span class="retro-window-dot close"></span>
                            <span class="retro-window-dot minimize"></span>
                            <span class="retro-window-dot maximize"></span>
                        </div>
                    </div>
                    <div class="retro-window-body">
                        <div class="admin-table-container">
                            <table class="admin-table">
                                <thead><tr><th>ID</th><th>Name</th><th>Branch</th><th>Semester</th><th>Role</th><th>GitHub</th></tr></thead>
                                <tbody>
                                    <c:forEach var="s" items="${students}">
                                        <c:if test="${s.role != 'admin'}">
                                        <tr>
                                            <td style="font-family: 'JetBrains Mono', monospace;">#${s.id}</td>
                                            <td style="font-weight: 600;">${s.name}</td>
                                            <td>${s.branch}</td>
                                            <td style="font-family: 'JetBrains Mono', monospace;">Sem ${s.semester}</td>
                                            <td><span class="badge" style="background: rgba(0, 242, 254, 0.1); color: var(--accent-blue); border: 1px solid var(--accent-blue);">${s.role}</span></td>
                                            <td>
                                                <c:if test="${not empty s.githubUrl && s.githubUrl != '#'}">
                                                    <a href="${s.githubUrl}" target="_blank" class="btn-sm-glass" style="width: 32px; height: 32px; font-size: 0.9rem;"><i class="bi bi-github"></i></a>
                                                </c:if>
                                            </td>
                                        </tr>
                                        </c:if>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Login Logs Section -->
            <div id="logs" class="mb-5 reveal">
                <div class="retro-window">
                    <div class="retro-window-header">
                        <span class="retro-window-title"><i class="bi bi-clock-history me-2"></i>Login Activity Logs</span>
                        <div class="retro-window-dots">
                            <span class="retro-window-dot close"></span>
                            <span class="retro-window-dot minimize"></span>
                            <span class="retro-window-dot maximize"></span>
                        </div>
                    </div>
                    <div class="retro-window-body">
                        <c:choose>
                            <c:when test="${empty loginLogs}">
                                <p class="text-secondary text-center py-4">No login activity telemetry recorded yet.</p>
                            </c:when>
                            <c:otherwise>
                                <div class="admin-table-container">
                                    <table class="admin-table">
                                        <thead><tr><th>User (ID)</th><th>Role</th><th>Login Timestamp</th></tr></thead>
                                        <tbody>
                                            <c:forEach var="log" items="${loginLogs}" begin="0" end="4">
                                                <tr>
                                                    <td>${log.userName} <span class="text-muted" style="font-family: 'JetBrains Mono', monospace;">(ID: ${log.userId})</span></td>
                                                    <td><span class="badge" style="background: rgba(255, 0, 127, 0.1); color: var(--accent-pink); border: 1px solid var(--accent-pink);">${log.role}</span></td>
                                                    <td style="font-family: 'JetBrains Mono', monospace;">${log.loginTime}</td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                        <c:if test="${fn:length(loginLogs) > 5}">
                                            <tbody class="collapse" id="olderLogs">
                                                <c:forEach var="log" items="${loginLogs}" begin="5">
                                                    <tr>
                                                        <td>${log.userName} <span class="text-muted" style="font-family: 'JetBrains Mono', monospace;">(ID: ${log.userId})</span></td>
                                                        <td><span class="badge" style="background: rgba(255, 0, 127, 0.1); color: var(--accent-pink); border: 1px solid var(--accent-pink);">${log.role}</span></td>
                                                        <td style="font-family: 'JetBrains Mono', monospace;">${log.loginTime}</td>
                                                    </tr>
                                                </c:forEach>
                                            </tbody>
                                        </c:if>
                                    </table>
                                </div>
                                <c:if test="${fn:length(loginLogs) > 5}">
                                    <div class="text-center mt-3">
                                        <button class="btn-retro btn-retro-cyan btn-sm" type="button" data-bs-toggle="collapse" data-bs-target="#olderLogs" aria-expanded="false">
                                            <span>Show Older Logs</span>
                                        </button>
                                    </div>
                                </c:if>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>

            <!-- Placements Section -->
            <div id="placements" class="mb-5 reveal">
                <div class="retro-window">
                    <div class="retro-window-header">
                        <span class="retro-window-title"><i class="bi bi-briefcase me-2"></i>Placement Telemetry</span>
                        <div class="retro-window-dots">
                            <span class="retro-window-dot close"></span>
                            <span class="retro-window-dot minimize"></span>
                            <span class="retro-window-dot maximize"></span>
                        </div>
                    </div>
                    <div class="retro-window-body">
                        <div class="admin-table-container">
                            <table class="admin-table">
                                <thead><tr><th>Student ID</th><th>Company</th><th>Role</th><th>Package</th><th>Status</th><th>Date</th></tr></thead>
                                <tbody>
                                    <c:forEach var="p" items="${placements}">
                                        <tr>
                                            <td style="font-family: 'JetBrains Mono', monospace;">#${p.studentId}</td>
                                            <td style="font-weight: 600;">${p.company}</td>
                                            <td>${p.role}</td>
                                            <td style="color: var(--accent-green); font-weight: 700; font-family: 'JetBrains Mono', monospace;">${p.packageLpa} LPA</td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${p.status == 'placed'}"><span class="badge badge-placed">Placed</span></c:when>
                                                    <c:when test="${p.status == 'interviewing'}"><span class="badge badge-interviewing">Interviewing</span></c:when>
                                                    <c:when test="${p.status == 'offered'}"><span class="badge badge-offered">Offered</span></c:when>
                                                    <c:otherwise><span class="badge">${p.status}</span></c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td style="font-family: 'JetBrains Mono', monospace;"><c:out value="${p.datePlaced}" default="--"/></td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Attendance Section -->
            <div id="attendance" class="mb-5 reveal">
                <div class="retro-window">
                    <div class="retro-window-header">
                        <span class="retro-window-title"><i class="bi bi-calendar-check me-2"></i>Attendance Tracking</span>
                        <div class="retro-window-dots">
                            <span class="retro-window-dot close"></span>
                            <span class="retro-window-dot minimize"></span>
                            <span class="retro-window-dot maximize"></span>
                        </div>
                    </div>
                    <div class="retro-window-body">
                        <div class="admin-table-container">
                            <table class="admin-table">
                                <thead><tr><th>Student ID</th><th>Subject</th><th>Attended / Total</th><th>Percentage</th><th>Progress</th></tr></thead>
                                <tbody>
                                    <c:forEach var="a" items="${attendanceList}">
                                        <tr>
                                            <td style="font-family: 'JetBrains Mono', monospace;">#${a.studentId}</td>
                                            <td style="font-weight: 600;">${a.subject}</td>
                                            <td style="font-family: 'JetBrains Mono', monospace;">${a.attended} / ${a.totalClasses}</td>
                                            <td style="font-weight: bold; font-family: 'JetBrains Mono', monospace; color: ${a.percentage >= 75 ? 'var(--accent-green)' : 'var(--accent-pink)'};">${a.percentage}%</td>
                                            <td style="min-width: 150px;">
                                                <div class="attendance-bar">
                                                    <div class="attendance-bar-fill ${a.percentage >= 75 ? 'attendance-good' : 'attendance-warn'}" style="width: ${a.percentage}%;"></div>
                                                </div>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Documents Section -->
            <div id="documents" class="mb-5 reveal">
                <div class="retro-window">
                    <div class="retro-window-header">
                        <span class="retro-window-title"><i class="bi bi-file-earmark-text me-2"></i>Global Documents Index</span>
                        <div class="retro-window-dots">
                            <span class="retro-window-dot close"></span>
                            <span class="retro-window-dot minimize"></span>
                            <span class="retro-window-dot maximize"></span>
                        </div>
                    </div>
                    <div class="retro-window-body">
                        <div class="admin-table-container">
                            <table class="admin-table">
                                <thead><tr><th>Student ID</th><th>Document Title</th><th>File Reference Path</th><th>Upload Date</th></tr></thead>
                                <tbody>
                                    <c:forEach var="doc" items="${allDocuments}">
                                        <tr>
                                            <td style="font-family: 'JetBrains Mono', monospace;">#${doc.studentId}</td>
                                            <td style="font-weight: 600;"><i class="bi bi-file-pdf me-2" style="color: var(--accent-pink);"></i>${doc.title}</td>
                                            <td style="font-family: 'JetBrains Mono', monospace; color: var(--accent-blue); font-size: 0.85rem;">${doc.filePath}</td>
                                            <td style="font-family: 'JetBrains Mono', monospace;">${doc.uploadDate}</td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>

        </div>
    </div>

    <!-- Bootstrap Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="js/main.js"></script>
</body>
</html>
