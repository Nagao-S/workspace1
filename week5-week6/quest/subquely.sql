-- 1. サブクエリ
-- 従業員番号が10001から10010のうち、全給与レコードの平均給与より給与が大きいレコードの従業員番号と給与を、サブクエリを使用して取得してください。
SELECT emp_no, salary
FROM salaries
WHERE salary > (SELECT AVG(salary) FROM salaries )
AND emp_no BETWEEN 10001 AND 10010;

-- 2. 重複なし
-- 平均の2倍以上の給与をもらっている従業員の従業員番号を重複なく取得してください。
SELECT DISTINCT emp_no
FROM salaries
WHERE salary >= (SELECT AVG(salary) * 2 FROM salaries);


-- ３. 最大給与
-- 従業員番号が10001から10010のうち、全給与レコードの平均給与より給与が大きい従業員の従業員番号と最大給与を取得してください。
SELECT emp_no, MAX(salary) AS max_salary
FROM salaries
WHERE salary > (SELECT AVG(salary) FROM salaries)
AND emp_no BETWEEN 10001 AND 10010
GROUP BY emp_no;

-- 4. 相関サブクエリ
-- 従業員のうち、性別ごとに最高年齢の従業員の性別、従業員番号、誕生日を、相関サブクエリを使用して取得してください。
SELECT e1.gender, e1.emp_no, e1.birth_date
FROM employees e1
WHERE  e1.birth_date = (
  SELECT MIN(e2.birth_date)
  FROM employees e2
  WHERE e2.gender = e1.gender
);

SELECT e.gender, e.emp_no, e.birth_date
FROM employees e
JOIN (
    SELECT gender, MIN(birth_date) AS min_birth_date
    FROM employees
    GROUP BY gender
) AS g ON e.gender = g.gender AND e.birth_date = g.min_birth_date;



-- 5. 一番若い従業員
-- 従業員番号10100から10200の従業員の中で、それぞれの性別で最も若い年齢の人の性別、誕生日、従業員番号、ファーストネーム、ラストネームを取得してください。
SELECT e1.gender, e1.birth_date, e1.emp_no, e1.first_name, e1.last_name
FROM employees e1
WHERE  e1.birth_date = (
  SELECT MAX(e2.birth_date)
  FROM employees e2
  WHERE e2.gender = e1.gender
  AND e2.emp_no BETWEEN 10100 AND 10200
)
AND e1.emp_no BETWEEN 10100 AND 10200;


-- 1. CASE
-- 従業員番号10100から10200の従業員に対して、最終在籍日に応じて在籍中か離職済みかを出し分けたいです。従業員番号、最終在籍日 (to_date)、在職状況(employed/unemployed) を、CASE 式を使用して表示してください。
SELECT emp_no, to_date,
CASE
  WHEN to_date = '9999-01-01' THEN 'employed'
  ELSE 'unemployed'
END AS status
FROM dept_emp
WHERE emp_no BETWEEN 10100 AND 10200;


-- 2. 年代
-- 従業員番号が10001から10050の従業員を対象に、従業員番号、誕生日、年代を表示してください。なお年代は、誕生日が1950年代の場合「50s」、誕生日が1960年代の場合「60s」と表記してください。
SELECT emp_no, birth_date,
CONCAT(SUBSTRING(YEAR(birth_date), 3, 1), '0s') AS decade
FROM employees
WHERE emp_no BETWEEN 10001 AND 10050;

-- 3. 年代ごとの最大給与
-- 年代ごとの最大給与を取得してください。なお年代は、誕生日が1950年代の場合「50s」、誕生日が1960年代の場合「60s」と表記してください。
SELECT CONCAT(SUBSTRING(YEAR(e.birth_date), 3, 1), '0s') AS decade,
MAX(s.salary) AS max_salary
FROM employees e
JOIN salaries s ON e.emp_no = s.emp_no
GROUP BY decade;



