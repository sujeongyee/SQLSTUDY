-- ����ȯ �Լ�
-- �ڵ�����ȯ
SELECT * FROM EMPLOYEES WHERE DEPARTMENT_ID = 30;
SELECT * FROM EMPLOYEES WHERE DEPARTMENT_ID = '30'; --�ڵ�����ȯ
SELECT  SYSDATE -5, SYSDATE -'5' FROM EMPLOYEES; --�ڵ�����ȯ

-- ��������ȯ
-- TO_CHAR(��¥, ��¥����)
SELECT TO_CHAR(SYSDATE,'YYYY-MM-DD HH:MI:SS') FROM DUAL; --���� 
SELECT TO_CHAR(SYSDATE,'YY/MM/DD HH24/MI/SS') FROM DUAL; --����
SELECT TO_CHAR(SYSDATE, 'YYYY"��"MM"��"DD"��"') FROM DUAL; --���� ���ڰ� �ƴ� ���� ""�� �����ݴϴ�
SELECT TO_CHAR(HIRE_DATE,'YYYY-DD') FROM EMPLOYEES;


--TO_CHAR(����,��������)
SELECT TO_CHAR(200000,'$999,999,999') FROM DUAL;
SELECT TO_CHAR(200000.1234,'999999.999') FROM DUAL; -- �Ҽ����ڸ� ǥ��
SELECT FIRST_NAME,TO_CHAR(SALARY * 1300,'L999,999,999,999') AS �츮���� FROM EMPLOYEES;
SELECT FIRST_NAME, TO_CHAR(SALARY * 1300, 'L0999,999,999') FROM EMPLOYEES; --������ ���� �ڸ� ���� 0���� �߰�


--TO_NUMBER(����, ��������)
SELECT '3.14'+2000 FROM DUAL; --�ڵ�����ȯ
SELECT TO_NUMBER('3.14') + 2000 FROM DUAL; --�������ȯ
SELECT TO_NUMBER('$3,300','$999,999') + 2000 FROM DUAL;

--TO_DATE(����, ��¥����)
SELECT SYSDATE - '2023-05-16' FROM DUAL; -- ERROR
SELECT SYSDATE - TO_DATE('2023-05-16','YYYY-MM-DD') FROM DUAL;
SELECT SYSDATE - TO_DATE('2023/05/16 11:31:23','YYYY/MM/DD HH:MI:SS') FROM DUAL;

-- �Ʒ� ���� YYYY�� MM�� DD�� ���·� ���
SELECT '20050105' FROM DUAL;
SELECT TO_CHAR(TO_DATE('20050105','YYYYMMDD'),'YYYY"��"MM"��"DD"��"') FROM DUAL;

--�Ʒ� ���� ���� ��¥�� ���̸� ���ϼ��� 
SELECT SYSDATE - TO_DATE('2005��01��05��','YYYY"��"MM"��"DD"��"') FROM DUAL;

------------------------------------------------------------------------------
--NULL���� ���� ��ȯ NVL(�÷�,NULL�� ��� ó���� ��)
SELECT NVL(NULL,0) FROM DUAL;
SELECT FIRST_NAME, COMMISSION_PCT*100 FROM EMPLOYEES; -- NULL�� ������ ���ָ� NULL�� ����
SELECT FIRST_NAME, NVL(COMMISSION_PCT,0)*100 FROM EMPLOYEES; --NULL ���� 0�� �����ؼ� ������
SELECT FIRST_NAME, SALARY+(SALARY*NVL(COMMISSION_PCT,0)) FROM EMPLOYEES;

--NVL2(�÷�, NULL�� �ƴ� ��� ó����, NULL�� ����� ó����)

SELECT NVL2(NULL,'���̾ƴմϴ�','���Դϴ�') FROM DUAL; -- NULL�� ��� �ڿ��� ����, NULL�� �ƴҰ�� �տ��� ����
SELECT SALARY,
       NVL2(COMMISSION_PCT,SALARY+(SALARY*COMMISSION_PCT),SALARY) AS �޿� FROM EMPLOYEES;

--DECODE() - ELSE IF ���� ��ü�ϴ� �Լ�
SELECT DECODE('D','A','A�Դϴ�',
                  'B','B�Դϴ�',
                  'C','C�Դϴ�',
                  'ABC�� �ƴմϴ�') FROM DUAL;

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

--2ND (��Һ� OR �ٸ� Į���� �񱳰� ����)
SELECT JOB_ID,
       CASE WHEN JOB_ID = 'IT_PROG' THEN SALARY * 0.3
            WHEN JOB_ID = 'FI_MGR' THEN SALARY * 0.2
            ELSE SALARY
       END
FROM EMPLOYEES;

--COALESCE (A,B) - NVL�̶� ���� (NULL�� ��쿡�� ġȯ)
SELECT COALESCE(NULL,1,2) FROM DUAL; --NULL�̶�� 1, �ƴϸ� 2
SELECT COALESCE(COMMISSION_PCT, 1) FROM EMPLOYEES;


--------------------------------------------------
SELECT * FROM EMPLOYEES;
SELECT EMPLOYEE_ID �����ȣ,FIRST_NAME||' '||LAST_NAME �����,HIRE_DATE �Ի�����, 
       TRUNC((SYSDATE-HIRE_DATE)/365) �ټӳ�� FROM EMPLOYEES WHERE ((SYSDATE-HIRE_DATE)/365)>=10 ORDER BY �ټӳ�� DESC ;


SELECT FIRST_NAME,MANAGER_ID,
       CASE MANAGER_ID WHEN 100 THEN '���'
                       WHEN 120 THEN '����'
                       WHEN 121 THEN '�븮'
                       WHEN 122 THEN '����'
                       ELSE '�ӿ�'
END AS ����  FROM EMPLOYEES WHERE DEPARTMENT_ID>=50;



