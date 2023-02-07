drop table proceeding_tbl;
drop table project_tbl;
drop table employee_tbl;
drop table department_tbl;

create table department_tbl (
    dept_no varchar2(15 byte) not null,
    dept_name varchar2(30 byte),
    dept_location varchar2(50 byte),
    constraint pk_dept primary key(dept_no_)
);

create table employee_tbl (
    emp_no number not null,
    dept_no varchar2(15 byte),
    position char(15 byte),
    name varchar2(15 byte),
    hire_date date,
    salary number,
    constraint pk_emp primary key(emp_no),
    constraint fk_emp_dept foreign key(dept_no) references department(dept_no)
);

create table project_tbl (
    pjt_no number not null,
    pjt_name varchar2(30 byte),
    begin_date date,
    end_date date,
    constraint pk_pjt primary key(pjt_no)
);

create table proceeding_tbl (
    pcd_no number not null,
    emp_no number,
    pjt_no number,
    pjt_state number not null,
    constraint pk_pro primary key(pcd_no),
    constraint pk_pro primary key(pjt_state),
    constraint fk_pro_emp foreign key(emp_no) references employee_tbl(emp_no),
    constraint fk_pro_pjt foreign key(pjt_no) references project_tbl(pjt_no)
);
    
    
    