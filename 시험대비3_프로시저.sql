-- 전달된 부서번호의 부서를 삭제하는 프로시저를 작성하시오.
-- 전달된 부서에 근무하는 모든 사원을 함꼐 삭제하시오.
CREATE OR REPLACE PROCEDURE DELETE_PROC(DEPTNO IN DEPARTMENT_TBL.DEPT_NO%TYPE)  -- %TYPE : 테이블 컬럼과 PL/SQL 변수 간의 유형 호환성이 유지된다.
IS       -- 변수, 상수 선언부
BEGIN    -- 실행부
    DELETE
      FROM EMPLOYEE_TBL
     WHERE DEPART = DEPTNO;
    DELETE
      FROM DEPARTMENT_TBL
     WHERE DEPT_NO = DEPTNO;
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE(SQLCODE);
        DBMS_OUTPUT.PUT_LINE(SQLCODE);
        ROLLBACK;   -- 예외 발생 시 마지막 COMMIT;으로 돌아간다.
END;

EXECUTE DELETE_PROC(1);