-- 테이블 구조 파악
describe employees;     -- desc까지 줄일 수 있음

-- 1. employees 테이블에서 first_name, last_name 조회하기
select first_name, last_name
  from employees;
  
-- 2. employees 테이블에서 department_id를 중복 제거하고 조회하기
select distinct department_id
  from employees;
  
-- 3. employees 테이블에서 employee_id가 150인 사원 조회하기
select employee_id, first_name, last_name
  from employees
 where employee_id = 150;       -- where절(조건)의 등호(=)는 비교 연산자이다.
 
-- 4. employees 테이블에서 salary가 10000 ~ 20000 사이인 사원 조회하기
select employee_id, first_name, last_name, salary
  from employees
 where salary between 10000 and 20000;
 
-- 5. employees 테이블에서 department_id가 30, 40, 50인 사원 조회하기
select employee_id, first_name, last_name, department_id
  from employees
 where department_id in(30, 40, 50);
 
-- 6. employees 테이블에서 department_id가 null인 사원 조회하기
select employee_id, first_name, last_name, department_id
  from employees
 where department_id is null;       -- is not null
 
-- 7. employees 테이블에서 phone_number가 515로 시작하는 사원 조회하기
select employee_id, first_name, last_name, phone_number
  from employees
 where phone_number like '515%';    -- phone_number not like '515%'
 
-- 8. employees 테이블을 first_name의 가나다순(오름차순)으로 정렬해서 조회하기
select employee_id, first_name, last_name
  from employees
 order by first_name asc;    -- asc는 생략 가능하다.
 
-- 9. employees 테이블을 높은 salary를 받는 사원을 먼저 조회하기
select employee_id, first_name, last_name, salary
  from employees
 order by salary desc;       -- desc는 생략이 불가능하다.

-- 10. employees 테이블의 사원들을 department_id순으로 조회하고, 동일한 department_id를 가진 사원들은 높은 salary순으로 조회하기
select employee_id, first_name, last_name, department_id, salary
  from employees
 order by department_id asc, salary desc;

