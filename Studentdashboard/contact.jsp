<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<%-- Include Header --%>
<%@ include file="/WEB-INF/views/header.jsp" %>

<!-- ============ PAGE WRAPPER ============ -->
<main class="page-wrapper">

    <!-- ============ PAGE HEADER ============ -->
    <section class="page-header">
        <div class="container text-center">
            <h1 class="section-title fade-in-up">
                <i class="bi bi-envelope-paper-fill me-2"></i>Contact Us
            </h1>
            <p class="section-subtitle fade-in-up delay-1">
                Have a question or want to collaborate? Drop us a message!
            </p>
        </div>
    </section>

    <!-- ============ CONTACT SECTION ============ -->
    <section class="pb-5">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-lg-8 col-xl-7">

                    <!-- Success / Error Messages -->
                    <c:if test="${not empty successMsg}">
                        <div class="alert-glass alert-glass-success mb-4 fade-in-up">
                            <i class="bi bi-check-circle-fill me-2"></i>
                            <c:out value="${successMsg}"/>
                        </div>
                    </c:if>
                    <c:if test="${not empty errorMsg}">
                        <div class="alert-glass alert-glass-error mb-4 fade-in-up">
                            <i class="bi bi-exclamation-triangle-fill me-2"></i>
                            <c:out value="${errorMsg}"/>
                        </div>
                    </c:if>

                    <!-- Contact Form -->
                    <div class="glass-card contact-form fade-in-up">
                        <form id="contactForm"
                              action="${pageContext.request.contextPath}/contact"
                              method="POST" novalidate>

                            <!-- Name -->
                            <div class="mb-4">
                                <label for="name" class="form-label">
                                    <i class="bi bi-person me-1"></i>Full Name
                                </label>
                                <input type="text" class="form-control form-control-lg" id="name" name="name"
                                       placeholder="Enter your name" required>
                            </div>

                            <!-- Email -->
                            <div class="mb-4">
                                <label for="email" class="form-label">
                                    <i class="bi bi-envelope me-1"></i>Email Address
                                </label>
                                <input type="email" class="form-control form-control-lg" id="email" name="email"
                                       placeholder="you@example.com" required>
                            </div>

                            <!-- Subject -->
                            <div class="mb-4">
                                <label for="subject" class="form-label">
                                    <i class="bi bi-chat-left-text me-1"></i>Subject
                                </label>
                                <input type="text" class="form-control form-control-lg" id="subject" name="subject"
                                       placeholder="What's this about?" required>
                            </div>

                            <!-- Message -->
                            <div class="mb-4">
                                <label for="message" class="form-label">
                                    <i class="bi bi-pencil-square me-1"></i>Your Message
                                </label>
                                <textarea class="form-control form-control-lg" id="message" name="message"
                                          rows="6" placeholder="Write your message here..." required></textarea>
                            </div>

                            <!-- Submit -->
                            <button type="submit" class="btn-glow w-100" style="padding: 1rem;">
                                <i class="bi bi-send-fill me-2"></i>Send Message
                            </button>
                        </form>
                    </div>

                    <!-- Contact Info Cards -->
                    <div class="row g-4 mt-4 stagger-children">
                        <div class="col-md-4 fade-in-up">
                            <div class="glass-card p-4 text-center">
                                <i class="bi bi-geo-alt-fill text-gradient" style="font-size: 2rem;"></i>
                                <h6 class="mt-3 mb-1">Location</h6>
                                <p class="mb-0" style="color: var(--text-muted); font-size: 0.95rem;">
                                    Acropolis, Indore, India
                                </p>
                            </div>
                        </div>
                        <div class="col-md-4 fade-in-up">
                            <div class="glass-card p-4 text-center">
                                <i class="bi bi-envelope-fill text-gradient" style="font-size: 2rem;"></i>
                                <h6 class="mt-3 mb-1">Email</h6>
                                <p class="mb-0" style="color: var(--text-muted); font-size: 0.95rem;">
                                    kushagrasingh240033@acropolis.in
                                </p>
                            </div>
                        </div>
                        <div class="col-md-4 fade-in-up">
                            <div class="glass-card p-4 text-center">
                                <i class="bi bi-telephone-fill text-gradient" style="font-size: 2rem;"></i>
                                <h6 class="mt-3 mb-1">Phone</h6>
                                <p class="mb-0" style="color: var(--text-muted); font-size: 0.95rem;">
                                    +91 8435841607
                                </p>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
        </div>
    </section>

</main>

<%@ include file="/WEB-INF/views/footer.jsp" %>
