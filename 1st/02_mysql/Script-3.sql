select 
	menu_name ,
	menu_price ,
	orderable_status
  from tbl_menu
 where orderable_status = 'Y'; -- where 테이블 추출 조건 확인
 
select 
	menu_name ,
	menu_code ,
	menu_price
  from tbl_menu
 where menu_price >= 13000
 order by menu_price desc;
  
 select 
 	*
   from tbl_menu
  where orderable_status != 'Y';
  
 select 
 	*
   from tbl_menu
  where orderable_status = 'Y' or category_code = 10;
  
 -- 같은 문자열이 있는지 조회하기
 
select 
	menu_name ,
	menu_price
  from tbl_menu
 where menu_name like "%갈치%";
 
select 
	menu_name ,
	menu_price
  from tbl_menu
 where menu_name not like "%마늘%";
 
select 
	category_code ,
	category_name ,
	ref_category_code
  from tbl_category
 where ref_category_code is not null;
 
