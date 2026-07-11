package com.portfolio.filter;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.concurrent.ConcurrentHashMap;

@WebFilter("/*")
public class RateLimitFilter implements Filter {

    private static final int MAX_REQUESTS_PER_MINUTE = 30;
    // Map of IP Address to [Count, Timestamp]
    private ConcurrentHashMap<String, long[]> requestCounts = new ConcurrentHashMap<>();

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {}

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;
        
        // Skip rate limiting for static resources
        String path = req.getRequestURI();
        if (path.startsWith(req.getContextPath() + "/css/") || 
            path.startsWith(req.getContextPath() + "/js/") ||
            path.startsWith(req.getContextPath() + "/images/")) {
            chain.doFilter(request, response);
            return;
        }

        String clientIp = getClientIp(req);
        long currentTime = System.currentTimeMillis();
        
        requestCounts.compute(clientIp, (ip, data) -> {
            if (data == null || (currentTime - data[1]) > 60000) {
                // First request or reset after 1 minute
                return new long[]{1, currentTime};
            } else {
                // Increment count
                data[0]++;
                return data;
            }
        });

        long currentCount = requestCounts.get(clientIp)[0];
        
        if (currentCount > MAX_REQUESTS_PER_MINUTE) {
            res.setStatus(429); // 429 Too Many Requests
            res.getWriter().write("Too Many Requests. Please wait 1 minute before trying again.");
            return;
        }

        chain.doFilter(request, response);
    }

    private String getClientIp(HttpServletRequest request) {
        String xForwardedFor = request.getHeader("X-Forwarded-For");
        if (xForwardedFor != null && !xForwardedFor.isEmpty()) {
            return xForwardedFor.split(",")[0].trim();
        }
        return request.getRemoteAddr();
    }

    @Override
    public void destroy() {}
}