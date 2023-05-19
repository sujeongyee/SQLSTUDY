SELECT * FROM INFO;
SELECT * FROM AUTH;

-- INNER JOIN (중복된 값만 출력 // 붙을 수 있는 데이터가 없으면 안나옴)
SELECT * FROM INFO INNER JOIN AUTH ON INFO.AUTH_ID=AUTH.AUTH_ID;

-- AUTH_ID는 양쪽 테이블에 모두 존재하기 때문에, SELECT에서 테이블명을 함께 기술해야 합니다
SELECT ID,
       TITLE,
       INFO.AUTH_ID,
       NAME
FROM INFO INNER JOIN AUTH ON INFO.AUTH_ID = AUTH.AUTH_ID;

-- 테이블 엘리어스
SELECT I.ID,
       I.TITLE,
       I.AUTH_ID,
       A.NAME
FROM INFO I
INNER JOIN AUTH A
ON I.AUTH_ID = A.AUTH_ID;

--WHERE
SELECT *
FROM INFO I 
INNER JOIN AUTH A
ON I.AUTH_ID = A.AUTH_ID
WHERE ID IN (1,2,3)
ORDER BY ID DESC;

-- INNER JOIN USING
SELECT *
FROM INFO
INNER JOIN AUTH
USING (AUTH_ID);
------------------------------------------------------
-- OUTER JOIN
-- LEFT OUTER JOIN (왼쪽 기준 다 나옴)
SELECT * FROM INFO I LEFT OUTER JOIN AUTH A ON I.AUTH_ID = A.AUTH_ID;
-- RIGHT OUTER JOIN (오른쪽 기준 다 나옴)
SELECT * FROM INFO I RIGHT OUTER JOIN AUTH A ON I.AUTH_ID = A.AUTH_ID;
SELECT * FROM AUTH A LEFT OUTER JOIN INFO I ON A.AUTH_ID = I.AUTH_ID;
-- 위와 값이 같음 ,기준만 다를뿐!
-- FULL OUTER JOIN (걍 다 나옴)
SELECT * FROM INFO I FULL OUTER JOIN AUTH A ON I.AUTH_ID = A.AUTH_ID;
-- CROSS JOIN
SELECT * FROM INFO CROSS JOIN AUTH ;



----------------------------------------------------------

SELECT * FROM EMPLOYEES;
SELECT * FROM DEPARTMENTS;
SELECT * FROM LOCATIONS;

SELECT * FROM EMPLOYEES E JOIN DEPARTMENTS D ON E.DEPARTMENT_ID = D.DEPARTMENT_ID;
-- 조인은 여러번 들어갈 수 있습니다.
SELECT * FROM EMPLOYEES E LEFT JOIN DEPARTMENTS D ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
                          LEFT JOIN LOCATIONS L ON D.LOCATION_ID = L.LOCATION_ID;
                          
-- SELF JOIN
SELECT * FROM EMPLOYEES;

SELECT E1.FIRST_NAME,E1.MANAGER_ID , E2. FIRST_NAME,E2.EMPLOYEE_ID 
FROM EMPLOYEES E1 LEFT OUTER JOIN EMPLOYEES E2 ON E1.MANAGER_ID = E2.EMPLOYEE_ID; 

SELECT E1.*,
       E2.FIRST_NAME AS 상급자
FROM EMPLOYEES E1 LEFT JOIN EMPLOYEES E2 ON E1.MANAGER_ID = E2.EMPLOYEE_ID;

--------------------------------------------------------------
-- 오라클 조인구문
-- FROM절 아래에 테이블을 나열, WHERE에 JOIN의 조건을 씁니다

--INNER JOIN
SELECT * FROM EMPLOYEES E, DEPARTMENTS D
WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID;

--LEFT JOIN
SELECT * FROM EMPLOYEES E, DEPARTMENTS D
WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID(+);

--RIGHT JOIN
SELECT * FROM EMPLOYEES E, DEPARTMENTS D
WHERE E.DEPARTMENT_ID(+) = D.DEPARTMENT_ID;

--FULL OUTER JOIN 없습니다.
-- 조건이 있다면 AND로 연결해서 사용합니다
















                          