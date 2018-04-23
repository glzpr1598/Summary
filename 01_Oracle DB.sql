/*******************************************************
1. 유저
*******************************************************/

-- 유저 생성
CREATE USER 유저명
IDENTIFIED BY 비밀번호;

-- 유저 비밀번호 변경
ALTER USER 유저명 
IDENTIFIED BY 비밀번호;

-- 유저 조회
SELECT * 
FROM DBA_USERS;

-- 유저 삭제
DROP USER 유저명 
[CASCADE];

-- 권한 부여
GRANT 권한, 롤 ...
TO 유저;
-- 롤 : 권한을 패키징해놓은 것
-- CONNECT : 데이터베이스 접속, 객체 생성(세션, 테이블, 뷰)
-- RESOURCE : 사용자에게 자신의 테이블, 시퀀스, 프로시저, 트리거와 같은 객체를 생성할 수 있는 권한
-- DBA : 관리자 권한

-- 권한 회수
REVOKE 권한, 롤
FROM 유저명;


/*******************************************************
2. 테이블
*******************************************************/

-- 테이블 생성
CREATE TABLE 테이블명(
    컬럼명 데이터타입 ...
);

-- 테이블 삭제
DROP TABLE 테이블명;

-- 테이블의 데이터 삭제
TRUNCATE TABLE 테이블명;

-- 테이블명 수정
ALTER TABLE 기존_이름 
RENAME TO 변경할_이름;

-- 컬럼 추가
ALTER TABLE 테이블명 ADD(
    컬럼명 데이터타입 ...
);

-- 컬럼 삭제
ALTER TABLE 테이블명 
DROP COLUMN 컬럼명;

-- 컬럼의 데이터타입 수정
ALTER TABLE 테이블명 MODIFY(
    컬럼명 데이터타입 ...
);

-- 컬럼명 수정
ALTER TABLE 테이블명 
RENAME COLUMN 기존_이름 
TO 변경할_이름;

-- 테이블 구조 조회
DESC 테이블;

-- 테이블 리스트 조회
SELECT * 
FROM USER_TABLES;


/*******************************************************
3. 데이터
*******************************************************/

-- 데이터 삽입
INSERT INTO 테이블명[(컬럼명 ...)]
VALUES(값 ...);

-- 데이터 수정
UPDATE 테이블명
SET 컬럼명 = 값, ...
[WHERE 조건];

-- 데이터 삭제
DELETE FROM 테이블명
[WHERE 조건];

-- 데이터 조회
SELECT 컬럼명 ... 
FROM 테이블명


/*******************************************************
4. 데이터 조회
*******************************************************/

-- 조건(WHERE)
SELECT 컬럼명 ... 
FROM 테이블명
[WHERE 조건];

-- 별칭(AS)
SELECT 컬럼명 AS "별칭" 
FROM 테이블명;

-- AND
WHERE 조건 AND 조건

-- OR
WHERE 조건 OR 조건

-- A와 B 사이(BETWEEN)
WHERE BETWEEN A AND B

-- 중복 제거(DISTINCT)
SELECT [DISTINCT] 컬럼명 
FROM 테이블명;

-- 포함하는 값(IN)
WHERE 컬럼명 IN('값' ...)

-- 포함하는 값(LIKE)
WHERE 컬럼명 LIKE '%값%'

-- 정렬
ORDER BY 컬럼명 {ASC | DESC}

-- 그룹핑(GROUP BY, HAVING)
GROUP BY 컬럼명 
HAVING 조건


/*******************************************************
5. 제약조건
*******************************************************/

-- 제약조건 종류
PRIMARY KEY(컬럼명)
FOREIGN KEY(컬럼명) REFERENCES 테이블(참조컬럼)
UNIQUE(컬럼명)
CHECK(조건)
...

-- 제약조건 추가
ALTER TABLE 테이블명 
ADD [CONSTRAINT 제약조건명] 제약조건;

-- 제약조건 수정
ALTER TABLE 테이블명 
MODIFY 컬럼명 데이터타입 [CONSTRAINT 제약조건명] 제약조건;

-- 제약조건 삭제
ALTER TABLE 테이블명 
DROP CONSTRAINT 제약조건명;

-- 제약조건 조회
SELECT * FROM USER_CONSTRAINTS;

-- 연계 참조 무결성 제약조건
외래키 ON {DELETE | UPDATE} {NO ACTION | CASCADE | SET NULL | SET DEFAULT}
-- NO ACTION이 기본값


/*******************************************************
6. 조인
*******************************************************/

-- INNER JOIN : 테이블들의 연관된 컬럼의 값이 일치하는 행을 결과로 생성
SELECT 컬럼명
FROM 테이블1
[INNER] JOIN 테이블2
USING(컬럼); -- 두 테이블의 컬럼명이 같을 때
ON 컬럼1 = 컬럼2; -- 두 테이블의 컬럼명이 다를 때

-- OUTER JOIN : 컬럼의 값이 일치하지 않는 행도 생성
SELECT 컬럼명
FROM 테이블1
{RIGHT | LEFT | FULL} OUTER JOIN 테이블2
USING(컬럼명); -- 두 테이블의 컬럼명이 같을 때
ON 컬럼1 = 컬럼2; -- 두 테이블의 컬럼명이 다를 때

-- SELF-JOIN
SELECT 컬럼명
FROM 테이블 별칭1
JOIN 테이블 별칭2
ON 별칭1.컬럼 - 별칭2.컬럼2;

-- NATURAL JOIN : 동일한 컬럼을 조건없이 자동으로 조인
SELECT 컬럼명
FROM 테이블1
NATURAL JOIN 테이블2;

-- CROSS JOIN : 두 테이블의 카테시안 곱 수행
SELECT 컬럼명
FROM 테이블2
CROSS JOIN 테이블2;


/*******************************************************
7. 집합연산
*******************************************************/

-- 합집합
쿼리1 UNION 쿼리2; -- 중복 제거
쿼리1 UNION ALL 쿼리2; -- 중복 무시

-- 교집합
쿼리1 INTERSECT 쿼리2;

-- 차집합
쿼리1 구문1 MINUS 쿼리2;


/*******************************************************
8. 뷰
*******************************************************/

-- 뷰 생성
CREATE [OR REPLACE] VIEW 뷰이름
AS SELECT 구문
[WITH CHECK OPTION | WITH READ ONLY];
-- WITH CHECK OPTION : 뷰의 조건식을 만족하는 내에서 수정 가능, 기본값
-- WITH READ ONLY : 수정 불가능

-- 뷰 수정
UPDATE 뷰이름
SET 컬럼 = 값
[WHERE 조건];

-- 뷰 삭제
DROP VIEW 뷰이름;

-- 뷰 조회
SELECT * FROM USER_VIEWS;


/*******************************************************
9. 시퀀스
*******************************************************/

-- 시퀀스 생성
CREATE SEQUENCE 시퀀스명
[START WITH n] -- 시작값(기본값 = 1)
[INCREMENT BY n] -- 증가값(기본값 = 1)
[MAXVALUE n | NOMAXVALUE] : 최댓값(기본값 = 9999999999999999999999999999)
[MINVALUE n | NOMINVALUE] : 최솟값(기본값 = 1)
[CYCLE | NOCYCLE] : 최댓값에 도달시 다시 시작할 것인지(기본값 = NOCYCLE)
[CACHE [n] | NOCACHE] : 캐시에 저장을 할 것인지(기본값 = CACHE 20)

-- 시퀀스 넘기기
시퀀스명.NEXTVAL

-- 시퀀스 조회
시퀀스명.CURRVAL

-- 사용자의 시퀀스 조회
SELECT * FROM USER_SEQUENCES;

-- 시퀀스 수정
ALTER SEQUENCE 시퀀스명 수정할옵션;

-- 시퀀스 삭제
DROP SEQUENCE 시퀀스명;


/*******************************************************
10. 대표적인 함수
*******************************************************/

-- 집계 함수
COUNT(), SUM(), AVG(), MAX(), MIN()
 
-- 숫자 함수
ABS(num) : 절댓값
CEIL(num) : 소수점 올림
FLOOR(num) : 소수점 내림
ROUND(num, pos) : num을 소수 pos번째 자리까지 반올림
TRUNC(num, pos) : num을 소수 pos번째 자리까지 버림
MOD(num1, num2) : num1을 num2로 나눈 나머지

-- 날짜 함수
SYSDATE : 현재 시각(초까지)
SYSTIMESTAMP : 현재 시각(10억분의 1초까지)

