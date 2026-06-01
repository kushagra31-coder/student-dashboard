<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard - Space Theme</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
    <!-- Main Style -->
    <link rel="stylesheet" href="css/style.css">
</head>
<body class="dashboard-body">
    <!-- Particle canvas for stars -->
    <canvas id="particle-canvas"></canvas>

    <!-- Include Sidebar -->
    <jsp:include page="/WEB-INF/views/sidebar.jsp" />

    <!-- Main Dashboard Area -->
    <div class="dashboard-main">
        <div class="container-fluid py-5">
            <!-- Hero Section -->
            <div class="hero-section text-center reveal mb-5 p-5 glass-card">
                <h1 class="hero-title">Welcome, <span class="gradient-text">${student.name != null ? student.name : 'Explorer'}</span></h1>
                <h3 class="hero-subtitle">
                    <span class="typing-text" data-phrases="[&quot;Branch: ${empty student.branch ? 'Computer Science' : student.branch}&quot;, &quot;Semester: ${empty student.semester ? '6' : student.semester}&quot;]"></span><span class="typing-cursor"></span>
                </h3>
            </div>

            <!-- Stats Row -->
            <div class="row g-4 mb-5">
                <div class="col-md-3 col-sm-6 reveal delay-1">
                    <div class="glass-card stat-card">
                        <div class="stat-number" data-target="${documentCount != null ? documentCount : 0}">0</div>
                        <div class="stat-label">Documents</div>
                    </div>
                </div>
                <div class="col-md-3 col-sm-6 reveal delay-2">
                    <div class="glass-card stat-card">
                        <div class="stat-number" data-target="${projectCount != null ? projectCount : 0}">0</div>
                        <div class="stat-label">Projects</div>
                    </div>
                </div>
                <div class="col-md-3 col-sm-6 reveal delay-3">
                    <div class="glass-card stat-card">
                        <div class="stat-number" data-target="${achievementCount != null ? achievementCount : 0}">0</div>
                        <div class="stat-label">Achievements</div>
                    </div>
                </div>
                <div class="col-md-3 col-sm-6 reveal delay-4">
                    <div class="glass-card stat-card">
                        <div class="stat-number" data-target="${student.semester != null ? student.semester : '6'}">0</div>
                        <div class="stat-label">Semester</div>
                    </div>
                </div>
            </div>

            <div class="row g-4 mb-5">
                <!-- Bio Card -->
                <div class="col-lg-4 reveal">
                    <div class="glass-card p-4 h-100">
                        <h4 class="mb-3 text-gradient">About Me</h4>
                        <p class="text-secondary mb-0">${student.bio != null ? student.bio : 'A passionate student ready to explore the universe of technology and innovation.'}</p>
                    </div>
                </div>

                <!-- Projects Grid -->
                <div class="col-lg-8 reveal delay-1">
                    <div class="glass-card p-4 h-100">
                        <h4 class="mb-4 text-gradient">Recent Projects</h4>
                        <div class="row g-3">
                            <c:forEach var="project" items="${projects}" begin="0" end="3">
                                <div class="col-md-6">
                                    <div class="project-item p-3 glass-card" style="border-top: 3px solid var(--accent-cyan);">
                                        <h5><c:out value="${project.title}"/></h5>
                                        <div class="tech-stack mb-2">
                                            <c:if test="${not empty project.techStack}">
                                                <c:forEach var="tech" items="${fn:split(project.techStack, ',')}">
                                                    <span class="badge bg-glass-light border-glass"><c:out value="${fn:trim(tech)}"/></span>
                                                </c:forEach>
                                            </c:if>
                                        </div>
                                        <c:if test="${not empty project.githubUrl}">
                                            <a href="<c:out value='${project.githubUrl}'/>" class="btn-glow-outline btn-sm">View Source</a>
                                        </c:if>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Achievements Grid -->
            <div class="reveal mb-5">
                <h4 class="mb-4 text-gradient">Achievements</h4>
                <div class="row g-4">
                    <c:forEach var="achievement" items="${achievements}">
                        <div class="col-md-4">
                            <div class="glass-card p-4 achievement-card glow-purple">
                                <h5><i class="bi ${achievement.icon} me-2 text-gradient"></i><c:out value="${achievement.title}"/></h5>
                                <p class="text-secondary text-sm mb-0"><c:out value="${achievement.description}"/></p>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>

        </div>
    </div>

    <!-- Bootstrap Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <!-- Main JS -->
    <script src="js/main.js"></script>
</body>
</html>
