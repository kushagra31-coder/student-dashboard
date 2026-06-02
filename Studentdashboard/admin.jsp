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
    <!-- CRT Overlay -->
    <div class="crt-overlay"></div>
    <canvas id="particle-canvas"></canvas>

    <!-- Sidebar (Using standard sidebar modified or keeping it simple for Admin) -->
    <div class="sidebar glass-card">
        <div class="sidebar-brand">
            <span class="gradient-text">AdminPanel</span>
        </div>
        <ul class="sidebar-nav">
            <li><a href="${pageContext.request.contextPath}/admin" class="sidebar-link active"><i class="bi bi-speedometer2"></i> Dashboard</a></li>
            <li><a href="${pageContext.request.contextPath}/home" class="sidebar-link"><i class="bi bi-house"></i> Go to App</a></li>
            <li><a href="${pageContext.request.contextPath}/logout" class="sidebar-link logout"><i class="bi bi-box-arrow-right"></i> Logout</a></li>
        </ul>
    </div>

    <!-- Main Content -->
    <div class="dashboard-main">
        <div class="container-fluid py-4 px-4">
            
            <c:if test="${param.success == 'true'}">
                <div class="alert alert-success alert-dismissible fade show" role="alert" style="background: rgba(40,167,69,0.2); color: #fff; border-color: #28a745;">
                    Action completed successfully!
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            </c:if>

            <div class="retro-window mb-5">
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
                                        <!-- Actions -->
                                        <div class="d-flex gap-2 mb-4">
                                            <button class="btn btn-sm btn-outline-info" onclick="openProjectModal(${student.id}, '${student.name}')"><i class="bi bi-plus-lg"></i> Add Project</button>
                                            <button class="btn btn-sm btn-outline-success" onclick="openDocModal(${student.id}, '${student.name}')"><i class="bi bi-plus-lg"></i> Upload Document</button>
                                            <button class="btn btn-sm btn-outline-warning" onclick="openCertModal(${student.id}, '${student.name}')"><i class="bi bi-plus-lg"></i> Add Certificate</button>
                                        </div>

                                        <div class="row g-3">
                                            <!-- Projects -->
                                            <div class="col-md-4">
                                                <h6 class="text-info border-bottom pb-2">Projects</h6>
                                                <ul class="list-unstyled">
                                                    <c:forEach var="p" items="${studentProjects[student.id]}">
                                                        <li>- <c:out value="${p.title}"/></li>
                                                    </c:forEach>
                                                    <c:if test="${empty studentProjects[student.id]}"><li><small class="text-muted">No projects</small></li></c:if>
                                                </ul>
                                            </div>
                                            <!-- Documents -->
                                            <div class="col-md-4">
                                                <h6 class="text-success border-bottom pb-2">Documents</h6>
                                                <ul class="list-unstyled">
                                                    <c:forEach var="d" items="${studentDocuments[student.id]}">
                                                        <li>- <c:out value="${d.title}"/></li>
                                                    </c:forEach>
                                                    <c:if test="${empty studentDocuments[student.id]}"><li><small class="text-muted">No documents</small></li></c:if>
                                                </ul>
                                            </div>
                                            <!-- Certificates -->
                                            <div class="col-md-4">
                                                <h6 class="text-warning border-bottom pb-2">Certificates</h6>
                                                <ul class="list-unstyled">
                                                    <c:forEach var="c" items="${studentCertificates[student.id]}">
                                                        <li>- <c:out value="${c.title}"/></li>
                                                    </c:forEach>
                                                    <c:if test="${empty studentCertificates[student.id]}"><li><small class="text-muted">No certificates</small></li></c:if>
                                                </ul>
                                            </div>
                                        </div>

                                        <!-- Attendance Mini Table -->
                                        <div class="mt-4">
                                            <h6 class="text-secondary border-bottom pb-2">Attendance Info</h6>
                                            <table class="table table-dark table-sm table-hover mt-2" style="background: transparent;">
                                                <thead>
                                                    <tr>
                                                        <th>Subject</th>
                                                        <th>Total</th>
                                                        <th>Attended</th>
                                                        <th>%</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <c:set var="hasAtt" value="false" />
                                                    <c:forEach var="att" items="${attendanceList}">
                                                        <c:if test="${att.studentId == student.id}">
                                                            <c:set var="hasAtt" value="true" />
                                                            <tr>
                                                                <td>${att.subject}</td>
                                                                <td>${att.totalClasses}</td>
                                                                <td>${att.attended}</td>
                                                                <td>${att.percentage}%</td>
                                                            </tr>
                                                        </c:if>
                                                    </c:forEach>
                                                    <c:if test="${!hasAtt}">
                                                        <tr><td colspan="4" class="text-center text-muted">No attendance data</td></tr>
                                                    </c:if>
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </div>
            </div>

            <!-- Login Logs -->
            <div class="retro-window">
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

    <!-- Add Project Modal -->
    <div class="modal fade" id="addProjectModal" tabindex="-1">
        <div class="modal-dialog modal-dialog-centered text-white">
            <div class="modal-content glass-card" style="background: rgba(20,20,40,0.9);">
                <form action="${pageContext.request.contextPath}/admin" method="post">
                    <input type="hidden" name="action" value="addProject">
                    <input type="hidden" name="studentId" id="projStudentId">
                    <div class="modal-header border-bottom border-secondary">
                        <h5 class="modal-title text-info">Add Project for <span id="projStudentName"></span></h5>
                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                    </div>
                    <div class="modal-body">
                        <div class="mb-3">
                            <label>Title</label>
                            <input type="text" name="title" class="form-control bg-dark text-white border-secondary" required>
                        </div>
                        <div class="mb-3">
                            <label>Description</label>
                            <textarea name="description" class="form-control bg-dark text-white border-secondary" rows="2"></textarea>
                        </div>
                        <div class="mb-3">
                            <label>Tech Stack</label>
                            <input type="text" name="techStack" class="form-control bg-dark text-white border-secondary">
                        </div>
                        <div class="mb-3">
                            <label>GitHub URL</label>
                            <input type="url" name="githubUrl" class="form-control bg-dark text-white border-secondary">
                        </div>
                    </div>
                    <div class="modal-footer border-top border-secondary">
                        <button type="submit" class="btn btn-outline-info">Add Project</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- Upload Document Modal -->
    <div class="modal fade" id="uploadDocModal" tabindex="-1">
        <div class="modal-dialog modal-dialog-centered text-white">
            <div class="modal-content glass-card" style="background: rgba(20,20,40,0.9);">
                <form action="${pageContext.request.contextPath}/admin" method="post">
                    <input type="hidden" name="action" value="uploadDocument">
                    <input type="hidden" name="studentId" id="docStudentId">
                    <div class="modal-header border-bottom border-secondary">
                        <h5 class="modal-title text-success">Upload Doc for <span id="docStudentName"></span></h5>
                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                    </div>
                    <div class="modal-body">
                        <div class="mb-3">
                            <label>Title (e.g. 10th Marksheet)</label>
                            <input type="text" name="title" class="form-control bg-dark text-white border-secondary" required>
                        </div>
                        <div class="mb-3">
                            <label>File Path (e.g. documents/10th.pdf)</label>
                            <input type="text" name="filePath" class="form-control bg-dark text-white border-secondary" required>
                        </div>
                    </div>
                    <div class="modal-footer border-top border-secondary">
                        <button type="submit" class="btn btn-outline-success">Upload Document</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- Add Certificate Modal -->
    <div class="modal fade" id="addCertModal" tabindex="-1">
        <div class="modal-dialog modal-dialog-centered text-white">
            <div class="modal-content glass-card" style="background: rgba(20,20,40,0.9);">
                <form action="${pageContext.request.contextPath}/admin" method="post">
                    <input type="hidden" name="action" value="addCertificate">
                    <input type="hidden" name="studentId" id="certStudentId">
                    <div class="modal-header border-bottom border-secondary">
                        <h5 class="modal-title text-warning">Add Certificate for <span id="certStudentName"></span></h5>
                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                    </div>
                    <div class="modal-body">
                        <div class="mb-3">
                            <label>Title (e.g. AWS Certified)</label>
                            <input type="text" name="title" class="form-control bg-dark text-white border-secondary" required>
                        </div>
                        <div class="mb-3">
                            <label>File Path</label>
                            <input type="text" name="filePath" class="form-control bg-dark text-white border-secondary" required>
                        </div>
                    </div>
                    <div class="modal-footer border-top border-secondary">
                        <button type="submit" class="btn btn-outline-warning">Add Certificate</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="js/main.js"></script>
    <script>
        function openProjectModal(id, name) {
            document.getElementById('projStudentId').value = id;
            document.getElementById('projStudentName').innerText = name;
            new bootstrap.Modal(document.getElementById('addProjectModal')).show();
        }
        function openDocModal(id, name) {
            document.getElementById('docStudentId').value = id;
            document.getElementById('docStudentName').innerText = name;
            new bootstrap.Modal(document.getElementById('uploadDocModal')).show();
        }
        function openCertModal(id, name) {
            document.getElementById('certStudentId').value = id;
            document.getElementById('certStudentName').innerText = name;
            new bootstrap.Modal(document.getElementById('addCertModal')).show();
        }
    </script>
</body>
</html>
