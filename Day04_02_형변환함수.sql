/*
    DUAL 테이블
    1. DUMMY 칼럼 1개 + 'X' 값을 1개 가지고 있는 테이블이다.
    2. 아무 일도 안하는 테이블이다.
    3. 오라클은 SELECT - FROM절이 필수이므로 언제나 테이블이 필요하다.
       테이블이 필요 없는 값을 조회할 때 DUAL 테이블을 사용한다.
*/


/* 1. 숫자로 변환하기(TO_NUMBER) */
-- '100' -> 100
select '100', to_number('100')
  from dual;

-- 심화. 오라클에서는 숫자와 '문자'를 연산하면 '문자'를 숫자로 변환한 뒤 연산한다.
-- 이 때 자동으로 TO_NUMBER 함수가 사용된다.
select employee_id, first_name, last_name
  from employees
 where employee_id = '150';  -- EMPLOYEE_ID = TO_NUMBER('150')으로 자동으로 변환한 뒤 처리한다.



/* 2. 문자로 변환하기(TO_CHAR) */

-- 1) 숫자를 문자로 변환하기
-- 100  -> '100'
-- 1000 -> '1,000'
select
       to_char(100)             -- '100'
     , to_char(100, '999999')   -- '   100'
     , to_char(100, '000000')   -- '000100'
     , to_char(1234, '9,999')   -- '1,234'
     , to_char(12345, '9,999')  -- ####### (5자리 12345를 4자리 형식 9,999에 맞출 수 없다.)
     , to_char(12345, '99,999') -- '12,345'
     , to_char(0.123, '0.00')   -- '0.12' (반올림)
     , to_char(0.125, '0.00')   -- '0.13' (반올림)
  from
       dual;

-- 2) 날짜를 문자로 변환하기 (중요)
-- 날짜를 원하는 형식으로 변환할 때 사용한다.
-- '2023-02-07' -> '2023년 02월 07일'

-- 먼저, 현재 날짜와 시간 확인하기
select
       sysdate       -- DATE 타입의 현재 날짜와 시간
     , systimestamp  -- TIMESTAMP 타입의 현재 날짜와 시간
  from
       dual;

-- 원하는 형식으로 현재 날짜와 시간 확인하기
select
       to_char(sysdate, 'YYYY-MM-DD')
     , to_char(sysdate, 'AM HH:MI:SS')
     , to_char(sysdate, 'HH24:MI:SS')
  from
       dual;


/* 3. 날짜로 변환하기(TO_DATE) */
-- 날짜와 시간을 원하는 형식으로 표시하는 함수가 아님을 주의하십시오.
-- '05/06/07' 이 날짜는 알려주기 전에는 해석이 안 되는 날짜이다.
-- 어떤 날짜를 어떤 방법으로 해석해야 하는지 알려주는 함수가 TO_DATE 이다.
select
       to_date('05/06/07', 'YY/MM/DD')
     , to_date('05/06/07', 'MM/DD/YY')
  from
       dual;

-- EMPLOYEES 테이블에서 2000/01/01 ~ 2005/12/31 사이에 입사한 사원 조회하기
select employee_id, first_name, last_name, hire_date
  from employees
 where to_date(hire_date, 'YY/MM/DD') between to_date('00/01/01', 'YY/MM/DD') and to_date('05/12/31', 'YY/MM/DD');


-- 날짜 비교는 TO_DATE 함수를 이용하자!
drop table sample_tbl;
create table sample_tbl (
    dt1 date
);

insert into sample_tbl(dt1) values(sysdate);
commit;

-- 안 됨
select dt1
  from sample_tbl
 where dt1 = '23/02/07';

-- 안 됨
select dt1
  from sample_tbl
 where dt1 = to_date('23/02/07', 'YY/MM/DD');

-- 됨
select dt1
  from sample_tbl
 where to_date(dt1, 'YY/MM/DD') = to_date('23/02/07', 'YY/MM/DD');

-- 다시 한 번 주의!
select 
       to_date(dt1, 'YYYY-MM-DD')  -- 원하는 형식이 적용 안 됨
     , to_char(dt1, 'YYYY-MM-DD')  -- 원하는 형식이 적용됨
  from
       sample_tbl;
