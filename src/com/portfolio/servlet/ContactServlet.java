package com.portfolio.servlet;

import com.portfolio.dao.ContactDAO;
import com.portfolio.model.ContactMessage;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

/**
 * Handles the contact-us form: shows the page on GET and processes
 * the submission on POST.
 */
@WebServlet(name = "ContactServlet", urlPatterns = {"/contact"})
public class ContactServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private final ContactDAO contactDAO = new ContactDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setAttribute("currentPage", "contact");
        request.getRequestDispatcher("/contact.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Ensure correct encoding for multi-byte characters.
        request.setCharacterEncoding("UTF-8");

        // Read form parameters.
        String name    = request.getParameter("name");
        String email   = request.getParameter("email");
        String subject = request.getParameter("subject");
        String message = request.getParameter("message");

        // Build the model object.
        ContactMessage msg = new ContactMessage();
        msg.setName(name);
        msg.setEmail(email);
        msg.setSubject(subject);
        msg.setMessage(message);

        // Persist and set feedback attribute.
        boolean saved = contactDAO.saveMessage(msg);

        if (saved) {
            request.setAttribute("successMsg",
                    "Thank you! Your message has been sent successfully.");
        } else {
            request.setAttribute("errorMsg",
                    "Sorry, something went wrong. Please try again later.");
        }

        // Forward back to the contact page so the user sees the result.
        request.setAttribute("currentPage", "contact");
        request.getRequestDispatcher("/contact.jsp").forward(request, response);
    }
}
