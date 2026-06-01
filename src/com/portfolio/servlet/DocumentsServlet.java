package com.portfolio.servlet;

import com.portfolio.dao.DocumentDAO;
import com.portfolio.model.Document;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet("/documents")
public class DocumentsServlet extends HttpServlet {

    private final DocumentDAO documentDAO = new DocumentDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("studentId") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        int studentId = (int) session.getAttribute("studentId");
        String studentName = (String) session.getAttribute("studentName");

        List<Document> documents = documentDAO.getDocumentsByStudentId(studentId);

        request.setAttribute("documents", documents);
        request.setAttribute("studentName", studentName);

        request.getRequestDispatcher("/documents.jsp").forward(request, response);
    }
}
