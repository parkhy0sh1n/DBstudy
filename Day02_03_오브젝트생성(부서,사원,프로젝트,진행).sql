-- 테이블 삭제
drop table proceeding_tbl;
drop table project_tbl;
drop table employee_tbl;
drop table department_tbl;

-- 부서 테이블 생성
create table department_tbl (
    dept_no       varchar2(15 byte) not null,
    dept_name     varchar2(30 byte) null,
    dept_location varchar2(50 byte) null,
    constraint pk_dept primary key(dept_no)
);

-- 사원 테이블 생성
create table employee_tbl (
    emp_no     number            not null,
    dept_no    varchar2(15 byte) null,
    position   char(10 byte)     null,
    name       varchar2(15 byte) null,
    hire_date  date              null,
    salary     number            null,
    constraint pk_emp primary key(emp_no),
    constraint fk_emp_dept foreign key(dept_no) references department_tbl(dept_no) on delete set null   -- 부서가 없어지면 사원의 부서 정보만 null 처리된다.
);

-- 프로젝트 테이블 생성
create table project_tbl (
    pjt_no      number            not null,
    pjt_name    varchar2(30 byte) null,
    begin_date  date              null,
    end_date    date              null,
    constraint pk_pjt primary key(pjt_no)
);

-- 프로젝트진행 테이블 생성
create table proceeding_tbl (
    pcd_no    number not null,
    emp_no    number null,
    pjt_no    number null,
    pjt_state number not null,
    constraint pk_pcd primary key(pcd_no),
    constraint fk_pcd_emp foreign key(emp_no) references employee_tbl(emp_no) on delete set null,
    constraint fk_pcd_pjt foreign key(pjt_no) references project_tbl(pjt_no) on delete set null
);