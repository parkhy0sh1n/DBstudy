/*
    DML
    1. Data Manipulation Language
    2. 데이터 조작어
    3. 데이터(행, Row)를 삽입, 수정, 삭제할 때 사용하는 언어이다.
    4. DML 사용 후에는 commit 또는 rollback 처리를 해야 한다.
    5. 종류
        1) 삽입 : insert into values
        2) 수정 : update set where
        3) 삭제 : delete from where
*/

-- 참고. 자격증에서는 DML을 insert, update, delete + select로 보는 경우도 있다.

-- 테이블 삭제
drop table employee_tbl;
drop table department_tbl;

-- 테이블 생성
create table department_tbl (
    dept_no   number             not null,
    dept_name varchar2(15 byte)  not null,
    location   varchar2(15 byte) not null
);

create table employee_tbl (
    emp_no    number            not null,
    name      varchar2(20 byte) not null,
    depart    number,
    position  varchar2(20 byte),
    gender    char(2 byte),
    hire_date date,
    salary    number
);

-- 기본키
alter table department_tbl
    add constraint pk_dept primary key(dept_no);
alter table employee_tbl
    add constraint pk_emp primary key(emp_no);

-- 외래키
alter table employee_tbl
    add constraint fk_emp_dept foreign key(depart) 
        references department_tbl(dept_no)
            on delete set null;
            
-- 시퀀스(번호 생성기) 삭제하기
drop sequence department_seq;

-- 시퀀스(번호 생성기) 만들기
create sequence department_seq
    increment by 1      -- 1씩 증가하는 번호를 만든다.(생략 가능)
    start with 1        -- 1부터 번호를 만든다.(생략 가능)
    nomaxvalue          -- 번호의 상한선이 없다.(생략 가능) maxvalue 100 : 번호를 100까지만 생성한다.
    nominvalue          -- 번호의 하한선이 없다.(생략 가능) minvalue 100 : 번호의 최소값이 100이다.
    nocycle             -- 번호 순환이 없다.(생략 가능)     cycle : 번호가 maxvalue에 도달하면 다음 번호는 minvalue이다.
    nocache             -- 메모리 캐시를 사용하지 않는다.   cache : 메모리 캐시를 사용한다.(사용하지 않는 것이 좋다.)
    order               -- 번호 건너뛰기가 없다.            noorder : 번호 건너뛰기 가능하다.
;

-- 시퀀드에서 번호 뽑는 함수 : nextval
-- select department_seq.nextval from dual;    -- 오라클에서는 테이블에 없는 데이터를 조회하려면 dual 테이블을 사용한다.
            
-- 데이터 입력하기(Parent Key를 먼저 입력해야 한다.)
insert into department_tbl(dept_no, dept_name, location) values(department_seq.nextval, '영업부', '대구');
insert into department_tbl(dept_no, dept_name, location) values(department_seq.nextval, '인사부', '서울');
insert into department_tbl(dept_no, dept_name, location) values(department_seq.nextval, '총무부', '대구');
insert into department_tbl(dept_no, dept_name, location) values(department_seq.nextval, '기획부', '서울');
commit;

-- 시퀀스(번호 생성기) 삭제하기
drop sequence employee_seq;

-- 시퀀스(번호 생성기) 만들기
create sequence employee_seq
    start with 1001  
    nocache;

-- 데이터 입력하기
insert into employee_tbl(emp_no, name, depart, position, gender, hire_date, salary) values(employee_seq.nextval, '구창민', 1, '과장', 'M', '95/05/01','5000000');
insert into employee_tbl(emp_no, name, depart, position, gender, hire_date, salary) values(employee_seq.nextval, '김민서', 1, '과장', 'M', '17/09/01','2500000');
insert into employee_tbl(emp_no, name, depart, position, gender, hire_date, salary) values(employee_seq.nextval, '이은영', 2, '과장', 'M', '90/09/01','5500000');
insert into employee_tbl(emp_no, name, depart, position, gender, hire_date, salary) values(employee_seq.nextval, '한성일', 2, '과장', 'M', '93/04/01','5000000');
commit;

-- 데이터 수정하기
-- 1. 부서번호(dept_no)가 1인 부서의 지역(location)을 '경기'로 수정하시오.
update department_tbl
   set location = '경기'      -- 수정할 내용(여기서 등호는 대입 연산자이다.
 where dept_no = 1;           -- 조건문(여기서 등호는 비교 연산자이다.)
commit;

-- 2. 부서번호(depart)가 1인 부서에 근무하는 사원들의 급여(salary)를 500000원 증가시키시오.
update employee_tbl
   set salary = salary + 500000
 where depart = 1;
commit;

-- 데이터 삭제하기
-- 1. 지역(location)이 '대구'인 부서를 삭제하시오. ('대구'에서 근무하는 사원이 없으므로 문제 없이 삭제된다.)
delete from department_tbl where location = '대구';
commit;

-- 2. 지역(location)이 '서울'인 부서를 삭제하시오. ('서울'에서 근무하는 부서번호(depart)가 on delete set null 외래키 옵션에 의해서 null로 처리된다.)
delete from department_tbl where location = '서울';
commit;