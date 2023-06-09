--트랜잭션 (논리적 작업단위)

SHOW AUTOCOMMIT;

--오토커밋 온
SET AUTOCOMMIT ON;

--오토커밋 오프
SET AUTOCOMMIT  OFF;


DELETE FROM DEPTS WHERE DEPARTMENT_ID = 10;
SAVEPOINT DELETE10; --세이브포인트기록

DELETE FROM DEPTS WHERE DEPARTMENT_ID = 20;
SAVEPOINT DELETE20; --기록

ROLLBACK TO DELETE10; -- 10번 세이브포인트로 롤백

ROLLBACK; --마지막 커밋 시점
SELECT * FROM DEPTS;

--------------------------------------------
INSERT INTO DEPTS VALUES(300,'DEMO',NULL,1800);

SELECT * FROM DEPTS;
COMMIT; -- 트랜잭션 반영

