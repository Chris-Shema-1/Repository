
# 📘 PL/SQL  

---

## 👨‍👩‍👧‍👦 Group Members  
1. Shema Christian 26991 
2. ITANGISHAKA Fulgence  26963

---

## 📌 Overview

This project demonstrates how SQL can be used to model and analyze student data using the **`studentss`** table. The code creates a table, inserts sample data, and runs several analytical queries using SQL *Window Functions* such as `RANK()`, `DENSE_RANK()`, `LAG()`, `ROW_NUMBER()`, and aggregate functions like `MAX()` with the `OVER()` clause.

---

## 🗂️ Table: `studentss`

This table stores basic information about students, including their:
- `student_id`: Unique identifier for each student.
- `student_name`: Full name of the student.
- `class`: The class the student belongs to (e.g., 10A, 10B).
- `subject`: Subject for which the student is scored.
- `score`: Numeric score achieved in the subject.
- `registration_date`: Date the student registered.

### ✅ Table Creation Query

```sql
CREATE TABLE studentss (
    student_id NUMBER PRIMARY KEY,
    student_name VARCHAR2(100),
    class VARCHAR2(10),
    subject VARCHAR2(50),
    score NUMBER,
    registration_date DATE
);


```

---

## 📝 Data Insertion

Ten records are inserted to simulate a realistic dataset across 3 classes (`10A`, `10B`, `10C`) and 3 subjects (`Math`, `Science`, `English`).

Each student has a different score and registration date to support rich analysis.

### ✅ Sample Insert

```sql
INSERT INTO studentss (student_id, student_name, class, subject, score, registration_date)
VALUES (1, 'Alice Johnson', '10A', 'Math', 85, TO_DATE('2024-01-10', 'YYYY-MM-DD'));
```

---

## 📊 SQL Queries and Explanations

### 1. **Score Comparison with Previous Student (by Subject)**

This query compares each student’s score to the previous one (by subject), using the `LAG()` function.

```sql
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


```
![Image](https://github.com/user-attachments/assets/f10acd64-75c0-4a97-b1bf-9a6d70e25aa6)
📌 **Purpose:** Helps identify performance trends in each subject.

---

### 2. **Ranking Students in Each Class**

Ranks students within each class using both `RANK()` and `DENSE_RANK()`.

```sql
SELECT 
    student_id,
    student_name,
    class,
    score,
    RANK() OVER (PARTITION BY class ORDER BY score DESC) AS rank_in_class,
    DENSE_RANK() OVER (PARTITION BY class ORDER BY score DESC) AS dense_rank_in_class
FROM studentss;
```
![Image](https://github.com/user-attachments/assets/fab55a88-d042-483f-8ad1-3cb174446994)
📌 **Purpose:** Shows rank differences and gaps between scores.

---

### 3. **Top 3 Students in Each Class**

This query selects only the top 3 ranked students from each class.

```sql
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
```
![Image](https://github.com/user-attachments/assets/0a0d23c5-df7f-470a-8327-f947609da45f)
📌 **Purpose:** Highlights high-performing students in every class.

---

### 4. **First Two Students to Register in Each Class**

Uses `ROW_NUMBER()` to identify the earliest registered students per class.

```sql
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
```
![Image](https://github.com/user-attachments/assets/06fd083e-fc7c-4265-80cd-9b459b69acbc)
📌 **Purpose:** Tracks early registrants, useful for administrative reports.

---

### 5. **Maximum Scores in Class and Overall**

Finds the maximum score within each class and compares it to the overall highest score across all classes.

```sql
SELECT 
    student_id,
    student_name,
    class,
    score,
    MAX(score) OVER (PARTITION BY class) AS max_score_in_class,
    MAX(score) OVER () AS overall_max_score
FROM studentss;
```
![Image](https://github.com/user-attachments/assets/b5314689-b9e2-4b00-b222-d8c722c023d4)
📌 **Purpose:** Helps in determining top performance both locally (class) and globally (school-wide).

---

## 🧠 Key SQL Concepts Used

- **Window Functions**: `LAG()`, `RANK()`, `DENSE_RANK()`, `ROW_NUMBER()`, `MAX()`
- **Partitioning**: Used to divide data logically without physically altering the table.
- **Nested Queries**: Employed for filtering ranked results.
- **Date Functions**: `TO_DATE()` used to handle string-to-date conversion.

---

## ✅ Summary

This assignment demonstrates strong foundational understanding of:
- Creating relational tables.
- Inserting and managing student performance data.
- Running analytical queries using SQL window functions.
- Extracting insights on student performance, registration trends, and rankings.

---
