select 
	menu_code,
	menu_name,
	menu_price
  from tbl_menu
  
-- order by menu_price asc; -- asc : 오름차순정렬, desc : 내림차순 정렬
order by menu_price desc;

-- order by 절을 사용하여 결과 집합의 여러 열로 정렬
select 
	menu_code,
	menu_name,
	menu_price
  from tbl_menu
 order by 
 	menu_price desc,
 	menu_name asc;
 
-- 메뉴의 코드, 이름, 코드 곱하기 가격을 조회한다.
-- 정렬 기준은 코드의 오름차순으로 정렬한다.
 
 select 
 	menu_code,
	menu_name,
	menu_code * menu_price
  from tbl_menu
order by
	menu_code asc;
	
-- 
select 
	field('C', 'A', 'B', 'C');
	
select 
	field(orderable_status, 'N', 'Y')
  from tbl_menu;
 
--   SELECT * FROM tbl_menu;
 
select 
 	category_code ,
 	category_name , 
 	ref_category_code
  from tbl_category
order by ref_category_code is null desc;
