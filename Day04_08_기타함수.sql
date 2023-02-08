-- 기타 함수


-- 1. 순위 구하기
--    1) rank() over(order by 순위구할컬럼 asc)  : 오름차순 순위(낮은 값이 1등), asc는 생략 가능
--    2) rank() over(order by 순위구할컬럼 desc) : 내림차순 순위(높은 값이 1등)
--    3) 동점자는 같은 등수로 처리
--    4) 순위 순으로 정렬된 상태로 조회
select 
       employee_id
     , first_name || ' ' || last_name as name
     , salary
     , rank() over(order by salary desc) as 연봉순위
  from employees;
  
-- 2. 분기 처리하기
--    1) decode(표현식
--          , 값1, 결과1
--          , 값2, 결과2
--          , ...)
--       표현식=값1이면 결과1을 반환, 표현식=값2이면 결과2를 반환, ...
--       표현식과 값의 동등 비교(=)만 가능하다.
select 
       employee_id
     , first_name
     , last_name
     , department_id
     , decode(department_id
          , 10, 'Administratin'
          , 20, 'Marketing'
          , 30, 'Purchasing'
          , 40, 'Human Resources'
          , 50, 'Sipping'
          , 60, 'IT') as department_name
  from employees
 where department_id in(10, 20, 30, 40, 50, 60);
 
-- 2) 분기 표현식
-- case
--     when 조건식1 then 결과값1
--     when 조건식2 then 결과값2
--     ...
--     else 결과값n
-- end
select 
       employee_id
     , first_name
     , last_name
     , salary
     , case
           when salary >= 15000 then 'A'
           when salary >= 10000 then 'B'
           when salary >= 5000 then 'C'
           else 'D'
       end
  from employees;
  
-- 3. 행 번호 반환하기
--    row_number() over(order by 컬럼 asc|desc)
--    정렬 결과에 행 번호를 추가해서 반환하는 함수
select
       row_number() over(order by salary desc)
       employee_id
     , first_name
     , last_name
     , salary
  from employees;