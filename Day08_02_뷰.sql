/*
    뷰(View)
    1. 테이블이나 뷰를 이용해서 만들어 낸 가상 테이블이다.
    2. 쿼리문 자체를 저장하고 있다.
    3. 자주 사용하는 
    4. 뷰로 인한 성능상의 이점은 없다.
*/

-- 뷰 만들기
create view view_emp
    as (select e.emp_no, e.name, e.depart, d.dept_name, e.gender, e.position, e.hire_date, e.salary
          from department_tbl d inner join employee_tbl e
            on d.dept_no = e.depart);
            
-- 뷰 조회하기
select emp_no, name, dept_name
  from view_emp
 where depart = 1;
 
-- 뷰 삭제하기
drop view view_emp;