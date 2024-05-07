/* CONSTRAINTS */
-- 수업 목표 : 제약 조건을 이해한다.

-- 제약조건
-- 테이블 작성 시 각 컬럼에 값 기록에 대한 제약조건을 설정할 수 있다.
-- 데이터 무결성 보장을 목적으로 함
-- 입력/수정하는 데이터에 문제가 없는지 자동으로 검사해 주게 하기 위한 목적
-- primary key, not null, unique, check , foreign key


/* not null */
DROP TABLE IF EXISTS user_notnull;
CREATE TABLE IF NOT EXISTS user_notnull(
	user_nol int NOT NULL,
	user_id varchar(255) NOT NULL,
	USER_pwd varchar(255) NOT NULL,
	user_name varchar(255) NOT NULL,
	gender varchar(3),
	phone varchar(255) NOT NULL,
	email varchar(255) 
)ENGINE=innodb;

SELECT * FROM user_notnull;

INSERT INTO user_notnull
(user_nol, user_id, user_pwd, user_name, gender, phone, email)
VALUES
(1, 'user01', 'pass01', '홍길동', '남', '010-1234-5678', 'hong123@gmail.com'),
(2, 'user02', 'pass02', '유관순', '여', '010-777-7777', 'yu77@gmail.com');

SELECT * FROM user_notnull;

-- not null 제약 조건에 의해 에러가 발생함
INSERT INTO user_notnull
(user_nol, user_id, user_pwd, user_name, gender, email)
VALUES
(3, 'user03', 'pass03', '홍길동', '남','hong123@gmail.com');



/* unique */
-- 중복값을 허용하지 않는다.
CREATE TABLE IF NOT EXISTS user_unique(
	user_no int NOT NULL UNIQUE,
	user_id varchar(255) NOT NULL,
	USER_pwd varchar(255) NOT NULL,
	user_name varchar(255) NOT NULL,
	gender varchar(3),
	phone varchar(255) NOT NULL,
	email varchar(255) 
)ENGINE=innodb;

INSERT INTO user_unique
(user_no, user_id, user_pwd, user_name, gender, phone, email)
VALUES
(1, 'user01', 'pass01', '홍길동', '남', '010-1234-5678', 'hong123@gmail.com'),
(2, 'user02', 'pass02', '유관순', '여', '010-777-7777', 'yu77@gmail.com');

INSERT INTO user_unique
(user_no, user_id, user_pwd, user_name, gender, phone, email)
VALUES
(1, 'user01', 'pass01', '홍길동', '남', '010-1234-5678', 'hong123@gmail.com');

SELECT * FROM user_unique;


-- primary key
/* 테이블에서 한 행의 정보를 찾기 위해서 사용 할 컬럼을 의미한다.
 * 테이블에 대한 식별자 역할을 한다(한 행씩 구분하는 역할을 한다.)
 * not null + unique 제약조건의 의미
 * 한 테이블 한 개만 설정할 수 있음
 * 컬럼 레벨, 테이블 레벨 둘 다 설정 가능함
 * 한 개 컬럼에 설정할 수도 있고, 여러 개의  컬럼을 묶어서 설정할 수도 있다(복합키)
 * */

DROP TABLE IF EXISTS user_primarykey;

CREATE TABLE IF NOT EXISTS user_primarykey(
	user_no int PRIMARY KEY,
	user_id varchar(255) NOT NULL,
	USER_pwd varchar(255) NOT NULL,
	user_name varchar(255) NOT NULL,
	gender varchar(3),
	phone varchar(255) NOT NULL,
	email varchar(255) 
)ENGINE=innodb;

INSERT INTO user_primarykey
(user_no, user_id, user_pwd, user_name, gender, phone, email)
VALUES
(1, 'user01', 'pass01', '홍길동', '남', '010-1234-5678', 'hong123@gmail.com'),
(2, 'user02', 'pass02', '유관순', '여', '010-777-7777', 'yu77@gmail.com');

-- primary key는 not null과 unique 제약조건을 갖는다.
INSERT INTO user_primarykey
(user_id, user_pwd, user_name, gender, phone, email)
VALUES
( 'user01', 'pass01', '홍길동', '남', '010-1234-5678', 'hong123@gmail.com');

SELECT * FROM user_primarykey;


/* foreign key */
-- 참조(references)된 다른 테이블에서 제공하는 값만 사용할 수 있음
-- 참조 무결성을 위배하지 않기 위해 사용
-- Foreign key 제약조건에 의해서
-- 테이블 간의 관계(relationShip)이 형성됨
-- 제공되는 값 외에는 null을 사용할 수 있음
DROP TABLE IF EXISTS user_grade;

CREATE TABLE IF NOT EXISTS user_grade(
	grade_code int PRIMARY KEY,
	grade_name varchar(255) NOT null
) ENGINE=innodb;

INSERT INTO user_grade
VALUES
(10, '보통강사'),
(20, '만족강사'),
(30,'매우만족강사');

SELECT * FROM user_grade;


DROP TABLE IF NOT EXISTS instructor_foreingkey;

CREATE TABLE IF NOT EXISTS instructor_foreingkey(
	user_no int PRIMARY KEY,
	user_name varchar(255) NOT NULL,
	gender varchar(3),
	phone varchar(255),
	grade_code int,
	FOREIGN key(grade_code) REFERENCES user_grade(grade_code)
)ENGINE=innodb;

SELECT 
   i.user_name,
   u.grade_name
  FROM instructor_foreingkey i
  JOIN user_grade u ON i.grade_code = u.grade_code;

INSERT INTO instructor_foreingkey
VALUES (1, '왕강사', '남','010-2322-2323', 10);


-- on update set null, on delete set null
CREATE TABLE IF NOT EXISTS instructor_foreingkey2(
	user_no int PRIMARY KEY,
	user_name varchar(255) NOT NULL,
	gender varchar(3),
	phone varchar(255),
	grade_code int,
	FOREIGN key(grade_code) REFERENCES user_grade(grade_code)
	ON UPDATE SET NULL 
	ON DELETE SET NULL
)ENGINE=innodb;

INSERT INTO instructor_foreingkey2
VALUES (1, '왕강사', '남','010-2322-2323', 10),
(2,'이상우', '남','010-2323-2222', 30);

SELECT * FROM instructor_foreingkey2;

-- instructor_foreingkey 테이블에서 참조의 대한 옵션을 설정하지 않았다.
-- 이로인해 아래의 update에서 user_grade를 변경한다면 instructor_foreingkey 테이블이 참조하고 있어 
-- 변경할 수 없는 오류가 발생하게 된다. 그래서 삭제
DROP TABLE IF EXISTS instructor_foreingkey;

-- grade_code = null
-- grade_code는 제약조건으로 primary key 조건이 부여되었다.
-- 이로인해 grade_code를 삭제하는 것은 primary key 제약조건에 위배하여 불가능하다.
UPDATE user_grade 
 SET grade_code = 40
WHERE grade_code = 10;

SELECT * FROM user_grade;
-- 아래의 테이블을 조회하면 grade_code가 변경됨에 따라 grade_code가 null로 변경된다.
-- 이는 ON UPDATE SET NULL 옵션에 의해 참조하는 테이블이 변경되면 자신의 참조값을 null로 처리하는 것이다.
SELECT
	* 
  FROM instructor_foreingkey2;


DELETE FROM user_grade 
WHERE grade_code = 30;

-- 아래의 테이블을 조회하면 grade_code가 변경됨에 따라 grade_code가 null로 변경된다.
-- 이는 ON DELETE SET NULL 옵션에 의해 참조하는 테이블이 변경되면 자신의 참조값을 null로 처리하는 것이다.
SELECT
	* 
  FROM instructor_foreingkey2;
 
 
/* CHECK */
DROP TABLE IF EXISTS USER_CHECK;
CREATE TABLE IF NOT EXISTS user_check(
	user_no int AUTO_INCREMENT PRIMARY KEY,
	user_name varchar(255) NOT NULL,
	gender char(3) CHECK (gender IN ('남', '여')),
	age int CHECK (age >= 15)
)ENGINE= innodb;

INSERT INTO user_check 
VALUES
(NULL, '홍길동', '남', 15);
-- 아래의 값은 gender에 '남' 또는 '여'만 입력할 수 있도록 설정하였으나 '짭'이라는 값을 입력하여 오류가 발생함
-- (NULL, '김길동', '짭',20);
-- 아래의 값은 age에 15이상 값만 입력할 수 있도록 설정하였으나 5가 입력되어 제약조건을 위배함
-- (NULL, '신짱구', '남', 5);


-- defalut 
-- 컬럼에 null대신 기본 값 적용
-- 컬럼 타입이 date일 시 current_date만 가능하다.
-- 컬럼 타입이 datetime일 시 current_time과 current_timestamp, now() 모두 사용 가능 
DROP TABLE IF EXISTS tbl_country;
CREATE TABLE IF NOT EXISTS tbl_country(
	country_code int AUTO_INCREMENT PRIMARY KEY,
	country_name varchar(255) DEFAULT '한국',
	poplation varchar(255) DEFAULT '0명',
	add_day date DEFAULT (current_date),
	add_time datetime DEFAULT (current_time)
)ENGINE=innodb;

SELECT * FROM tbl_country;

INSERT INTO tbl_country 
VALUES (NULL, DEFAULT, DEFAULT, DEFAULT, DEFAULT);

INSERT INTO tbl_country 
	(country_code)
VALUES (NULL);

SELECT * FROM tbl_country;






