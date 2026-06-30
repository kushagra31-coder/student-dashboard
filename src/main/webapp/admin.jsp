<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - AITR</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body class="section-light" style="padding: 0;">
    <jsp:include page="/WEB-INF/views/header.jsp" />

    <div class="container my-5">
        <div class="mb-5 border-bottom border-dark border-3 pb-4 d-flex justify-content-between align-items-center">
            <div>
                <h1 class="bangers-font" style="font-size: 3rem; color: var(--brand);">ADMIN CONSOLE</h1>
                <p class="fs-5 fw-bold mb-0 text-uppercase">System Overview & Management</p>
            </div>
            <a href="${pageContext.request.contextPath}/logout" class="nb-button secondary">
                <i class="bi bi-box-arrow-right me-2"></i> LOGOUT
            </a>
        </div>
        
        <c:if test="${not empty errorMessage}">
            <div class="nb-badge danger w-100 p-2 mb-4 fs-6 text-center">
                ${errorMessage}
            </div>
        </c:if>

        <c:if test="${not empty successMessage}">
            <div class="nb-badge success w-100 p-2 mb-4 fs-6 text-center">
                ${successMessage}
            </div>
        </c:if>

        <!-- Students Section -->
        <section class="mb-5">
            <h2 class="bangers-font mb-4" style="font-size: 2.5rem;">REGISTERED STUDENTS</h2>
            <div class="nb-card p-0 overflow-hidden">
                <div class="table-responsive">
                    <table class="table table-hover mb-0 fw-bold" style="border-collapse: separate; border-spacing: 0;">
                        <thead style="background: var(--neutral-primary-soft);">
                            <tr class="text-uppercase" style="border-bottom: 4px solid var(--border-default);">
                                <th>ID</th>
                                <th>Photo</th>
                                <th>Name</th>
                                <th>Email</th>
                                <th>Branch</th>
                                <th>Sem</th>
                                <th>Role</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="student" items="${students}">
                                <tr>
                                    <td class="align-middle">${student.id}</td>
                                    <td class="align-middle">
                                        <img src="${pageContext.request.contextPath}/${not empty student.photoPath ? student.photoPath : 'images/student1.jpg'}" 
                                             class="rounded-circle" width="40" height="40" style="object-fit: cover; border: 2px solid var(--border-default);"
                                             onerror="this.src='${pageContext.request.contextPath}/images/student1.jpg'">
                                    </td>
                                    <td class="align-middle">${student.name}</td>
                                    <td class="align-middle">${student.email}</td>
                                    <td class="align-middle">${student.branch}</td>
                                    <td class="align-middle">
                                        <span class="nb-badge brand">SEM ${student.semester}</span>
                                    </td>
                                    <td class="align-middle">
                                        <span class="nb-badge ${student.role == 'admin' ? 'success' : ''}">${student.role}</span>
                                    </td>
                                    <td class="align-middle">
                                        <form action="${pageContext.request.contextPath}/admin-action" method="post" class="d-inline">
                                            <input type="hidden" name="action" value="deleteStudent">
                                            <input type="hidden" name="studentId" value="${student.id}">
                                            <button type="submit" class="nb-button" style="padding: 6px 12px; font-size: 14px; background: var(--danger);" onclick="return confirm('Delete this student?')">
                                                <i class="bi bi-trash"></i>
                                            </button>
                                        </form>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </section>

        <!-- System Logs Section -->
        <section class="mb-5">
            <h2 class="bangers-font mb-4" style="font-size: 2.5rem;">SYSTEM LOGINS</h2>
            <div class="nb-card p-0 overflow-hidden">
                <div class="table-responsive">
                    <table class="table mb-0 fw-bold">
                        <thead style="background: var(--neutral-primary-soft);">
                            <tr class="text-uppercase" style="border-bottom: 4px solid var(--border-default);">
                                <th>User ID</th>
                                <th>Name</th>
                                <th>Role</th>
                                <th>IP Address</th>
                                <th>Time</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="log" items="${loginLogs}">
                                <tr>
                                    <td>${log.userId}</td>
                                    <td>${log.userName}</td>
                                    <td><span class="nb-badge ${log.role == 'admin' ? 'success' : ''}">${log.role}</span></td>
                                    <td><span class="font-monospace text-muted">${log.ipAddress}</span></td>
                                    <td>${log.loginTime}</td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </section>

    </div>
    
    <jsp:include page="/WEB-INF/views/footer.jsp" />
</body>
</html>