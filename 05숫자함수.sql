-- ���� �Լ�
--ROUND - �ݿø� (�Ű������� �ϳ���� �ݿø� ,
--�ΰ���� �ι�°�� �Ҽ��� �ڸ��� �ǹ�, ������� �Ҽ����� ���� �ڸ�����ŭ)
SELECT ROUND(45.523,2),ROUND(45.523),ROUND(145.523 , -2) FROM DUAL;
--TRUNC()- ����
SELECT TRUNC(45.523,2),TRUNC(45.523),TRUNC(45.523,-1) FROM DUAL;
--CEIL() �ø� , FLOOR() ����
SELECT CEIL(3.14), FLOOR(3.14) FROM DUAL;
--MOD() - ������
SELECT MOD(5,3) AS ������, TRUNC(5/3) AS �� FROM DUAL;
--------------------------------------------------

--��¥�Լ�
SELECT SYSDATE FROM DUAL; --��/��/��
SELECT SYSTIMESTAMP FROM DUAL; -- �ú��� �и������� ������ ���� �ð�Ÿ��

--��¥�ǿ��� = ������ �ϼ�
SELECT SYSDATE + 10 FROM DUAL; -- +10��
SELECT SYSDATE - 10 FROM DUAL; -- -10��
SELECT SYSDATE-HIRE_DATE FROM EMPLOYEES; --�ϼ�
SELECT (SYSDATE-HIRE_DATE)/7 AS WEEK FROM EMPLOYEES;
SELECT (SYSDATE-HIRE_DATE)/365 AS YEAR FROM EMPLOYEES;
SELECT TRUNC((SYSDATE-HIRE_DATE)/365) * 12 AS MONTH FROM EMPLOYEES;

--��¥�� �ݿø�, ����
SELECT ROUND(SYSDATE) FROM DUAL; -- ������ ��¥�� �ð��������� �ݿø�
SELECT ROUND(SYSDATE,'DAY') FROM DUAL; -- �ݿø��� ���� �Ͽ��Ϸ�
SELECT ROUND(SYSDATE,'MONTH') FROM DUAL; -- �� �������� �ݿø�
SELECT ROUND(SYSDATE,'YEAR') FROM DUAL; -- ���� �������� �ݿø�

SELECT TRUNC(SYSDATE) FROM DUAL; -- ������ ��ȯ
SELECT TRUNC(SYSDATE,'DAY') FROM DUAL; -- �ش����� �Ͽ��Ϸ�
SELECT TRUNC(SYSDATE,'MONTH') FROM DUAL; -- �ش� ���� 1�Ϸ�
SELECT TRUNC(SYSDATE,'YEAR') FROM DUAL; -- �ش� ���� 1��1�Ϸ�

