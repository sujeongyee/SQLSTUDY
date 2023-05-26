--문제 1.
--DEPTS테이블의 다음을 추가하세요

INSERT INTO DEPTS (DEPARTMENT_ID,DEPARTMENT_NAME,MANAGER_ID,LOCATION_ID) VALUES (280,'개발',NULL,1800);
INSERT INTO DEPTS (DEPARTMENT_ID,DEPARTMENT_NAME,MANAGER_ID,LOCATION_ID) VALUES (290,'회계',NULL,1800);                         
INSERT INTO DEPTS (DEPARTMENT_ID,DEPARTMENT_NAME,MANAGER_ID,LOCATION_ID) VALUES (300,'재정',301,1800);
INSERT INTO DEPTS (DEPARTMENT_ID,DEPARTMENT_NAME,MANAGER_ID,LOCATION_ID) VALUES (310,'인사',302,1800);
INSERT INTO DEPTS (DEPARTMENT_ID,DEPARTMENT_NAME,MANAGER_ID,LOCATION_ID) VALUES (320,'영업',303,1700);

SELECT * FROM DEPTS;

--문제 2.
--DEPTS테이블의 데이터를 수정합니다
--1. department_name 이 IT Support 인 데이터의 department_name을 IT bank로 변경

UPDATE DRPTS
SET DEPARTMENT_NAME = 'IT bank'
WHERE DEPARTMENT_NAME = 'IT Support';

--2. department_id가 290인 데이터의 manager_id를 301로 변경
UPDATE DRPTS
SET MANAGER_ID = 301
WHERE DEPARTMENT_ID = 290;


--3. department_name이 IT Helpdesk인 데이터의 부서명을 IT Help로 , 매니저아이디를 303으로, 지역아이디를
--1800으로 변경하세요

UPDATE DEPTS
SET DEPARTMENT_NAME = 'IT Help',
    MANAGER_ID = 303,
    LOCATION_ID = 1800
WHERE DRPARTMENT_NAME = 'IT Helpdesk';    

--4. 이사, 부장, 과장, 대리 의 매니저아이디를 301로 한번에 변경하세요.

UPDATE DEPTS
SET MANAGER_ID = 301
WHERE DEPARTMENT_NAME IN ('재정','인사','영업');

--문제 3.
--삭제의 조건은 항상 primary key로 합니다, 여기서 primary key는 department_id라고 가정합니다.
--1. 부서명 영업부를 삭제 하세요
--2. 부서명 NOC를 삭제하세요
SELECT * FROM DEPARTMENTS;

--DELETE FROM DEPTS WHERE DEPARTMENT_ID =;

--DELETE FROM DEPTS WHERE DEPARTMENT_ID =;

--DEPARTMENT_ID DEPARTMENT_NAME MANAGER_ID LOCATION_ID

--문제
--문제4
--1. Depts 사본테이블에서 department_id 가 200보다 큰 데이터를 삭제하세요.
DELETE FROM DEPTS WHERE DEPARTMENT_ID >=200;
--2. Depts 사본테이블의 manager_id가 null이 아닌 데이터의 manager_id를 전부 100으로 변경하세요.
UPDATE DEPTS SET MANAGER_ID = 100 WHERE MANAGER_ID IS NOT NULL;
--3. Depts 테이블은 타겟 테이블 입니다.
--4. Departments테이블은 매번 수정이 일어나는 테이블이라고 가정하고 Depts와 비교하여
--일치하는 경우 Depts의 부서명, 매니저ID, 지역ID를 업데이트 하고
--새로유입된 데이터는 그대로 추가해주는 merge문을 작성하세요.

MERGE INTO DEPTS D1
USING (SELECT * FROM DEPARTMENTS) D2
ON (D1.DEPATMENT_ID = D2.DEPARTMENT_ID)
WHEN MATCHED THEN
    UPDATE SET D1.DEPARTMENT_NAME = D2.DEPARTMENT_NAME,
               D1.MANAGER_ID = D2.MANAGER_ID,
              D1.LOCATION_ID = D2.LOCATION_ID
WHEN NOT MATCHED THEN
    INSERT VALUES (D2.DEPARTMENT_ID,D2.DEPARTMENT_NAME,D2.MANAGER_ID,D2.LOCATION_ID);

--문제 5
--1. jobs_it 사본 테이블을 생성하세요 (조건은 min_salary가 6000보다 큰 데이터만 복사합니다)
CREATE TABLE JOBS_IT AS (SELECT * FROM JOBS WHERE MIN_SALARY >=6000 AND 1=1);
--2. jobs_it 테이블에 다음 데이터를 추가하세요

INSERT INTO JOBS_IT VALUES('IT_DEV','아이티개발팀',6000,20000);
INSERT INTO JOBS_IT VALUES('NET_DEV','네트워크개발팀',5000,20000);
INSERT INTO JOBS_IT VALUES('SEC_DEV','보안개발팀',6000,19000);

--3. jobs_it은 타겟 테이블 입니다
--4. jobs테이블은 매번 수정이 일어나는 테이블이라고 가정하고 jobs_it과 비교하여
--min_salary컬럼이 0보다 큰 경우 기존의 데이터는 min_salary, max_salary를 업데이트 하고 새로 유입된
--데이터는 그대로 추가해주는 merge문을 작성하세요

MERGE INTO JOBS_IT J1
USING(SELECT * FROM JOBS WHERE MIN_SALARY >= 0) J2
ON (J.JOB_ID = J2.JOB_ID)
WHEN MATCHED THEN
    UPDATE SET J1.MIN_SALARY = J2.MIN_SALARY,
               J1.MAX_SALARY = J2.MAX_SALARY
WHEN NOT MATCHED THEN
    INSERT VALUES (J2.JOB_ID,J2.JOB_TITLE,J2.MIN_SALARY,J2.MAX_SALARY);