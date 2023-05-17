-- 형변환 함수
-- 자동형변환
SELECT * FROM EMPLOYEES WHERE DEPARTMENT_ID = 30;
SELECT * FROM EMPLOYEES WHERE DEPARTMENT_ID = '30'; --자동형변환
SELECT  SYSDATE -5, SYSDATE -'5' FROM EMPLOYEES; --자동형변환

-- 강제형변환
-- TO_CHAR(날짜, 날짜포맷)
SELECT TO_CHAR(SYSDATE,'YYYY-MM-DD HH:MI:SS') FROM DUAL; --문자 
SELECT TO_CHAR(SYSDATE,'YY/MM/DD HH24/MI/SS') FROM DUAL; --문자
SELECT TO_CHAR(SYSDATE, 'YYYY"년"MM"월"DD"일"') FROM DUAL; --포맷 문자가 아닌 경우는 ""로 묶어줍니다
SELECT TO_CHAR(HIRE_DATE,'YYYY-DD') FROM EMPLOYEES;


--TO_CHAR(숫자,숫자포맷)
SELECT TO_CHAR(200000,'$999,999,999') FROM DUAL;
SELECT TO_CHAR(200000.1234,'999999.999') FROM DUAL; -- 소수점자리 표현
SELECT FIRST_NAME,TO_CHAR(SALARY * 1300,'L999,999,999,999') AS 우리나라돈 FROM EMPLOYEES;
SELECT FIRST_NAME, TO_CHAR(SALARY * 1300, 'L0999,999,999') FROM EMPLOYEES; --부족한 앞의 자리 수를 0으로 추가


--TO_NUMBER(문자, 숫자포맷)
SELECT '3.14'+2000 FROM DUAL; --자동형변환
SELECT TO_NUMBER('3.14') + 2000 FROM DUAL; --명시적변환
SELECT TO_NUMBER('$3,300','$999,999') + 2000 FROM DUAL;

--TO_DATE(문자, 날짜포맷)
SELECT SYSDATE - '2023-05-16' FROM DUAL; -- ERROR
SELECT SYSDATE - TO_DATE('2023-05-16','YYYY-MM-DD') FROM DUAL;
SELECT SYSDATE - TO_DATE('2023/05/16 11:31:23','YYYY/MM/DD HH:MI:SS') FROM DUAL;

-- 아래 값을 YYYY년 MM월 DD일 형태로 출력
SELECT '20050105' FROM DUAL;
SELECT TO_CHAR(TO_DATE('20050105','YYYYMMDD'),'YYYY"년"MM"월"DD"일"') FROM DUAL;

--아래 값과 현재 날짜의 차이를 구하세요 
SELECT SYSDATE - TO_DATE('2005년01월05일','YYYY"년"MM"월"DD"일"') FROM DUAL;

------------------------------------------------------------------------------
--NULL값에 대한 변환 NVL(컬럼,NULL일 경우 처리할 값)
SELECT NVL(NULL,0) FROM DUAL;
SELECT FIRST_NAME, COMMISSION_PCT*100 FROM EMPLOYEES; -- NULL에 연산을 해주면 NULL이 나옴
SELECT FIRST_NAME, NVL(COMMISSION_PCT,0)*100 FROM EMPLOYEES; --NULL 값에 0을 대입해서 곱해줌
SELECT FIRST_NAME, SALARY+(SALARY*NVL(COMMISSION_PCT,0)) FROM EMPLOYEES;

--NVL2(컬럼, NULL이 아닌 경우 처리값, NULL인 경우의 처리값)

SELECT NVL2(NULL,'널이아닙니다','널입니다') FROM DUAL; -- NULL일 경우 뒤에거 실행, NULL이 아닐경우 앞에꺼 실행
SELECT SALARY,
       NVL2(COMMISSION_PCT,SALARY+(SALARY*COMMISSION_PCT),SALARY) AS 급여 FROM EMPLOYEES;

--DECODE() - ELSE IF 문을 대체하는 함수
SELECT DECODE('D','A','A입니다',
                  'B','B입니다',
                  'C','C입니다',
                  'ABC가 아닙니다') FROM DUAL;

SELECT JOB_ID, 
       DECODE(JOB_ID,'IT_PROG', SALARY * 0.3,
                     'FI_MGR', SALARY * 0.2,
                      SALARY)
FROM EMPLOYEES;

--CASE WHEN THEN ELSE
--1ST
SELECT JOB_ID,
       CASE JOB_ID WHEN 'IT_PROG' THEN SALARY * 0.3
                   WHEN 'FI_MGR' THEN SALARY * 0.2
                   ELSE SALARY
       END
FROM EMPLOYEES;

--2ND (대소비교 OR 다른 칼럼의 비교가 가능)
SELECT JOB_ID,
       CASE WHEN JOB_ID = 'IT_PROG' THEN SALARY * 0.3
            WHEN JOB_ID = 'FI_MGR' THEN SALARY * 0.2
            ELSE SALARY
       END
FROM EMPLOYEES;

--COALESCE (A,B) - NVL이랑 유사 (NULL인 경우에만 치환)
SELECT COALESCE(NULL,1,2) FROM DUAL; --NULL이라면 1, 아니면 2
SELECT COALESCE(COMMISSION_PCT, 1) FROM EMPLOYEES;


--------------------------------------------------
SELECT * FROM EMPLOYEES;
SELECT EMPLOYEE_ID 사원번호,FIRST_NAME||' '||LAST_NAME 사원명,HIRE_DATE 입사일자, 
       TRUNC((SYSDATE-HIRE_DATE)/365) 근속년수 FROM EMPLOYEES WHERE ((SYSDATE-HIRE_DATE)/365)>=10 ORDER BY 근속년수 DESC ;


SELECT FIRST_NAME,MANAGER_ID,
       CASE MANAGER_ID WHEN 100 THEN '사원'
                       WHEN 120 THEN '주임'
                       WHEN 121 THEN '대리'
                       WHEN 122 THEN '과장'
                       ELSE '임원'
END AS 직급  FROM EMPLOYEES WHERE DEPARTMENT_ID>=50;



