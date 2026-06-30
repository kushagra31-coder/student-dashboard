<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="/WEB-INF/views/header.jsp" />

<!-- Hero Section -->
<section class="section-light">
    <div class="container text-center" style="max-width: 900px;">
        <h1 class="bangers-font" style="font-size: 5rem; line-height: 1.1; margin-bottom: 24px;">
            BUILD YOUR <span style="color: var(--brand);">FUTURE</span><br>
            ONE BLOCK AT A TIME
        </h1>
        <p class="fs-4 mb-5 fw-bold" style="color: var(--body-color);">
            AITR's next-generation student portfolio and achievement tracking system.
        </p>
        <div>
            <a href="${pageContext.request.contextPath}/register" class="nb-button me-3" style="font-size: 1.25rem;">
                GET STARTED
            </a>
            <a href="${pageContext.request.contextPath}/login" class="nb-button secondary" style="font-size: 1.25rem;">
                LOGIN TO CONSOLE
            </a>
        </div>
    </div>
</section>

<!-- Features Section -->
<section class="section-dark">
    <div class="container" style="max-width: 1200px;">
        <div class="text-center mb-5 pb-3">
            <h2 class="bangers-font" style="font-size: 3.5rem;">LEVEL UP YOUR CAREER</h2>
        </div>
        <div class="row g-4">
            <div class="col-md-4">
                <div class="nb-card h-100">
                    <h3 class="bangers-font" style="font-size: 2rem;">🏆 ACHIEVEMENTS</h3>
                    <p class="fw-bold mt-3">Log your hackathon wins, competitive programming ranks, and major academic milestones.</p>
                </div>
            </div>
            <div class="col-md-4">
                <div class="nb-card h-100">
                    <h3 class="bangers-font" style="font-size: 2rem;">🚀 PROJECTS</h3>
                    <p class="fw-bold mt-3">Showcase your best software engineering projects, GitHub repositories, and tech stacks.</p>
                </div>
            </div>
            <div class="col-md-4">
                <div class="nb-card h-100">
                    <h3 class="bangers-font" style="font-size: 2rem;">📄 VERIFIED DOCS</h3>
                    <p class="fw-bold mt-3">Store and share verified certificates and academic transcripts all in one secure place.</p>
                </div>
            </div>
        </div>
    </div>
</section>

<jsp:include page="/WEB-INF/views/footer.jsp" />