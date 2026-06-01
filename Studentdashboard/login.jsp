<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - Student Dashboard</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Main Style -->
    <link rel="stylesheet" href="css/style.css">
    <style>
        .login-wrapper {
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
        }
        .login-card {
            max-width: 400px;
            width: 100%;
            padding: 2.5rem;
            text-align: center;
        }
        .login-card .form-control {
            margin-bottom: 1.5rem;
            background: rgba(255, 255, 255, 0.04);
            border: 1px solid var(--glass-border);
            color: var(--text-primary);
        }
        .login-card .form-control:focus {
            background: rgba(255, 255, 255, 0.08);
            border-color: var(--accent-blue);
            box-shadow: 0 0 10px rgba(0, 212, 255, 0.3);
        }
    </style>
</head>
<body>
    <canvas id="particle-canvas"></canvas>

    <div class="login-wrapper">
        <div class="glass-card login-card fade-in-up">
            <h2 class="mb-4" style="background: linear-gradient(135deg, #c9a84c, #00d4ff); -webkit-background-clip: text; -webkit-text-fill-color: transparent;">Welcome Back</h2>
            <p class="text-secondary mb-4">Enter your credentials to access the dashboard</p>
            <% if (request.getAttribute("errorMessage") != null) { %>
                <div style="background: rgba(220, 53, 69, 0.15); border: 1px solid rgba(220, 53, 69, 0.5); color: #ff6b6b; padding: 12px 16px; border-radius: 8px; margin-bottom: 1.5rem; font-size: 0.9rem;">
                    <i class="bi bi-exclamation-triangle-fill me-2"></i><%= request.getAttribute("errorMessage") %>
                </div>
            <% } %>
            <form action="${pageContext.request.contextPath}/login" method="post">
                <input type="text" name="id" class="form-control" placeholder="Student ID (or Admin ID)" required>
                <input type="password" name="password" class="form-control" placeholder="Password" required>
                <button type="submit" class="btn-glow w-100 justify-content-center">Login</button>
            </form>
        </div>
    </div>

    <script src="js/main.js"></script>
</body>
</html>
