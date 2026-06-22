<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login – Student Dashboard</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Audiowide&family=JetBrains+Mono:wght@400;500;700&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
    <style>
        /* ── All styles self-contained — no external CSS dependency ── */
        *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }

        html, body {
            min-height: 100vh;
            background: #0d0d1a;
            font-family: 'JetBrains Mono', monospace;
        }

        /* Subtle star-speckle background */
        body {
            background-image:
                radial-gradient(circle, rgba(255,255,255,0.06) 1px, transparent 1px),
                radial-gradient(circle, rgba(219,39,119,0.04) 1px, transparent 1px);
            background-size: 60px 60px, 120px 120px;
        }

        .login-wrapper {
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 24px;
        }

        /* ── THE CARD (matches original screenshot exactly) ── */
        .login-card {
            width: 100%;
            max-width: 380px;
            background: #ffffff;
            border: 2.5px solid #111111;
            border-radius: 8px;
            box-shadow: 5px 5px 0px #111111;
            overflow: hidden;
            animation: fadeUp 0.4s ease both;
        }
        @keyframes fadeUp {
            from { opacity:0; transform: translateY(20px); }
            to   { opacity:1; transform: translateY(0);    }
        }

        /* Title bar */
        .card-titlebar {
            background: #f4f4f4;
            border-bottom: 2px solid #111111;
            padding: 9px 16px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            font-size: 0.78rem;
            font-weight: 700;
            letter-spacing: 1px;
            color: #333;
        }
        .titlebar-dots { display: flex; gap: 6px; }
        .titlebar-dots span { width: 12px; height: 12px; border-radius: 50%; display: block; }
        .dot-r { background: #ff5f57; }
        .dot-y { background: #febc2e; }
        .dot-g { background: #28c840; }

        /* Card body */
        .card-body-inner { padding: 30px 28px 26px; }

        h2.login-heading {
            font-family: 'Audiowide', cursive;
            font-size: 1.6rem;
            text-align: center;
            background: linear-gradient(135deg, #db2777, #9333ea);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            margin-bottom: 6px;
        }
        .login-sub {
            text-align: center;
            color: #888;
            font-size: 0.82rem;
            margin-bottom: 24px;
        }

        /* Error */
        .error-box {
            background: rgba(220,53,69,0.08);
            border: 1.5px solid rgba(220,53,69,0.35);
            color: #dc2626;
            padding: 10px 14px;
            border-radius: 4px;
            margin-bottom: 14px;
            font-size: 0.82rem;
        }

        /* Inputs */
        .login-input {
            width: 100%;
            background: #ffffff;
            border: 1.5px solid #cccccc;
            border-radius: 4px;
            padding: 10px 14px;
            font-family: 'JetBrains Mono', monospace;
            font-size: 0.88rem;
            color: #111;
            outline: none;
            margin-bottom: 12px;
            display: block;
            transition: border-color 0.2s;
        }
        .login-input:focus   { border-color: #db2777; box-shadow: 0 0 0 3px rgba(219,39,119,0.1); }
        .login-input::placeholder { color: #aaa; }

        /* Password wrapper */
        .pwd-wrap           { position: relative; margin-bottom: 12px; }
        .pwd-wrap .login-input { margin-bottom: 0; padding-right: 42px; }
        .pwd-eye {
            position: absolute; right: 10px; top: 50%;
            transform: translateY(-50%);
            background: none; border: none;
            color: #999; cursor: pointer; font-size: 1rem;
            transition: color 0.2s;
        }
        .pwd-eye:hover { color: #db2777; }

        /* Login button */
        .login-btn {
            width: 100%;
            padding: 12px;
            background: #db2777;
            color: #fff;
            border: none;
            border-radius: 4px;
            font-family: 'JetBrains Mono', monospace;
            font-size: 0.88rem;
            font-weight: 700;
            letter-spacing: 3px;
            text-transform: uppercase;
            cursor: pointer;
            margin-top: 6px;
            transition: opacity 0.2s, transform 0.15s;
        }
        .login-btn:hover { opacity: 0.9; transform: translateY(-1px); }

        /* ── SIGN UP ROW — clearly visible ── */
        .signup-row {
            margin-top: 20px;
            padding-top: 18px;
            border-top: 1.5px solid #eeeeee;
            text-align: center;
            font-size: 0.84rem;
            color: #777;
        }
        .signup-row a {
            color: #db2777;
            font-weight: 700;
            text-decoration: none;
            margin-left: 4px;
        }
        .signup-row a:hover { text-decoration: underline; }
    </style>
</head>
<body>

<div class="login-wrapper">
    <div class="login-card">

        <!-- Title bar — matches original screenshot -->
        <div class="card-titlebar">
            <span>Access Terminal</span>
            <div class="titlebar-dots">
                <span class="dot-r"></span>
                <span class="dot-y"></span>
                <span class="dot-g"></span>
            </div>
        </div>

        <!-- Body -->
        <div class="card-body-inner">
            <h2 class="login-heading">Welcome Back</h2>
            <p class="login-sub">Enter credentials to initialize connection</p>

            <!-- Error message -->
            <% if (request.getAttribute("errorMessage") != null) { %>
                <div class="error-box">
                    <i class="bi bi-exclamation-triangle-fill me-2"></i>
                    <%= request.getAttribute("errorMessage") %>
                </div>
            <% } %>

            <!-- Form -->
            <form action="${pageContext.request.contextPath}/login" method="post">
                <input type="text" name="id" class="login-input"
                       placeholder="Student ID (or Admin ID)" required>

                <div class="pwd-wrap">
                    <input type="password" name="password" id="pwd"
                           class="login-input" placeholder="Password" required>
                    <button type="button" class="pwd-eye" id="pwd-btn">
                        <i class="bi bi-eye-fill" id="pwd-icon"></i>
                    </button>
                </div>

                <button type="submit" class="login-btn">Login</button>
            </form>

            <!-- ── New here? Sign Up ──────────────────────── -->
            <div class="signup-row">
                New here?
                <a href="${pageContext.request.contextPath}/register">Sign Up</a>
            </div>

        </div>
    </div>
</div>

<script>
    const btn  = document.getElementById('pwd-btn');
    const pwd  = document.getElementById('pwd');
    const icon = document.getElementById('pwd-icon');
    if (btn) {
        btn.addEventListener('click', () => {
            const show = pwd.type === 'password';
            pwd.type   = show ? 'text' : 'password';
            icon.className = show ? 'bi bi-eye-slash-fill' : 'bi bi-eye-fill';
        });
    }
</script>
</body>
</html>
