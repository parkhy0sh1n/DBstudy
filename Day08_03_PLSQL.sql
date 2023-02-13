/*
    PL/SQL
    
    1. 오라클 전용 문법이고 프로그래밍 처리가 가능한 SQL이다.
    2. 형식
        [DECLARE
            변수 선언]
        BEGIN
            수행할 PL/SQL
        END;
    3. 변수에 저장된 값을 출력하기 위해서 서버 출력을 ON 시켜줘야 한다.
       최초 1번만 실행시켜 두면 된다.(디폴트는 OFF)
        SET SERVEROUTPUT ON;
*/

-- 서버출력 ON
set serveroutput on;

-- 서버출력 확인
begin
    dbms_output.put_line('Hello World');
end;


/*
    테이블 복사하기
    1. CREATE TABLE과 복사할 데이터의 조회(SELECT)를 이용한다.
    2. PK와 FK 제약조건은 복사되지 않는다.
    3. 복사하는 쿼리
        1) 데이터를 복사하기
            CREATE TABLE 테이블 AS(SELECT 칼럼 FROM 테이블);
        2) 데이터를 제외하고 구조만 복사하기(칼럼만 복사하기)
            CREATE TABLE 테이블 AS(SELECT 칼럼 FROM 테이블 WHERE 1=2);
*/
-- HR 계정의 EMPLOYEES 테이블을 GDJ61 계정으로 복사해서 기초 데이터로 사용하기
drop table employees;
create table employees
    as (select *
          from hr.employees);

-- EMPLOYEES 테이블에 PK 생성하기
alter table employees
    add constraint pk_employee primary key(employee_id);


/*
     변수 선언하기
     1. 대입 연산자(:=)를 사용한다.
     2. 종류
        1) 스칼라 변수 : 타입을 직접 지정한다.
        2) 참조 변수   : 특정 칼럼의 타입을 가져다가 지정한다.
        3) 레코드 변수 : 2개 이상의 칼럼을 합쳐서 하나의 타입으로 지정한다.
        4) 행 변수     : 행 전체 데이터를 저장한다.
*/

-- 1. 스칼라 변수
--    직접 타입을 명시
declare
    name varchar2(10 byte);
    age number(3);
begin
    name := '제시카';
    age := 30;
    dbms_output.put_line('이름은 ' || name || '입니다.');
    dbms_output.put_line('나이는 ' || age || '살입니다.');
end;


-- 2. 참조 변수
--    특정 칼럼의 타입을 그대로 사용하는 변수
--    SELECT절의 INTO를 이용해서 테이블의 데이터를 가져와서 변수에 저장할 수 있다.
--    선언방법 : 변수명 테이블명.칼럼명%TYPE
declare
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


-- 3. 레코드 변수
--    여러 칼럼의 값을 동시에 저장하는 변수
--    레코드 변수 정의(만들기)와 레코드 변수 선언으로 구분해서 진행
declare
    -- 레코드 변수 정의하기
    type my_record_type is record(  -- 타입명 : MY_RECORD_TYPE
        fname employees.first_name%type,
        lname employees.last_name%type,
        sal employees.salary%type
    );
    -- 레코드 변수 선언하기
    emp my_record_type;
begin
    select first_name, last_name, salary
      into emp
      from employees
     where employee_id = 100;
    dbms_output.put_line(emp.fname || ',' || emp.lname || ',' || emp.sal);
end;


--  4. 행 변수
--     행 전체 데이터를 저장할 수 있는 타입
--     항상 행 전체 데이터를 저장해야 한다.
--     선언 방법 : 변수명 테이블명%ROWTYPE
declare
    emp employees%rowtype;
begin
    select employee_id, first_name, last_name, email, phone_number, hire_date, job_id, salary, commission_pct, manager_id, department_id
      into emp
      from employees
     where employee_id = 100;
    dbms_output.put_line(emp.first_name || ',' || emp.last_name || ',' || emp.salary);
end;


/*
    IF 구문
    
    IF 조건식 THEN
        실행문
    ELSIF 조건식 THEN
        실행문
    ELSE
        실행문
    END IF;
*/

-- 성적에 따른 학점(A,B,C,D,F) 출력하기
declare
    score number(3);
    grade char(1 byte);
begin
    score := 50;
    if score >= 90 then
        grade := 'A';
    elsif score >= 80 then
        grade := 'B';
    elsif score >= 70 then
        grade := 'C';
    elsif score >= 60 then
        grade := 'D';
    else
        grade := 'F';
    end if;
    dbms_output.put_line(score || '점은 ' || grade || '학점입니다.');
end;


-- EMPLOYEE_ID가 150인 사원의 SALARY가 15000 이상이면 '고액연봉', 아니면 '보통연봉'을 출력하시오.
declare
    emp_id employees.employee_id%type;
    sal employees.salary%type;
    message varchar2(20 byte);
begin
    emp_id := 150;
    select salary
      into sal
      from employees
     where employee_id = emp_id;
    if sal >= 15000 then
        message := '고액연봉';
    else
        message := '보통연봉';
    end if;
    dbms_output.put_line('사원번호 ' || emp_id || '인 사원의 연봉은 ' || sal || '이고 ' || message || '입니다.');
end;

-- EMPLOYEE_ID가 150인 사원의 COMMISSION_PCT가 0이면 '커미션없음', 아니면 실제 커미션(COMMISSION_PCT * SALARY)을 출력하시오.
declare
    emp_id employees.employee_id%type;
    comm_pct employees.commission_pct%type;
    sal employees.salary%type;
    message varchar2(20 byte);
begin
    emp_id := 150;
    select nvl(commission_pct, 0), salary
      into comm_pct, sal
      from employees
     where employee_id = emp_id;
    if comm_pct = 0 then
        message := '커미션없음';
    else
        message := to_char(comm_pct * sal);
    end if;
    dbms_output.put_line('사원번호 ' || emp_id || '인 사원의 커미션은 ' || message || '입니다.');
end;


/*
    CASE 구문
    
    CASE
        WHEN 조건식 THEN
            실행문
        WHEN 조건식 THEN
            실행문
        ELSE
            실행문
    END CASE;
*/

-- EMPLOYEE_ID가 150인 사원의 PHONE_NUMBER에 따른 지역을 출력하시오.
-- 011 : MOBILE
-- 515 : EAST
-- 590 : WEST
-- 603 : SOUTH
-- 650 : NORTH
declare
    emp_id employees.employee_id%type;
    phone char(3 byte);
    message varchar2(6 byte);
begin
    emp_id := 150;
    select substr(phone_number, 1, 3)
      into phone
      from employees
     where employee_id = emp_id;
    case
        when phone = '011' then
            message := 'MOBILE';
        when phone = '515' then
            message := 'EAST';
        when phone = '590' then
            message := 'WEST';
        when phone = '603' then
            message := 'SOUTH';
        when phone = '650' then
            message := 'NORTH';
    end case;
    dbms_output.put_line(phone || ',' || message);
end;


/*
    WHILE 구문
    
    WHILE 조건식 LOOP
        실행문
    END LOOP;
*/

-- 1 ~ 5 출력하기
declare
    n number(1);
begin
    n := 1;
    while n <= 5 loop
        dbms_output.put_line(n);
        n := n + 1;
    end loop;
end;

-- 사원번호가 100 ~ 206인 사원들의 FIRST_NAME, LAST_NAME을 조회하시오.
declare
    emp_id employees.employee_id%type;
    fname employees.first_name%type;
    lname employees.last_name%type;
begin
    emp_id := 100;
    while emp_id <= 206 loop
        select first_name, last_name
          into fname, lname
          from employees
         where employee_id = emp_id;
        dbms_output.put_line(fname || ' ' || lname);
        emp_id := emp_id + 1;
    end loop;
end;

-- 사원번호가 100 ~ 206인 사원들의 FIRST_NAME, LAST_NAME을 조회하시오.
-- FIRST_NAME과 LAST_NAME을 저장할 수 있는 레코드 변수를 활용하시오.
declare
    emp_id employees.employee_id%type;
    type name_type is record(
        fname employees.first_name%type,
        lname employees.last_name%type
    );
    full_name name_type;
begin
    emp_id := 100;
    while emp_id <= 206 loop
        select first_name, last_name
          into full_name
          from employees
         where employee_id = emp_id;
        dbms_output.put_line(full_name.fname || ' ' || full_name.lname);
        emp_id := emp_id + 1;
    end loop;
end;


/*
    FOR 구문
    
    FOR 변수 IN 시작..종료 LOOP
        실행문
    END LOOP;
*/
-- 1 ~ 5 출력하기
declare
    n number(1);
begin
    for n in 1..5 loop
        dbms_output.put_line(n);
    end loop;
end;

-- 1 ~ 10 사이 정수를 '짝수', '홀수', '3의배수'로 출력하시오.
declare
    n number(2);
    modular number(1);  -- 나머지 값
    message varchar2(10 byte);
begin
    for n in 1..10 loop
        select mod(n, 3)
          into modular
          from dual;
        if modular = 0 then
            message := '3의배수';
        else
            select mod(n, 2)
              into modular
              from dual;
            if modular = 1 then
                message := '홀수';
            else
                message := '짝수';
            end if;
        end if;
        dbms_output.put_line(n || '은(는) ' || message || '입니다.');
    end loop;
end;

-- 사원번호가 100 ~ 206인 사원들의 연봉 평균을 출력하시오.
-- 연봉 평균 = 연봉 합 / 사원 수
declare
    emp_id employees.employee_id%type;
    sal employees.salary%type;
    total number;
    cnt number;
begin
    total := 0;
    cnt := 0;
    for emp_id in 100..206 loop
        select salary
          into sal
          from employees
         where employee_id = emp_id;
         total := total + sal;
         cnt := cnt + 1;
    end loop;
    dbms_output.put_line(total / cnt);
end;

-- department_id 50인 사원들의 목록을 dept50 테이블로 복사하시오.
-- 1) dept50 테이블 만들기
-- 2) 행 변수로 employees 테이블의 정보 읽기
-- 3) department_id가 50이면 행 변수에 저장된 내용을 dept50 테이블에 insert
drop table dept50
create table dept50
    as (select employee_id, first_name, last_name, email, phone_number, hire_date, job_id, salary, commission_pct, manager_id, department_id
          from employees
         where 1 = 2);
         
/*
declare
    emp_id employees.employee_id%type;
    emp employees%rowtype;
begin
    for emp_id in 100..206 loop
        select employee_id, first_name, last_name, email, phone_number, hire_date, job_id, salary, commission_pct, manager_id, department_id
          into emp
          from employees
         where employee_id = emp_id;
        if emp.department_id = 50 then
             insert into dept50 values emp;
        end if;
    end loop;
    commit;
end;
*/

declare
    emp employees%rowtype;
begin
    for emp in (select employee_id, first_name, last_name, email, phone_number, hire_date, job_id, salary, commission_pct, manager_id, department_id 
                  from employees 
                 where department_id = 50) loop
        insert into dept50 values emp;
    end loop;
    commit;
end;

/*
    exit : 반복문 종료하기
    continue : loop문의 시작부터 다시 실행하기
*/

-- 1부터 정수 값을 누적하시오. 누적 값이 100을 초과하면 그만 누적하고 어디까지 누적했는지 출력하시오.
declare
    n number;
    total number;
begin 
    n := 1;
    total := 0;
    while true loop
        if total > 100 then
            exit;
        end if;
        total := total + n;
        n := n + 1;
    end loop;
    dbms_output.put_line('1부터 ' || n || '까지 합은 ' || total || '입니다.');
end;

-- 1부터 3의 배수를 제외한 정수 값을 누적하시오. 누적 값이 100을 초과하면 그만 누적하고 어디까지 누적했는지 출력하시오.
declare
    n number;
    total number;
    modular number(1);
begin 
    n := 0;
    total := 0;
    while true loop
        n := n + 1;
        if total > 100 then
            exit;
        end if;
        select mod(n, 3)
          into modular
          from dual;
        if modular = 0 then
            continue;
        end if;
        total := total + n;
    end loop;
    dbms_output.put_line(total || '입니다.');
end;

/*
    예외처리 구문
    
    exception
        when 예외종류 then
            예외처리
        when 예외종료 then
            예외처리
        when others then
            예외처리
*/
declare
    fname employees.first_name%type;
begin
    select first_name
      into fname
      from employees
     where employee_id = 0;
exception
    when no_data_found then
        dbms_output.put_line('조회된 데이터가 없습니다.');
end;

declare
    fname employees.first_name%type;
begin
    select first_name
      into fname
      from employees
     where department_id = 50;
exception
    when too_many_rows then
        dbms_output.put_line('조회된 데이터가 2개 이상입니다.');
end;

declare
    fname employees.first_name%type;
begin
    select first_name
      into fname
      from employees
     where employee_id = 0;
exception
    when others then
        dbms_output.put_line(sqlcode);
        dbms_output.put_line(sqlerrm);
end;