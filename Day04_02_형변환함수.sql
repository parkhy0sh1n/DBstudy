/*
    dual 테이블
    1. dummy 컬럼 1개 + 'x' 값을 1개 가지고 있는 테이블이다.
    2. 아무 일도 안 하는 테이블이다.
    3. 오라클은 select - from절이 필수이므로 언제나 테이블이 필요하다.
        테이블이 필요 없는 값을 조회할 때 dual 테이블을 사용한다.
*/

-- 1. 숫자로 변환하기(to_number)
-- '100' -> 100
select '100', to_number('100') 
  from dual;
  
-- 심화. 오라클에서는 숫자과 '문자'를 연산하면 '문자'를 숫자로 변환한 뒤 연산한다.
-- 이 때 자동으로 to_number 함수가 사용된다.
select employee_id, first_name, last_name
  from employees
 where employee_id = '150';     -- employee_id = to_number('150')으로 자동으로 변환한 뒤 처리한다.
 
-- 2. 문자로 변환하기(to_char)
-- 1) 숫자를 문자로 변환하기
-- 100        -> '100'
-- 1000       -> '1,000'
 select
        to_char(100)             -- '100'
      , to_char(100, '999999')   -- '   100'
      , to_char(100, '000000')   -- '000100'
      , to_char(1234, '9,999')   -- '1,234'
      , to_char(12345, '9,999')  --  ###### (5자리 12345를 4자리 형식 9.999에 맞출 수 없다.)
      , to_char(12345, '99,999') -- '12,345'
      , to_char(0.123, '0.00')   -- '0.12' (반올림)
      , to_char(0.125, '0.00')   -- '0.13' (반올림)
  from
       dual;
-- 2) 날짜를 문자로 변환하기 (중요)
-- 날짜를 원하는 형식으로 변환활 떄 사용한다.
-- '2023-02-07' -> '2023년 02월 07일'

-- 먼저, 현재 날짜와 시간 확인하기
select
       sysdate      -- date 타입의 현재 날짜와 시간
     , systimestamp -- timestamp 타입의 현재 날짜와 시간
  from    
       dual;
       
-- 원하는 형식으로 현재 날짜와 시간을 확인하기
select
       to_char(sysdate, 'yyyy-mm-dd')
     , to_char(sysdate, 'am hh:mi;ss')
     , to_char(sysdate, 'hh24:mi:ss')
  from
       dual;
       
-- 3. 날짜와 변환하기(to_date)
-- 날짜와 시간을 원하는 형식으로 표시하는 함수가 아님을 주의하십시오.
-- '05/06/07'이 날짜는 알려주기 전에는 해석이 안 되는 날짜이다.
-- 어떤 날짜를 어떤 방법으로 해서해야 하는지 알려주는 함수가 to_date 함수이다.
select 
       to_date('05/06/07', 'yy/mm/dd')
     , to_date('05/06/07', 'mm/dd/yy')
  from 
       dual;
       
-- employees 테이블에서 00/01/01 ~ 05/12/31 사이에 입사한 사원 조회하기
select employee_id, first_name, last_name, hire_date
  from employees
 where to_date(hire_date, 'yy/mm/dd') between to_date('00/01/01', 'yy/mm/dd') and to_date('05/12/31', 'yy/mm/dd');
     
select employee_id, first_name, last_name, hire_date
  from employees     
     
-- 날짜 비교는 to_date 함수를 이용하자!
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
 where dt1 = to_date('23/02/07', 'yy/mm/dd');     
     
-- 됨
select dt1
  from sample_tbl   
 where to_date(dt1, 'yy/mm/dd') = to_date('23/02/07', 'yy/mm/dd'); 
     
-- 다시 한 번 주의!
select to_char(dt1, 'yyyy/mm/dd')       -- to_date : 원하는 형식이 적용 안 됨
  from sample_tbl;
 
 
