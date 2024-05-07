/* VIEW */
-- 가상의 테이블을 형성하는 view를 이해한다.
-- select 쿼리문을 저장한 객체로 가상테이블이라고 불린다.
-- 실질적인 데이터를 물리적으로 저장하고 있지 않음
-- 테이블을 사용하는 것과 동일하게 사용할 수 있다.

SELECT * FROM tbl_menu;

-- view 생성
CREATE VIEW hansik AS 
SELECT 
	menu_code,
	menu_name,
	menu_price,
	category_code,
	orderable_status
  FROM tbl_menu 
  WHERE category_code =4;
 
 
 
SELECT 
	* 
  FROM hansik ;


INSERT INTO tbl_menu VALUES(NULL, '식혜맛국밥', 5500, 4, 'y');


-- view를 통한 dml 
-- 1) view를 통한 insert(view는 auto_increment가 없으므로 pk 컬럼의 값을 지정해주어야 한다.)
INSERT INTO hansik VALUES(99, '수정과맛국밥', 5500, 4, 'y');
INSERT INTO hansik VALUES(100, '수정과맛국밥', 5500, 5, 'y');
SELECT * FROM tbl_menu ;
SELECT * FROM hansik;


-- test
CREATE VIEW hansik2 AS 
SELECT 
	menu.menu_name,
	menu.menu_price,
	category.category_name
  FROM tbl_menu menu 
  JOIN tbl_category category ON menu.category_code = category.category_code ;

select * FROM hansik2;
-- join을 하는 경우 값을 입력하는 것이 불가능함.
-- 필드 목록이 없으면 조인 뷰 'gangnam.hansik2'에 삽입할 수 없습니다
INSERT INTO hansik2 values 
('열무 kimchi', 10000, '한식');

-- 2) view를 통한 update
UPDATE hansik 
   SET menu_name = '수정된 메뉴',
       menu_price = 5700 
 WHERE menu_code = 99;

SELECT * FROM hansik;

-- join으로 설정된 테이블의 경우 view의 값을 변경하는 것은 불가능
-- UPDATE hansik2
--    SET category_name = '열무스',
--        menu_price = 5700 
--  WHERE menu_name = '열무김치라떼';
-- 
-- SELECT *FROM hansik2;

-- view를 이용한 데이터 삭제
DELETE FROM hansik WHERE menu_code = 99;
-- join으로 생성된 view의 데이터를 삭제하는 것도 권장하지 않음
DELETE FROM hansik2 WHERE menu_name='열무스';


-- view를 삭제
DROP VIEW hansik2;
-- view가 삭제되어 조회할 수 없음
SELECT * FROM hansik2;


-- view에 쓰인 subquery 안에 연산 결과 컬럼도 사용 가능하다.
CREATE VIEW hansik2 AS
SELECT 
	menu_name AS '메뉴명',
	truncate(menu_price/1000,1)AS '가격(천원)',
	category_name AS '카테고리명'
  FROM tbl_menu a
  JOIN tbl_category b ON a.category_code = b.category_code
 WHERE b.category_name ='한식';
-- view 생성시 지시한 컬럼의 별칭이 view의 컬럼 명이됨
SELECT 
   * 
  FROM hansik2
 WHERE 메뉴명 LIKE '%수정%';

-- or replace 옵션
-- 테이블을 drop 하지 않고 기존의 view를 새로운 view로 쉽게 대체할 수 있다.
CREATE OR REPLACE VIEW hansik AS
SELECT 
	menu_code AS '메뉴코드', 
	menu_name '메뉴명', 
	category_name '카테고리명'
 FROM tbl_menu 
 JOIN tbl_category ON tbl_menu.category_code = tbl_category.category_code ;
 
SELECT * FROM hansik;