drop table enroll_tbl;
drop table subject_tbl;
drop table student_tbl;

-- 학생 테이블 생성
create table student_tbl (
    stu_no    varchar2(5 byte)  not null,
    stu_name  varchar2(15 byte) null,
    stu_age   number(3)         null,
    constraint pk_student primary key(stu_no)
);

-- 과목 테이블 생성
create table subject_tbl (
    sjt_code  varchar2(1 byte)  not null,
    sjt_name  varchar2(10 byte) null,
    professor varchar2(15 byte) null,
    constraint pk_subject primary key(sjt_code)
);

-- 수강신청 테이블 생성
create table enroll_tbl (
    enr_no   number           not null,
    stu_no   varchar2(5 byte) not null,
    sjt_code varchar2(1 byte) not null,
    constraint pk_enroll primary key(enr_no),
    constraint fk_enroll_student foreign key(stu_no) references student_tbl(stu_no) on delete cascade,
    constraint fk_enroll_subject foreign key(sjt_code) references subject_tbl(sjt_code) on delete cascade
);