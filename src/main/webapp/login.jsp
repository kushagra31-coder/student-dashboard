<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - AITR Portfolio</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="css/style.css">
</head>
<body class="section-light d-flex align-items-center justify-content-center" style="min-height: 100vh; padding: 0;">
    <div class="container" style="max-width: 450px;">
        <div class="text-center mb-5">
            <h1 class="bangers-font" style="font-size: 4rem; color: var(--brand);">AITR DASH</h1>
            <p class="fw-bold text-uppercase">Student & Admin Portal</p>
        </div>

        <div class="nb-card">
            <h2 class="bangers-font text-center mb-4">ACCESS CONSOLE</h2>
            
            <c:if test="${not empty errorMessage}">
                <div class="nb-badge danger w-100 text-center mb-3 p-2" style="font-size: 14px;">
                    ${errorMessage}
                </div>
            </c:if>

            <form action="${pageContext.request.contextPath}/login" method="post">
                <div class="mb-4">
                    <label class="nb-label" for="id">User ID</label>
                    <input type="text" class="nb-input" id="id" name="id" placeholder="Student ID or Admin ID" required>
                </div>
                
                <div class="mb-4">
                    <label class="nb-label" for="password">Password</label>
                    <input type="password" class="nb-input" id="password" name="password" placeholder="••••••••" required>
                </div>

                <div class="d-grid mt-4">
                    <button type="submit" class="nb-button w-100">
                        LOGIN <i class="bi bi-arrow-right ms-2"></i>
                    </button>
                </div>
            </form>
            
            <div class="text-center mt-4 pt-4" style="border-top: 2px dashed var(--border-default);">
                <p class="mb-0 fw-bold">NEW HERE? <a href="${pageContext.request.contextPath}/register">REGISTER NOW</a></p>
            </div>
        </div>
    </div>
</body>
</html>