--���� 1.
--EMPLOYEES ���̺��� ��� ������� ��ձ޿����� ���� ������� �����͸� ��� �ϼ��� ( AVG(�÷�) ���)

SELECT *
FROM EMPLOYEES 
WHERE SALARY > (SELECT AVG(SALARY) FROM EMPLOYEES);

--EMPLOYEES ���̺��� ��� ������� ��ձ޿����� ���� ������� ���� ����ϼ���

SELECT COUNT(*)
FROM EMPLOYEES
WHERE SALARY >(SELECT AVG(SALARY) FROM EMPLOYEES);

--EMPLOYEES ���̺��� job_id�� IT_PFOG�� ������� ��ձ޿����� ���� ������� �����͸� ����ϼ���

SELECT *
FROM EMPLOYEES
WHERE SALARY >(SELECT AVG(SALARY) FROM EMPLOYEES WHERE JOB_ID = 'IT_PROG');

--���� 2.
--DEPARTMENTS���̺��� manager_id�� 100�� ����� department_id��
--EMPLOYEES���̺��� department_id�� ��ġ�ϴ� ��� ����� ������ �˻��ϼ���.

SELECT *
FROM EMPLOYEES
WHERE DEPARTMENT_ID = (SELECT DEPARTMENT_ID FROM DEPARTMENTS WHERE MANAGER_ID = 100);

--���� 3.
--EMPLOYEES���̺��� ��Pat���� manager_id���� ���� manager_id�� ���� ��� ����� �����͸� ����ϼ���

SELECT *
FROM EMPLOYEES
WHERE MANAGER_ID > (SELECT MANAGER_ID
                    FROM EMPLOYEES
                    WHERE FIRST_NAME = 'Pat');

--EMPLOYEES���̺��� ��James��(2��)���� manager_id�� ���� ��� ����� �����͸� ����ϼ���.

SELECT *
FROM EMPLOYEES
WHERE MANAGER_ID IN (SELECT MANAGER_ID
                     FROM EMPLOYEES
                     WHERE FIRST_NAME = 'James');

--���� 4.
--EMPLOYEES���̺� ���� first_name�������� �������� �����ϰ�, 41~50��° �������� �� ��ȣ, �̸��� ����ϼ���
SELECT * 
FROM(SELECT ROWNUM RN, 
            FIRST_NAME
     FROM (SELECT FIRST_NAME
           FROM EMPLOYEES
           ORDER BY FIRST_NAME DESC) FIRST_NAME)
WHERE RN BETWEEN 41 AND 50;

--���� 5.
--EMPLOYEES���̺��� hire_date�������� �������� �����ϰ�, 31~40��° �������� �� ��ȣ, ���id, �̸�, ��ȣ, 
--�Ի����� ����ϼ���.
SELECT *
FROM (SELECT ROWNUM RN , INFO.*
      FROM (SELECT EMPLOYEE_ID,
                   FIRST_NAME || ' ' || LAST_NAME AS NAME,
                   PHONE_NUMBER,
                   HIRE_DATE
            FROM EMPLOYEES
            ORDER BY HIRE_DATE)INFO)
WHERE RN BETWEEN 31 AND 40;

--���� 6.
--employees���̺� departments���̺��� left �����ϼ���
--����) �������̵�, �̸�(��, �̸�), �μ����̵�, �μ��� �� ����մϴ�.
--����) �������̵� ���� �������� ����

SELECT EMPLOYEE_ID,
       FIRST_NAME||' '||LAST_NAME AS NAME,
       D.DEPARTMENT_ID,
       D.DEPARTMENT_NAME
FROM EMPLOYEES E LEFT JOIN DEPARTMENTS D ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
ORDER BY EMPLOYEE_ID;

--���� 7.
--���� 6�� ����� (��Į�� ����)�� �����ϰ� ��ȸ�ϼ���

SELECT EMPLOYEE_ID,
       FIRST_NAME||' '||LAST_NAME AS NAME,
       (SELECT DEPARTMENT_ID FROM DEPARTMENTS D WHERE D.DEPARTMENT_ID = E.DEPARTMENT_ID) AS DEPARTMENT_ID,
       (SELECT DEPARTMENT_NAME FROM DEPARTMENTS D WHERE D.DEPARTMENT_ID = E.DEPARTMENT_ID) AS DEPARTMENT_NAME
FROM EMPLOYEES E
ORDER BY EMPLOYEE_ID;

--���� 8.
--departments���̺� locations���̺��� left �����ϼ���
--����) �μ����̵�, �μ��̸�, �Ŵ������̵�, �����̼Ǿ��̵�, ��Ʈ��_��巹��, ����Ʈ �ڵ�, ��Ƽ �� ����մϴ�
--����) �μ����̵� ���� �������� ����
SELECT * FROM DEPARTMENTS;
SELECT * FROM LOCATIONS;

SELECT DEPARTMENT_ID,
       DEPARTMENT_NAME,
       MANAGER_ID,
       D.LOCATION_ID,
       L.STREET_ADDRESS,
       L.POSTAL_CODE,
       L.CITY
FROM DEPARTMENTS D LEFT JOIN LOCATIONS L ON L.LOCATION_ID = D.LOCATION_ID
ORDER BY DEPARTMENT_ID;

--���� 9.
--���� 8�� ����� (��Į�� ����)�� �����ϰ� ��ȸ�ϼ���

SELECT DEPARTMENT_ID,
       DEPARTMENT_NAME,
       MANAGER_ID,
       LOCATION_ID,
       (SELECT STREET_ADDRESS FROM LOCATIONS L WHERE L.LOCATION_ID = D.LOCATION_ID),
       (SELECT POSTAL_CODE FROM LOCATIONS L WHERE L.LOCATION_ID = D.LOCATION_ID),
       (SELECT CITY FROM LOCATIONS L WHERE L.LOCATION_ID = D.LOCATION_ID )
FROM DEPARTMENTS D
ORDER BY DEPARTMENT_ID;


--���� 10.
--locations���̺� countries ���̺��� left �����ϼ���
--����) �����̼Ǿ��̵�, �ּ�, ��Ƽ, country_id, country_name �� ����մϴ�
--����) country_name���� �������� ����
SELECT * FROM COUNTRIES;

SELECT LOCATION_ID,
       STREET_ADDRESS,
       CITY,
       L.COUNTRY_ID,
       C.COUNTRY_NAME
FROM LOCATIONS L LEFT JOIN COUNTRIES C ON C.COUNTRY_ID = L.COUNTRY_ID
ORDER BY C.COUNTRY_NAME;   


--���� 11.
--���� 10�� ����� (��Į�� ����)�� �����ϰ� ��ȸ�ϼ���

SELECT LOCATION_ID,
       STREET_ADDRESS,
       CITY,
       COUNTRY_ID,
       (SELECT COUNTRY_NAME FROM COUNTRIES C WHERE C.COUNTRY_ID = L.COUNTRY_ID) AS COUNTRY_NAME
FROM LOCATIONS L
ORDER BY COUNTRY_NAME;

--���� 12. 
--employees���̺�, departments���̺��� left���� hire_date�� �������� �������� 1-10��° �����͸� ����մϴ�
--����) rownum�� �����Ͽ� ��ȣ, �������̵�, �̸�, ��ȭ��ȣ, �Ի���, �μ����̵�, �μ��̸� �� ����մϴ�.
--����) hire_date�� �������� �������� ���� �Ǿ�� �մϴ�. rownum�� Ʋ������ �ȵ˴ϴ�.
SELECT *
FROM(SELECT ROWNUM RN,INFO.*      
     FROM (SELECT EMPLOYEE_ID,
                  FIRST_NAME,
                  PHONE_NUMBER,
                  HIRE_DATE,
                  E.DEPARTMENT_ID,
                  D.DEPARTMENT_NAME            
           FROM EMPLOYEES E
           LEFT JOIN DEPARTMENTS D
           ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
           ORDER BY HIRE_DATE)INFO)
WHERE RN <11;


--���� 13. 
--EMPLOYEES �� DEPARTMENTS ���̺��� JOB_ID�� SA_MAN ����� ������ LAST_NAME, JOB_ID, 
--DEPARTMENT_ID,DEPARTMENT_NAME�� ����ϼ���

--��Ǯ��
SELECT E.LAST_NAME,
       E.JOB_ID,
       E.DEPARTMENT_ID,
       D.DEPARTMENT_NAME
FROM (SELECT *
      FROM EMPLOYEES
      WHERE JOB_ID = 'SA_MAN') E
JOIN DEPARTMENTS D
ON E.DEPARTMENT_ID = D.DEPARTMENT_ID;


SELECT LAST_NAME, 
       E.JOB_ID , 
       D.DEPARTMENT_ID,
       D.DEPARTMENT_NAME 
FROM EMPLOYEES E JOIN DEPARTMENTS D ON D.MANAGER_ID = E.EMPLOYEE_ID
WHERE E.JOB_ID = 'SA_MAN';


--���� 14
--DEPARTMENT���̺��� �� �μ��� ID, NAME, MANAGER_ID�� �μ��� ���� �ο����� ����ϼ���.
--�ο��� ���� �������� �����ϼ���.
--����� ���� �μ��� ������� ���� �ʽ��ϴ�

SELECT D.DEPARTMENT_ID,
       DEPARTMENT_NAME,
       MANAGER_ID,
       A.�ο���
FROM DEPARTMENTS D 
JOIN (SELECT COUNT(*)�ο��� ,
             DEPARTMENT_ID  
      FROM EMPLOYEES 
      GROUP BY DEPARTMENT_ID) A 
ON D.DEPARTMENT_ID = A.DEPARTMENT_ID
ORDER BY A.�ο��� DESC;

--��Ǯ��

SELECT D.DEPARTMENT_ID,
       D.DEPARTMENT_NAME,
       D.MANAGER_ID,
       E.�ο���
FROM DEPARTMENTS D 
JOIN (SELECT DEPARTMENT_ID,
             COUNT(*) �ο���
      FROM EMPLOYEES
      GROUP BY DEPARTMENT_ID) E
ON D.DEPARTMENT_ID = E.DEPARTMENT_ID
ORDER BY �ο��� DESC;      



--���� 15
--�μ��� ���� ���� ���ο�, �ּ�, �����ȣ, �μ��� ��� ������ ���ؼ� ����ϼ���
--�μ��� ����� ������ 0���� ����ϼ���

SELECT * FROM EMPLOYEES;
SELECT * FROM DEPARTMENTS;
SELECT * FROM LOCATIONS;

-- ��Į������,JOIN�ѹ� ����
SELECT D.*,
       (SELECT STREET_ADDRESS FROM LOCATIONS L WHERE L.LOCATION_ID = D.LOCATION_ID ) AS �ּ�,
       (SELECT POSTAL_CODE FROM LOCATIONS L WHERE L.LOCATION_ID = D.LOCATION_ID) AS �����ȣ,
       NVL(A.�μ�����տ���,0) AS �μ�����տ���
FROM DEPARTMENTS D 
LEFT JOIN (SELECT AVG(SALARY) AS �μ�����տ���, DEPARTMENT_ID
      FROM EMPLOYEES
      GROUP BY DEPARTMENT_ID) A
ON D.DEPARTMENT_ID = A.DEPARTMENT_ID ;

-- JOIN�ι�
SELECT DD.*,
       STREET_ADDRESS �ּ�,
       POSTAL_CODE �����ȣ
FROM LOCATIONS L 
RIGHT JOIN (SELECT D.*,
                   NVL(A.�μ�����տ���,0) AS �μ�����տ���
            FROM DEPARTMENTS D 
            LEFT JOIN (SELECT AVG(SALARY) AS �μ�����տ���, DEPARTMENT_ID
                       FROM EMPLOYEES
                       GROUP BY DEPARTMENT_ID) A
ON D.DEPARTMENT_ID = A.DEPARTMENT_ID ) DD ON DD.LOCATION_ID = L.LOCATION_ID
ORDER BY DD.DEPARTMENT_ID;

--JOIN�ι� �ϴ°� ����.................
--��Ǯ��

SELECT D.*,
       L.STREET_ADDRESS,
       L.POSTAL_CODE,
       NVL (E.SALARY,0) AS SALARY
FROM DEPARTMENTS D
LEFT JOIN (SELECT DEPARTMENT_ID,
                  TRUNC(AVG(SALARY)) AS SALARY
           FROM EMPLOYEES
           GROUP BY DEPARTMENT_ID) E
ON D.DEPARTMENT_ID = E.DEPARTMENT_ID       
JOIN LOCATIONS L 
ON D.LOCATION_ID = L.LOCATION_ID;


--���� 16
--���� 15����� ���� DEPARTMENT_ID�������� �������� �����ؼ� ROWNUM�� �ٿ� 1-10������ ������ ����ϼ���

--�� Ǯ��
SELECT ZZ.*
FROM (SELECT ROWNUM RN , Z.*
      FROM( SELECT D.*,
                  (SELECT STREET_ADDRESS 
                   FROM LOCATIONS L 
                   WHERE L.LOCATION_ID = D.LOCATION_ID ) AS �ּ�,
                  (SELECT POSTAL_CODE 
                   FROM LOCATIONS L 
                   WHERE L.LOCATION_ID = D.LOCATION_ID) AS �����ȣ,
                   NVL(A.�μ�����տ���,0) AS �μ�����տ���
            FROM DEPARTMENTS D 
            LEFT JOIN (SELECT AVG(SALARY) AS �μ�����տ���, 
                              DEPARTMENT_ID
                       FROM EMPLOYEES
                       GROUP BY DEPARTMENT_ID) A
                       ON D.DEPARTMENT_ID = A.DEPARTMENT_ID 
                       ORDER BY D.DEPARTMENT_ID DESC) Z) ZZ
WHERE RN BETWEEN 1 AND 11;


--��Ǯ��
     
SELECT *
FROM (SELECT ROWNUM RN,
       X.*
      FROM (SELECT D.*,
                   L.STREET_ADDRESS,
                   L.POSTAL_CODE,
                   NVL (E.SALARY,0) AS SALARY
           FROM DEPARTMENTS D
           LEFT JOIN (SELECT DEPARTMENT_ID,
                             TRUNC(AVG(SALARY)) AS SALARY
                      FROM EMPLOYEES
                     GROUP BY DEPARTMENT_ID) E
           ON D.DEPARTMENT_ID = E.DEPARTMENT_ID       
           JOIN LOCATIONS L 
           ON D.LOCATION_ID = L.LOCATION_ID
           ORDER BY D.DEPARTMENT_ID DESC) X)
WHERE RN BETWEEN 10 AND 21;
