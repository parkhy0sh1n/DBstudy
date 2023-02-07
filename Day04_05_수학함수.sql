-- 수학 함수

-- 1. 제곱
--    power(a, b) : a의 b제곱
select power(2, 3) from dual;

-- 2. 절대값
--    abs(a) : a의 절대값
select abs(-5) from dual;

-- 3. 나머지 값
--    mod(a, b) : a를 b로 나눈 나머지 값
select mod(7, 3) from dual;

-- 4. 부호 판별
--    sigh(a) : a기 양수이면 1, a가 음수이면 -1. a가
select sign(5), sign(-5), sign(0) from dual;

-- 5. 제곱근(루트)
--    sqrt(a) : 루트 a
selet sqrt(25) from dual;

-- 6. 정수로 올림
--    ceil(a) : 실수 a를 정수로 올린 값을 반환
select ceil(1.1), ceil(-1.1) from dual;

-- 7. 정수로 내림
--    floor(a) : 실수 a를 정수로 내린 값을 반환

-- 8. 원하는 자릿수로 반올림
--    ROUND(A, [DIGIT]) : 실수 A를 DIGIT 자릿수로 반올림 (없으면 정수)
SELECT 
       ROUND(123.456)       -- 123
     , ROUND(123.456, 1)    -- 123.5
     , ROUND(123.456, 2)    -- 123.46
     , ROUND(123.456, -1)   -- 120 (1의자리에서 반올림)
     , ROUND(123.456, -2)   -- 100 (10의 자리에서 반올림)
  FROM
       DUAL;   
       
-- 9. 원하는 자릿수로 절사 (중요)
--    TRUNC(A, [DIGIT]) : 실수 A를 DIGIT 자릿수로 절사 (없으면 정수)
-- ** 절사가 내림이 아닌 이유 예시) -1.9일 경우 내림(-2) 절사(-1)
SELECT 
       TRUNC(123.456)       -- 123
     , TRUNC(123.456, 1)    -- 123.4
     , TRUNC(123.456, 2)    -- 123.45
     , TRUNC(123.456, -1)   -- 120 (1의자리에서 절사)
     , TRUNC(123.456, -2)   -- 100 (10의 자리에서 절사)
  FROM
       DUAL;
       
-- 생각해보기
-- FLOOR 함수와 TRUNC 함수는 무엇이 다른가?
-- FLOOR : 작은 정수 찾기
— TRUNC : 보이는 소수점 자르기
SELECT
       FLOOR(1.9)
     , TRUNC(1.9)
     , FLOOR(-1.9)
     , TRUNC(-1.9)
  FROM 
       DUAL;
       