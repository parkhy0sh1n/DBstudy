-- 샘플 데이터
drop table sample_tbl;
create table sample_tbl (
    name varchar2(10 byte),
    kor  number(3),
    eng  number(3),
    mat  number(3)
);

insert into sample_tbl(name, kor, eng, mat) values(null, 100, 100, 100);
insert into sample_tbl(name, kor, eng, mat) values('정숙', null, 90, 90);
insert into sample_tbl(name, kor, eng, mat) values('미희', 80, null, 80);
insert into sample_tbl(name, kor, eng, mat) values('철순', 70, 70, null);
commit;

-- null값이 포함된 연산 결과는 null이다.
select name, kor + eng + mat as total
  from sample_tbl;

-- 1. nvl(컬럼, null 대신 사용할 값)
select
       nvl(name, '아무개') as 이름
     , nvl(kor, 0) + nvl(eng, 0) + nvl(mat, 0) as 총점
  from
       sample_tbl;
       
-- 2. nvl2(컬럼, null이 아닐 때 사용할 값, null일 때 사용할 값)
select
       nvl2(kor + eng + mat, '응시', '결시')
  from 
       sample_tbl;
