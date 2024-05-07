/* DDL(data definition language) */

/* create */
create table if not exists tb1(
	pk int primary key , -- 식별값(null이 허용되지 않음)
	fk int ,
	col1 varchar(225) , -- 문자열을 저장할 수 있는 수 (255개)
	check(col1 in('y','n')) -- 체크제약조건 데이터를 넣을 때 조건을 참조 col1에 y,n 아니면 에러남. 
) engine = innodb;

describe tb1; -- 테이블 구조확인

insert into tb1 values(2, 10, 'n');

select * from tb1;

-- Alter
-- 테이블에 추가/변경/수정/삭제하는 모든 것을 alter 명령어를 사용해 적용한다.
-- 종류가 너무 많고 복잡하기 때문에 대표적인 것만 사용해볼 것이다.

-- column을 추가하는 경우
alter table tb1
add col2 int not null;
-- not null 제약조건으로인해 null을 포함할 수 없다.
insert into tb1 values(2, 10, 'n', null);
describe tb1;

-- column을 삭제하는 경우
alter table tb1
drop column col2;
describe tb1;

-- 열 이름 및 데이터 형식 변경
alter table tb1
change column fk change_fk int not null;
describe tb1;

-- 테이블 생성
create table if not exists tb2(
	pk int primary key auto_increment,
	fk int ,
	col1 varchar(225) ,
	check(col1 in('y','n')) 
) engine = innodb;

-- auto_increment가 걸려있는 컬럼은 primary key 제거가 안되므로 auto_increment를 modify 명령어로 제거한다.
-- modify는 컬럼의 정의를 바꾸는 것이다.
alter table tb2
modify pk int;
describe tb2;

-- 테이블의 primary key는 하나만 가질 수 있어서 별도의 컬럼을 지정하지 않아도 primary 삭제가 가능하다.
alter table tb2
drop primary key;
describe tb2;

-- 테이블 삭제하기
create table if not exists tb5( -- 3,4,5 변경해서 테이블 만들기
	pk int primary key auto_increment,
	fk int ,
	col1 varchar(225) ,
	check(col1 in('y','n')) 
) engine = innodb;

drop table if exists tb3, tb4, tb5;

show tables;


-- truncate 확인을 위한 테이블 생성
create table if not exists tb3( -- 3,4,5 변경해서 테이블 만들기
	pk int primary key auto_increment,
	fk int ,
	col1 varchar(225) ,
	check(col1 in('y','n')) 
) engine = innodb;
-- 데이터 insert
insert into tb3 values(null, 10, 'n');
insert into tb3 values(null, 10, 'n');
insert into tb3 values(null, 10, 'n');
insert into tb3 values(null, 10, 'n');

select * from tb3;
delete from tb3;

-- truncate
truncate tb3;

-- delete의 차이

