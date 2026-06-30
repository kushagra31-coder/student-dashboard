<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>AITR DASH</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<nav class="navbar navbar-expand-lg" style="background: var(--neutral-primary); border-bottom: 4px solid var(--border-default);">
    <div class="container">
        <a class="navbar-brand bangers-font fs-3" href="${pageContext.request.contextPath}/home" style="color: var(--brand);">
            <i class="bi bi-controller me-2"></i>AITR DASH
        </a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto fw-bold text-uppercase">
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/home" style="color: var(--heading-color);">Home</a>
                </li>
                <c:if test="${not empty sessionScope.studentId}">
                    <li class="nav-item">
                        <a class="nb-button btn-sm ms-3" href="${pageContext.request.contextPath}/logout">Logout</a>
                    </li>
                </c:if>
                <c:if test="${empty sessionScope.studentId}">
                    <li class="nav-item">
                        <a class="nb-button btn-sm ms-3" href="${pageContext.request.contextPath}/login">Login</a>
                    </li>
                </c:if>
            </ul>
        </div>
    </div>
</nav>