-- 테이블 삭제
drop table lecture_tbl;
drop table enroll_tbl;
drop table student_tbl;
drop table course_tbl;
drop table professor_tbl;



-- 1. PROFESSOR_TBL 테이블
create table professor_tbl (
    p_no    number            not null,  -- 기본키
    p_name  varchar2(30 byte) null,
    p_major varchar2(30 byte) null
);
-- 기본키
alter table professor_tbl
    add constraint pk_professor primary key(p_no);


-- 2. COURSE_TBL 테이블
create table course_tbl (
    c_no   number            not null,  -- 기본키
    c_name varchar2(30 byte) null,
    c_unit number(1)         null
);
-- 기본키
alter table course_tbl
    add constraint pk_course primary key(c_no);


-- 3. STUDENT_TBL 테이블
create table student_tbl (
    s_no       number             not null,  -- 기본키
    s_name     varchar2(30 byte)  null,
    s_address  varchar2(100 byte) null,
    s_grade_no number(1)          null,
    p_no       number             not null  -- PROFESSOR_TBL 테이블의 P_NO칼럼을 참조하는 외래키
);
-- 기본키
alter table student_tbl
    add constraint pk_student primary key(s_no);
-- 외래키
alter table student_tbl
    add constraint fk_student_professor foreign key(p_no) 
        references professor_tbl(p_no);


-- 4. ENROLL_TBL 테이블
create table enroll_tbl (
    e_no   number not null,
    s_no   number not null,  -- STUDENT 테이블의 S_NO 칼럼을 참조하는 외래키
    c_no   number not null,  -- COURSE  테이블의 C_NO 칼럼을 참조하는 외래키
    e_date date   null
);
-- 기본키
alter table enroll_tbl
    add constraint pk_enroll primary key(e_no);
-- 외래키
alter table enroll_tbl
    add constraint fk_enroll_student foreign key(s_no) 
        references student_tbl(s_no);
alter table enroll_tbl
    add constraint fk_enroll_course foreign key(c_no) 
        references course_tbl(c_no);


-- 5. LECTURE_TBL 테이블
create table lecture_tbl (
    l_no       number            not null,  -- 기본키
    p_no       number            not null,  -- PROFESSOR 테이블의 P_NO 칼럼을 참조하는 외래키
    e_no       number            not null,  -- ENROLL 테이블의 E_NO 칼럼을 참조하는 외래키
    l_name     varchar2(30 byte) null,
    l_location varchar2(30 byte) null
);
-- 기본키
alter table lecture_tbl
    add constraint pk_lecture primary key(l_no);
-- 외래키
alter table lecture_tbl
    add constraint fk_lecture_professor foreign key(p_no) 
        references professor_tbl(p_no);
alter table lecture_tbl
    add constraint fk_lecture_enroll foreign key(e_no) 
        references enroll_tbl(e_no);



-- 데이터 삽입

-- 1. PROFESSOR_TBL 테이블 데이터 입력
insert into professor_tbl(p_no, p_name, p_major) values (1, '제임스', '전산');
insert into professor_tbl(p_no, p_name, p_major) values (2, '앨리스', '회계');
insert into professor_tbl(p_no, p_name, p_major) values (3, '스미스', '영화');

-- 2. COURSE_TBL 테이블 데이터 입력
insert into course_tbl(c_no, c_name, c_unit) values (11, '자바', 3);
insert into course_tbl(c_no, c_name, c_unit) values (22, '데이터베이스', 3);
insert into course_tbl(c_no, c_name, c_unit) values (33, '서버프로그램', 3);

-- 3. STUDENT_TBL 테이블 데이터 입력
insert into student_tbl(s_no, s_name, s_address, s_grade_no, p_no) values (10101, '김학생', '서울', 1, 3);
insert into student_tbl(s_no, s_name, s_address, s_grade_no, p_no) values (10102, '이학생', '경기', 1, 3);
insert into student_tbl(s_no, s_name, s_address, s_grade_no, p_no) values (10103, '최학생', '인천', 1, 3);

-- 4. ENROLL_TBL 테이블 데이터 입력
insert into enroll_tbl(e_no, s_no, c_no, e_date) values (111, 10101, 11, '20-02-25');
insert into enroll_tbl(e_no, s_no, c_no, e_date) values (222, 10101, 22, '20-02-26');
insert into enroll_tbl(e_no, s_no, c_no, e_date) values (333, 10101, 33, '20-02-27');

-- 5. LECTURE_TBL 테이블 데이터 입력
insert into lecture_tbl(l_no, p_no, e_no, l_name, l_location) values (1111, 1, 111, '자바완전정복', 'A101');
insert into lecture_tbl(l_no, p_no, e_no, l_name, l_location) values (2222, 1, 111, '자바완전정복', 'B101');
insert into lecture_tbl(l_no, p_no, e_no, l_name, l_location) values (3333, 1, 111, '자바완전정복', 'C101');

-- 6. 변경된 내용을 DB에 반영
commit;