-- 학생 이름, 담당 교수 이름 조회하기
-- 1) 표준 문법
select s.s_name, p.p_name
  from professor_tbl p inner join student_tbl s
    on p.p_no = s.p_no;
-- 2) 오라클 문법
select s.s_name, p.p_name
  from professor_tbl p, student_tbl s
 where p.p_no = s.p_no; 
 
-- 교수번호, 교수이름, 교수전공, 강의이름, 강의실을 조회하시오.
-- 1) 표준 문법
select p.p_no, p.p_name, p.p_major, l.l_name, l.l_location
  from professor_tbl p inner join lecture_tbl l
    on p.p_no = l.p_no;
-- 2) 오라클 문법
select p.p_no, p.p_name, p.p_major, l.l_name, l.l_location
  from professor_tbl p, lecture_tbl l
 where p.p_no = l.p_no;
 
-- 학번, 학생명, 수강 신청한 과목명을 조회하시오.
-- 1) 표준 문법
select s.s_no, s.s_name, c.c_name
  from student_tbl s inner join enroll_tbl e
    on s.s_no = e.s_no inner join course_tbl c
    on e.c_no = c.c_no;
-- 2) 오라클 문법
select s.s_no, s.s_name, c.c_name
  from student_tbl s, enroll_tbl e, c오ourse_tbl c
 where s.s_no = e.s_no
   and e.c_no = c.c_no;
   
-- 모든 교수들의 교수이름, 교수전공, 강의이름을 조회하시오. (교수는 총 3명이다.)
-- 1) 표준 문법
select p.p_name, p.p_major, l.l_name
  from professor_tbl p left outer join lecture_tbl l
    on p.p_no = l.p_no;
-- 2) 오라클 문법
select p.p_name, p.p_major, l.l_name
  from professor_tbl p, lecture_tbl l
 where p.p_no = l.p_no(+);