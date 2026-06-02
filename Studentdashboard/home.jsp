<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard - Student Dash</title>
    <!-- Google Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Audiowide&family=Rajdhani:wght@500;600;700&family=JetBrains+Mono:wght@400;500&display=swap" rel="stylesheet">
    
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <!-- Main Style -->
    <link rel="stylesheet" href="css/style.css">
</head>
<body class="dashboard-body">
    <!-- CRT Monitor Scanlines -->
    <div class="crt-overlay"></div>

    <!-- Synthwave Grid Canvas -->
    <canvas id="particle-canvas"></canvas>

    <!-- Include Sidebar -->
    <jsp:include page="/WEB-INF/views/sidebar.jsp" />

    <!-- Main Dashboard Area -->
    <div class="dashboard-main">
        <div class="container-fluid py-4 px-4">
            
            <!-- Hero Section -->
            <div class="retro-window reveal mb-5">
                <div class="retro-window-header">
                    <span class="retro-window-title">System Greeting</span>
                    <div class="retro-window-dots">
                        <span class="retro-window-dot close"></span>
                        <span class="retro-window-dot minimize"></span>
                        <span class="retro-window-dot maximize"></span>
                    </div>
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
                <!-- Bio Card -->
                <div class="col-lg-4 reveal">
                    <div class="retro-window h-100">
                        <div class="retro-window-header">
                            <span class="retro-window-title">Student Biography</span>
                            <div class="retro-window-dots"><span class="retro-window-dot close"></span></div>
                        </div>
                        <div class="retro-window-body">
                            <h4 class="mb-3 text-gradient">About Me</h4>
                            <p class="text-secondary mb-0" style="line-height: 1.7; font-size: 1.1rem;">
                                ${student.bio != null ? student.bio : 'A passionate student ready to explore the universe of technology and innovation.'}
                            </p>
                        </div>
                    </div>
                </div>

                <!-- Projects Grid -->
                <div class="col-lg-8 reveal delay-1">
                    <div class="retro-window h-100">
                        <div class="retro-window-header">
                            <span class="retro-window-title">Recent Telemetry Projects</span>
                            <div class="retro-window-dots"><span class="retro-window-dot minimize"></span><span class="retro-window-dot maximize"></span></div>
                        </div>
                        <div class="retro-window-body">
                            <h4 class="mb-4 text-gradient">Recent Projects</h4>
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
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Achievements Grid -->
            <div class="reveal mb-5">
                <div class="retro-window">
                    <div class="retro-window-header">
                        <span class="retro-window-title">System Achievements & Milestones</span>
                        <div class="retro-window-dots"><span class="retro-window-dot close"></span></div>
                    </div>
                    <div class="retro-window-body">
                        <h4 class="mb-4 text-gradient">Achievements</h4>
                        <div class="row g-4">
                            <c:forEach var="achievement" items="${achievements}">
                                <div class="col-md-4">
                                    <div class="glass-card p-4 achievement-card glow-purple">
                                        <h5 class="text-gradient"><i class="bi ${achievement.icon} me-2"></i><c:out value="${achievement.title}"/></h5>
                                        <p class="text-secondary text-sm mb-0"><c:out value="${achievement.description}"/></p>
                                    </div>
                                </div>
                            </c:forEach>
                    </div>
                </div>
            </div>

            <!-- Certificates Grid -->
            <div class="reveal mb-5">
                <div class="retro-window">
                    <div class="retro-window-header">
                        <span class="retro-window-title">Certifications & Credentials</span>
                        <div class="retro-window-dots"><span class="retro-window-dot close"></span></div>
                    </div>
                    <div class="retro-window-body">
                        <h4 class="mb-4 text-gradient">Certificates</h4>
                        <div class="row g-4">
                            <c:forEach var="cert" items="${certificates}">
                                <div class="col-md-4">
                                    <div class="glass-card p-4 achievement-card glow-cyan">
                                        <h5 class="text-gradient"><i class="bi bi-award me-2"></i><c:out value="${cert.title}"/></h5>
                                        <p class="text-secondary text-sm mb-0">Issued: <c:out value="${cert.issueDate}"/></p>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </div>
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
