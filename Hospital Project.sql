Create database if not exists Hospital;
use Hospital;

-- Patient table
CREATE TABLE Patient (
    PatientID INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(50), 
    LastName VARCHAR(50),
    Gender VARCHAR(10),
    DOB DATE,
    Mobile_No BIGINT,
    Address VARCHAR(100)
);

-- Doctors table
CREATE TABLE Doctors (
    DoctorID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Specialization VARCHAR(50),
    Phone BIGINT
);

-- Appointment table
CREATE TABLE Appointment (
    AppointmentID INT PRIMARY KEY,
    PatientID INT,
    DoctorID INT,
    AppointmentDate DATE,
    PatientStatus VARCHAR(20),
    Reasons VARCHAR(100),
    FOREIGN KEY (PatientID) REFERENCES Patient(PatientID),
    FOREIGN KEY (DoctorID) REFERENCES Doctors(DoctorID)
);

-- Treatment table
CREATE TABLE Treatment (
    TreatmentID INT PRIMARY KEY,
    AppointmentID INT,
    Treatment_Description VARCHAR(200),
    Cost DECIMAL(10,2),
    FOREIGN KEY (AppointmentID) REFERENCES Appointment(AppointmentID)
);

-- Billing table
CREATE TABLE Billing (
    BillID INT PRIMARY KEY,
    PatientID INT,
    TotalAmount DECIMAL(10,2),
    PaymentStatus VARCHAR(20),
    PaymentDate DATE,
    FOREIGN KEY (PatientID) REFERENCES Patient(PatientID)
);

-- Insert Patient data
INSERT INTO Patient (FirstName, LastName, Gender, DOB, Mobile_No, Address) VALUES
('Amit', 'Sharma', 'Male', '1990-05-14', 9876543210, 'Delhi'),
('Priya', 'Mehta', 'Female', '1995-11-20', 9876501234, 'Mumbai'),
('Rohan', 'Kapoor', 'Male', '1988-03-10', 9123456780, 'Pune'),
('Sneha', 'Patil', 'Female', '1992-08-05', 9988776655, 'Bangalore'),
('Arjun', 'Verma', 'Male', '1993-06-18', 9812345678, 'Chennai'),
('Neha', 'Singh', 'Female', '1991-09-25', 9845123456, 'Delhi'),
('Kunal', 'Desai', 'Male', '1996-04-12', 9823456712, 'Ahmedabad'),
('Simran', 'Kaur', 'Female', '1996-09-30', 698664652, 'Chandigarh'),
('Rahul', 'Yadav', 'Male', '1990-02-22', 9844001122, 'Lucknow'),
('Meera', 'Nair', 'Female', '1997-07-15', 9865432109, 'Kochi');

-- Insert Doctors data
INSERT INTO Doctors (DoctorID, FirstName, LastName, Specialization, Phone) VALUES
(12, 'Bhushan', 'Kulkarni','Neurologist', 1234567890),
(15, 'Sudeep', 'Kumar','Physician', 9874563210),
(2, 'Kiran', 'Deshmukh','Dentist', 7896541230),
(13, 'Jaishankar', 'Pandey','Cardiologist', 8794563210),
(32, 'Virat', 'Sharma','Pediatrician', 5468792310),
(36, 'Rohit', 'Kohli','Dermatologist', 1234567890),
(18, 'Shubham', 'Kadu','Gynecologist', 1263547809),
(34, 'Sagar', 'Lonkar','ENT Specialist', 9865328430),
(28, 'Vedant', 'Jain','Urologist', 6889520456),
(26, 'Ankit', 'Jadhav','Plastic Surgeon', 3623145698),
(3, 'Vedant', 'Dixir','Radiologist', 3216549870);

-- Insert Appointment data
INSERT INTO Appointment (AppointmentID, PatientID, DoctorID, AppointmentDate, PatientStatus, Reasons) VALUES
(1, 1, 12, '2025-08-01', 'Recovered', 'Regular Checkup'),
(2, 2, 15, '2025-08-02', 'Under Treatment', 'Fever'),
(3, 3, 2, '2025-08-03', 'Recovered', 'Tooth Pain'),
(4, 4, 13, '2025-08-04', 'Under Treatment', 'Heart Checkup'),
(5, 5, 32, '2025-08-05', 'Recovered', 'Child Vaccination'),
(6, 6, 36, '2025-08-06', 'Under Observation', 'Skin Allergy'),
(7, 7, 18, '2025-08-07', 'Recovered', 'Pregnancy Checkup'),
(8, 8, 34, '2025-08-08', 'Under Treatment', 'Ear Pain'),
(9, 9, 28, '2025-08-09', 'Recovered', 'Kidney Stone'),
(10, 10, 26, '2025-08-10', 'Under Observation', 'Plastic Surgery Consultation');

INSERT INTO Treatment (TreatmentID, AppointmentID, Treatment_Description, Cost) VALUES
(1, 1, 'General health check-up', 500.00),
(2, 2, 'Dental cleaning and polishing', 1200.00),
(3, 3, 'Eye examination and prescription', 800.00),
(4, 4, 'Minor wound dressing', 300.00),
(5, 5, 'Physiotherapy session', 1000.00),
(6, 6, 'Flu vaccination', 600.00),
(7, 7, 'Blood test - Complete Blood Count', 750.00),
(8, 8, 'ECG test and consultation', 1500.00),
(9, 9, 'Skin allergy treatment', 950.00),
(10, 10, 'Orthopedic consultation', 1300.00);

INSERT INTO Billing (BillID, PatientID, TotalAmount, PaymentStatus, PaymentDate) VALUES
(1, 1, 1500.00, 'Paid', '2025-08-01'),
(2, 2, 800.00, 'Pending', NULL),
(3, 3, 1200.50, 'Paid', '2025-08-03'),
(4, 4, 500.00, 'Paid', '2025-08-04'),
(5, 5, 2000.00, 'Pending', NULL),
(6, 6, 950.75, 'Paid', '2025-08-06'),
(7, 7, 300.00, 'Paid', '2025-08-07'),
(8, 8, 1750.00, 'Pending', NULL),
(9, 9, 1100.00, 'Paid', '2025-08-09'),
(10, 10, 650.00, 'Paid', '2025-08-10');

--  -------Queries-------
-- 1) List all the doctors from cardiologist speicalization
select * from Doctors
where Specialization = 'Cardiologist';

-- 2) Find all patient with upcoming sceduled appointments
select p.PatientID , p.FirstName, p.LastName , a.AppointmentDate
from Patient p
join appointment a on p.PatientID = a.PatientID
where a.AppointmentDate > curdate()
	and a.PatientStatus = 'Scheduled'
order by a.AppointmentDate;

-- 3) Calculate total revenue
select sum(TotalAmount) as TotalRevenue
from Billing
where PaymentStatus = 'Paid';

-- 4) Top 3 most expensive treatments
select Treatment_Description, Cost
from Treatment
order by Cost desc
limit 3;

-- 5) Doctors with most completed appointments
select d.FirstName, d.LastName , count(*) as TotalCompleted from Doctors d
join Appointment a on d.DoctorID = a.DoctorID 
where a.PatientStatus = 'Recovered' 
group by d.DoctorID
order by TotalCompleted desc;

-- 6) Patient who haven't paid their bills
select p.FirstName, p.LastName, b.TotalAmount , b.PaymentStatus 
from Patient p
join Billing b on p.PatientID = b.PatientID
where b.PaymentStatus = 'Pending';

-- 7) Total patient each doctor has treated
select d.FirstName, d.LastName , count(distinct a.PatientID) as Patient_Count
from Doctors d
join Appointment a on d.DoctorID= a.DoctorID
where a.PatientStatus = 'Recovered'
group by d.DoctorID;

-- 8) Average treatement cost
select avg(Cost) from Treatment;

-- 9) Patient Full medical history
select p.FirstName, p.LastName, a.AppointmentDate, a.Reasons, t.Treatment_Description, t.Cost
from Patient p
join Appointment a on p.PatientID = a.PatientID
left join Treatment t on a.AppointmentId = t.AppointmentID
where p.PatientID = 4;

-- 10 ) Monthly revenue report
select month(PaymentDate) as Month,
sum(TotalAmount) as MonthlyRevenue from Billing
where PaymentStatus = 'Paid'
group by month(PaymentDate)
order by Month;