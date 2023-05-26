--서브쿼리
--SELECT문이 SELECT구문으로 들어가는 형태 : 스칼라 서브쿼리
--SELECT문이 FROM구문으로 들어가는 형태 : 인라인뷰
--SELECT문이 WHERE구문으로 들어가면 : 서브쿼리
--서브쿼리는 반드시 ()안에 적습니다


--단일행 서브쿼리 - 리턴되는 행이 1개인 서브쿼리
SELECT * 
FROM EMPLOYEES WHERE
SALARY > (SELECT SALARY FROM EMPLOYEES WHERE FIRST_NAME = 'NANCY');
SELECT SALARY FROM EMPLOYEES WHERE FIRST_NAME = 'NANCY';

--EMPLOYEE_ID가 103번인 사람과 동일한 직군
SELECT JOB_ID FROM EMPLOYEES WHERE EMPLOYEE_ID = 103;

SELECT *
FROM EMPLOYEES
WHERE JOB_ID = (SELECT JOB_ID FROM EMPLOYEES WHERE EMPLOYEE_ID = 103);

--주의할점, 단일행 이어야 합니다. 컬럼값도 1개여야 합니다.
--ERR
SELECT *
FROM EMPLOYEES
WHERE JOB_ID = (SELECT job_id FROM EMPLOYEES WHERE EMPLOYEE_ID = 103 or EMPLOYEE_ID = 104);

--------------------------------------------------------------------------------

--다중행 서브쿼리 - 행이 여러개라면 IN,ANY,ALL로 비교합니다
SELECT SALARY
FROM EMPLOYEES
WHERE FIRST_NAME = 'David';

-- IN 동일한 값을 찾음 IN (4800,6800,9500)
-- DAVID 이름을 가진 사람과 같은 급여를 가진 사람을 찾으세요
SELECT *
FROM EMPLOYEES
WHERE SALARY IN (SELECT SALARY FROM EMPLOYEES WHERE FIRST_NAME = 'David');

--ANY 최소값 보다 큼 , 최대값 보다 작음
SELECT * 
FROM EMPLOYEES
WHERE SALARY < ANY (SELECT SALARY FROM EMPLOYEES WHERE FIRST_NAME ='David');

--ALL 최대값 보다 큼, 최소값 보다 작음
SELECT *
FROM EMPLOYEES
WHERE SALARY < ALL (SELECT SALARY FROM EMPLOYEES WHERE FIRST_NAME = 'David');

-- 직업이  IT_PROG인 사람들보다 더 큰 급여를 받는 사람들

SELECT SALARY FROM EMPLOYEES WHERE JOB_ID = 'IT_PROG';

SELECT *
FROM EMPLOYEES
WHERE SALARY > ANY (SELECT SALARY FROM EMPLOYEES WHERE JOB_ID = 'IT_PROG');


-------------------------------------------------------------------------
SELECT * FROM EMPLOYEES;
--스칼라 서브쿼리
--JOIN시에 특정테이블의 1컬럼을 가지고 올 때 유리합니다
SELECT FIRST_NAME,
       EMAIL,
       (SELECT DEPARTMENT_NAME FROM DEPARTMENTS D WHERE D.DEPARTMENT_ID = E.DEPARTMENT_ID)
FROM EMPLOYEES E
ORDER BY FIRST_NAME;
--위와 같은 결과
SELECT FIRST_NAME,
       EMAIL,
       DEPARTMENT_NAME
FROM EMPLOYEES E
LEFT JOIN DEPARTMENTS D ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
ORDER BY FIRST_NAME;

-- 각 부서의 매니저 이름을 출력하고 싶다?
SELECT * FROM DEPARTMENTS;
--JOIN
SELECT D.*,
       E.FIRST_NAME
FROM DEPARTMENTS D LEFT JOIN EMPLOYEES E ON D.MANAGER_ID = E.EMPLOYEE_ID;
--스칼라
SELECT D.*,
       (SELECT FIRST_NAME FROM EMPLOYEES E WHERE E.EMPLOYEE_ID = D.MANAGER_ID) AS 매니저이름
FROM DEPARTMENTS D;
--스칼라쿼리는 여러번 사용 가능
SELECT * FROM JOBS;
SELECT * FROM DEPARTMENTS;
SELECT * FROM EMPLOYEES;

SELECT E.FIRST_NAME,
       E.JOB_ID,
       (SELECT JOB_TITLE FROM JOBS J WHERE J.JOB_ID = E.JOB_ID) AS JOB_TITLE,
       (SELECT DEPARTMENT_NAME FROM DEPARTMENTS D WHERE D.DEPARTMENT_ID = E.DEPARTMENT_ID) AS DEPARTMENT_NAME
FROM EMPLOYEES E;

--각 부서의 사원수를 출력............ + 부서정보
SELECT * FROM DEPARTMENTS;

--오류
SELECT DEPARTMENT_ID,
       COUNT(*),
       (SELECT D.* FROM DEPARTMENTS D WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID) AS 부서정보
FROM EMPLOYEES E GROUP BY DEPARTMENT_ID;

--쌤 풀이
SELECT D.*,
       NVL((SELECT COUNT(*) FROM EMPLOYEES E WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID GROUP BY DEPARTMENT_ID),0) AS 사원수     
FROM DEPARTMENTS D;

---------------------------------------------------------------------------------
--인라인 뷰
--가짜 테이블 형태

SELECT *
FROM (SELECT *
      FROM * (SELECT * FROM EMPLOYEES)
      );

-- ROWNUM은 조회된 순서이기 때문에, ORDER와 같이 사용되면 ROWNUM이 섞이는 문제
SELECT ROWNUM,
       FIRST_NAME,
       SALARY
FROM ((SELECT *
FROM EMPLOYEES
ORDER BY SALARY DESC));

--문법
SELECT ROWNUM,
       A.*
FROM(SELECT FIRST_NAME,
            SALARY
     FROM EMPLOYEES
     ORDER BY SALARY
     ) A ;

-- ROWNUM은 무조건 1번째부터 조회가 가능하기 때문
SELECT ROWNUM,
       FIRST_NAME,
       SALARY
FROM ((SELECT *
       FROM EMPLOYEES
       ORDER BY SALARY DESC))
WHERE ROWNUM BETWEEN 1 AND 20;

--2번째 인라인뷰에서 ROWNUM을 RN으로 컬럼화
SELECT *
FROM(SELECT ROWNUM RN,
            FIRST_NAME,
            SALARY
     FROM (SELECT *
           FROM EMPLOYEES
           ORDER BY SALARY DESC)
    )
WHERE RN >= 11 AND RN <= 20;

--인라인 뷰의 예시
SELECT TO_CHAR(REGDATE,'YY-MM-DD') AS REGDATE,
       NAME
FROM (SELECT '홍길동' AS NAME ,SYSDATE AS REGDATE FROM DUAL
      UNION ALL
      SELECT '이순신',SYSDATE AS REGDATE FROM DUAL);

--인라인 뷰의 응용
--부서별 사원수 

SELECT D.*,
       E.TOTAL
FROM DEPARTMENTS D 
LEFT JOIN (SELECT DEPARTMENT_ID, COUNT(*) AS TOTAL
           FROM EMPLOYEES 
           GROUP BY DEPARTMENT_ID) E
ON D.DEPARTMENT_ID = E.DEPARTMENT_ID;

-- 정리
-- 단일행 (대소비교) VS 다중 서브쿼리 (IN, ANY ,ALL)
-- 스칼라쿼리 - LEFT JOIN과 같은 역할, 한번에 1개의 컬럼을 가져올 때
-- 인라인뷰 - FROM에 들어가는 가짜 테이블

----------------------------------------------------------------------

--문제 1.
---EMPLOYEES 테이블에서 모든 사원들의 평균급여보다 높은 사원들을 데이터를 출력 하세요 ( AVG(컬럼) 사용)

SELECT *
FROM EMPLOYEES
WHERE SALARY > (SELECT AVG(SALARY) FROM EMPLOYEES)
ORDER BY SALARY;

---EMPLOYEES 테이블에서 모든 사원들의 평균급여보다 높은 사원들의 수를 출력하세요

SELECT COUNT(*) AS 사원수
FROM (SELECT SALARY FROM EMPLOYEES WHERE SALARY > (SELECT AVG(SALARY) FROM EMPLOYEES) GROUP BY SALARY);

---EMPLOYEES 테이블에서 job_id가 IT_PFOG인 사원들의 평균급여보다 높은 사원들을 데이터를 출력하세요

SELECT *
       FROM EMPLOYEES
       WHERE SALARY > (SELECT AVG(SALARY)
                       FROM EMPLOYEES 
                       WHERE JOB_ID = 'IT_PROG');

--문제 2.
---DEPARTMENTS테이블에서 manager_id가 100인 사람의 department_id와 EMPLOYEES테이블에서 department_id가 일치하는 모든 사원의 정보를 검색하세요

SELECT *
FROM EMPLOYEES
WHERE DEPARTMENT_ID = (SELECT DEPARTMENT_ID
                       FROM DEPARTMENTS
                       WHERE MANAGER_ID = 100);



--문제 3.
---EMPLOYEES테이블에서 “Pat”의 manager_id보다 높은 manager_id를 갖는 모든 사원의 데이터를 출력하세요

SELECT *
FROM EMPLOYEES
WHERE MANAGER_ID > (SELECT MANAGER_ID 
                    FROM EMPLOYEES 
                    WHERE FIRST_NAME = 'Pat');


SELECT * FROM EMPLOYEES;

---EMPLOYEES테이블에서 “James”(2명)들의 manager_id와 갖는 모든 사원의 데이터를 출력하세요.

SELECT *
FROM EMPLOYEES
WHERE MANAGER_ID IN (SELECT MANAGER_ID
                     FROM EMPLOYEES
                     WHERE FIRST_NAME = 'James');

--문제 4.
---EMPLOYEES테이블 에서 first_name기준으로 내림차순 정렬하고, 41~50번째 데이터의 행 번호, 이름을 출력하세요



SELECT *
FROM (SELECT ROWNUM RN,
       FIRST_NAME
       FROM (SELECT FIRST_NAME
             FROM EMPLOYEES E
             ORDER BY FIRST_NAME DESC))
WHERE RN >=40 AND RN <= 50;



--문제 5.
---EMPLOYEES테이블에서 hire_date기준으로 오름차순 정렬하고, 31~40번째 데이터의 행 번호, 사원id, 이름, 번호, 
--입사일을 출력하세요

SELECT *
FROM(SELECT ROWNUM RN ,E.*
     FROM (SELECT EMPLOYEE_ID, FIRST_NAME , PHONE_NUMBER,HIRE_DATE
           FROM EMPLOYEES
           ORDER BY HIRE_DATE)E)
WHERE RN>=31 AND RN<=40;


--문제 6.
--employees테이블 departments테이블을 left 조인하세요
--조건) 직원아이디, 이름(성, 이름), 부서아이디, 부서명 만 출력합니다.
--조건) 직원아이디 기준 오름차순 정렬


SELECT E.EMPLOYEE_ID , 
       CONCAT(FIRST_NAME,LAST_NAME), 
       D.DEPARTMENT_ID,
       D.DEPARTMENT_NAME
FROM EMPLOYEES E 
LEFT JOIN DEPARTMENTS D ON E.MANAGER_ID = D.MANAGER_ID
ORDER BY EMPLOYEE_ID;

SELECT * FROM EMPLOYEES;
SELECT * FROM DEPARTMENTS;

--문제 7.
--문제 6의 결과를 (스칼라 쿼리)로 동일하게 조회하세요

SELECT E.EMPLOYEE_ID, 
      (SELECT D.DEPARTMENT_ID FROM DEPARTMENTS D WHERE D.DEPARTMENT_ID = E.DEPARTMENT_ID) AS DEPARTMENT_ID,
      (SELECT D.DEPARTMENT_NAME FROM DEPARTMENTS D WHERE D.DEPARTMENT_ID = E.DEPARTMENT_ID) AS DEPARTMENT_NAME
FROM EMPLOYEES E
ORDER BY EMPLOYEE_ID;



--문제 8.
--departments테이블 locations테이블을 left 조인하세요
--조건) 부서아이디, 부서이름, 매니저아이디, 로케이션아이디, 스트릿_어드레스, 포스트 코드, 시티 만 출력합니다
--조건) 부서아이디 기준 오름차순 정렬
SELECT * FROM DEPARTMENTS;
SELECT * FROM LOCATIONS;

SELECT D.DEPARTMENT_ID,
       D.DEPARTMENT_NAME,
       D.LOCATION_ID,
       L.STREET_ADDRESS,
       L.POSTAL_CODE,
       L.CITY
FROM DEPARTMENTS D
LEFT JOIN LOCATIONS L ON D.LOCATION_ID = L.LOCATION_ID
ORDER BY D.DEPARTMENT_ID;

--문제 9.
--문제 8의 결과를 (스칼라 쿼리)로 동일하게 조회하세요

SELECT D.DEPARTMENT_ID,
       D.DEPARTMENT_NAME,
       D.LOCATION_ID, 
       (SELECT STREET_ADDRESS FROM LOCATIONS L WHERE D.LOCATION_ID = L.LOCATION_ID ) AS STREET_ADDRESS,
       (SELECT POSTAL_CODE FROM LOCATIONS L WHERE D.LOCATION_ID = L.LOCATION_ID) AS POSTAL_CODE 
FROM DEPARTMENTS D
ORDER BY DEPARTMENT_ID;


--문제 10.
--locations테이블 countries 테이블을 left 조인하세요
--조건) 로케이션아이디, 주소, 시티, country_id, country_name 만 출력합니다
--조건) country_name기준 오름차순 정렬

SELECT L.LOCATION_ID, 
       L.STREET_ADDRESS, 
       L.CITY, 
       L.COUNTRY_ID,
       C.COUNTRY_NAME
FROM LOCATIONS L 
LEFT JOIN COUNTRIES C ON L.COUNTRY_ID = C.COUNTRY_ID
ORDER BY C.COUNTRY_NAME;

--문제 11.
--문제 10의 결과를 (스칼라 쿼리)로 동일하게 조회하세요

SELECT * FROM COUNTRIES ;
SELECT * FROM LOCATIONS;

SELECT L.LOCATION_ID, 
       L.STREET_ADDRESS, 
       L.CITY, 
       L.COUNTRY_ID,
       (SELECT COUNTRY_NAME FROM COUNTRIES C WHERE C.COUNTRY_ID = L.COUNTRY_ID )AS COUNTRY_NAME
FROM LOCATIONS L
ORDER BY COUNTRY_NAME;

--문제 12. 
--employees테이블, departments테이블을 left조인 hire_date를 오름차순 기준으로 1-10번째 데이터만 출력합니다
--조건) rownum을 적용하여 번호, 직원아이디, 이름, 전화번호, 입사일, 부서아이디, 부서이름 을 출력합니다.
--조건) hire_date를 기준으로 오름차순 정렬 되어야 합니다. rownum이 틀어지면 안됩니다

SELECT * FROM EMPLOYEES; -- EMPLOYEE_ID, FIRST_NAME, PHONE_NUMBER, HIRE_DATE
SELECT * FROM DEPARTMENTS; -- DEPARTMENT_ID,DEPARTMENT_NAME

SELECT ROWNUM RN , E.*
FROM (SELECT EMPLOYEE_ID, 
       FIRST_NAME, 
       PHONE_NUMBER, 
       HIRE_DATE,
       D.DEPARTMENT_ID,
       D.DEPARTMENT_NAME
FROM EMPLOYEES E LEFT JOIN DEPARTMENTS D ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
WHERE ROWNUM>=1 AND ROWNUM <=10
ORDER BY HIRE_DATE)E;


--문제 13. 
--EMPLOYEES 과 DEPARTMENTS 테이블에서 JOB_ID가 SA_MAN 사원의 정보의 LAST_NAME, JOB_ID, 
--DEPARTMENT_ID,DEPARTMENT_NAME을 출력하세요

SELECT LAST_NAME, 
       E.JOB_ID , 
       D.DEPARTMENT_ID,
       D.DEPARTMENT_NAME 
FROM EMPLOYEES E JOIN DEPARTMENTS D ON D.MANAGER_ID = E.EMPLOYEE_ID
WHERE E.JOB_ID = 'SA_MAN';

--문제 14
--DEPARTMENT테이블에서 각 부서의 ID, NAME, MANAGER_ID와 부서에 속한 인원수를 출력하세요.
--인원수 기준 내림차순 정렬하세요.
--사람이 없는 부서는 출력하지 뽑지 않습니다


SELECT DEPARTMENT_ID,
       DEPARTMENT_NAME,
       MANAGER_ID
       (SELECT )
FROM DEPARTMENTS D;

SELECT COUNT(*)
FROM DEPARTMENTS 

SELECT * FROM EMPLOYEES;
SELECT * FROM DEPARTMENTS;




--문제 15
--부서에 대한 정보 전부와, 주소, 우편번호, 부서별 평균 연봉을 구해서 출력하세요
--부서별 평균이 없으면 0으로 출력하세요



--문제 16
--문제 15결과에 대해 DEPARTMENT_ID기준으로 내림차순 정렬해서 ROWNUM을 붙여 1-10데이터 까지만
--출력하세요
