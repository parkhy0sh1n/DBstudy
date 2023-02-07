/*
    KEY 제약조건 변경하기
    1. 기본키
        1) 추가
            ALTER TABLE 테이블명 ADD CONSTRAINT 제약조건명 PRIMARY KEY(칼럼);
        2) 삭제
            ALTER TABLE 테이블명 DROP PRIMARY KEY;
            ALTER TABLE 테이블명 DROP CONSTRAINT 제약조건명;
    2. 외래키
        1) 추가
            ALTER TABLE 테이블명 ADD CONSTRAINT 제약조건명 FOREIGN KEY(칼럼) REFERENCES 부모테이블(참조칼럼) [옵션]
        2) 삭제
            ALTER TABLE 테이블명 DROP CONSTRAINT 제약조건명;
*/

drop table schedule_tbl;
drop table player_tbl;
drop table event_tbl;
drop table nation_tbl;

create table nation_tbl (
    n_code         number(3)         not null,
    n_name         varchar2(30 byte) not null,
    n_parti_person number,
    n_prev_event   number,
    n_prev_rank    number,
    n_curr_rank    number
);

create table event_tbl (
    e_code       number            not null,
    e_name       varchar2(30 byte) not null,
    e_first_year number(4),
    e_info       varchar2(100 byte)
);

create table player_tbl (
    p_code number(3)         not null,
    p_name varchar2(30 byte) not null,
    n_code number(3)         not null,
    e_code number            not null,
    p_rank number,
    p_age  number(3)
);

create table schedule_tbl (
    s_no         number(3) not null,
    n_code       number(3),
    e_code       number,
    s_start_date date,
    s_end_date   date,
    s_info       varchar2(100 byte)
);

-- 기본키 제거하기
alter table nation_tbl
    drop primary key;           -- 테이블의 기본키는 오직 1개이므로 제약조건의 이름을 몰라도 삭제할 수 있다.
alter table event_tbl
    drop primary key;
alter table plaryer_tbl
    drop primary key;
alter table schedule_tbl
    drop primary key;

-- 기본키 추가하기
alter table nation_tbl
    add constraint pk_nation primary key(n_code);
alter table event_tbl
    add constraint pk_event primary key(e_code);
alter table player_tbl
    add constraint pk_player primary key(p_code);
alter table schedule_tbl
    add constraint pk_schedule primary key(s_no);
        
-- 외래키 제거하기
alter table player_tbl
    drop constraint fk_player_nation;
alter table player_tbl
    drop constraint fk_player_event;
alter table schedule_tbl
    drop constraint fk_schedule_nation;
alter table schedule_tbl
    drop constraint fk_schedule_event;
    
-- 외래키 추가하기
alter table player_tbl
    add constraint fk_player_nation foreign key(n_code)
        references nation_tbl(n_code)
            on delete cascade;
alter table player_tbl
    add constraint fk_player_event foreign key(e_code)
        references event_tbl(e_code)
            on delete cascade;
alter table schedule_tbl
    add constraint fk_schedule_nation foreign key(n_code)
        references nation_tbl(n_code)
            on delete set null;     -- on delete cascade도 가능하다.
alter table schedule_tbl
    add constraint fk_schedule_event foreign key(e_code)
        references event_tbl(e_cdoe)
            on delete set null;     -- on delete cascade도 가능하다.
            
-- 연습. nation_tbl의 기본키 제거하기
-- 외래키(FK)에 의해서 참조 중인 기본키(PK)는 "반드시" 외래키를 먼저 삭제해야 한다.
alter table player_tbl
    drop constraint fk_player_nation;
alter table schedule_tbl
    drop constraint fk_schedule_nation;
alter table nation_tbl
    drop primary key;          

-- 외래키 제약 조건 일시 중지(비활성화)
alter table player_tbl
    disable constraint fk_player_event;
    
-- 외래키 제약 조건 다시 시작(활성화)
alter table player_tbl
    enable constraint fk_player_event;