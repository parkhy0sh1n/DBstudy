/*
    DDL
    1. Data Definition Language
    2. 데이터 정의어
    3. 데이터베이스 객체(user, table, sequence, view, index 등)를 생성/수정/삭제하는 언어이다.
    4. 완료된 작업을 취소할 수 없다.(commit 할 필요가 없다. rollback을 할 수 없다.)
    5. 종류
        1) create : 생성
        2) alter  : 수정
        3) drop   : 삭제
*/

drop table customer_tbl;
drop table bank_tbl;

create table bank_tbl (
    bank_code varchar2(20 byte) not null,
    bank_name varchar2(30 byte),
    constraint pk_bank primary key(bank_code)
);

create table customer_tbl (
    no        number not null,
    name      varchar2(30 byte) not null,
    phone     varchar2(30 byte) unique,
    age       number check(age between 0 and 100),
    bank_code varchar2(20 byte),
    constraint pk_cus primary key(no),
    constraint fk_cus_bank foreign key(bank_code) references bank_tbl(bank_code)
);

/*
    테이블 변경하기
    1. 컬럼 추가   : alter table 테이블명 add           컬럼명 데이터타입 [제약조건]
    2. 컬럼 삭제   : alter table 테이블명 drop column   컬럼명
    3. 컬럼 수정   : alter table 테이블명 modify        컬럼명 데이터타입 [제약조건]
    4. 컬럼 이름   : alter table 테이블명 reanme column 기존칼럼명 to 신규컬럼명
    5. 테이블 이름 : alter table 테이블명 raname to 신규테이블명
*/

-- 1. bank_tbl 테이블에 연락처(bank_tel) 컬럼을 추가하시오.
alter table bank_tbl 
    add bank_tel varchar2(20 byte) not null;

-- 2. customer_tbl 테이블에서 나이(age) 컬럼을 삭제하시오.
alter table customer_tbl
    drop column age;

-- 3. bank_tbl 테이블의 은행명(bank_name) 컬럼의 데이터타입을 varchar2(15 byte)으로 변경하시오.
alter table bank_tbl
    modify bank_name varchar2(15 byte);
    
-- 4. customer_tbl 테이블에서 고객명(name) 컬럼의 이름을 cust_name으로 변경하시오.
alter table customer_tbl
    rename column name to cust_name;

-- 개인 실습
-- 5. customer_tbl 테이블에 grade 컬럼을 추가하시오.
--    grede 컬럼은 'vip', 'gold', 'silver', ' bronze' 중 하나의 값만 가질 수 있도록 check 제약조건을 지정하시오.
alter table customer_tbl
    add grade varchar2(6 byte) check(grade in('vip', 'gold', 'silver', 'bronze'));

-- 6. bank_tbl 테이블의 bank_name 컬럼에 not null 제약조건을 추가하시오.
alter table bank_tbl
    modify bank_name varchar2(15 byte) not null;

-- 7. customer_tbl 테이블의 no 컬럼의 이름을 cust_no로 변경하시오.
alter table customer_tbl
    rename column no to cust_no;

-- 8. customer_tbl 테이블의 phone 컬럼을 삭제하시오.
alter table customer_tbl
    drop column phone;

-- 9. customer_tbl 테이블의 cust_name 컬럼의 not null 제약조건을 null 제약조건으로 변경하시오.
alter table customer_tbl
    modify cust_name varchar2(30 byte) null;
