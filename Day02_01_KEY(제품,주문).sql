/*
    KEY 제약조건
    1. 기본키(PK키 : Primary Key)
        1) 개체 무결성
        2) PK는 not null + unique 해야 한다.
    2. 외래키(FK : Foreign Key)
        1) 참조 무결성
        2) FK는 참조하는 값만 가질 수 있다.
*/

/*
    일대다(1:M) 관계
    1. PK와 FK를 가진 테이블 간의 관계이다.
        1) 부모 테이블 : 1, PK를 가진 테이블
        2) 자식 테이블 : M, FK를 가진 테이블
    2. 생성과 삭제 규칙
        1) 생성 규칙 : "반드시" 부모 테이블을 먼저 생성한다.
        2) 삭제 규칙 : "반드시" 자식 테이블을 먼저 삭제한다.
*/

/*
    외래키 제약 조건의 옵션
    1. on delete cascade
        1) 참조 중인 parent key가 삭제되면 해당 parent key를 가진 행 전체를 함께 삭제한다.
        2) 예시) 회원 탈퇴 시 작성한 모든 게시글이 함꼐 삭제됩니다.
                 게시글 삭제 시 해당 게시글에 달린 모든 댓글이 함께 삭제됩니다.
    2. on delete set null
        1) 참조 중인 parent key가 삭제되면 해당 parent key를 가진 컬럼 값만 null로 처리한다.
        2) 예시) 어떤 상품을 제거하였으나, 해당 상품의 주문 내역은 남아있는 경우
*/

-- 테이블 삭제
drop table order_tbl;
drop table product_tbl;



-- 제품 테이블(부모 테이블)
create table product_tbl (
    prod_no number not null,
    prod_name varchar2(10 byte),
    prod_price number,
    prod_stock number,
    constraint pk_prod primary key(prod_no)
);



-- 주문 테이블(자식 테이블)
create table order_tbl (
    order_no number not null,
    user_id varchar2(10 byte),
    prod_no number,
    order_date date,
    constraint pk_order primary key(order_no),
    constraint fk_order_prod foreign key(prod_no) references product_tbl(prod_no) on delete cascade
);


    
/*
    제약조건 테이블
    1. SYS, SYSTEM 관리 계정으로 접속해서 확인한다.
    2. 종류
        1) all_constraints      -- 모든 제약조건
        2) user_constraints     -- 사용자 제약조건
        3) dba_constraints      -- 관리자 제약조건
*/



-- 테이블의 구조를 확인하는 쿼리문 (설명)
-- describe all_constraints;
-- select * from user_constraints where constraint_name like 'pk%';





