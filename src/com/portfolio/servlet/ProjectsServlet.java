package com.portfolio.servlet;

import com.portfolio.dao.ProjectDAO;
import com.portfolio.model.Project;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

/**
 * Serves the projects listing page.
 */
@WebServlet(name = "ProjectsServlet", urlPatterns = {"/projects"})
public class ProjectsServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private final ProjectDAO projectDAO = new ProjectDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Project> projects = projectDAO.getAllProjects();
        request.setAttribute("currentPage", "projects");
        request.setAttribute("projects", projects);

        request.getRequestDispatcher("/projects.jsp").forward(request, response);
    }
}
