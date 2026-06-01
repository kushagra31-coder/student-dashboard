<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
    <link rel="stylesheet" href="css/style.css">
    <style>
        .admin-table { width: 100%; border-collapse: separate; border-spacing: 0; }
        .admin-table thead th { background: rgba(201, 168, 76, 0.15); color: #c9a84c; padding: 14px 16px; font-size: 0.85rem; text-transform: uppercase; letter-spacing: 1px; border-bottom: 1px solid rgba(201, 168, 76, 0.3); }
        .admin-table tbody td { padding: 12px 16px; border-bottom: 1px solid rgba(255,255,255,0.05); color: #ccc; font-size: 0.9rem; }
        .admin-table tbody tr:hover { background: rgba(255,255,255,0.03); }
        .section-title { font-size: 1.5rem; font-weight: 700; margin-bottom: 1.5rem; background: linear-gradient(135deg, #c9a84c, #00d4ff); -webkit-background-clip: text; -webkit-text-fill-color: transparent; }
        .badge-placed { background: rgba(40, 167, 69, 0.2); color: #5dd39e; border: 1px solid rgba(40, 167, 69, 0.4); }
        .badge-interviewing { background: rgba(0, 212, 255, 0.15); color: #00d4ff; border: 1px solid rgba(0, 212, 255, 0.4); }
        .badge-offered { background: rgba(201, 168, 76, 0.2); color: #c9a84c; border: 1px solid rgba(201, 168, 76, 0.4); }
        .stat-overview { display: grid; grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); gap: 1.5rem; margin-bottom: 2.5rem; }
        .stat-overview .glass-card { padding: 1.5rem; text-align: center; }
        .stat-overview .stat-icon { font-size: 2rem; margin-bottom: 0.5rem; }
        .stat-overview .stat-val { font-size: 2.2rem; font-weight: 800; background: linear-gradient(135deg, #c9a84c, #00d4ff); -webkit-background-clip: text; -webkit-text-fill-color: transparent; }
        .stat-overview .stat-lbl { color: #888; font-size: 0.85rem; text-transform: uppercase; letter-spacing: 1px; }
        .attendance-bar { height: 8px; border-radius: 4px; background: rgba(255,255,255,0.1); overflow: hidden; }
        .attendance-bar-fill { height: 100%; border-radius: 4px; transition: width 0.6s ease; }
        .attendance-good { background: linear-gradient(90deg, #5dd39e, #00d4ff); }
        .attendance-warn { background: linear-gradient(90deg, #c9a84c, #ff6b6b); }
    </style>
</head>
<body class="dashboard-body">
    <canvas id="particle-canvas"></canvas>
    <jsp:include page="/WEB-INF/views/admin-sidebar.jsp" />

    <div class="dashboard-main">
        <div class="container-fluid py-4 px-4">

            <!-- Header -->
            <div class="mb-4">
                <h1 style="font-size: 1.8rem; font-weight: 700;">Admin Dashboard</h1>
                <p class="text-secondary">Manage students, track attendance, and monitor activity</p>
            </div>

            <!-- Stats Overview -->
            <div class="stat-overview reveal">
                <div class="glass-card">
                    <div class="stat-icon" style="color: #00d4ff;"><i class="bi bi-people-fill"></i></div>
                    <div class="stat-val">${fn:length(students)}</div>
                    <div class="stat-lbl">Students</div>
                </div>
                <div class="glass-card">
                    <div class="stat-icon" style="color: #c9a84c;"><i class="bi bi-clock-history"></i></div>
                    <div class="stat-val">${fn:length(loginLogs)}</div>
                    <div class="stat-lbl">Login Events</div>
                </div>
                <div class="glass-card">
                    <div class="stat-icon" style="color: #5dd39e;"><i class="bi bi-briefcase-fill"></i></div>
                    <div class="stat-val">${fn:length(placements)}</div>
                    <div class="stat-lbl">Placements</div>
                </div>
                <div class="glass-card">
                    <div class="stat-icon" style="color: #f472b6;"><i class="bi bi-file-earmark-text-fill"></i></div>
                    <div class="stat-val">${fn:length(allDocuments)}</div>
                    <div class="stat-lbl">Documents</div>
                </div>
            </div>

            <!-- Students Section -->
            <div id="students" class="mb-5 reveal">
                <h3 class="section-title"><i class="bi bi-people me-2"></i>Student Records</h3>
                <div class="glass-card p-4">
                    <table class="admin-table">
                        <thead><tr><th>ID</th><th>Name</th><th>Branch</th><th>Semester</th><th>Role</th><th>GitHub</th></tr></thead>
                        <tbody>
                            <c:forEach var="s" items="${students}">
                                <c:if test="${s.role != 'admin'}">
                                <tr>
                                    <td>${s.id}</td>
                                    <td style="color: #fff; font-weight: 600;">${s.name}</td>
                                    <td>${s.branch}</td>
                                    <td>${s.semester}</td>
                                    <td><span class="badge" style="background: rgba(0,212,255,0.15); color: #00d4ff;">${s.role}</span></td>
                                    <td><c:if test="${not empty s.githubUrl && s.githubUrl != '#'}"><a href="${s.githubUrl}" target="_blank" style="color: #c9a84c;"><i class="bi bi-github"></i></a></c:if></td>
                                </tr>
                                </c:if>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>

            <!-- Login Logs Section -->
            <div id="logs" class="mb-5 reveal">
                <h3 class="section-title"><i class="bi bi-clock-history me-2"></i>Login Activity</h3>
                <div class="glass-card p-4">
                    <c:choose>
                        <c:when test="${empty loginLogs}">
                            <p class="text-secondary text-center py-4">No login activity recorded yet.</p>
                        </c:when>
                        <c:otherwise>
                            <table class="admin-table">
                                <thead><tr><th>User</th><th>Role</th><th>Login Time</th></tr></thead>
                                <tbody>
                                    <c:forEach var="log" items="${loginLogs}" begin="0" end="4">
                                        <tr>
                                            <td style="color: #fff;">${log.userName} <span class="text-secondary">(ID: ${log.userId})</span></td>
                                            <td><span class="badge" style="background: rgba(201,168,76,0.15); color: #c9a84c;">${log.role}</span></td>
                                            <td>${log.loginTime}</td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                                <c:if test="${fn:length(loginLogs) > 5}">
                                    <tbody class="collapse" id="olderLogs">
                                        <c:forEach var="log" items="${loginLogs}" begin="5">
                                            <tr>
                                                <td style="color: #fff;">${log.userName} <span class="text-secondary">(ID: ${log.userId})</span></td>
                                                <td><span class="badge" style="background: rgba(201,168,76,0.15); color: #c9a84c;">${log.role}</span></td>
                                                <td>${log.loginTime}</td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </c:if>
                            </table>
                            <c:if test="${fn:length(loginLogs) > 5}">
                                <div class="text-center mt-3">
                                    <button class="btn btn-outline-light btn-sm" type="button" data-bs-toggle="collapse" data-bs-target="#olderLogs" aria-expanded="false" style="border-color: rgba(255,255,255,0.2); color: #ccc;">
                                        Show Older Logs
                                    </button>
                                </div>
                            </c:if>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>

            <!-- Placements Section -->
            <div id="placements" class="mb-5 reveal">
                <h3 class="section-title"><i class="bi bi-briefcase me-2"></i>Placement Records</h3>
                <div class="glass-card p-4">
                    <table class="admin-table">
                        <thead><tr><th>Student ID</th><th>Company</th><th>Role</th><th>Package (LPA)</th><th>Status</th><th>Date</th></tr></thead>
                        <tbody>
                            <c:forEach var="p" items="${placements}">
                                <tr>
                                    <td>${p.studentId}</td>
                                    <td style="color: #fff; font-weight: 600;">${p.company}</td>
                                    <td>${p.role}</td>
                                    <td style="color: #5dd39e; font-weight: 700;">${p.packageLpa} LPA</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${p.status == 'placed'}"><span class="badge badge-placed">Placed</span></c:when>
                                            <c:when test="${p.status == 'interviewing'}"><span class="badge badge-interviewing">Interviewing</span></c:when>
                                            <c:when test="${p.status == 'offered'}"><span class="badge badge-offered">Offered</span></c:when>
                                            <c:otherwise><span class="badge">${p.status}</span></c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td><c:out value="${p.datePlaced}" default="--"/></td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>

            <!-- Attendance Section -->
            <div id="attendance" class="mb-5 reveal">
                <h3 class="section-title"><i class="bi bi-calendar-check me-2"></i>Attendance Records</h3>
                <div class="glass-card p-4">
                    <table class="admin-table">
                        <thead><tr><th>Student ID</th><th>Subject</th><th>Attended / Total</th><th>Percentage</th><th>Progress</th></tr></thead>
                        <tbody>
                            <c:forEach var="a" items="${attendanceList}">
                                <tr>
                                    <td>${a.studentId}</td>
                                    <td style="color: #fff;">${a.subject}</td>
                                    <td>${a.attended} / ${a.totalClasses}</td>
                                    <td style="font-weight: 700; color: ${a.percentage >= 75 ? '#5dd39e' : '#ff6b6b'};">${a.percentage}%</td>
                                    <td style="min-width: 120px;">
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

            <!-- Documents Section -->
            <div id="documents" class="mb-5 reveal">
                <h3 class="section-title"><i class="bi bi-file-earmark-text me-2"></i>All Documents</h3>
                <div class="glass-card p-4">
                    <table class="admin-table">
                        <thead><tr><th>Student ID</th><th>Document Title</th><th>File Path</th><th>Upload Date</th></tr></thead>
                        <tbody>
                            <c:forEach var="doc" items="${allDocuments}">
                                <tr>
                                    <td>${doc.studentId}</td>
                                    <td style="color: #fff;"><i class="bi bi-file-pdf me-2" style="color: #ff6b6b;"></i>${doc.title}</td>
                                    <td style="font-family: monospace; color: #00d4ff; font-size: 0.8rem;">${doc.filePath}</td>
                                    <td>${doc.uploadDate}</td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>

        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="js/main.js"></script>
</body>
</html>
