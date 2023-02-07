/*
        DQL
        1. Data Query Language
        2. 데이터 질의(조회) 언어
        3. 테이블의 데이터를 조회하는 언어이다.
        4. 테이블의 내용에 변경이 생기진 않는다
            (트랜잭션의 대상이 아니고, COMMIT이 필요하지 않다.)
            (트랜잭션 처리 대상: 내용이 바뀌는 작업:삽입, 수정, 삭제)
        5. 형식([]는 생략 가능)
            select 조회할 컬럼, 조회헐컬럼, 조회할컬럼, ... 
            from 테이블명
            [where 조건식] 
            [group by 그룹화할컬럼]
            [having 그룹조건식] 
            [order by 정렬할컬럼 정렬방식]
        6. 순서
            1) from 테이블명
            2) [where 조건식] 
            3) [group by 그룹화할컬럼]
            4) select 조회할 컬럼, 조회헐컬럼, 조회할컬럼, ... 
            5) [order by 정렬할컬럼 정렬방식]
*/

/*
    트랜잭션
    1. Transaction
    2. 여러 개의 세부 작업으로 구성 된 하나의 작업을 의미한다.
    3. 모든 세부 작업이 성공하면 COMMIT이라고 하고, 하나라도 실패하면 모든 세부 작업의 취소를 진행한다.
        (All or Nothing)
*/

-- 조회 실습
-- 1. 사원 테이블에서 사원명 조회하기
-- 1) 기본 방식
select ename
  from emp;
-- 2) 오너 명시하기(테이블을 가지고 있는 계정)
select ename
  from scott.emp;
-- 3) 테이블 명시하기(컬럼을 가지고 있는 테이블)
select emp.ename
  from emp;
-- 4) 테이블 별명 지정하기
select e.ename
  from emp e;  -- emp 테이블의 별명을 e로 부여한다. as(alias)를 사용할 수 없다.
-- 5) 컬럼 별명 지정하기
select e.ename as 사원명  -- e.ename 컬럼의 별명을 '사원명'으로 부여한다. as(alias)를 사용할 수 있다.
  from emp e;
  
  
-- 2. 사원 테이블의 모든 컬럼 조회하기
-- 1) * 활용하기(select절에서 *는 모든 컬럼을 의미한다.)
select *       -- 불려 가기 싫으면 사용 금지!
  from emp;
-- 2) 모든 컬럼 직접 작성하기
select empno, ename, job, mgr, hiredate, sal, comm, deptno   
  from emp;


-- 3. 동일한 데이터는 한 번만 조회하기
--    distinct
select distinct job
  from emp;
  
  
-- 4. JOB이 MANAGER인 사원 목록 조회하기
select empno, ename, job, mgr, hiredate, sal, comm, deptno
  from emp
 where job = 'MANAGER';
 
select empno, ename, job, mgr, hiredate, sal, comm, deptno
  from emp
 where job IN('MANAGER');
 

-- 5. SAL이 1500 초과인 사원 목록 조회하기
select empno, ename, job, mgr, hiredate, sal, comm, deptno
  from emp
 where sal >= 1500;
 
 
-- 6. SAL이 2000 ~ 2999인 사원 목록 조회하기
select empno, ename, job, mgr, hiredate, sal, comm, deptno
  from emp
 where sal between 2000 and 2999;
 
 
-- 7. COMM을 받는 사원 목록 조회하기
--    1) null 이다   : is null
--    2) null 아니다  : is not null
select empno, ename, job, mgr, hiredate, sal, comm, deptno
  from emp
 where comm is not null 
   and comm != 0;
   
   
-- 8. ENAME이 A로 시작하는 사원 목록 조회하기
--    1) wild card
--       (1) % : 글자 수 제한 업는 모든 문자
--       (2) _ : 1글자로 제한된 모든 문자
--    2) 연산자
--       (1) like     : wild card를 포함항다.
--       (2) not like : wild card를 포함하지 않는다.
select empno, ename, job, mgr, hiredate, sal, comm, deptno
  from emp
 where emnam like 'A%';