/*
    사용자 함수(function)
    1. 어떤 값을 반환할 때 사용하는 데이터베이스 객체이다.
    2. 실제로 함수를 만들어서 사용하는 개념이다.
    3. return 개념이 존재한다.
    4. 함수의 결과 값을 확인할 수 있도록 select문에서 많이 사용한다.
    5. 형식
       create [or replace] function 함수명[(매개변수)]
       return 반환타입
       is -- as도 가능
          변수 선언
       begin
          함수 본문
       [exception
          예외 처리]
       end;
*/

-- 사용자 함수 func1 정의
create or replace function func1
return varchar2   -- 반환타입에서는 크기를 명시하지 않는다.
is
begin
    return 'hello world';
end;

-- 사용자 함수 func1 호출
select func1() from dual;

-- 사용자 함수 func2 정의
-- 사원번호를 전달하면 해당 사원의 full_name(steven king)을 반환하는 함수
-- 사용자 함수의 파라미터는 in/out 표기가 없다.
-- 입력 파라미터 현식으로 사용된다.
create or replace function func2(emp_id employees.employee_id%type)
return varchar2
is
    fname employees.first_name%type; 
    lname employees.last_name%type;
begin
    select first_name, last_name 
      into fname, lname
      from employees
     where employee_id = emp_id;
    return fname || ' ' || lname;
end;

-- 사용자 함수func2 호출
select employee_id, func2(employee_id)
  from employees;
 
-- 사용자 함수 func3 정의
-- 사원번호를 전달하면 해당 사원의 연봉이 15000 이상이면 '고액연봉', 아니면 '보통연봉'을 반환하는 함수
create or replace function func3(emp_id employees.employee_id%type)
return varchar2
is
    sal employees.salary%type;
    message varchar2(12 byte);
begin
    select salary
      into sal
      from employees
     where employee_id = emp_id;
    if sal >= 15000 then
        message := '고액연봉';
    else
        message := '보통연봉';
    end if;
    return message;
end;

-- 사용자 함수 func3 호출
select employee_id, first_name, last_name, salary, func3(employee_id)
  from employees;
  
-- 함수 my_ceil 정의
create or replace function my_ceil(n number,digit number)
return number
is
begin
    return ceil(n * power(10, digit)) / power(10, digit);
end;

-- 함수 my_ceil 호출
select
       my_ceil(111.111, 2)     -- 소수 2자리 올림
     , my_ceil(111.111, 1)     -- 소수 1자리 올림
     , my_ceil(111.111, 0)     -- 정수로 올림
     , my_ceil(111.111, -1)  -- 일의자리 올림
     , my_ceil(111.111, -2)  -- 십의자리 올림
 from
       dual;
