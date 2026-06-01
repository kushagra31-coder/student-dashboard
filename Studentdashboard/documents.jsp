<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Documents</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
    <link rel="stylesheet" href="css/style.css">
    <style>
        .doc-card { padding: 1.5rem; transition: transform 0.3s ease, box-shadow 0.3s ease; border-left: 3px solid #c9a84c; }
        .doc-card:hover { transform: translateY(-4px); box-shadow: 0 8px 32px rgba(201, 168, 76, 0.2); }
        .doc-icon { font-size: 2.5rem; color: #ff6b6b; margin-bottom: 1rem; }
        .doc-title { font-size: 1.1rem; font-weight: 600; color: #fff; margin-bottom: 0.5rem; }
        .doc-meta { font-size: 0.8rem; color: #888; }
        .doc-path { font-family: monospace; font-size: 0.75rem; color: #00d4ff; background: rgba(0,212,255,0.08); padding: 4px 10px; border-radius: 6px; display: inline-block; margin-top: 0.5rem; }
        .empty-state { text-align: center; padding: 4rem 2rem; }
        .empty-state i { font-size: 4rem; color: #333; margin-bottom: 1rem; }
    </style>
</head>
<body class="dashboard-body">
    <canvas id="particle-canvas"></canvas>
    <jsp:include page="/WEB-INF/views/sidebar.jsp" />

    <div class="dashboard-main">
        <div class="container-fluid py-4 px-4">

            <div class="mb-4 reveal">
                <h1 style="font-size: 1.8rem; font-weight: 700; background: linear-gradient(135deg, #c9a84c, #00d4ff); -webkit-background-clip: text; -webkit-text-fill-color: transparent;">My Documents</h1>
                <p class="text-secondary">View and manage your uploaded documents</p>
            </div>

            <c:choose>
                <c:when test="${empty documents}">
                    <div class="glass-card empty-state reveal">
                        <i class="bi bi-folder2-open"></i>
                        <h4 style="color: #666;">No Documents Yet</h4>
                        <p class="text-secondary">Your uploaded documents will appear here.</p>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="row g-4">
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

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="js/main.js"></script>
</body>
</html>
