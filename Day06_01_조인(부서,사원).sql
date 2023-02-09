/*
    드라이브(drive) 테이블과 드리븐(driven) 태아불
    1. 드라이브(drive) 테이블
       1) 조인 관계를 처리하는 메인 테이블
       2) 1:M 관계에서 1에 해당하는 테이블
       3) 행(row)의 개수가 일반적으로 적고, PK를 조인 조건으로 사용하기 떄문에 인덱스(index) 활용이 가능하다.
    2. 드리븐(driven) 테이블
       1) 1:M 관계에서 M에 해당하는 테이블
       2) 행(row)의 개수가 일반적으로 많고, FK를 조인 조건으로 사용하기 떄문에 인덱스(indec) 활
    3. 조인 성능 향상을 위해서 가급적 드라이브(drive) 테이블을 먼저 작성한다. 드리블(driven) 테이블은 나중에 작성한다.
*/

-- 1. 내부 조인(두 테이블에 일치하는 정보를 조인한다.)
-- 1) 표준 문법
select e.emp_no, e.name, d.dept_no, d.dept_name
  from department_tbl d inner join employee_tbl e
    on d.dept_no = e.depart;
-- 2) 오라클 문법
select e.emp_no, e.name, d.dept_no, d.dept_name
  from department_tbl d, employee_tbl e
 where d.dept_no = e.depart;
 
-- 2. 왼쪽 외부 조인(왼쪽에 있는 테이블은 일치하는 정보가 없어도 무조건 조인한다.)
-- 1) 표준 문법
select d.dept_no, d.dept_name, e.emp_no, e.name
  from department_tbl d left outer join employee_tbl e
    on d.dept_no = e.depart;
-- 2) 오라클 문법
select d.dept_no, d.dept_name, e.emp_no, e.name
  from department_tbl d, employee_tbl e
 where d.dept_no = e.depart(+);
 
-- 외래키 제약조건의 비활성화(일시 중지)
-- 재약조건이름 : fk_emp_dept
alter table employee_tbl
    disable constraint fk_emp_dept;
    
-- 외래키 제약조건이 없는 상태이므로, 제약조건을 위배하는 데이터를 입력할 수 있다.
insert into employee_tbl(emp_no, name, depart, position, gender, hire_date,, salary)
values(employee_seq.nextval, '김성실', 5, '대리', 'f'. '98/12/01' 3500000);
commit;

-- 외래키 제약조건의 활성화(다시 시작)
-- 제약조건이름 : fk_emp_dept
alter table employee_tbl
   enable constraint fk_emp_dept;
   
-- 3. 오른쪽 외부 조인(오른쪽에 있는 테이블은 일치하는 정보가 없어도 무조건 조인한다.)
-- 1) 표준 문법
select d.dept_no, d.dept_name, e.emp_no, e.name
  from department_tbl d right outer join employee_tbl e
    on d.dept_no = e.depart;
-- 2) 오라클 문법
select d.dept_no, d.dept_name, e.emp_no, e.name
  from department_tbl d, employee_tbl e
 where d.dept_no(+) = e.depart;
 
-- 외래키 제약조건을 위반하는 데이터 삭제하기
delete from employee_tbl where emp_no = 1005;    -- pk를 조건으로 사용하면 인덱스를 타기 때문에 빠르다.
delete from employee_tbl where name = '김성실';  -- 인덱스를 타지 않는 일반 컬럼은 느리게 동작한다.
commit;

-- 외래키 제약조건의 활성화(다시 시작)
-- 제약조건이름 : fk_emp_dept
alter table employee_tbl
   enable constraint fk_emp_dept;
