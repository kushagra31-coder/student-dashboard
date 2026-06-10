<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard - Student Dash</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Audiowide&family=Rajdhani:wght@500;600;700&family=JetBrains+Mono:wght@400;500&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <link rel="stylesheet" href="css/style.css">
    <style>
        .add-btn { float: right; padding: 2px 10px; font-size: 0.8rem; border-radius: 20px; }
    </style>
</head>
<body class="dashboard-body">

    <jsp:include page="/WEB-INF/views/sidebar.jsp" />

    <div class="dashboard-main">
        <div class="container-fluid py-4 px-4">
            
            <c:if test="${param.success == 'true'}">
                <div class="alert alert-success alert-dismissible fade show mb-4" role="alert" style="background: rgba(40,167,69,0.2); color: #fff; border-color: #28a745;">
                    Data added successfully!
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            </c:if>

            <!-- Hero Section -->
            <div class="retro-window reveal mb-5">
                <div class="retro-window-header">
                    <span class="retro-window-title">System Greeting</span>
                    <div class="retro-window-dots"><span class="retro-window-dot minimize"></span><span class="retro-window-dot maximize"></span></div>
                </div>
                <div class="retro-window-body text-center p-5">
                    <h1 class="hero-title">Welcome, <span class="text-gradient">${student.name != null ? student.name : 'Explorer'}</span></h1>
                    <h3 class="hero-subtitle mb-0">
                        <span class="typing-text" data-phrases="[&quot;Branch: ${empty student.branch ? 'Computer Science' : student.branch}&quot;, &quot;Semester: ${empty student.semester ? '6' : student.semester}&quot;]"></span><span class="typing-cursor"></span>
                    </h3>
                </div>
            </div>

            <!-- Stats Row -->
            <div class="row g-4 mb-5">
                <div class="col-md-3 col-sm-6 reveal delay-1">
                    <div class="retro-window stat-card">
                        <div class="stat-number" data-target="${documentCount != null ? documentCount : 0}">0</div>
                        <div class="stat-label">Documents</div>
                    </div>
                </div>
                <div class="col-md-3 col-sm-6 reveal delay-2">
                    <div class="retro-window stat-card">
                        <div class="stat-number" data-target="${projectCount != null ? projectCount : 0}">0</div>
                        <div class="stat-label">Projects</div>
                    </div>
                </div>
                <div class="col-md-3 col-sm-6 reveal delay-3">
                    <div class="retro-window stat-card">
                        <div class="stat-number" data-target="${achievementCount != null ? achievementCount : 0}">0</div>
                        <div class="stat-label">Achievements</div>
                    </div>
                </div>
                <div class="col-md-3 col-sm-6 reveal delay-4">
                    <div class="retro-window stat-card">
                        <div class="stat-number" data-target="${student.semester != null ? student.semester : '6'}">0</div>
                        <div class="stat-label">Semester</div>
                    </div>
                </div>
            </div>

            <div class="row g-4 mb-5">
                <!-- Bio & Clubs Card -->
                <div class="col-lg-4 reveal">
                    <div class="retro-window h-100">
                        <div class="retro-window-header">
                            <span class="retro-window-title">Profile & Communities</span>
                        </div>
                        <div class="retro-window-body">
                            <h4 class="mb-3 text-gradient">About Me</h4>
                            <p class="text-secondary mb-4" style="line-height: 1.7; font-size: 1.1rem;">
                                ${student.bio != null ? student.bio : 'A passionate student ready to explore.'}
                            </p>
                            
                            <h4 class="mb-3 text-gradient d-flex justify-content-between align-items-center">
                                Clubs 
                                <button class="btn btn-expressive add-btn" data-bs-toggle="modal" data-bs-target="#addClubModal"><i class="bi bi-plus"></i> Add</button>
                            </h4>
                            <ul class="list-group list-group-flush mb-0" style="background: transparent;">
                                <c:forEach var="c" items="${clubs}">
                                    <li class="list-group-item text-white" style="background: transparent; border-color: rgba(255,255,255,0.1);">
                                        <strong><c:out value="${c.name}"/></strong><br>
                                        <span class="badge bg-secondary"><c:out value="${c.role}"/></span>
                                        <p class="text-muted small mt-1 mb-0"><c:out value="${c.description}"/></p>
                                    </li>
                                </c:forEach>
                                <c:if test="${empty clubs}"><li class="list-group-item text-muted" style="background: transparent;">No clubs joined.</li></c:if>
                            </ul>
                        </div>
                    </div>
                </div>

                <!-- Projects Grid -->
                <div id="projects" class="col-lg-8 reveal delay-1">
                    <div class="retro-window h-100">
                        <div class="retro-window-header">
                            <span class="retro-window-title">Recent Telemetry Projects</span>
                        </div>
                        <div class="retro-window-body">
                            <h4 class="mb-4 text-gradient d-flex justify-content-between align-items-center">
                                Recent Projects
                                <button class="btn btn-expressive add-btn" data-bs-toggle="modal" data-bs-target="#addProjectModal"><i class="bi bi-plus"></i> Add</button>
                            </h4>
                            <div class="row g-3">
                                <c:forEach var="project" items="${projects}" begin="0" end="3">
                                    <div class="col-md-6">
                                        <div class="glass-card project-card p-3 h-100">
                                            <h5 class="text-gradient-pink"><c:out value="${project.title}"/></h5>
                                            <div class="tech-stack mb-3 mt-2">
                                                <c:if test="${not empty project.techStack}">
                                                    <c:forEach var="tech" items="${fn:split(project.techStack, ',')}">
                                                        <span class="tech-tag"><c:out value="${fn:trim(tech)}"/></span>
                                                    </c:forEach>
                                                </c:if>
                                            </div>
                                            <c:if test="${not empty project.githubUrl}">
                                                <div class="mt-auto">
                                                    <a href="<c:out value='${project.githubUrl}'/>" target="_blank" class="btn-glow-outline w-100 justify-content-center btn-sm"><span>View Source</span></a>
                                                </div>
                                            </c:if>
                                        </div>
                                    </div>
                                </c:forEach>
                                <c:if test="${empty projects}"><div class="col-12 text-muted">No projects added yet.</div></c:if>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="row mb-5">
                <!-- Certificates Grid -->
                <div id="certificates" class="col-12 reveal">
                    <div class="retro-window">
                        <div class="retro-window-header">
                            <span class="retro-window-title">Certifications</span>
                        </div>
                        <div class="retro-window-body">
                            <h4 class="mb-4 text-gradient d-flex justify-content-between align-items-center">
                                Earned Certificates
                                <button class="btn btn-expressive add-btn" data-bs-toggle="modal" data-bs-target="#addCertModal"><i class="bi bi-plus"></i> Add</button>
                            </h4>
                            <div class="row g-3">
                                <c:forEach var="cert" items="${certificates}">
                                    <div class="col-md-4 col-sm-6">
                                        <div class="glass-card project-card p-3 h-100">
                                            <h5 class="text-gradient-purple"><c:out value="${cert.title}"/></h5>
                                            <div class="mt-auto pt-3">
                                                <a href="${pageContext.request.contextPath}/<c:out value='${cert.filePath}'/>" target="_blank" class="btn-glow-outline w-100 justify-content-center btn-sm" style="border-color: var(--accent-purple); color: var(--accent-purple);"><span>View Certificate</span></a>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                                <c:if test="${empty certificates}"><div class="col-12 text-muted">No certificates added yet.</div></c:if>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="row g-4 mb-5">
                <!-- Skills -->
                <div class="col-lg-6 reveal">
                    <div class="retro-window h-100">
                        <div class="retro-window-header"><span class="retro-window-title">Coding Languages & Skills</span></div>
                        <div class="retro-window-body">
                            <h4 class="mb-4 text-gradient d-flex justify-content-between align-items-center">
                                Technical Arsenal
                                <button class="btn btn-expressive add-btn" data-bs-toggle="modal" data-bs-target="#addSkillModal"><i class="bi bi-plus"></i> Add</button>
                            </h4>
                            <div class="d-flex flex-wrap gap-2">
                                <c:forEach var="s" items="${skills}">
                                    <div class="glass-card p-2 px-3 glow-cyan text-center">
                                        <strong><c:out value="${s.name}"/></strong><br>
                                        <small class="text-muted"><c:out value="${s.proficiencyPercent}"/>%</small>
                                    </div>
                                </c:forEach>
                                <c:if test="${empty skills}"><div class="text-muted">No skills added yet.</div></c:if>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Documents -->
                <div class="col-lg-6 reveal">
                    <div class="retro-window h-100">
                        <div class="retro-window-header"><span class="retro-window-title">Official Documents</span></div>
                        <div class="retro-window-body">
                            <h4 class="mb-4 text-gradient d-flex justify-content-between align-items-center">
                                Uploaded Documents
                                <button class="btn btn-expressive add-btn" data-bs-toggle="modal" data-bs-target="#addDocModal"><i class="bi bi-upload"></i> Upload</button>
                            </h4>
                            <ul class="list-group list-group-flush" style="background: transparent;">
                                <!-- Ideally documents list would be fetched here, but we'll show a simple link to documents page -->
                                <li class="list-group-item text-white" style="background: transparent; border: none;">
                                    <a href="${pageContext.request.contextPath}/documents" class="btn-glow-outline w-100 justify-content-center"><span>View All Documents</span></a>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>

        </div>
    </div>

    <!-- MODALS -->

    <!-- Add Project Modal -->
    <div class="modal fade" id="addProjectModal" tabindex="-1">
        <div class="modal-dialog modal-dialog-centered text-white">
            <div class="modal-content glass-card" style="background: rgba(20,20,40,0.95); border: 1px solid var(--neon-cyan);">
                <form action="${pageContext.request.contextPath}/student-action" method="post">
                    <input type="hidden" name="action" value="addProject">
                    <div class="modal-header border-bottom" style="border-color: rgba(255,255,255,0.1) !important;">
                        <h5 class="modal-title text-info"><i class="bi bi-rocket me-2"></i>New Project</h5>
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
                            <input type="text" name="techStack" class="form-control bg-dark text-white border-secondary" placeholder="Java, React, MySQL">
                        </div>
                        <div class="mb-3">
                            <label>Project Thumbnail / Image</label>
                            <!-- Uses file input to open OS file explorer -->
                            <input type="file" name="imagePathFile" class="form-control bg-dark text-white border-secondary" accept="image/*">
                            <!-- Hidden input for the string path backend expects for now -->
                            <input type="hidden" name="imagePath" value="images/project1.jpg">
                        </div>
                    </div>
                    <div class="modal-footer border-top" style="border-color: rgba(255,255,255,0.1) !important;">
                        <button type="submit" class="btn btn-info text-dark fw-bold px-4">Save Project</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- Upload Document Modal -->
    <div class="modal fade" id="addDocModal" tabindex="-1">
        <div class="modal-dialog modal-dialog-centered text-white">
            <div class="modal-content glass-card" style="background: rgba(20,20,40,0.95); border: 1px solid var(--neon-cyan);">
                <form action="${pageContext.request.contextPath}/student-action" method="post" enctype="multipart/form-data">
                    <input type="hidden" name="action" value="addDocument">
                    <!-- Simulate path for now since it's not a real multipart servlet yet -->
                    <input type="hidden" name="filePath" value="documents/uploaded.pdf">
                    <div class="modal-header border-bottom" style="border-color: rgba(255,255,255,0.1) !important;">
                        <h5 class="modal-title text-success"><i class="bi bi-file-earmark-arrow-up me-2"></i>Upload Document</h5>
                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                    </div>
                    <div class="modal-body">
                        <div class="mb-3">
                            <label>Document Title</label>
                            <input type="text" name="title" class="form-control bg-dark text-white border-secondary" required placeholder="e.g. 10th Marksheet">
                        </div>
                        <div class="mb-3">
                            <label>Select File</label>
                            <!-- Standard file input triggers OS file explorer -->
                            <input type="file" name="file" class="form-control bg-dark text-white border-secondary" required>
                        </div>
                    </div>
                    <div class="modal-footer border-top" style="border-color: rgba(255,255,255,0.1) !important;">
                        <button type="submit" class="btn btn-success fw-bold px-4">Upload File</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- Add Certificate Modal -->
    <div class="modal fade" id="addCertModal" tabindex="-1">
        <div class="modal-dialog modal-dialog-centered text-white">
            <div class="modal-content glass-card" style="background: rgba(20,20,40,0.95); border: 1px solid var(--accent-purple);">
                <form action="${pageContext.request.contextPath}/student-action" method="post" enctype="multipart/form-data">
                    <input type="hidden" name="action" value="addCertificate">
                    <input type="hidden" name="filePath" value="certificates/uploaded.pdf">
                    <div class="modal-header border-bottom" style="border-color: rgba(255,255,255,0.1) !important;">
                        <h5 class="modal-title" style="color: var(--accent-purple);"><i class="bi bi-award me-2"></i>Upload Certificate</h5>
                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                    </div>
                    <div class="modal-body">
                        <div class="mb-3">
                            <label>Certificate Title</label>
                            <input type="text" name="title" class="form-control bg-dark text-white border-secondary" required placeholder="e.g. AWS Certified Practitioner">
                        </div>
                        <div class="mb-3">
                            <label>Select File</label>
                            <input type="file" name="file" class="form-control bg-dark text-white border-secondary" required>
                        </div>
                    </div>
                    <div class="modal-footer border-top" style="border-color: rgba(255,255,255,0.1) !important;">
                        <button type="submit" class="btn fw-bold px-4" style="background: var(--accent-purple); color: #fff;">Upload</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- Add Club Modal -->
    <div class="modal fade" id="addClubModal" tabindex="-1">
        <div class="modal-dialog modal-dialog-centered text-white">
            <div class="modal-content glass-card" style="background: rgba(20,20,40,0.95); border: 1px solid var(--neon-cyan);">
                <form action="${pageContext.request.contextPath}/student-action" method="post">
                    <input type="hidden" name="action" value="addClub">
                    <div class="modal-header border-bottom" style="border-color: rgba(255,255,255,0.1) !important;">
                        <h5 class="modal-title text-warning"><i class="bi bi-people-fill me-2"></i>Join a Club</h5>
                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                    </div>
                    <div class="modal-body">
                        <div class="mb-3">
                            <label>Club Name</label>
                            <input type="text" name="name" class="form-control bg-dark text-white border-secondary" required>
                        </div>
                        <div class="mb-3">
                            <label>Your Role</label>
                            <input type="text" name="role" class="form-control bg-dark text-white border-secondary" required>
                        </div>
                        <div class="mb-3">
                            <label>Description / Activities</label>
                            <textarea name="description" class="form-control bg-dark text-white border-secondary" rows="3" required></textarea>
                        </div>
                    </div>
                    <div class="modal-footer border-top" style="border-color: rgba(255,255,255,0.1) !important;">
                        <button type="submit" class="btn btn-warning text-dark fw-bold px-4">Add Club</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- Add Skill Modal -->
    <div class="modal fade" id="addSkillModal" tabindex="-1">
        <div class="modal-dialog modal-dialog-centered text-white">
            <div class="modal-content glass-card" style="background: rgba(20,20,40,0.95); border: 1px solid var(--neon-cyan);">
                <form action="${pageContext.request.contextPath}/student-action" method="post">
                    <input type="hidden" name="action" value="addSkill">
                    <div class="modal-header border-bottom" style="border-color: rgba(255,255,255,0.1) !important;">
                        <h5 class="modal-title text-primary"><i class="bi bi-code-slash me-2"></i>Add Skill</h5>
                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                    </div>
                    <div class="modal-body">
                        <div class="mb-3">
                            <label>Category</label>
                            <select name="category" class="form-control bg-dark text-white border-secondary">
                                <option value="Language">Language</option>
                                <option value="Web">Web Tech</option>
                                <option value="Database">Database</option>
                            </select>
                        </div>
                        <div class="mb-3">
                            <label>Skill Name (e.g. HTML, Rust)</label>
                            <input type="text" name="name" class="form-control bg-dark text-white border-secondary" required>
                        </div>
                        <div class="mb-3">
                            <label>Proficiency (%)</label>
                            <input type="number" name="proficiency" class="form-control bg-dark text-white border-secondary" min="1" max="100" required>
                        </div>
                    </div>
                    <div class="modal-footer border-top" style="border-color: rgba(255,255,255,0.1) !important;">
                        <button type="submit" class="btn btn-primary fw-bold px-4">Add Skill</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="js/main.js"></script>
</body>
</html>
