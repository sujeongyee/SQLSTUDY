
-- 시퀀스 (순차적으로 증가하는 값) - PK에 많이 사용됨

SELECT * FROM user_sequences;

-- 사용자 시퀀스 생성
CREATE SEQUENCE DEPTS_SEQ
       START WITH 1
       INCREMENT BY 1
       MAXVALUE 10
       MINVALUE 1
       NOCYCLE
       NOCACHE;
       
--시퀀스 삭제 (단, 사용되고 있는 시퀀스라면 주의)
DROP SEQUENCE DEPTS_SEQ;

DROP TABLE DEPTS;

CREATE TABLE DEPTS AS (SELECT * FROM DEPARTMENTS WHERE 1 = 2); --
ALTER TABLE DEPTS ADD CONSTRAINT DEPTS_PK PRIMARY KEY (DEPARTMENT_ID); --PK
SELECT * FROM DEPTS;

-- 시퀀스 이용
SELECT DEPTS_SEQ.NEXTVAL FROM DUAL; -- 시퀀스의 다음값
SELECT DEPTS_SEQ.CURRVAL FROM DUAL; -- 시퀀스의 현재값


INSERT INTO DEPTS VALUES(DEPTS_SEQ.NEXTVAL,'TEST',100,1000);
-- X 10 (시퀀의 최대값 도달하면 더이상 사용할 수 없음)

--시퀀스 수정
ALTER SEQUENCE DEPTS_SEQ MAXVALUE 99999;
ALTER SEQUENCE DEPTS_SEQ INCREMENT BY 10;

SELECT * FROM DEPTS;

-- 시퀀스 빠른 생성(기본 옵션으로 생성)
CREATE SEQUENCE DEPTS2_SEQ NOCACHE;
SELECT* FROM user_sequences;
DROP SEQUENCE DEPTS2_SEQ;


--시퀀스 초기화 (시퀀스가 테이블에서 사용되고 있는 경우면, 시퀀스를 DROP하면 안됩니다.)
-- 1 .현재시퀀스
SELECT DEPTS_SEQ.CURRVAL FROM DUAL;
-- 2 .증가값을 음수로 변경
ALTER SEQUENCE DEPTS_SEQ INCREMENT BY -89; -- 현재 시퀀스 -1로 감소
--3.시퀀스 실행
SELECT DEPTS_SEQ.NEXTVAL FROM DUAL;
INSERT INTO DEPTS VALUES(DEPTS_SEQ.NEXTVAL,'TEST',100,1000);
--4.시퀀스 증가값을 다시 1로 변경
ALTER SEQUENCE DEPTS_SEQ INCREMENT BY 1;
-- 이후부터 시퀀스는 2에서 시작..


-- 시퀀스 값이 너ㅓㅓㅓㅓㅓㅓㅓㅓ무커지면
-- 시퀀스 VS 년별로 시퀀스 VS 랜덤한 문자열
-- EX - 20230523-00001-상품번호
DROP TABLE DEPT3;

CREATE TABLE DEPT3 (
    DEPT_NO VARCHAR2(30) PRIMARY KEY,
    DEPT_NAME VARCHAR2(30)
);
SELECT * FROM DEPT3;
CREATE SEQUENCE DEPTS3_SEQ NOCACHE;
DROP SEQUENCE DEPTS3_SEQ;

INSERT INTO DEPT3 VALUES
(TO_CHAR(SYSDATE,'YYYYMMDD')|| '-'||
LPAD((DEPTS3_SEQ.NEXTVAL),5 ,'0')||'-'||'상품번호' ,'TEST');

SELECT * FROM DEPT3;

-----------------------------------------------------
--INDEX
--인덱스는 PK,UK에서 자동생성되는 UNIQUE인덱스가 있습니다.
--인덱스의 역할은 조회를 빠르게 해주는 HINT역할을 합니다.
--많이 변경되지 않는 일반컬럼에 인덱스를 적용할 수 있습니다.

CREATE TABLE EMP_IT AS (SELECT * FROM EMPLOYEES WHERE 1=1);
--인덱스가 없을때 조회 VS 인덱스 생성 후 조회
SELECT * FROM EMP_IT WHERE FIRST_NAME = 'Allan';
--인덱스 생성 (인덱스는 조회를 빠르게 하긴 하지만 , 무작위하게 많이 생성하면, 오히려 성능이 떨어질수 있습니다)
CREATE INDEX EMP_IT_IDX ON EMP_IT (FIRST_NAME);
CREATE UNIQUE INDEX EMP_IT_IDX ON EMP_IT (FIRST_NAME); --유니크인덱스(컬럼값이 유니크해야 합니다.)
--인덱스삭제
DROP INDEX EMP_IT_IDX;
--인덱스는 (결합인덱스) 여러컬럼을 지정할 수 있습니다.
CREATE INDEX EMP_IT_IDX ON EMP_IT (FIRST_NAME, LAST_NAME);
SELECT * FROM EMP_IT WHERE FIRST_NAME = 'Allan'; --인덱스 적용됨
SELECT* FROM EMP_IT WHERE FIRST_NAME = 'Allan' AND LAST_NAME = 'McEwen'; --인덱스 적용됨

-- FIRST_NAME 내림차순으로
-- 인덱스를 기준으로 힌트를 주는 방법

SELECT *
FROM (SELECT /*+ INDEX_DESC (E EMP_IT_IDX)*/
       ROWNUM RN,
       E.*
FROM EMP_IT E
ORDER BY FIRST_NAME DESC)
WHERE RN < 10 AND RN <=20;

---------------------------------------




       
       
       
       
       
       
       
       
       
       
       
       
       
       
