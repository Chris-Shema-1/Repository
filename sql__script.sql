CREATE TABLE studentss (
    student_id NUMBER PRIMARY KEY,
    student_name VARCHAR2(100),
    class VARCHAR2(10),
    subject VARCHAR2(50),
    score NUMBER,
    registration_date DATE
);

INSERT INTO studentss (student_id, student_name, class, subject, score, registration_date) VALUES (1, 'Alice Johnson', '10A', 'Math', 85, TO_DATE('2024-01-10', 'YYYY-MM-DD'));
INSERT INTO studentss (student_id, student_name, class, subject, score, registration_date) VALUES (2, 'Ben Smith', '10A', 'Math', 92, TO_DATE('2024-01-08', 'YYYY-MM-DD'));
INSERT INTO studentss (student_id, student_name, class, subject, score, registration_date) VALUES (3, 'Clara Lee', '10A', 'Math', 85, TO_DATE('2024-01-11', 'YYYY-MM-DD'));
INSERT INTO studentss (student_id, student_name, class, subject, score, registration_date) VALUES (4, 'David Kim', '10B', 'Science', 78, TO_DATE('2024-01-09', 'YYYY-MM-DD'));
INSERT INTO studentss (student_id, student_name, class, subject, score, registration_date) VALUES (5, 'Ella Chen', '10B', 'Science', 90, TO_DATE('2024-01-06', 'YYYY-MM-DD'));
INSERT INTO studentss (student_id, student_name, class, subject, score, registration_date) VALUES (6, 'Frank White', '10B', 'Science', 78, TO_DATE('2024-01-07', 'YYYY-MM-DD'));
INSERT INTO studentss (student_id, student_name, class, subject, score, registration_date) VALUES (7, 'Grace Liu', '10A', 'Math', 95, TO_DATE('2024-01-05', 'YYYY-MM-DD'));
INSERT INTO studentss (student_id, student_name, class, subject, score, registration_date) VALUES (8, 'Hank Green', '10C', 'English', 88, TO_DATE('2024-01-12', 'YYYY-MM-DD'));
INSERT INTO studentss (student_id, student_name, class, subject, score, registration_date) VALUES (9, 'Isla Brown', '10C', 'English', 91, TO_DATE('2024-01-08', 'YYYY-MM-DD'));
INSERT INTO studentss (student_id, student_name, class, subject, score, registration_date) VALUES (10, 'Jack Black', '10C', 'English', 87, TO_DATE('2024-01-04', 'YYYY-MM-DD'));

SELECT 
    student_id,
    student_name,
    subject,
    score,
    LAG(score) OVER (PARTITION BY subject ORDER BY score) AS prev_score,
    CASE 
        WHEN score > LAG(score) OVER (PARTITION BY subject ORDER BY score) THEN 'HIGHER'
        WHEN score < LAG(score) OVER (PARTITION BY subject ORDER BY score) THEN 'LOWER'
        ELSE 'EQUAL'
    END AS comparison_with_prev
FROM studentss;

SELECT 
    student_id,
    student_name,
    class,
    score,
    RANK() OVER (PARTITION BY class ORDER BY score DESC) AS rank_in_class,
    DENSE_RANK() OVER (PARTITION BY class ORDER BY score DESC) AS dense_rank_in_class
FROM studentss;

SELECT *
FROM (
    SELECT 
        student_id,
        student_name,
        class,
        score,
        RANK() OVER (PARTITION BY class ORDER BY score DESC) AS rank_in_class
    FROM studentss
)
WHERE rank_in_class <= 3;

SELECT *
FROM (
    SELECT 
        student_id,
        student_name,
        class,
        registration_date,
        ROW_NUMBER() OVER (PARTITION BY class ORDER BY registration_date ASC) AS row_num
    FROM studentss
)
WHERE row_num <= 2;

SELECT 
    student_id,
    student_name,
    class,
    score,
    MAX(score) OVER (PARTITION BY class) AS max_score_in_class,
    MAX(score) OVER () AS overall_max_score
FROM studentss;
