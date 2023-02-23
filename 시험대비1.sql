-- 사원번호를 전달하면 해당 사원의 이름을 반환하는 함수 만들기
CREATE OR REPLACE FUNCTION GET_NAME(EMPNO EMPLOYEE_TBL.EMP_NO%TYPE)
RETURN VARCHAR2
IS
    EMPNAME EMPLOYEE_TBL.NAME%TYPE;
BEGIN
    SELECT NAME
      INTO EMPNAME
      FROM EMPLOYEE_TBL
     WHERE EMP_NO = EMPNO;
    RETURN EMPNAME;
END;
-- 사원명
-- 구창민
SELECT GET_NAME(1001) AS 사원명                -- 전체
  FROM EMPLOYEE_TBL
 WHERE EMP_NO = 1001;

SELECT DISTINCT GET_NAME(1001) AS 사원명       -- 한 번만
  FROM EMPLOYEE_TBL;
  
SELECT GET_NAME(1001) AS 사원명
  FROM EMPLOYEE_TBL;