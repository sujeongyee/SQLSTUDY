--��������
--SELECT���� SELECT�������� ���� ���� : ��Į�� ��������
--SELECT���� FROM�������� ���� ���� : �ζ��κ�
--SELECT���� WHERE�������� ���� : ��������
--���������� �ݵ�� ()�ȿ� �����ϴ�


--������ �������� - ���ϵǴ� ���� 1���� ��������
SELECT * 
FROM EMPLOYEES WHERE
SALARY > (SELECT SALARY FROM EMPLOYEES WHERE FIRST_NAME = 'NANCY');
SELECT SALARY FROM EMPLOYEES WHERE FIRST_NAME = 'NANCY';

--EMPLOYEE_ID�� 103���� ����� ������ ����
SELECT JOB_ID FROM EMPLOYEES WHERE EMPLOYEE_ID = 103;

SELECT *
FROM EMPLOYEES
WHERE JOB_ID = (SELECT JOB_ID FROM EMPLOYEES WHERE EMPLOYEE_ID = 103);

--��������, ������ �̾�� �մϴ�. �÷����� 1������ �մϴ�.
--ERR
SELECT *
FROM EMPLOYEES
WHERE JOB_ID = (SELECT job_id FROM EMPLOYEES WHERE EMPLOYEE_ID = 103 or EMPLOYEE_ID = 104);

--------------------------------------------------------------------------------

--������ �������� - ���� ��������� IN,ANY,ALL�� ���մϴ�
SELECT SALARY
FROM EMPLOYEES
WHERE FIRST_NAME = 'David';

-- IN ������ ���� ã�� IN (4800,6800,9500)
-- DAVID �̸��� ���� ����� ���� �޿��� ���� ����� ã������
SELECT *
FROM EMPLOYEES
WHERE SALARY IN (SELECT SALARY FROM EMPLOYEES WHERE FIRST_NAME = 'David');

--ANY �ּҰ� ���� ŭ , �ִ밪 ���� ����
SELECT * 
FROM EMPLOYEES
WHERE SALARY < ANY (SELECT SALARY FROM EMPLOYEES WHERE FIRST_NAME ='David');

--ALL �ִ밪 ���� ŭ, �ּҰ� ���� ����
SELECT *
FROM EMPLOYEES
WHERE SALARY < ALL (SELECT SALARY FROM EMPLOYEES WHERE FIRST_NAME = 'David');

-- ������  IT_PROG�� ����麸�� �� ū �޿��� �޴� �����

SELECT SALARY FROM EMPLOYEES WHERE JOB_ID = 'IT_PROG';

SELECT *
FROM EMPLOYEES
WHERE SALARY > ANY (SELECT SALARY FROM EMPLOYEES WHERE JOB_ID = 'IT_PROG');


-------------------------------------------------------------------------
SELECT * FROM EMPLOYEES;
--��Į�� ��������
--JOIN�ÿ� Ư�����̺��� 1�÷��� ������ �� �� �����մϴ�
SELECT FIRST_NAME,
       EMAIL,
       (SELECT DEPARTMENT_NAME FROM DEPARTMENTS D WHERE D.DEPARTMENT_ID = E.DEPARTMENT_ID)
FROM EMPLOYEES E
ORDER BY FIRST_NAME;
--���� ���� ���
SELECT FIRST_NAME,
       EMAIL,
       DEPARTMENT_NAME
FROM EMPLOYEES E
LEFT JOIN DEPARTMENTS D ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
ORDER BY FIRST_NAME;

-- �� �μ��� �Ŵ��� �̸��� ����ϰ� �ʹ�?
SELECT * FROM DEPARTMENTS;
--JOIN
SELECT D.*,
       E.FIRST_NAME
FROM DEPARTMENTS D LEFT JOIN EMPLOYEES E ON D.MANAGER_ID = E.EMPLOYEE_ID;
--��Į��
SELECT D.*,
       (SELECT FIRST_NAME FROM EMPLOYEES E WHERE E.EMPLOYEE_ID = D.MANAGER_ID) AS �Ŵ����̸�
FROM DEPARTMENTS D;
--��Į�������� ������ ��� ����
SELECT * FROM JOBS;
SELECT * FROM DEPARTMENTS;
SELECT * FROM EMPLOYEES;

SELECT E.FIRST_NAME,
       E.JOB_ID,
       (SELECT JOB_TITLE FROM JOBS J WHERE J.JOB_ID = E.JOB_ID) AS JOB_TITLE,
       (SELECT DEPARTMENT_NAME FROM DEPARTMENTS D WHERE D.DEPARTMENT_ID = E.DEPARTMENT_ID) AS DEPARTMENT_NAME
FROM EMPLOYEES E;

--�� �μ��� ������� ���............ + �μ�����
SELECT * FROM DEPARTMENTS;

--����
SELECT DEPARTMENT_ID,
       COUNT(*),
       (SELECT D.* FROM DEPARTMENTS D WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID) AS �μ�����
FROM EMPLOYEES E GROUP BY DEPARTMENT_ID;

--�� Ǯ��
SELECT D.*,
       NVL((SELECT COUNT(*) FROM EMPLOYEES E WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID GROUP BY DEPARTMENT_ID),0) AS �����     
FROM DEPARTMENTS D;

---------------------------------------------------------------------------------
--�ζ��� ��
--��¥ ���̺� ����

SELECT *
FROM (SELECT *
      FROM * (SELECT * FROM EMPLOYEES)
      );

-- ROWNUM�� ��ȸ�� �����̱� ������, ORDER�� ���� ���Ǹ� ROWNUM�� ���̴� ����
SELECT ROWNUM,
       FIRST_NAME,
       SALARY
FROM ((SELECT *
FROM EMPLOYEES
ORDER BY SALARY DESC));

--����
SELECT ROWNUM,
       A.*
FROM(SELECT FIRST_NAME,
            SALARY
     FROM EMPLOYEES
     ORDER BY SALARY
     ) A ;

-- ROWNUM�� ������ 1��°���� ��ȸ�� �����ϱ� ����
SELECT ROWNUM,
       FIRST_NAME,
       SALARY
FROM ((SELECT *
       FROM EMPLOYEES
       ORDER BY SALARY DESC))
WHERE ROWNUM BETWEEN 1 AND 20;

--2��° �ζ��κ信�� ROWNUM�� RN���� �÷�ȭ
SELECT *
FROM(SELECT ROWNUM RN,
            FIRST_NAME,
            SALARY
     FROM (SELECT *
           FROM EMPLOYEES
           ORDER BY SALARY DESC)
    )
WHERE RN >= 11 AND RN <= 20;

--�ζ��� ���� ����
SELECT TO_CHAR(REGDATE,'YY-MM-DD') AS REGDATE,
       NAME
FROM (SELECT 'ȫ�浿' AS NAME ,SYSDATE AS REGDATE FROM DUAL
      UNION ALL
      SELECT '�̼���',SYSDATE AS REGDATE FROM DUAL);

--�ζ��� ���� ����
--�μ��� ����� 

SELECT D.*,
       E.TOTAL
FROM DEPARTMENTS D 
LEFT JOIN (SELECT DEPARTMENT_ID, COUNT(*) AS TOTAL
           FROM EMPLOYEES 
           GROUP BY DEPARTMENT_ID) E
ON D.DEPARTMENT_ID = E.DEPARTMENT_ID;

-- ����
-- ������ (��Һ�) VS ���� �������� (IN, ANY ,ALL)
-- ��Į������ - LEFT JOIN�� ���� ����, �ѹ��� 1���� �÷��� ������ ��
-- �ζ��κ� - FROM�� ���� ��¥ ���̺�

----------------------------------------------------------------------

--���� 1.
---EMPLOYEES ���̺��� ��� ������� ��ձ޿����� ���� ������� �����͸� ��� �ϼ��� ( AVG(�÷�) ���)

SELECT *
FROM EMPLOYEES
WHERE SALARY > (SELECT AVG(SALARY) FROM EMPLOYEES)
ORDER BY SALARY;

---EMPLOYEES ���̺��� ��� ������� ��ձ޿����� ���� ������� ���� ����ϼ���

SELECT COUNT(*) AS �����
FROM (SELECT SALARY FROM EMPLOYEES WHERE SALARY > (SELECT AVG(SALARY) FROM EMPLOYEES) GROUP BY SALARY);

---EMPLOYEES ���̺��� job_id�� IT_PFOG�� ������� ��ձ޿����� ���� ������� �����͸� ����ϼ���

SELECT *
       FROM EMPLOYEES
       WHERE SALARY > (SELECT AVG(SALARY)
                       FROM EMPLOYEES 
                       WHERE JOB_ID = 'IT_PROG');

--���� 2.
---DEPARTMENTS���̺��� manager_id�� 100�� ����� department_id�� EMPLOYEES���̺��� department_id�� ��ġ�ϴ� ��� ����� ������ �˻��ϼ���

SELECT *
FROM EMPLOYEES
WHERE DEPARTMENT_ID = (SELECT DEPARTMENT_ID
                       FROM DEPARTMENTS
                       WHERE MANAGER_ID = 100);



--���� 3.
---EMPLOYEES���̺��� ��Pat���� manager_id���� ���� manager_id�� ���� ��� ����� �����͸� ����ϼ���

SELECT *
FROM EMPLOYEES
WHERE MANAGER_ID > (SELECT MANAGER_ID 
                    FROM EMPLOYEES 
                    WHERE FIRST_NAME = 'Pat');


SELECT * FROM EMPLOYEES;

---EMPLOYEES���̺��� ��James��(2��)���� manager_id�� ���� ��� ����� �����͸� ����ϼ���.

SELECT *
FROM EMPLOYEES
WHERE MANAGER_ID IN (SELECT MANAGER_ID
                     FROM EMPLOYEES
                     WHERE FIRST_NAME = 'James');

--���� 4.
---EMPLOYEES���̺� ���� first_name�������� �������� �����ϰ�, 41~50��° �������� �� ��ȣ, �̸��� ����ϼ���



SELECT *
FROM (SELECT ROWNUM RN,
       FIRST_NAME
       FROM (SELECT FIRST_NAME
             FROM EMPLOYEES E
             ORDER BY FIRST_NAME DESC))
WHERE RN >=40 AND RN <= 50;



--���� 5.
---EMPLOYEES���̺��� hire_date�������� �������� �����ϰ�, 31~40��° �������� �� ��ȣ, ���id, �̸�, ��ȣ, 
--�Ի����� ����ϼ���

SELECT *
FROM(SELECT ROWNUM RN ,E.*
     FROM (SELECT EMPLOYEE_ID, FIRST_NAME , PHONE_NUMBER,HIRE_DATE
           FROM EMPLOYEES
           ORDER BY HIRE_DATE)E)
WHERE RN>=31 AND RN<=40;


--���� 6.
--employees���̺� departments���̺��� left �����ϼ���
--����) �������̵�, �̸�(��, �̸�), �μ����̵�, �μ��� �� ����մϴ�.
--����) �������̵� ���� �������� ����


SELECT E.EMPLOYEE_ID , 
       CONCAT(FIRST_NAME,LAST_NAME), 
       D.DEPARTMENT_ID,
       D.DEPARTMENT_NAME
FROM EMPLOYEES E 
LEFT JOIN DEPARTMENTS D ON E.MANAGER_ID = D.MANAGER_ID
ORDER BY EMPLOYEE_ID;

SELECT * FROM EMPLOYEES;
SELECT * FROM DEPARTMENTS;

--���� 7.
--���� 6�� ����� (��Į�� ����)�� �����ϰ� ��ȸ�ϼ���

SELECT E.EMPLOYEE_ID, 
      (SELECT D.DEPARTMENT_ID FROM DEPARTMENTS D WHERE D.DEPARTMENT_ID = E.DEPARTMENT_ID) AS DEPARTMENT_ID,
      (SELECT D.DEPARTMENT_NAME FROM DEPARTMENTS D WHERE D.DEPARTMENT_ID = E.DEPARTMENT_ID) AS DEPARTMENT_NAME
FROM EMPLOYEES E
ORDER BY EMPLOYEE_ID;



--���� 8.
--departments���̺� locations���̺��� left �����ϼ���
--����) �μ����̵�, �μ��̸�, �Ŵ������̵�, �����̼Ǿ��̵�, ��Ʈ��_��巹��, ����Ʈ �ڵ�, ��Ƽ �� ����մϴ�
--����) �μ����̵� ���� �������� ����
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

--���� 9.
--���� 8�� ����� (��Į�� ����)�� �����ϰ� ��ȸ�ϼ���

SELECT D.DEPARTMENT_ID,
       D.DEPARTMENT_NAME,
       D.LOCATION_ID, 
       (SELECT STREET_ADDRESS FROM LOCATIONS L WHERE D.LOCATION_ID = L.LOCATION_ID ) AS STREET_ADDRESS,
       (SELECT POSTAL_CODE FROM LOCATIONS L WHERE D.LOCATION_ID = L.LOCATION_ID) AS POSTAL_CODE 
FROM DEPARTMENTS D
ORDER BY DEPARTMENT_ID;


--���� 10.
--locations���̺� countries ���̺��� left �����ϼ���
--����) �����̼Ǿ��̵�, �ּ�, ��Ƽ, country_id, country_name �� ����մϴ�
--����) country_name���� �������� ����

SELECT L.LOCATION_ID, 
       L.STREET_ADDRESS, 
       L.CITY, 
       L.COUNTRY_ID,
       C.COUNTRY_NAME
FROM LOCATIONS L 
LEFT JOIN COUNTRIES C ON L.COUNTRY_ID = C.COUNTRY_ID
ORDER BY C.COUNTRY_NAME;

--���� 11.
--���� 10�� ����� (��Į�� ����)�� �����ϰ� ��ȸ�ϼ���

SELECT * FROM COUNTRIES ;
SELECT * FROM LOCATIONS;

SELECT L.LOCATION_ID, 
       L.STREET_ADDRESS, 
       L.CITY, 
       L.COUNTRY_ID,
       (SELECT COUNTRY_NAME FROM COUNTRIES C WHERE C.COUNTRY_ID = L.COUNTRY_ID )AS COUNTRY_NAME
FROM LOCATIONS L
ORDER BY COUNTRY_NAME;

--���� 12. 
--employees���̺�, departments���̺��� left���� hire_date�� �������� �������� 1-10��° �����͸� ����մϴ�
--����) rownum�� �����Ͽ� ��ȣ, �������̵�, �̸�, ��ȭ��ȣ, �Ի���, �μ����̵�, �μ��̸� �� ����մϴ�.
--����) hire_date�� �������� �������� ���� �Ǿ�� �մϴ�. rownum�� Ʋ������ �ȵ˴ϴ�

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


--���� 13. 
--EMPLOYEES �� DEPARTMENTS ���̺��� JOB_ID�� SA_MAN ����� ������ LAST_NAME, JOB_ID, 
--DEPARTMENT_ID,DEPARTMENT_NAME�� ����ϼ���

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


SELECT DEPARTMENT_ID,
       DEPARTMENT_NAME,
       MANAGER_ID
       (SELECT )
FROM DEPARTMENTS D;

SELECT COUNT(*)
FROM DEPARTMENTS 

SELECT * FROM EMPLOYEES;
SELECT * FROM DEPARTMENTS;




--���� 15
--�μ��� ���� ���� ���ο�, �ּ�, �����ȣ, �μ��� ��� ������ ���ؼ� ����ϼ���
--�μ��� ����� ������ 0���� ����ϼ���



--���� 16
--���� 15����� ���� DEPARTMENT_ID�������� �������� �����ؼ� ROWNUM�� �ٿ� 1-10������ ������
--����ϼ���
