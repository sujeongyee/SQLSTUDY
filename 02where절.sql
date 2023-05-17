--WHERE절
SELECT * FROM EMPLOYEES;
SELECT * FROM EMPLOYEES WHERE SALARY = 4800; --같다
SELECT * FROM EMPLOYEES WHERE SALARY <> 4800; --같지앟다
SELECT * FROM EMPLOYEES WHERE DEPARTMENT_ID >= 100;
SELECT * FROM EMPLOYEES WHERE DEPARTMENT_ID < 50;
SELECT * FROM EMPLOYEES WHERE JOB_ID ='AD_ASST';
SELECT * FROM EMPLOYEES WHERE HIRE_DATE = '03/09/17';

--BETWEEN~AND, IN, LIKE
SELECT * FROM EMPLOYEES WHERE SALARY BETWEEN 6000 AND 12000; -- 값의 범위 앞에 BETWEEN //이상 ~ 이하
SELECT * FROM EMPLOYEES WHERE HIRE_DATE BETWEEN '08/01/01' AND '08/12/31'; -- 날짜 범위도 지정 가능(날짜 대소비교 가능)

SELECT * FROM EMPLOYEES WHERE DEPARTMENT_ID IN (10,20,30,40,50); -- 정확히 일치하는 데이터 찾기
SELECT * FROM EMPLOYEES WHERE JOB_ID IN ('ST_MAN','IT_PROG','HR_REP'); -- 문자도 가능

SELECT * FROM EMPLOYEES WHERE JOB_ID LIKE 'IT%'; -- IT로 시작하는
SELECT * FROM EMPLOYEES WHERE HIRE_DATE LIKE '03%'; -- 03년
SELECT * FROM EMPLOYEES WHERE HIRE_DATE LIKE '%03'; -- 3일
SELECT * FROM EMPLOYEES WHERE HIRE_DATE LIKE '%12%'; --12가 포함된
SELECT * FROM EMPLOYEES WHERE HIRE_DATE LIKE '___05%'; -- 5월
SELECT * FROM EMPLOYEES WHERE EMAIL LIKE '_A%'; -- 두번째 글짜가 A인

--IS NULL, IS NOT NULL
SELECT * FROM EMPLOYEES WHERE COMMISSION_PCT = NULL; -- X
SELECT * FROM EMPLOYEES WHERE COMMISSION_PCT IS NULL;
SELECT * FROM EMPLOYEES WHERE COMMISSION_PCT IS NOT NULL;

-- NOT, OR, AND
SELECT * FROM EMPLOYEES WHERE NOT SALARY >= 6000; -- NOT은 <>과 동일한 표현
-- AND가 OR보다 우선순위가 빠름
SELECT * FROM EMPLOYEES WHERE SALARY >= 6000 AND SALARY <= 12000; --BETWEEN 6000 AND 12000
SELECT * FROM EMPLOYEES WHERE JOB_ID = 'IT_PROG' AND SALARY >= 6000 ; --두 조건 다 만족하는
SELECT * FROM EMPLOYEES WHERE JOB_ID = 'IT_PROG' OR SALARY >= 6000 ;

SELECT * FROM EMPLOYEES WHERE JOB_ID = 'IT_PROG' OR JOB_ID = 'FI_MGR' AND SALARY >=6000; --AND가 먼저 동작해서
-- IT_PROG || FI_MGR중 샐러리가 6000 이상 -> 다 나옴
SELECT * FROM EMPLOYEES WHERE (JOB_ID = 'IT_PROG' OR JOB_ID = 'FI_MGR') AND SALARY >=6000; -- 이렇게 해주자
--------------------------------------------
--ORDER BY 컬럼 (앨리어스)
SELECT * FROM EMPLOYEES ORDER BY HIRE_DATE; --날짜 기준 ASC
SELECT * FROM EMPLOYEES ORDER BY HIRE_DATE DESC; --날짜 기준 내림차순

SELECT * FROM EMPLOYEES WHERE JOB_ID IN ('IP_PROG','ST_MAN') ORDER BY FIRST_NAME DESC;
SELECT * FROM EMPLOYEES WHERE SALARY BETWEEN 6000 AND 12000 ORDER BY EMPLOYEE_ID; 
--ALIAS도 ORDER절에 사용할 수 있음
SELECT  FIRST_NAME, SALARY *12 AS PAY FROM EMPLOYEES ORDER BY PAY ASC;
--정렬 여러개 ,로 나열
SELECT FIRST_NAME,SALARY,JOB_ID FROM EMPLOYEES ORDER BY JOB_ID ASC, SALARY DESC;




