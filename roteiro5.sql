--Q1
SELECT COUNT(*) FROM employee WHERE sex="F";

--Q2
SELECT AVG(salary) AS media_salario FROM employee WHERE sex="M" AND address LIKE "%TX";

--Q3
SELECT superssn AS ssn_supervisor, COUNT(*) AS qtd_supervisionados
FROM employee
GROUP BY superssn
ORDER BY qtd_supervisionados;

--Q4
SELECT s.fname as nome_supervisor, COUNT(*) as qtd_supervisionados 
FROM (employee AS s INNER JOIN employee AS e ON (s.ssn = e.superssn)) 
GROUP BY s.ssn 
ORDER BY COUNT(*);

--Q5
SELECT s.fname as nome_supervisor, COUNT(*) as qtd_supervisionados 
FROM (employee AS s RIGHT OUTER JOIN employee AS e ON (s.ssn = e.superssn)) 
GROUP BY s.ssn 
ORDER BY COUNT(*);

--Q6
SELECT MIN(todos) AS qtd
FROM (
    SELECT COUNT(*) AS todos
    FROM works_on
    GROUP BY pno
) AS tabela;

--Q7
SELECT pno AS num_projeto, qtd AS qtd_func
FROM ((
        SELECT pno, COUNT(*) as qtd1
        FROM works_on
        GROUP BY pno
    ) AS projetos
    INNER JOIN (
        SELECT MIN(sla) AS qtd2
        FROM (
            SELECT COUNT(*) as sla
            FROM works_on
            GROUP BY pno
        ) AS tabela
    ) AS minimo
    ON qtd1 = qtd2
);

--Q8
SELECT w.pno AS num_proj, AVG(s.salary) AS media_salario
FROM (employee AS s INNER JOIN works_on AS w ON (s.ssn = w.essn))
GROUP BY w.pno
ORDER BY media_salario;

--Q9
SELECT w.pno AS num_proj, p.pname AS proj_name, AVG(s.salary) AS media_salario
FROM (employee AS s INNER JOIN works_on AS w ON (s.ssn = w.essn) INNER JOIN project AS p ON (w.pno = p.pnumber))
GROUP BY w.pno
ORDER BY media_salario;

--Q10
SELECT e.fname, e.salary
FROM employee AS e
WHERE e.salary > (
    SELECT MAX(e.salary)
    FROM works_on AS w INNER JOIN employee AS e ON (w.essn = e.ssn AND w.pno = 92)
);

--Q11
SELECT e.ssn, COUNT(w.pno) AS qtd_proj
FROM (employee AS e LEFT OUTER JOIN works_on AS w ON (e.ssn = w.essn)) 
GROUP BY e.ssn 
ORDER BY COUNT(w.pno);

--Q12
SELECT *
FROM (
    SELECT w.pno AS num_proj, count(e.ssn) AS qtd_func
    FROM employee AS e LEFT OUTER JOIN works_on AS w ON (e.ssn = w.essn)
    GROUP BY w.pno
    ORDER BY count(e.ssn)) AS new_table
WHERE qtd_func < 5;

--Q13
SELECT fname FROM employee 
WHERE ssn IN (
    SELECT w.essn 
    FROM works_on AS w, project AS p
    WHERE p.plocation = 'Sugarland' AND w.pno = p.pnumber) AND ssn IN (
        SELECT d.essn 
        FROM employee AS e, dependent AS d
        WHERE e.ssn = d.essn
    );


--Q14
SELECT d.dname
FROM department AS d 
WHERE NOT EXISTS(
    SELECT *
    FROM project AS p
    WHERE p.dnum = d.dnumber
);

--Q15
SELECT e.fname, e.lname
FROM employee AS e, works_on AS w 
WHERE (e.ssn = w.essn AND w.pno = (
    SELECT w.pno
    FROM works_on AS w
    WHERE w.essn = '123456789'
));