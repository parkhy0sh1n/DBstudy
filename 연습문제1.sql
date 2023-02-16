-- 1. 다음 칼럼 정보를 이용하여 MEMBER_TBL 테이블을 생성하시오.
--    1) 회원번호: MEMBER_NO, NUMBER, 필수
--    2) 회원아이디: ID, VARCHAR2(30 BYTE), 필수, 중복 불가
--    3) 회원패스워드: PW, VARCHAR2(30 BYTE), 필수
--    4) 회원포인트: POINT, NUMBER
--    5) 회원등급: GRADE, VARCHAR2(10 BYTE), 'VIP', 'GOLD', 'SILVER', 'BRONZE' 값 중 하나를 가짐
--    6) 회원이메일: EMAIL, VARCHAR2(100 BYTE), 중복 불가
drop table board_tbl;
drop table member_tbl;

create table member_tbl (
	member_no number             not null,
	id        varchar2(30 byte)  not null unique,
	pw        varchar2(30 byte)  not null,
	point     number,
	grade     varchar2(10 byte)  check(grade in ('vip', 'gold', 'silver', 'bronze')),
	email     varchar2(100 byte) unique
);



-- 2. MEMBER_TBL 테이블에 다음 새로운 칼럼을 추가하시오.
--    1) 회원주소: ADDRESS VARCHAR2(200 BYTE)
--    2) 회원가입일: REGIST_DATE DATE
alter table member_tbl add address varchar2(200 byte);
alter table member_tbl add regist_date date;

-- 3. 추가된 회원주소 칼럼을 다시 삭제하시오.
alter table member_tbl drop column address;


-- 4. 회원등급 칼럼의 타입을 VARCHAR2(20 BYTE)으로 수정하시오.
alter table member_tbl modify grade varchar2(20 byte);

-- 5. 회원패스워드 칼럼의 이름을 PWD로 수정하시오.
alter table member_tbl rename column pw to pwd;

-- 6. 회원번호 칼럼에 기본키(PK_MEMBER)를 설정하시오.
alter table member_tbl add constraint pk_member primary key(member_no);

-- 7. 다음 칼럼 정보를 이용하여 BOARD_TBL 테이블을 생성하시오.
--    1) 글번호: BOARD_NO, NUMBER, 필수
--    2) 글제목: TITLE, VARCHAR2(1000 BYTE), 필수
--    3) 글내용: CONTENT, VARCHAR2(4000 BYTE), 필수
--    4) 조회수: HIT, VARCHAR2(1 BYTE)
--    5) 작성자: WRITER, VARCHAR2(30 BYTE), 필수
--    6) 작성일자: CREATE_DATE, DATE
create table board_tbl (
    board_no number not null,
    title varchar2(1000 byte) not null,
    content varchar2(4000 byte) not null,
    hit varchar2(1 byte),
    writer varchar2(30 byte) not null,
    create_date date
);


-- 8. 조회수 칼럼의 타입을 NUMBER로 수정하시오.
alter table board_tbl modify hit number;

-- 9. 글내용 칼럼의 필수 제약조건을 제거하시오.
alter table board_tbl modify content null;

-- 10. 글번호 칼럼에 기본키(PK_BOARD)를 설정하시오.
alter table board_tbl add constraint pk_board primary key(board_no);

-- 11. 작성자 칼럼에 MEMBER_TBL 테이블의 회원아이디를 참조하는 FK_BOARD_MEMBER 외래키를 설정하시오.
-- 게시글을 작성한 회원 정보가 삭제되면 해당 회원이 작성한 게시글도 모두 함께 지워지도록 처리하시오.
alter table board_tbl add constraint fk_board_member foreign key(writer) references member_tbl(id) on delete cascade;

-- 12. MEMBER_TBL 테이블과 BOARD_TBL 테이블을 모두 삭제하시오.