<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en" data-theme="dark">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sign Up - Student Dashboard</title>
    <meta name="description" content="Register as a new student to access the Student Portfolio Dashboard.">
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
        /* ── Register Page Specific ────────────────────────────────────────── */
        .register-wrapper {
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 40px 20px;
            position: relative;
            z-index: 1;
        }

        .register-card {
            max-width: 520px;
            width: 100%;
        }

        /* Two-column grid for form inputs */
        .form-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 14px;
        }
        .form-grid .full-width {
            grid-column: 1 / -1;
        }

        /* ID reveal box on success */
        .id-reveal-box {
            background: rgba(201, 168, 76, 0.08);
            border: 3px solid var(--accent-gold, #c9a84c);
            border-radius: 8px;
            padding: 24px 20px;
            text-align: center;
            margin: 20px 0;
            animation: pulse-gold 2s ease-in-out infinite;
        }
        .id-reveal-box .id-number {
            font-family: 'Audiowide', cursive;
            font-size: 3.5rem;
            color: var(--accent-gold, #c9a84c);
            line-height: 1;
            text-shadow: 0 0 30px rgba(201, 168, 76, 0.6);
        }
        .id-reveal-box .id-label {
            font-family: 'JetBrains Mono', monospace;
            font-size: 0.8rem;
            color: rgba(201, 168, 76, 0.7);
            text-transform: uppercase;
            letter-spacing: 2px;
            margin-top: 6px;
        }

        @keyframes pulse-gold {
            0%, 100% { box-shadow: 0 0 10px rgba(201, 168, 76, 0.2); }
            50%       { box-shadow: 0 0 30px rgba(201, 168, 76, 0.5); }
        }

        .warning-text {
            font-family: 'JetBrains Mono', monospace;
            font-size: 0.8rem;
            color: #ff6b6b;
            background: rgba(220, 53, 69, 0.1);
            border: 1px solid rgba(220, 53, 69, 0.3);
            border-radius: 4px;
            padding: 10px 14px;
        }

        .success-icon {
            width: 64px;
            height: 64px;
            background: rgba(22, 163, 74, 0.15);
            border: 2px solid rgba(22, 163, 74, 0.5);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 16px;
            font-size: 1.8rem;
            color: #4ade80;
        }

        /* Responsive stacking on small screens */
        @media (max-width: 480px) {
            .form-grid {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>

<!-- Particle Canvas Background -->
<canvas id="particle-canvas" style="position:fixed;top:0;left:0;width:100%;height:100%;z-index:0;pointer-events:none;"></canvas>

<div class="register-wrapper">
    <div class="register-card">

        <c:if test="${success}">
            <div class="retro-window fade-in-up text-center">
                <div class="retro-window-header">
                    <span class="retro-window-title">Registration Complete</span>
                    <div class="retro-window-dots">
                        <span class="retro-window-dot close"></span>
                        <span class="retro-window-dot minimize"></span>
                        <span class="retro-window-dot maximize"></span>
                    </div>
                </div>
                <div class="retro-window-body">
                    <div class="success-icon"><i class="bi bi-check-lg"></i></div>
                    <h2 class="text-gradient mb-2">Welcome, ${studentName}!</h2>
                    <p class="text-secondary mb-4" style="font-size: 0.95rem;">
                        Your account has been created successfully.
                    </p>

                    <p class="text-secondary" style="font-size: 0.9rem; margin-bottom: 8px;">Your unique login ID is:</p>
                    <div class="id-reveal-box">
                        <div class="id-number">${generatedId}</div>
                        <div class="id-label">Student ID — Save this number!</div>
                    </div>

                    <div class="warning-text mb-4">
                        <i class="bi bi-exclamation-triangle-fill me-2"></i>
                        <strong>Important:</strong> Write down your Student ID.
                        You will need <strong>ID: ${generatedId}</strong> and your password to log in.
                        This ID cannot be recovered if lost.
                    </div>

                    <a href="${pageContext.request.contextPath}/login" class="btn-retro w-100 justify-content-center">
                        <span><i class="bi bi-box-arrow-in-right me-2"></i>Proceed to Login</span>
                    </a>
                </div>
            </div>
        </c:if>

        <c:if test="${not success}">
            <div class="retro-window fade-in-up">
                <div class="retro-window-header">
                    <span class="retro-window-title">New User Registration</span>
                    <div class="retro-window-dots">
                        <span class="retro-window-dot close"></span>
                        <span class="retro-window-dot minimize"></span>
                        <span class="retro-window-dot maximize"></span>
                    </div>
                </div>
                <div class="retro-window-body">
                    <h2 class="mb-1 text-gradient">Create Account</h2>
                    <p class="text-secondary mb-4" style="font-size: 0.9rem;">
                        Register to get your unique Student ID and access your dashboard.
                    </p>

                    <!-- Error Message -->
                    <c:if test="${not empty errorMessage}">
                        <div style="background: rgba(220, 53, 69, 0.12); border: 2px solid rgba(220, 53, 69, 0.4);
                                    color: #ff6b6b; padding: 12px 16px; border-radius: 4px;
                                    margin-bottom: 1.25rem; font-size: 0.9rem;
                                    font-family: 'JetBrains Mono', monospace;">
                            <i class="bi bi-exclamation-triangle-fill me-2"></i>${errorMessage}
                        </div>
                    </c:if>

                    <form action="${pageContext.request.contextPath}/register" method="post" novalidate>
                        <div class="form-grid">

                            <!-- Full Name -->
                            <div class="full-width">
                                <label class="form-label text-secondary" style="font-size:0.8rem; font-family:'JetBrains Mono',monospace; text-transform:uppercase; letter-spacing:1px;">
                                    <i class="bi bi-person me-1"></i> Full Name <span style="color:#ff6b6b">*</span>
                                </label>
                                <input type="text" name="name" class="form-control"
                                       placeholder="e.g. Kushagra Tomar"
                                       value="<c:out value='${prevName}'/>" required>
                            </div>

                            <!-- Email -->
                            <div>
                                <label class="form-label text-secondary" style="font-size:0.8rem; font-family:'JetBrains Mono',monospace; text-transform:uppercase; letter-spacing:1px;">
                                    <i class="bi bi-envelope me-1"></i> Email <span style="color:#ff6b6b">*</span>
                                </label>
                                <input type="email" name="email" class="form-control"
                                       placeholder="you@college.ac.in"
                                       value="<c:out value='${prevEmail}'/>" required>
                            </div>

                            <!-- Phone -->
                            <div>
                                <label class="form-label text-secondary" style="font-size:0.8rem; font-family:'JetBrains Mono',monospace; text-transform:uppercase; letter-spacing:1px;">
                                    <i class="bi bi-phone me-1"></i> Phone
                                </label>
                                <input type="text" name="phone" class="form-control"
                                       placeholder="+91 9876543210"
                                       value="<c:out value='${prevPhone}'/>">
                            </div>

                            <!-- Branch -->
                            <div>
                                <label class="form-label text-secondary" style="font-size:0.8rem; font-family:'JetBrains Mono',monospace; text-transform:uppercase; letter-spacing:1px;">
                                    <i class="bi bi-mortarboard me-1"></i> Branch <span style="color:#ff6b6b">*</span>
                                </label>
                                <input type="text" name="branch" class="form-control"
                                       placeholder="B.Tech Computer Science"
                                       value="<c:out value='${prevBranch}'/>" required>
                            </div>

                            <!-- Semester -->
                            <div>
                                <label class="form-label text-secondary" style="font-size:0.8rem; font-family:'JetBrains Mono',monospace; text-transform:uppercase; letter-spacing:1px;">
                                    <i class="bi bi-calendar3 me-1"></i> Semester <span style="color:#ff6b6b">*</span>
                                </label>
                                <select name="semester" class="form-control form-select" required>
                                    <option value="" disabled <c:if test="${empty prevSemester}">selected</c:if>>Select Semester</option>
                                    <c:forEach var="i" begin="1" end="8">
                                        <option value="${i}" <c:if test="${prevSemester == i}">selected</c:if>>Semester ${i}</option>
                                    </c:forEach>
                                </select>
                            </div>

                            <!-- Password -->
                            <div>
                                <label class="form-label text-secondary" style="font-size:0.8rem; font-family:'JetBrains Mono',monospace; text-transform:uppercase; letter-spacing:1px;">
                                    <i class="bi bi-lock me-1"></i> Password <span style="color:#ff6b6b">*</span>
                                </label>
                                <div class="position-relative">
                                    <input type="password" name="password" id="reg-pwd"
                                           class="form-control" placeholder="Min. 6 characters"
                                           style="padding-right: 40px;" required>
                                    <button type="button" id="reg-pwd-toggle"
                                            style="position:absolute;right:5px;top:50%;transform:translateY(-50%);
                                                   background:transparent;border:none;color:var(--accent-blue);z-index:10;padding:10px;">
                                        <i class="bi bi-eye-fill"></i>
                                    </button>
                                </div>
                            </div>

                            <!-- Confirm Password -->
                            <div>
                                <label class="form-label text-secondary" style="font-size:0.8rem; font-family:'JetBrains Mono',monospace; text-transform:uppercase; letter-spacing:1px;">
                                    <i class="bi bi-shield-lock me-1"></i> Confirm Password <span style="color:#ff6b6b">*</span>
                                </label>
                                <div class="position-relative">
                                    <input type="password" name="confirmPassword" id="reg-cpwd"
                                           class="form-control" placeholder="Re-enter password"
                                           style="padding-right: 40px;" required>
                                    <button type="button" id="reg-cpwd-toggle"
                                            style="position:absolute;right:5px;top:50%;transform:translateY(-50%);
                                                   background:transparent;border:none;color:var(--accent-blue);z-index:10;padding:10px;">
                                        <i class="bi bi-eye-fill"></i>
                                    </button>
                                </div>
                            </div>

                        </div><!-- /.form-grid -->

                        <!-- Password Match Hint -->
                        <div id="pwd-match-hint" class="mt-2" style="font-family:'JetBrains Mono',monospace; font-size:0.78rem; display:none;"></div>

                        <button type="submit" class="btn-retro w-100 justify-content-center mt-4" id="submit-btn">
                            <span><i class="bi bi-person-plus me-2"></i>Create Account</span>
                        </button>
                    </form>

                    <!-- Back to Login -->
                    <p class="mt-4 mb-0 text-center text-secondary" style="font-size: 0.9rem;">
                        Already have an account?
                        <a href="${pageContext.request.contextPath}/login"
                           class="text-gradient"
                           style="text-decoration: none; font-weight: 600;">
                            Log In
                        </a>
                    </p>
                </div>
            </div>
        </c:if>

    </div>
</div>

<script src="js/main.js"></script>
<script>
// ── Password show/hide toggles ──────────────────────────────────────────────
function makeToggle(btnId, inputId) {
    const btn   = document.getElementById(btnId);
    const input = document.getElementById(inputId);
    if (!btn || !input) return;
    btn.addEventListener('click', () => {
        const isPassword = input.type === 'password';
        input.type = isPassword ? 'text' : 'password';
        btn.querySelector('i').className = isPassword ? 'bi bi-eye-slash-fill' : 'bi bi-eye-fill';
    });
}
makeToggle('reg-pwd-toggle',  'reg-pwd');
makeToggle('reg-cpwd-toggle', 'reg-cpwd');

// ── Live password match indicator ───────────────────────────────────────────
const pwdInput  = document.getElementById('reg-pwd');
const cpwdInput = document.getElementById('reg-cpwd');
const matchHint = document.getElementById('pwd-match-hint');

function checkMatch() {
    if (!cpwdInput || !pwdInput || !matchHint) return;
    const pwd  = pwdInput.value;
    const cpwd = cpwdInput.value;
    if (cpwd.length === 0) { matchHint.style.display = 'none'; return; }
    matchHint.style.display = 'block';
    if (pwd === cpwd) {
        matchHint.style.color = '#4ade80';
        matchHint.innerHTML   = '<i class="bi bi-check-circle-fill me-1"></i> Passwords match';
    } else {
        matchHint.style.color = '#ff6b6b';
        matchHint.innerHTML   = '<i class="bi bi-x-circle-fill me-1"></i> Passwords do not match';
    }
}
if (pwdInput)  pwdInput.addEventListener('input', checkMatch);
if (cpwdInput) cpwdInput.addEventListener('input', checkMatch);
</script>
</body>
</html>
