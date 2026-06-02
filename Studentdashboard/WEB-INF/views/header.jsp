<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="Student Portfolio Dashboard — Showcasing student excellence through innovative projects and skills.">
    <title><c:out value="${pageTitle}" default="StudentDash — Portfolio Dashboard"/></title>

    <!-- Google Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Audiowide&family=Rajdhani:wght@500;600;700&family=JetBrains+Mono:wght@400;500&display=swap" rel="stylesheet">

    <!-- Bootstrap 5.3 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">

    <!-- Custom Stylesheet -->
    <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet">
</head>
<body>

<!-- CRT Monitor Scanlines -->
<div class="crt-overlay"></div>

<!-- Particle / Synthwave Grid Canvas -->
<canvas id="particle-canvas"></canvas>

<!-- Theme Toggle -->
<button id="theme-toggle" class="btn btn-outline-light position-fixed top-0 end-0 m-3" style="z-index: 1050; border-radius: 50%; width: 45px; height: 45px; background: rgba(255,255,255,0.1); backdrop-filter: blur(10px);"><i class="bi bi-moon-fill"></i></button>

<!-- ============ NAVBAR ============ -->
<nav class="navbar navbar-expand-lg nav-glass fixed-top">
    <div class="container">
        <a class="navbar-brand d-flex align-items-center" href="${pageContext.request.contextPath}/home">
            <i class="bi bi-mortarboard-fill me-2"></i>StudentDash
        </a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
                data-bs-target="#mainNav" aria-controls="mainNav"
                aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="mainNav">
            <ul class="navbar-nav ms-auto gap-1">
                <li class="nav-item">
                    <a class="nav-link <c:if test='${currentPage == "home"}'>active</c:if>"
                       href="${pageContext.request.contextPath}/home">
                        <i class="bi bi-house-door me-1"></i>Home
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link <c:if test='${currentPage == "students"}'>active</c:if>"
                       href="${pageContext.request.contextPath}/students">
                        <i class="bi bi-people me-1"></i>Students
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link <c:if test='${currentPage == "projects"}'>active</c:if>"
                       href="${pageContext.request.contextPath}/projects">
                        <i class="bi bi-code-square me-1"></i>Projects
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link <c:if test='${currentPage == "contact"}'>active</c:if>"
                       href="${pageContext.request.contextPath}/contact">
                        <i class="bi bi-envelope me-1"></i>Contact
                    </a>
                </li>
            </ul>
        </div>
    </div>
</nav>
