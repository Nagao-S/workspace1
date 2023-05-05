START TRANSACTION;

INSERT INTO employees (emp_no,birth_date,first_name,last_name,gender,hire_date) VALUES ('9999999','1980-01-01','nagao','shiduru','F','1998-11-10');
SELECT * FROM employees WHERE first_name = 'nagao';

ROLLBACK;


DELETE FROM employees WHERE first_name = 'nagao';

COMMIT;