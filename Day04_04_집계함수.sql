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
    1. 통계(합계, 평균, 개수, 최대, 최소 등)를 계산하는 함수이다.
    2. GROUP BY절에서 주로 사용한다.
    3. 종류
        1) 합계 : SUM(칼럼)
        2) 평균 : AVG(칼럼)
        3) 개수 : COUNT(칼럼)
        4) 최대 : MAX(칼럼)
        5) 최소 : MIN(칼럼)
    4. NULL값은 연산에서 제외한다.
*/

/*
    이름  국어 영어 수학  합계(SUM으로 구할 수 없는 합계이다.)
    NULL, 100, 100, 100   300
    '정숙', NULL, 90, 90  180
    '미희', 80, NULL, 80  160
    '철순', 70, 70, NULL  140
    --------------------------
    합계   250  260  270
    (SUM으로 구할 수 있는 합계이다.)
*/


-- 합계
select
       sum(kor)
     , sum(eng)
     , sum(mat)
--   , SUM(KOR, ENG, MAT)  -- SUM 함수의 인수는 1개만 가능하다.
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
       count(kor)  -- 국어 시험에 응시한 인원 수
     , count(eng)  -- 영어 시험에 응시한 인원 수
     , count(mat)  -- 수학 시험에 응시한 인원 수
     , count(*)    -- 모든 칼럼을 참조해서 어느 한 칼럼이라도 값을 가지고 있으면 개수에 포함
  from
       sample_tbl;

-- 개수 정리!
-- 테이블에 포함된 데이터(행, ROW)의 개수는 COUNT(*)로 구한다.
  