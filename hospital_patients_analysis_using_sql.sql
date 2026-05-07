-- load the table hospital patients
SELECT * FROM hospital_patients;

-- Count the variables and rows
SELECT COUNT(*) FROM hospital_patients;

-- Standardize Text: Clean Names
UPDATE hospital_patients
SET NAME = CONCAT( 
	UPPER(LEFT(Name, 1)),
    LOWER(SUBSTRING(Name, 2))
);

-- Create Length of Stay
ALTER TABLE hospital_patients 
ADD COLUMN stay_length INT;

-- Update the data
UPDATE hospital_patients
SET stay_length = DATEDIFF(`Discharge Date`, `Date of Admission`);

-- Create Age Groups   
ALTER TABLE hospital_patients
ADD COLUMN age_group VARCHAR(20);

-- Update the data 
UPDATE hospital_patients
SET age_group = CASE
	WHEN Age < 18 THEN 'Child'
    WHEN Age BETWEEN 18 AND 35 THEN 'Young Adult'
    WHEN Age BETWEEN 36 AND 60 THEN 'Adult'
    ELSE 'Senior'
 END;
 
 -- Check for the engineered columns
 SELECT 
	Name, Age, age_group, stay_length
FROM hospital_patients
LIMIT 10;    

/*
Task 1 — Most Common Medical Condition: Which medical condition appears most frequently? 
Expected: medical_condition and total_patients 
*/
SELECT `Medical Condition`, COUNT(*) AS total_patients
FROM hospital_patients
GROUP BY `Medical Condition`
ORDER BY total_patients DESC
LIMIT 5;

/*
Task 2 — Gender Distribution: How many male vs female patients do we have? 
Expected: gender and total_patients 
*/
SELECT Gender, COUNT(*) AS total_patients
FROM hospital_patients
GROUP BY Gender
ORDER BY total_patients DESC;

/*
Task 3 — Average Billing by Condition: Which medical condition is the most expensive on average? 
Expected: medical_condition and avg_billing. Order highest to lowest.
*/
SELECT `Medical Condition`, AVG(`Billing Amount`) AS avg_billing
FROM hospital_patients
GROUP BY `Medical Condition`
ORDER BY avg_billing DESC;

/*
Task 4 — Hospital Load: Which hospitals handle the most patients? 
Expected: hospital and total_patients. Top hospitals first.
*/
SELECT Hospital, COUNT(*) AS total_patients 
FROM hospital_patients
GROUP BY Hospital
ORDER BY total_patients DESC
LIMIT 10;

/*
Task 5 — Insurance Analysis: Which insurance provider covers the most patients? 
Expected: insurance_provider and total_patients 
*/
SELECT `Insurance Provider`, COUNT(*) AS total_patients
FROM hospital_patients
GROUP BY `Insurance Provider`
ORDER BY total_patients DESC
LIMIT 5;

/* 
Task 6 — Admission Type Analysis: Which admission type is most common? 
Expected: admission_type and total_admissions
*/
SELECT `Admission Type`, COUNT(*) AS total_admissions 
FROM hospital_patients
GROUP BY `Admission Type` 
ORDER BY total_admissions DESC
LIMIT 5;

/*
Task 7 — Length of Stay Analysis: What is the average hospital stay by medical condition? 
Expected: medical_condition and avg_stay_length
*/
SELECT `Medical Condition`, AVG(stay_length) AS avg_stay_length
FROM hospital_patients
GROUP BY `Medical Condition`
ORDER BY avg_stay_length DESC;

/*
Task 8 — Age Group Analysis: Which age group visits the hospital most?
Expected: age_group and total_patients
*/
SELECT age_group, COUNT(*) AS total_patients
FROM hospital_patients
GROUP BY age_group
ORDER BY total_patients DESC
LIMIT 5;

/*
Task 9 — High Cost Patients: Show patients with billing amount greater than 40,000
Expected: name, medical_condition, and billing_amount 
*/
SELECT Name, `Medical Condition`, `Billing Amount`
FROM hospital_patients
WHERE `Billing Amount` > 40000
ORDER BY `Billing Amount` DESC;

/*
Task 10 — Insight Question: Which combination of medical condition and gender has the highest total billing?
Expected: medical_condition, gender, and total_billing
*/
SELECT 
	`Medical Condition`, 
    Gender, 
    SUM(`Billing Amount`) AS total_billing 
FROM hospital_patients
GROUP BY `Medical Condition`, Gender
ORDER BY total_billing DESC;