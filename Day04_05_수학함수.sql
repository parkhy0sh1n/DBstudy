-- 수학 함수

-- 1. 제곱
--    POWER(A, B) : A의 B제곱
select power(2, 3)  -- 2의 3제곱
  from dual;


-- 2. 절댓값
--    ABS(A) : A의 절댓값
select abs(-5)
  from dual;


-- 3. 나머지 값
--    MOD(A, B) : A를 B로 나눈 나머지 값
select mod(7, 3)
  from dual;


-- 4. 부호 판별
--    SIGN(A) : A가 양수이면 1, A가 음수이면 -1, A가 0이면 0을 반환
select
       sign(5)
     , sign(-5)
     , sign(0)
  from
       dual;


-- 5. 제곱근(루트)
--    SQRT(A) : 루트 A
select sqrt(25) from dual;


-- 6. 정수로 올림
--    CEIL(A) : 실수 A를 정수로 올린 값을 반환
select
       ceil(1.1)
     , ceil(-1.1)
  from
       dual;


-- 7. 정수로 내림
--    FLOOR(A) : 실수 A를 정수로 내린 값을 반환
select
       floor(1.9)
     , floor(-1.9)
  from
       dual;


-- 8. 원하는 자릿수로 반올림
--    ROUND(A, [DIGIT]) : 실수 A를 DIGIT 자릿수로 반올린 값을 반환, DIGIT을 생략하면 정수로 반올린 값을 반환
select
       round(123.456)       -- 정수로 반올림
     , round(123.456, 1)    -- 소수 1자리 남기고 반올림
     , round(123.456, 2)    -- 소수 2자리 남기고 반올림
     , round(123.456, -1)   -- 일의 자리에서 반올림
     , round(123.456, -2)   -- 십의 자리에서 반올림
  from
       dual;


-- 9. 원하는 자릿수로 절사 (공부해 두기)
--    TRUNC(A, [DIGIT]) : 실수 A를 DIGIT 자릿수로 절사 값을 반환, DIGIT을 생략하면 정수로 절사한 값을 반환
select
       trunc(123.456)       -- 정수로 절사
     , trunc(123.456, 1)    -- 소수 1자리 남기고 절사
     , trunc(123.456, 2)    -- 소수 2자리 남기고 절사
     , trunc(123.456, -1)   -- 일의 자리에서 절사
     , trunc(123.456, -2)   -- 십의 자리에서 절사
  from
       dual;


-- 생각해보기.
-- FLOOR 함수와 TRUNC 함수는 무엇이 다른가?
-- FLOOR : 작은 정수 찾기
-- TRUNC : 보이는 소수점 자르기
select
       floor(1.9)
     , trunc(1.9)
     , floor(-1.9)
     , trunc(-1.9)
  from 
       dual;