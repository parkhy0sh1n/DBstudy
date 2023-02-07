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

/*
    집계함수(그룹별 통계)
    1. 통계(합계, 평균, 개수, 최대, 최소 등)를 게산하는 함수이다.
    2. group by절에서 주로 사용한다.
    3. 종류
        1) 합계 : sum(컬럼)
        2) 평균 : avg(컬럼)
        3) 개수 : count(컬럼)
        4) 최대 : max(컬럼)
        5) 최소 : min(컬럼)
*/

/* 
   이름  국어 영어 수학 합계
   null, 100, 100, 100, 300
  '정숙', null, 90, 90, 180
  '미희', 80, null, 80. 160
  '철순', 70,  70, null 140
   합계  250  260 270
*/

-- 합계
select
       sum(kor)
     , sum(eng)
     , sum(mat)
--   , sum(kor, eng, mat)       -- sum 함수의 인수는 1개만 가능하다.
  from 
       sample_tbl;
  
-- 평균(응시 결과가 없으면 0으로 처리하기)
select
       avg(nvl(kor, 0))
     , avg(nvl(eng, 0))
     , avg(nvl(mat, 0))
  from 
       sample_tbl;
       
-- 개수
select 
      count(kor) -- 국어시험에 응시한 인원 수
    , count(eng) -- 영어시험에 응시한 인원 수
    , count(mat) -- 수학시험에 응시한 인원 수
    , count(*)   -- 모든 칼럼을 참조해서 어느 한 칼럼이라도 값을 가지고 있으면 개수에 포함시켜라 => 개수 구하는 함수이니 암기하기
 from
    sample_tbl;

-- 개수 정리!
-- 테이블에 포함된 데이터(행, ROW)의 개수는 COUNT(*)로 구한다.  
  dd