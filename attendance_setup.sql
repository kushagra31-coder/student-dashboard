

-- Create table (if not already exists)
CREATE TABLE IF NOT EXISTS attendance (
    id            INT AUTO_INCREMENT PRIMARY KEY,
    student_id    INT NOT NULL,
    subject       VARCHAR(50) NOT NULL,
    total_classes INT NOT NULL DEFAULT 40,
    attended      INT NOT NULL DEFAULT 0,
    percentage    DECIMAL(5,1) NOT NULL DEFAULT 0.0,
    UNIQUE KEY uq_student_subject (student_id, subject),
    FOREIGN KEY (student_id) REFERENCES students(id) ON DELETE CASCADE
);

-- Verify
SELECT 'attendance table ready' AS status;
SELECT COUNT(*) AS existing_rows FROM attendance;
