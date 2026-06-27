package com.portfolio.filter;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebFilter("/*")
public class AuthFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;

        String path = req.getRequestURI().substring(req.getContextPath().length());

        boolean isProtected = path.equals("/home") || path.equals("/dashboard")
                || path.equals("/admin") || path.equals("/documents")
                || path.equals("/students") || path.equals("/projects");

        if (isProtected) {
            HttpSession session = req.getSession(false);
            if (session == null || session.getAttribute("studentId") == null) {
                res.sendRedirect(req.getContextPath() + "/login");
                return;
            }

            // Extra check: only admins may access /admin, /students, /projects
            if (path.equals("/admin") || path.equals("/students") || path.equals("/projects")) {
                String role = (String) session.getAttribute("studentRole");
                if (!"admin".equals(role)) {
                    res.sendRedirect(req.getContextPath() + "/home");
                    return;
                }
            }
        }

        // Allow all other requests (like /login, /contact, /css/*, etc.)
        chain.doFilter(request, response);
    }

    @Override
    public void destroy() {
    }
}
