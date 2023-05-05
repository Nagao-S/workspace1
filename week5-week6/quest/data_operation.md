#データ登録
INSERT INTO my_table (name, age) VALUES ('nagao', 24);

#データ表示
select * from my_table;

#データの更新
UPDATE my_table SET name = 'tanaka' WHERE id = 1;

#データ削除
DELETE FROM my_table;

2. 列の選択
部署ごとに、部署番号、歴代のマネージャーの従業員番号、マネージャーのファーストネーム、マネージャーのラストネームを取得してください。
SELECT dept_manager.dept_no, dept_manager.emp_no, employees.first_name, employees.last_name
FROM dept_manager
INNER JOIN employees ON dept_manager.emp_no = employees.emp_no;


3. 複数の内部結合
部署ごとに、部署番号、部署名、歴代のマネージャーの従業員番号、マネージャーのファーストネーム、マネージャーのラストネームを取得してください。
SELECT dept_manager.dept_no,departments.dept_name, dept_manager.emp_no, employees.first_name, employees.last_name
FROM dept_manager
INNER JOIN employees ON dept_manager.emp_no = employees.emp_no
INNER JOIN departments ON dept_manager.dept_no = departments.dept_no;

4. 絞り込み
部署ごとに、部署番号、部署名、現在のマネージャーの従業員番号、マネージャーのファーストネーム、マネージャーのラストネームを取得してください。
SELECT dept_manager.dept_no,departments.dept_name, dept_manager.emp_no, employees.first_name, employees.last_name
FROM dept_manager
INNER JOIN employees ON dept_manager.emp_no = employees.emp_no
INNER JOIN departments ON dept_manager.dept_no = departments.dept_no
WHERE dept_manager.to_date = '9999-01-01';


5. 給与
従業員番号10001から10010の従業員ごとに、ファーストネーム、ラストネーム、いつからいつまで給与がいくらだったかを取得してください。
SELECT employees.emp_no, employees.first_name, employees.last_name, salaries.salary, salaries.from_date, salaries.to_date
FROM employees
INNER JOIN salaries ON employees.emp_no = salaries.emp_no
WHERE employees.emp_no BETWEEN '10001' AND '10010';

6. 内部結合と外部結合の違い
INNER JOIN と OUTER JOIN の違いについて、SQL 初心者にわかるように説明してください。またどのように使い分けるのかも合わせて説明してください。
SELECT employees.emp_no, employees.first_name, employees.last_name, salaries.salary, salaries.from_date
FROM employees
LEFT OUTER JOIN salaries ON employees.emp_no = salaries.emp_no
WHERE employees.emp_no BETWEEN '10001' AND '10010';
