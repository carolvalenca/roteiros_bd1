-- Q1
SELECT * FROM department;

--Q2
SELECT * FROM dependent;

--Q3
SELECT * FROM dept_locations;

--Q4
SELECT * FROM employee;

--Q5
SELECT * FROM project;

--Q6 
SELECT * FROM works_on;

--Q7
SELECT fname, lname 
FROM employee 
WHERE sex='M';

--Q8
SELECT fname 
FROM employee 
WHERE superssn is null AND sex='M';

--Q9
SELECT e.fname, s.fname 
FROM employee e, employee s 
WHERE e.superssn = s.ssn;

--Q10
SELECT fname 
FROM employee 
WHERE superssn=(SELECT ssn FROM employee WHERE fname='Franklin');

--Q11
SELECT d.dname, l.dlocation 
FROM department d , dept_locations l 
WHERE d.dnumber=l.dnumber;

--Q12
SELECT d.dname, l.dlocation 
FROM department d , dept_locations l 
WHERE l.dlocation LIKE 'S%' AND d.dnumber=l.dnumber;

--Q13
SELECT e.fname, e.lname, d.dependent_name 
FROM employee e, dependent d 
WHERE e.ssn=d.essn;

--Q14
SELECT CONCAT(fname, ' ', minit, ' ', lname) AS full_name, salary 
FROM employee 
WHERE salary>50000;

--Q15
SELECT p.pname, d.dname 
FROM project p, department d 
WHERE p.dnum=d.dnumber;

--Q16
SELECT p.pname, e.fname 
FROM project p, department d, employee e 
WHERE p.pnumber>30 AND p.dnum=d.dnumber AND d.mgrssn=e.ssn;

--Q17
SELECT e.fname, p.pname 
FROM project p, employee e, works_on w 
WHERE e.ssn=w.essn AND w.pno=p.pnumber;

--Q18
SELECT e.fname, d.dependent_name, d.relationship 
FROM employee e, dependent d, project p
WHERE p.pnumber=91 AND p.dnum = e.dno ANDe.ssn=d.essn;
