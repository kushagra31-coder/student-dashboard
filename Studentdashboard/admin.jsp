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
    
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    
    <!-- Custom Style -->
    <link rel="stylesheet" href="css/style.css">
</head>
<body class="dashboard-body">

    <jsp:include page="/WEB-INF/views/admin-sidebar.jsp"/>

    <!-- Main Content -->
    <div class="dashboard-main">
        <div class="container-fluid py-4 px-4">
            
            <c:if test="${param.success == 'true'}">
                <div class="alert alert-success alert-dismissible fade show" role="alert" style="background: rgba(40,167,69,0.2); color: #fff; border-color: #28a745;">
                    Action completed successfully!
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            </c:if>

            <div class="retro-window mb-5 text-center p-4">
                <h1 style="font-family: 'Audiowide', cursive; color: var(--neon-cyan); text-shadow: 0 0 10px var(--neon-cyan);">Acropolis Institute</h1>
                <h4 class="text-white mb-3" style="font-family: 'Rajdhani', sans-serif;">{AITR of Indore}</h4>
                <p class="text-muted" style="font-style: italic;">"Empowering the next generation of innovators and leaders. Welcome to the centralized administration dashboard."</p>
            </div>

            <div id="students" class="retro-window mb-5">
                <div class="retro-window-header">
                    <span class="retro-window-title">Student Records & Management</span>
                </div>
                <div class="retro-window-body p-4">
                    <div class="accordion" id="studentAccordion">
                        <c:forEach var="student" items="${students}">
                            <div class="accordion-item glass-card mb-3" style="background: rgba(255,255,255,0.02); border: 1px solid var(--glass-border);">
                                <h2 class="accordion-header" id="heading${student.id}">
                                    <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapse${student.id}" aria-expanded="false" aria-controls="collapse${student.id}" style="background: transparent; color: white; border: none;">
                                        <strong class="text-gradient">${student.name}</strong> &nbsp;—&nbsp; ${student.branch} (Sem: ${student.semester})
                                    </button>
                                </h2>
                                <div id="collapse${student.id}" class="accordion-collapse collapse" aria-labelledby="heading${student.id}" data-bs-parent="#studentAccordion">
                                    <div class="accordion-body text-white">
                                        
                                        <div class="row g-4">
                                            <!-- Clubs -->
                                            <div class="col-md-6">
                                                <h6 class="text-info border-bottom pb-2"><i class="bi bi-people-fill"></i> Clubs & Communities</h6>
                                                <ul class="list-unstyled">
                                                    <c:forEach var="c" items="${studentClubs[student.id]}">
                                                        <li class="mb-2"><strong><c:out value="${c.name}"/></strong> <span class="badge bg-secondary"><c:out value="${c.role}"/></span></li>
                                                    </c:forEach>
                                                    <c:if test="${empty studentClubs[student.id]}"><li><small class="text-muted">No clubs joined</small></li></c:if>
                                                </ul>
                                            </div>

                                            <!-- Skills -->
                                            <div class="col-md-6">
                                                <h6 class="text-primary border-bottom pb-2"><i class="bi bi-code-slash"></i> Technical Skills</h6>
                                                <div>
                                                    <c:forEach var="s" items="${studentSkills[student.id]}">
                                                        <span class="badge" style="background: rgba(0, 212, 255, 0.2); border: 1px solid var(--neon-cyan); margin: 2px;">
                                                            <c:out value="${s.name}"/> (<c:out value="${s.proficiencyPercent}"/>%)
                                                        </span>
                                                    </c:forEach>
                                                    <c:if test="${empty studentSkills[student.id]}"><li><small class="text-muted">No skills listed</small></li></c:if>
                                                </div>
                                            </div>

                                            <!-- Projects -->
                                            <div class="col-md-4 mt-4">
                                                <h6 class="text-success border-bottom pb-2"><i class="bi bi-rocket"></i> Projects</h6>
                                                <ul class="list-unstyled">
                                                    <c:forEach var="p" items="${studentProjects[student.id]}">
                                                        <li>- <c:out value="${p.title}"/></li>
                                                    </c:forEach>
                                                    <c:if test="${empty studentProjects[student.id]}"><li><small class="text-muted">No projects</small></li></c:if>
                                                </ul>
                                            </div>
                                            
                                            <!-- Documents -->
                                            <div class="col-md-4 mt-4">
                                                <h6 class="text-warning border-bottom pb-2"><i class="bi bi-file-earmark-text"></i> Documents</h6>
                                                <ul class="list-unstyled">
                                                    <c:forEach var="d" items="${studentDocuments[student.id]}">
                                                        <li>- <c:out value="${d.title}"/></li>
                                                    </c:forEach>
                                                    <c:if test="${empty studentDocuments[student.id]}"><li><small class="text-muted">No documents</small></li></c:if>
                                                </ul>
                                            </div>

                                            <!-- Certificates -->
                                            <div class="col-md-4 mt-4">
                                                <h6 style="color: var(--accent-purple);" class="border-bottom pb-2"><i class="bi bi-award"></i> Certificates</h6>
                                                <ul class="list-unstyled">
                                                    <c:forEach var="cert" items="${studentCertificates[student.id]}">
                                                        <li>- <c:out value="${cert.title}"/></li>
                                                    </c:forEach>
                                                    <c:if test="${empty studentCertificates[student.id]}"><li><small class="text-muted">No certificates</small></li></c:if>
                                                </ul>
                                            </div>
                                        </div>

                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </div>
            </div>

            <!-- Login Logs -->
            <div id="logs" class="retro-window">
                <div class="retro-window-header"><span class="retro-window-title">System Login Logs</span></div>
                <div class="retro-window-body p-3" style="max-height: 400px; overflow-y: auto;">
                    <table class="table table-dark table-hover table-bordered mb-0">
                        <thead class="table-secondary">
                            <tr>
                                <th>Time</th>
                                <th>User</th>
                                <th>Role</th>
                                <th>IP Address</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="log" items="${loginLogs}">
                                <tr>
                                    <td><c:out value="${log.loginTime}"/></td>
                                    <td><c:out value="${log.userName}"/></td>
                                    <td><span class="badge ${log.role == 'admin' ? 'bg-danger' : 'bg-primary'}"><c:out value="${log.role}"/></span></td>
                                    <td><c:out value="${log.ipAddress}"/></td>
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
