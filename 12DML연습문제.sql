SELECT * FROM DEPTS;
--���� 1.
--DEPTS���̺� ������ �߰��ϼ���
DESC DEPTS;
INSERT INTO DEPTS (DEPARTMENT_ID , DEPARTMENT_NAME,LOCATION_ID) VALUES (280,'����',1800);
INSERT INTO DEPTS (DEPARTMENT_ID , DEPARTMENT_NAME,LOCATION_ID) VALUES (290,'ȸ���',1800);
INSERT INTO DEPTS VALUES (300,'����',301,1800);
INSERT INTO DEPTS VALUES (310,'�λ�',302,1800);
INSERT INTO DEPTS VALUES (320,'����',303,1700);


SELECT * FROM DEPTS;

--���� 2.
--DEPTS���̺��� �����͸� �����մϴ�
--1. department_name �� IT Support �� �������� department_name�� IT bank�� ����

UPDATE DEPTS 
SET DEPARTMENT_NAME = 'IT bank' 
WHERE DEPARTMENT_NAME = 'IT Support';

--2. department_id�� 290�� �������� manager_id�� 301�� ����

UPDATE DEPTS
SET MANAGER_ID = 301
WHERE DEPARTMENT_ID = 290;

--3. department_name�� IT Helpdesk�� �������� �μ����� IT Help�� , �Ŵ������̵� 303����, �������̵�
--1800���� �����ϼ���
UPDATE DEPTS
SET MANAGER_ID = 303,
    DEPARTMENT_ID = 1800
WHERE DEPARTMENT_NAME = 'IT Helpdesk';
--4. ����, �λ�, ���� �� �Ŵ������̵� 301�� �ѹ��� �����ϼ���.

SELECT * FROM DEPTS;
UPDATE DEPTS
SET MANAGER_ID = 301
WHERE DEPARTMENT_NAME IN ('����','�λ�','����');

--���� 3.
--������ ������ �׻� primary key�� �մϴ�, ���⼭ primary key�� department_id��� �����մϴ�.
--1. �μ��� �����θ� ���� �ϼ���
DELETE FROM DEPTS WHERE DEPARTMENT_NAME = '����';

--2. �μ��� NOC�� �����ϼ���
DELETE FROM DEPTS WHERE DEPARTMENT_NAME = 'NOC';

--����4
--1. Depts �纻���̺��� department_id �� 200���� ū �����͸� �����ϼ���.
SELECT * FROM DEPTS;
DELETE FROM DEPTS WHERE DEPARTMENT_ID > 200;
--2. Depts �纻���̺��� manager_id�� null�� �ƴ� �������� manager_id�� ���� 100���� �����ϼ���.
UPDATE DEPTS
SET MANAGER_ID = 100
WHERE MANAGER_ID IS NOT NULL;

COMMIT;

--3. Depts ���̺��� Ÿ�� ���̺� �Դϴ�.
--4. Departments���̺��� �Ź� ������ �Ͼ�� ���̺��̶�� �����ϰ� Depts�� ���Ͽ�
--��ġ�ϴ� ��� Depts�� �μ���, �Ŵ���ID, ����ID�� ������Ʈ �ϰ�
--�������Ե� �����ʹ� �״�� �߰����ִ� merge���� �ۼ��ϼ���.

SELECT * FROM DEPARTMENTS;
MERGE INTO DEPTS D1
USING (SELECT * FROM DEPARTMENTS) D2
ON(D1.DEPARTMENT_ID = D2.DEPARTMENT_ID)
WHEN MATCHED THEN
     UPDATE SET D1.DEPARTMENT_NAME = D2.DEPARTMENT_NAME,
                D1.MANAGER_ID = D2.MANAGER_ID,
                D1.LOCATION_ID = D2.LOCATION_ID
WHEN NOT MATCHED THEN
     INSERT VALUES(D2.DEPARTMENT_ID,
                   D2.DEPARTMENT_NAME,
                   D2.MANAGER_ID,
                   D2.LOCATION_ID);
                   
SELECT * FROM DEPTS;                 
                 
--���� 5
SELECT * FROM JOBS;
SELECT * FROM JOBS_IT;
DESC JOBS_IT;
--1. jobs_it �纻 ���̺��� �����ϼ��� (������ min_salary�� 6000���� ū �����͸� �����մϴ�)
CREATE TABLE JOBS_IT AS (SELECT * FROM JOBS WHERE 1=2);
INSERT INTO JOBS_IT (SELECT * FROM JOBS WHERE MIN_SALARY > 6000);
--2. jobs_it ���̺� ���� �����͸� �߰��ϼ���
INSERT INTO JOBS_IT VALUES ('IT_DEV','����Ƽ������',6000,20000);
INSERT INTO JOBS_IT VALUES ('NET_DEV','��Ʈ��ũ������',5000,20000);
INSERT INTO JOBS_IT VALUES ('SEC_DEV','���Ȱ�����',6000,19000);
--3. jobs_it�� Ÿ�� ���̺� �Դϴ�

--4. jobs���̺��� �Ź� ������ �Ͼ�� ���̺��̶�� �����ϰ� jobs_it�� ���Ͽ�
--min_salary�÷��� 0���� ū ��� ������ �����ʹ� min_salary, max_salary�� ������Ʈ �ϰ� ���� ���Ե�
--�����ʹ� �״�� �߰����ִ� merge���� �ۼ��ϼ���                   
 
MERGE INTO JOBS_IT J1
USING (SELECT * FROM JOBS WHERE MIN_SALARY > 0) J2
ON(J1.JOB_ID = J2.JOB_ID)
WHEN MATCHED THEN
     UPDATE SET J1.MIN_SALARY = J2.MIN_SALARY,
                J1.MAX_SALARY = J2.MAX_SALARY
WHEN NOT MATCHED THEN     
     INSERT VALUES(J2.JOB_ID,
                   J2.JOB_TITLE,
                   J2.MIN_SALARY,
                   J2.MAX_SALARY);              
                   
SELECT * FROM JOBS_IT;   

COMMIT;