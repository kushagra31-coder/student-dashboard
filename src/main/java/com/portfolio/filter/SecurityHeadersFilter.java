package com.portfolio.filter;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebFilter("/*")
public class SecurityHeadersFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {}

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        
        HttpServletResponse res = (HttpServletResponse) response;
        
        // Prevent Clickjacking
        res.setHeader("X-Frame-Options", "DENY");
        
        // Enable Browser XSS Filter
        res.setHeader("X-XSS-Protection", "1; mode=block");
        
        // Prevent MIME Sniffing
        res.setHeader("X-Content-Type-Options", "nosniff");
        
        // Strict Transport Security (HSTS) - For Azure/Aiven HTTPS deployments
        res.setHeader("Strict-Transport-Security", "max-age=31536000; includeSubDomains");
        
        // Basic Content Security Policy (allows self scripts/styles and fonts, restricts dangerous external injections)
        res.setHeader("Content-Security-Policy", "default-src 'self' https: data: 'unsafe-inline' 'unsafe-eval'; frame-ancestors 'none';");
        
        // Cache Control for API/Dynamic endpoints can be added in specific servlets, 
        // but generally we shouldn't cache the whole site.
        
        chain.doFilter(request, response);
    }

    @Override
    public void destroy() {}
}