<%@ page contentType="text/html;charset=UTF-8" language="java" isErrorPage="true" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>500 - Server Error</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body class="login-body d-flex align-items-center justify-content-center" style="height: 100vh;">
    <div class="glass-card text-center p-5 reveal border-danger">
        <h1 style="font-family: 'Bangers', cursive; font-size: 6rem; color: #ff6b6b; margin-bottom: 0;">500</h1>
        <h3 class="mb-4 text-white">Internal Server Error</h3>
        <p class="text-secondary mb-4">Oops! Something went wrong on our end. Our engineers have been notified.</p>
        <a href="${pageContext.request.contextPath}/home" class="btn btn-brutal">RETURN HOME</a>
    </div>
</body>
</html>