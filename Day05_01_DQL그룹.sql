/*
    group by절
    1. group by절에서 지정한 컬럼의 데이터는 동일한 데이터끼리 하나로 모여서 조회된다.
    2. select절에서 조회하려는 컬럼은 "반드시" select절에 있어야 한다.(필수 규칙)
*/

-- 1. 동일한 department_id를 그룹화하여 조회하시오.
select department_id
  from employees
 group by department_id;
 
-- 2. 동일한 department_id를 그룹화하여 first_name과 department_id를 조회하시오. (실패하는 쿼리문)
select first_name, department_id   -- first_name 컬럼이 group by절에 없기 때문에 실행되지 않는다.
  from employees
 group by department_id;
 
-- 3. group by절이 없는 집계함수는 전체 데이터를 대상으로 한다.
select 
       count(*)    as 전체사원수
     , sum(salary) as 전체사원연봉합
     , avg(salary) as 전체사원연봉평균
     , max(salary) as 전체사원연봉킹
     , min(salary) as 전체사원연봉꽝
  from employees;
  
-- 4. group by절을 지정하면 같은 그룹끼리 집계함수가 적용된다.
select
       department_id
     , count(*)    as 부서별사원수
     , sum(salary) as 부서별연봉합
     , avg(salary) as 부서별연봉평균
     , max(salary) as 부서별연봉킹
     , min(salary) as 부서별연봉꽝
  from employees
 where department_id is not null
 group by department_id;
 
 -- 참고. group by 없이 집계함수 사용하기
 select
        distinct department_id
      , count(*) over(partition by department_id) as 부서별사원수
      , sum(salary) over(partition by department_id) as 부서별연봉합
      , avg(salary) over(partition by department_id) as 부서별연봉평균
      , max(salary) over(partition by department_id) as 부서별연봉킹
      , min(salary) over(partition by department_id) as 부서별연봉꽝
  from employees;             
 /*
    조건 지정하기
    1. group by절로 그룹화 할 대상(모수)이 적을수록 성능에 유리하다.
    2. group by 이전에 처리할 수 있는 조건은 where절로 처리하는 것이 유리하다.
    3. group by 이후에만 처리할 수 잇는 조건은 having절이 처리한다.
 */
 
-- 5. derpatment_id가 null인 부서를 제외하고, 모든 부서의 부서별 사원 수를 조회하시오.
--    해설) department_id가 null 부서의 재외는 group by 이전에 처리할 수 있으므로 where절에서 조건을 처리한다.
select 
       department_id
     , count(*) as 부서별사원수
  from employees
 where department_id is not null
 group by department_id;
 
 -- 6. 부서별 인원 수가 5명 이하인 부서를 조회하시오.
 --    해솔) 부서별 인원 수는 gropup by 이후에 확인할 수 있으므로 having절에서 조건을 처리한다.
 select 
       department_id
     , count(*) as 부서별사원수
  from employees
 group by department_id;
 havning count(*) <= 5;