/*
    프로시저(procedure)
    1. 하나의 프로시저에 여러 개의 쿼리문을 작성해서 처리할 수 있다.
    2. 여러 개의 쿼리문이 필요한 서비스를 프로시저로 작성해 두면 사용이 편리하다.
       (예시 : 은행 이체(update 쿼리가 2개로 구성)
    3. 형식
       create [or replace] procedure 프로시저명[(매개변수)]
       is -- as도 가능
          변수선언
       begin
          본문
       [exception
          예외처리]
       end;
    4. 작성된 프로시저는 execute 프로시저(); 형식으로 실행한다.
*/

-- 프로시저1 정의(만들기)
create or replace procedure proc1
is
begin
    dbms_output.put_line('hello world');
end;

-- 프로시저1 호출(실행하기)
execute proc1();

-- 프로시저2 정의(만들기) : 사원번호가 100인 사원의 first_name, last_name, salary를 조회하는 프로시저
create or replace procedure proc2
is
    fname employees.first_name%type;
    lname employees.last_name%type;
    sal employees.salary%type;
begin
     select first_name, last_name, salary
       into fname, lname, sal
       from employees
      where employee_id = 100;
      dbms_output.put_line(fname || ',' || lname || ',' || sal);
end;

-- 프로시저2 호출(실행하기)
execute proc2();

-- 프로시저3 정의(만들기) : 사원번호를 전달하면 해당 사원의 first_name, last_name, salary를 조회하는 프로시저
-- 입력 파라미터

create or replace procedure proc3(emp_id in employees.employee_id%type)
is
    fname employees.first_name%type;
    lname employees.last_name%type;
    sal employees.salary%type;
begin
     select first_name, last_name, salary
       into fname, lname, sal
       from employees
      where employee_id = 100;
      dbms_output.put_line(fname || ',' || lname || ',' || sal);
exception
    when others then
        dbms_output.put_line('예외가 발생했습니다.');
end;

-- 프로시저3 호출(실행하기)
execute proc3(100);

-- 프로시저4 정의(만들기)
-- 사원번호가 100인 사원의 first_name, last_name을 출력 파라미터로 반환하는 프로시저
-- 출력 파라미터
-- 1. 프로시저의 실행 결과를 저장하는 변수이다.
-- 2. 형식 : 변수명 out 타입
create or replace procedure proc4(fname out employees.first_name%type, lname out employees.last_name%type)
is
begin
    select first_name, last_name
      into fname, lname  -- 이 곳에서 출력 파라미터에 값이 저장된다.
      from employees
     where employee_id = 100;
end;

-- 프로시저4 호출(실행하기)
-- fname과 lname값을 저장할 변수를 선언한 뒤, 프로시저에 전달해야 한다.
declare
    fname employees.first_name%type;
    lname employees.last_name%type;
begin
    proc4(fname, lname);   -- plsql 내부에서 프로시저를 호출할 때는 execute를 생략해야 한다.
    dbms_output.put_line(fname || ',' || lname);
end;

-- 프로시저5. 사원번호를 전달하면, 해당 사원의 first_name이 출력 파라미터 fname에 저장되도록 
-- 없는 사원번호가 전달되면 fname에 'noname'이 저장되도록 작성.
-- 실행 예시)
-- proc6(100, fname) : 사원번호 100은 steven입니다.
-- proc6(0, fname)   : 사원번호 0은 noname입니다.
create or replace procedure pro6(emp_id in employees.employee_id%type, fname out employees.first_name%type)
is
begin
    select first_name
      into fname
      from employees
     where employee_id = emp_id;
exception
    when no_data_found then
        fname := 'noname';
end;

declare
    fname employees.first_name%type;
begin
    proc5(100, fname);
    dbms_output.put_line(fname);
end;

/*
    프로시저 연습
    1. buy_proc 프로시저 구현하기
    2. 처리할 일
        1) 구매내역 테이블에 구매 내역을 추가(insert)한다.
        2) 제품 테이블의 재고 내역을 수정(update)한다.
        3) 고객 테이블의 포인트를 수정(update)한다.
*/
-- 테이블 삭제하기
drop table buy_tbl;
drop table cust_tbl;
drop table prod_tbl;

--  시퀀스 삭제하기
drop sequence buy_seq;

-- 제품 테이블 구성하기
create table prod_tbl (
    /*  */ p_code number not null,
    /*  */ p_name varchar2(20 byte),
    /*  */ p_price number,
    /*  */ p_stock number
);
alter table prod_tbl
    add constraint pk_prod primary key(p_code);
insert into prod_tbl(p_code, p_name, p_price, p_stock) values(1000, '홈런볼', 1000, 100);
insert into prod_tbl(p_code, p_name, p_price, p_stock) values(1001, '맛동산', 2000, 100);
commit;

-- 고객 테이블 구성하기
create table cust_tbl (
    c_no number not null,
    c_name varchar2(20 byte),
    c_point number
);
alter table cust_tbl
    add constraint pk_cust primary key(c_no);
insert into cust_tbl(c_no, c_name, c_point) values(1, '정숙', 0);
insert into cust_tbl(c_no, c_name, c_point) values(2, '재홍', 0);
commit;

-- 구매 테이블 구성하기
create table buy_tbl (
    b_no number not null,
    c_no number not null,
    p_code number,
    b_amount number
);
alter table buy_tbl
    add constraint pk_buy primary key(b_no);
alter table buy_tbl
    add constraint fk_buy_cust foreign key(c_no)
        references cust_tbl(c_no)
            on delete cascade;
alter table buy_tbl
    add constraint fk_buy_prod foreign key(p_code)
        references prod_tbl(p_code)
            on delete set null;
create sequence buy_seq
    nocache;

-- BUY_PROC 프로시저 정의
create or replace procedure buy_proc
(
    /* 고객번호 */  cno in cust_tbl.c_no%type, 
    /* 제품코드 */  pcode in prod_tbl.p_code%type, 
    /* 구매수량 */  buy_amount in buy_tbl.b_amount%type
)
is
begin
    -- 1) 구매내역 테이블에 구매 내역을 추가(INSERT)한다.
    insert into buy_tbl(b_no, c_no, p_code, b_amount) values(buy_seq.nextval, cno, pcode, buy_amount);
    -- 2) 제품 테이블의 재고 내역을 수정(UPDATE)한다.
    update prod_tbl set p_stock = p_stock - buy_amount where p_code = pcode;
    -- 3) 고객 테이블의 포인트를 수정(UPDATE)한다.
    --    총 구매액의 10%를 정수로 올림처리해서 포인트로 준다.
    update cust_tbl set c_point = c_point + ceil((select p_price from prod_tbl where p_code = pcode) * buy_amount * 0.1) where c_no = cno;
    -- 4) 커밋
    commit;
exception
    when others then  -- 모든 예외를 처리
        -- 예외 사유 확인
        dbms_output.put_line(sqlcode || '(' || sqlerrm || ')');
        -- 롤백
        rollback;
end;

-- BUY_PROC 프로시저 호출
execute buy_proc(1, 1000, 10);  -- 고객번호 1, 제품코드 1000, 구매수량 10
begin
    buy_proc(2, 1001, 5);       -- 고객번호 2, 제품코드 1000, 구매수량 5
end;