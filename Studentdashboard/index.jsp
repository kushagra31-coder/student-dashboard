<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    // Immediately redirect based on session auth status
    jakarta.servlet.http.HttpSession sess = request.getSession(false);
    if (sess == null || sess.getAttribute("studentId") == null) {
        response.sendRedirect(request.getContextPath() + "/login");
    } else {
        String role = (String) sess.getAttribute("studentRole");
        if ("admin".equals(role)) {
            response.sendRedirect(request.getContextPath() + "/admin");
        } else {
            response.sendRedirect(request.getContextPath() + "/home");
        }
    }
%>
