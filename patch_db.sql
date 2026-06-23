USE portfolio_db;
ALTER TABLE students ADD COLUMN email VARCHAR(150), ADD COLUMN phone VARCHAR(20);
UPDATE students SET email = 'kushagrasingh240033@acropolis.in', phone = '+91 8435841607' WHERE id = 1;
UPDATE students SET email = 'bhagyesh@acropolis.in', phone = '+91 9302266309' WHERE id = 2;
UPDATE students SET email = 'harshit@acropolis.in', phone = '+91 9755578278' WHERE id = 3;
UPDATE students SET email = 'admin@acropolis.in', phone = '+91 7509569010' WHERE id = 4;
