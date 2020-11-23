--  QUESTAO 1

--letra a
create view vw_dptmgr
as select d.dname, e.fname
from department d, employee e
where d.mgrssn = e.ssn;

--letra b
create view vw_empl_houston
as select ssn, fname
from employee
where address like '%Houston%'; 

--letra c
create view vw_deptstats
as select d.dname, d.dnumber, count(*) as number_employee
from (works_on as w inner join project as p on (p.pnumber = w.pno) inner join department as d on (p.dnum = d.dnumber))
group by d.dnumber;

--letra d
create view vw_projstats
as select p.pnumber, count(*) as number_employee
from (works_on as w inner join project as p on (p.pnumber = w.pno))
group by p.pnumber;

-- QUESTAO 2
select * from vw_dptmgr;
select * from vw_empl_houston;
select * from vw_deptstats;
select * from vw_projstats;

-- QUESTAO 3
drop view vw_dptmgr;
drop view vw_empl_houston;
drop view vw_deptstats;
drop view vw_projstats;

-- QUESTAO 4
create or replace function check_age(e_ssn char(9)) 
returns varchar as $$
declare 
    e_age integer;
    retorno varchar;
begin 
    select date_part('year',age(bdate)) into e_age
    from employee
    where e_ssn = ssn;
    if e_age >= 50 then retorno := 'SENIOR';
    elsif e_age < 50 and e_age >= 0 then retorno := 'YOUNG';
    elsif e_age is null then retorno := 'UNKNOWN';
    else retorno := 'INVALID';
    end if;
    return retorno;
end;
$$ 
LANGUAGE plpgsql;

-- QUESTAO 5
CREATE or replace FUNCTION check_mgr() RETURNS trigger AS $check_mgr$
    declare 
        e_dno integer;
        e_age integer;
        e_supervisee employee%ROWTYPE;
    BEGIN
        select dno into e_dno
        from employee
        where ssn = new.mgrssn;
        select * into supervisee
        from employee
        where new.mgrssn = superssn;
        select date_part('year',age(bdate)) into e_age
        from employee
        where ssn = new.mgrssn;
        IF NEW.dnumber != e_dno THEN
            RAISE EXCEPTION 'manager must be a department''s employee';
        END IF;
        IF e_age < 50 THEN
            RAISE EXCEPTION 'manager must be a SENIOR employee';
        END IF;
        IF e_supervisee IS NULL THEN
            RAISE EXCEPTION 'manager must have supervisees';
        END IF;
        RETURN null;
    END;
$check_mgr$ LANGUAGE plpgsql;

CREATE TRIGGER check_mgr BEFORE INSERT OR UPDATE ON department
    FOR EACH ROW EXECUTE PROCEDURE check_mgr();


