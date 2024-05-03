-- group by
-- 같은 값을 묶을때 사용하는 키워드이다.

 select 
	category_code ,
	count(*)
   from tbl_menu
   group by category_code ;

 select
	category_code ,
	sum(menu_price)
   from tbl_menu
   group by category_code ;

select 
	category_code as b ,
	avg(menu_price)
	from tbl_menu
	group by category_code ;

-- 여러 값을 묶는 경우
select 
	category_code ,
	menu_price ,
	count(*)
  from tbl_menu tm 
  group by category_code , menu_price ;

-- 그룹에 조건을 부여하기
-- having
 select 
 	category_code
   from tbl_menu tm 
  where category_code > 6  -- sql 쿼리의 전체에 대한 조건
  group by category_code 
  having category_code between 5 and 8; -- having 컬럼 between 5부터 8까지 조회 / having 그룹 집합 조건
 