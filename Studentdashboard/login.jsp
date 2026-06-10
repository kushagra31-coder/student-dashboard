<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - Student Dashboard</title>
    <!-- Google Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Audiowide&family=Rajdhani:wght@500;600;700&family=JetBrains+Mono:wght@400;500&display=swap" rel="stylesheet">
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
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
            max-width: 420px;
            width: 100%;
            padding: 0;
            text-align: center;
        }
    </style>
</head>
<body>



    <div class="login-wrapper">
        <div class="retro-window login-card fade-in-up">
            <div class="retro-window-header">
                <span class="retro-window-title">Access Terminal</span>
                <div class="retro-window-dots">
                    <span class="retro-window-dot close"></span>
                    <span class="retro-window-dot minimize"></span>
                    <span class="retro-window-dot maximize"></span>
                </div>
            </div>
            <div class="retro-window-body">
                <h2 class="mb-3 text-gradient">Welcome Back</h2>
                <p class="text-secondary mb-4" style="font-size: 0.95rem;">Enter credentials to initialize connection</p>
                <% if (request.getAttribute("errorMessage") != null) { %>
                    <div style="background: rgba(220, 53, 69, 0.15); border: 2px solid rgba(220, 53, 69, 0.4); color: #ff6b6b; padding: 12px 16px; border-radius: 4px; margin-bottom: 1.5rem; font-size: 0.95rem; font-family: 'JetBrains Mono', monospace;">
                        <i class="bi bi-exclamation-triangle-fill me-2"></i><%= request.getAttribute("errorMessage") %>
                    </div>
                <% } %>
                <form action="${pageContext.request.contextPath}/login" method="post">
                    <input type="text" name="id" class="form-control mb-3" placeholder="Student ID (or Admin ID)" required>
                    <div class="position-relative mb-3">
                        <input type="password" name="password" class="form-control mb-0" placeholder="Password" required style="padding-right: 40px;">
                        <button type="button" id="pwd-toggle" style="position: absolute; right: 5px; top: 50%; transform: translateY(-50%); background: transparent; border: none; color: var(--accent-blue); z-index: 10; padding: 10px;">
                            <i class="bi bi-eye-fill"></i>
                        </button>
                    </div>
                    <button type="submit" class="btn-retro w-100 justify-content-center mt-2"><span>Login</span></button>
                </form>
            </div>
        </div>
    </div>

    <script src="js/main.js"></script>
</body>
</html>
