USE portfolio_db;

-- Delete old data to avoid duplicates if re-run
DELETE FROM projects;
DELETE FROM contact_messages;

-- Insert Fake Projects for Student 1 (Kushagra)
INSERT INTO projects (student_id, title, description, tech_stack, github_url, live_demo_url, image_path) VALUES
(1, 'AI-Powered Chat Assistant', 'A contextual chatbot utilizing NLP models to assist students with university queries and course selections in real-time.', 'Python, TensorFlow, React, Node.js', 'https://github.com/kushagra/ai-chat', 'https://ai-chat.demo.com', 'images/project1.jpg'),
(1, 'Quantum Encryption Simulator', 'A visual simulation tool demonstrating the principles of Quantum Key Distribution (QKD) using BB84 protocol over a simulated network.', 'Java, JavaFX, cryptography', 'https://github.com/kushagra/quantum-sim', 'https://quantum-sim.demo.com', 'images/project2.jpg');

-- Insert Fake Projects for Student 2 (Bhagyesh)
INSERT INTO projects (student_id, title, description, tech_stack, github_url, live_demo_url, image_path) VALUES
(2, 'Smart Campus IoT Network', 'An integrated IoT system using ESP32 sensors to monitor campus library occupancy and environmental parameters.', 'C++, ESP32, MQTT, Vue.js', 'https://github.com/bhagyesh/iot-campus', 'https://iot-campus.demo.com', 'images/project3.jpg'),
(2, 'Decentralized Voting DApp', 'A secure voting application deployed on the Ethereum testnet to ensure tamper-proof student union elections.', 'Solidity, Web3.js, React, Truffle', 'https://github.com/bhagyesh/voting-dapp', 'https://voting-dapp.demo.com', 'images/project1.jpg');

-- Insert Fake Projects for Student 3 (Harshit)
INSERT INTO projects (student_id, title, description, tech_stack, github_url, live_demo_url, image_path) VALUES
(3, 'Autonomous Drone Navigation', 'Flight controller software for autonomous drones utilizing computer vision for obstacle avoidance in complex environments.', 'Python, OpenCV, ROS, C++', 'https://github.com/harshit/drone-nav', 'https://drone-nav.demo.com', 'images/project2.jpg'),
(3, 'FinTech Budgeting App', 'A mobile application that aggregates bank data via Plaid API to provide students with actionable budgeting insights.', 'Flutter, Dart, Firebase, Node.js', 'https://github.com/harshit/fintech-app', 'https://fintech-app.demo.com', 'images/project3.jpg');

-- Insert Fake Contact Messages
INSERT INTO contact_messages (name, email, subject, message) VALUES
('Tech Recruiter', 'recruitment@google.com', 'Software Engineering Role', 'Hi! We loved the projects showcased on your dashboard and would like to schedule an interview for our upcoming SWE role.'),
('Startup Founder', 'founder@innovate.co', 'Collaboration Request', 'Your IoT project looks fascinating. Would you be open to collaborating on a commercial version of this system?');
