DROP SCHEMA IF EXISTS ahmed;
CREATE SCHEMA ahmed;
USE  ahmed;
SET AUTOCOMMIT=0;

-- Table: Department
DROP TABLE IF EXISTS `Department`;
CREATE TABLE Department (
dept_id INT PRIMARY KEY,
dept_name VARCHAR(100) NOT NULL
)ENGINE=InnoDB AUTO_INCREMENT=4080 DEFAULT CHARSET=latin1;

-- Table: Doctors
DROP TABLE IF EXISTS `Doctors`;

CREATE TABLE Doctors (
doctor_id INT PRIMARY KEY,
name VARCHAR(100) NOT NULL,
specialization VARCHAR(100),
dept_id INT,
city VARCHAR(50) NOT NULL,
state VARCHAR(50) NOT NULL,
postal_code VARCHAR(20),
country VARCHAR(50) NOT NULL,
FOREIGN KEY (dept_id) REFERENCES Department(dept_id)
)ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Table: Nurse
DROP TABLE IF EXISTS `Nurse`;
CREATE TABLE Nurse (
nurse_id INT PRIMARY KEY,
name VARCHAR(100) NOT NULL,
gender ENUM('Male', 'Female') NOT NULL,
dept_id INT,
phone VARCHAR(20),
FOREIGN KEY (dept_id) REFERENCES Department(dept_id)
)ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Table: Patient
DROP TABLE IF EXISTS `Patient`;
CREATE TABLE Patient (
patient_id INT PRIMARY KEY,
name VARCHAR(100) NOT NULL,
gender VARCHAR(10) CHECK (gender IN ('Male', 'Female')),
age INT CHECK (age >= 0),
phone VARCHAR(20)
)ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Table: Appointment
DROP TABLE IF EXISTS `Appointment`;
CREATE TABLE Appointment (
appointment_id INT PRIMARY KEY,
doctor_id INT,
patient_id INT,
appointment_date DATE NOT NULL,
reason VARCHAR(255),
status ENUM('Pending', 'Completed', 'Cancelled') DEFAULT 'Pending',
FOREIGN KEY (doctor_id) REFERENCES Doctors(doctor_id),
FOREIGN KEY (patient_id) REFERENCES Patient(patient_id)
)ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Table: Rooms
DROP TABLE IF EXISTS `Rooms`;
CREATE TABLE Rooms (
room_id INT PRIMARY KEY,
room_number VARCHAR(20) NOT NULL UNIQUE,
room_type ENUM('Single', 'Double', 'Triple') NOT NULL,
capacity INT CHECK (capacity > 0),
is_available BOOLEAN,
dept_id INT,
FOREIGN KEY (dept_id) REFERENCES Department(dept_id)
)ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Table: Payment
DROP TABLE IF EXISTS `Payment`;
CREATE TABLE Payment (
payment_id INT PRIMARY KEY,
patient_id INT,
appointment_id INT,
amount DECIMAL(10, 2) CHECK (amount >= 0),
payment_method VARCHAR(50),
status ENUM('Completed', 'Pending') DEFAULT 'Pending',
FOREIGN KEY (patient_id) REFERENCES Patient(patient_id),
FOREIGN KEY (appointment_id) REFERENCES Appointment(appointment_id)
)ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Table: Medical Case
DROP TABLE IF EXISTS `MedicalCase`;
CREATE TABLE MedicalCase (
case_id INT PRIMARY KEY,
patient_id INT,
doctor_id INT,
diagnosis VARCHAR(255) NOT NULL,
treatment VARCHAR(255),
date_of_diagnosis DATE NOT NULL,
status ENUM('Ongoing', 'Completed', 'Scheduled') DEFAULT 'Ongoing',
FOREIGN KEY (patient_id) REFERENCES Patient(patient_id),
FOREIGN KEY (doctor_id) REFERENCES Doctors(doctor_id)
)ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Insert data into Department
INSERT INTO Department (dept_id, dept_name) VALUES
(1, 'Cardiology'),
(2, 'Neurology'),
(3, 'Orthopedics'),
(4, 'Pediatrics'),
(5, 'Dermatology'),
(6, 'Gastroenterology'),
(7, 'Oncology'),
(8, 'Psychiatry'),
(9, 'Endocrinology'),
(10, 'Urology');

-- Insert data into Doctors
INSERT INTO Doctors (doctor_id, name, specialization, dept_id, city, state, postal_code, country) VALUES
(1, 'Dr. John Doe', 'Cardiologist', 1, 'New York', 'NY', '10001', 'USA'),
(2, 'Dr. Jane Smith', 'Neurologist', 2, 'Los Angeles', 'CA', '90001', 'USA'),
(3, 'Dr. Alice Brown', 'Orthopedic Surgeon', 3, 'Chicago', 'IL', '60007', 'USA'),
(4, 'Dr. Robert Johnson', 'Pediatrician', 4, 'Houston', 'TX', '77001', 'USA'),
(5, 'Dr. Emma Wilson', 'Dermatologist', 5, 'Phoenix', 'AZ', '85001', 'USA'),
(6, 'Dr. Olivia Davis', 'Gastroenterologist', 6, 'San Francisco', 'CA', '94101', 'USA'),
(7, 'Dr. Liam Clark', 'Oncologist', 7, 'Miami', 'FL', '33101', 'USA'),
(8, 'Dr. Sophia Martinez', 'Psychiatrist', 8, 'Dallas', 'TX', '75201', 'USA'),
(9, 'Dr. Isabella Lee', 'Endocrinologist', 9, 'Atlanta', 'GA', '30301', 'USA'),
(10, 'Dr. Mason Moore', 'Urologist', 10, 'Boston', 'MA', '02108', 'USA');

-- Insert data into Nurse
INSERT INTO Nurse (nurse_id, name, gender, dept_id, phone) VALUES
(1, 'Nancy Green', 'Female', 1, '123-456-7890'),
(2, 'James Wilson', 'Male', 2, '987-654-3210'),
(3, 'Linda Brown', 'Female', 3, '654-321-0987'),
(4, 'Michael Harris', 'Male', 4, '321-654-9870'),
(5, 'Karen Lewis', 'Female', 5, '147-258-3690'),
(6, 'David Clark', 'Male', 6, '258-369-1470'),
(7, 'Patricia Walker', 'Female', 7, '369-147-2580'),
(8, 'John Young', 'Male', 8, '741-852-9630'),
(9, 'Jessica Hall', 'Female', 9, '963-741-8520'),
(10, 'William Allen', 'Male', 10, '159-357-9510');

-- Insert data into Patient
INSERT INTO Patient (patient_id, name, gender, age, phone) VALUES
(1, 'Michael Adams', 'Male', 45, '555-1234'),
(2, 'Sarah Parker', 'Female', 30, '555-5678'),
(3, 'David Moore', 'Male', 50, '555-8765'),
(4, 'Emma Harris', 'Female', 40, '555-2345'),
(5, 'Daniel Clark', 'Male', 35, '555-3456'),
(6, 'Sophia White', 'Female', 60, '555-4567'),
(7, 'James Martin', 'Male', 70, '555-6789'),
(8, 'Isabella Scott', 'Female', 25, '555-7890'),
(9, 'William Garcia', 'Male', 55, '555-8901'),
(10, 'Olivia Perez', 'Female', 28, '555-9012');

-- Insert data into Appointment
INSERT INTO Appointment (appointment_id, doctor_id, patient_id, appointment_date, reason) VALUES
(1, 1, 1, '2025-05-10', 'Heart Checkup'),
(2, 2, 2, '2025-05-11', 'Neurological Exam'),
(3, 3, 3, '2025-05-12', 'Knee Surgery Consultation'),
(4, 4, 4, '2025-05-13', 'Pediatric Consultation'),
(5, 5, 5, '2025-05-14', 'Skin Rash Treatment'),
(6, 6, 6, '2025-05-15', 'Gastrointestinal Problem'),
(7, 7, 7, '2025-05-16', 'Cancer Treatment Consultation'),
(8, 8, 8, '2025-05-17', 'Psychiatric Evaluation'),
(9, 9, 9, '2025-05-18', 'Thyroid Issues'),
(10, 10, 10, '2025-05-19', 'Urinary Issues');

-- Insert data into Rooms
INSERT INTO Rooms (room_id, room_number, room_type, capacity, is_available, dept_id) VALUES
(1, '101', 'Single', 1, TRUE, 1),
(2, '102', 'Double', 2, TRUE, 2),
(3, '103', 'Single', 1, TRUE, 3),
(4, '104', 'Double', 2, FALSE, 4),
(5, '105', 'Triple', 3, TRUE, 5),
(6, '106', 'Single', 1, FALSE, 6),
(7, '107', 'Double', 2, TRUE, 7),
(8, '108', 'Single', 1, TRUE, 8),
(9, '109', 'Triple', 3, TRUE, 9),
(10, '110', 'Double', 2, FALSE, 10);

-- Insert data into Payment
INSERT INTO Payment (payment_id, patient_id, appointment_id, amount, payment_method, status) VALUES
(1, 1, 1, 200.00, 'Credit Card', 'Completed'),
(2, 2, 2, 150.00, 'Cash', 'Completed'),
(3, 3, 3, 300.00, 'Debit Card', 'Pending'),
(4, 4, 4, 120.00, 'Cash', 'Completed'),
(5, 5, 5, 180.00, 'Credit Card', 'Completed'),
(6, 6, 6, 220.00, 'Debit Card', 'Completed'),
(7, 7, 7, 250.00, 'Credit Card', 'Pending'),
(8, 8, 8, 200.00, 'Cash', 'Completed'),
(9, 9, 9, 150.00, 'Debit Card', 'Completed'),
(10, 10, 10, 180.00, 'Credit Card', 'Completed');

-- Insert data into Medical Case
INSERT INTO MedicalCase (case_id, patient_id, doctor_id, diagnosis, treatment, date_of_diagnosis, status) VALUES
(1, 1, 1, 'Hypertension', 'Medication', '2025-05-10', 'Ongoing'),
(2, 2, 2, 'Migraine', 'Pain Relief', '2025-05-11', 'Ongoing'),
(3, 3, 3, 'Knee Osteoarthritis', 'Surgery', '2025-05-12', 'Scheduled'),
(4, 4, 4, 'Asthma', 'Inhaler Prescription', '2025-05-13', 'Ongoing'),
(5, 5, 5, 'Psoriasis', 'Topical Treatment', '2025-05-14', 'Ongoing'),
(6, 6, 6, 'Gastritis', 'Dietary Changes', '2025-05-15', 'Resolved'),
(7, 7, 7, 'Lung Cancer', 'Chemotherapy', '2025-05-16', 'Ongoing'),
(8, 8, 8, 'Depression', 'Antidepressants', '2025-05-17', 'Ongoing'),
(9, 9, 9, 'Hyperthyroidism', 'Thyroid Medication', '2025-05-18', 'Ongoing'),
(10, 10, 10, 'Bladder Infection', 'Antibiotics', '2025-05-19', 'Completed');
COMMIT;

SET AUTOCOMMIT=1;







-- -- البحث عن المرضى الذين يحتوي اسمهم على "David"
-- SELECT * 
-- FROM Patient 
-- WHERE name LIKE '%David%';







-- -- حساب عدد المواعيد لكل طبيب وترتيبهم تنازلياً
-- SELECT d.name AS Doctor_Name, COUNT(a.appointment_id) AS Total_Appointments
-- FROM Doctors d
-- JOIN Appointment a ON d.doctor_id = a.doctor_id
-- GROUP BY d.doctor_id
-- ORDER BY Total_Appointments DESC;






-- -- عرض الغرف المتاحة في قسم القلب (Cardiology)
-- SELECT r.room_number, r.room_type, r.capacity
-- FROM Rooms r
-- JOIN Department d ON r.dept_id = d.dept_id
-- WHERE d.dept_name = 'Cardiology' AND r.is_available = TRUE;












-- -- ترتيب المرضى تنازلياً حسب العمر
-- SELECT name, age, gender
-- FROM Patient
-- ORDER BY age DESC;












-- -- جمع إجمالي المبالغ المدفوعة لكل مريض (مرتبة تصاعدياً)
-- SELECT p.name AS Patient_Name, SUM(py.amount) AS Total_Payments
-- FROM Patient p
-- JOIN Payment py ON p.patient_id = py.patient_id
-- GROUP BY p.patient_id
-- ORDER BY Total_Payments ASC;









-- شرح الاستعلامات:
-- البحث النصي: يستخدم LIKE للعثور على أسماء المرضى التي تحتوي على كلمة "David".

-- Aggregate Function: يستخدم COUNT لحساب عدد المواعيد لكل طبيب مع GROUP BY و ORDER BY.

-- JOIN بين الجداول: يربط بين جدول الغرف والأقسام لعرض الغرف المتاحة في قسم معين.

-- الترتيب: يُظهر المرضى من الأكبر إلى الأصغر سناً باستخدام ORDER BY.

-- SUM مع GROUP BY: يجمع إجمالي المدفوعات لكل مريض ويُرتبها تصاعدياً.





-- -- هذا الاستعلام يُظهر عدد المواعيد لكل مريض مع اسم الطبيب الأكثر تعاملًا معه
-- SELECT 
--     p.name AS Patient_Name,
--     d.name AS Doctor_Name,
--     COUNT(a.appointment_id) AS Total_Appointments
-- FROM 
--     Patient p
-- JOIN 
--     Appointment a ON p.patient_id = a.patient_id
-- JOIN 
--     Doctors d ON a.doctor_id = d.doctor_id
-- GROUP BY 
--     p.patient_id, d.doctor_id
-- ORDER BY 
--     Total_Appointments DESC;