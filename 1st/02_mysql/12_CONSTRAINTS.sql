/* CONSTRAINTS */
-- 제약조건을 이해한다.

-- 제약조건
-- 테이블 작성 시 각 컬럼에 값 기록에 대한 제욕조건을 설정할 수 있다.
-- 데이터 무결성 보장을 목적으로 함
-- 입력/수정하는 데이터에 문제가 없는지 자동으로 검사해 주게 하기 위한 목적
-- primary key, not null, unique, check, foreign key

/* not null */
drop table if exists user_notnull;
create table if not exists user_notnull(
	user_nol int not null,
	user_id varchar(255) not null,
	user_pwd varchar(255) not null,
	user_name varchar(255) not null,
	gender varchar(3),
	phone varchar(255) not null,
	email varchar(255)
) engine = innodb;

insert into user_notnull(
	user_nol, user_id, user_pwd, user_name, gender, phone, email
)values
(1, 'user', 'pass', '홍길동','남','010-1234-1234','hong123@gamil.com'),
(2, 'user01', 'pass', '유관순','여','010-1234-1234','you123@gamil.com');

select * from user_notnull;

-- not null 제약 조건에 의해 에러가 발생함.
insert into user_notnull(
	user_nol, user_id, user_pwd, user_name, gender, email
)values
(3, 'user03', 'pass03', '홍길동','남', 'hong123@gamil.com');

/* unique */
-- 중복값을 허용하지 않는다.
create table if not exists user_unique(
	user_no int not null unique,
	user_id varchar(255) not null,
	user_pwd varchar(255) not null,
	user_name varchar(255) not null,
	gender varchar(3),
	phone varchar(255) not null,
	email varchar(255)
) engine = innodb;

insert into user_unique(
	user_no, user_id, user_pwd, user_name, gender, phone, email
)values
(1, 'user', 'pass', '홍길동','남','010-1234-1234','hong123@gamil.com');

select * from user_unique;

-- primary key
/* 테이블에서 한 행의 정보를 찾기 위해서 사용할 컬럼을 의미한다. 
 * 테이블에 대한 식별자 역할을 한다.(한 행씩 구분하는 역할을 한다.)
 * not null + unique 제약조건의 의미
 * 한 테이블 한 개만 설정할 수 있음
 * 컬럼 레벨, 테이블 레벨 둘 다 설정 가능함
 * 한 개 컬럼에 설정할 수도 있고, 여러개의 컬럼을 묶어서 설정할수 도 있다.(복합키)
 * */

drop table if exists user_primarykey;

create table if not exists user_primarykey(
	user_no int primary key,
	user_id varchar(255) not null,
	user_pwd varchar(255) not null,
	user_name varchar(255) not null,
	gender varchar(3),
	phone varchar(255) not null,
	email varchar(255)
) engine = innodb;

insert into user_primarykey(
	user_no, user_id, user_pwd, user_name, gender, phone, email
)values
(1, 'user', 'pass', '홍길동','남','010-1234-1234','hong123@gamil.com'),
(2, 'user01', 'pass', '유관순','여','010-1234-1234','you123@gamil.com');

-- primary key는 not null과 unique 제약조건을 갖는다.
insert into user_primarykey(
	user_id, user_pwd, user_name, gender, phone, email
)values
('user', 'pass', '홍길동','남','010-1234-1234','hong123@gamil.com');

select * from user_primarykey;

/* foreign key */
-- 참조(references)된 다른 테이블에서 제공하는 값만 사용할 수 있음
-- 참조 무결성을 위배하지 않기 위해 사용
-- foreign key 제약조건에 의해서
-- 테이블 간의 관계(relatiomShip)이 형성됨
-- 제공되는 값 외에는 null을 사용할 수 있음

drop table if exists user_grade;

create table if not exists user_grade(
	grade_code int primary key,
	grade_name varchar(255) not null
)engine = innodb;

insert into user_grade 
values
(10, '보통강사'),
(20, '만족강사'),
(30, '매우만족강사');

select * from user_grade;

drop table if exists instructor_foreingkey;

create table if not exists instructor_foreingkey(
	user_no int primary key ,
	user_name varchar(255) not null ,
	gender varchar(3) ,
	phone varchar(255) ,
	grade_code int ,
	foreign key(grade_code)
	references user_grade(grade_code)
)engine=innodb;

select * from instructor_foreingkey;

insert into instructor_foreingkey
values (1, '왕강사', '남', '010-1234-1234', 10);

select
	a.user_name ,
	b.grade_name
  from instructor_foreingkey a
 join user_grade b on a.grade_code = b.grade_code;

-- on update set null, on delete set null
create table if not exists instructor_foreignkey2(
	user_no int primary key ,
	user_name varchar(255) not null ,
	gender varchar(3) ,
	phone varchar(255) ,
	grade_code int ,
	foreign key(grade_code)
	references user_grade(grade_code)
	on update set null
	on delete set null
)engine=innodb;

insert into instructor_foreignkey2
values (1, '왕강사', '남', '010-1234-1234', 10),
(2, '이상우', '남', '010-1234-1234', 30);

select * from instructor_foreignkey2;

-- instructor_foreignkey 테이블에서 참조에 대한 옵션을 설정하지 않았다.
-- 이로인해 아래의 update에서 user_grade를 변경한다면 instructor_foreignkey 테이블이 참조하고 있어
-- 변경할 수 없는 오류가 발생하게 된다. 그래서 삭제
drop table if exists instructor_foreignkey;

-- grade_code = null
-- grade_code 는 제약조건으로 primary key 조건이 부여되었다.
-- 이로인해 grade_code를 삭제하는 것은 primary key제약조건에 위배하여 불가능하다.
update user_grade
set grade_code = 40
where grade_code = 10;

select * from user_grade;

-- 아래의 테이블을 조회하면 grade_code가 변경됨에 따라 grade_code가 null로 변경된다.
-- 이는 on delete set null 옵션에 의해 참조하는 테이블이 변경되면 자신의 참조값을 null로 처리하는 것이다.
select
	*
  from instructor_foreignkey2;

 
 /* CHECK */
 drop table if exists user_check;

create table if not exists user_check(
	user_no int auto_increment primary key,
	user_name varchar(255) not null,
	gender char(3) check (gender in ('남','여')),
	age int check (age >= 15)
)engine = innodb;
 
 insert into user_check
 values (null, '홍길동', '남',15);
--  (null, '김길동', '짭', 20); 남, 여 외 불가능
--  (null, '신짱구', '남', 5); 15세 이상만
 
 
-- default
-- 컬럼에 null 대신 기본 값 적용
-- 컬럼 타입이 date일 시 current_date만 가능하다.
-- 컬럼 타입이 datetime일 시 current_time과 current_timestamp, now() 모두 사용 가능
drop table if exists tb1_country;

create table if not exists tb1_country(
	country_code int auto_increment primary key,
	country_name varchar(255) default '한국',
	population varchar(255) default '0명',
	add_day date default (current_date),
	add_time datetime default (current_time)
)engine = innodb;

select * from tb1_country;

insert into tb1_country
values(null, default, default, default, default);

insert into tb1_country
	(country_code)
values (null);

select * from tb1_country;











 

