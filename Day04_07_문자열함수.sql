-- 문자열 함수


-- 1. 대소문자 변환 함수
select
       upper(email)   -- 대문자
     , lower(email)   -- 소문자
     , initcap(email) -- 첫 글자는 대문자, 나머지는 소문자
  from
       employees;


-- 2. 글자 수(바이트 수) 반환 함수
select
       length('HELLO')  -- 글자 수 : 5
     , length('안녕')   -- 글자 수 : 2
     , lengthb('HELLO') -- 바이트 수 : 5
     , lengthb('안녕')  -- 바이트 수 : 6
  from
       dual;


-- 3. 문자열 연결 함수/연산자
--    1) 함수   : CONCAT(A, B)  주의! 인수가 2개만 전달 가능하다.(CONCAT(A, B, C) 같은 형태는 불가능하다.)
--    2) 연산자 : ||   주의! OR 연산 아닙니다! 오라클 전용입니다!
select
       concat(concat(first_name, ' '), last_name)
     , first_name || ' ' || last_name
  from
       employees;


-- 4. 문자열 일부 반환하기
--    SUBSTR(칼럼, BEGIN, LENGTH) : BEGIN부터 LENGTH개를 반환
--    주의! BEGIN은 1에서 시작한다.
select
       substr(email, 1, 3)  -- 1번째 글자부터 3글자를 가져오시오.
  from
       employees;


-- 5. 특정 문자열의 위치 반환하기
--    INSTR(칼럼, 찾을문자열)
--    주의! 반환되는 위치 정보는 인덱스가 아니므로 0부터 시작하지 않고, 1부터 시작한다.
--    못 찾으면 0을 반환한다.
select
       instr(email, 'A')  -- 'A'의 위치를 반환
  from
       employees;


-- 6. 문자열 채우기(PADDING)
--    1) LPAD(칼럼, 전체폭, 채울문자)
--    2) RPAD(칼럼, 전체폭, 채울문자)
select
       lpad(nvl(department_id, 0), 3, '0')
     , rpad(substr(email, 1, 2), 5, '*')
  from
       employees;


-- 7. 불필요한 공백 제거
--    1) LTRIM(칼럼) : 왼쪽 공백 제거
--    2) RTRIM(칼럼) : 오른쪽 공백 제거
--    3) TRIM(칼럼)  : 왼쪽, 오른쪽 공백 모두 제거
select
       '[' || ltrim('     HELLO') || ']'
     , '[' || rtrim('HELLO     ') || ']'
     , '[' || trim('   HELLO   ') || ']'
  from
       dual;