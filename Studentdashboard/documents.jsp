<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Documents</title>
    <!-- Google Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Audiowide&family=Rajdhani:wght@500;600;700&family=JetBrains+Mono:wght@400;500&display=swap" rel="stylesheet">
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <link rel="stylesheet" href="css/style.css">
    <style>
        .doc-card { padding: 1.5rem; transition: transform 0.3s ease, box-shadow 0.3s ease; border-left: 3px solid var(--accent-pink); }
        .doc-card:hover { transform: translateY(-4px); box-shadow: 0 8px 32px rgba(255, 0, 127, 0.25); border-left-color: var(--accent-blue); }
        .doc-icon { font-size: 2.8rem; color: var(--accent-pink); margin-bottom: 1rem; text-shadow: 0 0 10px rgba(255,0,127,0.3); }
        .doc-title { font-family: 'Audiowide', sans-serif; font-size: 1.15rem; color: #fff; margin-bottom: 0.5rem; }
        [data-theme='light'] .doc-title { color: var(--text-primary); }
        .doc-meta { font-size: 0.85rem; color: var(--text-muted); font-family: 'JetBrains Mono', monospace; }
        .doc-path { font-family: 'JetBrains Mono', monospace; font-size: 0.8rem; color: var(--accent-blue); background: rgba(0, 242, 254, 0.08); padding: 4px 10px; border-radius: 4px; display: inline-block; margin-top: 0.5rem; border: 1px solid rgba(0, 242, 254, 0.15); }
        .empty-state { text-align: center; padding: 4rem 2rem; }
        .empty-state i { font-size: 4rem; color: var(--text-muted); margin-bottom: 1rem; }
    </style>
</head>
<body class="dashboard-body">
    <!-- CRT Monitor Scanlines -->
    <div class="crt-overlay"></div>

    <!-- Synthwave Grid Canvas -->
    <canvas id="particle-canvas"></canvas>
    
    <jsp:include page="/WEB-INF/views/sidebar.jsp" />

    <div class="dashboard-main">
        <div class="container-fluid py-4 px-4">

            <div class="retro-window reveal">
                <div class="retro-window-header">
                    <span class="retro-window-title"><i class="bi bi-file-earmark-text me-2"></i>Document Explorer</span>
                    <div class="retro-window-dots">
                        <span class="retro-window-dot close"></span>
                        <span class="retro-window-dot minimize"></span>
                        <span class="retro-window-dot maximize"></span>
                    </div>
                </div>
                <div class="retro-window-body">
                    <h1 class="text-gradient mb-2" style="font-size: 2.2rem; display: inline-block;">My Documents</h1>
                    <p class="text-secondary mb-4" style="font-size: 1.15rem;">View and manage your academic files and records</p>
                    
                    <c:choose>
                        <c:when test="${empty documents}">
                            <div class="glass-card empty-state reveal">
                                <i class="bi bi-folder2-open text-gradient"></i>
                                <h4 class="text-secondary mt-3">No Documents Found</h4>
                                <p class="text-muted">Your uploaded credentials and certifications will appear here.</p>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="row g-4 mt-2">
                                <c:forEach var="doc" items="${documents}" varStatus="status">
                                    <div class="col-md-6 col-lg-4 reveal" style="animation-delay: ${status.index * 0.1}s;">
                                        <div class="glass-card doc-card h-100">
                                            <div class="doc-icon"><i class="bi bi-file-earmark-pdf-fill"></i></div>
                                            <div class="doc-title"><c:out value="${doc.title}"/></div>
                                            <div class="doc-meta">
                                                <i class="bi bi-calendar3 me-1"></i>
                                                <c:out value="${doc.uploadDate}" default="Recently uploaded"/>
                                            </div>
                                            <div class="doc-path"><i class="bi bi-link-45deg me-1"></i><c:out value="${doc.filePath}"/></div>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>

        </div>
    </div>

    <!-- Bootstrap Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="js/main.js"></script>
</body>
</html>
