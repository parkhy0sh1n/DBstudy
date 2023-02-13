/*
  인덱스(Index)
  1. 빠른 검색을 위해서 데이터의 물리적 위치를기억하고 있는 데이터베이스 객체
  2. 인덱스가 등록된 칼럼을 이용한 검색은 빠르다.
  3. 인덱스가 자동으로 등록되는 경우
  	1) pk
  	2) unique
  4. 삽입, 수정, 삭제가 자주 발생하는 곳에서는 인덱스를 사용하면 성능이 떨어진다.	
*/

-- 인덱스 정보가 저장된 데이터 사전(메타 데이터, 시스템 카탈로그)
-- indexes : 인덱스정보
-- constraint : 제약조건 정보

describe all_indexes;
  select owner, index_name, table_name
    from all_indexes;

describe dba_indexes;
  select owner, index_name, table_name
    from dba_indexes;

describe user_indexes;
  select owner, index_name, table_name
    from user_indexes;

-- 인덱스 칼럼 정보가 저장된 데이터 사전
 all_ind_columns
 dba_ind_columns
 user_ind_columns

describe user_ind_columns;
 select index_name, table_name, column_name
   from user_ind_columns; 

-- 인덱스 생성하기
create index ind_name
    on book_tbl(book_name); 

-- 인덱스 삭제하기
drop index ind_name;   