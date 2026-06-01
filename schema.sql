-- ============================================
-- Portfolio Database Schema
-- Dynamic JSP Student Portfolio Dashboard
-- ============================================

CREATE DATABASE IF NOT EXISTS portfolio_db;
USE portfolio_db;

-- ============================================
-- Students Table
-- ============================================
DROP TABLE IF EXISTS contact_messages;
DROP TABLE IF EXISTS projects;
DROP TABLE IF EXISTS skills;
DROP TABLE IF EXISTS students;

CREATE TABLE students (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    branch VARCHAR(100) NOT NULL,
    role VARCHAR(100) NOT NULL,
    bio TEXT,
    github_url VARCHAR(255),
    linkedin_url VARCHAR(255),
    resume_url VARCHAR(255),
    photo_path VARCHAR(255)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ============================================
-- Projects Table
-- ============================================
CREATE TABLE projects (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(200) NOT NULL,
    description TEXT,
    tech_stack VARCHAR(300),
    github_url VARCHAR(255),
    live_demo_url VARCHAR(255),
    image_path VARCHAR(255),
    student_id INT,
    FOREIGN KEY (student_id) REFERENCES students(id) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ============================================
-- Skills Table
-- ============================================
CREATE TABLE skills (
    id INT AUTO_INCREMENT PRIMARY KEY,
    category VARCHAR(50) NOT NULL,
    name VARCHAR(100) NOT NULL,
    proficiency_percent INT DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ============================================
-- Contact Messages Table
-- ============================================
CREATE TABLE contact_messages (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(150) NOT NULL,
    subject VARCHAR(200),
    message TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ============================================
-- Seed Data: 3 Students
-- ============================================
INSERT INTO students (name, branch, role, bio, github_url, linkedin_url, resume_url, photo_path) VALUES
(
    'Kushagra Tomar',
    'Computer Science & Engineering',
    'Full-Stack Developer',
    'Passionate full-stack developer with expertise in Java, Spring Boot, and React. Loves building scalable web applications and contributing to open-source projects. Currently exploring cloud-native architectures and microservices.',
    'https://github.com/kushagratomar',
    'https://linkedin.com/in/kushagratomar',
    '#',
    'images/student1.jpg'
),
(
    'Priya Sharma',
    'Information Technology',
    'UI/UX Designer & Frontend Dev',
    'Creative designer and frontend developer with a keen eye for aesthetics. Specializes in creating intuitive user interfaces using Figma, React, and modern CSS. Believer in design-driven development and accessibility-first approach.',
    'https://github.com/priyasharma',
    'https://linkedin.com/in/priyasharma',
    '#',
    'images/student2.jpg'
),
(
    'Rahul Verma',
    'Computer Science & Engineering',
    'Backend Engineer & DevOps',
    'Backend engineering enthusiast with deep knowledge of Python, Django, and AWS. Experienced in building RESTful APIs, CI/CD pipelines, and containerized deployments. Advocates for clean code and test-driven development.',
    'https://github.com/rahulverma',
    'https://linkedin.com/in/rahulverma',
    '#',
    'images/student3.jpg'
);

-- ============================================
-- Seed Data: Projects (2 per student)
-- ============================================
INSERT INTO projects (title, description, tech_stack, github_url, live_demo_url, image_path, student_id) VALUES
(
    'E-Commerce Platform',
    'A full-featured online shopping platform with product catalog, cart management, payment integration via Stripe, and real-time order tracking. Built with microservices architecture for scalability.',
    'Java, Spring Boot, React, MySQL, Docker',
    'https://github.com/kushagratomar/ecommerce',
    'https://ecommerce-demo.example.com',
    'images/project1.jpg',
    1
),
(
    'AI Chat Assistant',
    'An intelligent chatbot powered by natural language processing that can answer questions, summarize documents, and assist with code debugging. Features a sleek conversational UI with markdown support.',
    'Python, FastAPI, OpenAI API, React, Redis',
    'https://github.com/kushagratomar/ai-chat',
    'https://ai-chat-demo.example.com',
    'images/project2.jpg',
    1
),
(
    'Portfolio Design System',
    'A comprehensive design system and component library built for rapid prototyping. Includes 50+ reusable components, dark/light themes, and interactive Storybook documentation.',
    'React, TypeScript, Storybook, Figma, CSS Modules',
    'https://github.com/priyasharma/design-system',
    'https://design-system-demo.example.com',
    'images/project3.jpg',
    2
),
(
    'Health & Fitness Tracker',
    'A mobile-first web app for tracking workouts, nutrition, and health metrics. Features interactive charts, goal setting, and social sharing. Designed with accessibility and usability in mind.',
    'Vue.js, Node.js, MongoDB, Chart.js, PWA',
    'https://github.com/priyasharma/fitness-tracker',
    'https://fitness-demo.example.com',
    'images/project1.jpg',
    2
),
(
    'Cloud Infrastructure Monitor',
    'Real-time cloud infrastructure monitoring dashboard with alerting, log aggregation, and cost analytics. Supports AWS, GCP, and Azure with unified metrics visualization.',
    'Python, Django, Grafana, Prometheus, Docker, Terraform',
    'https://github.com/rahulverma/cloud-monitor',
    'https://cloud-monitor-demo.example.com',
    'images/project2.jpg',
    3
),
(
    'CI/CD Pipeline Builder',
    'A visual drag-and-drop pipeline builder for creating automated CI/CD workflows. Supports GitHub Actions, Jenkins, and GitLab CI with template marketplace and YAML export.',
    'Go, React, PostgreSQL, Docker, Kubernetes',
    'https://github.com/rahulverma/pipeline-builder',
    'https://pipeline-builder-demo.example.com',
    'images/project3.jpg',
    3
);

-- ============================================
-- Seed Data: Skills
-- ============================================
INSERT INTO skills (category, name, proficiency_percent) VALUES
-- Frontend
('Frontend', 'HTML5 & CSS3', 95),
('Frontend', 'JavaScript (ES6+)', 90),
('Frontend', 'React.js', 88),
('Frontend', 'Vue.js', 75),
('Frontend', 'Bootstrap / Tailwind', 92),
-- Backend
('Backend', 'Java & Spring Boot', 90),
('Backend', 'Python & Django', 85),
('Backend', 'Node.js & Express', 80),
('Backend', 'REST API Design', 92),
('Backend', 'Go', 65),
-- Database
('Database', 'MySQL', 90),
('Database', 'PostgreSQL', 85),
('Database', 'MongoDB', 78),
('Database', 'Redis', 72),
-- Tools
('Tools', 'Git & GitHub', 95),
('Tools', 'Docker & Kubernetes', 82),
('Tools', 'AWS / GCP', 78),
('Tools', 'CI/CD Pipelines', 80),
('Tools', 'Linux & Shell', 88);
