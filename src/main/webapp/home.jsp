<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student Dashboard - AITR</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body class="section-light" style="padding: 0;">
    <jsp:include page="/WEB-INF/views/sidebar.jsp" />

    <div class="dashboard-main pb-5">
        
        <!-- Welcome Hero -->
        <div class="mb-5 border-bottom border-dark border-3 pb-4">
            <h1 class="bangers-font" style="font-size: 3rem; color: var(--brand);">WELCOME, ${student.name}</h1>
            <p class="fs-5 fw-bold mb-0">Branch: ${empty student.branch ? 'Computer Science' : student.branch} | Semester: ${student.semester}</p>
        </div>
        
        <c:if test="${not empty errorMessage}">
            <div class="nb-badge danger w-100 p-2 mb-4 fs-6 text-center">
                ${errorMessage}
            </div>
        </c:if>

        <!-- Stats Row -->
        <div class="row g-4 mb-5">
            <div class="col-md-4">
                <div class="nb-card h-100 text-center">
                    <h3 class="bangers-font" style="font-size: 2.5rem; color: var(--brand);"></h3>
                    <p class="fw-bold mb-0 text-uppercase">Documents</p>
                </div>
            </div>
            <div class="col-md-4">
                <div class="nb-card h-100 text-center">
                    <h3 class="bangers-font" style="font-size: 2.5rem; color: var(--brand);"></h3>
                    <p class="fw-bold mb-0 text-uppercase">Projects</p>
                </div>
            </div>
            <div class="col-md-4">
                <div class="nb-card h-100 text-center nb-card-featured">
                    <h3 class="bangers-font" style="font-size: 2.5rem; color: var(--brand);"></h3>
                    <p class="fw-bold mb-0 text-uppercase">Achievements</p>
                </div>
            </div>
        </div>

        <!-- Projects Section -->
        <section id="projects" class="mb-5">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h2 class="bangers-font" style="font-size: 2.5rem;">MY PROJECTS</h2>
                <button type="button" class="nb-button" data-bs-toggle="modal" data-bs-target="#addProjectModal">
                    <i class="bi bi-plus-lg me-1"></i> ADD PROJECT
                </button>
            </div>
            
            <div class="row g-4">
                <c:choose>
                    <c:when test="${empty projects}">
                        <div class="col-12">
                            <div class="nb-card text-center p-5">
                                <h4 class="bangers-font text-muted">No projects added yet!</h4>
                            </div>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="project" items="${projects}">
                            <div class="col-md-6">
                                <div class="nb-card h-100">
                                    <h4 class="bangers-font text-uppercase mb-2">${project.title}</h4>
                                    <div class="mb-3">
                                        <c:forEach var="tech" items="${project.techStack.split(',')}">
                                            <span class="nb-badge brand me-1">${tech.trim()}</span>
                                        </c:forEach>
                                    </div>
                                    <p class="fw-bold">${project.description}</p>
                                    <a href="${project.githubUrl}" target="_blank" class="nb-button secondary btn-sm mt-auto">
                                        <i class="bi bi-github me-1"></i> View Code
                                    </a>
                                </div>
                            </div>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </div>
        </section>

        <!-- Achievements Section -->
        <section id="achievements" class="mb-5">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h2 class="bangers-font" style="font-size: 2.5rem;">ACHIEVEMENTS</h2>
                <button type="button" class="nb-button" data-bs-toggle="modal" data-bs-target="#addAchievementModal">
                    <i class="bi bi-plus-lg me-1"></i> ADD ACHIEVEMENT
                </button>
            </div>
            <div class="row g-4">
                <c:forEach var="ach" items="${achievements}">
                    <div class="col-12">
                        <div class="nb-card">
                            <h4 class="bangers-font text-uppercase mb-2">${ach.title}</h4>
                            <p class="fw-bold mb-1">${ach.description}</p>
                            <small class="fw-bold text-muted">${ach.dateEarned}</small>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </section>

    </div>

    <!-- Add Project Modal -->
    <div class="modal fade" id="addProjectModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content nb-modal-content">
                <div class="nb-modal-header">
                    <h5 class="bangers-font fs-3">NEW PROJECT</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <form action="${pageContext.request.contextPath}/student-action" method="post" enctype="multipart/form-data">
                    <input type="hidden" name="action" value="addProject">
                    <div class="modal-body">
                        <label class="nb-label">Project Title</label>
                        <input type="text" name="title" class="nb-input" required>
                        
                        <label class="nb-label">Description</label>
                        <textarea name="description" class="nb-input" rows="3" required></textarea>
                        
                        <label class="nb-label">Tech Stack (Comma Separated)</label>
                        <input type="text" name="techStack" class="nb-input" required>
                        
                        <label class="nb-label">GitHub URL</label>
                        <input type="url" name="githubUrl" class="nb-input">

                        <label class="nb-label">Project Image / Screenshot</label>
                        <input type="file" name="imagePathFile" class="nb-input" accept="image/*">
                    </div>
                    <div class="modal-footer border-top border-dark border-2 mt-4 pt-4">
                        <button type="submit" class="nb-button w-100">SAVE PROJECT</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- Add Achievement Modal -->
    <div class="modal fade" id="addAchievementModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content nb-modal-content">
                <div class="nb-modal-header">
                    <h5 class="bangers-font fs-3">NEW ACHIEVEMENT</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <form action="${pageContext.request.contextPath}/student-action" method="post">
                    <input type="hidden" name="action" value="addAchievement">
                    <div class="modal-body">
                        <label class="nb-label">Title</label>
                        <input type="text" name="title" class="nb-input" required>
                        
                        <label class="nb-label">Description</label>
                        <textarea name="description" class="nb-input" rows="3" required></textarea>
                        
                        <label class="nb-label">Date Earned</label>
                        <input type="date" name="dateEarned" class="nb-input" required>
                    </div>
                    <div class="modal-footer border-top border-dark border-2 mt-4 pt-4">
                        <button type="submit" class="nb-button w-100">SAVE ACHIEVEMENT</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>