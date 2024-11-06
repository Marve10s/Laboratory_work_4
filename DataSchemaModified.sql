-- Drop tables if they exist to reset the schema
DROP TABLE IF EXISTS student CASCADE;
DROP TABLE IF EXISTS librarian CASCADE;
DROP TABLE IF EXISTS request CASCADE;
DROP TABLE IF EXISTS material CASCADE;
DROP TABLE IF EXISTS software CASCADE;
DROP TABLE IF EXISTS humidity CASCADE;

-- Create student table
CREATE TABLE student (
    student_id SERIAL PRIMARY KEY,
    full_name VARCHAR(50) NOT NULL
);

-- Create librarian table
CREATE TABLE librarian (
    librarian_id SERIAL PRIMARY KEY,
    full_name VARCHAR(50) NOT NULL
);

-- Create request table
CREATE TABLE request (
    request_id SERIAL PRIMARY KEY,
    creation_date DATE NOT NULL,
    req_status VARCHAR(20) CHECK (status IN ('в обробці', 'завершено')),
    student_id INT,
    librarian_id INT,
    software_id INT,
    FOREIGN KEY (student_id) REFERENCES student (student_id),
    FOREIGN KEY (librarian_id) REFERENCES librarian (librarian_id),
    FOREIGN KEY (software_id) REFERENCES software (software_id)
);

-- Create material table
CREATE TABLE material (
    material_id SERIAL PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    author VARCHAR(100) NOT NULL,
    access_type VARCHAR(20) CHECK (access_type IN ('електронний', 'фізичний')),
    request_id INT,
    FOREIGN KEY (request_id) REFERENCES request (request_id)
);

-- Create software table
CREATE TABLE software (
    software_id SERIAL PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    software_version VARCHAR(10) NOT NULL,
    student_id INT,
    humidity_id INT,
    FOREIGN KEY (student_id) REFERENCES student (student_id),
    FOREIGN KEY (humidity_id) REFERENCES humidity (humidity_id)
);

-- Create humidity table
CREATE TABLE humidity (
    humidity_id SERIAL PRIMARY KEY,
    current_level INT CHECK (current_level BETWEEN 0 AND 100),
    target_level INT CHECK (target_level BETWEEN 0 AND 100),
    student_id INT,
    FOREIGN KEY (student_id) REFERENCES student (student_id)
);

-- Add regular expression constraints for name attributes
ALTER TABLE student ADD CONSTRAINT student_name_format
CHECK (full_name ~ '^[a-zа-я][a-zа-я]*$');

ALTER TABLE librarian ADD CONSTRAINT librarian_name_format
CHECK (full_name ~ '^[a-zа-я][a-zа-я]*$');
