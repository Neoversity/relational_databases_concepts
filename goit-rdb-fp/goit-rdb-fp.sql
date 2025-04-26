DROP TABLE pandemic.infectious_cases;

-- КРОК 2.1: Підрахунок кількості записів у вихідній таблиці infectious_cases
SELECT COUNT(*) FROM pandemic.infectious_cases;

-- КРОК 2.2: Створення таблиці entity для збереження унікальних сутностей
CREATE TABLE pandemic.entity (
    entity_id INT AUTO_INCREMENT PRIMARY KEY,
    entity_name VARCHAR(255) NOT NULL,
    entity_code VARCHAR(20) NOT NULL
);

-- КРОК 2.3: Заповнення таблиці entity унікальними назвами країн та кодами
INSERT INTO pandemic.entity (entity_name, entity_code)
SELECT DISTINCT Entity, Code
FROM pandemic.infectious_cases;

-- КРОК 2.4: Створення таблиці infectious_case для нормалізованих випадків
CREATE TABLE pandemic.infectious_case (
    case_id INT AUTO_INCREMENT PRIMARY KEY,
    entity_id INT NOT NULL,
    year INT NOT NULL,
    number_of_cases INT,
    FOREIGN KEY (entity_id) REFERENCES pandemic.entity(entity_id)
);

-- КРОК 2.5: Заповнення таблиці infectious_case даними з таблиці infectious_cases
-- Тут використовуємо кількість випадків поліомієліту (polio_cases)
INSERT INTO pandemic.infectious_case (entity_id, year, number_of_cases)
SELECT e.entity_id, ic.Year, ic.polio_cases
FROM pandemic.infectious_cases ic
JOIN pandemic.entity e ON ic.Entity = e.entity_name AND ic.Code = e.entity_code;

SELECT * FROM pandemic.infectious_case
LIMIT 10;

-- КРОК 3 Проаналізуйте дані Аналіз Number_rabies.:
SELECT 
    Entity,
    Code,
    AVG(CAST(Number_rabies AS SIGNED)) AS avg_rabies,
    MIN(CAST(Number_rabies AS SIGNED)) AS min_rabies,
    MAX(CAST(Number_rabies AS SIGNED)) AS max_rabies,
    SUM(CAST(Number_rabies AS SIGNED)) AS sum_rabies
FROM 
    pandemic.infectious_cases
WHERE 
    Number_rabies IS NOT NULL
    AND Number_rabies != ''
GROUP BY 
    Entity, Code
ORDER BY 
    avg_rabies DESC
LIMIT 10;


-- Крок 4. Побудуйте колонку різниці в роках.

SELECT 
    Entity,
    Code,
    Year,
    STR_TO_DATE(CONCAT(Year, '-01-01'), '%Y-%m-%d') AS year_start_date,
    CURRENT_DATE() AS current_date_field,
    TIMESTAMPDIFF(YEAR, STR_TO_DATE(CONCAT(Year, '-01-01'), '%Y-%m-%d'), CURRENT_DATE()) AS years_difference
FROM 
    pandemic.infectious_cases
LIMIT 10;

-- Крок 5. Побудуйте власну функцію.

DELIMITER //

CREATE FUNCTION calculate_years_difference(input_year INT)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE start_date DATE;
    DECLARE years_diff INT;

    SET start_date = STR_TO_DATE(CONCAT(input_year, '-01-01'), '%Y-%m-%d');
    SET years_diff = TIMESTAMPDIFF(YEAR, start_date, CURRENT_DATE());

    RETURN years_diff;
END//

DELIMITER ;


SELECT 
    Entity,
    Code,
    Year,
    calculate_years_difference(Year) AS years_difference
FROM 
    pandemic.infectious_cases
LIMIT 10;

