USE portfolio_db;

DELETE FROM certificates;

-- Student 1 (Kushagra)
INSERT INTO certificates (student_id, title, file_path) VALUES 
(1, 'AWS Certified Solutions Architect', 'certificates/aws_architect.pdf'),
(1, 'Google Cloud Professional Developer', 'certificates/gcp_developer.pdf');

-- Student 2 (Bhagyesh)
INSERT INTO certificates (student_id, title, file_path) VALUES 
(2, 'Google UX Design Professional', 'certificates/google_ux.pdf'),
(2, 'Meta Front-End Developer', 'certificates/meta_frontend.pdf');

-- Student 3 (Harshit)
INSERT INTO certificates (student_id, title, file_path) VALUES 
(3, 'Oracle Certified Professional, Java SE', 'certificates/oracle_java.pdf'),
(3, 'MongoDB Certified Developer Associate', 'certificates/mongodb_dev.pdf');
