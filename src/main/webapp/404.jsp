<%@ page contentType="text/html;charset=UTF-8" language="java" isErrorPage="true" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>404 - Not Found</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body class="login-body d-flex align-items-center justify-content-center" style="height: 100vh;">
    <div class="glass-card text-center p-5 reveal">
        <h1 style="font-family: 'Bangers', cursive; font-size: 6rem; color: #ff6b6b; margin-bottom: 0;">404</h1>
        <h3 class="mb-4 text-white">Page Not Found</h3>
        <p class="text-secondary mb-4">The resource you're looking for doesn't exist or has been moved.</p>
        <a href="${pageContext.request.contextPath}/home" class="btn btn-brutal">RETURN HOME</a>
    </div>
</body>
</html>