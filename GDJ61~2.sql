/*
    서브쿼리(sub query)
    1. 메인쿼리에 포함하는 하위쿼리를 의미한다.
    2. 일반적으로 하위쿼리는 괄호()로 묶어서 메인쿼리에 포함한다.
    3. 하워쿼리가 항상 메인쿼리보다 먼저 실행된다.
*/

/*
    서브쿼리가 포함되는 위치
    1. select절 : 스칼라 서브쿼리
    2. from절   : 인라인 뷰
    3. where절  : 서브쿼리
*/

/*
    서브쿼리의 실행 결과에 의한 구분
    1. 단일 행 서브쿼리
        1) 결과 행이 1개이다.
        2) 단일 행 서브쿼리인 대표적인 경우
            (1) where절에서 사용한 동등비교(=) 칼럼이 pk, unique 칼럼인 경우
            (2) 집계함수처럼 결과가 1개의 값을 반환하는 경우
        3) 단일 행 서브쿼리에서 사용하는 연산자
            단일 행 연산자를 사용(=, !=, >, >=, <, <=)
    2. 다중 행 서브쿼리
        1) 결과 행이 1개 이상이다.
        2) from절, where절에서 많이 사용된다.
        3) 다중 행 서브쿼리에서 사용하는 연산자
            다중 행 연산자를 사용(in, any, all 등)
*/


/* where절의 서브쿼리 */

-- 1. 사원번호가 1001인 사원과 동일한 직급(position)을 가진 사원을 조회하시오.
select 사원정보
  from 사원
 where 직급 = (사원번호가 1001인 사원의 직급);

select emp_no, name, depart, gender, position, hire_date, salary
  from employee_tbl
 where position = (select position
                     from employee_tbl
                    where emp_no = 1001);


-- 2. 부서번호가 2인 부서와 동일한 지역에 있는 부서를 조회하시오.
select 부서정보
  from 부서
 where 지역 = (부서번호가 2인 부서의 지역);

select dept_no, dept_name, location
  from department_tbl
 where location = (select location
                     from department_tbl
                    where dept_no = 2);


-- 3. 가장 높은 급여를 받는 사원을 조회하시오.
select 사원정보
  from 사원
 where 급여 = (가장 높은 급여);

select emp_no, name, depart, gender, position, hire_date, salary
  from employee_tbl
 where salary = (select max(salary)
                   from employee_tbl);


-- 4. 평균 급여 이상을 받는 사원을 조회하시오.
select 사원정보
  from 사원
 where 급여 >= (평균 급여);

select emp_no, name, depart, gender, position, hire_date, salary
  from employee_tbl
 where salary >= (select avg(salary)
                    from employee_tbl);


-- 5. 평균 근속 개월 수 이상을 근무한 사원을 조회하시오.
select 사원정보
  from 사원
 where 근속개월수 >= (평균 근속개월수);

select emp_no, name, depart, gender, position, hire_date, salary
  from employee_tbl
 where months_between(sysdate, hire_date) >= (select avg(months_between(sysdate, hire_date))
                                                from employee_tbl);


-- 6. 부서번호가 2인 부서에 근무하는 사원들의 직급과 일치하는 사원을 조회하시오.
select 사원정보
  from 사원
 where 직급 in (부서번호가 2인 부서에 근무하는 사원들의 직급);

select emp_no, name, depart, gender, position, hire_date, salary
  from employee_tbl
 where position in (select position
                      from employee_tbl
                     where depart = 2);  -- where절에서 사용한 depart 칼럼이 pk/unique 칼럼이 아니므로 다중 행 서브쿼리이다.
                                         -- 따라서 단일 행 연산자인 등호(=) 대신 다중 행 연산자 in을 사용해야 한다.


-- 7. 부서명이 '영업부'인 부서에 근무하는 사원을 조회하시오.
select 사원정보
from 사원
where 부서번호 in (부서명이 '영업부'인 부서의 부서번호);

select emp_no, name, depart, gender, position, hire_date, salary
  from employee_tbl
 where depart in (select dept_no
                    from department_tbl
                   where dept_name = '영업부');  -- where절에서 사용한 depart_name 칼럼이 pk/unique가 아니므로 다중 행 서브쿼리이다.

-- 참고. 조인으로 풀기
select e.emp_no, e.name, e.depart, e.gender, e.position, e.hire_date, e.salary
  from department_tbl d inner join employee_tbl e
    on d.dept_no = e.depart
 where d.dept_name = '영업부';


-- 8. 직급이 '과장'인 사원들이 근무하는 부서 정보를 조회하시오.
select 부서정보
from 부서
where 부서번호 in (직급이 '과장'인 사원들이 근무하는 부서번호);

select dept_no, dept_name, location
  from department_tbl
 where dept_no in (select depart
                     from employee_tbl
                    where position = '과장');  -- where절에서 사용한 position 칼럼이 pk/unique가 아니므로 다중 행 서브쿼리이다.

-- 참고. 조인으로 풀기
select d.dept_no, d.dept_name, d.location
  from department_tbl d inner join employee_tbl e
    on d.dept_no = e.depart
 where e.position = '과장';


-- 9. '영업부'의 가장 높은 급여보다 더 높은 급여를 받는 사원을 조회하시오.
select 사원정보
from 사원
where 급여 > ('영업부'의 최대 급여);

select emp_no, name, depart, gender, position, hire_date, salary
  from employee_tbl
 where salary > (select max(salary)
                   from employee_tbl
                  where depart in (select dept_no
                                     from department_tbl
                                    where dept_name = '영업부'));

-- 참고. 서브쿼리를 조인으로 풀기
select emp_no, name, depart, gender, position, hire_date, salary
  from employee_tbl
 where salary > (select max(e.salary)
                   from department_tbl d inner join employee_tbl e
                     on d.dept_no = e.depart
                  where d.dept_name = '영업부');


/* select절의 서브쿼리 */






/*
    인라인 뷰(inline view)
    1. 쿼리문에 포함된 뷰(가상 테이블)이다.
    2. from절에 포함되는 서브쿼리를 의미한다.
    3. 단일 행/다중 행 개념이 필요 없다.
    4. 인라인 뷰에 포함된 칼럼만 메인쿼리에서 사용할 수 있다.
    5. 인라인 뷰를 이용해서 select문의 실행 순서를 조정할 수 있다.
*/

/*
    가상 칼럼
    1. pseudo column (p는 묵음)
    2. 존재하지만 저장되어 있지 않은 칼럼을 의미한다.
    3. 사용할 수 있지만 일부 사용에 제약이 있다.
    4. 종류
        1) rowid  : 행(row) 아이디, 어떤 행이 어디에 저장되어 있는지 알고 있는 칼럼(물리적 저장 위치)
        2) rownum : 행(row) 번호, 어떤 행의 순번
*/

-- rowid
select rowid, emp_no, name
  from employee_tbl;

-- 오라클의 가장 빠른 검색은 rowid를 이용한 검색이다.
-- 실무에선 rowid 사용이 불가능하기 때문에 대신 인덱스(index)를 활용한다.
select emp_no, name
  from employee_tbl
 where rowid = 'aaae9yaabaaalg5aaa';

/*
    rownum의 제약 사항
    1. rownum이 1을 포함하는 범위를 조건으로 사용할 수 있다.
    2. rownum이 1을 포함하지 않는 범위는 조건으로 사용할 수 없다.
    3. 모든 rownum을 사용하려면 rownum에 별명을 지정하고 그 별명을 사용하면 된다.
*/

select emp_no, name
  from employee_tbl
 where rownum = 1;  -- rownum이 1을 포함한 범위가 사용되므로 가능!

select emp_no, name
  from employee_tbl
 where rownum <= 2;  -- rownum이 1을 포함한 범위가 사용되므로 가능!
 
select emp_no, name
  from employee_tbl
 where rownum = 2;  -- rownum이 1을 포함한 범위가 아니므로 불가능!

select rownum as rn, emp_no, name
  from employee_tbl
 where rn = 2;  -- 실행 순서가 맞지 않기 때문에 실행이 불가능하다.(별명을 사용할 수 없다.)
                -- 별명 지정을 where절보다 먼저 처리하면 해결된다.
                -- 별명을 지정하는 인라인 뷰를 사용하면 가장 먼저 별명이 지정되므로 해결된다.

select e.emp_no, e.name
  from (select rownum as rn, emp_no, name
          from employee_tbl) e
 where e.rn = 2;

/* from절의 서브쿼리 */

-- 1.연봉이 2번째로 높은 사원을 조회하시오.
--   1) 연봉순으로 정렬한다.
--   2) 정렬 결과에 행 번호(rownum)을 붙인다.
--   3) 원하는 행 번호를 조회한다.

-- 1) rownum 컬럼 사용하기
select e.emp_no, e.name, e.depart, e.gender, e.position, e.hire_date, e.salary
  from (select rownum as rn, a.emp_no, a.name, a.depart, a.gender, a.position, a.hire_date, a.salary
          from (select emp_no, name, depart, gender, position, hire_date, salary
                  from employee_tbl
         order by salary desc) a) e
 where e.rn = 3;

select e.emp_no, e.name
  from (select rownum as rn, a.emp_no, a.name
          from(select emp_no, name
                 from employee_tbl
                order by salary desc) a) e
 where e.rn = 3;

-- 2) row_number() 함수 사용하기
select e.emp_no, e.name, e.depart, e.gender, e.position, e.hire_date, e.salary
  from (select row_number() over(order by salary desc) as rn, emp_no, name, depart, gender, position, hire_date, salary
          from employee_tbl) e
 where e.rn = 3;

-- 2. 3~4번째로 입사한 사원을 조회하시오.
--    1) 입사일자순으로 정렬한다.
--    2) 정렬 결과에 행 번호(rownum)을 붙인다.
--    3) 원하는 행 번호를 조회한다.

-- 1) rownum 컬럼 사용하기
select e.emp_no, e.name, e.depart, e.gender, e.position, e.hire_date, e.salary
  from (select rownum as rn, a.emp_no, a.name, a.depart, a.gender, a.position, a.hire_date, a.salary
          from (select emp_no, name, depart, gender, position, hire_date, salary
                  from employee_tbl
         order by hire_date desc) a) e
 where e.rn = 3 or e.rn = 4;
-- 2) row_number() 함수 사용하기
select e.emp_no, e.name, e.depart, e.gender, e.position, e.hire_date, e.salary
  from (select row_number() over(order by hire_date asc) as rn, emp_no, name, depart, gender, position, hire_date, salary
          from employee_tbl) e
 where e.rn = 3 or e.rn = 4;
