/*
    트리거(trigger)
    1. dml(insert, update, delete) 작업 후 자동으로 실행되는 데이터베이스 객체이다.
    2. 행(row) 단위로 트리거가 동작한다.
    3. 종류
       1) before 트리거 : dml 동작 이전에 수행된다.
       2) after 트리거  : dml 동작 후에 수행된다.
    4. 형식
       create [or replace] trigger 트리거명
       before | after
       insert or update or delete
       on 테이블명
       for each row
       begin
          트리거본문
       end;
*/

set serverout on;

-- trig1 정의
create or replace trigger trig1
    after
    update
    on employees
    for each row
begin
    dbms_output.put_line('hello world');
end;

-- trig1 동작 확인(employees 테이블의 데이터를 수정해 본다.)
update employees
   set last_name = 'queen'
 where employee_id = 100;

-- trig1 삭제
drop trigger trig1;

-- trig2 정의
create or replace trigger trig2
    after
    insert or update or delete  -- 작성 순서 없음
    on employees
    for each row
begin
    if inserting then    -- 삽입 후 동작할 작업
        dbms_output.put_line('insert를 했군요.');
    elsif updating then  -- 수정 후 동작할 작업
        dbms_output.put_line('update를 했군요.');
    elsif deleting then  -- 삭제 후 동작할 작업
        dbms_output.put_line('delete를 했군요.');
    end if;
end;

-- trig2 동작 확인
insert into employees(employee_id, last_name, email, hire_date, job_id) values(99, 'a', 'a', sysdate, 'a');
update employees set first_name = 'kim' where employee_id = 99;
delete from employees where employee_id = 99;

-- trig2 삭제
drop trigger trig2;

/*
old 테이블
1. insert, update, delete 수행 이전의 정보를 임시 저장하고 있는 테이블이다.
2. :old 방식으로 호출한다.
3. after 트리거와 함께 사용한다. 
      1) after insert : null
      2) after update : update 이전 데이터(수정되기 전의 데이터)
      3) after delete : delete 이전 데이터(삭제되기 전의 데이터)
*/

-- trig3 정의
create or replace trigger trig3
    after
    update or delete
    on employees
    for each row
begin
    if updating then
        dbms_output.put_line('수정 전 last_name : ' || :old.last_name);
    elsif deleting then
        dbms_output.put_line('삭제 전 last_name : ' || :old.last_name);
    end if;
end;

-- trig3 동작 확인
update employees set last_name = 'kim' where employee_id = 100;
delete from employees where employee_id = 100;

-- trig3 삭제
drop trigger trig3;

/*
    트리거 실습
    사원 테이블에서 삭제할 사원정보를 퇴사자 테이블로 삽입하는 retire_trig 생성하기
    
    작업 순서
    1. 사원(employees) 테이블의 구조를 복사하여 퇴사자 테이블(retires)을 생성한다.
    2. 퇴사자(retires) 테이블에 퇴사번호(retire_id), 퇴사일자(retire_date) 컬럼을 추가한다.
    3. 퇴사번호(retire_id) 컬럼을 기본키로 지정한다.
    4. 퇴사번호를 생성할 retire_seq 시퀀스를 생성한다.
    5. retire_trig 트리거를 생성한다.
       1) after delete 트리거
       2) old 테이블의 데이터를 모두 퇴사자 테이블로 삽입한다.
       3) 퇴산번호는 시퀀스, 퇴사일자는 sysdate로 처리해서 삽입한다.
*/

-- 1. 사원(employees) 테이블의 구조를 복사하여 퇴사자 테이블(retires)을 생성한다.
drop table retires;
create table retires as
select * from employees where 1=2;

-- 2. 퇴사자(retires) 테이블에 퇴사번호(retire_id), 퇴사일자(retire_date) 컬럼을 추가한다.
alter table retires add retire_id number not null;
alter table retires add retire_date date;

-- 3. 퇴사번호(retire_id) 컬럼을 기본키로 지정한다.
alter table retires add constraint pk_ret primary key(retire_id);

-- 4. 퇴사번호를 생성할 retire_seq 시퀀스를 생성한다.
drop sequence retire_seq;
create sequence retire_seq nocache;
    
/*
   5. retire_trig 트리거를 생성한다.
      1) after delete 트리거
      2) old 테이블의 데이터를 모두 퇴사자 테이블로 삽입한다.
      3) 퇴산번호는 시퀀스, 퇴사일자는 sysdate로 처리해서 삽입한다.
*/
create or replace trigger retire_trig
    after
    delete
    on retires
    for each row
begin
    insert into retires(retire_id, retire_date, employee_id, first_name, last_name, email, phone_number, hire_date, job_id, salary, commission_pct, manager_id, department_id)
    values(retire_seq.nextval, sysdate, :old.employee_id, :old.first_name, :old.last_name, :old.email, :old.phone_number, :old.hire_date, :old.job_id, :old.salary, :old.commission_pct, :old.manager_id, :old.department_id);
end;

-- retire_trig 동작 확인
delete from employees where employee_id between 150 and 200;