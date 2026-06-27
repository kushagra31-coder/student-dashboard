<%@ page contentType="text/html;charset=UTF-8" language="java" %>


<footer class="footer-glass">
    <div class="container">
        <div class="row align-items-center gy-3">
            <div class="col-md-4">
                <span class="footer-brand">
                    <i class="bi bi-mortarboard-fill me-1"></i>StudentDash
                </span>
            </div>
            <div class="col-md-4 text-md-center">
                <ul class="footer-links justify-content-md-center">
                    <li><a href="${pageContext.request.contextPath}/home">Home</a></li>
                    <li><a href="${pageContext.request.contextPath}/students">Students</a></li>
                    <li><a href="${pageContext.request.contextPath}/projects">Projects</a></li>
                    <li><a href="${pageContext.request.contextPath}/contact">Contact</a></li>
                </ul>
            </div>
            <div class="col-md-4 text-md-end">
                <p class="footer-text mb-0">&copy; 2026 StudentDash. All rights reserved.</p>
            </div>
        </div>
    </div>
</footer>


<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

<script src="${pageContext.request.contextPath}/js/main.js"></script>
</body>
</html>
